#include "types.h"
#include "stat.h"
#include "user.h"

// Maximum number of processes to record
#define MAX_PROCS 64

int
main(int argc, char *argv[])
{
  
  //Make array of uproc structs dynamically
  struct uproc* uprocs = malloc((sizeof(struct uproc) * MAX_PROCS));

  //Make a call to getprocs to populate this space with processor info
  if(getprocs(MAX_PROCS, uprocs) == -1) {
    printf(1, "getprocs failed!\n");
  }

  //Print out proc info
  int i = 0;
  for(i = 0; i < MAX_PROCS; i++) {
    //If the current process has a PID of -2, that means the end of the valid
    //processes
    if(uprocs[i].pid == -2) {
      printf(1, "Found -2, exiting after %d loops\n", i); //@@
      break;
    }
    printf(1, "Name: %s     PID: %d     PPID: %d     \n", 
                    uprocs[i].name, uprocs[i].pid, uprocs[i].ppid);

  }

  exit();
}
