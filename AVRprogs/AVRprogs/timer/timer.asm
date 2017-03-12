.include "m16def.inc"

.def temp = r16
.def sys = r17

.dseg

.cseg
.org 0
rjmp Reset

.org $010 
	rjmp TIM1_OVF

Reset:

	ldi temp, HIGH(RAMEND)
	out sph, temp
	ldi temp, LOW(RAMEND)
	out spl, temp

	ldi temp, 0xff
	out DDRD, temp
	
	ldi temp, 0b00000101
	out TCCR1B, temp
	
	ldi temp, 0b00000100
	out TIMSK, temp
	out TIFR, temp

	ldi temp, 0xf0
	out TCNT1H, temp
	out TCNT1L, temp

	ldi sys, 0x01 
	out PORTD, sys

	sei
Proga:
	rjmp Proga	


TIM1_OVF:
	cli
	cpi sys, 0x01
	breq Led2

	cpi sys, 0x02
	breq Led3

	cpi sys, 0x04
	breq Led4

	cpi sys, 0x08
	breq Led1

Vix:
	ldi temp, 0xEE
	out TCNT1H, temp
	out TCNT1L, temp
	
	sei
	reti


Led1:
	ldi sys, 0x01
	out PORTD, sys
	rjmp Vix

Led2:
	ldi sys, 0x02
	out PORTD, sys
	rjmp Vix

Led3:
	ldi sys, 0x04
	out PORTD, sys
	rjmp Vix

Led4:
	ldi sys, 0x08
	out PORTD, sys
	rjmp Vix
