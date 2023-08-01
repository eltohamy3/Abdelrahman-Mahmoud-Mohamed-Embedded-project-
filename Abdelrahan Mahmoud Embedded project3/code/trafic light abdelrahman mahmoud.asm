
_getval:

;trafic light abdelrahman mahmoud.c,25 :: 		unsigned char getval(int i )
;trafic light abdelrahman mahmoud.c,27 :: 		return (i %10 ) + tens[i/10] ;
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_getval_i+0, 0
	MOVWF      R0+0
	MOVF       FARG_getval_i+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      FLOC__getval+0
	MOVF       R0+1, 0
	MOVWF      FLOC__getval+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_getval_i+0, 0
	MOVWF      R0+0
	MOVF       FARG_getval_i+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	ADDLW      _tens+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ADDWF      FLOC__getval+0, 0
	MOVWF      R0+0
;trafic light abdelrahman mahmoud.c,28 :: 		}
L_end_getval:
	RETURN
; end of _getval

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;trafic light abdelrahman mahmoud.c,30 :: 		void interrupt()
;trafic light abdelrahman mahmoud.c,32 :: 		if (intf_bit==1)
	BTFSS      INTF_bit+0, BitPos(INTF_bit+0)
	GOTO       L_interrupt0
;trafic light abdelrahman mahmoud.c,34 :: 		intf_bit =0 ;
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
;trafic light abdelrahman mahmoud.c,35 :: 		if (automatic ==1 )
	MOVF       _automatic+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt1
;trafic light abdelrahman mahmoud.c,37 :: 		automatic =0 ; // go to manual moood
	CLRF       _automatic+0
;trafic light abdelrahman mahmoud.c,38 :: 		}
	GOTO       L_interrupt2
L_interrupt1:
;trafic light abdelrahman mahmoud.c,39 :: 		else if (automatic ==0)
	MOVF       _automatic+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt3
;trafic light abdelrahman mahmoud.c,41 :: 		automatic =1 ; // go to automatic mood
	MOVLW      1
	MOVWF      _automatic+0
;trafic light abdelrahman mahmoud.c,42 :: 		}
L_interrupt3:
L_interrupt2:
;trafic light abdelrahman mahmoud.c,43 :: 		}
L_interrupt0:
;trafic light abdelrahman mahmoud.c,44 :: 		}
L_end_interrupt:
L__interrupt77:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;trafic light abdelrahman mahmoud.c,47 :: 		void main()
;trafic light abdelrahman mahmoud.c,51 :: 		adcon1=7 ; // make porta and porte digital
	MOVLW      7
	MOVWF      ADCON1+0
;trafic light abdelrahman mahmoud.c,54 :: 		trisb=0b00000011;  trisd=0; portd=0;
	MOVLW      3
	MOVWF      TRISB+0
	CLRF       TRISD+0
	CLRF       PORTD+0
;trafic light abdelrahman mahmoud.c,55 :: 		trisc=0 ; portc =0 ;
	CLRF       TRISC+0
	CLRF       PORTC+0
;trafic light abdelrahman mahmoud.c,56 :: 		trise=0 ; porte=0;
	CLRF       TRISE+0
	CLRF       PORTE+0
;trafic light abdelrahman mahmoud.c,57 :: 		yellow2=0 ; red2=0 ; green2=0 ;
	BCF        PORTB+0, 3
	BCF        PORTB+0, 2
	BCF        PORTB+0, 4
;trafic light abdelrahman mahmoud.c,58 :: 		red=0 ;yellow =0 ;green =0;
	BCF        PORTE+0, 0
	BCF        PORTE+0, 1
	BCF        PORTE+0, 2
;trafic light abdelrahman mahmoud.c,59 :: 		gie_bit=1 ; inte_bit=1;  intedg_bit=1 ;           // for interrupt
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
	BSF        INTE_bit+0, BitPos(INTE_bit+0)
	BSF        INTEDG_bit+0, BitPos(INTEDG_bit+0)
;trafic light abdelrahman mahmoud.c,61 :: 		ones2 =0 ;tens2 =0 ;
	BCF        PORTC+0, 2
	BCF        PORTC+0, 3
