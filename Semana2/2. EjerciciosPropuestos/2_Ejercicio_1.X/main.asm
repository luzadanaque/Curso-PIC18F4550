#include "p18f4550.inc"
#include "config.inc"

;Variables en RAM
cblock 0x10
    dato_A
    dato_B
    dato_C
endc  
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
    setf TRISB       ; Definir puerto B como entrada
    bcf  TRISD,0     ; Definir pin RD0 como salida.
    bcf  LATD,0      ; Inicializar el puerto D en 0.

LOOP:
    movf PORTB,W             ; W = PORTB
    movwf dato_A             ; A = W
    movwf dato_B             ; B = W
    movwf dato_C             ; C = W
    ; Formar el dato A
    movlw 0x01               ; W = 0x01
    andwf dato_A,f           ; A = A & W
    ; Formar el dato B
    movlw 0x02          ; W = 0x02
    andwf dato_B,f           ; B = B & W
    rrncf dato_B,f           ; B = B >> 1
    ; Formar el dato C
    movlw 0x04          ; W = 0x04
    andwf dato_C,f           ; C = C & W
    rrncf dato_C,f           ; C = C >> 1
    rrncf dato_C,f           ; C = C >> 1
    ; Realizar la operacion AB
    movf  dato_A,W           ; W = A
    andwf dato_B,F           ; B = AB
    ; Realizar la operacion AB + C
    movf  dato_C,W           ; W = C
    iorwf dato_B,F           ; AB(B) = AB + C
    ; Mostrar resultado en salida
    btfss dato_B,0           ; ¿Dato_B == 1?
    goto FORZAR_0            ; Falso => salida = 0
    goto FORZAR_1            ; Verdadero => salida = 1
    
FORZAR_0:
    bcf LATD,0
    goto LOOP
FORZAR_1:
    bsf LATD,0
    goto LOOP
;Subrutinas
end
    


    
    
    
    