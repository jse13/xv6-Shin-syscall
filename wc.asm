
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "%d %d %d %s\n", l, w, c, name);
}

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
}

int
main(int argc, char *argv[])
   5:	be 01 00 00 00       	mov    $0x1,%esi
{
   a:	53                   	push   %ebx
   b:	83 e4 f0             	and    $0xfffffff0,%esp
   e:	83 ec 10             	sub    $0x10,%esp
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
}

int
main(int argc, char *argv[])
  11:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  14:	83 c3 04             	add    $0x4,%ebx
{
  int fd, i;

  if(argc <= 1){
  17:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  1b:	7e 60                	jle    7d <main+0x7d>
  1d:	8d 76 00             	lea    0x0(%esi),%esi
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  20:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  27:	00 
  28:	8b 03                	mov    (%ebx),%eax
  2a:	89 04 24             	mov    %eax,(%esp)
  2d:	e8 d0 03 00 00       	call   402 <open>
  32:	85 c0                	test   %eax,%eax
  34:	89 c7                	mov    %eax,%edi
  36:	78 26                	js     5e <main+0x5e>
      printf(1, "wc: cannot open %s\n", argv[i]);
      exit();
    }
    wc(fd, argv[i]);
  38:	8b 13                	mov    (%ebx),%edx
  if(argc <= 1){
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
  3a:	83 c6 01             	add    $0x1,%esi
  3d:	83 c3 04             	add    $0x4,%ebx
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "wc: cannot open %s\n", argv[i]);
      exit();
    }
    wc(fd, argv[i]);
  40:	89 04 24             	mov    %eax,(%esp)
  43:	89 54 24 04          	mov    %edx,0x4(%esp)
  47:	e8 54 00 00 00       	call   a0 <wc>
    close(fd);
  4c:	89 3c 24             	mov    %edi,(%esp)
  4f:	e8 96 03 00 00       	call   3ea <close>
  if(argc <= 1){
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
  54:	3b 75 08             	cmp    0x8(%ebp),%esi
  57:	75 c7                	jne    20 <main+0x20>
      exit();
    }
    wc(fd, argv[i]);
    close(fd);
  }
  exit();
  59:	e8 64 03 00 00       	call   3c2 <exit>
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "wc: cannot open %s\n", argv[i]);
  5e:	8b 03                	mov    (%ebx),%eax
  60:	c7 44 24 04 81 08 00 	movl   $0x881,0x4(%esp)
  67:	00 
  68:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  6f:	89 44 24 08          	mov    %eax,0x8(%esp)
  73:	e8 88 04 00 00       	call   500 <printf>
      exit();
  78:	e8 45 03 00 00       	call   3c2 <exit>
