
_ln:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	83 ec 10             	sub    $0x10,%esp
   a:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(argc != 3){
   d:	83 7d 08 03          	cmpl   $0x3,0x8(%ebp)
  11:	74 19                	je     2c <main+0x2c>
    printf(2, "Usage: ln old new\n");
  13:	c7 44 24 04 3e 07 00 	movl   $0x73e,0x4(%esp)
  1a:	00 
  1b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  22:	e8 b9 03 00 00       	call   3e0 <printf>
    exit();
  27:	e8 76 02 00 00       	call   2a2 <exit>
  }
  if(link(argv[1], argv[2]) < 0)
  2c:	8b 43 08             	mov    0x8(%ebx),%eax
  2f:	89 44 24 04          	mov    %eax,0x4(%esp)
  33:	8b 43 04             	mov    0x4(%ebx),%eax
  36:	89 04 24             	mov    %eax,(%esp)
  39:	e8 c4 02 00 00       	call   302 <link>
  3e:	85 c0                	test   %eax,%eax
  40:	78 05                	js     47 <main+0x47>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit();
  42:	e8 5b 02 00 00       	call   2a2 <exit>
  if(argc != 3){
    printf(2, "Usage: ln old new\n");
    exit();
  }
  if(link(argv[1], argv[2]) < 0)
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  47:	8b 43 08             	mov    0x8(%ebx),%eax
  4a:	89 44 24 0c          	mov    %eax,0xc(%esp)
  4e:	8b 43 04             	mov    0x4(%ebx),%eax
  51:	c7 44 24 04 51 07 00 	movl   $0x751,0x4(%esp)
  58:	00 
  59:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  60:	89 44 24 08          	mov    %eax,0x8(%esp)
  64:	e8 77 03 00 00       	call   3e0 <printf>
  69:	eb d7                	jmp    42 <main+0x42>
  6b:	66 90                	xchg   %ax,%ax
  6d:	66 90                	xchg   %ax,%ax
  6f:	90                   	nop

00000070 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  70:	55                   	push   %ebp
  71:	89 e5                	mov    %esp,%ebp
  73:	8b 45 08             	mov    0x8(%ebp),%eax
  76:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  79:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  7a:	89 c2                	mov    %eax,%edx
  7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  80:	0f b6 19             	movzbl (%ecx),%ebx
  83:	83 c1 01             	add    $0x1,%ecx
  86:	88 1a                	mov    %bl,(%edx)
  88:	83 c2 01             	add    $0x1,%edx
  8b:	84 db                	test   %bl,%bl
  8d:	75 f1                	jne    80 <strcpy+0x10>
    ;
  return os;
}
  8f:	5b                   	pop    %ebx
  90:	5d                   	pop    %ebp
  91:	c3                   	ret    
  92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	8b 55 08             	mov    0x8(%ebp),%edx
  a6:	56                   	push   %esi
  a7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  aa:	53                   	push   %ebx
  while(*p && *p == *q)
  ab:	0f b6 02             	movzbl (%edx),%eax
  ae:	0f b6 19             	movzbl (%ecx),%ebx
  b1:	84 c0                	test   %al,%al
  b3:	75 16                	jne    cb <strcmp+0x2b>
  b5:	eb 21                	jmp    d8 <strcmp+0x38>
  b7:	90                   	nop
    p++, q++;
  b8:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  bb:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
  bf:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  c2:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  c5:	84 c0                	test   %al,%al
  c7:	74 0f                	je     d8 <strcmp+0x38>
    p++, q++;
  c9:	89 f1                	mov    %esi,%ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  cb:	38 d8                	cmp    %bl,%al
  cd:	74 e9                	je     b8 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  cf:	29 d8                	sub    %ebx,%eax
}
  d1:	5b                   	pop    %ebx
  d2:	5e                   	pop    %esi
  d3:	5d                   	pop    %ebp
  d4:	c3                   	ret    
  d5:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  d8:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
  da:	29 d8                	sub    %ebx,%eax
}
  dc:	5b                   	pop    %ebx
  dd:	5e                   	pop    %esi
  de:	5d                   	pop    %ebp
  df:	c3                   	ret    

000000e0 <strlen>:

