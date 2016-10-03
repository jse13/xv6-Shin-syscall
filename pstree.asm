
_pstree:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
// Maximum number of processes to record
#define MAX_PROCS 64

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	56                   	push   %esi
   4:	53                   	push   %ebx
   5:	83 e4 f0             	and    $0xfffffff0,%esp
   8:	83 ec 20             	sub    $0x20,%esp
  
  //Make array of uproc structs dynamically
  struct uproc* uprocs = malloc((sizeof(struct uproc) * MAX_PROCS));
   b:	c7 04 24 00 06 00 00 	movl   $0x600,(%esp)
  12:	e8 89 06 00 00       	call   6a0 <malloc>

  //Make a call to getprocs to populate this space with processor info
  if(getprocs(MAX_PROCS, uprocs) == -1) {
  17:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
  1e:	89 44 24 04          	mov    %eax,0x4(%esp)
int
main(int argc, char *argv[])
{
  
  //Make array of uproc structs dynamically
  struct uproc* uprocs = malloc((sizeof(struct uproc) * MAX_PROCS));
  22:	89 c3                	mov    %eax,%ebx

  //Make a call to getprocs to populate this space with processor info
  if(getprocs(MAX_PROCS, uprocs) == -1) {
  24:	e8 59 03 00 00       	call   382 <getprocs>
  29:	83 f8 ff             	cmp    $0xffffffff,%eax
  2c:	74 5f                	je     8d <main+0x8d>

// Maximum number of processes to record
#define MAX_PROCS 64

int
main(int argc, char *argv[])
  2e:	31 f6                	xor    %esi,%esi
  30:	eb 37                	jmp    69 <main+0x69>
  32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    //processes
    if(uprocs[i].pid == -2) {
      printf(1, "Found -2, exiting after %d loops\n", i); //@@
      break;
    }
    printf(1, "Name: %s     PID: %d     PPID: %d     \n", 
  38:	8b 53 04             	mov    0x4(%ebx),%edx
    printf(1, "getprocs failed!\n");
  }

  //Print out proc info
  int i = 0;
  for(i = 0; i < MAX_PROCS; i++) {
  3b:	83 c6 01             	add    $0x1,%esi
    //processes
    if(uprocs[i].pid == -2) {
      printf(1, "Found -2, exiting after %d loops\n", i); //@@
      break;
    }
    printf(1, "Name: %s     PID: %d     PPID: %d     \n", 
  3e:	89 44 24 0c          	mov    %eax,0xc(%esp)
                    uprocs[i].name, uprocs[i].pid, uprocs[i].ppid);
  42:	8d 43 08             	lea    0x8(%ebx),%eax
  45:	83 c3 18             	add    $0x18,%ebx
  48:	89 44 24 08          	mov    %eax,0x8(%esp)
    //processes
    if(uprocs[i].pid == -2) {
      printf(1, "Found -2, exiting after %d loops\n", i); //@@
      break;
    }
    printf(1, "Name: %s     PID: %d     PPID: %d     \n", 
  4c:	c7 44 24 04 b8 07 00 	movl   $0x7b8,0x4(%esp)
  53:	00 
  54:	89 54 24 10          	mov    %edx,0x10(%esp)
  58:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  5f:	e8 bc 03 00 00       	call   420 <printf>
    printf(1, "getprocs failed!\n");
  }

  //Print out proc info
  int i = 0;
  for(i = 0; i < MAX_PROCS; i++) {
  64:	83 fe 40             	cmp    $0x40,%esi
  67:	74 1f                	je     88 <main+0x88>
    //If the current process has a PID of -2, that means the end of the valid
    //processes
    if(uprocs[i].pid == -2) {
  69:	8b 03                	mov    (%ebx),%eax
  6b:	83 f8 fe             	cmp    $0xfffffffe,%eax
  6e:	75 c8                	jne    38 <main+0x38>
      printf(1, "Found -2, exiting after %d loops\n", i); //@@
  70:	89 74 24 08          	mov    %esi,0x8(%esp)
  74:	c7 44 24 04 94 07 00 	movl   $0x794,0x4(%esp)
  7b:	00 
  7c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  83:	e8 98 03 00 00       	call   420 <printf>
    printf(1, "Name: %s     PID: %d     PPID: %d     \n", 
                    uprocs[i].name, uprocs[i].pid, uprocs[i].ppid);

  }

  exit();
  88:	e8 55 02 00 00       	call   2e2 <exit>
  //Make array of uproc structs dynamically
  struct uproc* uprocs = malloc((sizeof(struct uproc) * MAX_PROCS));

  //Make a call to getprocs to populate this space with processor info
  if(getprocs(MAX_PROCS, uprocs) == -1) {
    printf(1, "getprocs failed!\n");
  8d:	c7 44 24 04 80 07 00 	movl   $0x780,0x4(%esp)
  94:	00 
  95:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  9c:	e8 7f 03 00 00       	call   420 <printf>
  a1:	eb 8b                	jmp    2e <main+0x2e>
  a3:	66 90                	xchg   %ax,%ax
  a5:	66 90                	xchg   %ax,%ax
  a7:	66 90                	xchg   %ax,%ax
  a9:	66 90                	xchg   %ax,%ax
  ab:	66 90                	xchg   %ax,%ax
  ad:	66 90                	xchg   %ax,%ax
  af:	90                   	nop

000000b0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	8b 45 08             	mov    0x8(%ebp),%eax
  b6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  b9:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  ba:	89 c2                	mov    %eax,%edx
  bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  c0:	0f b6 19             	movzbl (%ecx),%ebx
  c3:	83 c1 01             	add    $0x1,%ecx
  c6:	88 1a                	mov    %bl,(%edx)
  c8:	83 c2 01             	add    $0x1,%edx
  cb:	84 db                	test   %bl,%bl
  cd:	75 f1                	jne    c0 <strcpy+0x10>
    ;
  return os;
}
  cf:	5b                   	pop    %ebx
  d0:	5d                   	pop    %ebp
  d1:	c3                   	ret    
  d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000e0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	8b 55 08             	mov    0x8(%ebp),%edx
  e6:	56                   	push   %esi
  e7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ea:	53                   	push   %ebx
  while(*p && *p == *q)
  eb:	0f b6 02             	movzbl (%edx),%eax
  ee:	0f b6 19             	movzbl (%ecx),%ebx
  f1:	84 c0                	test   %al,%al
  f3:	75 16                	jne    10b <strcmp+0x2b>
  f5:	eb 21                	jmp    118 <strcmp+0x38>
  f7:	90                   	nop
    p++, q++;
  f8:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  fb:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  ff:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 102:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 105:	84 c0                	test   %al,%al
 107:	74 0f                	je     118 <strcmp+0x38>
    p++, q++;
 109:	89 f1                	mov    %esi,%ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 10b:	38 d8                	cmp    %bl,%al
 10d:	74 e9                	je     f8 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 10f:	29 d8                	sub    %ebx,%eax
}
 111:	5b                   	pop    %ebx
 112:	5e                   	pop    %esi
 113:	5d                   	pop    %ebp
 114:	c3                   	ret    
 115:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 118:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 11a:	29 d8                	sub    %ebx,%eax
}
 11c:	5b                   	pop    %ebx
 11d:	5e                   	pop    %esi
 11e:	5d                   	pop    %ebp
 11f:	c3                   	ret    

00000120 <strlen>:

uint
strlen(char *s)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 126:	80 39 00             	cmpb   $0x0,(%ecx)
 129:	74 12                	je     13d <strlen+0x1d>
 12b:	31 d2                	xor    %edx,%edx
 12d:	8d 76 00             	lea    0x0(%esi),%esi
 130:	83 c2 01             	add    $0x1,%edx
 133:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 137:	89 d0                	mov    %edx,%eax
 139:	75 f5                	jne    130 <strlen+0x10>
    ;
  return n;
}
 13b:	5d                   	pop    %ebp
 13c:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 13d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 13f:	5d                   	pop    %ebp
 140:	c3                   	ret    
 141:	eb 0d                	jmp    150 <memset>
 143:	90                   	nop
 144:	90                   	nop
 145:	90                   	nop
 146:	90                   	nop
 147:	90                   	nop
 148:	90                   	nop
 149:	90                   	nop
 14a:	90                   	nop
 14b:	90                   	nop
 14c:	90                   	nop
 14d:	90                   	nop
 14e:	90                   	nop
 14f:	90                   	nop

00000150 <memset>:

void*
memset(void *dst, int c, uint n)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	8b 55 08             	mov    0x8(%ebp),%edx
 156:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 157:	8b 4d 10             	mov    0x10(%ebp),%ecx
 15a:	8b 45 0c             	mov    0xc(%ebp),%eax
 15d:	89 d7                	mov    %edx,%edi
 15f:	fc                   	cld    
 160:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 162:	89 d0                	mov    %edx,%eax
 164:	5f                   	pop    %edi
 165:	5d                   	pop    %ebp
 166:	c3                   	ret    
 167:	89 f6                	mov    %esi,%esi
 169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000170 <strchr>:

char*
strchr(const char *s, char c)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	8b 45 08             	mov    0x8(%ebp),%eax
 176:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 17a:	0f b6 10             	movzbl (%eax),%edx
 17d:	84 d2                	test   %dl,%dl
 17f:	75 11                	jne    192 <strchr+0x22>
 181:	eb 15                	jmp    198 <strchr+0x28>
 183:	90                   	nop
 184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 188:	83 c0 01             	add    $0x1,%eax
 18b:	0f b6 10             	movzbl (%eax),%edx
 18e:	84 d2                	test   %dl,%dl
 190:	74 06                	je     198 <strchr+0x28>
    if(*s == c)
 192:	38 ca                	cmp    %cl,%dl
 194:	75 f2                	jne    188 <strchr+0x18>
      return (char*)s;
  return 0;
}
 196:	5d                   	pop    %ebp
 197:	c3                   	ret    
strchr(const char *s, char c)
{
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
 198:	31 c0                	xor    %eax,%eax
}
 19a:	5d                   	pop    %ebp
 19b:	90                   	nop
 19c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1a0:	c3                   	ret    
 1a1:	eb 0d                	jmp    1b0 <gets>
 1a3:	90                   	nop
 1a4:	90                   	nop
 1a5:	90                   	nop
 1a6:	90                   	nop
 1a7:	90                   	nop
 1a8:	90                   	nop
 1a9:	90                   	nop
 1aa:	90                   	nop
 1ab:	90                   	nop
 1ac:	90                   	nop
 1ad:	90                   	nop
 1ae:	90                   	nop
 1af:	90                   	nop

000001b0 <gets>:

char*
gets(char *buf, int max)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	57                   	push   %edi
 1b4:	56                   	push   %esi
 1b5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1b6:	31 db                	xor    %ebx,%ebx
  return 0;
}

