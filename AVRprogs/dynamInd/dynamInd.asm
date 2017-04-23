.include "m16def.inc"
.def temp = r16
.def razr1 = r17
.def razr2 = r18
.def razr3 = r19

.def sys = r20
.def try = r21

.equ ch1 = 0b10011111
.equ ch2 = 0b00100101
.equ ch3 = 0b00001101
.equ ch4 = 0b10011001
.equ ch5 = 0b01001001
.equ ch6 = 0b01000001
.equ ch7 = 0b00011111
.equ ch8 = 0b00000001
.equ ch9 = 0b00001001
.equ ch0 = 0b00000011

.dseg

Visible:
	.byte 6

.cseg
	.org 0
	jmp Reset
	.org $012 
	jmp TIM0_OVF


Reset:

	ldi temp, ch1
	sts Visible, temp
	ldi temp, ch2
	sts Visible+1, temp
	ldi temp, ch3
	sts Visible+2, temp
	ldi temp, ch4
	sts Visible+3, temp
	ldi temp, ch5
	sts Visible+4, temp
	ldi temp, ch6
	sts Visible+5, temp

	ldi temp, HIGH(RAMEND)
	out sph, temp
	ldi temp, LOW(RAMEND)
	out spl, temp

	ldi temp, 0xff
	out DDRD, temp
	out DDRB, temp
	
	ldi temp, 0b00000010 // Предделитель на 2
	out TCCR0, temp
	
	ldi temp, 0b00000001
	out TIFR, temp
	out TIMSK, temp

	ldi temp, 0xfe
	out TCNT0, temp

	ldi sys, 0b10000000
		
	sei
Main:
	ldi try, ch1
	sts Visible, try
	rcall Delay

	ldi try, ch2
	sts Visible, try
	rcall Delay

	ldi try, ch3
	sts Visible, try
	rcall Delay

	ldi try, ch4
	sts Visible, try
	rcall Delay

	ldi try, ch5
	sts Visible, try
	rcall Delay

	rjmp Main

Delay: 
	ldi razr1, 255
	ldi razr2, 255
	ldi razr3, 10

	PDelay:
		dec razr1
		brne PDelay
		dec razr2
		brne PDelay
		dec razr3
		brne PDelay
	ret


TIM0_OVF:
	cli

	lsr sys
	cpi sys, 0b00000010
	breq Metka
	
	out PORTD, sys
	
	ld temp, X+
	ld temp, X
	out PORTB, temp

	Vix:

		ldi temp, 0x00
		out TCNT0, temp
	
		sei
		reti

Metka:
	ldi sys, 0b10000000
	out PORTD, sys

	ldi XH, HIGH(Visible)
	ldi XL, LOW(Visible)
	
	ld temp, X
	out PORTB, temp

	rjmp Vix
