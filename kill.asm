
_kill:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	53                   	push   %ebx
  int i;

  if(argc < 2){
   6:	bb 01 00 00 00       	mov    $0x1,%ebx
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
   b:	83 e4 f0             	and    $0xfffffff0,%esp
   e:	83 ec 10             	sub    $0x10,%esp
  11:	8b 75 08             	mov    0x8(%ebp),%esi
  14:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  if(argc < 2){
  17:	83 fe 01             	cmp    $0x1,%esi
  1a:	7e 23                	jle    3f <main+0x3f>
  1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
  20:	8b 04 9f             	mov    (%edi,%ebx,4),%eax

  if(argc < 2){
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
  23:	83 c3 01             	add    $0x1,%ebx
    kill(atoi(argv[i]));
  26:	89 04 24             	mov    %eax,(%esp)
  29:	e8 02 02 00 00       	call   230 <atoi>
  2e:	89 04 24             	mov    %eax,(%esp)
  31:	e8 8c 02 00 00       	call   2c2 <kill>

  if(argc < 2){
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
  36:	39 f3                	cmp    %esi,%ebx
  38:	75 e6                	jne    20 <main+0x20>
    kill(atoi(argv[i]));
  exit();
  3a:	e8 53 02 00 00       	call   292 <exit>
main(int argc, char **argv)
{
  int i;

  if(argc < 2){
    printf(2, "usage: kill pid...\n");
  3f:	c7 44 24 04 2e 07 00 	movl   $0x72e,0x4(%esp)
  46:	00 
  47:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  4e:	e8 7d 03 00 00       	call   3d0 <printf>
    exit();
  53:	e8 3a 02 00 00       	call   292 <exit>
  58:	66 90                	xchg   %ax,%ax
  5a:	66 90                	xchg   %ax,%ax
  5c:	66 90                	xchg   %ax,%ax
  5e:	66 90                	xchg   %ax,%ax

00000060 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	8b 45 08             	mov    0x8(%ebp),%eax
  66:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  69:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  6a:	89 c2                	mov    %eax,%edx
  6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  70:	0f b6 19             	movzbl (%ecx),%ebx
  73:	83 c1 01             	add    $0x1,%ecx
  76:	88 1a                	mov    %bl,(%edx)
  78:	83 c2 01             	add    $0x1,%edx
  7b:	84 db                	test   %bl,%bl
  7d:	75 f1                	jne    70 <strcpy+0x10>
    ;
  return os;
}
  7f:	5b                   	pop    %ebx
  80:	5d                   	pop    %ebp
  81:	c3                   	ret    
  82:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000090 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	8b 55 08             	mov    0x8(%ebp),%edx
  96:	56                   	push   %esi
  97:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  9a:	53                   	push   %ebx
  while(*p && *p == *q)
  9b:	0f b6 02             	movzbl (%edx),%eax
  9e:	0f b6 19             	movzbl (%ecx),%ebx
  a1:	84 c0                	test   %al,%al
  a3:	75 16                	jne    bb <strcmp+0x2b>
  a5:	eb 21                	jmp    c8 <strcmp+0x38>
  a7:	90                   	nop
    p++, q++;
  a8:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  ab:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  af:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  b2:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  b5:	84 c0                	test   %al,%al
  b7:	74 0f                	je     c8 <strcmp+0x38>
    p++, q++;
  b9:	89 f1                	mov    %esi,%ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  bb:	38 d8                	cmp    %bl,%al
  bd:	74 e9                	je     a8 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  bf:	29 d8                	sub    %ebx,%eax
}
  c1:	5b                   	pop    %ebx
  c2:	5e                   	pop    %esi
  c3:	5d                   	pop    %ebp
  c4:	c3                   	ret    
  c5:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  c8:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
  ca:	29 d8                	sub    %ebx,%eax
}
  cc:	5b                   	pop    %ebx
  cd:	5e                   	pop    %esi
  ce:	5d                   	pop    %ebp
  cf:	c3                   	ret    

000000d0 <strlen>:

uint
strlen(char *s)
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  d6:	80 39 00             	cmpb   $0x0,(%ecx)
  d9:	74 12                	je     ed <strlen+0x1d>
  db:	31 d2                	xor    %edx,%edx
  dd:	8d 76 00             	lea    0x0(%esi),%esi
  e0:	83 c2 01             	add    $0x1,%edx
  e3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  e7:	89 d0                	mov    %edx,%eax
  e9:	75 f5                	jne    e0 <strlen+0x10>
    ;
  return n;
}
  eb:	5d                   	pop    %ebp
  ec:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
  ed:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
  ef:	5d                   	pop    %ebp
  f0:	c3                   	ret    
  f1:	eb 0d                	jmp    100 <memset>
  f3:	90                   	nop
  f4:	90                   	nop
  f5:	90                   	nop
  f6:	90                   	nop
  f7:	90                   	nop
  f8:	90                   	nop
  f9:	90                   	nop
  fa:	90                   	nop
  fb:	90                   	nop
  fc:	90                   	nop
  fd:	90                   	nop
  fe:	90                   	nop
  ff:	90                   	nop

00000100 <memset>:

void*
memset(void *dst, int c, uint n)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	8b 55 08             	mov    0x8(%ebp),%edx
 106:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 107:	8b 4d 10             	mov    0x10(%ebp),%ecx
 10a:	8b 45 0c             	mov    0xc(%ebp),%eax
 10d:	89 d7                	mov    %edx,%edi
 10f:	fc                   	cld    
 110:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 112:	89 d0                	mov    %edx,%eax
 114:	5f                   	pop    %edi
 115:	5d                   	pop    %ebp
 116:	c3                   	ret    
 117:	89 f6                	mov    %esi,%esi
 119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000120 <strchr>:

char*
strchr(const char *s, char c)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	8b 45 08             	mov    0x8(%ebp),%eax
 126:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 12a:	0f b6 10             	movzbl (%eax),%edx
 12d:	84 d2                	test   %dl,%dl
 12f:	75 11                	jne    142 <strchr+0x22>
 131:	eb 15                	jmp    148 <strchr+0x28>
 133:	90                   	nop
 134:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 138:	83 c0 01             	add    $0x1,%eax
 13b:	0f b6 10             	movzbl (%eax),%edx
 13e:	84 d2                	test   %dl,%dl
 140:	74 06                	je     148 <strchr+0x28>
    if(*s == c)
 142:	38 ca                	cmp    %cl,%dl
 144:	75 f2                	jne    138 <strchr+0x18>
      return (char*)s;
  return 0;
}
 146:	5d                   	pop    %ebp
 147:	c3                   	ret    
strchr(const char *s, char c)
{
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
 148:	31 c0                	xor    %eax,%eax
}
 14a:	5d                   	pop    %ebp
 14b:	90                   	nop
 14c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 150:	c3                   	ret    
 151:	eb 0d                	jmp    160 <gets>
 153:	90                   	nop
 154:	90                   	nop
 155:	90                   	nop
 156:	90                   	nop
 157:	90                   	nop
 158:	90                   	nop
 159:	90                   	nop
 15a:	90                   	nop
 15b:	90                   	nop
 15c:	90                   	nop
 15d:	90                   	nop
 15e:	90                   	nop
 15f:	90                   	nop

00000160 <gets>:

char*
gets(char *buf, int max)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	57                   	push   %edi
 164:	56                   	push   %esi
 165:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 166:	31 db                	xor    %ebx,%ebx
  return 0;
}