uint
strlen(char *s)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  e6:	80 39 00             	cmpb   $0x0,(%ecx)
  e9:	74 12                	je     fd <strlen+0x1d>
  eb:	31 d2                	xor    %edx,%edx
  ed:	8d 76 00             	lea    0x0(%esi),%esi
  f0:	83 c2 01             	add    $0x1,%edx
  f3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  f7:	89 d0                	mov    %edx,%eax
  f9:	75 f5                	jne    f0 <strlen+0x10>
    ;
  return n;
}
  fb:	5d                   	pop    %ebp
  fc:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
  fd:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
  ff:	5d                   	pop    %ebp
 100:	c3                   	ret    
 101:	eb 0d                	jmp    110 <memset>
 103:	90                   	nop
 104:	90                   	nop
 105:	90                   	nop
 106:	90                   	nop
 107:	90                   	nop
 108:	90                   	nop
 109:	90                   	nop
 10a:	90                   	nop
 10b:	90                   	nop
 10c:	90                   	nop
 10d:	90                   	nop
 10e:	90                   	nop
 10f:	90                   	nop

00000110 <memset>:

void*
memset(void *dst, int c, uint n)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	8b 55 08             	mov    0x8(%ebp),%edx
 116:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 117:	8b 4d 10             	mov    0x10(%ebp),%ecx
 11a:	8b 45 0c             	mov    0xc(%ebp),%eax
 11d:	89 d7                	mov    %edx,%edi
 11f:	fc                   	cld    
 120:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 122:	89 d0                	mov    %edx,%eax
 124:	5f                   	pop    %edi
 125:	5d                   	pop    %ebp
 126:	c3                   	ret    
 127:	89 f6                	mov    %esi,%esi
 129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000130 <strchr>:

char*
strchr(const char *s, char c)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	8b 45 08             	mov    0x8(%ebp),%eax
 136:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 13a:	0f b6 10             	movzbl (%eax),%edx
 13d:	84 d2                	test   %dl,%dl
 13f:	75 11                	jne    152 <strchr+0x22>
 141:	eb 15                	jmp    158 <strchr+0x28>
 143:	90                   	nop
 144:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 148:	83 c0 01             	add    $0x1,%eax
 14b:	0f b6 10             	movzbl (%eax),%edx
 14e:	84 d2                	test   %dl,%dl
 150:	74 06                	je     158 <strchr+0x28>
    if(*s == c)
 152:	38 ca                	cmp    %cl,%dl
 154:	75 f2                	jne    148 <strchr+0x18>
      return (char*)s;
  return 0;
}
 156:	5d                   	pop    %ebp
 157:	c3                   	ret    
strchr(const char *s, char c)
{
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
 158:	31 c0                	xor    %eax,%eax
}
 15a:	5d                   	pop    %ebp
 15b:	90                   	nop
 15c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 160:	c3                   	ret    
 161:	eb 0d                	jmp    170 <gets>
 163:	90                   	nop
 164:	90                   	nop
 165:	90                   	nop
 166:	90                   	nop
 167:	90                   	nop
 168:	90                   	nop
 169:	90                   	nop
 16a:	90                   	nop
 16b:	90                   	nop
 16c:	90                   	nop
 16d:	90                   	nop
 16e:	90                   	nop
 16f:	90                   	nop

00000170 <gets>:

char*
gets(char *buf, int max)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	57                   	push   %edi
 174:	56                   	push   %esi
 175:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 176:	31 db                	xor    %ebx,%ebx
  return 0;
}

