
_grep:     file format elf32-i386


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
   5:	53                   	push   %ebx
   6:	83 e4 f0             	and    $0xfffffff0,%esp
   9:	83 ec 20             	sub    $0x20,%esp
   c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  int fd, i;
  char *pattern;

  if(argc <= 1){
   f:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  13:	0f 8e 8b 00 00 00    	jle    a4 <main+0xa4>
    printf(2, "usage: grep pattern [file ...]\n");
    exit();
  }
  pattern = argv[1];
  19:	8b 43 04             	mov    0x4(%ebx),%eax
    }
  }
}

int
main(int argc, char *argv[])
  1c:	83 c3 08             	add    $0x8,%ebx
  1f:	be 02 00 00 00       	mov    $0x2,%esi
    printf(2, "usage: grep pattern [file ...]\n");
    exit();
  }
  pattern = argv[1];

  if(argc <= 2){
  24:	83 7d 08 02          	cmpl   $0x2,0x8(%ebp)

  if(argc <= 1){
    printf(2, "usage: grep pattern [file ...]\n");
    exit();
  }
  pattern = argv[1];
  28:	89 44 24 1c          	mov    %eax,0x1c(%esp)

  if(argc <= 2){
  2c:	74 61                	je     8f <main+0x8f>
  2e:	66 90                	xchg   %ax,%ax
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  30:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  37:	00 
  38:	8b 03                	mov    (%ebx),%eax
  3a:	89 04 24             	mov    %eax,(%esp)
  3d:	e8 60 05 00 00       	call   5a2 <open>
  42:	85 c0                	test   %eax,%eax
  44:	89 c7                	mov    %eax,%edi
  46:	78 28                	js     70 <main+0x70>
      printf(1, "grep: cannot open %s\n", argv[i]);
      exit();
    }
    grep(pattern, fd);
  48:	89 44 24 04          	mov    %eax,0x4(%esp)
  4c:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  if(argc <= 2){
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
  50:	83 c6 01             	add    $0x1,%esi
  53:	83 c3 04             	add    $0x4,%ebx
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "grep: cannot open %s\n", argv[i]);
      exit();
    }
    grep(pattern, fd);
  56:	89 04 24             	mov    %eax,(%esp)
  59:	e8 c2 01 00 00       	call   220 <grep>
    close(fd);
  5e:	89 3c 24             	mov    %edi,(%esp)
  61:	e8 24 05 00 00       	call   58a <close>
  if(argc <= 2){
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
  66:	39 75 08             	cmp    %esi,0x8(%ebp)
  69:	7f c5                	jg     30 <main+0x30>
      exit();
    }
    grep(pattern, fd);
    close(fd);
  }
  exit();
  6b:	e8 f2 04 00 00       	call   562 <exit>
    exit();
  }

  for(i = 2; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "grep: cannot open %s\n", argv[i]);
  70:	8b 03                	mov    (%ebx),%eax
  72:	c7 44 24 04 20 0a 00 	movl   $0xa20,0x4(%esp)
  79:	00 
  7a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  81:	89 44 24 08          	mov    %eax,0x8(%esp)
  85:	e8 16 06 00 00       	call   6a0 <printf>
      exit();
  8a:	e8 d3 04 00 00       	call   562 <exit>
    exit();
  }
  pattern = argv[1];

  if(argc <= 2){
    grep(pattern, 0);
  8f:	89 04 24             	mov    %eax,(%esp)
  92:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  99:	00 
  9a:	e8 81 01 00 00       	call   220 <grep>
    exit();
  9f:	e8 be 04 00 00       	call   562 <exit>
{
  int fd, i;
  char *pattern;

  if(argc <= 1){
    printf(2, "usage: grep pattern [file ...]\n");
  a4:	c7 44 24 04 00 0a 00 	movl   $0xa00,0x4(%esp)
  ab:	00 
  ac:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  b3:	e8 e8 05 00 00       	call   6a0 <printf>
    exit();
  b8:	e8 a5 04 00 00       	call   562 <exit>
  bd:	66 90                	xchg   %ax,%ax
  bf:	90                   	nop

000000c0 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	57                   	push   %edi
  c4:	56                   	push   %esi
  c5:	53                   	push   %ebx
  c6:	83 ec 1c             	sub    $0x1c,%esp
  c9:	8b 75 08             	mov    0x8(%ebp),%esi
  cc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cf:	8b 5d 10             	mov    0x10(%ebp),%ebx
  d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
  d8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  dc:	89 3c 24             	mov    %edi,(%esp)
  df:	e8 3c 00 00 00       	call   120 <matchhere>
  e4:	85 c0                	test   %eax,%eax
  e6:	75 20                	jne    108 <matchstar+0x48>
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  e8:	0f be 03             	movsbl (%ebx),%eax
  eb:	84 c0                	test   %al,%al
  ed:	74 0c                	je     fb <matchstar+0x3b>
  ef:	83 c3 01             	add    $0x1,%ebx
  f2:	39 f0                	cmp    %esi,%eax
  f4:	74 e2                	je     d8 <matchstar+0x18>
  f6:	83 fe 2e             	cmp    $0x2e,%esi
  f9:	74 dd                	je     d8 <matchstar+0x18>
  return 0;
}
  fb:	83 c4 1c             	add    $0x1c,%esp
{
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  return 0;
  fe:	31 c0                	xor    %eax,%eax
}
 100:	5b                   	pop    %ebx
 101:	5e                   	pop    %esi
 102:	5f                   	pop    %edi
 103:	5d                   	pop    %ebp
 104:	c3                   	ret    
 105:	8d 76 00             	lea    0x0(%esi),%esi
 108:	83 c4 1c             	add    $0x1c,%esp
// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
 10b:	b8 01 00 00 00       	mov    $0x1,%eax
  }while(*text!='\0' && (*text++==c || c=='.'));
  return 0;
}
 110:	5b                   	pop    %ebx
 111:	5e                   	pop    %esi
 112:	5f                   	pop    %edi
 113:	5d                   	pop    %ebp
 114:	c3                   	ret    
 115:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000120 <matchhere>:
  return 0;
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	53                   	push   %ebx
 124:	83 ec 14             	sub    $0x14,%esp
 127:	8b 55 08             	mov    0x8(%ebp),%edx
 12a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  if(re[0] == '\0')
 12d:	0f be 02             	movsbl (%edx),%eax
 130:	84 c0                	test   %al,%al
 132:	75 20                	jne    154 <matchhere+0x34>
 134:	eb 42                	jmp    178 <matchhere+0x58>
 136:	66 90                	xchg   %ax,%ax
    return 1;
  if(re[1] == '*')
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 138:	0f b6 19             	movzbl (%ecx),%ebx
 13b:	84 db                	test   %bl,%bl
 13d:	74 31                	je     170 <matchhere+0x50>
 13f:	3c 2e                	cmp    $0x2e,%al
 141:	74 04                	je     147 <matchhere+0x27>
 143:	38 d8                	cmp    %bl,%al
 145:	75 29                	jne    170 <matchhere+0x50>
    return matchhere(re+1, text+1);
 147:	83 c2 01             	add    $0x1,%edx
 14a:	83 c1 01             	add    $0x1,%ecx
}

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  if(re[0] == '\0')
 14d:	0f be 02             	movsbl (%edx),%eax
 150:	84 c0                	test   %al,%al
 152:	74 24                	je     178 <matchhere+0x58>
    return 1;
  if(re[1] == '*')
 154:	0f b6 5a 01          	movzbl 0x1(%edx),%ebx
 158:	80 fb 2a             	cmp    $0x2a,%bl
 15b:	74 2b                	je     188 <matchhere+0x68>
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
 15d:	3c 24                	cmp    $0x24,%al
 15f:	75 d7                	jne    138 <matchhere+0x18>
 161:	84 db                	test   %bl,%bl
 163:	74 3c                	je     1a1 <matchhere+0x81>
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 165:	0f b6 19             	movzbl (%ecx),%ebx
 168:	84 db                	test   %bl,%bl
 16a:	75 d7                	jne    143 <matchhere+0x23>
 16c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return matchhere(re+1, text+1);
  return 0;
 170:	31 c0                	xor    %eax,%eax
}
 172:	83 c4 14             	add    $0x14,%esp
 175:	5b                   	pop    %ebx
 176:	5d                   	pop    %ebp
 177:	c3                   	ret    
 178:	83 c4 14             	add    $0x14,%esp

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
  if(re[0] == '\0')
    return 1;
 17b:	b8 01 00 00 00       	mov    $0x1,%eax
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    return matchhere(re+1, text+1);
  return 0;
}
 180:	5b                   	pop    %ebx
 181:	5d                   	pop    %ebp
 182:	c3                   	ret    
 183:	90                   	nop
 184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