main(int argc, char *argv[])
{
  int fd, i;

  if(argc <= 1){
    wc(0, "");
  7d:	c7 44 24 04 73 08 00 	movl   $0x873,0x4(%esp)
  84:	00 
  85:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  8c:	e8 0f 00 00 00       	call   a0 <wc>
    exit();
  91:	e8 2c 03 00 00       	call   3c2 <exit>
  96:	66 90                	xchg   %ax,%ax
  98:	66 90                	xchg   %ax,%ax
  9a:	66 90                	xchg   %ax,%ax
  9c:	66 90                	xchg   %ax,%ax
  9e:	66 90                	xchg   %ax,%ax

000000a0 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	57                   	push   %edi
  a4:	56                   	push   %esi
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  a5:	31 f6                	xor    %esi,%esi

char buf[512];

void
wc(int fd, char *name)
{
  a7:	53                   	push   %ebx
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  a8:	31 db                	xor    %ebx,%ebx

char buf[512];

void
wc(int fd, char *name)
{
  aa:	83 ec 3c             	sub    $0x3c,%esp
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  ad:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  b4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  bb:	90                   	nop
  bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
  c0:	8b 45 08             	mov    0x8(%ebp),%eax
  c3:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  ca:	00 
  cb:	c7 44 24 04 a0 0b 00 	movl   $0xba0,0x4(%esp)
  d2:	00 
  d3:	89 04 24             	mov    %eax,(%esp)
  d6:	e8 ff 02 00 00       	call   3da <read>
  db:	83 f8 00             	cmp    $0x0,%eax
  de:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  e1:	7e 5c                	jle    13f <wc+0x9f>
  e3:	31 ff                	xor    %edi,%edi
  e5:	eb 0b                	jmp    f2 <wc+0x52>
  e7:	90                   	nop
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
        inword = 0;
  e8:	31 f6                	xor    %esi,%esi
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
  ea:	83 c7 01             	add    $0x1,%edi
  ed:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
  f0:	74 38                	je     12a <wc+0x8a>
      c++;
      if(buf[i] == '\n')
  f2:	0f be 87 a0 0b 00 00 	movsbl 0xba0(%edi),%eax
        l++;
  f9:	31 c9                	xor    %ecx,%ecx
      if(strchr(" \r\t\n\v", buf[i]))
  fb:	c7 04 24 5e 08 00 00 	movl   $0x85e,(%esp)
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
        l++;
 102:	3c 0a                	cmp    $0xa,%al
 104:	0f 94 c1             	sete   %cl
      if(strchr(" \r\t\n\v", buf[i]))
 107:	89 44 24 04          	mov    %eax,0x4(%esp)
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
        l++;
 10b:	01 cb                	add    %ecx,%ebx
      if(strchr(" \r\t\n\v", buf[i]))
 10d:	e8 3e 01 00 00       	call   250 <strchr>
 112:	85 c0                	test   %eax,%eax
 114:	75 d2                	jne    e8 <wc+0x48>
        inword = 0;
      else if(!inword){
 116:	85 f6                	test   %esi,%esi
 118:	75 1e                	jne    138 <wc+0x98>
        w++;
 11a:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
 11e:	83 c7 01             	add    $0x1,%edi
 121:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
        inword = 0;
      else if(!inword){
        w++;
        inword = 1;
 124:	66 be 01 00          	mov    $0x1,%si
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
 128:	75 c8                	jne    f2 <wc+0x52>
 12a:	8b 45 dc             	mov    -0x24(%ebp),%eax
 12d:	01 f8                	add    %edi,%eax
 12f:	89 45 dc             	mov    %eax,-0x24(%ebp)
 132:	eb 8c                	jmp    c0 <wc+0x20>
 134:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      c++;
      if(buf[i] == '\n')
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
        inword = 0;
      else if(!inword){
 138:	be 01 00 00 00       	mov    $0x1,%esi
 13d:	eb ab                	jmp    ea <wc+0x4a>
        w++;
        inword = 1;
      }
    }
  }
  if(n < 0){
 13f:	75 35                	jne    176 <wc+0xd6>
    printf(1, "wc: read error\n");
    exit();
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
 141:	8b 45 0c             	mov    0xc(%ebp),%eax
 144:	89 5c 24 08          	mov    %ebx,0x8(%esp)
 148:	c7 44 24 04 74 08 00 	movl   $0x874,0x4(%esp)
 14f:	00 
 150:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 157:	89 44 24 14          	mov    %eax,0x14(%esp)
 15b:	8b 45 dc             	mov    -0x24(%ebp),%eax
 15e:	89 44 24 10          	mov    %eax,0x10(%esp)
 162:	8b 45 e0             	mov    -0x20(%ebp),%eax
 165:	89 44 24 0c          	mov    %eax,0xc(%esp)
 169:	e8 92 03 00 00       	call   500 <printf>
}
 16e:	83 c4 3c             	add    $0x3c,%esp
 171:	5b                   	pop    %ebx
 172:	5e                   	pop    %esi
 173:	5f                   	pop    %edi
 174:	5d                   	pop    %ebp
 175:	c3                   	ret    
        inword = 1;
      }
    }
  }
  if(n < 0){
    printf(1, "wc: read error\n");
 176:	c7 44 24 04 64 08 00 	movl   $0x864,0x4(%esp)
 17d:	00 
 17e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 185:	e8 76 03 00 00       	call   500 <printf>
    exit();
 18a:	e8 33 02 00 00       	call   3c2 <exit>
 18f:	90                   	nop

00000190 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	8b 45 08             	mov    0x8(%ebp),%eax
 196:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 199:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 19a:	89 c2                	mov    %eax,%edx
 19c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1a0:	0f b6 19             	movzbl (%ecx),%ebx
 1a3:	83 c1 01             	add    $0x1,%ecx
 1a6:	88 1a                	mov    %bl,(%edx)
 1a8:	83 c2 01             	add    $0x1,%edx
 1ab:	84 db                	test   %bl,%bl
 1ad:	75 f1                	jne    1a0 <strcpy+0x10>
    ;
  return os;
}
 1af:	5b                   	pop    %ebx
 1b0:	5d                   	pop    %ebp
 1b1:	c3                   	ret    
 1b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	8b 55 08             	mov    0x8(%ebp),%edx
 1c6:	56                   	push   %esi
 1c7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 1ca:	53                   	push   %ebx
  while(*p && *p == *q)
 1cb:	0f b6 02             	movzbl (%edx),%eax
 1ce:	0f b6 19             	movzbl (%ecx),%ebx
 1d1:	84 c0                	test   %al,%al
 1d3:	75 16                	jne    1eb <strcmp+0x2b>
 1d5:	eb 21                	jmp    1f8 <strcmp+0x38>
 1d7:	90                   	nop
    p++, q++;
 1d8:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1db:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 1df:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 1e2:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1e5:	84 c0                	test   %al,%al
 1e7:	74 0f                	je     1f8 <strcmp+0x38>
    p++, q++;
 1e9:	89 f1                	mov    %esi,%ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1eb:	38 d8                	cmp    %bl,%al
 1ed:	74 e9                	je     1d8 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1ef:	29 d8                	sub    %ebx,%eax
}
 1f1:	5b                   	pop    %ebx
 1f2:	5e                   	pop    %esi
 1f3:	5d                   	pop    %ebp
 1f4:	c3                   	ret    
 1f5:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1f8:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1fa:	29 d8                	sub    %ebx,%eax
}
 1fc:	5b                   	pop    %ebx
 1fd:	5e                   	pop    %esi
 1fe:	5d                   	pop    %ebp
 1ff:	c3                   	ret    