;trafic light abdelrahman mahmoud.c,62 :: 		ones1=0 ;tens1=0 ;
	BCF        PORTC+0, 0
	BCF        PORTC+0, 1
;trafic light abdelrahman mahmoud.c,64 :: 		automatic=1;
	MOVLW      1
	MOVWF      _automatic+0
;trafic light abdelrahman mahmoud.c,65 :: 		automatic_led =1  ; manual_led=0 ;
	BSF        PORTB+0, 5
	BCF        PORTB+0, 6
;trafic light abdelrahman mahmoud.c,66 :: 		while (1)
L_main4:
;trafic light abdelrahman mahmoud.c,70 :: 		while( automatic==1)
L_main6:
	MOVF       _automatic+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main7
;trafic light abdelrahman mahmoud.c,72 :: 		automatic_led =1  ; manual_led=0 ;
	BSF        PORTB+0, 5
	BCF        PORTB+0, 6
;trafic light abdelrahman mahmoud.c,74 :: 		ones1=1 ;tens1=1; //west digit
	BSF        PORTC+0, 0
	BSF        PORTC+0, 1
;trafic light abdelrahman mahmoud.c,75 :: 		ones2=1 ; tens2 =1 ; // south digit
	BSF        PORTC+0, 2
	BSF        PORTC+0, 3
;trafic light abdelrahman mahmoud.c,76 :: 		red =0 ;green =0; yellow =0 ;  red2 =0 ;green2 =0 ;yellow2=0 ; // intial all off
	BCF        PORTE+0, 0
	BCF        PORTE+0, 2
	BCF        PORTE+0, 1
	BCF        PORTB+0, 2
	BCF        PORTB+0, 4
	BCF        PORTB+0, 3
;trafic light abdelrahman mahmoud.c,78 :: 		red =1; green2 =0 ; yellow2 =1 ;// first south is green
	BSF        PORTE+0, 0
	BCF        PORTB+0, 4
	BSF        PORTB+0, 3
;trafic light abdelrahman mahmoud.c,79 :: 		for ( i =15; i>0 ;i--)
	MOVLW      15
	MOVWF      _i+0
	MOVLW      0
	MOVWF      _i+1
L_main8:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _i+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main79
	MOVF       _i+0, 0
	SUBLW      0
L__main79:
	BTFSC      STATUS+0, 0
	GOTO       L_main9
;trafic light abdelrahman mahmoud.c,81 :: 		if (i==12)
	MOVLW      0
	XORWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main80
	MOVLW      12
	XORWF      _i+0, 0
L__main80:
	BTFSS      STATUS+0, 2
	GOTO       L_main11
;trafic light abdelrahman mahmoud.c,83 :: 		yellow2=0;
	BCF        PORTB+0, 3
;trafic light abdelrahman mahmoud.c,84 :: 		green2=1 ;
	BSF        PORTB+0, 4
;trafic light abdelrahman mahmoud.c,85 :: 		}
L_main11:
;trafic light abdelrahman mahmoud.c,86 :: 		portd = getval(i) ;
	MOVF       _i+0, 0
	MOVWF      FARG_getval_i+0
	MOVF       _i+1, 0
	MOVWF      FARG_getval_i+1
	CALL       _getval+0
	MOVF       R0+0, 0
	MOVWF      PORTD+0
;trafic light abdelrahman mahmoud.c,88 :: 		if (!automatic )
	MOVF       _automatic+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main12
;trafic light abdelrahman mahmoud.c,89 :: 		break ;
	GOTO       L_main9
L_main12:
;trafic light abdelrahman mahmoud.c,90 :: 		if (i>3)
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _i+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main81
	MOVF       _i+0, 0
	SUBLW      3
L__main81:
	BTFSC      STATUS+0, 0
	GOTO       L_main13
;trafic light abdelrahman mahmoud.c,92 :: 		delay_ms(800) ; // dont make the delay in 0
	MOVLW      9
	MOVWF      R11+0
	MOVLW      30
	MOVWF      R12+0
	MOVLW      228
	MOVWF      R13+0