int matchhere(char *re, char *text)
{
  if(re[0] == '\0')
    return 1;
  if(re[1] == '*')
    return matchstar(re[0], re+2, text);
 188:	83 c2 02             	add    $0x2,%edx
 18b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 18f:	89 54 24 04          	mov    %edx,0x4(%esp)
 193:	89 04 24             	mov    %eax,(%esp)
 196:	e8 25 ff ff ff       	call   c0 <matchstar>
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    return matchhere(re+1, text+1);
  return 0;
}
 19b:	83 c4 14             	add    $0x14,%esp
 19e:	5b                   	pop    %ebx
 19f:	5d                   	pop    %ebp
 1a0:	c3                   	ret    
  if(re[0] == '\0')
    return 1;
  if(re[1] == '*')
    return matchstar(re[0], re+2, text);
  if(re[0] == '$' && re[1] == '\0')
    return *text == '\0';
 1a1:	31 c0                	xor    %eax,%eax
 1a3:	80 39 00             	cmpb   $0x0,(%ecx)
 1a6:	0f 94 c0             	sete   %al
 1a9:	eb c7                	jmp    172 <matchhere+0x52>
 1ab:	90                   	nop
 1ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001b0 <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	56                   	push   %esi
 1b4:	53                   	push   %ebx
 1b5:	83 ec 10             	sub    $0x10,%esp
 1b8:	8b 75 08             	mov    0x8(%ebp),%esi
 1bb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(re[0] == '^')
 1be:	80 3e 5e             	cmpb   $0x5e,(%esi)
 1c1:	74 3d                	je     200 <match+0x50>
 1c3:	90                   	nop
 1c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return matchhere(re+1, text);
  do{  // must look at empty string
    if(matchhere(re, text))
 1c8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 1cc:	89 34 24             	mov    %esi,(%esp)
 1cf:	e8 4c ff ff ff       	call   120 <matchhere>
 1d4:	85 c0                	test   %eax,%eax
 1d6:	75 18                	jne    1f0 <match+0x40>
      return 1;
  }while(*text++ != '\0');
 1d8:	0f b6 03             	movzbl (%ebx),%eax
 1db:	83 c3 01             	add    $0x1,%ebx
 1de:	84 c0                	test   %al,%al
 1e0:	75 e6                	jne    1c8 <match+0x18>
  return 0;
}
 1e2:	83 c4 10             	add    $0x10,%esp
    return matchhere(re+1, text);
  do{  // must look at empty string
    if(matchhere(re, text))
      return 1;
  }while(*text++ != '\0');
  return 0;
 1e5:	31 c0                	xor    %eax,%eax
}
 1e7:	5b                   	pop    %ebx
 1e8:	5e                   	pop    %esi
 1e9:	5d                   	pop    %ebp
 1ea:	c3                   	ret    
 1eb:	90                   	nop
 1ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1f0:	83 c4 10             	add    $0x10,%esp
{
  if(re[0] == '^')
    return matchhere(re+1, text);
  do{  // must look at empty string
    if(matchhere(re, text))
      return 1;
 1f3:	b8 01 00 00 00       	mov    $0x1,%eax
  }while(*text++ != '\0');
  return 0;
}
 1f8:	5b                   	pop    %ebx
 1f9:	5e                   	pop    %esi
 1fa:	5d                   	pop    %ebp
 1fb:	c3                   	ret    
 1fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

int
match(char *re, char *text)
{
  if(re[0] == '^')
    return matchhere(re+1, text);
 200:	83 c6 01             	add    $0x1,%esi
 203:	89 75 08             	mov    %esi,0x8(%ebp)
  do{  // must look at empty string
    if(matchhere(re, text))
      return 1;
  }while(*text++ != '\0');
  return 0;
}
 206:	83 c4 10             	add    $0x10,%esp
 209:	5b                   	pop    %ebx
 20a:	5e                   	pop    %esi
 20b:	5d                   	pop    %ebp

