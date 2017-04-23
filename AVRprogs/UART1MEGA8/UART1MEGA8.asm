          .nolist               ;������ ��������� ��������� ��������� ���� � �������, �.�. ����� � ����� *.lss �� ����� ������������� ������������ ���
          .include "m8def.inc"	;����������� ������������ ������������� ����� ��� ATmega8 
          .list		         	;������ ��������� �������� ��������� ���� � �������, �.�. ����� � ����� *.lss ����� ������������� ������������ ���

          .equ fCK         =  8000000             ;������� � ������
		  .equ BAUD        =  9600                ;�������� ��� UART � �����
          .equ UBRR_value  =  (fCK/(BAUD*16))-1   ;����������� �������� ��� �������� UBRR

          .cseg		  ;������ ��������� ��������, ��� ������ ���� ��� ���������
          .org 0	  ;������ ��������� ��������, ��� ��� ��������� ����� ������������� � 0��� ������ � FLASH

  ;������ ���������� 
          rjmp  initial         ;���������� �� � , ��������� �� ���������� ���������� - initial
          rjmp  0 		;rjmp  service_INT0 ;������� ���������� 0      
          rjmp  0 		;rjmp  service_INT1 ;������� ���������� 1     
          rjmp  0 		;rjmp  service_OC2  ;���������� TCNT2 � OCR2  
          rjmp  0 		;rjmp  service_OVF2 ;������������ TCNT2       
          rjmp  0 		;rjmp  service_ICP1 ;������ � ICP1           
          rjmp  0 		;rjmp  service_OC1A ;���������� TCNT1 � OCR1A 
          rjmp  0 		;rjmp  service_OC1B ;���������� TCNT1 � OCR1B 
          rjmp  0 		;rjmp  service_OVF1 ;������������ TCNT1       
          rjmp  0 		;rjmp  service_OVF0 ;������������ TCNT0       
          rjmp  0 		;rjmp  service_SPI  ;���������� �� ������ SPI 
          rjmp  0 		;rjmp  service_URXC ;��������� ����� �� USART 
          rjmp  0 		;rjmp  service_UDRE ;����������� UDR � USART  
          rjmp  0 		;rjmp  service_UTXC ;�������� ����� �� USART  
          rjmp  0 		;rjmp  service_ADCC ;���������� �� ���        
          rjmp  0 		;rjmp  service_ERDY ;���������� ������ � EEPROM
          rjmp  0		;rjmp  service_ACI  ;���������� �� ����������� 
          rjmp  0 		;rjmp  service_TWI  ;���������� �� ������ TWI  
          rjmp  0 		;rjmp  service_SPMR ;���������� ���������� spm 

  ;��������� �����
initial:  ldi   R16,low(RAMEND)    ;��������� � R16 ������� ���� �� ��������� RAMEND, ������� ���������� � m8def.inc � ������ ������ SRAM
          out   SPL,R16            ;��������� �������� �� R16 � SPL
          ldi   R17,high(RAMEND)   ;��������� � R16 ������� ���� �� ��������� RAMEND, ������� ���������� � m8def.inc
          out   SPH,R17            ;��������� �������� �� R17 � SPH

  ;��� �������� ���������
main:     rcall init_USART
		  ldi   R16,0b01010011     
		  rcall USART_send		;���� 0x53, ��� ASCII ��� ����� 'S'
		  ldi   R16,0b00101101
		  rcall USART_send      ;���� 0x2D, ��� ASCII ��� ����� '-'
		  ldi   R16,0b01000101
		  rcall USART_send      ;���� 0x45, ��� ASCII ��� ����� 'E'
loop:	  rjmp  loop

 ;������������ ������������� USART ������
init_USART:
		  ldi  R16,high(UBRR_value)   ;������������� �������� 9600 ���
	  	  out   UBRRH,R16
  		  ldi   R16,low(UBRR_value)   
		  out   UBRRL,R16
  		  ldi   R16,(1<<TXEN)          ;��������� ������ �����������
		  out   UCSRB,R16
          ldi   R16,(1<< URSEL)|(1<< UCSZ0)|(1<< UCSZ1)
		  out   UCSRC,R16              ;������������� ����� 8 ��� ������, ��� �������� ��������, ����������� �����
		  ret

USART_send:
		  sbis  UCSRA,UDRE            ;���� ���� ��� UDRE �������� UCSRA �� ����� ����
	      rjmp  USART_send
		  out   UDR,R16				   ;�������� ���� �� UART, ������ ������ � ������� UDR
		  ret
