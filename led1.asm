

// Pone il ping P9.30 a "1".
// 
// compilare con
// #> pasm -b led1.asm 
// il parametro "-b" sta per little-endian binary file.
	
.origin 0
.entrypoint START

#define PRU0_R31_VEC_VALID 32    // permette notifica di "programma concluso"
#define PRU_EVTOUT_0	    3    // evento che viene restituito 	
#define ISTR_PER_MS       200    // numero di istruzioni che vengono eseguite ogni millisecondo  
#define DELAY 	          20000000   // numero a caso

START:
	SET r30.t2       // accende P9.30
	MOV r0, DELAY
WAIT_ON:
	SUB r0, r0, 1
	QBNE WAIT_ON, r0, 0
LED_OFF:
	CLR r30.t2       // cancella stato => spegni il led
	MOV r0, DELAY
WAIT_OFF:
	SUB r0, r0, 1
	QBNE WAIT_OFF, r0, 0
	QBA START
	
END:	
	MOV r31.b0, PRU0_R31_VEC_VALID | PRU_EVTOUT_0
	HALT
	
