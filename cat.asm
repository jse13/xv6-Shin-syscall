
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  }
}

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
    exit();
  }
}

int
main(int argc, char *argv[])
   5:	be 01 00 00 00       	mov    $0x1,%esi
{
   a:	53                   	push   %ebx
   b:	83 e4 f0             	and    $0xfffffff0,%esp
   e:	83 ec 10             	sub    $0x10,%esp
    exit();
  }
}

int
main(int argc, char *argv[])
  11:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  14:	83 c3 04             	add    $0x4,%ebx
{
  int fd, i;

  if(argc <= 1){
  17:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  1b:	7e 5a                	jle    77 <main+0x77>
  1d:	8d 76 00             	lea    0x0(%esi),%esi
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  20:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  27:	00 
  28:	8b 03                	mov    (%ebx),%eax
  2a:	89 04 24             	mov    %eax,(%esp)
  2d:	e8 40 03 00 00       	call   372 <open>
  32:	85 c0                	test   %eax,%eax
  34:	89 c7                	mov    %eax,%edi
  36:	78 20                	js     58 <main+0x58>
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    cat(fd);
  38:	89 04 24             	mov    %eax,(%esp)
  if(argc <= 1){
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
  3b:	83 c6 01             	add    $0x1,%esi
  3e:	83 c3 04             	add    $0x4,%ebx
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    cat(fd);
  41:	e8 4a 00 00 00       	call   90 <cat>
    close(fd);
  46:	89 3c 24             	mov    %edi,(%esp)
  49:	e8 0c 03 00 00       	call   35a <close>
  if(argc <= 1){
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
  4e:	3b 75 08             	cmp    0x8(%ebp),%esi
  51:	75 cd                	jne    20 <main+0x20>
      exit();
    }
    cat(fd);
    close(fd);
  }
  exit();
  53:	e8 da 02 00 00       	call   332 <exit>
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
  58:	8b 03                	mov    (%ebx),%eax
  5a:	c7 44 24 04 df 07 00 	movl   $0x7df,0x4(%esp)
  61:	00 
  62:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  69:	89 44 24 08          	mov    %eax,0x8(%esp)
  6d:	e8 fe 03 00 00       	call   470 <printf>
      exit();
  72:	e8 bb 02 00 00       	call   332 <exit>
main(int argc, char *argv[])
{
  int fd, i;

  if(argc <= 1){
    cat(0);
  77:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  7e:	e8 0d 00 00 00       	call   90 <cat>
    exit();
  83:	e8 aa 02 00 00       	call   332 <exit>
  88:	66 90                	xchg   %ax,%ax
  8a:	66 90                	xchg   %ax,%ax
  8c:	66 90                	xchg   %ax,%ax
  8e:	66 90                	xchg   %ax,%ax

00000090 <cat>:

char buf[512];

void
cat(int fd)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	53                   	push   %ebx
  94:	83 ec 14             	sub    $0x14,%esp
  97:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
  9a:	eb 1c                	jmp    b8 <cat+0x28>
  9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    write(1, buf, n);
  a0:	89 44 24 08          	mov    %eax,0x8(%esp)
  a4:	c7 44 24 04 e0 0a 00 	movl   $0xae0,0x4(%esp)
  ab:	00 
  ac:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  b3:	e8 9a 02 00 00       	call   352 <write>
void
cat(int fd)
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
  b8:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  bf:	00 
  c0:	c7 44 24 04 e0 0a 00 	movl   $0xae0,0x4(%esp)
  c7:	00 
  c8:	89 1c 24             	mov    %ebx,(%esp)
  cb:	e8 7a 02 00 00       	call   34a <read>
  d0:	83 f8 00             	cmp    $0x0,%eax
  d3:	7f cb                	jg     a0 <cat+0x10>
    write(1, buf, n);
  if(n < 0){
  d5:	75 06                	jne    dd <cat+0x4d>
    printf(1, "cat: read error\n");
    exit();
  }
}
  d7:	83 c4 14             	add    $0x14,%esp
  da:	5b                   	pop    %ebx
  db:	5d                   	pop    %ebp
  dc:	c3                   	ret    
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
    write(1, buf, n);
  if(n < 0){
    printf(1, "cat: read error\n");
  dd:	c7 44 24 04 ce 07 00 	movl   $0x7ce,0x4(%esp)
  e4:	00 
  e5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  ec:	e8 7f 03 00 00       	call   470 <printf>
    exit();
  f1:	e8 3c 02 00 00       	call   332 <exit>
  f6:	66 90                	xchg   %ax,%ax
  f8:	66 90                	xchg   %ax,%ax
  fa:	66 90                	xchg   %ax,%ax
  fc:	66 90                	xchg   %ax,%ax
  fe:	66 90                	xchg   %ax,%ax

00000100 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	8b 45 08             	mov    0x8(%ebp),%eax
 106:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 109:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 10a:	89 c2                	mov    %eax,%edx
 10c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 110:	0f b6 19             	movzbl (%ecx),%ebx
 113:	83 c1 01             	add    $0x1,%ecx
 116:	88 1a                	mov    %bl,(%edx)
 118:	83 c2 01             	add    $0x1,%edx
 11b:	84 db                	test   %bl,%bl
 11d:	75 f1                	jne    110 <strcpy+0x10>
    ;
  return os;
}
 11f:	5b                   	pop    %ebx
 120:	5d                   	pop    %ebp
 121:	c3                   	ret    
 122:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000130 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	8b 55 08             	mov    0x8(%ebp),%edx
 136:	56                   	push   %esi
 137:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 13a:	53                   	push   %ebx
  while(*p && *p == *q)
 13b:	0f b6 02             	movzbl (%edx),%eax
 13e:	0f b6 19             	movzbl (%ecx),%ebx
 141:	84 c0                	test   %al,%al
 143:	75 16                	jne    15b <strcmp+0x2b>
 145:	eb 21                	jmp    168 <strcmp+0x38>
 147:	90                   	nop
    p++, q++;
 148:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 14b:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 14f:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 152:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 155:	84 c0                	test   %al,%al
 157:	74 0f                	je     168 <strcmp+0x38>
    p++, q++;
 159:	89 f1                	mov    %esi,%ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 15b:	38 d8                	cmp    %bl,%al
 15d:	74 e9                	je     148 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 15f:	29 d8                	sub    %ebx,%eax
}
 161:	5b                   	pop    %ebx
 162:	5e                   	pop    %esi
 163:	5d                   	pop    %ebp
 164:	c3                   	ret    
 165:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 168:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 16a:	29 d8                	sub    %ebx,%eax
}
 16c:	5b                   	pop    %ebx
 16d:	5e                   	pop    %esi
 16e:	5d                   	pop    %ebp
 16f:	c3                   	ret    

00000170 <strlen>:

uint
strlen(char *s)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 176:	80 39 00             	cmpb   $0x0,(%ecx)
 179:	74 12                	je     18d <strlen+0x1d>
 17b:	31 d2                	xor    %edx,%edx
 17d:	8d 76 00             	lea    0x0(%esi),%esi
 180:	83 c2 01             	add    $0x1,%edx
 183:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 187:	89 d0                	mov    %edx,%eax
 189:	75 f5                	jne    180 <strlen+0x10>
    ;
  return n;
}
 18b:	5d                   	pop    %ebp
 18c:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 18d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 18f:	5d                   	pop    %ebp
 190:	c3                   	ret    
 191:	eb 0d                	jmp    1a0 <memset>
 193:	90                   	nop
 194:	90                   	nop
 195:	90                   	nop
 196:	90                   	nop
 197:	90                   	nop
 198:	90                   	nop
 199:	90                   	nop
 19a:	90                   	nop
 19b:	90                   	nop
 19c:	90                   	nop
 19d:	90                   	nop
 19e:	90                   	nop
 19f:	90                   	nop

