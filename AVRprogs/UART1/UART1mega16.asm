          .nolist               ;данная директива отключает генерацию кода в листинг, т.е. далее в файле *.lss не будет фиксироваться ассемблерный код
          .include "m16def.inc"	;подключение стандартного заголовочного файла для ATmega8 
          .list		         	;данная директива включает генерацию кода в листинг, т.е. далее в файле *.lss будет фиксироваться ассемблерный код

          .equ fCK         =  8000000             ;частота в герцах
		  .equ BAUD        =  9600                ;скорость для UART в бодах
          .equ UBRR_value  =  (fCK/(BAUD*16))-1   ;расчитываем значение для регистра UBRR

          .cseg		  ;данная директива означает, что дальше идет код программы
          .org 0	  ;данная директива означает, что код программы будет располагаться с 0ого адреса в FLASH

  ;ВЕКТОР ПРЕРЫВАНИЙ 
          rjmp  initial         ;прерывание от … , ссылаемся на обработчик прерывания - initial
          rjmp  0 		;rjmp  service_INT0 ;внешнее прерывание 0      
          rjmp  0 		;rjmp  service_INT1 ;внешнее прерывание 1     
          rjmp  0 		;rjmp  service_OC2  ;совпадение TCNT2 и OCR2  
          rjmp  0 		;rjmp  service_OVF2 ;переполнение TCNT2       
          rjmp  0 		;rjmp  service_ICP1 ;захват в ICP1           
          rjmp  0 		;rjmp  service_OC1A ;совпадение TCNT1 и OCR1A 
          rjmp  0 		;rjmp  service_OC1B ;совпадение TCNT1 и OCR1B 
          rjmp  0 		;rjmp  service_OVF1 ;переполнение TCNT1       
          rjmp  0 		;rjmp  service_OVF0 ;переполнение TCNT0       
          rjmp  0 		;rjmp  service_SPI  ;прерывание от модуля SPI 
          rjmp  0 		;rjmp  service_URXC ;получение байта по USART 
          rjmp  0 		;rjmp  service_UDRE ;опустошение UDR в USART  
          rjmp  0 		;rjmp  service_UTXC ;передача байта по USART  
          rjmp  0 		;rjmp  service_ADCC ;прерывание от АЦП        
          rjmp  0 		;rjmp  service_ERDY ;завершение записи в EEPROM
          rjmp  0		;rjmp  service_ACI  ;прерывание от компаратора 
          rjmp  0 		;rjmp  service_TWI  ;прерывание от модуля TWI  
          rjmp  0 		;rjmp  service_SPMR ;завершение выполнения spm 

  ;УСТАНОВКА СТЕКА
initial:  ldi   R16,low(RAMEND)    ;скопируем в R16 младщий байт из константы RAMEND, которая определена в m8def.inc и хранит размер SRAM
          out   SPL,R16            ;скопируем значение из R16 в SPL
          ldi   R17,high(RAMEND)   ;скопируем в R16 старший байт из константы RAMEND, которая определена в m8def.inc
          out   SPH,R17            ;скопируем значение из R17 в SPH

  ;КОД ОСНОВНОЙ ПРОГРАММЫ
main:     rcall init_USART
;		  ldi   R16,0b01010011     
;		  rcall USART_send		;шлем 0x53, это ASCII код знака 'S'
;		  ldi   R16,0b00101101
;		  rcall USART_send      ;шлем 0x2D, это ASCII код знака '-'
;		  ldi   R16,0b01000101
;		  rcall USART_send      ;шлем 0x45, это ASCII код знака 'E'

	RCALL	uart_rcv	; Ждем байта
	INC	R16		; Делаем с ним что-то
	RCALL	uart_snt	; Отправляем обратно.
	rjmp  main

 ;ПОДПРОГРАММА ИНИЦИАЛИЗАЦИИ USART МОДУЛЯ
init_USART:ldi  R16,high(UBRR_value)   ;устанавливаем скорость 9600 бод
	  	  out   UBRRH,R16
  		  ldi   R16,low(UBRR_value)   
		  out   UBRRL,R16
  		  ldi   R16,(1<<TXEN)          ;разрешаем работу передатчика
		  out   UCSRB,R16
          ldi   R16,(1<< URSEL)|(1<< UCSZ0)|(1<< UCSZ1)
		  out   UCSRC,R16              ;устанавливаем режим 8 бит данных, без проверки четности, асинхронный режим
		  ret

		    
; Процедура отправки байта
uart_snt:	SBIS 	UCSRA,UDRE	; Пропуск если нет флага готовности
		RJMP	uart_snt 	; ждем готовности - флага UDRE
 
		OUT	UDR, R16	; шлем байт
		
		SBIS 	UCSRA,UDRE	; Пропуск если нет флага готовности
		RJMP	uart_snt 	; ждем готовности - флага UDRE
		ldi   R16,0b01010011
		OUT	UDR, R16	; шлем байт
		
		RET			  
;Ожидание байта
uart_rcv:	SBIS	UCSRA,RXC	; Ждем флага прихода байта
		RJMP	uart_rcv	; вращаясь в цикле
 
		IN	R16,UDR		; байт пришел - забираем.
		RET
