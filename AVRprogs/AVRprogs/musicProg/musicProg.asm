

.DEVICE ATmega128	
.include "m128def.inc"
.list

.def	temp = R16		; Вспомогательный регистр
.def	temp1 = R17		; Второй вспомогательный регистр
.def	count = R18		; Определение регистра-счетчика
.def	fnota = R19		; Частота текущей ноты
.def	dnota = R20		; Длительность текущей ноты
.def	loop = R21		; Ячейки для процедуры задержки

			
			.cseg
			.org 0

			jmp init

			.org 0x46	

init:

;-------------------------- Инициализация стека
	
		ldi		temp, RAMEND	; Выбор адреса вершины стека 
		out		SPL, temp		; Запись его в регистр стека

;-------------------------- Инициализация портов В/В
	
		ldi 	temp, 0x08		; Инициализация порта PB
		out		PORTB, temp
		out		DDRB, temp

		ldi 	temp, 0x7F		; Инициализация порта PD
		out		PORTD, temp
		ldi		temp, 0x00
		out		DDRD, temp

;--------------------------- Инициализация (выключение) компаратора

		ldi 	temp, 0x80
		out		ACSR, temp

;----------------------Инициализ. таймера

		ldi temp, 0x01	; выбор режима СТС
		out TCCR1B, temp
		ldi temp, 0x00
		out OCR1AH, r16
		ldi temp, low(kdel)
		out OCR1AL, 0x00
;		ldi temp, 0b00010000
;		out TIMSK, temp
m1:		ldi 	temp, 0x00		; Выключаем звук
		out		TCCR1A, temp