000001a0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	8b 55 08             	mov    0x8(%ebp),%edx
 1a6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1aa:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ad:	89 d7                	mov    %edx,%edi
 1af:	fc                   	cld    
 1b0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1b2:	89 d0                	mov    %edx,%eax
 1b4:	5f                   	pop    %edi
 1b5:	5d                   	pop    %ebp
 1b6:	c3                   	ret    
 1b7:	89 f6                	mov    %esi,%esi
 1b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001c0 <strchr>:

char*
strchr(const char *s, char c)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	8b 45 08             	mov    0x8(%ebp),%eax
 1c6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1ca:	0f b6 10             	movzbl (%eax),%edx
 1cd:	84 d2                	test   %dl,%dl
 1cf:	75 11                	jne    1e2 <strchr+0x22>
 1d1:	eb 15                	jmp    1e8 <strchr+0x28>
 1d3:	90                   	nop
 1d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1d8:	83 c0 01             	add    $0x1,%eax
 1db:	0f b6 10             	movzbl (%eax),%edx
 1de:	84 d2                	test   %dl,%dl
 1e0:	74 06                	je     1e8 <strchr+0x28>
    if(*s == c)
 1e2:	38 ca                	cmp    %cl,%dl
 1e4:	75 f2                	jne    1d8 <strchr+0x18>
      return (char*)s;
  return 0;
}
 1e6:	5d                   	pop    %ebp
 1e7:	c3                   	ret    
