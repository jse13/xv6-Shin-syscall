
_stressfs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	53                   	push   %ebx
  char data[512];

  printf(1, "stressfs starting\n");
  memset(data, 'a', sizeof(data));

  for(i = 0; i < 4; i++)
   6:	31 db                	xor    %ebx,%ebx
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	81 ec 20 02 00 00    	sub    $0x220,%esp
  int fd, i;
  char path[] = "stressfs0";
  char data[512];

  printf(1, "stressfs starting\n");
  11:	c7 44 24 04 0e 08 00 	movl   $0x80e,0x4(%esp)
  18:	00 
  memset(data, 'a', sizeof(data));
  19:	8d 74 24 20          	lea    0x20(%esp),%esi
{
  int fd, i;
  char path[] = "stressfs0";
  char data[512];

  printf(1, "stressfs starting\n");
  1d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)

int
main(int argc, char *argv[])
{
  int fd, i;
  char path[] = "stressfs0";
  24:	c7 44 24 16 73 74 72 	movl   $0x65727473,0x16(%esp)
  2b:	65 
  2c:	c7 44 24 1a 73 73 66 	movl   $0x73667373,0x1a(%esp)
  33:	73 
  34:	66 c7 44 24 1e 30 00 	movw   $0x30,0x1e(%esp)
  char data[512];

  printf(1, "stressfs starting\n");
  3b:	e8 70 04 00 00       	call   4b0 <printf>
  memset(data, 'a', sizeof(data));
  40:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  47:	00 
  48:	c7 44 24 04 61 00 00 	movl   $0x61,0x4(%esp)
  4f:	00 
  50:	89 34 24             	mov    %esi,(%esp)
  53:	e8 88 01 00 00       	call   1e0 <memset>

  for(i = 0; i < 4; i++)
    if(fork() > 0)
  58:	e8 0d 03 00 00       	call   36a <fork>
  5d:	85 c0                	test   %eax,%eax
  5f:	0f 8f c6 00 00 00    	jg     12b <main+0x12b>
  char data[512];

  printf(1, "stressfs starting\n");
  memset(data, 'a', sizeof(data));

  for(i = 0; i < 4; i++)
  65:	83 c3 01             	add    $0x1,%ebx
  68:	83 fb 04             	cmp    $0x4,%ebx
  6b:	75 eb                	jne    58 <main+0x58>
  6d:	bf 04 00 00 00       	mov    $0x4,%edi
    if(fork() > 0)
      break;

  printf(1, "write %d\n", i);
  72:	89 5c 24 08          	mov    %ebx,0x8(%esp)

  path[8] += i;
  fd = open(path, O_CREATE | O_RDWR);
  76:	bb 14 00 00 00       	mov    $0x14,%ebx

  for(i = 0; i < 4; i++)
    if(fork() > 0)
      break;

  printf(1, "write %d\n", i);
  7b:	c7 44 24 04 21 08 00 	movl   $0x821,0x4(%esp)
  82:	00 
  83:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  8a:	e8 21 04 00 00       	call   4b0 <printf>

  path[8] += i;
  8f:	89 f8                	mov    %edi,%eax
  91:	00 44 24 1e          	add    %al,0x1e(%esp)
  fd = open(path, O_CREATE | O_RDWR);
  95:	8d 44 24 16          	lea    0x16(%esp),%eax
  99:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
  a0:	00 
  a1:	89 04 24             	mov    %eax,(%esp)
  a4:	e8 09 03 00 00       	call   3b2 <open>
  a9:	89 c7                	mov    %eax,%edi
  ab:	90                   	nop
  ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  b0:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  b7:	00 
  b8:	89 74 24 04          	mov    %esi,0x4(%esp)
  bc:	89 3c 24             	mov    %edi,(%esp)
  bf:	e8 ce 02 00 00       	call   392 <write>

  printf(1, "write %d\n", i);

  path[8] += i;
  fd = open(path, O_CREATE | O_RDWR);
  for(i = 0; i < 20; i++)
  c4:	83 eb 01             	sub    $0x1,%ebx
  c7:	75 e7                	jne    b0 <main+0xb0>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  close(fd);
  c9:	89 3c 24             	mov    %edi,(%esp)

  printf(1, "read\n");

  fd = open(path, O_RDONLY);
  cc:	bb 14 00 00 00       	mov    $0x14,%ebx
  path[8] += i;
  fd = open(path, O_CREATE | O_RDWR);
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  close(fd);
  d1:	e8 c4 02 00 00       	call   39a <close>

  printf(1, "read\n");
  d6:	c7 44 24 04 2b 08 00 	movl   $0x82b,0x4(%esp)
  dd:	00 
  de:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  e5:	e8 c6 03 00 00       	call   4b0 <printf>

  fd = open(path, O_RDONLY);
  ea:	8d 44 24 16          	lea    0x16(%esp),%eax
  ee:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  f5:	00 
  f6:	89 04 24             	mov    %eax,(%esp)
  f9:	e8 b4 02 00 00       	call   3b2 <open>
  fe:	89 c7                	mov    %eax,%edi
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
 100:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
 107:	00 
 108:	89 74 24 04          	mov    %esi,0x4(%esp)
 10c:	89 3c 24             	mov    %edi,(%esp)
 10f:	e8 76 02 00 00       	call   38a <read>
  close(fd);

  printf(1, "read\n");

  fd = open(path, O_RDONLY);
  for (i = 0; i < 20; i++)
 114:	83 eb 01             	sub    $0x1,%ebx
 117:	75 e7                	jne    100 <main+0x100>
    read(fd, data, sizeof(data));
  close(fd);
 119:	89 3c 24             	mov    %edi,(%esp)
 11c:	e8 79 02 00 00       	call   39a <close>

  wait();
 121:	e8 54 02 00 00       	call   37a <wait>

  exit();
 126:	e8 47 02 00 00       	call   372 <exit>
 12b:	89 df                	mov    %ebx,%edi
 12d:	8d 76 00             	lea    0x0(%esi),%esi
 130:	e9 3d ff ff ff       	jmp    72 <main+0x72>
 135:	66 90                	xchg   %ax,%ax
 137:	66 90                	xchg   %ax,%ax
 139:	66 90                	xchg   %ax,%ax
 13b:	66 90                	xchg   %ax,%ax
 13d:	66 90                	xchg   %ax,%ax
 13f:	90                   	nop

00000140 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	8b 45 08             	mov    0x8(%ebp),%eax
 146:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 149:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 14a:	89 c2                	mov    %eax,%edx
 14c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 150:	0f b6 19             	movzbl (%ecx),%ebx
 153:	83 c1 01             	add    $0x1,%ecx
 156:	88 1a                	mov    %bl,(%edx)
 158:	83 c2 01             	add    $0x1,%edx
 15b:	84 db                	test   %bl,%bl
 15d:	75 f1                	jne    150 <strcpy+0x10>
    ;
  return os;
}
 15f:	5b                   	pop    %ebx
 160:	5d                   	pop    %ebp
 161:	c3                   	ret    
 162:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000170 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	8b 55 08             	mov    0x8(%ebp),%edx
 176:	56                   	push   %esi
 177:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 17a:	53                   	push   %ebx
  while(*p && *p == *q)
 17b:	0f b6 02             	movzbl (%edx),%eax
 17e:	0f b6 19             	movzbl (%ecx),%ebx
 181:	84 c0                	test   %al,%al
 183:	75 16                	jne    19b <strcmp+0x2b>
 185:	eb 21                	jmp    1a8 <strcmp+0x38>
 187:	90                   	nop
    p++, q++;
 188:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 18b:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 18f:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 192:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 195:	84 c0                	test   %al,%al
 197:	74 0f                	je     1a8 <strcmp+0x38>
    p++, q++;
 199:	89 f1                	mov    %esi,%ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 19b:	38 d8                	cmp    %bl,%al
 19d:	74 e9                	je     188 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 19f:	29 d8                	sub    %ebx,%eax
}
 1a1:	5b                   	pop    %ebx
 1a2:	5e                   	pop    %esi
 1a3:	5d                   	pop    %ebp
 1a4:	c3                   	ret    
 1a5:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1a8:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1aa:	29 d8                	sub    %ebx,%eax
}
 1ac:	5b                   	pop    %ebx
 1ad:	5e                   	pop    %esi
 1ae:	5d                   	pop    %ebp
 1af:	c3                   	ret    