L_main14:
	DECFSZ     R13+0, 1
	GOTO       L_main14
	DECFSZ     R12+0, 1
	GOTO       L_main14
	DECFSZ     R11+0, 1
	GOTO       L_main14
	NOP
;trafic light abdelrahman mahmoud.c,93 :: 		}
	GOTO       L_main15
L_main13:
;trafic light abdelrahman mahmoud.c,96 :: 		yellow2=1;delay_ms(100) ;yellow2=0;delay_ms(100) ;yellow2=1;delay_ms(100) ;
	BSF        PORTB+0, 3
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main16:
	DECFSZ     R13+0, 1
	GOTO       L_main16
	DECFSZ     R12+0, 1
	GOTO       L_main16
	DECFSZ     R11+0, 1
	GOTO       L_main16
	NOP
	BCF        PORTB+0, 3
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main17:
	DECFSZ     R13+0, 1
	GOTO       L_main17
	DECFSZ     R12+0, 1
	GOTO       L_main17
	DECFSZ     R11+0, 1
	GOTO       L_main17
	NOP
	BSF        PORTB+0, 3
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main18:
	DECFSZ     R13+0, 1
	GOTO       L_main18
	DECFSZ     R12+0, 1
	GOTO       L_main18
	DECFSZ     R11+0, 1
	GOTO       L_main18
	NOP
;trafic light abdelrahman mahmoud.c,97 :: 		yellow2=0;delay_ms(100) ;yellow2=1;delay_ms(100) ;yellow2=0;delay_ms(100) ;
	BCF        PORTB+0, 3
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main19:
	DECFSZ     R13+0, 1
	GOTO       L_main19
	DECFSZ     R12+0, 1
	GOTO       L_main19
	DECFSZ     R11+0, 1
	GOTO       L_main19
	NOP
	BSF        PORTB+0, 3
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main20:
	DECFSZ     R13+0, 1
	GOTO       L_main20
	DECFSZ     R12+0, 1
	GOTO       L_main20
	DECFSZ     R11+0, 1
	GOTO       L_main20
	NOP
	BCF        PORTB+0, 3
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main21:
	DECFSZ     R13+0, 1
	GOTO       L_main21
	DECFSZ     R12+0, 1
	GOTO       L_main21
	DECFSZ     R11+0, 1
	GOTO       L_main21
	NOP
;trafic light abdelrahman mahmoud.c,98 :: 		yellow2=1;delay_ms(100) ;yellow2=0;delay_ms(100) ;
	BSF        PORTB+0, 3
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main22:
	DECFSZ     R13+0, 1
	GOTO       L_main22
	DECFSZ     R12+0, 1
	GOTO       L_main22
	DECFSZ     R11+0, 1
	GOTO       L_main22
	NOP
	BCF        PORTB+0, 3
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main23:
	DECFSZ     R13+0, 1
	GOTO       L_main23
	DECFSZ     R12+0, 1
	GOTO       L_main23
	DECFSZ     R11+0, 1
	GOTO       L_main23
	NOP
;trafic light abdelrahman mahmoud.c,99 :: 		}
L_main15:
;trafic light abdelrahman mahmoud.c,100 :: 		if (!automatic )
	MOVF       _automatic+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main24
;trafic light abdelrahman mahmoud.c,101 :: 		break ;
	GOTO       L_main9
L_main24:
;trafic light abdelrahman mahmoud.c,79 :: 		for ( i =15; i>0 ;i--)
	MOVLW      1
	SUBWF      _i+0, 1
	BTFSS      STATUS+0, 0
	DECF       _i+1, 1
;trafic light abdelrahman mahmoud.c,102 :: 		}
	GOTO       L_main8
L_main9:
;trafic light abdelrahman mahmoud.c,103 :: 		if (!automatic )
	MOVF       _automatic+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main25
;trafic light abdelrahman mahmoud.c,104 :: 		break ;
	GOTO       L_main7
L_main25:
;trafic light abdelrahman mahmoud.c,105 :: 		red=0; yellow2 =0 ;
	BCF        PORTE+0, 0
	BCF        PORTB+0, 3
