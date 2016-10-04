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
  int i, k = 0;
  int whitespaces = 0;

  //sort based on PID
  for(i = 0; i < MAX_PROCS && uprocs[i].pid != -2; i++) {

    //If child of a parent, print whitespaces
    if(i != 0 && (uprocs[i].ppid == uprocs[i - 1].pid))
      whitespaces += 3;
    else if(whitespaces >= 3)
      whitespaces -= 3;
    else
      whitespaces = 0;

    for(k = 0; k < whitespaces; k++)
      printf(1, " ");

    //Print out the name and PID of process
    printf(1, "%s [%d]\n", uprocs[i].name, uprocs[i].pid);

  }

  exit();
}