00000200 <strlen>:

uint
strlen(char *s)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 206:	80 39 00             	cmpb   $0x0,(%ecx)
 209:	74 12                	je     21d <strlen+0x1d>
 20b:	31 d2                	xor    %edx,%edx
 20d:	8d 76 00             	lea    0x0(%esi),%esi
 210:	83 c2 01             	add    $0x1,%edx
 213:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 217:	89 d0                	mov    %edx,%eax
 219:	75 f5                	jne    210 <strlen+0x10>
    ;
  return n;
}
 21b:	5d                   	pop    %ebp
 21c:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 21d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 21f:	5d                   	pop    %ebp
 220:	c3                   	ret    
 221:	eb 0d                	jmp    230 <memset>
 223:	90                   	nop
 224:	90                   	nop
 225:	90                   	nop
 226:	90                   	nop
 227:	90                   	nop
 228:	90                   	nop
 229:	90                   	nop
 22a:	90                   	nop
 22b:	90                   	nop
 22c:	90                   	nop
 22d:	90                   	nop
 22e:	90                   	nop
 22f:	90                   	nop

00000230 <memset>:

void*
memset(void *dst, int c, uint n)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	8b 55 08             	mov    0x8(%ebp),%edx
 236:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 237:	8b 4d 10             	mov    0x10(%ebp),%ecx
 23a:	8b 45 0c             	mov    0xc(%ebp),%eax
 23d:	89 d7                	mov    %edx,%edi
 23f:	fc                   	cld    
 240:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 242:	89 d0                	mov    %edx,%eax
 244:	5f                   	pop    %edi
 245:	5d                   	pop    %ebp
 246:	c3                   	ret    
 247:	89 f6                	mov    %esi,%esi
 249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000250 <strchr>:

char*
strchr(const char *s, char c)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	8b 45 08             	mov    0x8(%ebp),%eax
 256:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 25a:	0f b6 10             	movzbl (%eax),%edx
 25d:	84 d2                	test   %dl,%dl
 25f:	75 11                	jne    272 <strchr+0x22>
 261:	eb 15                	jmp    278 <strchr+0x28>
 263:	90                   	nop
 264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 268:	83 c0 01             	add    $0x1,%eax
 26b:	0f b6 10             	movzbl (%eax),%edx
 26e:	84 d2                	test   %dl,%dl
 270:	74 06                	je     278 <strchr+0x28>
    if(*s == c)
 272:	38 ca                	cmp    %cl,%dl
 274:	75 f2                	jne    268 <strchr+0x18>
      return (char*)s;
  return 0;
}
 276:	5d                   	pop    %ebp
 277:	c3                   	ret    
strchr(const char *s, char c)
{
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
 278:	31 c0                	xor    %eax,%eax
}
 27a:	5d                   	pop    %ebp
 27b:	90                   	nop
 27c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 280:	c3                   	ret    
 281:	eb 0d                	jmp    290 <gets>
 283:	90                   	nop
 284:	90                   	nop
 285:	90                   	nop
 286:	90                   	nop
 287:	90                   	nop
 288:	90                   	nop
 289:	90                   	nop
 28a:	90                   	nop
 28b:	90                   	nop
 28c:	90                   	nop
 28d:	90                   	nop
 28e:	90                   	nop
 28f:	90                   	nop

00000290 <gets>:

char*
gets(char *buf, int max)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	57                   	push   %edi
 294:	56                   	push   %esi
 295:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 296:	31 db                	xor    %ebx,%ebx
  return 0;
}