000001b0 <strlen>:

uint
strlen(char *s)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 1b6:	80 39 00             	cmpb   $0x0,(%ecx)
 1b9:	74 12                	je     1cd <strlen+0x1d>
 1bb:	31 d2                	xor    %edx,%edx
 1bd:	8d 76 00             	lea    0x0(%esi),%esi
 1c0:	83 c2 01             	add    $0x1,%edx
 1c3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 1c7:	89 d0                	mov    %edx,%eax
 1c9:	75 f5                	jne    1c0 <strlen+0x10>
    ;
  return n;
}
 1cb:	5d                   	pop    %ebp
 1cc:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 1cd:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 1cf:	5d                   	pop    %ebp
 1d0:	c3                   	ret    
 1d1:	eb 0d                	jmp    1e0 <memset>
 1d3:	90                   	nop
 1d4:	90                   	nop
 1d5:	90                   	nop
 1d6:	90                   	nop
 1d7:	90                   	nop
 1d8:	90                   	nop
 1d9:	90                   	nop
 1da:	90                   	nop
 1db:	90                   	nop
 1dc:	90                   	nop
 1dd:	90                   	nop
 1de:	90                   	nop
 1df:	90                   	nop

000001e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	8b 55 08             	mov    0x8(%ebp),%edx
 1e6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ed:	89 d7                	mov    %edx,%edi
 1ef:	fc                   	cld    
 1f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1f2:	89 d0                	mov    %edx,%eax
 1f4:	5f                   	pop    %edi
 1f5:	5d                   	pop    %ebp
 1f6:	c3                   	ret    
 1f7:	89 f6                	mov    %esi,%esi
 1f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000200 <strchr>:

char*
strchr(const char *s, char c)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	8b 45 08             	mov    0x8(%ebp),%eax
 206:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 20a:	0f b6 10             	movzbl (%eax),%edx
 20d:	84 d2                	test   %dl,%dl
 20f:	75 11                	jne    222 <strchr+0x22>
 211:	eb 15                	jmp    228 <strchr+0x28>
 213:	90                   	nop
 214:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 218:	83 c0 01             	add    $0x1,%eax
 21b:	0f b6 10             	movzbl (%eax),%edx
 21e:	84 d2                	test   %dl,%dl
 220:	74 06                	je     228 <strchr+0x28>
    if(*s == c)
 222:	38 ca                	cmp    %cl,%dl
 224:	75 f2                	jne    218 <strchr+0x18>
      return (char*)s;
  return 0;
}
 226:	5d                   	pop    %ebp
 227:	c3                   	ret    
strchr(const char *s, char c)
{
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
 228:	31 c0                	xor    %eax,%eax
}
 22a:	5d                   	pop    %ebp
 22b:	90                   	nop
 22c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 230:	c3                   	ret    
 231:	eb 0d                	jmp    240 <gets>
 233:	90                   	nop
 234:	90                   	nop
 235:	90                   	nop
 236:	90                   	nop
 237:	90                   	nop
 238:	90                   	nop
 239:	90                   	nop
 23a:	90                   	nop
 23b:	90                   	nop
 23c:	90                   	nop
 23d:	90                   	nop
 23e:	90                   	nop
 23f:	90                   	nop

00000240 <gets>:

char*
gets(char *buf, int max)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	57                   	push   %edi
 244:	56                   	push   %esi
 245:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 246:	31 db                	xor    %ebx,%ebx
  return 0;
}

char*
gets(char *buf, int max)
{
 248:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 24b:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 24e:	8d 73 01             	lea    0x1(%ebx),%esi
 251:	3b 75 0c             	cmp    0xc(%ebp),%esi
 254:	7d 42                	jge    298 <gets+0x58>
    cc = read(0, &c, 1);
 256:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 25d:	00 
 25e:	89 7c 24 04          	mov    %edi,0x4(%esp)
 262:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 269:	e8 1c 01 00 00       	call   38a <read>
    if(cc < 1)
 26e:	85 c0                	test   %eax,%eax
 270:	7e 26                	jle    298 <gets+0x58>
      break;
    buf[i++] = c;
 272:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 276:	89 f3                	mov    %esi,%ebx
 278:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 27b:	3c 0d                	cmp    $0xd,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 27d:	88 44 32 ff          	mov    %al,-0x1(%edx,%esi,1)
    if(c == '\n' || c == '\r')
 281:	74 04                	je     287 <gets+0x47>
 283:	3c 0a                	cmp    $0xa,%al
 285:	75 c7                	jne    24e <gets+0xe>
      break;
  }
  buf[i] = '\0';
 287:	8b 45 08             	mov    0x8(%ebp),%eax
 28a:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 28e:	83 c4 2c             	add    $0x2c,%esp
 291:	5b                   	pop    %ebx
 292:	5e                   	pop    %esi
 293:	5f                   	pop    %edi
 294:	5d                   	pop    %ebp
 295:	c3                   	ret    
 296:	66 90                	xchg   %ax,%ax
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 298:	8b 45 08             	mov    0x8(%ebp),%eax
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
 29b:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 29d:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 2a1:	83 c4 2c             	add    $0x2c,%esp
 2a4:	5b                   	pop    %ebx
 2a5:	5e                   	pop    %esi
 2a6:	5f                   	pop    %edi
 2a7:	5d                   	pop    %ebp
 2a8:	c3                   	ret    
 2a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002b0 <stat>:

