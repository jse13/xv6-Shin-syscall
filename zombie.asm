
_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp
  if(fork() > 0)
   9:	e8 4c 02 00 00       	call   25a <fork>
   e:	85 c0                	test   %eax,%eax
  10:	7e 0c                	jle    1e <main+0x1e>
    sleep(5);  // Let child exit before parent.
  12:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
  19:	e8 d4 02 00 00       	call   2f2 <sleep>
  exit();
  1e:	e8 3f 02 00 00       	call   262 <exit>
  23:	66 90                	xchg   %ax,%ax
  25:	66 90                	xchg   %ax,%ax
  27:	66 90                	xchg   %ax,%ax
  29:	66 90                	xchg   %ax,%ax
  2b:	66 90                	xchg   %ax,%ax
  2d:	66 90                	xchg   %ax,%ax
  2f:	90                   	nop

00000030 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  30:	55                   	push   %ebp
  31:	89 e5                	mov    %esp,%ebp
  33:	8b 45 08             	mov    0x8(%ebp),%eax
  36:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  39:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  3a:	89 c2                	mov    %eax,%edx
  3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  40:	0f b6 19             	movzbl (%ecx),%ebx
  43:	83 c1 01             	add    $0x1,%ecx
  46:	88 1a                	mov    %bl,(%edx)
  48:	83 c2 01             	add    $0x1,%edx
  4b:	84 db                	test   %bl,%bl
  4d:	75 f1                	jne    40 <strcpy+0x10>
    ;
  return os;
}
  4f:	5b                   	pop    %ebx
  50:	5d                   	pop    %ebp
  51:	c3                   	ret    
  52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000060 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	8b 55 08             	mov    0x8(%ebp),%edx
  66:	56                   	push   %esi
  67:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  6a:	53                   	push   %ebx
  while(*p && *p == *q)
  6b:	0f b6 02             	movzbl (%edx),%eax
  6e:	0f b6 19             	movzbl (%ecx),%ebx
  71:	84 c0                	test   %al,%al
  73:	75 16                	jne    8b <strcmp+0x2b>
  75:	eb 21                	jmp    98 <strcmp+0x38>
  77:	90                   	nop
    p++, q++;
  78:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  7b:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  7f:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  82:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  85:	84 c0                	test   %al,%al
  87:	74 0f                	je     98 <strcmp+0x38>
    p++, q++;
  89:	89 f1                	mov    %esi,%ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  8b:	38 d8                	cmp    %bl,%al
  8d:	74 e9                	je     78 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  8f:	29 d8                	sub    %ebx,%eax
}
  91:	5b                   	pop    %ebx
  92:	5e                   	pop    %esi
  93:	5d                   	pop    %ebp
  94:	c3                   	ret    
  95:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  98:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
  9a:	29 d8                	sub    %ebx,%eax
}
  9c:	5b                   	pop    %ebx
  9d:	5e                   	pop    %esi
  9e:	5d                   	pop    %ebp
  9f:	c3                   	ret    

000000a0 <strlen>:

uint
strlen(char *s)
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  a6:	80 39 00             	cmpb   $0x0,(%ecx)
  a9:	74 12                	je     bd <strlen+0x1d>
  ab:	31 d2                	xor    %edx,%edx
  ad:	8d 76 00             	lea    0x0(%esi),%esi
  b0:	83 c2 01             	add    $0x1,%edx
  b3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  b7:	89 d0                	mov    %edx,%eax
  b9:	75 f5                	jne    b0 <strlen+0x10>
    ;
  return n;
}
  bb:	5d                   	pop    %ebp
  bc:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
  bd:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
  bf:	5d                   	pop    %ebp
  c0:	c3                   	ret    
  c1:	eb 0d                	jmp    d0 <memset>
  c3:	90                   	nop
  c4:	90                   	nop
  c5:	90                   	nop
  c6:	90                   	nop
  c7:	90                   	nop
  c8:	90                   	nop
  c9:	90                   	nop
  ca:	90                   	nop
  cb:	90                   	nop
  cc:	90                   	nop
  cd:	90                   	nop
  ce:	90                   	nop
  cf:	90                   	nop

