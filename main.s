	
	AREA myData, DATA


COUNT EQU 10 ; test count upt10
SUM   EQU 0
	

RED EQU 0 ;  COLORES DE SEMAFORO
YELLOW EQU 1
GREEN EQU 2
	
	
TIME_Y EQU 5
TIME_BASE EQU 20
EXTRA_TIME EQU 5

	
	
	AREA MYCODE, CODE
		ENTRY 
		EXPORT __main
			
__main
	
	
	LDR r0, =GREEN ; Semaforo vehicular N-S
	LDR r1, =RED   ; Semaforo peatonal N-S
	LDR r2, =GREEN ; Semaforo vehicular S-N
	LDR r3, =RED   ; Semaforo peatonal S-N
	
	LDR r4, =RED ; Semaforo vehicular E-O
	LDR r5, =GREEN   ; Semaforo peatonal E-O
	LDR r6, =RED ; Semaforo vehicular O-E
	LDR r7, =GREEN   ; Semaforo peatonal O-E
	
	LDR r8, =TIME_BASE ; Delay base
	LDR r9, =0 ; Timer
	
	LDR r11, =0 ; sensor peatonal N-S
	LDR r12, = 0 ; sensor peatonal E-O
	
	
	B start
	

start
	MOV r8, #TIME_BASE 
	BL delay1 ; Delay 20s
	
	
	

sensor_peatonal_NS
	MOV r8, #EXTRA_TIME ; delay 5s
	
	
	CMP r11,#0 ; compare sensorP N-S con 0
	
	BEQ delay2 ; delay extra de 5s
	
	BL semaforoN_S_YELLOW ; cambio a amarillo
	
	
semaforoN_S_YELLOW

	MOV r0, #YELLOW; cambio a amarillo
	MOV r2, #YELLOW
	
	BL delay3 ; delay 5s

cambio_semaforoNS
	
	MOV r0, #RED ; N-S vehicular
	MOV r1, #GREEN ; N-S peatonal
	MOV r2, #RED ; S-N vehicular
	MOV r3, #GREEN ; N-S peatonal
	
	MOV r4, #GREEN ; Semaforo vehicular E-O
	MOV r5, #RED   ; Semaforo peatonal E-O
	MOV r6, #GREEN ; Semaforo vehicular O-E
	MOV r7, #RED   ; Semaforo peatonal O-E
	
	MOV r8, #TIME_BASE
	BL delay4
	
	
sensor_peatonal_OE

	MOV r8, #EXTRA_TIME ; delay 5s
	
	
	CMP r12,#0 ; compare sensorP EO con 0
	
	BEQ delay5 ; delay extra de 5s
	
	BL semaforoE_O_YELLOW ; cambio a amarillo


semaforoE_O_YELLOW

	MOV r4, #YELLOW; cambio a amarillo
	MOV r6, #YELLOW
	
	BL delay6 ; delay 5s


cambio_semaforo_OE
	
	MOV r0, #GREEN ; N-S vehicular
	MOV r1, #RED ; N-S peatonal
	MOV r2, #GREEN ; S-N vehicular
	MOV r3, #RED ; N-S peatonal
	
	MOV r4, #RED ; Semaforo vehicular E-O
	MOV r5, #GREEN   ; Semaforo peatonal E-O
	MOV r6, #RED ; Semaforo vehicular O-E
	MOV r7, #GREEN   ; Semaforo peatonal O-E

	BL start




delay6 
	ADD r9,r9,#1; timer = timer +1
	
	SUBS r10, r8, r9 ; if timer != Time
	
	BNE delay6 ; Else
	
	MOV r9, #0
	BL cambio_semaforo_OE



delay5 
	ADD r9,r9,#1; timer = timer +1
	
	SUBS r10, r8, r9 ; if timer != Time
	
	BNE delay5 ; Else
	
	MOV r9, #0
	BL semaforoE_O_YELLOW




delay4 
	ADD r9,r9,#1; timer = timer +1
	
	SUBS r10, r8, r9 ; if timer != Time
	
	BNE delay4 ; Else
	
	MOV r9, #0
	BL sensor_peatonal_OE


	
delay3	
	ADD r9,r9,#1; timer = timer +1
	
	SUBS r10, r8, r9 ; if timer != Time
	
	BNE delay3 ; Else
	
	MOV r9, #0
	BL cambio_semaforoNS
	


delay2
	ADD r9,r9,#1; timer = timer +1
	
	SUBS r10, r8, r9 ; if timer != Time
	
	BNE delay2 ; Else
	
	MOV r9, #0
	BL semaforoN_S_YELLOW


delay1

	ADD r9,r9,#1; timer = timer +1
	
	SUBS r10, r8, r9 ; if timer != Time
	
	BNE delay1 ; Else
	
	MOV r9, #0
	BL sensor_peatonal_NS
	

stop    B stop

	END
	
	