int
match(char *re, char *text)
{
  if(re[0] == '^')
    return matchhere(re+1, text);
 20c:	e9 0f ff ff ff       	jmp    120 <matchhere>
 211:	eb 0d                	jmp    220 <grep>
 213:	90                   	nop
 214:	90                   	nop
 215:	90                   	nop
 216:	90                   	nop
 217:	90                   	nop
 218:	90                   	nop
 219:	90                   	nop
 21a:	90                   	nop
 21b:	90                   	nop
 21c:	90                   	nop
 21d:	90                   	nop
 21e:	90                   	nop
 21f:	90                   	nop

00000220 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	57                   	push   %edi
 224:	56                   	push   %esi
 225:	53                   	push   %ebx
 226:	83 ec 2c             	sub    $0x2c,%esp
 229:	8b 75 08             	mov    0x8(%ebp),%esi
  int n, m;
  char *p, *q;

  m = 0;
 22c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
 233:	90                   	nop
 234:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 238:	b8 ff 03 00 00       	mov    $0x3ff,%eax
 23d:	2b 45 e4             	sub    -0x1c(%ebp),%eax
 240:	89 44 24 08          	mov    %eax,0x8(%esp)
 244:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 247:	05 e0 0d 00 00       	add    $0xde0,%eax
 24c:	89 44 24 04          	mov    %eax,0x4(%esp)
 250:	8b 45 0c             	mov    0xc(%ebp),%eax
 253:	89 04 24             	mov    %eax,(%esp)
 256:	e8 1f 03 00 00       	call   57a <read>
 25b:	85 c0                	test   %eax,%eax
 25d:	0f 8e b9 00 00 00    	jle    31c <grep+0xfc>
    m += n;
 263:	01 45 e4             	add    %eax,-0x1c(%ebp)
    buf[m] = '\0';
    p = buf;
 266:	bb e0 0d 00 00       	mov    $0xde0,%ebx
  char *p, *q;

  m = 0;
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
    m += n;
    buf[m] = '\0';
 26b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 26e:	c6 80 e0 0d 00 00 00 	movb   $0x0,0xde0(%eax)
 275:	8d 76 00             	lea    0x0(%esi),%esi
    p = buf;
    while((q = strchr(p, '\n')) != 0){
 278:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
 27f:	00 
 280:	89 1c 24             	mov    %ebx,(%esp)
 283:	e8 68 01 00 00       	call   3f0 <strchr>
 288:	85 c0                	test   %eax,%eax
 28a:	89 c7                	mov    %eax,%edi
 28c:	74 42                	je     2d0 <grep+0xb0>
      *q = 0;
 28e:	c6 07 00             	movb   $0x0,(%edi)
      if(match(pattern, p)){
 291:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 295:	89 34 24             	mov    %esi,(%esp)
 298:	e8 13 ff ff ff       	call   1b0 <match>
 29d:	85 c0                	test   %eax,%eax
 29f:	75 07                	jne    2a8 <grep+0x88>
 2a1:	8d 5f 01             	lea    0x1(%edi),%ebx
 2a4:	eb d2                	jmp    278 <grep+0x58>
 2a6:	66 90                	xchg   %ax,%ax
        *q = '\n';
 2a8:	c6 07 0a             	movb   $0xa,(%edi)
        write(1, p, q+1 - p);
 2ab:	83 c7 01             	add    $0x1,%edi
 2ae:	89 f8                	mov    %edi,%eax
 2b0:	29 d8                	sub    %ebx,%eax
 2b2:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 2b6:	89 fb                	mov    %edi,%ebx
 2b8:	89 44 24 08          	mov    %eax,0x8(%esp)
 2bc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2c3:	e8 ba 02 00 00       	call   582 <write>
 2c8:	eb ae                	jmp    278 <grep+0x58>
 2ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      }
      p = q+1;
    }
    if(p == buf)
 2d0:	81 fb e0 0d 00 00    	cmp    $0xde0,%ebx
 2d6:	74 38                	je     310 <grep+0xf0>
      m = 0;
    if(m > 0){
 2d8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 2db:	85 c0                	test   %eax,%eax
 2dd:	0f 8e 55 ff ff ff    	jle    238 <grep+0x18>
      m -= p - buf;
 2e3:	b8 e0 0d 00 00       	mov    $0xde0,%eax
 2e8:	29 d8                	sub    %ebx,%eax
 2ea:	01 45 e4             	add    %eax,-0x1c(%ebp)
      memmove(buf, p, m);
 2ed:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 2f0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 2f4:	c7 04 24 e0 0d 00 00 	movl   $0xde0,(%esp)
 2fb:	89 44 24 08          	mov    %eax,0x8(%esp)
 2ff:	e8 2c 02 00 00       	call   530 <memmove>
 304:	e9 2f ff ff ff       	jmp    238 <grep+0x18>
 309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        write(1, p, q+1 - p);
      }
      p = q+1;
    }
    if(p == buf)
      m = 0;
 310:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
 317:	e9 1c ff ff ff       	jmp    238 <grep+0x18>
    if(m > 0){
      m -= p - buf;
      memmove(buf, p, m);
    }
  }
}
 31c:	83 c4 2c             	add    $0x2c,%esp
 31f:	5b                   	pop    %ebx
 320:	5e                   	pop    %esi
 321:	5f                   	pop    %edi
 322:	5d                   	pop    %ebp
 323:	c3                   	ret    
 324:	66 90                	xchg   %ax,%ax
 326:	66 90                	xchg   %ax,%ax
 328:	66 90                	xchg   %ax,%ax
 32a:	66 90                	xchg   %ax,%ax
 32c:	66 90                	xchg   %ax,%ax
 32e:	66 90                	xchg   %ax,%ax