char*
gets(char *buf, int max)
{
 178:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 17b:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 17e:	8d 73 01             	lea    0x1(%ebx),%esi
 181:	3b 75 0c             	cmp    0xc(%ebp),%esi
 184:	7d 42                	jge    1c8 <gets+0x58>
    cc = read(0, &c, 1);
 186:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 18d:	00 
 18e:	89 7c 24 04          	mov    %edi,0x4(%esp)
 192:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 199:	e8 1c 01 00 00       	call   2ba <read>
    if(cc < 1)
 19e:	85 c0                	test   %eax,%eax
 1a0:	7e 26                	jle    1c8 <gets+0x58>
      break;
    buf[i++] = c;
 1a2:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1a6:	89 f3                	mov    %esi,%ebx
 1a8:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 1ab:	3c 0d                	cmp    $0xd,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 1ad:	88 44 32 ff          	mov    %al,-0x1(%edx,%esi,1)
    if(c == '\n' || c == '\r')
 1b1:	74 04                	je     1b7 <gets+0x47>
 1b3:	3c 0a                	cmp    $0xa,%al
 1b5:	75 c7                	jne    17e <gets+0xe>
      break;
  }
  buf[i] = '\0';
 1b7:	8b 45 08             	mov    0x8(%ebp),%eax
 1ba:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 1be:	83 c4 2c             	add    $0x2c,%esp
 1c1:	5b                   	pop    %ebx
 1c2:	5e                   	pop    %esi
 1c3:	5f                   	pop    %edi
 1c4:	5d                   	pop    %ebp
 1c5:	c3                   	ret    
 1c6:	66 90                	xchg   %ax,%ax
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1c8:	8b 45 08             	mov    0x8(%ebp),%eax
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
 1cb:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1cd:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 1d1:	83 c4 2c             	add    $0x2c,%esp
 1d4:	5b                   	pop    %ebx
 1d5:	5e                   	pop    %esi
 1d6:	5f                   	pop    %edi
 1d7:	5d                   	pop    %ebp
 1d8:	c3                   	ret    
 1d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001e0 <stat>:

int
stat(char *n, struct stat *st)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1e6:	8b 45 08             	mov    0x8(%ebp),%eax
 1e9:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1f0:	00 
  return buf;
}

int
stat(char *n, struct stat *st)
{
 1f1:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 1f4:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f7:	89 04 24             	mov    %eax,(%esp)
 1fa:	e8 e3 00 00 00       	call   2e2 <open>
  if(fd < 0)
 1ff:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 201:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 203:	78 2b                	js     230 <stat+0x50>
    return -1;
  r = fstat(fd, st);
 205:	8b 45 0c             	mov    0xc(%ebp),%eax
 208:	89 1c 24             	mov    %ebx,(%esp)
 20b:	89 44 24 04          	mov    %eax,0x4(%esp)
 20f:	e8 e6 00 00 00       	call   2fa <fstat>
  close(fd);
 214:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 217:	89 c6                	mov    %eax,%esi
  close(fd);
 219:	e8 ac 00 00 00       	call   2ca <close>
  return r;
}
 21e:	89 f0                	mov    %esi,%eax
 220:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 223:	8b 75 fc             	mov    -0x4(%ebp),%esi
 226:	89 ec                	mov    %ebp,%esp
 228:	5d                   	pop    %ebp
 229:	c3                   	ret    
 22a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 230:	be ff ff ff ff       	mov    $0xffffffff,%esi
 235:	eb e7                	jmp    21e <stat+0x3e>
 237:	89 f6                	mov    %esi,%esi
 239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000240 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	8b 4d 08             	mov    0x8(%ebp),%ecx
 246:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 247:	0f be 11             	movsbl (%ecx),%edx
 24a:	8d 42 d0             	lea    -0x30(%edx),%eax
 24d:	3c 09                	cmp    $0x9,%al
 24f:	b8 00 00 00 00       	mov    $0x0,%eax
 254:	77 17                	ja     26d <atoi+0x2d>
 256:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 258:	83 c1 01             	add    $0x1,%ecx
 25b:	8d 04 80             	lea    (%eax,%eax,4),%eax
 25e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 262:	0f be 11             	movsbl (%ecx),%edx
 265:	8d 5a d0             	lea    -0x30(%edx),%ebx
 268:	80 fb 09             	cmp    $0x9,%bl
 26b:	76 eb                	jbe    258 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 26d:	5b                   	pop    %ebx
 26e:	5d                   	pop    %ebp
 26f:	c3                   	ret    