000000d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	8b 55 08             	mov    0x8(%ebp),%edx
  d6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  da:	8b 45 0c             	mov    0xc(%ebp),%eax
  dd:	89 d7                	mov    %edx,%edi
  df:	fc                   	cld    
  e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  e2:	89 d0                	mov    %edx,%eax
  e4:	5f                   	pop    %edi
  e5:	5d                   	pop    %ebp
  e6:	c3                   	ret    
  e7:	89 f6                	mov    %esi,%esi
  e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000f0 <strchr>:

char*
strchr(const char *s, char c)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	8b 45 08             	mov    0x8(%ebp),%eax
  f6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
  fa:	0f b6 10             	movzbl (%eax),%edx
  fd:	84 d2                	test   %dl,%dl
  ff:	75 11                	jne    112 <strchr+0x22>
 101:	eb 15                	jmp    118 <strchr+0x28>
 103:	90                   	nop
 104:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 108:	83 c0 01             	add    $0x1,%eax
 10b:	0f b6 10             	movzbl (%eax),%edx
 10e:	84 d2                	test   %dl,%dl
 110:	74 06                	je     118 <strchr+0x28>
    if(*s == c)
 112:	38 ca                	cmp    %cl,%dl
 114:	75 f2                	jne    108 <strchr+0x18>
      return (char*)s;
  return 0;
}
 116:	5d                   	pop    %ebp
 117:	c3                   	ret    
strchr(const char *s, char c)
{
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
 118:	31 c0                	xor    %eax,%eax
}
 11a:	5d                   	pop    %ebp
 11b:	90                   	nop
 11c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 120:	c3                   	ret    
 121:	eb 0d                	jmp    130 <gets>
 123:	90                   	nop
 124:	90                   	nop
 125:	90                   	nop
 126:	90                   	nop
 127:	90                   	nop
 128:	90                   	nop
 129:	90                   	nop
 12a:	90                   	nop
 12b:	90                   	nop
 12c:	90                   	nop
 12d:	90                   	nop
 12e:	90                   	nop
 12f:	90                   	nop

00000130 <gets>:

char*
gets(char *buf, int max)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	57                   	push   %edi
 134:	56                   	push   %esi
 135:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 136:	31 db                	xor    %ebx,%ebx
  return 0;
}

char*
gets(char *buf, int max)
{
 138:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 13b:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 13e:	8d 73 01             	lea    0x1(%ebx),%esi
 141:	3b 75 0c             	cmp    0xc(%ebp),%esi
 144:	7d 42                	jge    188 <gets+0x58>
    cc = read(0, &c, 1);
 146:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 14d:	00 
 14e:	89 7c 24 04          	mov    %edi,0x4(%esp)
 152:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 159:	e8 1c 01 00 00       	call   27a <read>
    if(cc < 1)
 15e:	85 c0                	test   %eax,%eax
 160:	7e 26                	jle    188 <gets+0x58>
      break;
    buf[i++] = c;
 162:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 166:	89 f3                	mov    %esi,%ebx
 168:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 16b:	3c 0d                	cmp    $0xd,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 16d:	88 44 32 ff          	mov    %al,-0x1(%edx,%esi,1)
    if(c == '\n' || c == '\r')
 171:	74 04                	je     177 <gets+0x47>
 173:	3c 0a                	cmp    $0xa,%al
 175:	75 c7                	jne    13e <gets+0xe>
      break;
  }
  buf[i] = '\0';
 177:	8b 45 08             	mov    0x8(%ebp),%eax
 17a:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 17e:	83 c4 2c             	add    $0x2c,%esp
 181:	5b                   	pop    %ebx
 182:	5e                   	pop    %esi
 183:	5f                   	pop    %edi
 184:	5d                   	pop    %ebp
 185:	c3                   	ret    
 186:	66 90                	xchg   %ax,%ax
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 188:	8b 45 08             	mov    0x8(%ebp),%eax
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
 18b:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 18d:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 191:	83 c4 2c             	add    $0x2c,%esp
 194:	5b                   	pop    %ebx
 195:	5e                   	pop    %esi
 196:	5f                   	pop    %edi
 197:	5d                   	pop    %ebp
 198:	c3                   	ret    
 199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001a0 <stat>:

int
stat(char *n, struct stat *st)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1a6:	8b 45 08             	mov    0x8(%ebp),%eax
 1a9:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1b0:	00 
  return buf;
}

int
stat(char *n, struct stat *st)
{
 1b1:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 1b4:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1b7:	89 04 24             	mov    %eax,(%esp)
 1ba:	e8 e3 00 00 00       	call   2a2 <open>
  if(fd < 0)
 1bf:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1c1:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 1c3:	78 2b                	js     1f0 <stat+0x50>
    return -1;
  r = fstat(fd, st);
 1c5:	8b 45 0c             	mov    0xc(%ebp),%eax
 1c8:	89 1c 24             	mov    %ebx,(%esp)
 1cb:	89 44 24 04          	mov    %eax,0x4(%esp)
 1cf:	e8 e6 00 00 00       	call   2ba <fstat>
  close(fd);
 1d4:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 1d7:	89 c6                	mov    %eax,%esi
  close(fd);
 1d9:	e8 ac 00 00 00       	call   28a <close>
  return r;
}
 1de:	89 f0                	mov    %esi,%eax
 1e0:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 1e3:	8b 75 fc             	mov    -0x4(%ebp),%esi
 1e6:	89 ec                	mov    %ebp,%esp
 1e8:	5d                   	pop    %ebp
 1e9:	c3                   	ret    
 1ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 1f0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1f5:	eb e7                	jmp    1de <stat+0x3e>
 1f7:	89 f6                	mov    %esi,%esi
 1f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000200 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	8b 4d 08             	mov    0x8(%ebp),%ecx
 206:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 207:	0f be 11             	movsbl (%ecx),%edx
 20a:	8d 42 d0             	lea    -0x30(%edx),%eax
 20d:	3c 09                	cmp    $0x9,%al
 20f:	b8 00 00 00 00       	mov    $0x0,%eax
 214:	77 17                	ja     22d <atoi+0x2d>
 216:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 218:	83 c1 01             	add    $0x1,%ecx
 21b:	8d 04 80             	lea    (%eax,%eax,4),%eax
 21e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 222:	0f be 11             	movsbl (%ecx),%edx
 225:	8d 5a d0             	lea    -0x30(%edx),%ebx
 228:	80 fb 09             	cmp    $0x9,%bl
 22b:	76 eb                	jbe    218 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 22d:	5b                   	pop    %ebx
 22e:	5d                   	pop    %ebp
 22f:	c3                   	ret    