char*
gets(char *buf, int max)
{
 168:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 16b:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 16e:	8d 73 01             	lea    0x1(%ebx),%esi
 171:	3b 75 0c             	cmp    0xc(%ebp),%esi
 174:	7d 42                	jge    1b8 <gets+0x58>
    cc = read(0, &c, 1);
 176:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 17d:	00 
 17e:	89 7c 24 04          	mov    %edi,0x4(%esp)
 182:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 189:	e8 1c 01 00 00       	call   2aa <read>
    if(cc < 1)
 18e:	85 c0                	test   %eax,%eax
 190:	7e 26                	jle    1b8 <gets+0x58>
      break;
    buf[i++] = c;
 192:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 196:	89 f3                	mov    %esi,%ebx
 198:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 19b:	3c 0d                	cmp    $0xd,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 19d:	88 44 32 ff          	mov    %al,-0x1(%edx,%esi,1)
    if(c == '\n' || c == '\r')
 1a1:	74 04                	je     1a7 <gets+0x47>
 1a3:	3c 0a                	cmp    $0xa,%al
 1a5:	75 c7                	jne    16e <gets+0xe>
      break;
  }
  buf[i] = '\0';
 1a7:	8b 45 08             	mov    0x8(%ebp),%eax
 1aa:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 1ae:	83 c4 2c             	add    $0x2c,%esp
 1b1:	5b                   	pop    %ebx
 1b2:	5e                   	pop    %esi
 1b3:	5f                   	pop    %edi
 1b4:	5d                   	pop    %ebp
 1b5:	c3                   	ret    
 1b6:	66 90                	xchg   %ax,%ax
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1b8:	8b 45 08             	mov    0x8(%ebp),%eax
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
 1bb:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1bd:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 1c1:	83 c4 2c             	add    $0x2c,%esp
 1c4:	5b                   	pop    %ebx
 1c5:	5e                   	pop    %esi
 1c6:	5f                   	pop    %edi
 1c7:	5d                   	pop    %ebp
 1c8:	c3                   	ret    
 1c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001d0 <stat>:

