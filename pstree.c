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

  exit();
}