00000270 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 270:	55                   	push   %ebp
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
 271:	31 d2                	xor    %edx,%edx
{
 273:	89 e5                	mov    %esp,%ebp
 275:	56                   	push   %esi
 276:	8b 45 08             	mov    0x8(%ebp),%eax
 279:	53                   	push   %ebx
 27a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 27d:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 280:	85 db                	test   %ebx,%ebx
 282:	7e 12                	jle    296 <memmove+0x26>
 284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 288:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 28c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 28f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 292:	39 da                	cmp    %ebx,%edx
 294:	75 f2                	jne    288 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 296:	5b                   	pop    %ebx
 297:	5e                   	pop    %esi
 298:	5d                   	pop    %ebp
 299:	c3                   	ret    

0000029a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 29a:	b8 01 00 00 00       	mov    $0x1,%eax
 29f:	cd 40                	int    $0x40
 2a1:	c3                   	ret    

000002a2 <exit>:
SYSCALL(exit)
 2a2:	b8 02 00 00 00       	mov    $0x2,%eax
 2a7:	cd 40                	int    $0x40
 2a9:	c3                   	ret    

000002aa <wait>:
SYSCALL(wait)
 2aa:	b8 03 00 00 00       	mov    $0x3,%eax
 2af:	cd 40                	int    $0x40
 2b1:	c3                   	ret    

000002b2 <pipe>:
SYSCALL(pipe)
 2b2:	b8 04 00 00 00       	mov    $0x4,%eax
 2b7:	cd 40                	int    $0x40
 2b9:	c3                   	ret    

000002ba <read>:
SYSCALL(read)
 2ba:	b8 05 00 00 00       	mov    $0x5,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <write>:
SYSCALL(write)
 2c2:	b8 10 00 00 00       	mov    $0x10,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret    

000002ca <close>:
SYSCALL(close)
 2ca:	b8 15 00 00 00       	mov    $0x15,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <kill>:
SYSCALL(kill)
 2d2:	b8 06 00 00 00       	mov    $0x6,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <exec>:
SYSCALL(exec)
 2da:	b8 07 00 00 00       	mov    $0x7,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <open>:
SYSCALL(open)
 2e2:	b8 0f 00 00 00       	mov    $0xf,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <mknod>:
SYSCALL(mknod)
 2ea:	b8 11 00 00 00       	mov    $0x11,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <unlink>:
SYSCALL(unlink)
 2f2:	b8 12 00 00 00       	mov    $0x12,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <fstat>:
SYSCALL(fstat)
 2fa:	b8 08 00 00 00       	mov    $0x8,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <link>:
SYSCALL(link)
 302:	b8 13 00 00 00       	mov    $0x13,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <mkdir>:
SYSCALL(mkdir)
 30a:	b8 14 00 00 00       	mov    $0x14,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <chdir>:
SYSCALL(chdir)
 312:	b8 09 00 00 00       	mov    $0x9,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <dup>:
SYSCALL(dup)
 31a:	b8 0a 00 00 00       	mov    $0xa,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <getpid>:
SYSCALL(getpid)
 322:	b8 0b 00 00 00       	mov    $0xb,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <sbrk>:
SYSCALL(sbrk)
 32a:	b8 0c 00 00 00       	mov    $0xc,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <sleep>:
SYSCALL(sleep)
 332:	b8 0d 00 00 00       	mov    $0xd,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <uptime>:
SYSCALL(uptime)
 33a:	b8 0e 00 00 00       	mov    $0xe,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <getprocs>:
SYSCALL(getprocs)
 342:	b8 16 00 00 00       	mov    $0x16,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    
 34a:	66 90                	xchg   %ax,%ax
 34c:	66 90                	xchg   %ax,%ax
 34e:	66 90                	xchg   %ax,%ax

00000350 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	57                   	push   %edi
 354:	89 c7                	mov    %eax,%edi
 356:	56                   	push   %esi
 357:	53                   	push   %ebx
 358:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 35b:	8b 45 08             	mov    0x8(%ebp),%eax
 35e:	85 c0                	test   %eax,%eax
 360:	74 76                	je     3d8 <printint+0x88>
 362:	89 d0                	mov    %edx,%eax
 364:	c1 e8 1f             	shr    $0x1f,%eax
 367:	84 c0                	test   %al,%al
 369:	74 6d                	je     3d8 <printint+0x88>
    neg = 1;
    x = -xx;
 36b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 36d:	bb 01 00 00 00       	mov    $0x1,%ebx
    x = -xx;
 372:	f7 d8                	neg    %eax
  } else {
    x = xx;
  }

  i = 0;
 374:	31 f6                	xor    %esi,%esi
 376:	eb 02                	jmp    37a <printint+0x2a>
  do{
    buf[i++] = digits[x % base];
 378:	89 d6                	mov    %edx,%esi
 37a:	31 d2                	xor    %edx,%edx
 37c:	f7 f1                	div    %ecx
 37e:	0f b6 92 6c 07 00 00 	movzbl 0x76c(%edx),%edx
  }while((x /= base) != 0);
 385:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 387:	88 54 35 d8          	mov    %dl,-0x28(%ebp,%esi,1)
 38b:	8d 56 01             	lea    0x1(%esi),%edx
  }while((x /= base) != 0);
 38e:	75 e8                	jne    378 <printint+0x28>
  if(neg)
 390:	85 db                	test   %ebx,%ebx
 392:	74 08                	je     39c <printint+0x4c>
    buf[i++] = '-';
 394:	c6 44 15 d8 2d       	movb   $0x2d,-0x28(%ebp,%edx,1)
 399:	8d 56 02             	lea    0x2(%esi),%edx

  while(--i >= 0)
 39c:	8d 5a ff             	lea    -0x1(%edx),%ebx
 39f:	83 fb ff             	cmp    $0xffffffff,%ebx
 3a2:	8d 75 d7             	lea    -0x29(%ebp),%esi
 3a5:	74 25                	je     3cc <printint+0x7c>
 3a7:	90                   	nop
 3a8:	0f b6 44 1d d8       	movzbl -0x28(%ebp,%ebx,1),%eax
 3ad:	83 eb 01             	sub    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3b0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3b7:	00 
 3b8:	89 74 24 04          	mov    %esi,0x4(%esp)
 3bc:	89 3c 24             	mov    %edi,(%esp)
 3bf:	88 45 d7             	mov    %al,-0x29(%ebp)
 3c2:	e8 fb fe ff ff       	call   2c2 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3c7:	83 fb ff             	cmp    $0xffffffff,%ebx
 3ca:	75 dc                	jne    3a8 <printint+0x58>
    putc(fd, buf[i]);
}
 3cc:	83 c4 3c             	add    $0x3c,%esp
 3cf:	5b                   	pop    %ebx
 3d0:	5e                   	pop    %esi
 3d1:	5f                   	pop    %edi
 3d2:	5d                   	pop    %ebp
 3d3:	c3                   	ret    
 3d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3d8:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3da:	31 db                	xor    %ebx,%ebx
 3dc:	eb 96                	jmp    374 <printint+0x24>
 3de:	66 90                	xchg   %ax,%ax