int
stat(char *n, struct stat *st)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1d6:	8b 45 08             	mov    0x8(%ebp),%eax
 1d9:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1e0:	00 
  return buf;
}

int
stat(char *n, struct stat *st)
{
 1e1:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 1e4:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1e7:	89 04 24             	mov    %eax,(%esp)
 1ea:	e8 e3 00 00 00       	call   2d2 <open>
  if(fd < 0)
 1ef:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f1:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 1f3:	78 2b                	js     220 <stat+0x50>
    return -1;
  r = fstat(fd, st);
 1f5:	8b 45 0c             	mov    0xc(%ebp),%eax
 1f8:	89 1c 24             	mov    %ebx,(%esp)
 1fb:	89 44 24 04          	mov    %eax,0x4(%esp)
 1ff:	e8 e6 00 00 00       	call   2ea <fstat>
  close(fd);
 204:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 207:	89 c6                	mov    %eax,%esi
  close(fd);
 209:	e8 ac 00 00 00       	call   2ba <close>
  return r;
}
 20e:	89 f0                	mov    %esi,%eax
 210:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 213:	8b 75 fc             	mov    -0x4(%ebp),%esi
 216:	89 ec                	mov    %ebp,%esp
 218:	5d                   	pop    %ebp
 219:	c3                   	ret    
 21a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 220:	be ff ff ff ff       	mov    $0xffffffff,%esi
 225:	eb e7                	jmp    20e <stat+0x3e>
 227:	89 f6                	mov    %esi,%esi
 229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000230 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	8b 4d 08             	mov    0x8(%ebp),%ecx
 236:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 237:	0f be 11             	movsbl (%ecx),%edx
 23a:	8d 42 d0             	lea    -0x30(%edx),%eax
 23d:	3c 09                	cmp    $0x9,%al
 23f:	b8 00 00 00 00       	mov    $0x0,%eax
 244:	77 17                	ja     25d <atoi+0x2d>
 246:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 248:	83 c1 01             	add    $0x1,%ecx
 24b:	8d 04 80             	lea    (%eax,%eax,4),%eax
 24e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 252:	0f be 11             	movsbl (%ecx),%edx
 255:	8d 5a d0             	lea    -0x30(%edx),%ebx
 258:	80 fb 09             	cmp    $0x9,%bl
 25b:	76 eb                	jbe    248 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 25d:	5b                   	pop    %ebx
 25e:	5d                   	pop    %ebp
 25f:	c3                   	ret    

