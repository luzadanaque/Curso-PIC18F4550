#include "p18f4550.inc"
#include "config.inc"
;Variables en RAM
    cblock 0x10
	contador
	indice
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
    clrf  TRISD		    ; Puerto D como salida
    clrf contador	    ; Inicializar contador en 0.
LOOP:
    movf   contador,W	    ; W = contador
    call   deco7seg	    ; Busqueda en tabla y regresa el valor
    movwf  LATD		    ; Imprimir LATD = W(TABLAT)
    call   Retardo_100ms    ; Esperar 1 segundo
    incf   contador	    ; Incrementar contador en 1.
    movlw  .10		    ; W = 10
    cpfseq contador	    ; ¿Contador = W(10)?
    goto   LOOP		    ; FALSE => Repite LOOP  
    clrf   contador	    ; TRUE  => contador = 0
    goto   LOOP 
   
;*********** ESCRITURA DE MEMORIA FLASH ***********
;Espacio de memoria para el DISPLAY ANODO COMUN
Tabla_7SEG: db 0x40,0x79,0x24,0x30,0x19,0x12,0x02,0x78,0x00,0x10 
;******************* SUBRUTINAS *******************
;Subrutina (call deco7seg)
deco7seg:
    movwf indice            ; indice = W(contador)
    movlw UPPER Tabla_7SEG  ; Se lee la direccion alta de la tabla
    movwf TBLPTRU           ; Se guarda en TBLPTRU
    movlw HIGH  Tabla_7SEG  ; Se lee la direccion media de la tabla
    movwf TBLPTRH           ; Se guarda en TBLPTRH
    movlw LOW   Tabla_7SEG  ; Se lee la direccion baja de la tabla
    movwf TBLPTRL           ; Se guarda en TBLPTRL
    movf  indice,W          ; Cargar el W = indice
    addwf TBLPTRL,F         ; TBLPTRL = TBLPTRL + W(indice)
    TBLRD*                  ; Leemos la tabla segun el puntero de tabla
                            ; Y se almacena en TBLAT
    movf TABLAT,W           ; W = TABLAT
    return                  ; Retorna con un nuevo valor en W
                            ; W = TABLAT
    
#include "retardos.inc"
    end