int
stat(char *n, struct stat *st)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2b6:	8b 45 08             	mov    0x8(%ebp),%eax
 2b9:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 2c0:	00 
  return buf;
}

int
stat(char *n, struct stat *st)
{
 2c1:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 2c4:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2c7:	89 04 24             	mov    %eax,(%esp)
 2ca:	e8 e3 00 00 00       	call   3b2 <open>
  if(fd < 0)
 2cf:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2d1:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 2d3:	78 2b                	js     300 <stat+0x50>
    return -1;
  r = fstat(fd, st);
 2d5:	8b 45 0c             	mov    0xc(%ebp),%eax
 2d8:	89 1c 24             	mov    %ebx,(%esp)
 2db:	89 44 24 04          	mov    %eax,0x4(%esp)
 2df:	e8 e6 00 00 00       	call   3ca <fstat>
  close(fd);
 2e4:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 2e7:	89 c6                	mov    %eax,%esi
  close(fd);
 2e9:	e8 ac 00 00 00       	call   39a <close>
  return r;
}
 2ee:	89 f0                	mov    %esi,%eax
 2f0:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 2f3:	8b 75 fc             	mov    -0x4(%ebp),%esi
 2f6:	89 ec                	mov    %ebp,%esp
 2f8:	5d                   	pop    %ebp
 2f9:	c3                   	ret    
 2fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 300:	be ff ff ff ff       	mov    $0xffffffff,%esi
 305:	eb e7                	jmp    2ee <stat+0x3e>
 307:	89 f6                	mov    %esi,%esi
 309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000310 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	8b 4d 08             	mov    0x8(%ebp),%ecx
 316:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 317:	0f be 11             	movsbl (%ecx),%edx
 31a:	8d 42 d0             	lea    -0x30(%edx),%eax
 31d:	3c 09                	cmp    $0x9,%al
 31f:	b8 00 00 00 00       	mov    $0x0,%eax
 324:	77 17                	ja     33d <atoi+0x2d>
 326:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 328:	83 c1 01             	add    $0x1,%ecx
 32b:	8d 04 80             	lea    (%eax,%eax,4),%eax
 32e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 332:	0f be 11             	movsbl (%ecx),%edx
 335:	8d 5a d0             	lea    -0x30(%edx),%ebx
 338:	80 fb 09             	cmp    $0x9,%bl
 33b:	76 eb                	jbe    328 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 33d:	5b                   	pop    %ebx
 33e:	5d                   	pop    %ebp
 33f:	c3                   	ret    

