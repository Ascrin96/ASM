

.DEVICE ATmega128	
.include "m128def.inc"
.list

.def	temp = R16		; ��������������� �������
.def	temp1 = R17		; ������ ��������������� �������
.def	count = R18		; ����������� ��������-��������
.def	fnota = R19		; ������� ������� ����
.def	dnota = R20		; ������������ ������� ����
.def	loop = R21		; ������ ��� ��������� ��������

			
			.cseg
			.org 0

			jmp init

			.org 0x46	

init:

;-------------------------- ������������� �����
	
		ldi		temp, RAMEND	; ����� ������ ������� ����� 
		out		SPL, temp		; ������ ��� � ������� �����

;-------------------------- ������������� ������ �/�
	
		ldi 	temp, 0x08		; ������������� ����� PB
		out		PORTB, temp
		out		DDRB, temp

		ldi 	temp, 0x7F		; ������������� ����� PD
		out		PORTD, temp
		ldi		temp, 0x00
		out		DDRD, temp

;--------------------------- ������������� (����������) �����������

		ldi 	temp, 0x80
		out		ACSR, temp

;----------------------���������. �������

		ldi temp, 0x01	; ����� ������ ���
		out TCCR1B, temp
		ldi temp, 0x00
		out OCR1AH, r16
		ldi temp, low(kdel)
		out OCR1AL, 0x00
;		ldi temp, 0b00010000
;		out TIMSK, temp
m1:		ldi 	temp, 0x00		; ��������� ����
		out		TCCR1A, temp