char*
gets(char *buf, int max)
{
 298:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 29b:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 29e:	8d 73 01             	lea    0x1(%ebx),%esi
 2a1:	3b 75 0c             	cmp    0xc(%ebp),%esi
 2a4:	7d 42                	jge    2e8 <gets+0x58>
    cc = read(0, &c, 1);
 2a6:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 2ad:	00 
 2ae:	89 7c 24 04          	mov    %edi,0x4(%esp)
 2b2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2b9:	e8 1c 01 00 00       	call   3da <read>
    if(cc < 1)
 2be:	85 c0                	test   %eax,%eax
 2c0:	7e 26                	jle    2e8 <gets+0x58>
      break;
    buf[i++] = c;
 2c2:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2c6:	89 f3                	mov    %esi,%ebx
 2c8:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 2cb:	3c 0d                	cmp    $0xd,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 2cd:	88 44 32 ff          	mov    %al,-0x1(%edx,%esi,1)
    if(c == '\n' || c == '\r')
 2d1:	74 04                	je     2d7 <gets+0x47>
 2d3:	3c 0a                	cmp    $0xa,%al
 2d5:	75 c7                	jne    29e <gets+0xe>
      break;
  }
  buf[i] = '\0';
 2d7:	8b 45 08             	mov    0x8(%ebp),%eax
 2da:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 2de:	83 c4 2c             	add    $0x2c,%esp
 2e1:	5b                   	pop    %ebx
 2e2:	5e                   	pop    %esi
 2e3:	5f                   	pop    %edi
 2e4:	5d                   	pop    %ebp
 2e5:	c3                   	ret    
 2e6:	66 90                	xchg   %ax,%ax
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2e8:	8b 45 08             	mov    0x8(%ebp),%eax
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
 2eb:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2ed:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 2f1:	83 c4 2c             	add    $0x2c,%esp
 2f4:	5b                   	pop    %ebx
 2f5:	5e                   	pop    %esi
 2f6:	5f                   	pop    %edi
 2f7:	5d                   	pop    %ebp
 2f8:	c3                   	ret    
 2f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000300 <stat>:

int
stat(char *n, struct stat *st)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 306:	8b 45 08             	mov    0x8(%ebp),%eax
 309:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 310:	00 
  return buf;
}

int
stat(char *n, struct stat *st)
{
 311:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 314:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 317:	89 04 24             	mov    %eax,(%esp)
 31a:	e8 e3 00 00 00       	call   402 <open>
  if(fd < 0)
 31f:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 321:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 323:	78 2b                	js     350 <stat+0x50>
    return -1;
  r = fstat(fd, st);
 325:	8b 45 0c             	mov    0xc(%ebp),%eax
 328:	89 1c 24             	mov    %ebx,(%esp)
 32b:	89 44 24 04          	mov    %eax,0x4(%esp)
 32f:	e8 e6 00 00 00       	call   41a <fstat>
  close(fd);
 334:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 337:	89 c6                	mov    %eax,%esi
  close(fd);
 339:	e8 ac 00 00 00       	call   3ea <close>
  return r;
}
 33e:	89 f0                	mov    %esi,%eax
 340:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 343:	8b 75 fc             	mov    -0x4(%ebp),%esi
 346:	89 ec                	mov    %ebp,%esp
 348:	5d                   	pop    %ebp
 349:	c3                   	ret    
 34a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 350:	be ff ff ff ff       	mov    $0xffffffff,%esi
 355:	eb e7                	jmp    33e <stat+0x3e>
 357:	89 f6                	mov    %esi,%esi
 359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000360 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	8b 4d 08             	mov    0x8(%ebp),%ecx
 366:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 367:	0f be 11             	movsbl (%ecx),%edx
 36a:	8d 42 d0             	lea    -0x30(%edx),%eax
 36d:	3c 09                	cmp    $0x9,%al
 36f:	b8 00 00 00 00       	mov    $0x0,%eax
 374:	77 17                	ja     38d <atoi+0x2d>
 376:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 378:	83 c1 01             	add    $0x1,%ecx
 37b:	8d 04 80             	lea    (%eax,%eax,4),%eax
 37e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 382:	0f be 11             	movsbl (%ecx),%edx
 385:	8d 5a d0             	lea    -0x30(%edx),%ebx
 388:	80 fb 09             	cmp    $0x9,%bl
 38b:	76 eb                	jbe    378 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 38d:	5b                   	pop    %ebx
 38e:	5d                   	pop    %ebp
 38f:	c3                   	ret    

