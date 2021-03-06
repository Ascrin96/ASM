.include "m128def.inc"	; ������������� ����� ��������
.list					; ��������� ��������

.def	temp = r16		; ����������� �������� �������� ��������
.def 	rab = r17		; ����������� �������� ��������

.equ	kdel = 780

;------------------------- �������������� ����� ������

		.dseg			; �������� ������� ���
		.org	0x100
		; ������������� ������� ����� ��������

buf:	.byte	1		; ���� ���� ��� �������� ������� ��������




;------------------------- ������ ������������ ����

		.cseg 			; ����� �������� ������������ ����
		.org	0		; ���������� �������� ������ �� ����

start:	rjmp	init	; ������� �� ������ ���������
		reti			; ������� ���������� 0
		reti			; ������� ���������� 1
		reti			; ���������� �� ������� ������� T1
		reti
		reti			; ���������� �� ������������ T1
		reti			; ���������� �� ������������ T0
		reti			; ���������� UART ����� ��������
		reti			; ���������� UART ������� ������ ����
		reti			; ���������� UART �������� ���������
		reti			; ���������� �� �����������
		reti			; ���������� �� ��������� �� ����� ��������
		reti			; ������/������� 1. ���������� B 
		rjmp 	prtim1	; ���������� �� ���������� T1
		reti			; ������/������� 0. ���������� A 
		reti			; USI ��������� ����������
		reti			; USI ������������
		reti			; EEPROM ����������
		reti			; ������������ ��������� �������
		reti
		reti
		reti
		reti
		reti
		reti
		reti
		reti
		reti
		reti
		reti
		reti
		reti
		reti
		reti
		reti
		reti

		


; ------------------- ������ �������������
init:

;-------------------------- ������������� �����
	
	        ldi r16, 0x10
	        out sph, r16
	        ldi r16, 0xff
	        out spl, r16

;-------------------------- ������������� �������� ������������

		ldi		temp, 0x80  ; ���������� ����� $80 � ������� temp
		out		CLKPR, temp	; ���������� � ������� CLKPR
		ldi		temp, 0x0		; ���������� 0 � ������� temp
		out		CLKPR, temp	; ���������� ���� ���� � CLKPR

;-------------------------- ������������� ������ ��
	
		out		DDRD, temp	; ���������� ���� � DDRD (���� PD �� ����)

		ldi		temp, 0xFF	; ���������� ����� $FF � ������� temp
		out		DDRB, temp	; ���������� ��� ����� � DDRB (���� PB �� �����)
		out		PORTB, temp	; ���������� �� �� ����� � PORTB (�������� ���������)
		out		PORTD, temp	; ���������� ��� �� � PORTD (���.�����.���������)	


;-------------------------- ������������� ������� T1

		ldi		temp, 0xD			; ����� ������ �������
		out		TCCR1B, temp
		ldi		temp, high(kdel)	; ������� �������� ���� ����������
		out		OCR1AH, temp		; ������ � ������� ���������� �����.
		ldi		temp, low(kdel)		; ������� �������� ���� ����������
		out		OCR1AL, temp		; ������ � ������� ���������� �����.

;--------------------------- ������ � ������� �����
		
		ldi 	temp, 0b01000000	; ��������� ���������� �� �������
		out		TIMSK, temp

;--------------------------- ������������� �����������

		ldi 	temp, 0x80		; ���������� �����������
		out		ACSR, temp


;-------------------------- ������ �������� ���������
main:
		
		ldi 	rab, 0b00010000	; ������ ���������� ��������
		sts		buf, rab		; ������ ����������� �������� rab � ���

		sei						; ���������� ����������
m1:		rjmp	m1				; ������ ����������� ����





;========================================================
;       ������������ ��������� ����������
;========================================================


prtim1:	
		push	temp			; ��������� ������� temp
		push	rab				; ��������� ������� rab

		lds		rab, buf		; ������ ���������� rab �� ���
		
		in		temp, PIND		; ��������� ���������� ����� PD
		sbrs	temp, 0			; �������� �������� �������		
		rjmp	p2				; ���� �� ����, ��������� � ������ �����
		
;------------------------- ����� ������

p1:		lsr		rab				; ����� ����������� �������� ��������
		brcc 	p3				; ���� �� ����� �� ����� �������� ����������
		ldi		rab, 0b10000000	; ������ ���������� ��������
		rjmp	p3				; �� ������

;------------------------- ����� �����

p2:		lsl		rab				; ����� ����������� �������� ��������
		brcc	p3				; ���� �� ����� �� ����� �������� ����������
		ldi		rab, 0b00000001	; ������ ���������� ��������

;-------------------------- ����� ��������� ��������� ����������

p3:		ldi		temp, 0xFF		; ������� � temp ����� $FF
		eor		temp, rab		; �������� ����������� rab (����������� ���)
		out		PORTB, temp		; ����� �������� �������� � ���� PB

		sts		buf, rab		; ������ �������� rab � ���
			
		pop		rab				; ��������������� ������� rab
		pop		temp			; ��������������� ������� temp
		reti