00000260 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 260:	55                   	push   %ebp
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
 261:	31 d2                	xor    %edx,%edx
{
 263:	89 e5                	mov    %esp,%ebp
 265:	56                   	push   %esi
 266:	8b 45 08             	mov    0x8(%ebp),%eax
 269:	53                   	push   %ebx
 26a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 26d:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 270:	85 db                	test   %ebx,%ebx
 272:	7e 12                	jle    286 <memmove+0x26>
 274:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 278:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 27c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 27f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 282:	39 da                	cmp    %ebx,%edx
 284:	75 f2                	jne    278 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 286:	5b                   	pop    %ebx
 287:	5e                   	pop    %esi
 288:	5d                   	pop    %ebp
 289:	c3                   	ret    

0000028a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 28a:	b8 01 00 00 00       	mov    $0x1,%eax
 28f:	cd 40                	int    $0x40
 291:	c3                   	ret    

00000292 <exit>:
SYSCALL(exit)
 292:	b8 02 00 00 00       	mov    $0x2,%eax
 297:	cd 40                	int    $0x40
 299:	c3                   	ret    

0000029a <wait>:
SYSCALL(wait)
 29a:	b8 03 00 00 00       	mov    $0x3,%eax
 29f:	cd 40                	int    $0x40
 2a1:	c3                   	ret    

000002a2 <pipe>:
SYSCALL(pipe)
 2a2:	b8 04 00 00 00       	mov    $0x4,%eax
 2a7:	cd 40                	int    $0x40
 2a9:	c3                   	ret    

000002aa <read>:
SYSCALL(read)
 2aa:	b8 05 00 00 00       	mov    $0x5,%eax
 2af:	cd 40                	int    $0x40
 2b1:	c3                   	ret    

000002b2 <write>:
SYSCALL(write)
 2b2:	b8 10 00 00 00       	mov    $0x10,%eax
 2b7:	cd 40                	int    $0x40
 2b9:	c3                   	ret    

000002ba <close>:
SYSCALL(close)
 2ba:	b8 15 00 00 00       	mov    $0x15,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <kill>:
SYSCALL(kill)
 2c2:	b8 06 00 00 00       	mov    $0x6,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret    

000002ca <exec>:
SYSCALL(exec)
 2ca:	b8 07 00 00 00       	mov    $0x7,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <open>:
SYSCALL(open)
 2d2:	b8 0f 00 00 00       	mov    $0xf,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <mknod>:
SYSCALL(mknod)
 2da:	b8 11 00 00 00       	mov    $0x11,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <unlink>:
SYSCALL(unlink)
 2e2:	b8 12 00 00 00       	mov    $0x12,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <fstat>:
SYSCALL(fstat)
 2ea:	b8 08 00 00 00       	mov    $0x8,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <link>:
SYSCALL(link)
 2f2:	b8 13 00 00 00       	mov    $0x13,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <mkdir>:
SYSCALL(mkdir)
 2fa:	b8 14 00 00 00       	mov    $0x14,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <chdir>:
SYSCALL(chdir)
 302:	b8 09 00 00 00       	mov    $0x9,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <dup>:
SYSCALL(dup)
 30a:	b8 0a 00 00 00       	mov    $0xa,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <getpid>:
SYSCALL(getpid)
 312:	b8 0b 00 00 00       	mov    $0xb,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <sbrk>:
SYSCALL(sbrk)
 31a:	b8 0c 00 00 00       	mov    $0xc,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <sleep>:
SYSCALL(sleep)
 322:	b8 0d 00 00 00       	mov    $0xd,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <uptime>:
SYSCALL(uptime)
 32a:	b8 0e 00 00 00       	mov    $0xe,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <getprocs>:
SYSCALL(getprocs)
 332:	b8 16 00 00 00       	mov    $0x16,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    
 33a:	66 90                	xchg   %ax,%ax
 33c:	66 90                	xchg   %ax,%ax
 33e:	66 90                	xchg   %ax,%ax

00000340 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	57                   	push   %edi
 344:	89 c7                	mov    %eax,%edi
 346:	56                   	push   %esi
 347:	53                   	push   %ebx
 348:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 34b:	8b 45 08             	mov    0x8(%ebp),%eax
 34e:	85 c0                	test   %eax,%eax
 350:	74 76                	je     3c8 <printint+0x88>
 352:	89 d0                	mov    %edx,%eax
 354:	c1 e8 1f             	shr    $0x1f,%eax
 357:	84 c0                	test   %al,%al
 359:	74 6d                	je     3c8 <printint+0x88>
    neg = 1;
    x = -xx;
 35b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 35d:	bb 01 00 00 00       	mov    $0x1,%ebx
    x = -xx;
 362:	f7 d8                	neg    %eax
  } else {
    x = xx;
  }

  i = 0;
 364:	31 f6                	xor    %esi,%esi
 366:	eb 02                	jmp    36a <printint+0x2a>
  do{
    buf[i++] = digits[x % base];
 368:	89 d6                	mov    %edx,%esi
 36a:	31 d2                	xor    %edx,%edx
 36c:	f7 f1                	div    %ecx
 36e:	0f b6 92 49 07 00 00 	movzbl 0x749(%edx),%edx
  }while((x /= base) != 0);
 375:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 377:	88 54 35 d8          	mov    %dl,-0x28(%ebp,%esi,1)
 37b:	8d 56 01             	lea    0x1(%esi),%edx
  }while((x /= base) != 0);
 37e:	75 e8                	jne    368 <printint+0x28>
  if(neg)
 380:	85 db                	test   %ebx,%ebx
 382:	74 08                	je     38c <printint+0x4c>
    buf[i++] = '-';
 384:	c6 44 15 d8 2d       	movb   $0x2d,-0x28(%ebp,%edx,1)
 389:	8d 56 02             	lea    0x2(%esi),%edx

  while(--i >= 0)
 38c:	8d 5a ff             	lea    -0x1(%edx),%ebx
 38f:	83 fb ff             	cmp    $0xffffffff,%ebx
 392:	8d 75 d7             	lea    -0x29(%ebp),%esi
 395:	74 25                	je     3bc <printint+0x7c>
 397:	90                   	nop
 398:	0f b6 44 1d d8       	movzbl -0x28(%ebp,%ebx,1),%eax
 39d:	83 eb 01             	sub    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3a0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3a7:	00 
 3a8:	89 74 24 04          	mov    %esi,0x4(%esp)
 3ac:	89 3c 24             	mov    %edi,(%esp)
 3af:	88 45 d7             	mov    %al,-0x29(%ebp)
 3b2:	e8 fb fe ff ff       	call   2b2 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3b7:	83 fb ff             	cmp    $0xffffffff,%ebx
 3ba:	75 dc                	jne    398 <printint+0x58>
    putc(fd, buf[i]);
}
 3bc:	83 c4 3c             	add    $0x3c,%esp
 3bf:	5b                   	pop    %ebx
 3c0:	5e                   	pop    %esi
 3c1:	5f                   	pop    %edi
 3c2:	5d                   	pop    %ebp
 3c3:	c3                   	ret    
 3c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3c8:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3ca:	31 db                	xor    %ebx,%ebx
 3cc:	eb 96                	jmp    364 <printint+0x24>
 3ce:	66 90                	xchg   %ax,%ax

