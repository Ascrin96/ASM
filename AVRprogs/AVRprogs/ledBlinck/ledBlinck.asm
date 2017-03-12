.include "m16def.inc"

.def temp = r16
.def razr1 = r17
.def razr2 = r18
.def razr3 = r19

.dseg 

.cseg

.org 0
	rjmp Reset


Reset:

	ldi temp, 0x00
	out DDRA, temp	//Порт А на вход
	
	ldi temp, 0xff	//Порт В на выход
	out DDRB, temp
	
	ldi temp, 0xff
	out PORTA, temp //Включили подтягивающие сопротеления	

Main:
	sbic PINA, 0
	rjmp Main


	ldi temp, 0xff
	out PORTB, temp
	
	rcall Delay

	ldi temp, 0x00
	out PORTB, temp

	rjmp Delay
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

