.include "m16def.inc"

.def temp = r16
.def sys = r17
.def count = r18

.equ Bitrate = 9600
.equ BAUD = 8000000 / (16*Bitrate) - 1

.cseg
.org 0

jmp Reset

	.org $016
	jmp USART_RXC		; ������ ���������� ��� �����
	.org $01A
	jmp USART_TXC		; ������ ���������� ��� ��������

Reset:
	
	ldi temp, HIGH(RAMEND)
	out sph, temp
	ldi temp, LOW(RAMEND)
	out spl, temp

	ldi temp, HIGH(BAUD)		; ���������� �������� ��������
	out UBRRH, temp
	ldi temp, LOW(BAUD)
	out UBRRL, temp

	ldi temp, 0b11011000		; 7- ��� �����, 6-��� ���������� ��������, 4- ���������� �����, 4- ���������� ��������

	out UCSRB, temp

	ldi temp, 0b10000110		; 7 - ������ 1, 1,2 - 8 ��� �������
	out UCSRC, temp
	sei
Main:
	rjmp Main 

USART_RXC:
	cli
	sbis UCSRA, RXC
	rjmp USART_RXC

	in sys, UDR
	inc sys
	out UDR, sys

	ldi count, 0

	VixUR:
		sei
		reti

USART_TXC:
	cli
	sbis UCSRA, UDRE
	rjmp USART_TXC

	inc count

	cpi count, 5
	breq Jet
	
	inc sys
	out UDR, sys

	VixUT:
		set
		reti

	Jet:
		ldi count, 0
		rjmp	VixUT