00000330 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	8b 45 08             	mov    0x8(%ebp),%eax
 336:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 339:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 33a:	89 c2                	mov    %eax,%edx
 33c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 340:	0f b6 19             	movzbl (%ecx),%ebx
 343:	83 c1 01             	add    $0x1,%ecx
 346:	88 1a                	mov    %bl,(%edx)
 348:	83 c2 01             	add    $0x1,%edx
 34b:	84 db                	test   %bl,%bl
 34d:	75 f1                	jne    340 <strcpy+0x10>
    ;
  return os;
}
 34f:	5b                   	pop    %ebx
 350:	5d                   	pop    %ebp
 351:	c3                   	ret    
 352:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000360 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	8b 55 08             	mov    0x8(%ebp),%edx
 366:	56                   	push   %esi
 367:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 36a:	53                   	push   %ebx
  while(*p && *p == *q)
 36b:	0f b6 02             	movzbl (%edx),%eax
 36e:	0f b6 19             	movzbl (%ecx),%ebx
 371:	84 c0                	test   %al,%al
 373:	75 16                	jne    38b <strcmp+0x2b>
 375:	eb 21                	jmp    398 <strcmp+0x38>
 377:	90                   	nop
    p++, q++;
 378:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 37b:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 37f:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 382:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 385:	84 c0                	test   %al,%al
 387:	74 0f                	je     398 <strcmp+0x38>
    p++, q++;
 389:	89 f1                	mov    %esi,%ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 38b:	38 d8                	cmp    %bl,%al
 38d:	74 e9                	je     378 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 38f:	29 d8                	sub    %ebx,%eax
}
 391:	5b                   	pop    %ebx
 392:	5e                   	pop    %esi
 393:	5d                   	pop    %ebp
 394:	c3                   	ret    
 395:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 398:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 39a:	29 d8                	sub    %ebx,%eax
}
 39c:	5b                   	pop    %ebx
 39d:	5e                   	pop    %esi
 39e:	5d                   	pop    %ebp
 39f:	c3                   	ret    

000003a0 <strlen>:

uint
strlen(char *s)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 3a6:	80 39 00             	cmpb   $0x0,(%ecx)
 3a9:	74 12                	je     3bd <strlen+0x1d>
 3ab:	31 d2                	xor    %edx,%edx
 3ad:	8d 76 00             	lea    0x0(%esi),%esi
 3b0:	83 c2 01             	add    $0x1,%edx
 3b3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 3b7:	89 d0                	mov    %edx,%eax
 3b9:	75 f5                	jne    3b0 <strlen+0x10>
    ;
  return n;
}
 3bb:	5d                   	pop    %ebp
 3bc:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 3bd:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 3bf:	5d                   	pop    %ebp
 3c0:	c3                   	ret    
 3c1:	eb 0d                	jmp    3d0 <memset>
 3c3:	90                   	nop
 3c4:	90                   	nop
 3c5:	90                   	nop
 3c6:	90                   	nop
 3c7:	90                   	nop
 3c8:	90                   	nop
 3c9:	90                   	nop
 3ca:	90                   	nop
 3cb:	90                   	nop
 3cc:	90                   	nop
 3cd:	90                   	nop
 3ce:	90                   	nop
 3cf:	90                   	nop

000003d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	8b 55 08             	mov    0x8(%ebp),%edx
 3d6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 3d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3da:	8b 45 0c             	mov    0xc(%ebp),%eax
 3dd:	89 d7                	mov    %edx,%edi
 3df:	fc                   	cld    
 3e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 3e2:	89 d0                	mov    %edx,%eax
 3e4:	5f                   	pop    %edi
 3e5:	5d                   	pop    %ebp
 3e6:	c3                   	ret    
 3e7:	89 f6                	mov    %esi,%esi
 3e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003f0 <strchr>:

char*
strchr(const char *s, char c)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	8b 45 08             	mov    0x8(%ebp),%eax
 3f6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 3fa:	0f b6 10             	movzbl (%eax),%edx
 3fd:	84 d2                	test   %dl,%dl
 3ff:	75 11                	jne    412 <strchr+0x22>
 401:	eb 15                	jmp    418 <strchr+0x28>
 403:	90                   	nop
 404:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 408:	83 c0 01             	add    $0x1,%eax
 40b:	0f b6 10             	movzbl (%eax),%edx
 40e:	84 d2                	test   %dl,%dl
 410:	74 06                	je     418 <strchr+0x28>
    if(*s == c)
 412:	38 ca                	cmp    %cl,%dl
 414:	75 f2                	jne    408 <strchr+0x18>
      return (char*)s;
  return 0;
}
 416:	5d                   	pop    %ebp
 417:	c3                   	ret    
strchr(const char *s, char c)
{
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
 418:	31 c0                	xor    %eax,%eax
}
 41a:	5d                   	pop    %ebp
 41b:	90                   	nop
 41c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 420:	c3                   	ret    
 421:	eb 0d                	jmp    430 <gets>
 423:	90                   	nop
 424:	90                   	nop
 425:	90                   	nop
 426:	90                   	nop
 427:	90                   	nop
 428:	90                   	nop
 429:	90                   	nop
 42a:	90                   	nop
 42b:	90                   	nop
 42c:	90                   	nop
 42d:	90                   	nop
 42e:	90                   	nop
 42f:	90                   	nop

00000430 <gets>:

char*
gets(char *buf, int max)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	57                   	push   %edi
 434:	56                   	push   %esi
 435:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 436:	31 db                	xor    %ebx,%ebx
  return 0;
}

char*
gets(char *buf, int max)
{
 438:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 43b:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 43e:	8d 73 01             	lea    0x1(%ebx),%esi
 441:	3b 75 0c             	cmp    0xc(%ebp),%esi
 444:	7d 42                	jge    488 <gets+0x58>
    cc = read(0, &c, 1);
 446:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 44d:	00 
 44e:	89 7c 24 04          	mov    %edi,0x4(%esp)
 452:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 459:	e8 1c 01 00 00       	call   57a <read>
    if(cc < 1)
 45e:	85 c0                	test   %eax,%eax
 460:	7e 26                	jle    488 <gets+0x58>
      break;
    buf[i++] = c;
 462:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 466:	89 f3                	mov    %esi,%ebx
 468:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 46b:	3c 0d                	cmp    $0xd,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 46d:	88 44 32 ff          	mov    %al,-0x1(%edx,%esi,1)
    if(c == '\n' || c == '\r')
 471:	74 04                	je     477 <gets+0x47>
 473:	3c 0a                	cmp    $0xa,%al
 475:	75 c7                	jne    43e <gets+0xe>
      break;
  }
  buf[i] = '\0';
 477:	8b 45 08             	mov    0x8(%ebp),%eax
 47a:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 47e:	83 c4 2c             	add    $0x2c,%esp
 481:	5b                   	pop    %ebx
 482:	5e                   	pop    %esi
 483:	5f                   	pop    %edi
 484:	5d                   	pop    %ebp
 485:	c3                   	ret    
 486:	66 90                	xchg   %ax,%ax
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 488:	8b 45 08             	mov    0x8(%ebp),%eax
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
 48b:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 48d:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 491:	83 c4 2c             	add    $0x2c,%esp
 494:	5b                   	pop    %ebx
 495:	5e                   	pop    %esi
 496:	5f                   	pop    %edi
 497:	5d                   	pop    %ebp
 498:	c3                   	ret    
 499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000004a0 <stat>:

int
stat(char *n, struct stat *st)
{
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4a6:	8b 45 08             	mov    0x8(%ebp),%eax
 4a9:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 4b0:	00 
  return buf;
}

int
stat(char *n, struct stat *st)
{
 4b1:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 4b4:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4b7:	89 04 24             	mov    %eax,(%esp)
 4ba:	e8 e3 00 00 00       	call   5a2 <open>
  if(fd < 0)
 4bf:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4c1:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 4c3:	78 2b                	js     4f0 <stat+0x50>
    return -1;
  r = fstat(fd, st);
 4c5:	8b 45 0c             	mov    0xc(%ebp),%eax
 4c8:	89 1c 24             	mov    %ebx,(%esp)
 4cb:	89 44 24 04          	mov    %eax,0x4(%esp)
 4cf:	e8 e6 00 00 00       	call   5ba <fstat>
  close(fd);
 4d4:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 4d7:	89 c6                	mov    %eax,%esi
  close(fd);
 4d9:	e8 ac 00 00 00       	call   58a <close>
  return r;
}
 4de:	89 f0                	mov    %esi,%eax
 4e0:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 4e3:	8b 75 fc             	mov    -0x4(%ebp),%esi
 4e6:	89 ec                	mov    %ebp,%esp
 4e8:	5d                   	pop    %ebp
 4e9:	c3                   	ret    
 4ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 4f0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 4f5:	eb e7                	jmp    4de <stat+0x3e>
 4f7:	89 f6                	mov    %esi,%esi
 4f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000500 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 500:	55                   	push   %ebp
 501:	89 e5                	mov    %esp,%ebp
 503:	8b 4d 08             	mov    0x8(%ebp),%ecx
 506:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 507:	0f be 11             	movsbl (%ecx),%edx
 50a:	8d 42 d0             	lea    -0x30(%edx),%eax
 50d:	3c 09                	cmp    $0x9,%al
 50f:	b8 00 00 00 00       	mov    $0x0,%eax
 514:	77 17                	ja     52d <atoi+0x2d>
 516:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 518:	83 c1 01             	add    $0x1,%ecx
 51b:	8d 04 80             	lea    (%eax,%eax,4),%eax
 51e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 522:	0f be 11             	movsbl (%ecx),%edx
 525:	8d 5a d0             	lea    -0x30(%edx),%ebx
 528:	80 fb 09             	cmp    $0x9,%bl
 52b:	76 eb                	jbe    518 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 52d:	5b                   	pop    %ebx
 52e:	5d                   	pop    %ebp
 52f:	c3                   	ret    

