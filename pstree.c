#include "types.h"
#include "stat.h"
#include "user.h"

// Maximum number of processes to record
#define MAX_PROCS 64

int
main(int argc, char *argv[])
{
  
  //Make array of uproc structs dynamically
  struct uproc* procs = malloc((sizeof(struct uproc) * MAX_PROCS));

  //Make a call to getprocs to populate this space with processor info
  if(getprocs(MAX_PROCS, procs) == -1) {
    printf(1, "getprocs failed!\n");
  }

  //TODO: print out proc info

  exit();
}