char*
gets(char *buf, int max)
{
 1b8:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 1bb:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1be:	8d 73 01             	lea    0x1(%ebx),%esi
 1c1:	3b 75 0c             	cmp    0xc(%ebp),%esi
 1c4:	7d 42                	jge    208 <gets+0x58>
    cc = read(0, &c, 1);
 1c6:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 1cd:	00 
 1ce:	89 7c 24 04          	mov    %edi,0x4(%esp)
 1d2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1d9:	e8 1c 01 00 00       	call   2fa <read>
    if(cc < 1)
 1de:	85 c0                	test   %eax,%eax
 1e0:	7e 26                	jle    208 <gets+0x58>
      break;
    buf[i++] = c;
 1e2:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1e6:	89 f3                	mov    %esi,%ebx
 1e8:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 1eb:	3c 0d                	cmp    $0xd,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 1ed:	88 44 32 ff          	mov    %al,-0x1(%edx,%esi,1)
    if(c == '\n' || c == '\r')
 1f1:	74 04                	je     1f7 <gets+0x47>
 1f3:	3c 0a                	cmp    $0xa,%al
 1f5:	75 c7                	jne    1be <gets+0xe>
      break;
  }
  buf[i] = '\0';
 1f7:	8b 45 08             	mov    0x8(%ebp),%eax
 1fa:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 1fe:	83 c4 2c             	add    $0x2c,%esp
 201:	5b                   	pop    %ebx
 202:	5e                   	pop    %esi
 203:	5f                   	pop    %edi
 204:	5d                   	pop    %ebp
 205:	c3                   	ret    
 206:	66 90                	xchg   %ax,%ax
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 208:	8b 45 08             	mov    0x8(%ebp),%eax
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
 20b:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 20d:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 211:	83 c4 2c             	add    $0x2c,%esp
 214:	5b                   	pop    %ebx
 215:	5e                   	pop    %esi
 216:	5f                   	pop    %edi
 217:	5d                   	pop    %ebp
 218:	c3                   	ret    
 219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000220 <stat>:

