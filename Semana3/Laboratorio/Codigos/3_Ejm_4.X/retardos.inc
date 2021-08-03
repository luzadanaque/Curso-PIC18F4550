;***SUBRUTINAS CON RETARDO DE TIEMPO FIJO, OSCILADOR INTERNO/Externo DE 4MhZ 
; Con perscaler y F de 4MHz, ciclo de instruccion = F/4 = 1MHz de c.m.=1uS
    
;***VARIABLES EN MEMORIA
    CBLOCK 
    R_ContA		;Contadores de tiempo para los 
    R_ContB		;retardos
    R_ContC
    ENDC
; ******RETARDO DE 4 A 10us
Retardo_10micros	    ;Llamada con CALL toma 2c.m.
    NOP			    ;tarda 1c.m.
    NOP			    ;tarda 1c.m.
    NOP			    ;tarda 1c.m.
    NOP			    ;tarda 1c.m.
    NOP			    ;tarda 1c.m.
Retardo_5micros		    ;Llama con CALL toma 2c.m.
    NOP			    ;tarda 1c.m.
Retardo_4micros		    ;Llama con CALL toma 2c.m.
    RETURN

;******RETARDO DE 20 A 500us
Retardo_500micros	    ;Llama con CALL toma 2c.m.
    NOP			    ;tarda 1c.m.
    MOVLW   .164	    ;tarda 1c.m.
    GOTO    RetardoMicros   ;Llamada con GOTO toma 2c.m.
Retardo_200micros   
    NOP			    ;tarda 1c.m.
    MOVLW   .64		    ;tarda 1c.m.
    GOTO    RetardoMicros   ;Llamada con GOTO toma 2c.m.
Retardo_100micros   
    NOP			    ;tarda 1c.m.
    MOVLW   .31		    ;tarda 1c.m.
    GOTO    RetardoMicros   ;Llamada con GOTO toma 2c.m.
Retardo_50micros   
    NOP			    ;tarda 1c.m.
    MOVLW   .14		    ;tarda 1c.m.
    GOTO    RetardoMicros   ;Llamada con GOTO toma 2c.m.
Retardo_20micros	    ;Llama con CALL toma 2c.m.
    MOVLW   .5		    ;tarda 1c.m.
RetardoMicros		    
    MOVWF   R_ContA	    ;tarda 1c.m.
Retardo_Loop
    DECFSZ  R_ContA,1	    ;Tarda (K-1)c.m. cuando no salta y 2c.m al saltar
    GOTO    Retardo_Loop
    RETURN	

;******RETARDO DE 1 A 200ms
Retardo_200ms		    ;Llama con CALL toma 2c.m.
    MOVLW   .200	    ;tarda 1c.m.
    GOTO    Retardo_ms	    ;Llamada con GOTO toma 2c.m.
Retardo_100ms   	    
    MOVLW   .100	    ;tarda 1c.m.
    GOTO    Retardo_ms      ;Llamada con GOTO toma 2c.m.
Retardo_50ms   	    
    MOVLW   .50		    ;tarda 1c.m.
    GOTO    Retardo_ms      ;Llamada con GOTO toma 2c.m.
Retardo_20ms   	    
    MOVLW   .20		    ;tarda 1c.m.
    GOTO    Retardo_ms      ;Llamada con GOTO toma 2c.m.
Retardo_18ms
    MOVLW   .18
    GOTO    Retardo_ms
Retardo_15ms
    MOVLW   .15
    GOTO    Retardo_ms
Retardo_10ms   	    
    MOVLW   .10		    ;tarda 1c.m.
    GOTO    Retardo_ms      ;Llamada con GOTO toma 2c.m.
Retardo_5ms   	    
    MOVLW   .5		    ;tarda 1c.m.
    GOTO    Retardo_ms      ;Llamada con GOTO toma 2c.m.
Retardo_2ms   	    
    MOVLW   .2		    ;tarda 1c.m.
    GOTO    Retardo_ms      ;Llamada con GOTO toma 2c.m.
Retardo_1ms   	    
    MOVLW   .1		    ;tarda 1c.m.
;
Retardo_ms	    
    MOVWF   R_ContB	    ;tarda 1c.m.
Retardo_Loop1
    MOVLW   .249
    MOVWF   R_ContA
Retardo_Loop2
    NOP
    DECFSZ  R_ContA,1	    ;Tarda (K-1)c.m. cuando no salta y 2c.m al saltar
    GOTO    Retardo_Loop2
    DECFSZ  R_ContB,1
    GOTO    Retardo_Loop1
    RETURN  

;
;******RETARDO DE 0.5 A 20s
Retardo_20s		    ;Llama con CALL toma 2c.m.
    MOVLW   .200	    ;tarda 1c.m.
    GOTO    Retardo_Decima  ;Llamada con GOTO toma 2c.m.
Retardo_10s   	    
    MOVLW   .100	    ;tarda 1c.m.
    GOTO    Retardo_Decima  ;Llamada con GOTO toma 2c.m.
Retardo_5s   	    
    MOVLW   .50		    ;tarda 1c.m.
    GOTO    Retardo_Decima  ;Llamada con GOTO toma 2c.m.
Retardo_2s   	    
    MOVLW   .20		    ;tarda 1c.m.
    GOTO    Retardo_Decima  ;Llamada con GOTO toma 2c.m.
Retardo_3s
    MOVLW   .30
    GOTO    Retardo_Decima
Retardo_1s   	    
    MOVLW   .10		    ;tarda 1c.m.
    GOTO    Retardo_Decima  ;Llamada con GOTO toma 2c.m.
Retardo_500ms   	       
    MOVLW   .5		    ;tarda 1c.m.
;
Retardo_Decima	    
    MOVWF   R_ContC	    ;tarda 1c.m.
Retardo_DLoop
    MOVLW   .100
    MOVWF   R_ContB
Retardo_DLoop2
    MOVLW   .249
    MOVWF   R_ContA
Retardo_DLoop3
    NOP
    DECFSZ  R_ContA,1	    ;Tarda (K-1)c.m. cuando no salta y 2c.m al saltar
    GOTO    Retardo_DLoop3
    DECFSZ  R_ContB,1
    GOTO    Retardo_DLoop2
    DECFSZ  R_ContC,1
    GOTO    Retardo_DLoop
    RETURN  