000003d0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 3d4:	31 ff                	xor    %edi,%edi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3d6:	56                   	push   %esi
 3d7:	53                   	push   %ebx
 3d8:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3db:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 3de:	8d 55 10             	lea    0x10(%ebp),%edx
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3e1:	8b 75 08             	mov    0x8(%ebp),%esi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 3e4:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 3e7:	0f be 03             	movsbl (%ebx),%eax
    putc(fd, buf[i]);
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
 3ea:	83 c3 01             	add    $0x1,%ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3ed:	84 c0                	test   %al,%al
 3ef:	75 39                	jne    42a <printf+0x5a>
 3f1:	e9 c2 00 00 00       	jmp    4b8 <printf+0xe8>
 3f6:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 3f8:	83 fa 25             	cmp    $0x25,%edx
 3fb:	0f 84 bf 00 00 00    	je     4c0 <printf+0xf0>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 401:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 404:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 40b:	00 
 40c:	89 44 24 04          	mov    %eax,0x4(%esp)
 410:	89 34 24             	mov    %esi,(%esp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 413:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 416:	e8 97 fe ff ff       	call   2b2 <write>
 41b:	83 c3 01             	add    $0x1,%ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 41e:	0f be 43 ff          	movsbl -0x1(%ebx),%eax
 422:	84 c0                	test   %al,%al
 424:	0f 84 8e 00 00 00    	je     4b8 <printf+0xe8>
    c = fmt[i] & 0xff;
 42a:	0f b6 d0             	movzbl %al,%edx
    if(state == 0){
 42d:	85 ff                	test   %edi,%edi
 42f:	74 c7                	je     3f8 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 431:	83 ff 25             	cmp    $0x25,%edi
 434:	75 e5                	jne    41b <printf+0x4b>
      if(c == 'd'){
 436:	83 fa 64             	cmp    $0x64,%edx
 439:	0f 84 31 01 00 00    	je     570 <printf+0x1a0>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 43f:	25 f7 00 00 00       	and    $0xf7,%eax
 444:	83 f8 70             	cmp    $0x70,%eax
 447:	0f 84 83 00 00 00    	je     4d0 <printf+0x100>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 44d:	83 fa 73             	cmp    $0x73,%edx
 450:	0f 84 a2 00 00 00    	je     4f8 <printf+0x128>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 456:	83 fa 63             	cmp    $0x63,%edx
 459:	0f 84 35 01 00 00    	je     594 <printf+0x1c4>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 45f:	83 fa 25             	cmp    $0x25,%edx
 462:	0f 84 e0 00 00 00    	je     548 <printf+0x178>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 468:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 46b:	83 c3 01             	add    $0x1,%ebx
 46e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 475:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 476:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 478:	89 44 24 04          	mov    %eax,0x4(%esp)
 47c:	89 34 24             	mov    %esi,(%esp)
 47f:	89 55 d0             	mov    %edx,-0x30(%ebp)
 482:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 486:	e8 27 fe ff ff       	call   2b2 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 48b:	8b 55 d0             	mov    -0x30(%ebp),%edx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 48e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 491:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 498:	00 
 499:	89 44 24 04          	mov    %eax,0x4(%esp)
 49d:	89 34 24             	mov    %esi,(%esp)
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 4a0:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4a3:	e8 0a fe ff ff       	call   2b2 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4a8:	0f be 43 ff          	movsbl -0x1(%ebx),%eax
 4ac:	84 c0                	test   %al,%al
 4ae:	0f 85 76 ff ff ff    	jne    42a <printf+0x5a>
 4b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 4b8:	83 c4 3c             	add    $0x3c,%esp
 4bb:	5b                   	pop    %ebx
 4bc:	5e                   	pop    %esi
 4bd:	5f                   	pop    %edi
 4be:	5d                   	pop    %ebp
 4bf:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 4c0:	bf 25 00 00 00       	mov    $0x25,%edi
 4c5:	e9 51 ff ff ff       	jmp    41b <printf+0x4b>
 4ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 4d0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 4d3:	b9 10 00 00 00       	mov    $0x10,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4d8:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 4da:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 4e1:	8b 10                	mov    (%eax),%edx
 4e3:	89 f0                	mov    %esi,%eax
 4e5:	e8 56 fe ff ff       	call   340 <printint>
        ap++;
 4ea:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 4ee:	e9 28 ff ff ff       	jmp    41b <printf+0x4b>
 4f3:	90                   	nop
 4f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 4f8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        ap++;
        if(s == 0)
          s = "(null)";
 4fb:	b8 42 07 00 00       	mov    $0x742,%eax
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 500:	8b 3a                	mov    (%edx),%edi
        ap++;
 502:	83 c2 04             	add    $0x4,%edx
 505:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
          s = "(null)";
 508:	85 ff                	test   %edi,%edi
 50a:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 50d:	0f b6 07             	movzbl (%edi),%eax
 510:	84 c0                	test   %al,%al
 512:	74 28                	je     53c <printf+0x16c>
 514:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 518:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 51b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 51e:	83 c7 01             	add    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 521:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 528:	00 
 529:	89 44 24 04          	mov    %eax,0x4(%esp)
 52d:	89 34 24             	mov    %esi,(%esp)
 530:	e8 7d fd ff ff       	call   2b2 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 535:	0f b6 07             	movzbl (%edi),%eax
 538:	84 c0                	test   %al,%al
 53a:	75 dc                	jne    518 <printf+0x148>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 53c:	31 ff                	xor    %edi,%edi
 53e:	e9 d8 fe ff ff       	jmp    41b <printf+0x4b>
 543:	90                   	nop
 544:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 548:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 54b:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 54d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 554:	00 
 555:	89 44 24 04          	mov    %eax,0x4(%esp)
 559:	89 34 24             	mov    %esi,(%esp)
 55c:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 560:	e8 4d fd ff ff       	call   2b2 <write>
 565:	e9 b1 fe ff ff       	jmp    41b <printf+0x4b>
 56a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 570:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 573:	b9 0a 00 00 00       	mov    $0xa,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 578:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 57b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 582:	8b 10                	mov    (%eax),%edx
 584:	89 f0                	mov    %esi,%eax
 586:	e8 b5 fd ff ff       	call   340 <printint>
        ap++;
 58b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 58f:	e9 87 fe ff ff       	jmp    41b <printf+0x4b>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 594:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 597:	31 ff                	xor    %edi,%edi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 599:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 59b:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5a2:	00 
 5a3:	89 34 24             	mov    %esi,(%esp)
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 5a6:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5a9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 5ac:	89 44 24 04          	mov    %eax,0x4(%esp)
 5b0:	e8 fd fc ff ff       	call   2b2 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 5b5:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 5b9:	e9 5d fe ff ff       	jmp    41b <printf+0x4b>
 5be:	66 90                	xchg   %ax,%ax

000005c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5c0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5c1:	a1 e0 09 00 00       	mov    0x9e0,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 5c6:	89 e5                	mov    %esp,%ebp
 5c8:	57                   	push   %edi
 5c9:	56                   	push   %esi
 5ca:	53                   	push   %ebx
 5cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5ce:	8b 08                	mov    (%eax),%ecx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5d0:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5d3:	39 d0                	cmp    %edx,%eax
 5d5:	72 11                	jb     5e8 <free+0x28>
 5d7:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5d8:	39 c8                	cmp    %ecx,%eax
 5da:	72 04                	jb     5e0 <free+0x20>
 5dc:	39 ca                	cmp    %ecx,%edx
 5de:	72 10                	jb     5f0 <free+0x30>
 5e0:	89 c8                	mov    %ecx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5e2:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5e4:	8b 08                	mov    (%eax),%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5e6:	73 f0                	jae    5d8 <free+0x18>
 5e8:	39 ca                	cmp    %ecx,%edx
 5ea:	72 04                	jb     5f0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5ec:	39 c8                	cmp    %ecx,%eax
 5ee:	72 f0                	jb     5e0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 5f0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5f3:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 5f6:	39 cf                	cmp    %ecx,%edi
 5f8:	74 1e                	je     618 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 5fa:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5fd:	8b 48 04             	mov    0x4(%eax),%ecx
 600:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 603:	39 f2                	cmp    %esi,%edx
 605:	74 28                	je     62f <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 607:	89 10                	mov    %edx,(%eax)
  freep = p;
 609:	a3 e0 09 00 00       	mov    %eax,0x9e0
}
 60e:	5b                   	pop    %ebx
 60f:	5e                   	pop    %esi
 610:	5f                   	pop    %edi
 611:	5d                   	pop    %ebp
 612:	c3                   	ret    
 613:	90                   	nop
 614:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 618:	03 71 04             	add    0x4(%ecx),%esi
 61b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 61e:	8b 08                	mov    (%eax),%ecx
 620:	8b 09                	mov    (%ecx),%ecx
 622:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 625:	8b 48 04             	mov    0x4(%eax),%ecx
 628:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 62b:	39 f2                	cmp    %esi,%edx
 62d:	75 d8                	jne    607 <free+0x47>
    p->s.size += bp->s.size;
 62f:	03 4b fc             	add    -0x4(%ebx),%ecx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 632:	a3 e0 09 00 00       	mov    %eax,0x9e0
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 637:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 63a:	8b 53 f8             	mov    -0x8(%ebx),%edx
 63d:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 63f:	5b                   	pop    %ebx
 640:	5e                   	pop    %esi
 641:	5f                   	pop    %edi
 642:	5d                   	pop    %ebp
 643:	c3                   	ret    
 644:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 64a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000650 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 650:	55                   	push   %ebp
 651:	89 e5                	mov    %esp,%ebp
 653:	57                   	push   %edi
 654:	56                   	push   %esi
 655:	53                   	push   %ebx
 656:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 659:	8b 55 08             	mov    0x8(%ebp),%edx
  if((prevp = freep) == 0){
 65c:	8b 0d e0 09 00 00    	mov    0x9e0,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 662:	83 c2 07             	add    $0x7,%edx
 665:	c1 ea 03             	shr    $0x3,%edx
  if((prevp = freep) == 0){
 668:	85 c9                	test   %ecx,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 66a:	8d 5a 01             	lea    0x1(%edx),%ebx
  if((prevp = freep) == 0){
 66d:	0f 84 93 00 00 00    	je     706 <malloc+0xb6>
 673:	8b 01                	mov    (%ecx),%eax
 675:	8b 78 04             	mov    0x4(%eax),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 678:	39 fb                	cmp    %edi,%ebx
 67a:	76 64                	jbe    6e0 <malloc+0x90>
 67c:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 683:	eb 0c                	jmp    691 <malloc+0x41>
 685:	8d 76 00             	lea    0x0(%esi),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 688:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 68a:	8b 78 04             	mov    0x4(%eax),%edi
 68d:	39 fb                	cmp    %edi,%ebx
 68f:	76 4f                	jbe    6e0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 691:	3b 05 e0 09 00 00    	cmp    0x9e0,%eax
 697:	89 c1                	mov    %eax,%ecx
 699:	75 ed                	jne    688 <malloc+0x38>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 69b:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 6a1:	b8 00 80 00 00       	mov    $0x8000,%eax
 6a6:	0f 43 c6             	cmovae %esi,%eax
 6a9:	bf 00 10 00 00       	mov    $0x1000,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 6ae:	89 04 24             	mov    %eax,(%esp)
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 6b1:	0f 43 fb             	cmovae %ebx,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 6b4:	e8 61 fc ff ff       	call   31a <sbrk>
  if(p == (char*)-1)
 6b9:	83 f8 ff             	cmp    $0xffffffff,%eax
 6bc:	74 18                	je     6d6 <malloc+0x86>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 6be:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 6c1:	83 c0 08             	add    $0x8,%eax
 6c4:	89 04 24             	mov    %eax,(%esp)
 6c7:	e8 f4 fe ff ff       	call   5c0 <free>
  return freep;
 6cc:	8b 0d e0 09 00 00    	mov    0x9e0,%ecx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 6d2:	85 c9                	test   %ecx,%ecx
 6d4:	75 b2                	jne    688 <malloc+0x38>
        return 0;
 6d6:	31 c0                	xor    %eax,%eax
 6d8:	eb 1e                	jmp    6f8 <malloc+0xa8>
 6da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 6e0:	39 fb                	cmp    %edi,%ebx
 6e2:	74 1c                	je     700 <malloc+0xb0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 6e4:	29 df                	sub    %ebx,%edi
 6e6:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 6e9:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 6ec:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 6ef:	89 0d e0 09 00 00    	mov    %ecx,0x9e0
      return (void*)(p + 1);
 6f5:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 6f8:	83 c4 1c             	add    $0x1c,%esp
 6fb:	5b                   	pop    %ebx
 6fc:	5e                   	pop    %esi
 6fd:	5f                   	pop    %edi
 6fe:	5d                   	pop    %ebp
 6ff:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 700:	8b 10                	mov    (%eax),%edx
 702:	89 11                	mov    %edx,(%ecx)
 704:	eb e9                	jmp    6ef <malloc+0x9f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 706:	c7 05 e0 09 00 00 e4 	movl   $0x9e4,0x9e0
 70d:	09 00 00 
    base.s.size = 0;
 710:	b8 e4 09 00 00       	mov    $0x9e4,%eax
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 715:	c7 05 e4 09 00 00 e4 	movl   $0x9e4,0x9e4
 71c:	09 00 00 
    base.s.size = 0;
 71f:	c7 05 e8 09 00 00 00 	movl   $0x0,0x9e8
 726:	00 00 00 
 729:	e9 4e ff ff ff       	jmp    67c <malloc+0x2c>