strchr(const char *s, char c)
{
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
 1e8:	31 c0                	xor    %eax,%eax
}
 1ea:	5d                   	pop    %ebp
 1eb:	90                   	nop
 1ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1f0:	c3                   	ret    
 1f1:	eb 0d                	jmp    200 <gets>
 1f3:	90                   	nop
 1f4:	90                   	nop
 1f5:	90                   	nop
 1f6:	90                   	nop
 1f7:	90                   	nop
 1f8:	90                   	nop
 1f9:	90                   	nop
 1fa:	90                   	nop
 1fb:	90                   	nop
 1fc:	90                   	nop
 1fd:	90                   	nop
 1fe:	90                   	nop
 1ff:	90                   	nop

00000200 <gets>:

char*
gets(char *buf, int max)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	57                   	push   %edi
 204:	56                   	push   %esi
 205:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 206:	31 db                	xor    %ebx,%ebx
  return 0;
}

char*
gets(char *buf, int max)
{
 208:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 20b:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 20e:	8d 73 01             	lea    0x1(%ebx),%esi
 211:	3b 75 0c             	cmp    0xc(%ebp),%esi
 214:	7d 42                	jge    258 <gets+0x58>
    cc = read(0, &c, 1);
 216:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 21d:	00 
 21e:	89 7c 24 04          	mov    %edi,0x4(%esp)
 222:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 229:	e8 1c 01 00 00       	call   34a <read>
    if(cc < 1)
 22e:	85 c0                	test   %eax,%eax
 230:	7e 26                	jle    258 <gets+0x58>
      break;
    buf[i++] = c;
 232:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 236:	89 f3                	mov    %esi,%ebx
 238:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 23b:	3c 0d                	cmp    $0xd,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 23d:	88 44 32 ff          	mov    %al,-0x1(%edx,%esi,1)
    if(c == '\n' || c == '\r')
 241:	74 04                	je     247 <gets+0x47>
 243:	3c 0a                	cmp    $0xa,%al
 245:	75 c7                	jne    20e <gets+0xe>
      break;
  }
  buf[i] = '\0';
 247:	8b 45 08             	mov    0x8(%ebp),%eax
 24a:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 24e:	83 c4 2c             	add    $0x2c,%esp
 251:	5b                   	pop    %ebx
 252:	5e                   	pop    %esi
 253:	5f                   	pop    %edi
 254:	5d                   	pop    %ebp
 255:	c3                   	ret    
 256:	66 90                	xchg   %ax,%ax
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 258:	8b 45 08             	mov    0x8(%ebp),%eax
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
 25b:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 25d:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 261:	83 c4 2c             	add    $0x2c,%esp
 264:	5b                   	pop    %ebx
 265:	5e                   	pop    %esi
 266:	5f                   	pop    %edi
 267:	5d                   	pop    %ebp
 268:	c3                   	ret    
 269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000270 <stat>:

int
stat(char *n, struct stat *st)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 276:	8b 45 08             	mov    0x8(%ebp),%eax
 279:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 280:	00 
  return buf;
}