int
stat(char *n, struct stat *st)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 226:	8b 45 08             	mov    0x8(%ebp),%eax
 229:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 230:	00 
  return buf;
}

int
stat(char *n, struct stat *st)
{
 231:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 234:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 237:	89 04 24             	mov    %eax,(%esp)
 23a:	e8 e3 00 00 00       	call   322 <open>
  if(fd < 0)
 23f:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 241:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 243:	78 2b                	js     270 <stat+0x50>
    return -1;
  r = fstat(fd, st);
 245:	8b 45 0c             	mov    0xc(%ebp),%eax
 248:	89 1c 24             	mov    %ebx,(%esp)
 24b:	89 44 24 04          	mov    %eax,0x4(%esp)
 24f:	e8 e6 00 00 00       	call   33a <fstat>
  close(fd);
 254:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 257:	89 c6                	mov    %eax,%esi
  close(fd);
 259:	e8 ac 00 00 00       	call   30a <close>
  return r;
}
 25e:	89 f0                	mov    %esi,%eax
 260:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 263:	8b 75 fc             	mov    -0x4(%ebp),%esi
 266:	89 ec                	mov    %ebp,%esp
 268:	5d                   	pop    %ebp
 269:	c3                   	ret    
 26a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 270:	be ff ff ff ff       	mov    $0xffffffff,%esi
 275:	eb e7                	jmp    25e <stat+0x3e>
 277:	89 f6                	mov    %esi,%esi
 279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000280 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	8b 4d 08             	mov    0x8(%ebp),%ecx
 286:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 287:	0f be 11             	movsbl (%ecx),%edx
 28a:	8d 42 d0             	lea    -0x30(%edx),%eax
 28d:	3c 09                	cmp    $0x9,%al
 28f:	b8 00 00 00 00       	mov    $0x0,%eax
 294:	77 17                	ja     2ad <atoi+0x2d>
 296:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 298:	83 c1 01             	add    $0x1,%ecx
 29b:	8d 04 80             	lea    (%eax,%eax,4),%eax
 29e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2a2:	0f be 11             	movsbl (%ecx),%edx
 2a5:	8d 5a d0             	lea    -0x30(%edx),%ebx
 2a8:	80 fb 09             	cmp    $0x9,%bl
 2ab:	76 eb                	jbe    298 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 2ad:	5b                   	pop    %ebx
 2ae:	5d                   	pop    %ebp
 2af:	c3                   	ret    