00000530 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 530:	55                   	push   %ebp
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
 531:	31 d2                	xor    %edx,%edx
{
 533:	89 e5                	mov    %esp,%ebp
 535:	56                   	push   %esi
 536:	8b 45 08             	mov    0x8(%ebp),%eax
 539:	53                   	push   %ebx
 53a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 53d:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 540:	85 db                	test   %ebx,%ebx
 542:	7e 12                	jle    556 <memmove+0x26>
 544:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 548:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 54c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 54f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 552:	39 da                	cmp    %ebx,%edx
 554:	75 f2                	jne    548 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 556:	5b                   	pop    %ebx
 557:	5e                   	pop    %esi
 558:	5d                   	pop    %ebp
 559:	c3                   	ret    

0000055a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 55a:	b8 01 00 00 00       	mov    $0x1,%eax
 55f:	cd 40                	int    $0x40
 561:	c3                   	ret    

00000562 <exit>:
SYSCALL(exit)
 562:	b8 02 00 00 00       	mov    $0x2,%eax
 567:	cd 40                	int    $0x40
 569:	c3                   	ret    

0000056a <wait>:
SYSCALL(wait)
 56a:	b8 03 00 00 00       	mov    $0x3,%eax
 56f:	cd 40                	int    $0x40
 571:	c3                   	ret    

00000572 <pipe>:
SYSCALL(pipe)
 572:	b8 04 00 00 00       	mov    $0x4,%eax
 577:	cd 40                	int    $0x40
 579:	c3                   	ret    

0000057a <read>:
SYSCALL(read)
 57a:	b8 05 00 00 00       	mov    $0x5,%eax
 57f:	cd 40                	int    $0x40
 581:	c3                   	ret    

00000582 <write>:
SYSCALL(write)
 582:	b8 10 00 00 00       	mov    $0x10,%eax
 587:	cd 40                	int    $0x40
 589:	c3                   	ret    

0000058a <close>:
SYSCALL(close)
 58a:	b8 15 00 00 00       	mov    $0x15,%eax
 58f:	cd 40                	int    $0x40
 591:	c3                   	ret    

00000592 <kill>:
SYSCALL(kill)
 592:	b8 06 00 00 00       	mov    $0x6,%eax
 597:	cd 40                	int    $0x40
 599:	c3                   	ret    

0000059a <exec>:
SYSCALL(exec)
 59a:	b8 07 00 00 00       	mov    $0x7,%eax
 59f:	cd 40                	int    $0x40
 5a1:	c3                   	ret    

000005a2 <open>:
SYSCALL(open)
 5a2:	b8 0f 00 00 00       	mov    $0xf,%eax
 5a7:	cd 40                	int    $0x40
 5a9:	c3                   	ret    

000005aa <mknod>:
SYSCALL(mknod)
 5aa:	b8 11 00 00 00       	mov    $0x11,%eax
 5af:	cd 40                	int    $0x40
 5b1:	c3                   	ret    

000005b2 <unlink>:
SYSCALL(unlink)
 5b2:	b8 12 00 00 00       	mov    $0x12,%eax
 5b7:	cd 40                	int    $0x40
 5b9:	c3                   	ret    

000005ba <fstat>:
SYSCALL(fstat)
 5ba:	b8 08 00 00 00       	mov    $0x8,%eax
 5bf:	cd 40                	int    $0x40
 5c1:	c3                   	ret    

000005c2 <link>:
SYSCALL(link)
 5c2:	b8 13 00 00 00       	mov    $0x13,%eax
 5c7:	cd 40                	int    $0x40
 5c9:	c3                   	ret    

000005ca <mkdir>:
SYSCALL(mkdir)
 5ca:	b8 14 00 00 00       	mov    $0x14,%eax
 5cf:	cd 40                	int    $0x40
 5d1:	c3                   	ret    

000005d2 <chdir>:
SYSCALL(chdir)
 5d2:	b8 09 00 00 00       	mov    $0x9,%eax
 5d7:	cd 40                	int    $0x40
 5d9:	c3                   	ret    

000005da <dup>:
SYSCALL(dup)
 5da:	b8 0a 00 00 00       	mov    $0xa,%eax
 5df:	cd 40                	int    $0x40
 5e1:	c3                   	ret    

000005e2 <getpid>:
SYSCALL(getpid)
 5e2:	b8 0b 00 00 00       	mov    $0xb,%eax
 5e7:	cd 40                	int    $0x40
 5e9:	c3                   	ret    

000005ea <sbrk>:
SYSCALL(sbrk)
 5ea:	b8 0c 00 00 00       	mov    $0xc,%eax
 5ef:	cd 40                	int    $0x40
 5f1:	c3                   	ret    

000005f2 <sleep>:
SYSCALL(sleep)
 5f2:	b8 0d 00 00 00       	mov    $0xd,%eax
 5f7:	cd 40                	int    $0x40
 5f9:	c3                   	ret    

000005fa <uptime>:
SYSCALL(uptime)
 5fa:	b8 0e 00 00 00       	mov    $0xe,%eax
 5ff:	cd 40                	int    $0x40
 601:	c3                   	ret    

00000602 <getprocs>:
SYSCALL(getprocs)
 602:	b8 16 00 00 00       	mov    $0x16,%eax
 607:	cd 40                	int    $0x40
 609:	c3                   	ret    
 60a:	66 90                	xchg   %ax,%ax
 60c:	66 90                	xchg   %ax,%ax
 60e:	66 90                	xchg   %ax,%ax

00000610 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 610:	55                   	push   %ebp
 611:	89 e5                	mov    %esp,%ebp
 613:	57                   	push   %edi
 614:	89 c7                	mov    %eax,%edi
 616:	56                   	push   %esi
 617:	53                   	push   %ebx
 618:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 61b:	8b 45 08             	mov    0x8(%ebp),%eax
 61e:	85 c0                	test   %eax,%eax
 620:	74 76                	je     698 <printint+0x88>
 622:	89 d0                	mov    %edx,%eax
 624:	c1 e8 1f             	shr    $0x1f,%eax
 627:	84 c0                	test   %al,%al
 629:	74 6d                	je     698 <printint+0x88>
    neg = 1;
    x = -xx;
 62b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 62d:	bb 01 00 00 00       	mov    $0x1,%ebx
    x = -xx;
 632:	f7 d8                	neg    %eax
  } else {
    x = xx;
  }

  i = 0;
 634:	31 f6                	xor    %esi,%esi
 636:	eb 02                	jmp    63a <printint+0x2a>
  do{
    buf[i++] = digits[x % base];
 638:	89 d6                	mov    %edx,%esi
 63a:	31 d2                	xor    %edx,%edx
 63c:	f7 f1                	div    %ecx
 63e:	0f b6 92 3d 0a 00 00 	movzbl 0xa3d(%edx),%edx
  }while((x /= base) != 0);
 645:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 647:	88 54 35 d8          	mov    %dl,-0x28(%ebp,%esi,1)
 64b:	8d 56 01             	lea    0x1(%esi),%edx
  }while((x /= base) != 0);
 64e:	75 e8                	jne    638 <printint+0x28>
  if(neg)
 650:	85 db                	test   %ebx,%ebx
 652:	74 08                	je     65c <printint+0x4c>
    buf[i++] = '-';
 654:	c6 44 15 d8 2d       	movb   $0x2d,-0x28(%ebp,%edx,1)
 659:	8d 56 02             	lea    0x2(%esi),%edx

  while(--i >= 0)
 65c:	8d 5a ff             	lea    -0x1(%edx),%ebx
 65f:	83 fb ff             	cmp    $0xffffffff,%ebx
 662:	8d 75 d7             	lea    -0x29(%ebp),%esi
 665:	74 25                	je     68c <printint+0x7c>
 667:	90                   	nop
 668:	0f b6 44 1d d8       	movzbl -0x28(%ebp,%ebx,1),%eax
 66d:	83 eb 01             	sub    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 670:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 677:	00 
 678:	89 74 24 04          	mov    %esi,0x4(%esp)
 67c:	89 3c 24             	mov    %edi,(%esp)
 67f:	88 45 d7             	mov    %al,-0x29(%ebp)
 682:	e8 fb fe ff ff       	call   582 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 687:	83 fb ff             	cmp    $0xffffffff,%ebx
 68a:	75 dc                	jne    668 <printint+0x58>
    putc(fd, buf[i]);
}
 68c:	83 c4 3c             	add    $0x3c,%esp
 68f:	5b                   	pop    %ebx
 690:	5e                   	pop    %esi
 691:	5f                   	pop    %edi
 692:	5d                   	pop    %ebp
 693:	c3                   	ret    
 694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 698:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 69a:	31 db                	xor    %ebx,%ebx
 69c:	eb 96                	jmp    634 <printint+0x24>
 69e:	66 90                	xchg   %ax,%ax