int
stat(char *n, struct stat *st)
{
 281:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 284:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 287:	89 04 24             	mov    %eax,(%esp)
 28a:	e8 e3 00 00 00       	call   372 <open>
  if(fd < 0)
 28f:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 291:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 293:	78 2b                	js     2c0 <stat+0x50>
    return -1;
  r = fstat(fd, st);
 295:	8b 45 0c             	mov    0xc(%ebp),%eax
 298:	89 1c 24             	mov    %ebx,(%esp)
 29b:	89 44 24 04          	mov    %eax,0x4(%esp)
 29f:	e8 e6 00 00 00       	call   38a <fstat>
  close(fd);
 2a4:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 2a7:	89 c6                	mov    %eax,%esi
  close(fd);
 2a9:	e8 ac 00 00 00       	call   35a <close>
  return r;
}
 2ae:	89 f0                	mov    %esi,%eax
 2b0:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 2b3:	8b 75 fc             	mov    -0x4(%ebp),%esi
 2b6:	89 ec                	mov    %ebp,%esp
 2b8:	5d                   	pop    %ebp
 2b9:	c3                   	ret    
 2ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 2c0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2c5:	eb e7                	jmp    2ae <stat+0x3e>
 2c7:	89 f6                	mov    %esi,%esi
 2c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002d0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2d6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2d7:	0f be 11             	movsbl (%ecx),%edx
 2da:	8d 42 d0             	lea    -0x30(%edx),%eax
 2dd:	3c 09                	cmp    $0x9,%al
 2df:	b8 00 00 00 00       	mov    $0x0,%eax
 2e4:	77 17                	ja     2fd <atoi+0x2d>
 2e6:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 2e8:	83 c1 01             	add    $0x1,%ecx
 2eb:	8d 04 80             	lea    (%eax,%eax,4),%eax
 2ee:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2f2:	0f be 11             	movsbl (%ecx),%edx
 2f5:	8d 5a d0             	lea    -0x30(%edx),%ebx
 2f8:	80 fb 09             	cmp    $0x9,%bl
 2fb:	76 eb                	jbe    2e8 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 2fd:	5b                   	pop    %ebx
 2fe:	5d                   	pop    %ebp
 2ff:	c3                   	ret    