00000390 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 390:	55                   	push   %ebp
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
 391:	31 d2                	xor    %edx,%edx
{
 393:	89 e5                	mov    %esp,%ebp
 395:	56                   	push   %esi
 396:	8b 45 08             	mov    0x8(%ebp),%eax
 399:	53                   	push   %ebx
 39a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 39d:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3a0:	85 db                	test   %ebx,%ebx
 3a2:	7e 12                	jle    3b6 <memmove+0x26>
 3a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 3a8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 3ac:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 3af:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3b2:	39 da                	cmp    %ebx,%edx
 3b4:	75 f2                	jne    3a8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 3b6:	5b                   	pop    %ebx
 3b7:	5e                   	pop    %esi
 3b8:	5d                   	pop    %ebp
 3b9:	c3                   	ret    

000003ba <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3ba:	b8 01 00 00 00       	mov    $0x1,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <exit>:
SYSCALL(exit)
 3c2:	b8 02 00 00 00       	mov    $0x2,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <wait>:
SYSCALL(wait)
 3ca:	b8 03 00 00 00       	mov    $0x3,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <pipe>:
SYSCALL(pipe)
 3d2:	b8 04 00 00 00       	mov    $0x4,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <read>:
SYSCALL(read)
 3da:	b8 05 00 00 00       	mov    $0x5,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <write>:
SYSCALL(write)
 3e2:	b8 10 00 00 00       	mov    $0x10,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <close>:
SYSCALL(close)
 3ea:	b8 15 00 00 00       	mov    $0x15,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <kill>:
SYSCALL(kill)
 3f2:	b8 06 00 00 00       	mov    $0x6,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <exec>:
SYSCALL(exec)
 3fa:	b8 07 00 00 00       	mov    $0x7,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <open>:
SYSCALL(open)
 402:	b8 0f 00 00 00       	mov    $0xf,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <mknod>:
SYSCALL(mknod)
 40a:	b8 11 00 00 00       	mov    $0x11,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <unlink>:
SYSCALL(unlink)
 412:	b8 12 00 00 00       	mov    $0x12,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <fstat>:
SYSCALL(fstat)
 41a:	b8 08 00 00 00       	mov    $0x8,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <link>:
SYSCALL(link)
 422:	b8 13 00 00 00       	mov    $0x13,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <mkdir>:
SYSCALL(mkdir)
 42a:	b8 14 00 00 00       	mov    $0x14,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <chdir>:
SYSCALL(chdir)
 432:	b8 09 00 00 00       	mov    $0x9,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret    

0000043a <dup>:
SYSCALL(dup)
 43a:	b8 0a 00 00 00       	mov    $0xa,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    

00000442 <getpid>:
SYSCALL(getpid)
 442:	b8 0b 00 00 00       	mov    $0xb,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret    

0000044a <sbrk>:
SYSCALL(sbrk)
 44a:	b8 0c 00 00 00       	mov    $0xc,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret    

00000452 <sleep>:
SYSCALL(sleep)
 452:	b8 0d 00 00 00       	mov    $0xd,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret    

0000045a <uptime>:
SYSCALL(uptime)
 45a:	b8 0e 00 00 00       	mov    $0xe,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret    

00000462 <getprocs>:
SYSCALL(getprocs)
 462:	b8 16 00 00 00       	mov    $0x16,%eax
 467:	cd 40                	int    $0x40
 469:	c3                   	ret    
 46a:	66 90                	xchg   %ax,%ax
 46c:	66 90                	xchg   %ax,%ax
 46e:	66 90                	xchg   %ax,%ax

00000470 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 470:	55                   	push   %ebp
 471:	89 e5                	mov    %esp,%ebp
 473:	57                   	push   %edi
 474:	89 c7                	mov    %eax,%edi
 476:	56                   	push   %esi
 477:	53                   	push   %ebx
 478:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 47b:	8b 45 08             	mov    0x8(%ebp),%eax
 47e:	85 c0                	test   %eax,%eax
 480:	74 76                	je     4f8 <printint+0x88>
 482:	89 d0                	mov    %edx,%eax
 484:	c1 e8 1f             	shr    $0x1f,%eax
 487:	84 c0                	test   %al,%al
 489:	74 6d                	je     4f8 <printint+0x88>
    neg = 1;
    x = -xx;
 48b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 48d:	bb 01 00 00 00       	mov    $0x1,%ebx
    x = -xx;
 492:	f7 d8                	neg    %eax
  } else {
    x = xx;
  }

  i = 0;
 494:	31 f6                	xor    %esi,%esi
 496:	eb 02                	jmp    49a <printint+0x2a>
  do{
    buf[i++] = digits[x % base];
 498:	89 d6                	mov    %edx,%esi
 49a:	31 d2                	xor    %edx,%edx
 49c:	f7 f1                	div    %ecx
 49e:	0f b6 92 9c 08 00 00 	movzbl 0x89c(%edx),%edx
  }while((x /= base) != 0);
 4a5:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 4a7:	88 54 35 d8          	mov    %dl,-0x28(%ebp,%esi,1)
 4ab:	8d 56 01             	lea    0x1(%esi),%edx
  }while((x /= base) != 0);
 4ae:	75 e8                	jne    498 <printint+0x28>
  if(neg)
 4b0:	85 db                	test   %ebx,%ebx
 4b2:	74 08                	je     4bc <printint+0x4c>
    buf[i++] = '-';
 4b4:	c6 44 15 d8 2d       	movb   $0x2d,-0x28(%ebp,%edx,1)
 4b9:	8d 56 02             	lea    0x2(%esi),%edx

  while(--i >= 0)
 4bc:	8d 5a ff             	lea    -0x1(%edx),%ebx
 4bf:	83 fb ff             	cmp    $0xffffffff,%ebx
 4c2:	8d 75 d7             	lea    -0x29(%ebp),%esi
 4c5:	74 25                	je     4ec <printint+0x7c>
 4c7:	90                   	nop
 4c8:	0f b6 44 1d d8       	movzbl -0x28(%ebp,%ebx,1),%eax
 4cd:	83 eb 01             	sub    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4d0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4d7:	00 
 4d8:	89 74 24 04          	mov    %esi,0x4(%esp)
 4dc:	89 3c 24             	mov    %edi,(%esp)
 4df:	88 45 d7             	mov    %al,-0x29(%ebp)
 4e2:	e8 fb fe ff ff       	call   3e2 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4e7:	83 fb ff             	cmp    $0xffffffff,%ebx
 4ea:	75 dc                	jne    4c8 <printint+0x58>
    putc(fd, buf[i]);
}
 4ec:	83 c4 3c             	add    $0x3c,%esp
 4ef:	5b                   	pop    %ebx
 4f0:	5e                   	pop    %esi
 4f1:	5f                   	pop    %edi
 4f2:	5d                   	pop    %ebp
 4f3:	c3                   	ret    
 4f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4f8:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4fa:	31 db                	xor    %ebx,%ebx
 4fc:	eb 96                	jmp    494 <printint+0x24>
 4fe:	66 90                	xchg   %ax,%ax

