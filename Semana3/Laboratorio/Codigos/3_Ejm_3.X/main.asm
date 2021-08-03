#include "p18f4550.inc"
#include "config.inc"
;Variables en RAM
    cblock 
	contador
    endc
;Vectores del programa
    org 0x00000         ; Vector Reset
    goto SETUP          
    org 0x0020          ; Inicio del Programa.
;Programa Principal
SETUP:
    movlw 0x62           
    movwf OSCCON        ; Oscilador Interno de 8Mhz
    movlw 0x0F          
    movwf ADCON1        ; Todos los pines como digital
    bsf   TRISB,0       ; Pin RB0 como entrada
    clrf  TRISD         ; Puerto D como salida
    clrf  LATD          ; Inicialiar el puertdo D en 0.
    clrf  contador      ; Inicialiar el contador en 0.
    
LOOP:
    btfsc PORTB,0		; Leer Pulsador ¿RB0 == 0?
    goto  LOOP			; FALSE: Regresa al Bucle
    call  Retardo_20ms		; TRUE : Tiempo para los efectos de rebote.
    btfsc PORTB,0		; Leer nuevamente el pulsador, para verificar.
    goto  LOOP			; FALSE: Regresa al Bucle
    call  Incrementar_Cuenta    ; Llamar a la subrutina Incrementar_Cuenta.
Pulsador_Presionado:            
    btfss PORTB,0               ; Preguntar si el pulsador quedo presionado ¿RB0 == 1?
    goto Pulsador_Presionado    ; Salta y se mantiene en el bucle Pulsador_Presionado
    goto LOOP                   ; Salta al LOOP
    
;********************** Subrutinas **********************
Incrementar_Cuenta:
    incf   contador		; contador = contador + 1
    movlw  .10			; W = 10
    cpfslt contador,0		; ¿contador < W(10)?
Reiniciar_Contador:		; FALSE:
    clrf contador		; contador = 0
Actualizar_Puerto_D:		; TRUE:
    movf  contador,W		; W = contador
    movwf LATD			; LATD = W
    return
    
    #include "retardos.inc"
   end
   