;trafic light abdelrahman mahmoud.c,106 :: 		green2=0 ;
	BCF        PORTB+0, 4
;trafic light abdelrahman mahmoud.c,108 :: 		red2=1 ;
	BSF        PORTB+0, 2
;trafic light abdelrahman mahmoud.c,109 :: 		green =0;
	BCF        PORTE+0, 2
;trafic light abdelrahman mahmoud.c,110 :: 		yellow =1 ;
	BSF        PORTE+0, 1
;trafic light abdelrahman mahmoud.c,111 :: 		for ( i =23 ;i>0 ;i--)
	MOVLW      23
	MOVWF      _i+0
	MOVLW      0
	MOVWF      _i+1
L_main26:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _i+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main82
	MOVF       _i+0, 0
	SUBLW      0
L__main82:
	BTFSC      STATUS+0, 0
	GOTO       L_main27
;trafic light abdelrahman mahmoud.c,113 :: 		if (i==20)
	MOVLW      0
	XORWF      _i+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main83
	MOVLW      20
	XORWF      _i+0, 0
L__main83:
	BTFSS      STATUS+0, 2
	GOTO       L_main29
;trafic light abdelrahman mahmoud.c,115 :: 		yellow =0 ;
	BCF        PORTE+0, 1
;trafic light abdelrahman mahmoud.c,116 :: 		green=1 ;
	BSF        PORTE+0, 2
;trafic light abdelrahman mahmoud.c,117 :: 		}
L_main29:
;trafic light abdelrahman mahmoud.c,118 :: 		portd = getval(i) ;
	MOVF       _i+0, 0
	MOVWF      FARG_getval_i+0
	MOVF       _i+1, 0
	MOVWF      FARG_getval_i+1
	CALL       _getval+0
	MOVF       R0+0, 0
	MOVWF      PORTD+0
;trafic light abdelrahman mahmoud.c,119 :: 		if (!automatic )
	MOVF       _automatic+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main30
;trafic light abdelrahman mahmoud.c,120 :: 		break ;
	GOTO       L_main27
L_main30:
;trafic light abdelrahman mahmoud.c,121 :: 		if (i>3)
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _i+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main84
	MOVF       _i+0, 0
	SUBLW      3
L__main84:
	BTFSC      STATUS+0, 0
	GOTO       L_main31
;trafic light abdelrahman mahmoud.c,123 :: 		delay_ms(800) ; // dont make the delay in 0
	MOVLW      9
	MOVWF      R11+0
	MOVLW      30
	MOVWF      R12+0
	MOVLW      228
	MOVWF      R13+0
L_main32:
	DECFSZ     R13+0, 1
	GOTO       L_main32
	DECFSZ     R12+0, 1
	GOTO       L_main32
	DECFSZ     R11+0, 1
	GOTO       L_main32
	NOP
;trafic light abdelrahman mahmoud.c,124 :: 		}
	GOTO       L_main33
L_main31:
;trafic light abdelrahman mahmoud.c,127 :: 		yellow=1;delay_ms(100) ;yellow=0;delay_ms(100) ;yellow=1;delay_ms(100) ;
	BSF        PORTE+0, 1
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main34:
	DECFSZ     R13+0, 1
	GOTO       L_main34
	DECFSZ     R12+0, 1
	GOTO       L_main34
	DECFSZ     R11+0, 1
	GOTO       L_main34
	NOP
	BCF        PORTE+0, 1
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main35:
	DECFSZ     R13+0, 1
	GOTO       L_main35
	DECFSZ     R12+0, 1
	GOTO       L_main35
	DECFSZ     R11+0, 1
	GOTO       L_main35
	NOP
	BSF        PORTE+0, 1
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main36:
	DECFSZ     R13+0, 1
	GOTO       L_main36
	DECFSZ     R12+0, 1
	GOTO       L_main36
	DECFSZ     R11+0, 1
	GOTO       L_main36
	NOP