00000500 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 500:	55                   	push   %ebp
 501:	89 e5                	mov    %esp,%ebp
 503:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 504:	31 ff                	xor    %edi,%edi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 506:	56                   	push   %esi
 507:	53                   	push   %ebx
 508:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 50b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 50e:	8d 55 10             	lea    0x10(%ebp),%edx
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 511:	8b 75 08             	mov    0x8(%ebp),%esi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 514:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 517:	0f be 03             	movsbl (%ebx),%eax
    putc(fd, buf[i]);
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
 51a:	83 c3 01             	add    $0x1,%ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 51d:	84 c0                	test   %al,%al
 51f:	75 39                	jne    55a <printf+0x5a>
 521:	e9 c2 00 00 00       	jmp    5e8 <printf+0xe8>
 526:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 528:	83 fa 25             	cmp    $0x25,%edx
 52b:	0f 84 bf 00 00 00    	je     5f0 <printf+0xf0>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 531:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 534:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 53b:	00 
 53c:	89 44 24 04          	mov    %eax,0x4(%esp)
 540:	89 34 24             	mov    %esi,(%esp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 543:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 546:	e8 97 fe ff ff       	call   3e2 <write>
 54b:	83 c3 01             	add    $0x1,%ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 54e:	0f be 43 ff          	movsbl -0x1(%ebx),%eax
 552:	84 c0                	test   %al,%al
 554:	0f 84 8e 00 00 00    	je     5e8 <printf+0xe8>
    c = fmt[i] & 0xff;
 55a:	0f b6 d0             	movzbl %al,%edx
    if(state == 0){
 55d:	85 ff                	test   %edi,%edi
 55f:	74 c7                	je     528 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 561:	83 ff 25             	cmp    $0x25,%edi
 564:	75 e5                	jne    54b <printf+0x4b>
      if(c == 'd'){
 566:	83 fa 64             	cmp    $0x64,%edx
 569:	0f 84 31 01 00 00    	je     6a0 <printf+0x1a0>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 56f:	25 f7 00 00 00       	and    $0xf7,%eax
 574:	83 f8 70             	cmp    $0x70,%eax
 577:	0f 84 83 00 00 00    	je     600 <printf+0x100>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 57d:	83 fa 73             	cmp    $0x73,%edx
 580:	0f 84 a2 00 00 00    	je     628 <printf+0x128>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 586:	83 fa 63             	cmp    $0x63,%edx
 589:	0f 84 35 01 00 00    	je     6c4 <printf+0x1c4>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 58f:	83 fa 25             	cmp    $0x25,%edx
 592:	0f 84 e0 00 00 00    	je     678 <printf+0x178>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 598:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 59b:	83 c3 01             	add    $0x1,%ebx
 59e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5a5:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5a6:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5a8:	89 44 24 04          	mov    %eax,0x4(%esp)
 5ac:	89 34 24             	mov    %esi,(%esp)
 5af:	89 55 d0             	mov    %edx,-0x30(%ebp)
 5b2:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 5b6:	e8 27 fe ff ff       	call   3e2 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 5bb:	8b 55 d0             	mov    -0x30(%ebp),%edx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5be:	8d 45 e7             	lea    -0x19(%ebp),%eax
 5c1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5c8:	00 
 5c9:	89 44 24 04          	mov    %eax,0x4(%esp)
 5cd:	89 34 24             	mov    %esi,(%esp)
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 5d0:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5d3:	e8 0a fe ff ff       	call   3e2 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5d8:	0f be 43 ff          	movsbl -0x1(%ebx),%eax
 5dc:	84 c0                	test   %al,%al
 5de:	0f 85 76 ff ff ff    	jne    55a <printf+0x5a>
 5e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5e8:	83 c4 3c             	add    $0x3c,%esp
 5eb:	5b                   	pop    %ebx
 5ec:	5e                   	pop    %esi
 5ed:	5f                   	pop    %edi
 5ee:	5d                   	pop    %ebp
 5ef:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 5f0:	bf 25 00 00 00       	mov    $0x25,%edi
 5f5:	e9 51 ff ff ff       	jmp    54b <printf+0x4b>
 5fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 600:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 603:	b9 10 00 00 00       	mov    $0x10,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 608:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 60a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 611:	8b 10                	mov    (%eax),%edx
 613:	89 f0                	mov    %esi,%eax
 615:	e8 56 fe ff ff       	call   470 <printint>
        ap++;
 61a:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 61e:	e9 28 ff ff ff       	jmp    54b <printf+0x4b>
 623:	90                   	nop
 624:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 628:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        ap++;
        if(s == 0)
          s = "(null)";
 62b:	b8 95 08 00 00       	mov    $0x895,%eax
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 630:	8b 3a                	mov    (%edx),%edi
        ap++;
 632:	83 c2 04             	add    $0x4,%edx
 635:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
          s = "(null)";
 638:	85 ff                	test   %edi,%edi
 63a:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 63d:	0f b6 07             	movzbl (%edi),%eax
 640:	84 c0                	test   %al,%al
 642:	74 28                	je     66c <printf+0x16c>
 644:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 648:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 64b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 64e:	83 c7 01             	add    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 651:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 658:	00 
 659:	89 44 24 04          	mov    %eax,0x4(%esp)
 65d:	89 34 24             	mov    %esi,(%esp)
 660:	e8 7d fd ff ff       	call   3e2 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 665:	0f b6 07             	movzbl (%edi),%eax
 668:	84 c0                	test   %al,%al
 66a:	75 dc                	jne    648 <printf+0x148>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 66c:	31 ff                	xor    %edi,%edi
 66e:	e9 d8 fe ff ff       	jmp    54b <printf+0x4b>
 673:	90                   	nop
 674:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 678:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 67b:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 67d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 684:	00 
 685:	89 44 24 04          	mov    %eax,0x4(%esp)
 689:	89 34 24             	mov    %esi,(%esp)
 68c:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 690:	e8 4d fd ff ff       	call   3e2 <write>
 695:	e9 b1 fe ff ff       	jmp    54b <printf+0x4b>
 69a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 6a0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 6a3:	b9 0a 00 00 00       	mov    $0xa,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6a8:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 6ab:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 6b2:	8b 10                	mov    (%eax),%edx
 6b4:	89 f0                	mov    %esi,%eax
 6b6:	e8 b5 fd ff ff       	call   470 <printint>
        ap++;
 6bb:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 6bf:	e9 87 fe ff ff       	jmp    54b <printf+0x4b>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 6c4:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6c7:	31 ff                	xor    %edi,%edi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 6c9:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6cb:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6d2:	00 
 6d3:	89 34 24             	mov    %esi,(%esp)
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 6d6:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6d9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 6dc:	89 44 24 04          	mov    %eax,0x4(%esp)
 6e0:	e8 fd fc ff ff       	call   3e2 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 6e5:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 6e9:	e9 5d fe ff ff       	jmp    54b <printf+0x4b>
 6ee:	66 90                	xchg   %ax,%ax

000006f0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6f0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6f1:	a1 80 0b 00 00       	mov    0xb80,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 6f6:	89 e5                	mov    %esp,%ebp
 6f8:	57                   	push   %edi
 6f9:	56                   	push   %esi
 6fa:	53                   	push   %ebx
 6fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6fe:	8b 08                	mov    (%eax),%ecx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 700:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 703:	39 d0                	cmp    %edx,%eax
 705:	72 11                	jb     718 <free+0x28>
 707:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 708:	39 c8                	cmp    %ecx,%eax
 70a:	72 04                	jb     710 <free+0x20>
 70c:	39 ca                	cmp    %ecx,%edx
 70e:	72 10                	jb     720 <free+0x30>
 710:	89 c8                	mov    %ecx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 712:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 714:	8b 08                	mov    (%eax),%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 716:	73 f0                	jae    708 <free+0x18>
 718:	39 ca                	cmp    %ecx,%edx
 71a:	72 04                	jb     720 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 71c:	39 c8                	cmp    %ecx,%eax
 71e:	72 f0                	jb     710 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 720:	8b 73 fc             	mov    -0x4(%ebx),%esi
 723:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 726:	39 cf                	cmp    %ecx,%edi
 728:	74 1e                	je     748 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 72a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 72d:	8b 48 04             	mov    0x4(%eax),%ecx
 730:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 733:	39 f2                	cmp    %esi,%edx
 735:	74 28                	je     75f <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 737:	89 10                	mov    %edx,(%eax)
  freep = p;
 739:	a3 80 0b 00 00       	mov    %eax,0xb80
}
 73e:	5b                   	pop    %ebx
 73f:	5e                   	pop    %esi
 740:	5f                   	pop    %edi
 741:	5d                   	pop    %ebp
 742:	c3                   	ret    
 743:	90                   	nop
 744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 748:	03 71 04             	add    0x4(%ecx),%esi
 74b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 74e:	8b 08                	mov    (%eax),%ecx
 750:	8b 09                	mov    (%ecx),%ecx
 752:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 755:	8b 48 04             	mov    0x4(%eax),%ecx
 758:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 75b:	39 f2                	cmp    %esi,%edx
 75d:	75 d8                	jne    737 <free+0x47>
    p->s.size += bp->s.size;
 75f:	03 4b fc             	add    -0x4(%ebx),%ecx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 762:	a3 80 0b 00 00       	mov    %eax,0xb80
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 767:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 76a:	8b 53 f8             	mov    -0x8(%ebx),%edx
 76d:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 76f:	5b                   	pop    %ebx
 770:	5e                   	pop    %esi
 771:	5f                   	pop    %edi
 772:	5d                   	pop    %ebp
 773:	c3                   	ret    
 774:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 77a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000780 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 780:	55                   	push   %ebp
 781:	89 e5                	mov    %esp,%ebp
 783:	57                   	push   %edi
 784:	56                   	push   %esi
 785:	53                   	push   %ebx
 786:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 789:	8b 55 08             	mov    0x8(%ebp),%edx
  if((prevp = freep) == 0){
 78c:	8b 0d 80 0b 00 00    	mov    0xb80,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 792:	83 c2 07             	add    $0x7,%edx
 795:	c1 ea 03             	shr    $0x3,%edx
  if((prevp = freep) == 0){
 798:	85 c9                	test   %ecx,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 79a:	8d 5a 01             	lea    0x1(%edx),%ebx
  if((prevp = freep) == 0){
 79d:	0f 84 93 00 00 00    	je     836 <malloc+0xb6>
 7a3:	8b 01                	mov    (%ecx),%eax
 7a5:	8b 78 04             	mov    0x4(%eax),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 7a8:	39 fb                	cmp    %edi,%ebx
 7aa:	76 64                	jbe    810 <malloc+0x90>
 7ac:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 7b3:	eb 0c                	jmp    7c1 <malloc+0x41>
 7b5:	8d 76 00             	lea    0x0(%esi),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7b8:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 7ba:	8b 78 04             	mov    0x4(%eax),%edi
 7bd:	39 fb                	cmp    %edi,%ebx
 7bf:	76 4f                	jbe    810 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7c1:	3b 05 80 0b 00 00    	cmp    0xb80,%eax
 7c7:	89 c1                	mov    %eax,%ecx
 7c9:	75 ed                	jne    7b8 <malloc+0x38>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 7cb:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 7d1:	b8 00 80 00 00       	mov    $0x8000,%eax
 7d6:	0f 43 c6             	cmovae %esi,%eax
 7d9:	bf 00 10 00 00       	mov    $0x1000,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 7de:	89 04 24             	mov    %eax,(%esp)
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 7e1:	0f 43 fb             	cmovae %ebx,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 7e4:	e8 61 fc ff ff       	call   44a <sbrk>
  if(p == (char*)-1)
 7e9:	83 f8 ff             	cmp    $0xffffffff,%eax
 7ec:	74 18                	je     806 <malloc+0x86>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 7ee:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 7f1:	83 c0 08             	add    $0x8,%eax
 7f4:	89 04 24             	mov    %eax,(%esp)
 7f7:	e8 f4 fe ff ff       	call   6f0 <free>
  return freep;
 7fc:	8b 0d 80 0b 00 00    	mov    0xb80,%ecx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 802:	85 c9                	test   %ecx,%ecx
 804:	75 b2                	jne    7b8 <malloc+0x38>
        return 0;
 806:	31 c0                	xor    %eax,%eax
 808:	eb 1e                	jmp    828 <malloc+0xa8>
 80a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 810:	39 fb                	cmp    %edi,%ebx
 812:	74 1c                	je     830 <malloc+0xb0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 814:	29 df                	sub    %ebx,%edi
 816:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 819:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 81c:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 81f:	89 0d 80 0b 00 00    	mov    %ecx,0xb80
      return (void*)(p + 1);
 825:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 828:	83 c4 1c             	add    $0x1c,%esp
 82b:	5b                   	pop    %ebx
 82c:	5e                   	pop    %esi
 82d:	5f                   	pop    %edi
 82e:	5d                   	pop    %ebp
 82f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 830:	8b 10                	mov    (%eax),%edx
 832:	89 11                	mov    %edx,(%ecx)
 834:	eb e9                	jmp    81f <malloc+0x9f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 836:	c7 05 80 0b 00 00 84 	movl   $0xb84,0xb80
 83d:	0b 00 00 
    base.s.size = 0;
 840:	b8 84 0b 00 00       	mov    $0xb84,%eax
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 845:	c7 05 84 0b 00 00 84 	movl   $0xb84,0xb84
 84c:	0b 00 00 
    base.s.size = 0;
 84f:	c7 05 88 0b 00 00 00 	movl   $0x0,0xb88
 856:	00 00 00 
 859:	e9 4e ff ff ff       	jmp    7ac <malloc+0x2c>