00000340 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 340:	55                   	push   %ebp
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
 341:	31 d2                	xor    %edx,%edx
{
 343:	89 e5                	mov    %esp,%ebp
 345:	56                   	push   %esi
 346:	8b 45 08             	mov    0x8(%ebp),%eax
 349:	53                   	push   %ebx
 34a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 34d:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 350:	85 db                	test   %ebx,%ebx
 352:	7e 12                	jle    366 <memmove+0x26>
 354:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 358:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 35c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 35f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 362:	39 da                	cmp    %ebx,%edx
 364:	75 f2                	jne    358 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 366:	5b                   	pop    %ebx
 367:	5e                   	pop    %esi
 368:	5d                   	pop    %ebp
 369:	c3                   	ret    

0000036a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 36a:	b8 01 00 00 00       	mov    $0x1,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <exit>:
SYSCALL(exit)
 372:	b8 02 00 00 00       	mov    $0x2,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <wait>:
SYSCALL(wait)
 37a:	b8 03 00 00 00       	mov    $0x3,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <pipe>:
SYSCALL(pipe)
 382:	b8 04 00 00 00       	mov    $0x4,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <read>:
SYSCALL(read)
 38a:	b8 05 00 00 00       	mov    $0x5,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <write>:
SYSCALL(write)
 392:	b8 10 00 00 00       	mov    $0x10,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <close>:
SYSCALL(close)
 39a:	b8 15 00 00 00       	mov    $0x15,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <kill>:
SYSCALL(kill)
 3a2:	b8 06 00 00 00       	mov    $0x6,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <exec>:
SYSCALL(exec)
 3aa:	b8 07 00 00 00       	mov    $0x7,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <open>:
SYSCALL(open)
 3b2:	b8 0f 00 00 00       	mov    $0xf,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <mknod>:
SYSCALL(mknod)
 3ba:	b8 11 00 00 00       	mov    $0x11,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <unlink>:
SYSCALL(unlink)
 3c2:	b8 12 00 00 00       	mov    $0x12,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <fstat>:
SYSCALL(fstat)
 3ca:	b8 08 00 00 00       	mov    $0x8,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <link>:
SYSCALL(link)
 3d2:	b8 13 00 00 00       	mov    $0x13,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <mkdir>:
SYSCALL(mkdir)
 3da:	b8 14 00 00 00       	mov    $0x14,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <chdir>:
SYSCALL(chdir)
 3e2:	b8 09 00 00 00       	mov    $0x9,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <dup>:
SYSCALL(dup)
 3ea:	b8 0a 00 00 00       	mov    $0xa,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <getpid>:
SYSCALL(getpid)
 3f2:	b8 0b 00 00 00       	mov    $0xb,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <sbrk>:
SYSCALL(sbrk)
 3fa:	b8 0c 00 00 00       	mov    $0xc,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <sleep>:
SYSCALL(sleep)
 402:	b8 0d 00 00 00       	mov    $0xd,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <uptime>:
SYSCALL(uptime)
 40a:	b8 0e 00 00 00       	mov    $0xe,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <getprocs>:
SYSCALL(getprocs)
 412:	b8 16 00 00 00       	mov    $0x16,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    
 41a:	66 90                	xchg   %ax,%ax
 41c:	66 90                	xchg   %ax,%ax
 41e:	66 90                	xchg   %ax,%ax

00000420 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	57                   	push   %edi
 424:	89 c7                	mov    %eax,%edi
 426:	56                   	push   %esi
 427:	53                   	push   %ebx
 428:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 42b:	8b 45 08             	mov    0x8(%ebp),%eax
 42e:	85 c0                	test   %eax,%eax
 430:	74 76                	je     4a8 <printint+0x88>
 432:	89 d0                	mov    %edx,%eax
 434:	c1 e8 1f             	shr    $0x1f,%eax
 437:	84 c0                	test   %al,%al
 439:	74 6d                	je     4a8 <printint+0x88>
    neg = 1;
    x = -xx;
 43b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 43d:	bb 01 00 00 00       	mov    $0x1,%ebx
    x = -xx;
 442:	f7 d8                	neg    %eax
  } else {
    x = xx;
  }

  i = 0;
 444:	31 f6                	xor    %esi,%esi
 446:	eb 02                	jmp    44a <printint+0x2a>
  do{
    buf[i++] = digits[x % base];
 448:	89 d6                	mov    %edx,%esi
 44a:	31 d2                	xor    %edx,%edx
 44c:	f7 f1                	div    %ecx
 44e:	0f b6 92 38 08 00 00 	movzbl 0x838(%edx),%edx
  }while((x /= base) != 0);
 455:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 457:	88 54 35 d8          	mov    %dl,-0x28(%ebp,%esi,1)
 45b:	8d 56 01             	lea    0x1(%esi),%edx
  }while((x /= base) != 0);
 45e:	75 e8                	jne    448 <printint+0x28>
  if(neg)
 460:	85 db                	test   %ebx,%ebx
 462:	74 08                	je     46c <printint+0x4c>
    buf[i++] = '-';
 464:	c6 44 15 d8 2d       	movb   $0x2d,-0x28(%ebp,%edx,1)
 469:	8d 56 02             	lea    0x2(%esi),%edx

  while(--i >= 0)
 46c:	8d 5a ff             	lea    -0x1(%edx),%ebx
 46f:	83 fb ff             	cmp    $0xffffffff,%ebx
 472:	8d 75 d7             	lea    -0x29(%ebp),%esi
 475:	74 25                	je     49c <printint+0x7c>
 477:	90                   	nop
 478:	0f b6 44 1d d8       	movzbl -0x28(%ebp,%ebx,1),%eax
 47d:	83 eb 01             	sub    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 480:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 487:	00 
 488:	89 74 24 04          	mov    %esi,0x4(%esp)
 48c:	89 3c 24             	mov    %edi,(%esp)
 48f:	88 45 d7             	mov    %al,-0x29(%ebp)
 492:	e8 fb fe ff ff       	call   392 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 497:	83 fb ff             	cmp    $0xffffffff,%ebx
 49a:	75 dc                	jne    478 <printint+0x58>
    putc(fd, buf[i]);
}
 49c:	83 c4 3c             	add    $0x3c,%esp
 49f:	5b                   	pop    %ebx
 4a0:	5e                   	pop    %esi
 4a1:	5f                   	pop    %edi
 4a2:	5d                   	pop    %ebp
 4a3:	c3                   	ret    
 4a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4a8:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4aa:	31 db                	xor    %ebx,%ebx
 4ac:	eb 96                	jmp    444 <printint+0x24>
 4ae:	66 90                	xchg   %ax,%ax