00000300 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 300:	55                   	push   %ebp
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
 301:	31 d2                	xor    %edx,%edx
{
 303:	89 e5                	mov    %esp,%ebp
 305:	56                   	push   %esi
 306:	8b 45 08             	mov    0x8(%ebp),%eax
 309:	53                   	push   %ebx
 30a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 30d:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 310:	85 db                	test   %ebx,%ebx
 312:	7e 12                	jle    326 <memmove+0x26>
 314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 318:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 31c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 31f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 322:	39 da                	cmp    %ebx,%edx
 324:	75 f2                	jne    318 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 326:	5b                   	pop    %ebx
 327:	5e                   	pop    %esi
 328:	5d                   	pop    %ebp
 329:	c3                   	ret    

0000032a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 32a:	b8 01 00 00 00       	mov    $0x1,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <exit>:
SYSCALL(exit)
 332:	b8 02 00 00 00       	mov    $0x2,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <wait>:
SYSCALL(wait)
 33a:	b8 03 00 00 00       	mov    $0x3,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <pipe>:
SYSCALL(pipe)
 342:	b8 04 00 00 00       	mov    $0x4,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <read>:
SYSCALL(read)
 34a:	b8 05 00 00 00       	mov    $0x5,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <write>:
SYSCALL(write)
 352:	b8 10 00 00 00       	mov    $0x10,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <close>:
SYSCALL(close)
 35a:	b8 15 00 00 00       	mov    $0x15,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <kill>:
SYSCALL(kill)
 362:	b8 06 00 00 00       	mov    $0x6,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <exec>:
SYSCALL(exec)
 36a:	b8 07 00 00 00       	mov    $0x7,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <open>:
SYSCALL(open)
 372:	b8 0f 00 00 00       	mov    $0xf,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <mknod>:
SYSCALL(mknod)
 37a:	b8 11 00 00 00       	mov    $0x11,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <unlink>:
SYSCALL(unlink)
 382:	b8 12 00 00 00       	mov    $0x12,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <fstat>:
SYSCALL(fstat)
 38a:	b8 08 00 00 00       	mov    $0x8,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <link>:
SYSCALL(link)
 392:	b8 13 00 00 00       	mov    $0x13,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <mkdir>:
SYSCALL(mkdir)
 39a:	b8 14 00 00 00       	mov    $0x14,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <chdir>:
SYSCALL(chdir)
 3a2:	b8 09 00 00 00       	mov    $0x9,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <dup>:
SYSCALL(dup)
 3aa:	b8 0a 00 00 00       	mov    $0xa,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <getpid>:
SYSCALL(getpid)
 3b2:	b8 0b 00 00 00       	mov    $0xb,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <sbrk>:
SYSCALL(sbrk)
 3ba:	b8 0c 00 00 00       	mov    $0xc,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <sleep>:
SYSCALL(sleep)
 3c2:	b8 0d 00 00 00       	mov    $0xd,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <uptime>:
SYSCALL(uptime)
 3ca:	b8 0e 00 00 00       	mov    $0xe,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <getprocs>:
SYSCALL(getprocs)
 3d2:	b8 16 00 00 00       	mov    $0x16,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    
 3da:	66 90                	xchg   %ax,%ax
 3dc:	66 90                	xchg   %ax,%ax
 3de:	66 90                	xchg   %ax,%ax

000003e0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	57                   	push   %edi
 3e4:	89 c7                	mov    %eax,%edi
 3e6:	56                   	push   %esi
 3e7:	53                   	push   %ebx
 3e8:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3eb:	8b 45 08             	mov    0x8(%ebp),%eax
 3ee:	85 c0                	test   %eax,%eax
 3f0:	74 76                	je     468 <printint+0x88>
 3f2:	89 d0                	mov    %edx,%eax
 3f4:	c1 e8 1f             	shr    $0x1f,%eax
 3f7:	84 c0                	test   %al,%al
 3f9:	74 6d                	je     468 <printint+0x88>
    neg = 1;
    x = -xx;
 3fb:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 3fd:	bb 01 00 00 00       	mov    $0x1,%ebx
    x = -xx;
 402:	f7 d8                	neg    %eax
  } else {
    x = xx;
  }

  i = 0;
 404:	31 f6                	xor    %esi,%esi
 406:	eb 02                	jmp    40a <printint+0x2a>
  do{
    buf[i++] = digits[x % base];
 408:	89 d6                	mov    %edx,%esi
 40a:	31 d2                	xor    %edx,%edx
 40c:	f7 f1                	div    %ecx
 40e:	0f b6 92 fb 07 00 00 	movzbl 0x7fb(%edx),%edx
  }while((x /= base) != 0);
 415:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 417:	88 54 35 d8          	mov    %dl,-0x28(%ebp,%esi,1)
 41b:	8d 56 01             	lea    0x1(%esi),%edx
  }while((x /= base) != 0);
 41e:	75 e8                	jne    408 <printint+0x28>
  if(neg)
 420:	85 db                	test   %ebx,%ebx
 422:	74 08                	je     42c <printint+0x4c>
    buf[i++] = '-';
 424:	c6 44 15 d8 2d       	movb   $0x2d,-0x28(%ebp,%edx,1)
 429:	8d 56 02             	lea    0x2(%esi),%edx

  while(--i >= 0)
 42c:	8d 5a ff             	lea    -0x1(%edx),%ebx
 42f:	83 fb ff             	cmp    $0xffffffff,%ebx
 432:	8d 75 d7             	lea    -0x29(%ebp),%esi
 435:	74 25                	je     45c <printint+0x7c>
 437:	90                   	nop
 438:	0f b6 44 1d d8       	movzbl -0x28(%ebp,%ebx,1),%eax
 43d:	83 eb 01             	sub    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 440:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 447:	00 
 448:	89 74 24 04          	mov    %esi,0x4(%esp)
 44c:	89 3c 24             	mov    %edi,(%esp)
 44f:	88 45 d7             	mov    %al,-0x29(%ebp)
 452:	e8 fb fe ff ff       	call   352 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 457:	83 fb ff             	cmp    $0xffffffff,%ebx
 45a:	75 dc                	jne    438 <printint+0x58>
    putc(fd, buf[i]);
}
 45c:	83 c4 3c             	add    $0x3c,%esp
 45f:	5b                   	pop    %ebx
 460:	5e                   	pop    %esi
 461:	5f                   	pop    %edi
 462:	5d                   	pop    %ebp
 463:	c3                   	ret    
 464:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 468:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 46a:	31 db                	xor    %ebx,%ebx
 46c:	eb 96                	jmp    404 <printint+0x24>
 46e:	66 90                	xchg   %ax,%ax