;trafic light abdelrahman mahmoud.c,128 :: 		yellow=0;delay_ms(100) ;yellow=1;delay_ms(100) ;yellow=0;delay_ms(100) ;
	BCF        PORTE+0, 1
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main37:
	DECFSZ     R13+0, 1
	GOTO       L_main37
	DECFSZ     R12+0, 1
	GOTO       L_main37
	DECFSZ     R11+0, 1
	GOTO       L_main37
	NOP
	BSF        PORTE+0, 1
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main38:
	DECFSZ     R13+0, 1
	GOTO       L_main38
	DECFSZ     R12+0, 1
	GOTO       L_main38
	DECFSZ     R11+0, 1
	GOTO       L_main38
	NOP
	BCF        PORTE+0, 1
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main39:
	DECFSZ     R13+0, 1
	GOTO       L_main39
	DECFSZ     R12+0, 1
	GOTO       L_main39
	DECFSZ     R11+0, 1
	GOTO       L_main39
	NOP
;trafic light abdelrahman mahmoud.c,129 :: 		yellow=1;delay_ms(100) ;yellow=0;delay_ms(100) ;
	BSF        PORTE+0, 1
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main40:
	DECFSZ     R13+0, 1
	GOTO       L_main40
	DECFSZ     R12+0, 1
	GOTO       L_main40
	DECFSZ     R11+0, 1
	GOTO       L_main40
	NOP
	BCF        PORTE+0, 1
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main41:
	DECFSZ     R13+0, 1
	GOTO       L_main41
	DECFSZ     R12+0, 1
	GOTO       L_main41
	DECFSZ     R11+0, 1
	GOTO       L_main41
	NOP
;trafic light abdelrahman mahmoud.c,130 :: 		}
L_main33:
;trafic light abdelrahman mahmoud.c,131 :: 		if (!automatic )
	MOVF       _automatic+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main42
;trafic light abdelrahman mahmoud.c,132 :: 		break ;
	GOTO       L_main27
L_main42:
;trafic light abdelrahman mahmoud.c,111 :: 		for ( i =23 ;i>0 ;i--)
	MOVLW      1
	SUBWF      _i+0, 1
	BTFSS      STATUS+0, 0
	DECF       _i+1, 1
;trafic light abdelrahman mahmoud.c,133 :: 		}
	GOTO       L_main26
L_main27:
;trafic light abdelrahman mahmoud.c,134 :: 		red2=0;  green =0 ;
	BCF        PORTB+0, 2
	BCF        PORTE+0, 2
;trafic light abdelrahman mahmoud.c,135 :: 		if (!automatic )
	MOVF       _automatic+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main43
;trafic light abdelrahman mahmoud.c,136 :: 		break ;
	GOTO       L_main7
L_main43:
;trafic light abdelrahman mahmoud.c,139 :: 		}
	GOTO       L_main6
L_main7:
;trafic light abdelrahman mahmoud.c,141 :: 		while( automatic==0)
L_main44:
	MOVF       _automatic+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main45
;trafic light abdelrahman mahmoud.c,143 :: 		automatic_led =0 ; manual_led=1 ;
	BCF        PORTB+0, 5
	BSF        PORTB+0, 6
;trafic light abdelrahman mahmoud.c,144 :: 		if (portb.b1==1)    // west on
	BTFSS      PORTB+0, 1
	GOTO       L_main46
;trafic light abdelrahman mahmoud.c,146 :: 		red =0  ;green =0 ;red2=0 ;green2=0  ;yellow =0;  yellow2=0;
	BCF        PORTE+0, 0
	BCF        PORTE+0, 2
	BCF        PORTB+0, 2
	BCF        PORTB+0, 4
	BCF        PORTE+0, 1
	BCF        PORTB+0, 3
;trafic light abdelrahman mahmoud.c,147 :: 		yellow =1   ;red2 =1 ;
	BSF        PORTE+0, 1
	BSF        PORTB+0, 2
;trafic light abdelrahman mahmoud.c,148 :: 		if (automatic)
	MOVF       _automatic+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main47
;trafic light abdelrahman mahmoud.c,149 :: 		break ;
	GOTO       L_main45