000003e0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 3e4:	31 ff                	xor    %edi,%edi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3e6:	56                   	push   %esi
 3e7:	53                   	push   %ebx
 3e8:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3eb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 3ee:	8d 55 10             	lea    0x10(%ebp),%edx
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3f1:	8b 75 08             	mov    0x8(%ebp),%esi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 3f4:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 3f7:	0f be 03             	movsbl (%ebx),%eax
    putc(fd, buf[i]);
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
 3fa:	83 c3 01             	add    $0x1,%ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3fd:	84 c0                	test   %al,%al
 3ff:	75 39                	jne    43a <printf+0x5a>
 401:	e9 c2 00 00 00       	jmp    4c8 <printf+0xe8>
 406:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 408:	83 fa 25             	cmp    $0x25,%edx
 40b:	0f 84 bf 00 00 00    	je     4d0 <printf+0xf0>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 411:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 414:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 41b:	00 
 41c:	89 44 24 04          	mov    %eax,0x4(%esp)
 420:	89 34 24             	mov    %esi,(%esp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 423:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 426:	e8 97 fe ff ff       	call   2c2 <write>
 42b:	83 c3 01             	add    $0x1,%ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 42e:	0f be 43 ff          	movsbl -0x1(%ebx),%eax
 432:	84 c0                	test   %al,%al
 434:	0f 84 8e 00 00 00    	je     4c8 <printf+0xe8>
    c = fmt[i] & 0xff;
 43a:	0f b6 d0             	movzbl %al,%edx
    if(state == 0){
 43d:	85 ff                	test   %edi,%edi
 43f:	74 c7                	je     408 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 441:	83 ff 25             	cmp    $0x25,%edi
 444:	75 e5                	jne    42b <printf+0x4b>
      if(c == 'd'){
 446:	83 fa 64             	cmp    $0x64,%edx
 449:	0f 84 31 01 00 00    	je     580 <printf+0x1a0>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 44f:	25 f7 00 00 00       	and    $0xf7,%eax
 454:	83 f8 70             	cmp    $0x70,%eax
 457:	0f 84 83 00 00 00    	je     4e0 <printf+0x100>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 45d:	83 fa 73             	cmp    $0x73,%edx
 460:	0f 84 a2 00 00 00    	je     508 <printf+0x128>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 466:	83 fa 63             	cmp    $0x63,%edx
 469:	0f 84 35 01 00 00    	je     5a4 <printf+0x1c4>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 46f:	83 fa 25             	cmp    $0x25,%edx
 472:	0f 84 e0 00 00 00    	je     558 <printf+0x178>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 478:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 47b:	83 c3 01             	add    $0x1,%ebx
 47e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 485:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 486:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 488:	89 44 24 04          	mov    %eax,0x4(%esp)
 48c:	89 34 24             	mov    %esi,(%esp)
 48f:	89 55 d0             	mov    %edx,-0x30(%ebp)
 492:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 496:	e8 27 fe ff ff       	call   2c2 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 49b:	8b 55 d0             	mov    -0x30(%ebp),%edx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 49e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4a1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4a8:	00 
 4a9:	89 44 24 04          	mov    %eax,0x4(%esp)
 4ad:	89 34 24             	mov    %esi,(%esp)
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 4b0:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4b3:	e8 0a fe ff ff       	call   2c2 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4b8:	0f be 43 ff          	movsbl -0x1(%ebx),%eax
 4bc:	84 c0                	test   %al,%al
 4be:	0f 85 76 ff ff ff    	jne    43a <printf+0x5a>
 4c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 4c8:	83 c4 3c             	add    $0x3c,%esp
 4cb:	5b                   	pop    %ebx
 4cc:	5e                   	pop    %esi
 4cd:	5f                   	pop    %edi
 4ce:	5d                   	pop    %ebp
 4cf:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 4d0:	bf 25 00 00 00       	mov    $0x25,%edi
 4d5:	e9 51 ff ff ff       	jmp    42b <printf+0x4b>
 4da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 4e0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 4e3:	b9 10 00 00 00       	mov    $0x10,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4e8:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 4ea:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 4f1:	8b 10                	mov    (%eax),%edx
 4f3:	89 f0                	mov    %esi,%eax
 4f5:	e8 56 fe ff ff       	call   350 <printint>
        ap++;
 4fa:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 4fe:	e9 28 ff ff ff       	jmp    42b <printf+0x4b>
 503:	90                   	nop
 504:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 508:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        ap++;
        if(s == 0)
          s = "(null)";
 50b:	b8 65 07 00 00       	mov    $0x765,%eax
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 510:	8b 3a                	mov    (%edx),%edi
        ap++;
 512:	83 c2 04             	add    $0x4,%edx
 515:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
          s = "(null)";
 518:	85 ff                	test   %edi,%edi
 51a:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 51d:	0f b6 07             	movzbl (%edi),%eax
 520:	84 c0                	test   %al,%al
 522:	74 28                	je     54c <printf+0x16c>
 524:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 528:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 52b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 52e:	83 c7 01             	add    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 531:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 538:	00 
 539:	89 44 24 04          	mov    %eax,0x4(%esp)
 53d:	89 34 24             	mov    %esi,(%esp)
 540:	e8 7d fd ff ff       	call   2c2 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 545:	0f b6 07             	movzbl (%edi),%eax
 548:	84 c0                	test   %al,%al
 54a:	75 dc                	jne    528 <printf+0x148>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 54c:	31 ff                	xor    %edi,%edi
 54e:	e9 d8 fe ff ff       	jmp    42b <printf+0x4b>
 553:	90                   	nop
 554:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 558:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 55b:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 55d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 564:	00 
 565:	89 44 24 04          	mov    %eax,0x4(%esp)
 569:	89 34 24             	mov    %esi,(%esp)
 56c:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 570:	e8 4d fd ff ff       	call   2c2 <write>
 575:	e9 b1 fe ff ff       	jmp    42b <printf+0x4b>
 57a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 580:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 583:	b9 0a 00 00 00       	mov    $0xa,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 588:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 58b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 592:	8b 10                	mov    (%eax),%edx
 594:	89 f0                	mov    %esi,%eax
 596:	e8 b5 fd ff ff       	call   350 <printint>
        ap++;
 59b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 59f:	e9 87 fe ff ff       	jmp    42b <printf+0x4b>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 5a4:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5a7:	31 ff                	xor    %edi,%edi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 5a9:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5ab:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5b2:	00 
 5b3:	89 34 24             	mov    %esi,(%esp)
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 5b6:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5b9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 5bc:	89 44 24 04          	mov    %eax,0x4(%esp)
 5c0:	e8 fd fc ff ff       	call   2c2 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 5c5:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 5c9:	e9 5d fe ff ff       	jmp    42b <printf+0x4b>
 5ce:	66 90                	xchg   %ax,%ax

000005d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5d0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5d1:	a1 00 0a 00 00       	mov    0xa00,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 5d6:	89 e5                	mov    %esp,%ebp
 5d8:	57                   	push   %edi
 5d9:	56                   	push   %esi
 5da:	53                   	push   %ebx
 5db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5de:	8b 08                	mov    (%eax),%ecx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5e0:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5e3:	39 d0                	cmp    %edx,%eax
 5e5:	72 11                	jb     5f8 <free+0x28>
 5e7:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5e8:	39 c8                	cmp    %ecx,%eax
 5ea:	72 04                	jb     5f0 <free+0x20>
 5ec:	39 ca                	cmp    %ecx,%edx
 5ee:	72 10                	jb     600 <free+0x30>
 5f0:	89 c8                	mov    %ecx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5f2:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5f4:	8b 08                	mov    (%eax),%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5f6:	73 f0                	jae    5e8 <free+0x18>
 5f8:	39 ca                	cmp    %ecx,%edx
 5fa:	72 04                	jb     600 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5fc:	39 c8                	cmp    %ecx,%eax
 5fe:	72 f0                	jb     5f0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 600:	8b 73 fc             	mov    -0x4(%ebx),%esi
 603:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 606:	39 cf                	cmp    %ecx,%edi
 608:	74 1e                	je     628 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 60a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 60d:	8b 48 04             	mov    0x4(%eax),%ecx
 610:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 613:	39 f2                	cmp    %esi,%edx
 615:	74 28                	je     63f <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 617:	89 10                	mov    %edx,(%eax)
  freep = p;
 619:	a3 00 0a 00 00       	mov    %eax,0xa00
}
 61e:	5b                   	pop    %ebx
 61f:	5e                   	pop    %esi
 620:	5f                   	pop    %edi
 621:	5d                   	pop    %ebp
 622:	c3                   	ret    
 623:	90                   	nop
 624:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 628:	03 71 04             	add    0x4(%ecx),%esi
 62b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 62e:	8b 08                	mov    (%eax),%ecx
 630:	8b 09                	mov    (%ecx),%ecx
 632:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 635:	8b 48 04             	mov    0x4(%eax),%ecx
 638:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 63b:	39 f2                	cmp    %esi,%edx
 63d:	75 d8                	jne    617 <free+0x47>
    p->s.size += bp->s.size;
 63f:	03 4b fc             	add    -0x4(%ebx),%ecx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 642:	a3 00 0a 00 00       	mov    %eax,0xa00
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 647:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 64a:	8b 53 f8             	mov    -0x8(%ebx),%edx
 64d:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 64f:	5b                   	pop    %ebx
 650:	5e                   	pop    %esi
 651:	5f                   	pop    %edi
 652:	5d                   	pop    %ebp
 653:	c3                   	ret    
 654:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 65a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000660 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 660:	55                   	push   %ebp
 661:	89 e5                	mov    %esp,%ebp
 663:	57                   	push   %edi
 664:	56                   	push   %esi
 665:	53                   	push   %ebx
 666:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 669:	8b 55 08             	mov    0x8(%ebp),%edx
  if((prevp = freep) == 0){
 66c:	8b 0d 00 0a 00 00    	mov    0xa00,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 672:	83 c2 07             	add    $0x7,%edx
 675:	c1 ea 03             	shr    $0x3,%edx
  if((prevp = freep) == 0){
 678:	85 c9                	test   %ecx,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 67a:	8d 5a 01             	lea    0x1(%edx),%ebx
  if((prevp = freep) == 0){
 67d:	0f 84 93 00 00 00    	je     716 <malloc+0xb6>
 683:	8b 01                	mov    (%ecx),%eax
 685:	8b 78 04             	mov    0x4(%eax),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 688:	39 fb                	cmp    %edi,%ebx
 68a:	76 64                	jbe    6f0 <malloc+0x90>
 68c:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 693:	eb 0c                	jmp    6a1 <malloc+0x41>
 695:	8d 76 00             	lea    0x0(%esi),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 698:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 69a:	8b 78 04             	mov    0x4(%eax),%edi
 69d:	39 fb                	cmp    %edi,%ebx
 69f:	76 4f                	jbe    6f0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6a1:	3b 05 00 0a 00 00    	cmp    0xa00,%eax
 6a7:	89 c1                	mov    %eax,%ecx
 6a9:	75 ed                	jne    698 <malloc+0x38>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 6ab:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 6b1:	b8 00 80 00 00       	mov    $0x8000,%eax
 6b6:	0f 43 c6             	cmovae %esi,%eax
 6b9:	bf 00 10 00 00       	mov    $0x1000,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 6be:	89 04 24             	mov    %eax,(%esp)
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 6c1:	0f 43 fb             	cmovae %ebx,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 6c4:	e8 61 fc ff ff       	call   32a <sbrk>
  if(p == (char*)-1)
 6c9:	83 f8 ff             	cmp    $0xffffffff,%eax
 6cc:	74 18                	je     6e6 <malloc+0x86>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 6ce:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 6d1:	83 c0 08             	add    $0x8,%eax
 6d4:	89 04 24             	mov    %eax,(%esp)
 6d7:	e8 f4 fe ff ff       	call   5d0 <free>
  return freep;
 6dc:	8b 0d 00 0a 00 00    	mov    0xa00,%ecx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 6e2:	85 c9                	test   %ecx,%ecx
 6e4:	75 b2                	jne    698 <malloc+0x38>
        return 0;
 6e6:	31 c0                	xor    %eax,%eax
 6e8:	eb 1e                	jmp    708 <malloc+0xa8>
 6ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 6f0:	39 fb                	cmp    %edi,%ebx
 6f2:	74 1c                	je     710 <malloc+0xb0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 6f4:	29 df                	sub    %ebx,%edi
 6f6:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 6f9:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 6fc:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 6ff:	89 0d 00 0a 00 00    	mov    %ecx,0xa00
      return (void*)(p + 1);
 705:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 708:	83 c4 1c             	add    $0x1c,%esp
 70b:	5b                   	pop    %ebx
 70c:	5e                   	pop    %esi
 70d:	5f                   	pop    %edi
 70e:	5d                   	pop    %ebp
 70f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 710:	8b 10                	mov    (%eax),%edx
 712:	89 11                	mov    %edx,(%ecx)
 714:	eb e9                	jmp    6ff <malloc+0x9f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 716:	c7 05 00 0a 00 00 04 	movl   $0xa04,0xa00
 71d:	0a 00 00 
    base.s.size = 0;
 720:	b8 04 0a 00 00       	mov    $0xa04,%eax
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 725:	c7 05 04 0a 00 00 04 	movl   $0xa04,0xa04
 72c:	0a 00 00 
    base.s.size = 0;
 72f:	c7 05 08 0a 00 00 00 	movl   $0x0,0xa08
 736:	00 00 00 
 739:	e9 4e ff ff ff       	jmp    68c <malloc+0x2c>