000004b0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4b4:	31 ff                	xor    %edi,%edi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4b6:	56                   	push   %esi
 4b7:	53                   	push   %ebx
 4b8:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4bb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 4be:	8d 55 10             	lea    0x10(%ebp),%edx
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4c1:	8b 75 08             	mov    0x8(%ebp),%esi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 4c4:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 4c7:	0f be 03             	movsbl (%ebx),%eax
    putc(fd, buf[i]);
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
 4ca:	83 c3 01             	add    $0x1,%ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4cd:	84 c0                	test   %al,%al
 4cf:	75 39                	jne    50a <printf+0x5a>
 4d1:	e9 c2 00 00 00       	jmp    598 <printf+0xe8>
 4d6:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 4d8:	83 fa 25             	cmp    $0x25,%edx
 4db:	0f 84 bf 00 00 00    	je     5a0 <printf+0xf0>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4e1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 4e4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4eb:	00 
 4ec:	89 44 24 04          	mov    %eax,0x4(%esp)
 4f0:	89 34 24             	mov    %esi,(%esp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 4f3:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4f6:	e8 97 fe ff ff       	call   392 <write>
 4fb:	83 c3 01             	add    $0x1,%ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4fe:	0f be 43 ff          	movsbl -0x1(%ebx),%eax
 502:	84 c0                	test   %al,%al
 504:	0f 84 8e 00 00 00    	je     598 <printf+0xe8>
    c = fmt[i] & 0xff;
 50a:	0f b6 d0             	movzbl %al,%edx
    if(state == 0){
 50d:	85 ff                	test   %edi,%edi
 50f:	74 c7                	je     4d8 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 511:	83 ff 25             	cmp    $0x25,%edi
 514:	75 e5                	jne    4fb <printf+0x4b>
      if(c == 'd'){
 516:	83 fa 64             	cmp    $0x64,%edx
 519:	0f 84 31 01 00 00    	je     650 <printf+0x1a0>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 51f:	25 f7 00 00 00       	and    $0xf7,%eax
 524:	83 f8 70             	cmp    $0x70,%eax
 527:	0f 84 83 00 00 00    	je     5b0 <printf+0x100>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 52d:	83 fa 73             	cmp    $0x73,%edx
 530:	0f 84 a2 00 00 00    	je     5d8 <printf+0x128>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 536:	83 fa 63             	cmp    $0x63,%edx
 539:	0f 84 35 01 00 00    	je     674 <printf+0x1c4>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 53f:	83 fa 25             	cmp    $0x25,%edx
 542:	0f 84 e0 00 00 00    	je     628 <printf+0x178>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 548:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 54b:	83 c3 01             	add    $0x1,%ebx
 54e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 555:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 556:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 558:	89 44 24 04          	mov    %eax,0x4(%esp)
 55c:	89 34 24             	mov    %esi,(%esp)
 55f:	89 55 d0             	mov    %edx,-0x30(%ebp)
 562:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 566:	e8 27 fe ff ff       	call   392 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 56b:	8b 55 d0             	mov    -0x30(%ebp),%edx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 56e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 571:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 578:	00 
 579:	89 44 24 04          	mov    %eax,0x4(%esp)
 57d:	89 34 24             	mov    %esi,(%esp)
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 580:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 583:	e8 0a fe ff ff       	call   392 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 588:	0f be 43 ff          	movsbl -0x1(%ebx),%eax
 58c:	84 c0                	test   %al,%al
 58e:	0f 85 76 ff ff ff    	jne    50a <printf+0x5a>
 594:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 598:	83 c4 3c             	add    $0x3c,%esp
 59b:	5b                   	pop    %ebx
 59c:	5e                   	pop    %esi
 59d:	5f                   	pop    %edi
 59e:	5d                   	pop    %ebp
 59f:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 5a0:	bf 25 00 00 00       	mov    $0x25,%edi
 5a5:	e9 51 ff ff ff       	jmp    4fb <printf+0x4b>
 5aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 5b0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 5b3:	b9 10 00 00 00       	mov    $0x10,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5b8:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 5ba:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 5c1:	8b 10                	mov    (%eax),%edx
 5c3:	89 f0                	mov    %esi,%eax
 5c5:	e8 56 fe ff ff       	call   420 <printint>
        ap++;
 5ca:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 5ce:	e9 28 ff ff ff       	jmp    4fb <printf+0x4b>
 5d3:	90                   	nop
 5d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 5d8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        ap++;
        if(s == 0)
          s = "(null)";
 5db:	b8 31 08 00 00       	mov    $0x831,%eax
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 5e0:	8b 3a                	mov    (%edx),%edi
        ap++;
 5e2:	83 c2 04             	add    $0x4,%edx
 5e5:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
          s = "(null)";
 5e8:	85 ff                	test   %edi,%edi
 5ea:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 5ed:	0f b6 07             	movzbl (%edi),%eax
 5f0:	84 c0                	test   %al,%al
 5f2:	74 28                	je     61c <printf+0x16c>
 5f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5f8:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5fb:	8d 45 e3             	lea    -0x1d(%ebp),%eax
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 5fe:	83 c7 01             	add    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 601:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 608:	00 
 609:	89 44 24 04          	mov    %eax,0x4(%esp)
 60d:	89 34 24             	mov    %esi,(%esp)
 610:	e8 7d fd ff ff       	call   392 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 615:	0f b6 07             	movzbl (%edi),%eax
 618:	84 c0                	test   %al,%al
 61a:	75 dc                	jne    5f8 <printf+0x148>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 61c:	31 ff                	xor    %edi,%edi
 61e:	e9 d8 fe ff ff       	jmp    4fb <printf+0x4b>
 623:	90                   	nop
 624:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 628:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 62b:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 62d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 634:	00 
 635:	89 44 24 04          	mov    %eax,0x4(%esp)
 639:	89 34 24             	mov    %esi,(%esp)
 63c:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 640:	e8 4d fd ff ff       	call   392 <write>
 645:	e9 b1 fe ff ff       	jmp    4fb <printf+0x4b>
 64a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 650:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 653:	b9 0a 00 00 00       	mov    $0xa,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 658:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 65b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 662:	8b 10                	mov    (%eax),%edx
 664:	89 f0                	mov    %esi,%eax
 666:	e8 b5 fd ff ff       	call   420 <printint>
        ap++;
 66b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 66f:	e9 87 fe ff ff       	jmp    4fb <printf+0x4b>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 674:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 677:	31 ff                	xor    %edi,%edi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 679:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 67b:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 682:	00 
 683:	89 34 24             	mov    %esi,(%esp)
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 686:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 689:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 68c:	89 44 24 04          	mov    %eax,0x4(%esp)
 690:	e8 fd fc ff ff       	call   392 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 695:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 699:	e9 5d fe ff ff       	jmp    4fb <printf+0x4b>
 69e:	66 90                	xchg   %ax,%ax

000006a0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6a0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6a1:	a1 d0 0a 00 00       	mov    0xad0,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 6a6:	89 e5                	mov    %esp,%ebp
 6a8:	57                   	push   %edi
 6a9:	56                   	push   %esi
 6aa:	53                   	push   %ebx
 6ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6ae:	8b 08                	mov    (%eax),%ecx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6b0:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6b3:	39 d0                	cmp    %edx,%eax
 6b5:	72 11                	jb     6c8 <free+0x28>
 6b7:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6b8:	39 c8                	cmp    %ecx,%eax
 6ba:	72 04                	jb     6c0 <free+0x20>
 6bc:	39 ca                	cmp    %ecx,%edx
 6be:	72 10                	jb     6d0 <free+0x30>
 6c0:	89 c8                	mov    %ecx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6c2:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6c4:	8b 08                	mov    (%eax),%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6c6:	73 f0                	jae    6b8 <free+0x18>
 6c8:	39 ca                	cmp    %ecx,%edx
 6ca:	72 04                	jb     6d0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6cc:	39 c8                	cmp    %ecx,%eax
 6ce:	72 f0                	jb     6c0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6d0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6d3:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 6d6:	39 cf                	cmp    %ecx,%edi
 6d8:	74 1e                	je     6f8 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 6da:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6dd:	8b 48 04             	mov    0x4(%eax),%ecx
 6e0:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 6e3:	39 f2                	cmp    %esi,%edx
 6e5:	74 28                	je     70f <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6e7:	89 10                	mov    %edx,(%eax)
  freep = p;
 6e9:	a3 d0 0a 00 00       	mov    %eax,0xad0
}
 6ee:	5b                   	pop    %ebx
 6ef:	5e                   	pop    %esi
 6f0:	5f                   	pop    %edi
 6f1:	5d                   	pop    %ebp
 6f2:	c3                   	ret    
 6f3:	90                   	nop
 6f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6f8:	03 71 04             	add    0x4(%ecx),%esi
 6fb:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6fe:	8b 08                	mov    (%eax),%ecx
 700:	8b 09                	mov    (%ecx),%ecx
 702:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 705:	8b 48 04             	mov    0x4(%eax),%ecx
 708:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 70b:	39 f2                	cmp    %esi,%edx
 70d:	75 d8                	jne    6e7 <free+0x47>
    p->s.size += bp->s.size;
 70f:	03 4b fc             	add    -0x4(%ebx),%ecx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 712:	a3 d0 0a 00 00       	mov    %eax,0xad0
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 717:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 71a:	8b 53 f8             	mov    -0x8(%ebx),%edx
 71d:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 71f:	5b                   	pop    %ebx
 720:	5e                   	pop    %esi
 721:	5f                   	pop    %edi
 722:	5d                   	pop    %ebp
 723:	c3                   	ret    
 724:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 72a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000730 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 730:	55                   	push   %ebp
 731:	89 e5                	mov    %esp,%ebp
 733:	57                   	push   %edi
 734:	56                   	push   %esi
 735:	53                   	push   %ebx
 736:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 739:	8b 55 08             	mov    0x8(%ebp),%edx
  if((prevp = freep) == 0){
 73c:	8b 0d d0 0a 00 00    	mov    0xad0,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 742:	83 c2 07             	add    $0x7,%edx
 745:	c1 ea 03             	shr    $0x3,%edx
  if((prevp = freep) == 0){
 748:	85 c9                	test   %ecx,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 74a:	8d 5a 01             	lea    0x1(%edx),%ebx
  if((prevp = freep) == 0){
 74d:	0f 84 93 00 00 00    	je     7e6 <malloc+0xb6>
 753:	8b 01                	mov    (%ecx),%eax
 755:	8b 78 04             	mov    0x4(%eax),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 758:	39 fb                	cmp    %edi,%ebx
 75a:	76 64                	jbe    7c0 <malloc+0x90>
 75c:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 763:	eb 0c                	jmp    771 <malloc+0x41>
 765:	8d 76 00             	lea    0x0(%esi),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 768:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 76a:	8b 78 04             	mov    0x4(%eax),%edi
 76d:	39 fb                	cmp    %edi,%ebx
 76f:	76 4f                	jbe    7c0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 771:	3b 05 d0 0a 00 00    	cmp    0xad0,%eax
 777:	89 c1                	mov    %eax,%ecx
 779:	75 ed                	jne    768 <malloc+0x38>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 77b:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 781:	b8 00 80 00 00       	mov    $0x8000,%eax
 786:	0f 43 c6             	cmovae %esi,%eax
 789:	bf 00 10 00 00       	mov    $0x1000,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 78e:	89 04 24             	mov    %eax,(%esp)
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 791:	0f 43 fb             	cmovae %ebx,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 794:	e8 61 fc ff ff       	call   3fa <sbrk>
  if(p == (char*)-1)
 799:	83 f8 ff             	cmp    $0xffffffff,%eax
 79c:	74 18                	je     7b6 <malloc+0x86>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 79e:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 7a1:	83 c0 08             	add    $0x8,%eax
 7a4:	89 04 24             	mov    %eax,(%esp)
 7a7:	e8 f4 fe ff ff       	call   6a0 <free>
  return freep;
 7ac:	8b 0d d0 0a 00 00    	mov    0xad0,%ecx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 7b2:	85 c9                	test   %ecx,%ecx
 7b4:	75 b2                	jne    768 <malloc+0x38>
        return 0;
 7b6:	31 c0                	xor    %eax,%eax
 7b8:	eb 1e                	jmp    7d8 <malloc+0xa8>
 7ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 7c0:	39 fb                	cmp    %edi,%ebx
 7c2:	74 1c                	je     7e0 <malloc+0xb0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 7c4:	29 df                	sub    %ebx,%edi
 7c6:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 7c9:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 7cc:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 7cf:	89 0d d0 0a 00 00    	mov    %ecx,0xad0
      return (void*)(p + 1);
 7d5:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 7d8:	83 c4 1c             	add    $0x1c,%esp
 7db:	5b                   	pop    %ebx
 7dc:	5e                   	pop    %esi
 7dd:	5f                   	pop    %edi
 7de:	5d                   	pop    %ebp
 7df:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 7e0:	8b 10                	mov    (%eax),%edx
 7e2:	89 11                	mov    %edx,(%ecx)
 7e4:	eb e9                	jmp    7cf <malloc+0x9f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 7e6:	c7 05 d0 0a 00 00 d4 	movl   $0xad4,0xad0
 7ed:	0a 00 00 
    base.s.size = 0;
 7f0:	b8 d4 0a 00 00       	mov    $0xad4,%eax
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 7f5:	c7 05 d4 0a 00 00 d4 	movl   $0xad4,0xad4
 7fc:	0a 00 00 
    base.s.size = 0;
 7ff:	c7 05 d8 0a 00 00 00 	movl   $0x0,0xad8
 806:	00 00 00 
 809:	e9 4e ff ff ff       	jmp    75c <malloc+0x2c>
