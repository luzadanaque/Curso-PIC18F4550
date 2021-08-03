#include "p18f4550.inc"
#include "config.inc"
    
;Variables en RAM

;Vectores del programa
    org 0x00000         ; Vector Reset
    goto SETUP          
    org 0x0020          ; Inicio del Programa.
;Programa Principal
SETUP:
    movlw 0x62
    movwf OSCCON
    movlw 0x0F
    movwf ADCON1
    clrf  TRISD

LOOP:
    clrf LATD           ;Encender Led
    call Retardo_100ms  ;Retardo 100ms
    setf LATD           ;Apagar Led
    call Retardo_100ms  ;Retardo 100ms
    goto LOOP           ;Repite el ciclo
    
;Subrutina de Retardo
    cblock
	contador_A
	contador_B
    endc
Retardo_100ms:
    movlw  .100
    movwf  contador_B
    goto   Retardo_ms
Retardo_50ms:
    movlw  .50
    movwf  contador_B
    goto   Retardo_ms
Retardo_1ms:                 ; 2C.I
    movlw  .1               ; 1C.I
    movwf  contador_B         ; 1C.I
Retardo_ms:                 
    movlw  .249              ; M*1CI
    movwf  contador_A        ; M*1CI
Retardo:                  
    nop                      ; k*M*(C.I)
    decfsz contador_A,F      ; (k-1)*M*C.I  + M*2C.I
    goto   Retardo           ; (k-1)*M*2CI
    decfsz contador_B,F      ; (M-1)C.I  + 2C.I
    goto   Retardo_ms        ; (M-1)2C.I
    return                   ; 2C.I
   end