L_main47:
;trafic light abdelrahman mahmoud.c,150 :: 		ones2 =0 ;tens2 =0; ones1 =1 ;tens1 =1 ; // on all 7 segment
	BCF        PORTC+0, 2
	BCF        PORTC+0, 3
	BSF        PORTC+0, 0
	BSF        PORTC+0, 1
;trafic light abdelrahman mahmoud.c,151 :: 		for ( i =3 ;i>0 ;i--)
	MOVLW      3
	MOVWF      _i+0
	MOVLW      0
	MOVWF      _i+1
L_main48:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _i+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main85
	MOVF       _i+0, 0
	SUBLW      0
L__main85:
	BTFSC      STATUS+0, 0
	GOTO       L_main49
;trafic light abdelrahman mahmoud.c,153 :: 		portd= getval(i);
	MOVF       _i+0, 0
	MOVWF      FARG_getval_i+0
	MOVF       _i+1, 0
	MOVWF      FARG_getval_i+1
	CALL       _getval+0
	MOVF       R0+0, 0
	MOVWF      PORTD+0
;trafic light abdelrahman mahmoud.c,154 :: 		if (automatic)
	MOVF       _automatic+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main51
;trafic light abdelrahman mahmoud.c,155 :: 		break ;
	GOTO       L_main49
L_main51:
;trafic light abdelrahman mahmoud.c,156 :: 		delay_ms(800) ;
	MOVLW      9
	MOVWF      R11+0
	MOVLW      30
	MOVWF      R12+0
	MOVLW      228
	MOVWF      R13+0
L_main52:
	DECFSZ     R13+0, 1
	GOTO       L_main52
	DECFSZ     R12+0, 1
	GOTO       L_main52
	DECFSZ     R11+0, 1
	GOTO       L_main52
	NOP
;trafic light abdelrahman mahmoud.c,151 :: 		for ( i =3 ;i>0 ;i--)
	MOVLW      1
	SUBWF      _i+0, 1
	BTFSS      STATUS+0, 0
	DECF       _i+1, 1
;trafic light abdelrahman mahmoud.c,157 :: 		}
	GOTO       L_main48
L_main49:
;trafic light abdelrahman mahmoud.c,158 :: 		if (automatic)
	MOVF       _automatic+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main53
;trafic light abdelrahman mahmoud.c,159 :: 		break ;
	GOTO       L_main45
L_main53:
;trafic light abdelrahman mahmoud.c,161 :: 		yellow =0 ;
	BCF        PORTE+0, 1
;trafic light abdelrahman mahmoud.c,162 :: 		green =1;
	BSF        PORTE+0, 2
;trafic light abdelrahman mahmoud.c,163 :: 		ones1=0 ;tens1=0 ; // off all 7 segment
	BCF        PORTC+0, 0
	BCF        PORTC+0, 1
;trafic light abdelrahman mahmoud.c,164 :: 		while(!automatic &&  portb.b1==1 )   ;
L_main54:
	MOVF       _automatic+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main55
	BTFSS      PORTB+0, 1
	GOTO       L_main55
L__main74:
	GOTO       L_main54
L_main55:
;trafic light abdelrahman mahmoud.c,166 :: 		if (automatic)
	MOVF       _automatic+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main58
;trafic light abdelrahman mahmoud.c,167 :: 		break ;
	GOTO       L_main45
L_main58:
;trafic light abdelrahman mahmoud.c,168 :: 		}
L_main46:
;trafic light abdelrahman mahmoud.c,169 :: 		if (automatic)
	MOVF       _automatic+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main59
;trafic light abdelrahman mahmoud.c,170 :: 		break ;
	GOTO       L_main45
L_main59:
;trafic light abdelrahman mahmoud.c,171 :: 		if (portb.b1==0)    // south on
	BTFSC      PORTB+0, 1
	GOTO       L_main60
;trafic light abdelrahman mahmoud.c,173 :: 		red =0  ;green2 =0 ;red2=0 ;green=0  ;yellow2 =0;
	BCF        PORTE+0, 0
	BCF        PORTB+0, 4
	BCF        PORTB+0, 2
	BCF        PORTE+0, 2
	BCF        PORTB+0, 3
