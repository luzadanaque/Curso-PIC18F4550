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
    bcf  LATD,0
    bcf  LATD,1
    call Retardo_200ms  ;Retardo 100ms
    bsf  LATD,0
    bsf  LATD,1
    call Retardo_200ms  ;Retardo 100ms
    goto LOOP           ;Repite el ciclo
    
    #include "retardos.inc"
   end
   
