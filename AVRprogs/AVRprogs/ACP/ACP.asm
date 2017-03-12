.include "m16def.inc"

.def temp = r16
.def razr1 = r17
.def razr2 = r18

.dseg

.cseg
.org 0
	jmp Reset
.org $01C 
	jmp ADC_Conf
	

Reset:
	
	ldi temp, HIGH(RAMEND)
	out sph, temp
	ldi temp, LOW(RAMEND)
	out spl, temp
	
	ldi temp, 0xff
	out DDRD, temp

	ldi temp, 0b01100000
	out ADMUX, temp

	ldi temp, 0b11011111
	out ADCSRA, temp
		
	sei
Main:
	rjmp Main


ADC_Conf:
	cli
	in razr1, ADCL
	in razr2, ADCH

	out PORTD, razr2

Vix:
	
	ldi temp, 0b01100000
	out ADMUX, temp

	ldi temp, 0b11011111
	out ADCSRA, temp

	sei
	reti