;trafic light abdelrahman mahmoud.c,175 :: 		red=1;   yellow2 =1     ;
	BSF        PORTE+0, 0
	BSF        PORTB+0, 3
;trafic light abdelrahman mahmoud.c,176 :: 		ones2 =1 ;tens2 =1; ones1 =0 ;tens1 =0 ;  // on all 7 segment
	BSF        PORTC+0, 2
	BSF        PORTC+0, 3
	BCF        PORTC+0, 0
	BCF        PORTC+0, 1
;trafic light abdelrahman mahmoud.c,177 :: 		for ( i =3 ;i>0 ;i--)
	MOVLW      3
	MOVWF      _i+0
	MOVLW      0
	MOVWF      _i+1
L_main61:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _i+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main86
	MOVF       _i+0, 0
	SUBLW      0
L__main86:
	BTFSC      STATUS+0, 0
	GOTO       L_main62
;trafic light abdelrahman mahmoud.c,179 :: 		portd = getval(i) ;
	MOVF       _i+0, 0
	MOVWF      FARG_getval_i+0
	MOVF       _i+1, 0
	MOVWF      FARG_getval_i+1
	CALL       _getval+0
	MOVF       R0+0, 0
	MOVWF      PORTD+0
;trafic light abdelrahman mahmoud.c,180 :: 		if (automatic)
	MOVF       _automatic+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main64
;trafic light abdelrahman mahmoud.c,181 :: 		break ;
	GOTO       L_main62
L_main64:
;trafic light abdelrahman mahmoud.c,182 :: 		delay_ms(800) ;
	MOVLW      9
	MOVWF      R11+0
	MOVLW      30
	MOVWF      R12+0
	MOVLW      228
	MOVWF      R13+0
L_main65:
	DECFSZ     R13+0, 1
	GOTO       L_main65
	DECFSZ     R12+0, 1
	GOTO       L_main65
	DECFSZ     R11+0, 1
	GOTO       L_main65
	NOP
;trafic light abdelrahman mahmoud.c,177 :: 		for ( i =3 ;i>0 ;i--)
	MOVLW      1
	SUBWF      _i+0, 1
	BTFSS      STATUS+0, 0
	DECF       _i+1, 1
;trafic light abdelrahman mahmoud.c,183 :: 		}
	GOTO       L_main61
L_main62:
;trafic light abdelrahman mahmoud.c,184 :: 		if (automatic)
	MOVF       _automatic+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main66
;trafic light abdelrahman mahmoud.c,185 :: 		break ;
	GOTO       L_main45
L_main66:
;trafic light abdelrahman mahmoud.c,186 :: 		yellow2 =0 ;
	BCF        PORTB+0, 3
;trafic light abdelrahman mahmoud.c,187 :: 		green2=1 ;
	BSF        PORTB+0, 4
;trafic light abdelrahman mahmoud.c,188 :: 		ones2 =0 ;tens2 =0 ; // of all 7 segment
	BCF        PORTC+0, 2
	BCF        PORTC+0, 3
;trafic light abdelrahman mahmoud.c,189 :: 		while(!automatic &&  portb.b1==0 )    ;
L_main67:
	MOVF       _automatic+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main68
	BTFSC      PORTB+0, 1
	GOTO       L_main68
L__main73:
	GOTO       L_main67
L_main68:
;trafic light abdelrahman mahmoud.c,190 :: 		if (automatic)
	MOVF       _automatic+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main71
;trafic light abdelrahman mahmoud.c,191 :: 		break ;
	GOTO       L_main45
L_main71:
;trafic light abdelrahman mahmoud.c,192 :: 		}
L_main60:
;trafic light abdelrahman mahmoud.c,193 :: 		if (automatic)
	MOVF       _automatic+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main72
;trafic light abdelrahman mahmoud.c,194 :: 		break ;
	GOTO       L_main45
L_main72:
;trafic light abdelrahman mahmoud.c,195 :: 		}
	GOTO       L_main44
L_main45:
;trafic light abdelrahman mahmoud.c,197 :: 		}
	GOTO       L_main4
;trafic light abdelrahman mahmoud.c,199 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