00000230 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 230:	55                   	push   %ebp
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
 231:	31 d2                	xor    %edx,%edx
{
 233:	89 e5                	mov    %esp,%ebp
 235:	56                   	push   %esi
 236:	8b 45 08             	mov    0x8(%ebp),%eax
 239:	53                   	push   %ebx
 23a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 23d:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 240:	85 db                	test   %ebx,%ebx
 242:	7e 12                	jle    256 <memmove+0x26>
 244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 248:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 24c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 24f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 252:	39 da                	cmp    %ebx,%edx
 254:	75 f2                	jne    248 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 256:	5b                   	pop    %ebx
 257:	5e                   	pop    %esi
 258:	5d                   	pop    %ebp
 259:	c3                   	ret    

0000025a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 25a:	b8 01 00 00 00       	mov    $0x1,%eax
 25f:	cd 40                	int    $0x40
 261:	c3                   	ret    

00000262 <exit>:
SYSCALL(exit)
 262:	b8 02 00 00 00       	mov    $0x2,%eax
 267:	cd 40                	int    $0x40
 269:	c3                   	ret    

0000026a <wait>:
SYSCALL(wait)
 26a:	b8 03 00 00 00       	mov    $0x3,%eax
 26f:	cd 40                	int    $0x40
 271:	c3                   	ret    

00000272 <pipe>:
SYSCALL(pipe)
 272:	b8 04 00 00 00       	mov    $0x4,%eax
 277:	cd 40                	int    $0x40
 279:	c3                   	ret    

0000027a <read>:
SYSCALL(read)
 27a:	b8 05 00 00 00       	mov    $0x5,%eax
 27f:	cd 40                	int    $0x40
 281:	c3                   	ret    

00000282 <write>:
SYSCALL(write)
 282:	b8 10 00 00 00       	mov    $0x10,%eax
 287:	cd 40                	int    $0x40
 289:	c3                   	ret    

0000028a <close>:
SYSCALL(close)
 28a:	b8 15 00 00 00       	mov    $0x15,%eax
 28f:	cd 40                	int    $0x40
 291:	c3                   	ret    

00000292 <kill>:
SYSCALL(kill)
 292:	b8 06 00 00 00       	mov    $0x6,%eax
 297:	cd 40                	int    $0x40
 299:	c3                   	ret    

0000029a <exec>:
SYSCALL(exec)
 29a:	b8 07 00 00 00       	mov    $0x7,%eax
 29f:	cd 40                	int    $0x40
 2a1:	c3                   	ret    

000002a2 <open>:
SYSCALL(open)
 2a2:	b8 0f 00 00 00       	mov    $0xf,%eax
 2a7:	cd 40                	int    $0x40
 2a9:	c3                   	ret    

000002aa <mknod>:
SYSCALL(mknod)
 2aa:	b8 11 00 00 00       	mov    $0x11,%eax
 2af:	cd 40                	int    $0x40
 2b1:	c3                   	ret    

000002b2 <unlink>:
SYSCALL(unlink)
 2b2:	b8 12 00 00 00       	mov    $0x12,%eax
 2b7:	cd 40                	int    $0x40
 2b9:	c3                   	ret    

000002ba <fstat>:
SYSCALL(fstat)
 2ba:	b8 08 00 00 00       	mov    $0x8,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <link>:
SYSCALL(link)
 2c2:	b8 13 00 00 00       	mov    $0x13,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret    

000002ca <mkdir>:
SYSCALL(mkdir)
 2ca:	b8 14 00 00 00       	mov    $0x14,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <chdir>:
SYSCALL(chdir)
 2d2:	b8 09 00 00 00       	mov    $0x9,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <dup>:
SYSCALL(dup)
 2da:	b8 0a 00 00 00       	mov    $0xa,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <getpid>:
SYSCALL(getpid)
 2e2:	b8 0b 00 00 00       	mov    $0xb,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <sbrk>:
SYSCALL(sbrk)
 2ea:	b8 0c 00 00 00       	mov    $0xc,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <sleep>:
SYSCALL(sleep)
 2f2:	b8 0d 00 00 00       	mov    $0xd,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <uptime>:
SYSCALL(uptime)
 2fa:	b8 0e 00 00 00       	mov    $0xe,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <getprocs>:
SYSCALL(getprocs)
 302:	b8 16 00 00 00       	mov    $0x16,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    
 30a:	66 90                	xchg   %ax,%ax
 30c:	66 90                	xchg   %ax,%ax
 30e:	66 90                	xchg   %ax,%ax

00000310 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	57                   	push   %edi
 314:	89 c7                	mov    %eax,%edi
 316:	56                   	push   %esi
 317:	53                   	push   %ebx
 318:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 31b:	8b 45 08             	mov    0x8(%ebp),%eax
 31e:	85 c0                	test   %eax,%eax
 320:	74 76                	je     398 <printint+0x88>
 322:	89 d0                	mov    %edx,%eax
 324:	c1 e8 1f             	shr    $0x1f,%eax
 327:	84 c0                	test   %al,%al
 329:	74 6d                	je     398 <printint+0x88>
    neg = 1;
    x = -xx;
 32b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 32d:	bb 01 00 00 00       	mov    $0x1,%ebx
    x = -xx;
 332:	f7 d8                	neg    %eax
  } else {
    x = xx;
  }

  i = 0;
 334:	31 f6                	xor    %esi,%esi
 336:	eb 02                	jmp    33a <printint+0x2a>
  do{
    buf[i++] = digits[x % base];
 338:	89 d6                	mov    %edx,%esi
 33a:	31 d2                	xor    %edx,%edx
 33c:	f7 f1                	div    %ecx
 33e:	0f b6 92 05 07 00 00 	movzbl 0x705(%edx),%edx
  }while((x /= base) != 0);
 345:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 347:	88 54 35 d8          	mov    %dl,-0x28(%ebp,%esi,1)
 34b:	8d 56 01             	lea    0x1(%esi),%edx
  }while((x /= base) != 0);
 34e:	75 e8                	jne    338 <printint+0x28>
  if(neg)
 350:	85 db                	test   %ebx,%ebx
 352:	74 08                	je     35c <printint+0x4c>
    buf[i++] = '-';
 354:	c6 44 15 d8 2d       	movb   $0x2d,-0x28(%ebp,%edx,1)
 359:	8d 56 02             	lea    0x2(%esi),%edx

  while(--i >= 0)
 35c:	8d 5a ff             	lea    -0x1(%edx),%ebx
 35f:	83 fb ff             	cmp    $0xffffffff,%ebx
 362:	8d 75 d7             	lea    -0x29(%ebp),%esi
 365:	74 25                	je     38c <printint+0x7c>
 367:	90                   	nop
 368:	0f b6 44 1d d8       	movzbl -0x28(%ebp,%ebx,1),%eax
 36d:	83 eb 01             	sub    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 370:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 377:	00 
 378:	89 74 24 04          	mov    %esi,0x4(%esp)
 37c:	89 3c 24             	mov    %edi,(%esp)
 37f:	88 45 d7             	mov    %al,-0x29(%ebp)
 382:	e8 fb fe ff ff       	call   282 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 387:	83 fb ff             	cmp    $0xffffffff,%ebx
 38a:	75 dc                	jne    368 <printint+0x58>
    putc(fd, buf[i]);
}
 38c:	83 c4 3c             	add    $0x3c,%esp
 38f:	5b                   	pop    %ebx
 390:	5e                   	pop    %esi
 391:	5f                   	pop    %edi
 392:	5d                   	pop    %ebp
 393:	c3                   	ret    
 394:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 398:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 39a:	31 db                	xor    %ebx,%ebx
 39c:	eb 96                	jmp    334 <printint+0x24>
 39e:	66 90                	xchg   %ax,%ax