000006a0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 6a0:	55                   	push   %ebp
 6a1:	89 e5                	mov    %esp,%ebp
 6a3:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 6a4:	31 ff                	xor    %edi,%edi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 6a6:	56                   	push   %esi
 6a7:	53                   	push   %ebx
 6a8:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6ab:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 6ae:	8d 55 10             	lea    0x10(%ebp),%edx
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 6b1:	8b 75 08             	mov    0x8(%ebp),%esi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 6b4:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 6b7:	0f be 03             	movsbl (%ebx),%eax
    putc(fd, buf[i]);
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
 6ba:	83 c3 01             	add    $0x1,%ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6bd:	84 c0                	test   %al,%al
 6bf:	75 39                	jne    6fa <printf+0x5a>
 6c1:	e9 c2 00 00 00       	jmp    788 <printf+0xe8>
 6c6:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 6c8:	83 fa 25             	cmp    $0x25,%edx
 6cb:	0f 84 bf 00 00 00    	je     790 <printf+0xf0>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6d1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 6d4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6db:	00 
 6dc:	89 44 24 04          	mov    %eax,0x4(%esp)
 6e0:	89 34 24             	mov    %esi,(%esp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 6e3:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6e6:	e8 97 fe ff ff       	call   582 <write>
 6eb:	83 c3 01             	add    $0x1,%ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6ee:	0f be 43 ff          	movsbl -0x1(%ebx),%eax
 6f2:	84 c0                	test   %al,%al
 6f4:	0f 84 8e 00 00 00    	je     788 <printf+0xe8>
    c = fmt[i] & 0xff;
 6fa:	0f b6 d0             	movzbl %al,%edx
    if(state == 0){
 6fd:	85 ff                	test   %edi,%edi
 6ff:	74 c7                	je     6c8 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 701:	83 ff 25             	cmp    $0x25,%edi
 704:	75 e5                	jne    6eb <printf+0x4b>
      if(c == 'd'){
 706:	83 fa 64             	cmp    $0x64,%edx
 709:	0f 84 31 01 00 00    	je     840 <printf+0x1a0>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 70f:	25 f7 00 00 00       	and    $0xf7,%eax
 714:	83 f8 70             	cmp    $0x70,%eax
 717:	0f 84 83 00 00 00    	je     7a0 <printf+0x100>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 71d:	83 fa 73             	cmp    $0x73,%edx
 720:	0f 84 a2 00 00 00    	je     7c8 <printf+0x128>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 726:	83 fa 63             	cmp    $0x63,%edx
 729:	0f 84 35 01 00 00    	je     864 <printf+0x1c4>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 72f:	83 fa 25             	cmp    $0x25,%edx
 732:	0f 84 e0 00 00 00    	je     818 <printf+0x178>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 738:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 73b:	83 c3 01             	add    $0x1,%ebx
 73e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 745:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 746:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 748:	89 44 24 04          	mov    %eax,0x4(%esp)
 74c:	89 34 24             	mov    %esi,(%esp)
 74f:	89 55 d0             	mov    %edx,-0x30(%ebp)
 752:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 756:	e8 27 fe ff ff       	call   582 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 75b:	8b 55 d0             	mov    -0x30(%ebp),%edx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 75e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 761:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 768:	00 
 769:	89 44 24 04          	mov    %eax,0x4(%esp)
 76d:	89 34 24             	mov    %esi,(%esp)
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 770:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 773:	e8 0a fe ff ff       	call   582 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 778:	0f be 43 ff          	movsbl -0x1(%ebx),%eax
 77c:	84 c0                	test   %al,%al
 77e:	0f 85 76 ff ff ff    	jne    6fa <printf+0x5a>
 784:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 788:	83 c4 3c             	add    $0x3c,%esp
 78b:	5b                   	pop    %ebx
 78c:	5e                   	pop    %esi
 78d:	5f                   	pop    %edi
 78e:	5d                   	pop    %ebp
 78f:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 790:	bf 25 00 00 00       	mov    $0x25,%edi
 795:	e9 51 ff ff ff       	jmp    6eb <printf+0x4b>
 79a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 7a0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 7a3:	b9 10 00 00 00       	mov    $0x10,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7a8:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 7aa:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 7b1:	8b 10                	mov    (%eax),%edx
 7b3:	89 f0                	mov    %esi,%eax
 7b5:	e8 56 fe ff ff       	call   610 <printint>
        ap++;
 7ba:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 7be:	e9 28 ff ff ff       	jmp    6eb <printf+0x4b>
 7c3:	90                   	nop
 7c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 7c8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        ap++;
        if(s == 0)
          s = "(null)";
 7cb:	b8 36 0a 00 00       	mov    $0xa36,%eax
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 7d0:	8b 3a                	mov    (%edx),%edi
        ap++;
 7d2:	83 c2 04             	add    $0x4,%edx
 7d5:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
          s = "(null)";
 7d8:	85 ff                	test   %edi,%edi
 7da:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 7dd:	0f b6 07             	movzbl (%edi),%eax
 7e0:	84 c0                	test   %al,%al
 7e2:	74 28                	je     80c <printf+0x16c>
 7e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 7e8:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7eb:	8d 45 e3             	lea    -0x1d(%ebp),%eax
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 7ee:	83 c7 01             	add    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7f1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 7f8:	00 
 7f9:	89 44 24 04          	mov    %eax,0x4(%esp)
 7fd:	89 34 24             	mov    %esi,(%esp)
 800:	e8 7d fd ff ff       	call   582 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 805:	0f b6 07             	movzbl (%edi),%eax
 808:	84 c0                	test   %al,%al
 80a:	75 dc                	jne    7e8 <printf+0x148>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 80c:	31 ff                	xor    %edi,%edi
 80e:	e9 d8 fe ff ff       	jmp    6eb <printf+0x4b>
 813:	90                   	nop
 814:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 818:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 81b:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 81d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 824:	00 
 825:	89 44 24 04          	mov    %eax,0x4(%esp)
 829:	89 34 24             	mov    %esi,(%esp)
 82c:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 830:	e8 4d fd ff ff       	call   582 <write>
 835:	e9 b1 fe ff ff       	jmp    6eb <printf+0x4b>
 83a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 840:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 843:	b9 0a 00 00 00       	mov    $0xa,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 848:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 84b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 852:	8b 10                	mov    (%eax),%edx
 854:	89 f0                	mov    %esi,%eax
 856:	e8 b5 fd ff ff       	call   610 <printint>
        ap++;
 85b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 85f:	e9 87 fe ff ff       	jmp    6eb <printf+0x4b>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 864:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 867:	31 ff                	xor    %edi,%edi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 869:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 86b:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 872:	00 
 873:	89 34 24             	mov    %esi,(%esp)
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 876:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 879:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 87c:	89 44 24 04          	mov    %eax,0x4(%esp)
 880:	e8 fd fc ff ff       	call   582 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 885:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 889:	e9 5d fe ff ff       	jmp    6eb <printf+0x4b>
 88e:	66 90                	xchg   %ax,%ax

00000890 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 890:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 891:	a1 c0 0d 00 00       	mov    0xdc0,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 896:	89 e5                	mov    %esp,%ebp
 898:	57                   	push   %edi
 899:	56                   	push   %esi
 89a:	53                   	push   %ebx
 89b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 89e:	8b 08                	mov    (%eax),%ecx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8a0:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8a3:	39 d0                	cmp    %edx,%eax
 8a5:	72 11                	jb     8b8 <free+0x28>
 8a7:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8a8:	39 c8                	cmp    %ecx,%eax
 8aa:	72 04                	jb     8b0 <free+0x20>
 8ac:	39 ca                	cmp    %ecx,%edx
 8ae:	72 10                	jb     8c0 <free+0x30>
 8b0:	89 c8                	mov    %ecx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8b2:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8b4:	8b 08                	mov    (%eax),%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8b6:	73 f0                	jae    8a8 <free+0x18>
 8b8:	39 ca                	cmp    %ecx,%edx
 8ba:	72 04                	jb     8c0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8bc:	39 c8                	cmp    %ecx,%eax
 8be:	72 f0                	jb     8b0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 8c0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 8c3:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 8c6:	39 cf                	cmp    %ecx,%edi
 8c8:	74 1e                	je     8e8 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 8ca:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 8cd:	8b 48 04             	mov    0x4(%eax),%ecx
 8d0:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 8d3:	39 f2                	cmp    %esi,%edx
 8d5:	74 28                	je     8ff <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 8d7:	89 10                	mov    %edx,(%eax)
  freep = p;
 8d9:	a3 c0 0d 00 00       	mov    %eax,0xdc0
}
 8de:	5b                   	pop    %ebx
 8df:	5e                   	pop    %esi
 8e0:	5f                   	pop    %edi
 8e1:	5d                   	pop    %ebp
 8e2:	c3                   	ret    
 8e3:	90                   	nop
 8e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8e8:	03 71 04             	add    0x4(%ecx),%esi
 8eb:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 8ee:	8b 08                	mov    (%eax),%ecx
 8f0:	8b 09                	mov    (%ecx),%ecx
 8f2:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 8f5:	8b 48 04             	mov    0x4(%eax),%ecx
 8f8:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 8fb:	39 f2                	cmp    %esi,%edx
 8fd:	75 d8                	jne    8d7 <free+0x47>
    p->s.size += bp->s.size;
 8ff:	03 4b fc             	add    -0x4(%ebx),%ecx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 902:	a3 c0 0d 00 00       	mov    %eax,0xdc0
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 907:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 90a:	8b 53 f8             	mov    -0x8(%ebx),%edx
 90d:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 90f:	5b                   	pop    %ebx
 910:	5e                   	pop    %esi
 911:	5f                   	pop    %edi
 912:	5d                   	pop    %ebp
 913:	c3                   	ret    
 914:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 91a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000920 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 920:	55                   	push   %ebp
 921:	89 e5                	mov    %esp,%ebp
 923:	57                   	push   %edi
 924:	56                   	push   %esi
 925:	53                   	push   %ebx
 926:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 929:	8b 55 08             	mov    0x8(%ebp),%edx
  if((prevp = freep) == 0){
 92c:	8b 0d c0 0d 00 00    	mov    0xdc0,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 932:	83 c2 07             	add    $0x7,%edx
 935:	c1 ea 03             	shr    $0x3,%edx
  if((prevp = freep) == 0){
 938:	85 c9                	test   %ecx,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 93a:	8d 5a 01             	lea    0x1(%edx),%ebx
  if((prevp = freep) == 0){
 93d:	0f 84 93 00 00 00    	je     9d6 <malloc+0xb6>
 943:	8b 01                	mov    (%ecx),%eax
 945:	8b 78 04             	mov    0x4(%eax),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 948:	39 fb                	cmp    %edi,%ebx
 94a:	76 64                	jbe    9b0 <malloc+0x90>
 94c:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 953:	eb 0c                	jmp    961 <malloc+0x41>
 955:	8d 76 00             	lea    0x0(%esi),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 958:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 95a:	8b 78 04             	mov    0x4(%eax),%edi
 95d:	39 fb                	cmp    %edi,%ebx
 95f:	76 4f                	jbe    9b0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 961:	3b 05 c0 0d 00 00    	cmp    0xdc0,%eax
 967:	89 c1                	mov    %eax,%ecx
 969:	75 ed                	jne    958 <malloc+0x38>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 96b:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 971:	b8 00 80 00 00       	mov    $0x8000,%eax
 976:	0f 43 c6             	cmovae %esi,%eax
 979:	bf 00 10 00 00       	mov    $0x1000,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 97e:	89 04 24             	mov    %eax,(%esp)
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 981:	0f 43 fb             	cmovae %ebx,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 984:	e8 61 fc ff ff       	call   5ea <sbrk>
  if(p == (char*)-1)
 989:	83 f8 ff             	cmp    $0xffffffff,%eax
 98c:	74 18                	je     9a6 <malloc+0x86>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 98e:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 991:	83 c0 08             	add    $0x8,%eax
 994:	89 04 24             	mov    %eax,(%esp)
 997:	e8 f4 fe ff ff       	call   890 <free>
  return freep;
 99c:	8b 0d c0 0d 00 00    	mov    0xdc0,%ecx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 9a2:	85 c9                	test   %ecx,%ecx
 9a4:	75 b2                	jne    958 <malloc+0x38>
        return 0;
 9a6:	31 c0                	xor    %eax,%eax
 9a8:	eb 1e                	jmp    9c8 <malloc+0xa8>
 9aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 9b0:	39 fb                	cmp    %edi,%ebx
 9b2:	74 1c                	je     9d0 <malloc+0xb0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 9b4:	29 df                	sub    %ebx,%edi
 9b6:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 9b9:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 9bc:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 9bf:	89 0d c0 0d 00 00    	mov    %ecx,0xdc0
      return (void*)(p + 1);
 9c5:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 9c8:	83 c4 1c             	add    $0x1c,%esp
 9cb:	5b                   	pop    %ebx
 9cc:	5e                   	pop    %esi
 9cd:	5f                   	pop    %edi
 9ce:	5d                   	pop    %ebp
 9cf:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 9d0:	8b 10                	mov    (%eax),%edx
 9d2:	89 11                	mov    %edx,(%ecx)
 9d4:	eb e9                	jmp    9bf <malloc+0x9f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 9d6:	c7 05 c0 0d 00 00 c4 	movl   $0xdc4,0xdc0
 9dd:	0d 00 00 
    base.s.size = 0;
 9e0:	b8 c4 0d 00 00       	mov    $0xdc4,%eax
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 9e5:	c7 05 c4 0d 00 00 c4 	movl   $0xdc4,0xdc4
 9ec:	0d 00 00 
    base.s.size = 0;
 9ef:	c7 05 c8 0d 00 00 00 	movl   $0x0,0xdc8
 9f6:	00 00 00 
 9f9:	e9 4e ff ff ff       	jmp    94c <malloc+0x2c>