000002b0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2b0:	55                   	push   %ebp
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
 2b1:	31 d2                	xor    %edx,%edx
{
 2b3:	89 e5                	mov    %esp,%ebp
 2b5:	56                   	push   %esi
 2b6:	8b 45 08             	mov    0x8(%ebp),%eax
 2b9:	53                   	push   %ebx
 2ba:	8b 5d 10             	mov    0x10(%ebp),%ebx
 2bd:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2c0:	85 db                	test   %ebx,%ebx
 2c2:	7e 12                	jle    2d6 <memmove+0x26>
 2c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 2c8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 2cc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 2cf:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2d2:	39 da                	cmp    %ebx,%edx
 2d4:	75 f2                	jne    2c8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 2d6:	5b                   	pop    %ebx
 2d7:	5e                   	pop    %esi
 2d8:	5d                   	pop    %ebp
 2d9:	c3                   	ret    

000002da <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2da:	b8 01 00 00 00       	mov    $0x1,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <exit>:
SYSCALL(exit)
 2e2:	b8 02 00 00 00       	mov    $0x2,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <wait>:
SYSCALL(wait)
 2ea:	b8 03 00 00 00       	mov    $0x3,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <pipe>:
SYSCALL(pipe)
 2f2:	b8 04 00 00 00       	mov    $0x4,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <read>:
SYSCALL(read)
 2fa:	b8 05 00 00 00       	mov    $0x5,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <write>:
SYSCALL(write)
 302:	b8 10 00 00 00       	mov    $0x10,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <close>:
SYSCALL(close)
 30a:	b8 15 00 00 00       	mov    $0x15,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <kill>:
SYSCALL(kill)
 312:	b8 06 00 00 00       	mov    $0x6,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <exec>:
SYSCALL(exec)
 31a:	b8 07 00 00 00       	mov    $0x7,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <open>:
SYSCALL(open)
 322:	b8 0f 00 00 00       	mov    $0xf,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <mknod>:
SYSCALL(mknod)
 32a:	b8 11 00 00 00       	mov    $0x11,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <unlink>:
SYSCALL(unlink)
 332:	b8 12 00 00 00       	mov    $0x12,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <fstat>:
SYSCALL(fstat)
 33a:	b8 08 00 00 00       	mov    $0x8,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <link>:
SYSCALL(link)
 342:	b8 13 00 00 00       	mov    $0x13,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <mkdir>:
SYSCALL(mkdir)
 34a:	b8 14 00 00 00       	mov    $0x14,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <chdir>:
SYSCALL(chdir)
 352:	b8 09 00 00 00       	mov    $0x9,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <dup>:
SYSCALL(dup)
 35a:	b8 0a 00 00 00       	mov    $0xa,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <getpid>:
SYSCALL(getpid)
 362:	b8 0b 00 00 00       	mov    $0xb,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <sbrk>:
SYSCALL(sbrk)
 36a:	b8 0c 00 00 00       	mov    $0xc,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <sleep>:
SYSCALL(sleep)
 372:	b8 0d 00 00 00       	mov    $0xd,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <uptime>:
SYSCALL(uptime)
 37a:	b8 0e 00 00 00       	mov    $0xe,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <getprocs>:
SYSCALL(getprocs)
 382:	b8 16 00 00 00       	mov    $0x16,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    
 38a:	66 90                	xchg   %ax,%ax
 38c:	66 90                	xchg   %ax,%ax
 38e:	66 90                	xchg   %ax,%ax

00000390 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	57                   	push   %edi
 394:	89 c7                	mov    %eax,%edi
 396:	56                   	push   %esi
 397:	53                   	push   %ebx
 398:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 39b:	8b 45 08             	mov    0x8(%ebp),%eax
 39e:	85 c0                	test   %eax,%eax
 3a0:	74 76                	je     418 <printint+0x88>
 3a2:	89 d0                	mov    %edx,%eax
 3a4:	c1 e8 1f             	shr    $0x1f,%eax
 3a7:	84 c0                	test   %al,%al
 3a9:	74 6d                	je     418 <printint+0x88>
    neg = 1;
    x = -xx;
 3ab:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 3ad:	bb 01 00 00 00       	mov    $0x1,%ebx
    x = -xx;
 3b2:	f7 d8                	neg    %eax
  } else {
    x = xx;
  }

  i = 0;
 3b4:	31 f6                	xor    %esi,%esi
 3b6:	eb 02                	jmp    3ba <printint+0x2a>
  do{
    buf[i++] = digits[x % base];
 3b8:	89 d6                	mov    %edx,%esi
 3ba:	31 d2                	xor    %edx,%edx
 3bc:	f7 f1                	div    %ecx
 3be:	0f b6 92 e7 07 00 00 	movzbl 0x7e7(%edx),%edx
  }while((x /= base) != 0);
 3c5:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 3c7:	88 54 35 d8          	mov    %dl,-0x28(%ebp,%esi,1)
 3cb:	8d 56 01             	lea    0x1(%esi),%edx
  }while((x /= base) != 0);
 3ce:	75 e8                	jne    3b8 <printint+0x28>
  if(neg)
 3d0:	85 db                	test   %ebx,%ebx
 3d2:	74 08                	je     3dc <printint+0x4c>
    buf[i++] = '-';
 3d4:	c6 44 15 d8 2d       	movb   $0x2d,-0x28(%ebp,%edx,1)
 3d9:	8d 56 02             	lea    0x2(%esi),%edx

  while(--i >= 0)
 3dc:	8d 5a ff             	lea    -0x1(%edx),%ebx
 3df:	83 fb ff             	cmp    $0xffffffff,%ebx
 3e2:	8d 75 d7             	lea    -0x29(%ebp),%esi
 3e5:	74 25                	je     40c <printint+0x7c>
 3e7:	90                   	nop
 3e8:	0f b6 44 1d d8       	movzbl -0x28(%ebp,%ebx,1),%eax
 3ed:	83 eb 01             	sub    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3f0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3f7:	00 
 3f8:	89 74 24 04          	mov    %esi,0x4(%esp)
 3fc:	89 3c 24             	mov    %edi,(%esp)
 3ff:	88 45 d7             	mov    %al,-0x29(%ebp)
 402:	e8 fb fe ff ff       	call   302 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 407:	83 fb ff             	cmp    $0xffffffff,%ebx
 40a:	75 dc                	jne    3e8 <printint+0x58>
    putc(fd, buf[i]);
}
 40c:	83 c4 3c             	add    $0x3c,%esp
 40f:	5b                   	pop    %ebx
 410:	5e                   	pop    %esi
 411:	5f                   	pop    %edi
 412:	5d                   	pop    %ebp
 413:	c3                   	ret    
 414:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 418:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 41a:	31 db                	xor    %ebx,%ebx
 41c:	eb 96                	jmp    3b4 <printint+0x24>
 41e:	66 90                	xchg   %ax,%ax