00000470 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 470:	55                   	push   %ebp
 471:	89 e5                	mov    %esp,%ebp
 473:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 474:	31 ff                	xor    %edi,%edi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 476:	56                   	push   %esi
 477:	53                   	push   %ebx
 478:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 47b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 47e:	8d 55 10             	lea    0x10(%ebp),%edx
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 481:	8b 75 08             	mov    0x8(%ebp),%esi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 484:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 487:	0f be 03             	movsbl (%ebx),%eax
    putc(fd, buf[i]);
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
 48a:	83 c3 01             	add    $0x1,%ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 48d:	84 c0                	test   %al,%al
 48f:	75 39                	jne    4ca <printf+0x5a>
 491:	e9 c2 00 00 00       	jmp    558 <printf+0xe8>
 496:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 498:	83 fa 25             	cmp    $0x25,%edx
 49b:	0f 84 bf 00 00 00    	je     560 <printf+0xf0>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4a1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 4a4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4ab:	00 
 4ac:	89 44 24 04          	mov    %eax,0x4(%esp)
 4b0:	89 34 24             	mov    %esi,(%esp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 4b3:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4b6:	e8 97 fe ff ff       	call   352 <write>
 4bb:	83 c3 01             	add    $0x1,%ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4be:	0f be 43 ff          	movsbl -0x1(%ebx),%eax
 4c2:	84 c0                	test   %al,%al
 4c4:	0f 84 8e 00 00 00    	je     558 <printf+0xe8>
    c = fmt[i] & 0xff;
 4ca:	0f b6 d0             	movzbl %al,%edx
    if(state == 0){
 4cd:	85 ff                	test   %edi,%edi
 4cf:	74 c7                	je     498 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4d1:	83 ff 25             	cmp    $0x25,%edi
 4d4:	75 e5                	jne    4bb <printf+0x4b>
      if(c == 'd'){
 4d6:	83 fa 64             	cmp    $0x64,%edx
 4d9:	0f 84 31 01 00 00    	je     610 <printf+0x1a0>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 4df:	25 f7 00 00 00       	and    $0xf7,%eax
 4e4:	83 f8 70             	cmp    $0x70,%eax
 4e7:	0f 84 83 00 00 00    	je     570 <printf+0x100>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 4ed:	83 fa 73             	cmp    $0x73,%edx
 4f0:	0f 84 a2 00 00 00    	je     598 <printf+0x128>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4f6:	83 fa 63             	cmp    $0x63,%edx
 4f9:	0f 84 35 01 00 00    	je     634 <printf+0x1c4>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4ff:	83 fa 25             	cmp    $0x25,%edx
 502:	0f 84 e0 00 00 00    	je     5e8 <printf+0x178>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 508:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 50b:	83 c3 01             	add    $0x1,%ebx
 50e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 515:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 516:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 518:	89 44 24 04          	mov    %eax,0x4(%esp)
 51c:	89 34 24             	mov    %esi,(%esp)
 51f:	89 55 d0             	mov    %edx,-0x30(%ebp)
 522:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 526:	e8 27 fe ff ff       	call   352 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 52b:	8b 55 d0             	mov    -0x30(%ebp),%edx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 52e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 531:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 538:	00 
 539:	89 44 24 04          	mov    %eax,0x4(%esp)
 53d:	89 34 24             	mov    %esi,(%esp)
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 540:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 543:	e8 0a fe ff ff       	call   352 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 548:	0f be 43 ff          	movsbl -0x1(%ebx),%eax
 54c:	84 c0                	test   %al,%al
 54e:	0f 85 76 ff ff ff    	jne    4ca <printf+0x5a>
 554:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 558:	83 c4 3c             	add    $0x3c,%esp
 55b:	5b                   	pop    %ebx
 55c:	5e                   	pop    %esi
 55d:	5f                   	pop    %edi
 55e:	5d                   	pop    %ebp
 55f:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 560:	bf 25 00 00 00       	mov    $0x25,%edi
 565:	e9 51 ff ff ff       	jmp    4bb <printf+0x4b>
 56a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 570:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 573:	b9 10 00 00 00       	mov    $0x10,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 578:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 57a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 581:	8b 10                	mov    (%eax),%edx
 583:	89 f0                	mov    %esi,%eax
 585:	e8 56 fe ff ff       	call   3e0 <printint>
        ap++;
 58a:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 58e:	e9 28 ff ff ff       	jmp    4bb <printf+0x4b>
 593:	90                   	nop
 594:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 598:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        ap++;
        if(s == 0)
          s = "(null)";
 59b:	b8 f4 07 00 00       	mov    $0x7f4,%eax
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 5a0:	8b 3a                	mov    (%edx),%edi
        ap++;
 5a2:	83 c2 04             	add    $0x4,%edx
 5a5:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
          s = "(null)";
 5a8:	85 ff                	test   %edi,%edi
 5aa:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 5ad:	0f b6 07             	movzbl (%edi),%eax
 5b0:	84 c0                	test   %al,%al
 5b2:	74 28                	je     5dc <printf+0x16c>
 5b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5b8:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5bb:	8d 45 e3             	lea    -0x1d(%ebp),%eax
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 5be:	83 c7 01             	add    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5c1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5c8:	00 
 5c9:	89 44 24 04          	mov    %eax,0x4(%esp)
 5cd:	89 34 24             	mov    %esi,(%esp)
 5d0:	e8 7d fd ff ff       	call   352 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5d5:	0f b6 07             	movzbl (%edi),%eax
 5d8:	84 c0                	test   %al,%al
 5da:	75 dc                	jne    5b8 <printf+0x148>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5dc:	31 ff                	xor    %edi,%edi
 5de:	e9 d8 fe ff ff       	jmp    4bb <printf+0x4b>
 5e3:	90                   	nop
 5e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5e8:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5eb:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5ed:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5f4:	00 
 5f5:	89 44 24 04          	mov    %eax,0x4(%esp)
 5f9:	89 34 24             	mov    %esi,(%esp)
 5fc:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 600:	e8 4d fd ff ff       	call   352 <write>
 605:	e9 b1 fe ff ff       	jmp    4bb <printf+0x4b>
 60a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 610:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 613:	b9 0a 00 00 00       	mov    $0xa,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 618:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 61b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 622:	8b 10                	mov    (%eax),%edx
 624:	89 f0                	mov    %esi,%eax
 626:	e8 b5 fd ff ff       	call   3e0 <printint>
        ap++;
 62b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 62f:	e9 87 fe ff ff       	jmp    4bb <printf+0x4b>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 634:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 637:	31 ff                	xor    %edi,%edi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 639:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 63b:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 642:	00 
 643:	89 34 24             	mov    %esi,(%esp)
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 646:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 649:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 64c:	89 44 24 04          	mov    %eax,0x4(%esp)
 650:	e8 fd fc ff ff       	call   352 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 655:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 659:	e9 5d fe ff ff       	jmp    4bb <printf+0x4b>
 65e:	66 90                	xchg   %ax,%ax

00000660 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 660:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 661:	a1 c0 0a 00 00       	mov    0xac0,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 666:	89 e5                	mov    %esp,%ebp
 668:	57                   	push   %edi
 669:	56                   	push   %esi
 66a:	53                   	push   %ebx
 66b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 66e:	8b 08                	mov    (%eax),%ecx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 670:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 673:	39 d0                	cmp    %edx,%eax
 675:	72 11                	jb     688 <free+0x28>
 677:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 678:	39 c8                	cmp    %ecx,%eax
 67a:	72 04                	jb     680 <free+0x20>
 67c:	39 ca                	cmp    %ecx,%edx
 67e:	72 10                	jb     690 <free+0x30>
 680:	89 c8                	mov    %ecx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 682:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 684:	8b 08                	mov    (%eax),%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 686:	73 f0                	jae    678 <free+0x18>
 688:	39 ca                	cmp    %ecx,%edx
 68a:	72 04                	jb     690 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 68c:	39 c8                	cmp    %ecx,%eax
 68e:	72 f0                	jb     680 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 690:	8b 73 fc             	mov    -0x4(%ebx),%esi
 693:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 696:	39 cf                	cmp    %ecx,%edi
 698:	74 1e                	je     6b8 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 69a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 69d:	8b 48 04             	mov    0x4(%eax),%ecx
 6a0:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 6a3:	39 f2                	cmp    %esi,%edx
 6a5:	74 28                	je     6cf <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6a7:	89 10                	mov    %edx,(%eax)
  freep = p;
 6a9:	a3 c0 0a 00 00       	mov    %eax,0xac0
}
 6ae:	5b                   	pop    %ebx
 6af:	5e                   	pop    %esi
 6b0:	5f                   	pop    %edi
 6b1:	5d                   	pop    %ebp
 6b2:	c3                   	ret    
 6b3:	90                   	nop
 6b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6b8:	03 71 04             	add    0x4(%ecx),%esi
 6bb:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6be:	8b 08                	mov    (%eax),%ecx
 6c0:	8b 09                	mov    (%ecx),%ecx
 6c2:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6c5:	8b 48 04             	mov    0x4(%eax),%ecx
 6c8:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 6cb:	39 f2                	cmp    %esi,%edx
 6cd:	75 d8                	jne    6a7 <free+0x47>
    p->s.size += bp->s.size;
 6cf:	03 4b fc             	add    -0x4(%ebx),%ecx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 6d2:	a3 c0 0a 00 00       	mov    %eax,0xac0
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 6d7:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6da:	8b 53 f8             	mov    -0x8(%ebx),%edx
 6dd:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 6df:	5b                   	pop    %ebx
 6e0:	5e                   	pop    %esi
 6e1:	5f                   	pop    %edi
 6e2:	5d                   	pop    %ebp
 6e3:	c3                   	ret    
 6e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000006f0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6f0:	55                   	push   %ebp
 6f1:	89 e5                	mov    %esp,%ebp
 6f3:	57                   	push   %edi
 6f4:	56                   	push   %esi
 6f5:	53                   	push   %ebx
 6f6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6f9:	8b 55 08             	mov    0x8(%ebp),%edx
  if((prevp = freep) == 0){
 6fc:	8b 0d c0 0a 00 00    	mov    0xac0,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 702:	83 c2 07             	add    $0x7,%edx
 705:	c1 ea 03             	shr    $0x3,%edx
  if((prevp = freep) == 0){
 708:	85 c9                	test   %ecx,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 70a:	8d 5a 01             	lea    0x1(%edx),%ebx
  if((prevp = freep) == 0){
 70d:	0f 84 93 00 00 00    	je     7a6 <malloc+0xb6>
 713:	8b 01                	mov    (%ecx),%eax
 715:	8b 78 04             	mov    0x4(%eax),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 718:	39 fb                	cmp    %edi,%ebx
 71a:	76 64                	jbe    780 <malloc+0x90>
 71c:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 723:	eb 0c                	jmp    731 <malloc+0x41>
 725:	8d 76 00             	lea    0x0(%esi),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 728:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 72a:	8b 78 04             	mov    0x4(%eax),%edi
 72d:	39 fb                	cmp    %edi,%ebx
 72f:	76 4f                	jbe    780 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 731:	3b 05 c0 0a 00 00    	cmp    0xac0,%eax
 737:	89 c1                	mov    %eax,%ecx
 739:	75 ed                	jne    728 <malloc+0x38>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 73b:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 741:	b8 00 80 00 00       	mov    $0x8000,%eax
 746:	0f 43 c6             	cmovae %esi,%eax
 749:	bf 00 10 00 00       	mov    $0x1000,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 74e:	89 04 24             	mov    %eax,(%esp)
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 751:	0f 43 fb             	cmovae %ebx,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 754:	e8 61 fc ff ff       	call   3ba <sbrk>
  if(p == (char*)-1)
 759:	83 f8 ff             	cmp    $0xffffffff,%eax
 75c:	74 18                	je     776 <malloc+0x86>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 75e:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 761:	83 c0 08             	add    $0x8,%eax
 764:	89 04 24             	mov    %eax,(%esp)
 767:	e8 f4 fe ff ff       	call   660 <free>
  return freep;
 76c:	8b 0d c0 0a 00 00    	mov    0xac0,%ecx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 772:	85 c9                	test   %ecx,%ecx
 774:	75 b2                	jne    728 <malloc+0x38>
        return 0;
 776:	31 c0                	xor    %eax,%eax
 778:	eb 1e                	jmp    798 <malloc+0xa8>
 77a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 780:	39 fb                	cmp    %edi,%ebx
 782:	74 1c                	je     7a0 <malloc+0xb0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 784:	29 df                	sub    %ebx,%edi
 786:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 789:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 78c:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 78f:	89 0d c0 0a 00 00    	mov    %ecx,0xac0
      return (void*)(p + 1);
 795:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 798:	83 c4 1c             	add    $0x1c,%esp
 79b:	5b                   	pop    %ebx
 79c:	5e                   	pop    %esi
 79d:	5f                   	pop    %edi
 79e:	5d                   	pop    %ebp
 79f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 7a0:	8b 10                	mov    (%eax),%edx
 7a2:	89 11                	mov    %edx,(%ecx)
 7a4:	eb e9                	jmp    78f <malloc+0x9f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 7a6:	c7 05 c0 0a 00 00 c4 	movl   $0xac4,0xac0
 7ad:	0a 00 00 
    base.s.size = 0;
 7b0:	b8 c4 0a 00 00       	mov    $0xac4,%eax
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 7b5:	c7 05 c4 0a 00 00 c4 	movl   $0xac4,0xac4
 7bc:	0a 00 00 
    base.s.size = 0;
 7bf:	c7 05 c8 0a 00 00 00 	movl   $0x0,0xac8
 7c6:	00 00 00 
 7c9:	e9 4e ff ff ff       	jmp    71c <malloc+0x2c>
