#include<stdio.h>
#include<prussdrv.h>
#include<pruss_intc_mapping.h>
#define PRU_NUM 0   // usiamo la PRU-0
#define PROG_NAME "./led1.bin"     // programma da caricare nella PRU 

void main() {
  // inizializza struttura dati 
  tpruss_intc_initdata pruss_intc_initdata = PRUSS_INTC_INITDATA;
  // alloca i inizializza memoria 
  prussdrv_init();
  prussdrv_open (PRU_EVTOUT_0);
  // mappa PRU interrupt 
  prussdrv_pruintc_init( &pruss_intc_initdata);
  // carica il programma nella pru
  prussdrv_exec_program( PRU_NUM, "./led1.bin");
  // attende completamento del programma della PRU 
  int n = prussdrv_pru_wait_event( PRU_EVTOUT_0 );
  printf("PRU program completed with exit code: %d .\n", n);
  // disabilita la PRU e chiude il mappaggio della memoria
  prussdrv_pru_disable(PRU_NUM);
  prussdrv_exit();

}
