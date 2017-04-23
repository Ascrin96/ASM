.include "m16def.inc"

; Internal Hardware Init  ======================================
		.equ 	XTAL = 8000000 	
		.equ 	baudrate = 9600  
		.equ 	bauddivider = XTAL/(16*baudrate)-1
 
 
uart_init:	
		LDI 	R16, low(bauddivider)
		OUT 	UBRRL,R16
		LDI 	R16, high(bauddivider)
		OUT 	UBRRH,R16
 
		LDI 	R16,0
		OUT 	UCSRA, R16
 
; ���������� ���������, �����-�������� ��������.
		LDI 	R16, (1<<RXEN)|(1<<TXEN)|(0<<RXCIE)|(0<<TXCIE)|(0<<UDRIE)
		OUT 	UCSRB, R16	
 
; ������ ����� - 8 ���, ����� � ������� UCSRC, �� ��� �������� ��� ��������
		LDI 	R16, (1<<URSEL)|(1<<UCSZ0)|(1<<UCSZ1)
		OUT 	UCSRC, R16


; ��������� �������� �����
uart_snt:	
		SBIS 	UCSRA,UDRE	; ������� ���� ��� ����� ����������
		RJMP	uart_snt 	; ���� ���������� - ����� UDRE
 
		OUT	UDR, R16	; ���� ����
		RET			; �������

;������� �����:
;		RCALL 	uart_init 	; �������� ���� ��������� �������������.
 
; Main =========================================================
Main:		RCALL	uart_rcv	; ���� �����
 
		INC	R16		; ������ � ��� ���-��
 
		RCALL	uart_snt	; ���������� �������.
 
		JMP	Main

;�������� �����
uart_rcv:	
		SBIS	UCSRA,RXC	; ���� ����� ������� �����
		RJMP	uart_rcv	; �������� � �����
 
		IN	R16,UDR		; ���� ������ - ��������.
		RET			; �������. ��������� � R16