00000420 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 424:	31 ff                	xor    %edi,%edi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 426:	56                   	push   %esi
 427:	53                   	push   %ebx
 428:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 42b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 42e:	8d 55 10             	lea    0x10(%ebp),%edx
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 431:	8b 75 08             	mov    0x8(%ebp),%esi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 434:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 437:	0f be 03             	movsbl (%ebx),%eax
    putc(fd, buf[i]);
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
 43a:	83 c3 01             	add    $0x1,%ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 43d:	84 c0                	test   %al,%al
 43f:	75 39                	jne    47a <printf+0x5a>
 441:	e9 c2 00 00 00       	jmp    508 <printf+0xe8>
 446:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 448:	83 fa 25             	cmp    $0x25,%edx
 44b:	0f 84 bf 00 00 00    	je     510 <printf+0xf0>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 451:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 454:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 45b:	00 
 45c:	89 44 24 04          	mov    %eax,0x4(%esp)
 460:	89 34 24             	mov    %esi,(%esp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 463:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 466:	e8 97 fe ff ff       	call   302 <write>
 46b:	83 c3 01             	add    $0x1,%ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 46e:	0f be 43 ff          	movsbl -0x1(%ebx),%eax
 472:	84 c0                	test   %al,%al
 474:	0f 84 8e 00 00 00    	je     508 <printf+0xe8>
    c = fmt[i] & 0xff;
 47a:	0f b6 d0             	movzbl %al,%edx
    if(state == 0){
 47d:	85 ff                	test   %edi,%edi
 47f:	74 c7                	je     448 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 481:	83 ff 25             	cmp    $0x25,%edi
 484:	75 e5                	jne    46b <printf+0x4b>
      if(c == 'd'){
 486:	83 fa 64             	cmp    $0x64,%edx
 489:	0f 84 31 01 00 00    	je     5c0 <printf+0x1a0>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 48f:	25 f7 00 00 00       	and    $0xf7,%eax
 494:	83 f8 70             	cmp    $0x70,%eax
 497:	0f 84 83 00 00 00    	je     520 <printf+0x100>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 49d:	83 fa 73             	cmp    $0x73,%edx
 4a0:	0f 84 a2 00 00 00    	je     548 <printf+0x128>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4a6:	83 fa 63             	cmp    $0x63,%edx
 4a9:	0f 84 35 01 00 00    	je     5e4 <printf+0x1c4>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4af:	83 fa 25             	cmp    $0x25,%edx
 4b2:	0f 84 e0 00 00 00    	je     598 <printf+0x178>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4b8:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 4bb:	83 c3 01             	add    $0x1,%ebx
 4be:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4c5:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4c6:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4c8:	89 44 24 04          	mov    %eax,0x4(%esp)
 4cc:	89 34 24             	mov    %esi,(%esp)
 4cf:	89 55 d0             	mov    %edx,-0x30(%ebp)
 4d2:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 4d6:	e8 27 fe ff ff       	call   302 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 4db:	8b 55 d0             	mov    -0x30(%ebp),%edx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4de:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4e1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4e8:	00 
 4e9:	89 44 24 04          	mov    %eax,0x4(%esp)
 4ed:	89 34 24             	mov    %esi,(%esp)
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 4f0:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4f3:	e8 0a fe ff ff       	call   302 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4f8:	0f be 43 ff          	movsbl -0x1(%ebx),%eax
 4fc:	84 c0                	test   %al,%al
 4fe:	0f 85 76 ff ff ff    	jne    47a <printf+0x5a>
 504:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 508:	83 c4 3c             	add    $0x3c,%esp
 50b:	5b                   	pop    %ebx
 50c:	5e                   	pop    %esi
 50d:	5f                   	pop    %edi
 50e:	5d                   	pop    %ebp
 50f:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 510:	bf 25 00 00 00       	mov    $0x25,%edi
 515:	e9 51 ff ff ff       	jmp    46b <printf+0x4b>
 51a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 520:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 523:	b9 10 00 00 00       	mov    $0x10,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 528:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 52a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 531:	8b 10                	mov    (%eax),%edx
 533:	89 f0                	mov    %esi,%eax
 535:	e8 56 fe ff ff       	call   390 <printint>
        ap++;
 53a:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 53e:	e9 28 ff ff ff       	jmp    46b <printf+0x4b>
 543:	90                   	nop
 544:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 548:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        ap++;
        if(s == 0)
          s = "(null)";
 54b:	b8 e0 07 00 00       	mov    $0x7e0,%eax
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 550:	8b 3a                	mov    (%edx),%edi
        ap++;
 552:	83 c2 04             	add    $0x4,%edx
 555:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
          s = "(null)";
 558:	85 ff                	test   %edi,%edi
 55a:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 55d:	0f b6 07             	movzbl (%edi),%eax
 560:	84 c0                	test   %al,%al
 562:	74 28                	je     58c <printf+0x16c>
 564:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 568:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 56b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 56e:	83 c7 01             	add    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 571:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 578:	00 
 579:	89 44 24 04          	mov    %eax,0x4(%esp)
 57d:	89 34 24             	mov    %esi,(%esp)
 580:	e8 7d fd ff ff       	call   302 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 585:	0f b6 07             	movzbl (%edi),%eax
 588:	84 c0                	test   %al,%al
 58a:	75 dc                	jne    568 <printf+0x148>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 58c:	31 ff                	xor    %edi,%edi
 58e:	e9 d8 fe ff ff       	jmp    46b <printf+0x4b>
 593:	90                   	nop
 594:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 598:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 59b:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 59d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5a4:	00 
 5a5:	89 44 24 04          	mov    %eax,0x4(%esp)
 5a9:	89 34 24             	mov    %esi,(%esp)
 5ac:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 5b0:	e8 4d fd ff ff       	call   302 <write>
 5b5:	e9 b1 fe ff ff       	jmp    46b <printf+0x4b>
 5ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 5c0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 5c3:	b9 0a 00 00 00       	mov    $0xa,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5c8:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 5cb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 5d2:	8b 10                	mov    (%eax),%edx
 5d4:	89 f0                	mov    %esi,%eax
 5d6:	e8 b5 fd ff ff       	call   390 <printint>
        ap++;
 5db:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 5df:	e9 87 fe ff ff       	jmp    46b <printf+0x4b>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 5e4:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5e7:	31 ff                	xor    %edi,%edi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 5e9:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5eb:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5f2:	00 
 5f3:	89 34 24             	mov    %esi,(%esp)
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 5f6:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5f9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 5fc:	89 44 24 04          	mov    %eax,0x4(%esp)
 600:	e8 fd fc ff ff       	call   302 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 605:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 609:	e9 5d fe ff ff       	jmp    46b <printf+0x4b>
 60e:	66 90                	xchg   %ax,%ax

00000610 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 610:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 611:	a1 7c 0a 00 00       	mov    0xa7c,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 616:	89 e5                	mov    %esp,%ebp
 618:	57                   	push   %edi
 619:	56                   	push   %esi
 61a:	53                   	push   %ebx
 61b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 61e:	8b 08                	mov    (%eax),%ecx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 620:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 623:	39 d0                	cmp    %edx,%eax
 625:	72 11                	jb     638 <free+0x28>
 627:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 628:	39 c8                	cmp    %ecx,%eax
 62a:	72 04                	jb     630 <free+0x20>
 62c:	39 ca                	cmp    %ecx,%edx
 62e:	72 10                	jb     640 <free+0x30>
 630:	89 c8                	mov    %ecx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 632:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 634:	8b 08                	mov    (%eax),%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 636:	73 f0                	jae    628 <free+0x18>
 638:	39 ca                	cmp    %ecx,%edx
 63a:	72 04                	jb     640 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 63c:	39 c8                	cmp    %ecx,%eax
 63e:	72 f0                	jb     630 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 640:	8b 73 fc             	mov    -0x4(%ebx),%esi
 643:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 646:	39 cf                	cmp    %ecx,%edi
 648:	74 1e                	je     668 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 64a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 64d:	8b 48 04             	mov    0x4(%eax),%ecx
 650:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 653:	39 f2                	cmp    %esi,%edx
 655:	74 28                	je     67f <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 657:	89 10                	mov    %edx,(%eax)
  freep = p;
 659:	a3 7c 0a 00 00       	mov    %eax,0xa7c
}
 65e:	5b                   	pop    %ebx
 65f:	5e                   	pop    %esi
 660:	5f                   	pop    %edi
 661:	5d                   	pop    %ebp
 662:	c3                   	ret    
 663:	90                   	nop
 664:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 668:	03 71 04             	add    0x4(%ecx),%esi
 66b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 66e:	8b 08                	mov    (%eax),%ecx
 670:	8b 09                	mov    (%ecx),%ecx
 672:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 675:	8b 48 04             	mov    0x4(%eax),%ecx
 678:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 67b:	39 f2                	cmp    %esi,%edx
 67d:	75 d8                	jne    657 <free+0x47>
    p->s.size += bp->s.size;
 67f:	03 4b fc             	add    -0x4(%ebx),%ecx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 682:	a3 7c 0a 00 00       	mov    %eax,0xa7c
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 687:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 68a:	8b 53 f8             	mov    -0x8(%ebx),%edx
 68d:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 68f:	5b                   	pop    %ebx
 690:	5e                   	pop    %esi
 691:	5f                   	pop    %edi
 692:	5d                   	pop    %ebp
 693:	c3                   	ret    
 694:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 69a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000006a0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6a0:	55                   	push   %ebp
 6a1:	89 e5                	mov    %esp,%ebp
 6a3:	57                   	push   %edi
 6a4:	56                   	push   %esi
 6a5:	53                   	push   %ebx
 6a6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6a9:	8b 55 08             	mov    0x8(%ebp),%edx
  if((prevp = freep) == 0){
 6ac:	8b 0d 7c 0a 00 00    	mov    0xa7c,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6b2:	83 c2 07             	add    $0x7,%edx
 6b5:	c1 ea 03             	shr    $0x3,%edx
  if((prevp = freep) == 0){
 6b8:	85 c9                	test   %ecx,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6ba:	8d 5a 01             	lea    0x1(%edx),%ebx
  if((prevp = freep) == 0){
 6bd:	0f 84 93 00 00 00    	je     756 <malloc+0xb6>
 6c3:	8b 01                	mov    (%ecx),%eax
 6c5:	8b 78 04             	mov    0x4(%eax),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6c8:	39 fb                	cmp    %edi,%ebx
 6ca:	76 64                	jbe    730 <malloc+0x90>
 6cc:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 6d3:	eb 0c                	jmp    6e1 <malloc+0x41>
 6d5:	8d 76 00             	lea    0x0(%esi),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6d8:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 6da:	8b 78 04             	mov    0x4(%eax),%edi
 6dd:	39 fb                	cmp    %edi,%ebx
 6df:	76 4f                	jbe    730 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6e1:	3b 05 7c 0a 00 00    	cmp    0xa7c,%eax
 6e7:	89 c1                	mov    %eax,%ecx
 6e9:	75 ed                	jne    6d8 <malloc+0x38>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 6eb:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 6f1:	b8 00 80 00 00       	mov    $0x8000,%eax
 6f6:	0f 43 c6             	cmovae %esi,%eax
 6f9:	bf 00 10 00 00       	mov    $0x1000,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 6fe:	89 04 24             	mov    %eax,(%esp)
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 701:	0f 43 fb             	cmovae %ebx,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 704:	e8 61 fc ff ff       	call   36a <sbrk>
  if(p == (char*)-1)
 709:	83 f8 ff             	cmp    $0xffffffff,%eax
 70c:	74 18                	je     726 <malloc+0x86>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 70e:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 711:	83 c0 08             	add    $0x8,%eax
 714:	89 04 24             	mov    %eax,(%esp)
 717:	e8 f4 fe ff ff       	call   610 <free>
  return freep;
 71c:	8b 0d 7c 0a 00 00    	mov    0xa7c,%ecx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 722:	85 c9                	test   %ecx,%ecx
 724:	75 b2                	jne    6d8 <malloc+0x38>
        return 0;
 726:	31 c0                	xor    %eax,%eax
 728:	eb 1e                	jmp    748 <malloc+0xa8>
 72a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 730:	39 fb                	cmp    %edi,%ebx
 732:	74 1c                	je     750 <malloc+0xb0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 734:	29 df                	sub    %ebx,%edi
 736:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 739:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 73c:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 73f:	89 0d 7c 0a 00 00    	mov    %ecx,0xa7c
      return (void*)(p + 1);
 745:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 748:	83 c4 1c             	add    $0x1c,%esp
 74b:	5b                   	pop    %ebx
 74c:	5e                   	pop    %esi
 74d:	5f                   	pop    %edi
 74e:	5d                   	pop    %ebp
 74f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 750:	8b 10                	mov    (%eax),%edx
 752:	89 11                	mov    %edx,(%ecx)
 754:	eb e9                	jmp    73f <malloc+0x9f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 756:	c7 05 7c 0a 00 00 80 	movl   $0xa80,0xa7c
 75d:	0a 00 00 
    base.s.size = 0;
 760:	b8 80 0a 00 00       	mov    $0xa80,%eax
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 765:	c7 05 80 0a 00 00 80 	movl   $0xa80,0xa80
 76c:	0a 00 00 
    base.s.size = 0;
 76f:	c7 05 84 0a 00 00 00 	movl   $0x0,0xa84
 776:	00 00 00 
 779:	e9 4e ff ff ff       	jmp    6cc <malloc+0x2c>