000003a0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 3a4:	31 ff                	xor    %edi,%edi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3a6:	56                   	push   %esi
 3a7:	53                   	push   %ebx
 3a8:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3ab:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 3ae:	8d 55 10             	lea    0x10(%ebp),%edx
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3b1:	8b 75 08             	mov    0x8(%ebp),%esi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 3b4:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 3b7:	0f be 03             	movsbl (%ebx),%eax
    putc(fd, buf[i]);
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
 3ba:	83 c3 01             	add    $0x1,%ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3bd:	84 c0                	test   %al,%al
 3bf:	75 39                	jne    3fa <printf+0x5a>
 3c1:	e9 c2 00 00 00       	jmp    488 <printf+0xe8>
 3c6:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 3c8:	83 fa 25             	cmp    $0x25,%edx
 3cb:	0f 84 bf 00 00 00    	je     490 <printf+0xf0>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3d1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 3d4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3db:	00 
 3dc:	89 44 24 04          	mov    %eax,0x4(%esp)
 3e0:	89 34 24             	mov    %esi,(%esp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 3e3:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3e6:	e8 97 fe ff ff       	call   282 <write>
 3eb:	83 c3 01             	add    $0x1,%ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3ee:	0f be 43 ff          	movsbl -0x1(%ebx),%eax
 3f2:	84 c0                	test   %al,%al
 3f4:	0f 84 8e 00 00 00    	je     488 <printf+0xe8>
    c = fmt[i] & 0xff;
 3fa:	0f b6 d0             	movzbl %al,%edx
    if(state == 0){
 3fd:	85 ff                	test   %edi,%edi
 3ff:	74 c7                	je     3c8 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 401:	83 ff 25             	cmp    $0x25,%edi
 404:	75 e5                	jne    3eb <printf+0x4b>
      if(c == 'd'){
 406:	83 fa 64             	cmp    $0x64,%edx
 409:	0f 84 31 01 00 00    	je     540 <printf+0x1a0>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 40f:	25 f7 00 00 00       	and    $0xf7,%eax
 414:	83 f8 70             	cmp    $0x70,%eax
 417:	0f 84 83 00 00 00    	je     4a0 <printf+0x100>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 41d:	83 fa 73             	cmp    $0x73,%edx
 420:	0f 84 a2 00 00 00    	je     4c8 <printf+0x128>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 426:	83 fa 63             	cmp    $0x63,%edx
 429:	0f 84 35 01 00 00    	je     564 <printf+0x1c4>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 42f:	83 fa 25             	cmp    $0x25,%edx
 432:	0f 84 e0 00 00 00    	je     518 <printf+0x178>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 438:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 43b:	83 c3 01             	add    $0x1,%ebx
 43e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 445:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 446:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 448:	89 44 24 04          	mov    %eax,0x4(%esp)
 44c:	89 34 24             	mov    %esi,(%esp)
 44f:	89 55 d0             	mov    %edx,-0x30(%ebp)
 452:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 456:	e8 27 fe ff ff       	call   282 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 45b:	8b 55 d0             	mov    -0x30(%ebp),%edx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 45e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 461:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 468:	00 
 469:	89 44 24 04          	mov    %eax,0x4(%esp)
 46d:	89 34 24             	mov    %esi,(%esp)
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 470:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 473:	e8 0a fe ff ff       	call   282 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 478:	0f be 43 ff          	movsbl -0x1(%ebx),%eax
 47c:	84 c0                	test   %al,%al
 47e:	0f 85 76 ff ff ff    	jne    3fa <printf+0x5a>
 484:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 488:	83 c4 3c             	add    $0x3c,%esp
 48b:	5b                   	pop    %ebx
 48c:	5e                   	pop    %esi
 48d:	5f                   	pop    %edi
 48e:	5d                   	pop    %ebp
 48f:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 490:	bf 25 00 00 00       	mov    $0x25,%edi
 495:	e9 51 ff ff ff       	jmp    3eb <printf+0x4b>
 49a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 4a0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 4a3:	b9 10 00 00 00       	mov    $0x10,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4a8:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 4aa:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 4b1:	8b 10                	mov    (%eax),%edx
 4b3:	89 f0                	mov    %esi,%eax
 4b5:	e8 56 fe ff ff       	call   310 <printint>
        ap++;
 4ba:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 4be:	e9 28 ff ff ff       	jmp    3eb <printf+0x4b>
 4c3:	90                   	nop
 4c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 4c8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        ap++;
        if(s == 0)
          s = "(null)";
 4cb:	b8 fe 06 00 00       	mov    $0x6fe,%eax
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 4d0:	8b 3a                	mov    (%edx),%edi
        ap++;
 4d2:	83 c2 04             	add    $0x4,%edx
 4d5:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
          s = "(null)";
 4d8:	85 ff                	test   %edi,%edi
 4da:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 4dd:	0f b6 07             	movzbl (%edi),%eax
 4e0:	84 c0                	test   %al,%al
 4e2:	74 28                	je     50c <printf+0x16c>
 4e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4e8:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4eb:	8d 45 e3             	lea    -0x1d(%ebp),%eax
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 4ee:	83 c7 01             	add    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4f1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4f8:	00 
 4f9:	89 44 24 04          	mov    %eax,0x4(%esp)
 4fd:	89 34 24             	mov    %esi,(%esp)
 500:	e8 7d fd ff ff       	call   282 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 505:	0f b6 07             	movzbl (%edi),%eax
 508:	84 c0                	test   %al,%al
 50a:	75 dc                	jne    4e8 <printf+0x148>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 50c:	31 ff                	xor    %edi,%edi
 50e:	e9 d8 fe ff ff       	jmp    3eb <printf+0x4b>
 513:	90                   	nop
 514:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 518:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 51b:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 51d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 524:	00 
 525:	89 44 24 04          	mov    %eax,0x4(%esp)
 529:	89 34 24             	mov    %esi,(%esp)
 52c:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 530:	e8 4d fd ff ff       	call   282 <write>
 535:	e9 b1 fe ff ff       	jmp    3eb <printf+0x4b>
 53a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 540:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 543:	b9 0a 00 00 00       	mov    $0xa,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 548:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 54b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 552:	8b 10                	mov    (%eax),%edx
 554:	89 f0                	mov    %esi,%eax
 556:	e8 b5 fd ff ff       	call   310 <printint>
        ap++;
 55b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 55f:	e9 87 fe ff ff       	jmp    3eb <printf+0x4b>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 564:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 567:	31 ff                	xor    %edi,%edi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 569:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 56b:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 572:	00 
 573:	89 34 24             	mov    %esi,(%esp)
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 576:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 579:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 57c:	89 44 24 04          	mov    %eax,0x4(%esp)
 580:	e8 fd fc ff ff       	call   282 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 585:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 589:	e9 5d fe ff ff       	jmp    3eb <printf+0x4b>
 58e:	66 90                	xchg   %ax,%ax

00000590 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 590:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 591:	a1 98 09 00 00       	mov    0x998,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 596:	89 e5                	mov    %esp,%ebp
 598:	57                   	push   %edi
 599:	56                   	push   %esi
 59a:	53                   	push   %ebx
 59b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 59e:	8b 08                	mov    (%eax),%ecx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5a0:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5a3:	39 d0                	cmp    %edx,%eax
 5a5:	72 11                	jb     5b8 <free+0x28>
 5a7:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5a8:	39 c8                	cmp    %ecx,%eax
 5aa:	72 04                	jb     5b0 <free+0x20>
 5ac:	39 ca                	cmp    %ecx,%edx
 5ae:	72 10                	jb     5c0 <free+0x30>
 5b0:	89 c8                	mov    %ecx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5b2:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5b4:	8b 08                	mov    (%eax),%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5b6:	73 f0                	jae    5a8 <free+0x18>
 5b8:	39 ca                	cmp    %ecx,%edx
 5ba:	72 04                	jb     5c0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5bc:	39 c8                	cmp    %ecx,%eax
 5be:	72 f0                	jb     5b0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 5c0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5c3:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 5c6:	39 cf                	cmp    %ecx,%edi
 5c8:	74 1e                	je     5e8 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 5ca:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5cd:	8b 48 04             	mov    0x4(%eax),%ecx
 5d0:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 5d3:	39 f2                	cmp    %esi,%edx
 5d5:	74 28                	je     5ff <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 5d7:	89 10                	mov    %edx,(%eax)
  freep = p;
 5d9:	a3 98 09 00 00       	mov    %eax,0x998
}
 5de:	5b                   	pop    %ebx
 5df:	5e                   	pop    %esi
 5e0:	5f                   	pop    %edi
 5e1:	5d                   	pop    %ebp
 5e2:	c3                   	ret    
 5e3:	90                   	nop
 5e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 5e8:	03 71 04             	add    0x4(%ecx),%esi
 5eb:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 5ee:	8b 08                	mov    (%eax),%ecx
 5f0:	8b 09                	mov    (%ecx),%ecx
 5f2:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 5f5:	8b 48 04             	mov    0x4(%eax),%ecx
 5f8:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 5fb:	39 f2                	cmp    %esi,%edx
 5fd:	75 d8                	jne    5d7 <free+0x47>
    p->s.size += bp->s.size;
 5ff:	03 4b fc             	add    -0x4(%ebx),%ecx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 602:	a3 98 09 00 00       	mov    %eax,0x998
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 607:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 60a:	8b 53 f8             	mov    -0x8(%ebx),%edx
 60d:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 60f:	5b                   	pop    %ebx
 610:	5e                   	pop    %esi
 611:	5f                   	pop    %edi
 612:	5d                   	pop    %ebp
 613:	c3                   	ret    
 614:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 61a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000620 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 620:	55                   	push   %ebp
 621:	89 e5                	mov    %esp,%ebp
 623:	57                   	push   %edi
 624:	56                   	push   %esi
 625:	53                   	push   %ebx
 626:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 629:	8b 55 08             	mov    0x8(%ebp),%edx
  if((prevp = freep) == 0){
 62c:	8b 0d 98 09 00 00    	mov    0x998,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 632:	83 c2 07             	add    $0x7,%edx
 635:	c1 ea 03             	shr    $0x3,%edx
  if((prevp = freep) == 0){
 638:	85 c9                	test   %ecx,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 63a:	8d 5a 01             	lea    0x1(%edx),%ebx
  if((prevp = freep) == 0){
 63d:	0f 84 93 00 00 00    	je     6d6 <malloc+0xb6>
 643:	8b 01                	mov    (%ecx),%eax
 645:	8b 78 04             	mov    0x4(%eax),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 648:	39 fb                	cmp    %edi,%ebx
 64a:	76 64                	jbe    6b0 <malloc+0x90>
 64c:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 653:	eb 0c                	jmp    661 <malloc+0x41>
 655:	8d 76 00             	lea    0x0(%esi),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 658:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 65a:	8b 78 04             	mov    0x4(%eax),%edi
 65d:	39 fb                	cmp    %edi,%ebx
 65f:	76 4f                	jbe    6b0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 661:	3b 05 98 09 00 00    	cmp    0x998,%eax
 667:	89 c1                	mov    %eax,%ecx
 669:	75 ed                	jne    658 <malloc+0x38>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 66b:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 671:	b8 00 80 00 00       	mov    $0x8000,%eax
 676:	0f 43 c6             	cmovae %esi,%eax
 679:	bf 00 10 00 00       	mov    $0x1000,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 67e:	89 04 24             	mov    %eax,(%esp)
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 681:	0f 43 fb             	cmovae %ebx,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 684:	e8 61 fc ff ff       	call   2ea <sbrk>
  if(p == (char*)-1)
 689:	83 f8 ff             	cmp    $0xffffffff,%eax
 68c:	74 18                	je     6a6 <malloc+0x86>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 68e:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 691:	83 c0 08             	add    $0x8,%eax
 694:	89 04 24             	mov    %eax,(%esp)
 697:	e8 f4 fe ff ff       	call   590 <free>
  return freep;
 69c:	8b 0d 98 09 00 00    	mov    0x998,%ecx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 6a2:	85 c9                	test   %ecx,%ecx
 6a4:	75 b2                	jne    658 <malloc+0x38>
        return 0;
 6a6:	31 c0                	xor    %eax,%eax
 6a8:	eb 1e                	jmp    6c8 <malloc+0xa8>
 6aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 6b0:	39 fb                	cmp    %edi,%ebx
 6b2:	74 1c                	je     6d0 <malloc+0xb0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 6b4:	29 df                	sub    %ebx,%edi
 6b6:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 6b9:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 6bc:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 6bf:	89 0d 98 09 00 00    	mov    %ecx,0x998
      return (void*)(p + 1);
 6c5:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 6c8:	83 c4 1c             	add    $0x1c,%esp
 6cb:	5b                   	pop    %ebx
 6cc:	5e                   	pop    %esi
 6cd:	5f                   	pop    %edi
 6ce:	5d                   	pop    %ebp
 6cf:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 6d0:	8b 10                	mov    (%eax),%edx
 6d2:	89 11                	mov    %edx,(%ecx)
 6d4:	eb e9                	jmp    6bf <malloc+0x9f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 6d6:	c7 05 98 09 00 00 9c 	movl   $0x99c,0x998
 6dd:	09 00 00 
    base.s.size = 0;
 6e0:	b8 9c 09 00 00       	mov    $0x99c,%eax
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 6e5:	c7 05 9c 09 00 00 9c 	movl   $0x99c,0x99c
 6ec:	09 00 00 
    base.s.size = 0;
 6ef:	c7 05 a0 09 00 00 00 	movl   $0x0,0x9a0
 6f6:	00 00 00 
 6f9:	e9 4e ff ff ff       	jmp    64c <malloc+0x2c>
