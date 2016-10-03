
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  close(fd);
}

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	53                   	push   %ebx
  int i;

  if(argc < 2){
   6:	bb 01 00 00 00       	mov    $0x1,%ebx
  close(fd);
}

int
main(int argc, char *argv[])
{
   b:	83 e4 f0             	and    $0xfffffff0,%esp
   e:	83 ec 10             	sub    $0x10,%esp
  11:	8b 75 08             	mov    0x8(%ebp),%esi
  14:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  if(argc < 2){
  17:	83 fe 01             	cmp    $0x1,%esi
  1a:	7e 1b                	jle    37 <main+0x37>
  1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
  20:	8b 04 9f             	mov    (%edi,%ebx,4),%eax

  if(argc < 2){
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
  23:	83 c3 01             	add    $0x1,%ebx
    ls(argv[i]);
  26:	89 04 24             	mov    %eax,(%esp)
  29:	e8 c2 00 00 00       	call   f0 <ls>

  if(argc < 2){
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
  2e:	39 f3                	cmp    %esi,%ebx
  30:	75 ee                	jne    20 <main+0x20>
    ls(argv[i]);
  exit();
  32:	e8 7b 05 00 00       	call   5b2 <exit>
main(int argc, char *argv[])
{
  int i;

  if(argc < 2){
    ls(".");
  37:	c7 04 24 96 0a 00 00 	movl   $0xa96,(%esp)
  3e:	e8 ad 00 00 00       	call   f0 <ls>
    exit();
  43:	e8 6a 05 00 00       	call   5b2 <exit>
  48:	66 90                	xchg   %ax,%ax
  4a:	66 90                	xchg   %ax,%ax
  4c:	66 90                	xchg   %ax,%ax
  4e:	66 90                	xchg   %ax,%ax

00000050 <fmtname>:
#include "user.h"
#include "fs.h"

char*
fmtname(char *path)
{
  50:	55                   	push   %ebp
  51:	89 e5                	mov    %esp,%ebp
  53:	56                   	push   %esi
  54:	53                   	push   %ebx
  55:	83 ec 10             	sub    $0x10,%esp
  58:	8b 5d 08             	mov    0x8(%ebp),%ebx
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  5b:	89 1c 24             	mov    %ebx,(%esp)
  5e:	e8 8d 03 00 00       	call   3f0 <strlen>
  63:	01 d8                	add    %ebx,%eax
  65:	73 10                	jae    77 <fmtname+0x27>
  67:	eb 13                	jmp    7c <fmtname+0x2c>
  69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  70:	83 e8 01             	sub    $0x1,%eax
  73:	39 c3                	cmp    %eax,%ebx
  75:	77 05                	ja     7c <fmtname+0x2c>
  77:	80 38 2f             	cmpb   $0x2f,(%eax)
  7a:	75 f4                	jne    70 <fmtname+0x20>
    ;
  p++;
  7c:	8d 58 01             	lea    0x1(%eax),%ebx

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  7f:	89 1c 24             	mov    %ebx,(%esp)
  82:	e8 69 03 00 00       	call   3f0 <strlen>
  87:	83 f8 0d             	cmp    $0xd,%eax
  8a:	77 53                	ja     df <fmtname+0x8f>
    return p;
  memmove(buf, p, strlen(p));
  8c:	89 1c 24             	mov    %ebx,(%esp)
  8f:	e8 5c 03 00 00       	call   3f0 <strlen>
  94:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  98:	c7 04 24 9c 0d 00 00 	movl   $0xd9c,(%esp)
  9f:	89 44 24 08          	mov    %eax,0x8(%esp)
  a3:	e8 d8 04 00 00       	call   580 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  a8:	89 1c 24             	mov    %ebx,(%esp)
  ab:	e8 40 03 00 00       	call   3f0 <strlen>
  b0:	89 1c 24             	mov    %ebx,(%esp)
  return buf;
  b3:	bb 9c 0d 00 00       	mov    $0xd9c,%ebx

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  b8:	89 c6                	mov    %eax,%esi
  ba:	e8 31 03 00 00       	call   3f0 <strlen>
  bf:	ba 0e 00 00 00       	mov    $0xe,%edx
  c4:	29 f2                	sub    %esi,%edx
  c6:	89 54 24 08          	mov    %edx,0x8(%esp)
  ca:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
  d1:	00 
  d2:	05 9c 0d 00 00       	add    $0xd9c,%eax
  d7:	89 04 24             	mov    %eax,(%esp)
  da:	e8 41 03 00 00       	call   420 <memset>
  return buf;
}
  df:	83 c4 10             	add    $0x10,%esp
  e2:	89 d8                	mov    %ebx,%eax
  e4:	5b                   	pop    %ebx
  e5:	5e                   	pop    %esi
  e6:	5d                   	pop    %ebp
  e7:	c3                   	ret    
  e8:	90                   	nop
  e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000000f0 <ls>:

void
ls(char *path)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	57                   	push   %edi
  f4:	56                   	push   %esi
  f5:	53                   	push   %ebx
  f6:	81 ec 7c 02 00 00    	sub    $0x27c,%esp
  fc:	8b 7d 08             	mov    0x8(%ebp),%edi
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
  ff:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 106:	00 
 107:	89 3c 24             	mov    %edi,(%esp)
 10a:	e8 e3 04 00 00       	call   5f2 <open>
 10f:	85 c0                	test   %eax,%eax
 111:	89 c3                	mov    %eax,%ebx
 113:	0f 88 c7 01 00 00    	js     2e0 <ls+0x1f0>
    printf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
 119:	8d b5 d4 fd ff ff    	lea    -0x22c(%ebp),%esi
 11f:	89 74 24 04          	mov    %esi,0x4(%esp)
 123:	89 04 24             	mov    %eax,(%esp)
 126:	e8 df 04 00 00       	call   60a <fstat>
 12b:	85 c0                	test   %eax,%eax
 12d:	0f 88 f5 01 00 00    	js     328 <ls+0x238>
    printf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
 133:	0f b7 85 d4 fd ff ff 	movzwl -0x22c(%ebp),%eax
 13a:	66 83 f8 01          	cmp    $0x1,%ax
 13e:	74 68                	je     1a8 <ls+0xb8>
 140:	66 83 f8 02          	cmp    $0x2,%ax
 144:	75 48                	jne    18e <ls+0x9e>
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 146:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 14c:	89 3c 24             	mov    %edi,(%esp)
 14f:	8b b5 dc fd ff ff    	mov    -0x224(%ebp),%esi
 155:	89 95 a8 fd ff ff    	mov    %edx,-0x258(%ebp)
 15b:	e8 f0 fe ff ff       	call   50 <fmtname>
 160:	8b 95 a8 fd ff ff    	mov    -0x258(%ebp),%edx
 166:	89 74 24 10          	mov    %esi,0x10(%esp)
 16a:	c7 44 24 0c 02 00 00 	movl   $0x2,0xc(%esp)
 171:	00 
 172:	c7 44 24 04 76 0a 00 	movl   $0xa76,0x4(%esp)
 179:	00 
 17a:	89 54 24 14          	mov    %edx,0x14(%esp)
 17e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 185:	89 44 24 08          	mov    %eax,0x8(%esp)
 189:	e8 62 05 00 00       	call   6f0 <printf>
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
 18e:	89 1c 24             	mov    %ebx,(%esp)
 191:	e8 44 04 00 00       	call   5da <close>
}
 196:	81 c4 7c 02 00 00    	add    $0x27c,%esp
 19c:	5b                   	pop    %ebx
 19d:	5e                   	pop    %esi
 19e:	5f                   	pop    %edi
 19f:	5d                   	pop    %ebp
 1a0:	c3                   	ret    
 1a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
    break;

  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 1a8:	89 3c 24             	mov    %edi,(%esp)
 1ab:	e8 40 02 00 00       	call   3f0 <strlen>
 1b0:	83 c0 10             	add    $0x10,%eax
 1b3:	3d 00 02 00 00       	cmp    $0x200,%eax
 1b8:	0f 87 4a 01 00 00    	ja     308 <ls+0x218>
      printf(1, "ls: path too long\n");
      break;
    }
    strcpy(buf, path);
 1be:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 1c4:	89 7c 24 04          	mov    %edi,0x4(%esp)
 1c8:	8d bd c4 fd ff ff    	lea    -0x23c(%ebp),%edi
 1ce:	89 04 24             	mov    %eax,(%esp)
 1d1:	e8 aa 01 00 00       	call   380 <strcpy>
    p = buf+strlen(buf);
 1d6:	8d 95 e8 fd ff ff    	lea    -0x218(%ebp),%edx
 1dc:	89 14 24             	mov    %edx,(%esp)
 1df:	e8 0c 02 00 00       	call   3f0 <strlen>
 1e4:	8d 8d e8 fd ff ff    	lea    -0x218(%ebp),%ecx
 1ea:	01 c1                	add    %eax,%ecx
 1ec:	89 8d b4 fd ff ff    	mov    %ecx,-0x24c(%ebp)
    *p++ = '/';
 1f2:	c6 01 2f             	movb   $0x2f,(%ecx)
 1f5:	83 c1 01             	add    $0x1,%ecx
 1f8:	89 8d ac fd ff ff    	mov    %ecx,-0x254(%ebp)
 1fe:	66 90                	xchg   %ax,%ax
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 200:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 207:	00 
 208:	89 7c 24 04          	mov    %edi,0x4(%esp)
 20c:	89 1c 24             	mov    %ebx,(%esp)
 20f:	e8 b6 03 00 00       	call   5ca <read>
 214:	83 f8 10             	cmp    $0x10,%eax
 217:	0f 85 71 ff ff ff    	jne    18e <ls+0x9e>
      if(de.inum == 0)
 21d:	66 83 bd c4 fd ff ff 	cmpw   $0x0,-0x23c(%ebp)
 224:	00 
 225:	74 d9                	je     200 <ls+0x110>
        continue;
      memmove(p, de.name, DIRSIZ);
 227:	8b 95 ac fd ff ff    	mov    -0x254(%ebp),%edx
 22d:	8d 85 c6 fd ff ff    	lea    -0x23a(%ebp),%eax
 233:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
 23a:	00 
 23b:	89 44 24 04          	mov    %eax,0x4(%esp)
 23f:	89 14 24             	mov    %edx,(%esp)
 242:	e8 39 03 00 00       	call   580 <memmove>
      p[DIRSIZ] = 0;
 247:	8b 8d b4 fd ff ff    	mov    -0x24c(%ebp),%ecx
      if(stat(buf, &st) < 0){
 24d:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
    *p++ = '/';
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
      if(de.inum == 0)
        continue;
      memmove(p, de.name, DIRSIZ);
      p[DIRSIZ] = 0;
 253:	c6 41 0f 00          	movb   $0x0,0xf(%ecx)
      if(stat(buf, &st) < 0){
 257:	89 74 24 04          	mov    %esi,0x4(%esp)
 25b:	89 04 24             	mov    %eax,(%esp)
 25e:	e8 8d 02 00 00       	call   4f0 <stat>
 263:	85 c0                	test   %eax,%eax
 265:	0f 88 e5 00 00 00    	js     350 <ls+0x260>
        printf(1, "ls: cannot stat %s\n", buf);
        continue;
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 26b:	8b 95 dc fd ff ff    	mov    -0x224(%ebp),%edx
 271:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 277:	8b 8d e4 fd ff ff    	mov    -0x21c(%ebp),%ecx
 27d:	89 04 24             	mov    %eax,(%esp)
 280:	89 95 b0 fd ff ff    	mov    %edx,-0x250(%ebp)
 286:	0f bf 95 d4 fd ff ff 	movswl -0x22c(%ebp),%edx
 28d:	89 8d a4 fd ff ff    	mov    %ecx,-0x25c(%ebp)
 293:	89 95 a8 fd ff ff    	mov    %edx,-0x258(%ebp)
 299:	e8 b2 fd ff ff       	call   50 <fmtname>
 29e:	8b 8d a4 fd ff ff    	mov    -0x25c(%ebp),%ecx
 2a4:	8b 95 a8 fd ff ff    	mov    -0x258(%ebp),%edx
 2aa:	c7 44 24 04 76 0a 00 	movl   $0xa76,0x4(%esp)
 2b1:	00 
 2b2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2b9:	89 4c 24 14          	mov    %ecx,0x14(%esp)
 2bd:	8b 8d b0 fd ff ff    	mov    -0x250(%ebp),%ecx
 2c3:	89 54 24 0c          	mov    %edx,0xc(%esp)
 2c7:	89 44 24 08          	mov    %eax,0x8(%esp)
 2cb:	89 4c 24 10          	mov    %ecx,0x10(%esp)
 2cf:	e8 1c 04 00 00       	call   6f0 <printf>
 2d4:	e9 27 ff ff ff       	jmp    200 <ls+0x110>
 2d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
    printf(2, "ls: cannot open %s\n", path);
 2e0:	89 7c 24 08          	mov    %edi,0x8(%esp)
 2e4:	c7 44 24 04 4e 0a 00 	movl   $0xa4e,0x4(%esp)
 2eb:	00 
 2ec:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 2f3:	e8 f8 03 00 00       	call   6f0 <printf>
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
}
 2f8:	81 c4 7c 02 00 00    	add    $0x27c,%esp
 2fe:	5b                   	pop    %ebx
 2ff:	5e                   	pop    %esi
 300:	5f                   	pop    %edi
 301:	5d                   	pop    %ebp
 302:	c3                   	ret    
 303:	90                   	nop
 304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
    break;

  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
      printf(1, "ls: path too long\n");
 308:	c7 44 24 04 83 0a 00 	movl   $0xa83,0x4(%esp)
 30f:	00 
 310:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 317:	e8 d4 03 00 00       	call   6f0 <printf>
      break;
 31c:	e9 6d fe ff ff       	jmp    18e <ls+0x9e>
 321:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
    printf(2, "ls: cannot stat %s\n", path);
 328:	89 7c 24 08          	mov    %edi,0x8(%esp)
 32c:	c7 44 24 04 62 0a 00 	movl   $0xa62,0x4(%esp)
 333:	00 
 334:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 33b:	e8 b0 03 00 00       	call   6f0 <printf>
    close(fd);
 340:	89 1c 24             	mov    %ebx,(%esp)
 343:	e8 92 02 00 00       	call   5da <close>
 348:	e9 49 fe ff ff       	jmp    196 <ls+0xa6>
 34d:	8d 76 00             	lea    0x0(%esi),%esi
      if(de.inum == 0)
        continue;
      memmove(p, de.name, DIRSIZ);
      p[DIRSIZ] = 0;
      if(stat(buf, &st) < 0){
        printf(1, "ls: cannot stat %s\n", buf);
 350:	8d 95 e8 fd ff ff    	lea    -0x218(%ebp),%edx
 356:	89 54 24 08          	mov    %edx,0x8(%esp)
 35a:	c7 44 24 04 62 0a 00 	movl   $0xa62,0x4(%esp)
 361:	00 
 362:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 369:	e8 82 03 00 00       	call   6f0 <printf>
        continue;
 36e:	e9 8d fe ff ff       	jmp    200 <ls+0x110>
 373:	66 90                	xchg   %ax,%ax
 375:	66 90                	xchg   %ax,%ax
 377:	66 90                	xchg   %ax,%ax
 379:	66 90                	xchg   %ax,%ax
 37b:	66 90                	xchg   %ax,%ax
 37d:	66 90                	xchg   %ax,%ax
 37f:	90                   	nop

00000380 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	8b 45 08             	mov    0x8(%ebp),%eax
 386:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 389:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 38a:	89 c2                	mov    %eax,%edx
 38c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 390:	0f b6 19             	movzbl (%ecx),%ebx
 393:	83 c1 01             	add    $0x1,%ecx
 396:	88 1a                	mov    %bl,(%edx)
 398:	83 c2 01             	add    $0x1,%edx
 39b:	84 db                	test   %bl,%bl
 39d:	75 f1                	jne    390 <strcpy+0x10>
    ;
  return os;
}
 39f:	5b                   	pop    %ebx
 3a0:	5d                   	pop    %ebp
 3a1:	c3                   	ret    
 3a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	8b 55 08             	mov    0x8(%ebp),%edx
 3b6:	56                   	push   %esi
 3b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 3ba:	53                   	push   %ebx
  while(*p && *p == *q)
 3bb:	0f b6 02             	movzbl (%edx),%eax
 3be:	0f b6 19             	movzbl (%ecx),%ebx
 3c1:	84 c0                	test   %al,%al
 3c3:	75 16                	jne    3db <strcmp+0x2b>
 3c5:	eb 21                	jmp    3e8 <strcmp+0x38>
 3c7:	90                   	nop
    p++, q++;
 3c8:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3cb:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 3cf:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 3d2:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3d5:	84 c0                	test   %al,%al
 3d7:	74 0f                	je     3e8 <strcmp+0x38>
    p++, q++;
 3d9:	89 f1                	mov    %esi,%ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3db:	38 d8                	cmp    %bl,%al
 3dd:	74 e9                	je     3c8 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 3df:	29 d8                	sub    %ebx,%eax
}
 3e1:	5b                   	pop    %ebx
 3e2:	5e                   	pop    %esi
 3e3:	5d                   	pop    %ebp
 3e4:	c3                   	ret    
 3e5:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3e8:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 3ea:	29 d8                	sub    %ebx,%eax
}
 3ec:	5b                   	pop    %ebx
 3ed:	5e                   	pop    %esi
 3ee:	5d                   	pop    %ebp
 3ef:	c3                   	ret    

000003f0 <strlen>:

uint
strlen(char *s)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 3f6:	80 39 00             	cmpb   $0x0,(%ecx)
 3f9:	74 12                	je     40d <strlen+0x1d>
 3fb:	31 d2                	xor    %edx,%edx
 3fd:	8d 76 00             	lea    0x0(%esi),%esi
 400:	83 c2 01             	add    $0x1,%edx
 403:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 407:	89 d0                	mov    %edx,%eax
 409:	75 f5                	jne    400 <strlen+0x10>
    ;
  return n;
}
 40b:	5d                   	pop    %ebp
 40c:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 40d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 40f:	5d                   	pop    %ebp
 410:	c3                   	ret    
 411:	eb 0d                	jmp    420 <memset>
 413:	90                   	nop
 414:	90                   	nop
 415:	90                   	nop
 416:	90                   	nop
 417:	90                   	nop
 418:	90                   	nop
 419:	90                   	nop
 41a:	90                   	nop
 41b:	90                   	nop
 41c:	90                   	nop
 41d:	90                   	nop
 41e:	90                   	nop
 41f:	90                   	nop

00000420 <memset>:

void*
memset(void *dst, int c, uint n)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	8b 55 08             	mov    0x8(%ebp),%edx
 426:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 427:	8b 4d 10             	mov    0x10(%ebp),%ecx
 42a:	8b 45 0c             	mov    0xc(%ebp),%eax
 42d:	89 d7                	mov    %edx,%edi
 42f:	fc                   	cld    
 430:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 432:	89 d0                	mov    %edx,%eax
 434:	5f                   	pop    %edi
 435:	5d                   	pop    %ebp
 436:	c3                   	ret    
 437:	89 f6                	mov    %esi,%esi
 439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000440 <strchr>:

char*
strchr(const char *s, char c)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	8b 45 08             	mov    0x8(%ebp),%eax
 446:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 44a:	0f b6 10             	movzbl (%eax),%edx
 44d:	84 d2                	test   %dl,%dl
 44f:	75 11                	jne    462 <strchr+0x22>
 451:	eb 15                	jmp    468 <strchr+0x28>
 453:	90                   	nop
 454:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 458:	83 c0 01             	add    $0x1,%eax
 45b:	0f b6 10             	movzbl (%eax),%edx
 45e:	84 d2                	test   %dl,%dl
 460:	74 06                	je     468 <strchr+0x28>
    if(*s == c)
 462:	38 ca                	cmp    %cl,%dl
 464:	75 f2                	jne    458 <strchr+0x18>
      return (char*)s;
  return 0;
}
 466:	5d                   	pop    %ebp
 467:	c3                   	ret    
strchr(const char *s, char c)
{
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
 468:	31 c0                	xor    %eax,%eax
}
 46a:	5d                   	pop    %ebp
 46b:	90                   	nop
 46c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 470:	c3                   	ret    
 471:	eb 0d                	jmp    480 <gets>
 473:	90                   	nop
 474:	90                   	nop
 475:	90                   	nop
 476:	90                   	nop
 477:	90                   	nop
 478:	90                   	nop
 479:	90                   	nop
 47a:	90                   	nop
 47b:	90                   	nop
 47c:	90                   	nop
 47d:	90                   	nop
 47e:	90                   	nop
 47f:	90                   	nop

00000480 <gets>:

char*
gets(char *buf, int max)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	57                   	push   %edi
 484:	56                   	push   %esi
 485:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 486:	31 db                	xor    %ebx,%ebx
  return 0;
}

char*
gets(char *buf, int max)
{
 488:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 48b:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 48e:	8d 73 01             	lea    0x1(%ebx),%esi
 491:	3b 75 0c             	cmp    0xc(%ebp),%esi
 494:	7d 42                	jge    4d8 <gets+0x58>
    cc = read(0, &c, 1);
 496:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 49d:	00 
 49e:	89 7c 24 04          	mov    %edi,0x4(%esp)
 4a2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 4a9:	e8 1c 01 00 00       	call   5ca <read>
    if(cc < 1)
 4ae:	85 c0                	test   %eax,%eax
 4b0:	7e 26                	jle    4d8 <gets+0x58>
      break;
    buf[i++] = c;
 4b2:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 4b6:	89 f3                	mov    %esi,%ebx
 4b8:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 4bb:	3c 0d                	cmp    $0xd,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 4bd:	88 44 32 ff          	mov    %al,-0x1(%edx,%esi,1)
    if(c == '\n' || c == '\r')
 4c1:	74 04                	je     4c7 <gets+0x47>
 4c3:	3c 0a                	cmp    $0xa,%al
 4c5:	75 c7                	jne    48e <gets+0xe>
      break;
  }
  buf[i] = '\0';
 4c7:	8b 45 08             	mov    0x8(%ebp),%eax
 4ca:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 4ce:	83 c4 2c             	add    $0x2c,%esp
 4d1:	5b                   	pop    %ebx
 4d2:	5e                   	pop    %esi
 4d3:	5f                   	pop    %edi
 4d4:	5d                   	pop    %ebp
 4d5:	c3                   	ret    
 4d6:	66 90                	xchg   %ax,%ax
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 4d8:	8b 45 08             	mov    0x8(%ebp),%eax
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
 4db:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 4dd:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 4e1:	83 c4 2c             	add    $0x2c,%esp
 4e4:	5b                   	pop    %ebx
 4e5:	5e                   	pop    %esi
 4e6:	5f                   	pop    %edi
 4e7:	5d                   	pop    %ebp
 4e8:	c3                   	ret    
 4e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000004f0 <stat>:

int
stat(char *n, struct stat *st)
{
 4f0:	55                   	push   %ebp
 4f1:	89 e5                	mov    %esp,%ebp
 4f3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4f6:	8b 45 08             	mov    0x8(%ebp),%eax
 4f9:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 500:	00 
  return buf;
}

int
stat(char *n, struct stat *st)
{
 501:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 504:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 507:	89 04 24             	mov    %eax,(%esp)
 50a:	e8 e3 00 00 00       	call   5f2 <open>
  if(fd < 0)
 50f:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 511:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 513:	78 2b                	js     540 <stat+0x50>
    return -1;
  r = fstat(fd, st);
 515:	8b 45 0c             	mov    0xc(%ebp),%eax
 518:	89 1c 24             	mov    %ebx,(%esp)
 51b:	89 44 24 04          	mov    %eax,0x4(%esp)
 51f:	e8 e6 00 00 00       	call   60a <fstat>
  close(fd);
 524:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 527:	89 c6                	mov    %eax,%esi
  close(fd);
 529:	e8 ac 00 00 00       	call   5da <close>
  return r;
}
 52e:	89 f0                	mov    %esi,%eax
 530:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 533:	8b 75 fc             	mov    -0x4(%ebp),%esi
 536:	89 ec                	mov    %ebp,%esp
 538:	5d                   	pop    %ebp
 539:	c3                   	ret    
 53a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 540:	be ff ff ff ff       	mov    $0xffffffff,%esi
 545:	eb e7                	jmp    52e <stat+0x3e>
 547:	89 f6                	mov    %esi,%esi
 549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000550 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 550:	55                   	push   %ebp
 551:	89 e5                	mov    %esp,%ebp
 553:	8b 4d 08             	mov    0x8(%ebp),%ecx
 556:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 557:	0f be 11             	movsbl (%ecx),%edx
 55a:	8d 42 d0             	lea    -0x30(%edx),%eax
 55d:	3c 09                	cmp    $0x9,%al
 55f:	b8 00 00 00 00       	mov    $0x0,%eax
 564:	77 17                	ja     57d <atoi+0x2d>
 566:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 568:	83 c1 01             	add    $0x1,%ecx
 56b:	8d 04 80             	lea    (%eax,%eax,4),%eax
 56e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 572:	0f be 11             	movsbl (%ecx),%edx
 575:	8d 5a d0             	lea    -0x30(%edx),%ebx
 578:	80 fb 09             	cmp    $0x9,%bl
 57b:	76 eb                	jbe    568 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 57d:	5b                   	pop    %ebx
 57e:	5d                   	pop    %ebp
 57f:	c3                   	ret    

00000580 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 580:	55                   	push   %ebp
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
 581:	31 d2                	xor    %edx,%edx
{
 583:	89 e5                	mov    %esp,%ebp
 585:	56                   	push   %esi
 586:	8b 45 08             	mov    0x8(%ebp),%eax
 589:	53                   	push   %ebx
 58a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 58d:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 590:	85 db                	test   %ebx,%ebx
 592:	7e 12                	jle    5a6 <memmove+0x26>
 594:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 598:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 59c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 59f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 5a2:	39 da                	cmp    %ebx,%edx
 5a4:	75 f2                	jne    598 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 5a6:	5b                   	pop    %ebx
 5a7:	5e                   	pop    %esi
 5a8:	5d                   	pop    %ebp
 5a9:	c3                   	ret    

000005aa <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 5aa:	b8 01 00 00 00       	mov    $0x1,%eax
 5af:	cd 40                	int    $0x40
 5b1:	c3                   	ret    

000005b2 <exit>:
SYSCALL(exit)
 5b2:	b8 02 00 00 00       	mov    $0x2,%eax
 5b7:	cd 40                	int    $0x40
 5b9:	c3                   	ret    

000005ba <wait>:
SYSCALL(wait)
 5ba:	b8 03 00 00 00       	mov    $0x3,%eax
 5bf:	cd 40                	int    $0x40
 5c1:	c3                   	ret    

000005c2 <pipe>:
SYSCALL(pipe)
 5c2:	b8 04 00 00 00       	mov    $0x4,%eax
 5c7:	cd 40                	int    $0x40
 5c9:	c3                   	ret    

000005ca <read>:
SYSCALL(read)
 5ca:	b8 05 00 00 00       	mov    $0x5,%eax
 5cf:	cd 40                	int    $0x40
 5d1:	c3                   	ret    

000005d2 <write>:
SYSCALL(write)
 5d2:	b8 10 00 00 00       	mov    $0x10,%eax
 5d7:	cd 40                	int    $0x40
 5d9:	c3                   	ret    

000005da <close>:
SYSCALL(close)
 5da:	b8 15 00 00 00       	mov    $0x15,%eax
 5df:	cd 40                	int    $0x40
 5e1:	c3                   	ret    

000005e2 <kill>:
SYSCALL(kill)
 5e2:	b8 06 00 00 00       	mov    $0x6,%eax
 5e7:	cd 40                	int    $0x40
 5e9:	c3                   	ret    

000005ea <exec>:
SYSCALL(exec)
 5ea:	b8 07 00 00 00       	mov    $0x7,%eax
 5ef:	cd 40                	int    $0x40
 5f1:	c3                   	ret    

000005f2 <open>:
SYSCALL(open)
 5f2:	b8 0f 00 00 00       	mov    $0xf,%eax
 5f7:	cd 40                	int    $0x40
 5f9:	c3                   	ret    

000005fa <mknod>:
SYSCALL(mknod)
 5fa:	b8 11 00 00 00       	mov    $0x11,%eax
 5ff:	cd 40                	int    $0x40
 601:	c3                   	ret    

00000602 <unlink>:
SYSCALL(unlink)
 602:	b8 12 00 00 00       	mov    $0x12,%eax
 607:	cd 40                	int    $0x40
 609:	c3                   	ret    

0000060a <fstat>:
SYSCALL(fstat)
 60a:	b8 08 00 00 00       	mov    $0x8,%eax
 60f:	cd 40                	int    $0x40
 611:	c3                   	ret    

00000612 <link>:
SYSCALL(link)
 612:	b8 13 00 00 00       	mov    $0x13,%eax
 617:	cd 40                	int    $0x40
 619:	c3                   	ret    

0000061a <mkdir>:
SYSCALL(mkdir)
 61a:	b8 14 00 00 00       	mov    $0x14,%eax
 61f:	cd 40                	int    $0x40
 621:	c3                   	ret    

00000622 <chdir>:
SYSCALL(chdir)
 622:	b8 09 00 00 00       	mov    $0x9,%eax
 627:	cd 40                	int    $0x40
 629:	c3                   	ret    

0000062a <dup>:
SYSCALL(dup)
 62a:	b8 0a 00 00 00       	mov    $0xa,%eax
 62f:	cd 40                	int    $0x40
 631:	c3                   	ret    

00000632 <getpid>:
SYSCALL(getpid)
 632:	b8 0b 00 00 00       	mov    $0xb,%eax
 637:	cd 40                	int    $0x40
 639:	c3                   	ret    

0000063a <sbrk>:
SYSCALL(sbrk)
 63a:	b8 0c 00 00 00       	mov    $0xc,%eax
 63f:	cd 40                	int    $0x40
 641:	c3                   	ret    

00000642 <sleep>:
SYSCALL(sleep)
 642:	b8 0d 00 00 00       	mov    $0xd,%eax
 647:	cd 40                	int    $0x40
 649:	c3                   	ret    

0000064a <uptime>:
SYSCALL(uptime)
 64a:	b8 0e 00 00 00       	mov    $0xe,%eax
 64f:	cd 40                	int    $0x40
 651:	c3                   	ret    

00000652 <getprocs>:
SYSCALL(getprocs)
 652:	b8 16 00 00 00       	mov    $0x16,%eax
 657:	cd 40                	int    $0x40
 659:	c3                   	ret    
 65a:	66 90                	xchg   %ax,%ax
 65c:	66 90                	xchg   %ax,%ax
 65e:	66 90                	xchg   %ax,%ax

00000660 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 660:	55                   	push   %ebp
 661:	89 e5                	mov    %esp,%ebp
 663:	57                   	push   %edi
 664:	89 c7                	mov    %eax,%edi
 666:	56                   	push   %esi
 667:	53                   	push   %ebx
 668:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 66b:	8b 45 08             	mov    0x8(%ebp),%eax
 66e:	85 c0                	test   %eax,%eax
 670:	74 76                	je     6e8 <printint+0x88>
 672:	89 d0                	mov    %edx,%eax
 674:	c1 e8 1f             	shr    $0x1f,%eax
 677:	84 c0                	test   %al,%al
 679:	74 6d                	je     6e8 <printint+0x88>
    neg = 1;
    x = -xx;
 67b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 67d:	bb 01 00 00 00       	mov    $0x1,%ebx
    x = -xx;
 682:	f7 d8                	neg    %eax
  } else {
    x = xx;
  }

  i = 0;
 684:	31 f6                	xor    %esi,%esi
 686:	eb 02                	jmp    68a <printint+0x2a>
  do{
    buf[i++] = digits[x % base];
 688:	89 d6                	mov    %edx,%esi
 68a:	31 d2                	xor    %edx,%edx
 68c:	f7 f1                	div    %ecx
 68e:	0f b6 92 9f 0a 00 00 	movzbl 0xa9f(%edx),%edx
  }while((x /= base) != 0);
 695:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 697:	88 54 35 d8          	mov    %dl,-0x28(%ebp,%esi,1)
 69b:	8d 56 01             	lea    0x1(%esi),%edx
  }while((x /= base) != 0);
 69e:	75 e8                	jne    688 <printint+0x28>
  if(neg)
 6a0:	85 db                	test   %ebx,%ebx
 6a2:	74 08                	je     6ac <printint+0x4c>
    buf[i++] = '-';
 6a4:	c6 44 15 d8 2d       	movb   $0x2d,-0x28(%ebp,%edx,1)
 6a9:	8d 56 02             	lea    0x2(%esi),%edx

  while(--i >= 0)
 6ac:	8d 5a ff             	lea    -0x1(%edx),%ebx
 6af:	83 fb ff             	cmp    $0xffffffff,%ebx
 6b2:	8d 75 d7             	lea    -0x29(%ebp),%esi
 6b5:	74 25                	je     6dc <printint+0x7c>
 6b7:	90                   	nop
 6b8:	0f b6 44 1d d8       	movzbl -0x28(%ebp,%ebx,1),%eax
 6bd:	83 eb 01             	sub    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6c0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6c7:	00 
 6c8:	89 74 24 04          	mov    %esi,0x4(%esp)
 6cc:	89 3c 24             	mov    %edi,(%esp)
 6cf:	88 45 d7             	mov    %al,-0x29(%ebp)
 6d2:	e8 fb fe ff ff       	call   5d2 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 6d7:	83 fb ff             	cmp    $0xffffffff,%ebx
 6da:	75 dc                	jne    6b8 <printint+0x58>
    putc(fd, buf[i]);
}
 6dc:	83 c4 3c             	add    $0x3c,%esp
 6df:	5b                   	pop    %ebx
 6e0:	5e                   	pop    %esi
 6e1:	5f                   	pop    %edi
 6e2:	5d                   	pop    %ebp
 6e3:	c3                   	ret    
 6e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 6e8:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 6ea:	31 db                	xor    %ebx,%ebx
 6ec:	eb 96                	jmp    684 <printint+0x24>
 6ee:	66 90                	xchg   %ax,%ax

000006f0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 6f0:	55                   	push   %ebp
 6f1:	89 e5                	mov    %esp,%ebp
 6f3:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 6f4:	31 ff                	xor    %edi,%edi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 6f6:	56                   	push   %esi
 6f7:	53                   	push   %ebx
 6f8:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6fb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 6fe:	8d 55 10             	lea    0x10(%ebp),%edx
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 701:	8b 75 08             	mov    0x8(%ebp),%esi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 704:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 707:	0f be 03             	movsbl (%ebx),%eax
    putc(fd, buf[i]);
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
 70a:	83 c3 01             	add    $0x1,%ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 70d:	84 c0                	test   %al,%al
 70f:	75 39                	jne    74a <printf+0x5a>
 711:	e9 c2 00 00 00       	jmp    7d8 <printf+0xe8>
 716:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 718:	83 fa 25             	cmp    $0x25,%edx
 71b:	0f 84 bf 00 00 00    	je     7e0 <printf+0xf0>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 721:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 724:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 72b:	00 
 72c:	89 44 24 04          	mov    %eax,0x4(%esp)
 730:	89 34 24             	mov    %esi,(%esp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 733:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 736:	e8 97 fe ff ff       	call   5d2 <write>
 73b:	83 c3 01             	add    $0x1,%ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 73e:	0f be 43 ff          	movsbl -0x1(%ebx),%eax
 742:	84 c0                	test   %al,%al
 744:	0f 84 8e 00 00 00    	je     7d8 <printf+0xe8>
    c = fmt[i] & 0xff;
 74a:	0f b6 d0             	movzbl %al,%edx
    if(state == 0){
 74d:	85 ff                	test   %edi,%edi
 74f:	74 c7                	je     718 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 751:	83 ff 25             	cmp    $0x25,%edi
 754:	75 e5                	jne    73b <printf+0x4b>
      if(c == 'd'){
 756:	83 fa 64             	cmp    $0x64,%edx
 759:	0f 84 31 01 00 00    	je     890 <printf+0x1a0>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 75f:	25 f7 00 00 00       	and    $0xf7,%eax
 764:	83 f8 70             	cmp    $0x70,%eax
 767:	0f 84 83 00 00 00    	je     7f0 <printf+0x100>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 76d:	83 fa 73             	cmp    $0x73,%edx
 770:	0f 84 a2 00 00 00    	je     818 <printf+0x128>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 776:	83 fa 63             	cmp    $0x63,%edx
 779:	0f 84 35 01 00 00    	je     8b4 <printf+0x1c4>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 77f:	83 fa 25             	cmp    $0x25,%edx
 782:	0f 84 e0 00 00 00    	je     868 <printf+0x178>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 788:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 78b:	83 c3 01             	add    $0x1,%ebx
 78e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 795:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 796:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 798:	89 44 24 04          	mov    %eax,0x4(%esp)
 79c:	89 34 24             	mov    %esi,(%esp)
 79f:	89 55 d0             	mov    %edx,-0x30(%ebp)
 7a2:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 7a6:	e8 27 fe ff ff       	call   5d2 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 7ab:	8b 55 d0             	mov    -0x30(%ebp),%edx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7ae:	8d 45 e7             	lea    -0x19(%ebp),%eax
 7b1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 7b8:	00 
 7b9:	89 44 24 04          	mov    %eax,0x4(%esp)
 7bd:	89 34 24             	mov    %esi,(%esp)
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 7c0:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7c3:	e8 0a fe ff ff       	call   5d2 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7c8:	0f be 43 ff          	movsbl -0x1(%ebx),%eax
 7cc:	84 c0                	test   %al,%al
 7ce:	0f 85 76 ff ff ff    	jne    74a <printf+0x5a>
 7d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 7d8:	83 c4 3c             	add    $0x3c,%esp
 7db:	5b                   	pop    %ebx
 7dc:	5e                   	pop    %esi
 7dd:	5f                   	pop    %edi
 7de:	5d                   	pop    %ebp
 7df:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 7e0:	bf 25 00 00 00       	mov    $0x25,%edi
 7e5:	e9 51 ff ff ff       	jmp    73b <printf+0x4b>
 7ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 7f0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 7f3:	b9 10 00 00 00       	mov    $0x10,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7f8:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 7fa:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 801:	8b 10                	mov    (%eax),%edx
 803:	89 f0                	mov    %esi,%eax
 805:	e8 56 fe ff ff       	call   660 <printint>
        ap++;
 80a:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 80e:	e9 28 ff ff ff       	jmp    73b <printf+0x4b>
 813:	90                   	nop
 814:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 818:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        ap++;
        if(s == 0)
          s = "(null)";
 81b:	b8 98 0a 00 00       	mov    $0xa98,%eax
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
 820:	8b 3a                	mov    (%edx),%edi
        ap++;
 822:	83 c2 04             	add    $0x4,%edx
 825:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
          s = "(null)";
 828:	85 ff                	test   %edi,%edi
 82a:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 82d:	0f b6 07             	movzbl (%edi),%eax
 830:	84 c0                	test   %al,%al
 832:	74 28                	je     85c <printf+0x16c>
 834:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 838:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 83b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 83e:	83 c7 01             	add    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 841:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 848:	00 
 849:	89 44 24 04          	mov    %eax,0x4(%esp)
 84d:	89 34 24             	mov    %esi,(%esp)
 850:	e8 7d fd ff ff       	call   5d2 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 855:	0f b6 07             	movzbl (%edi),%eax
 858:	84 c0                	test   %al,%al
 85a:	75 dc                	jne    838 <printf+0x148>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 85c:	31 ff                	xor    %edi,%edi
 85e:	e9 d8 fe ff ff       	jmp    73b <printf+0x4b>
 863:	90                   	nop
 864:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 868:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 86b:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 86d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 874:	00 
 875:	89 44 24 04          	mov    %eax,0x4(%esp)
 879:	89 34 24             	mov    %esi,(%esp)
 87c:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 880:	e8 4d fd ff ff       	call   5d2 <write>
 885:	e9 b1 fe ff ff       	jmp    73b <printf+0x4b>
 88a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 890:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 893:	b9 0a 00 00 00       	mov    $0xa,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 898:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 89b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 8a2:	8b 10                	mov    (%eax),%edx
 8a4:	89 f0                	mov    %esi,%eax
 8a6:	e8 b5 fd ff ff       	call   660 <printint>
        ap++;
 8ab:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 8af:	e9 87 fe ff ff       	jmp    73b <printf+0x4b>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 8b4:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 8b7:	31 ff                	xor    %edi,%edi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 8b9:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 8bb:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 8c2:	00 
 8c3:	89 34 24             	mov    %esi,(%esp)
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 8c6:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 8c9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 8cc:	89 44 24 04          	mov    %eax,0x4(%esp)
 8d0:	e8 fd fc ff ff       	call   5d2 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 8d5:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 8d9:	e9 5d fe ff ff       	jmp    73b <printf+0x4b>
 8de:	66 90                	xchg   %ax,%ax

000008e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8e0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8e1:	a1 ac 0d 00 00       	mov    0xdac,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 8e6:	89 e5                	mov    %esp,%ebp
 8e8:	57                   	push   %edi
 8e9:	56                   	push   %esi
 8ea:	53                   	push   %ebx
 8eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8ee:	8b 08                	mov    (%eax),%ecx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8f0:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8f3:	39 d0                	cmp    %edx,%eax
 8f5:	72 11                	jb     908 <free+0x28>
 8f7:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8f8:	39 c8                	cmp    %ecx,%eax
 8fa:	72 04                	jb     900 <free+0x20>
 8fc:	39 ca                	cmp    %ecx,%edx
 8fe:	72 10                	jb     910 <free+0x30>
 900:	89 c8                	mov    %ecx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 902:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 904:	8b 08                	mov    (%eax),%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 906:	73 f0                	jae    8f8 <free+0x18>
 908:	39 ca                	cmp    %ecx,%edx
 90a:	72 04                	jb     910 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 90c:	39 c8                	cmp    %ecx,%eax
 90e:	72 f0                	jb     900 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 910:	8b 73 fc             	mov    -0x4(%ebx),%esi
 913:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 916:	39 cf                	cmp    %ecx,%edi
 918:	74 1e                	je     938 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 91a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 91d:	8b 48 04             	mov    0x4(%eax),%ecx
 920:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 923:	39 f2                	cmp    %esi,%edx
 925:	74 28                	je     94f <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 927:	89 10                	mov    %edx,(%eax)
  freep = p;
 929:	a3 ac 0d 00 00       	mov    %eax,0xdac
}
 92e:	5b                   	pop    %ebx
 92f:	5e                   	pop    %esi
 930:	5f                   	pop    %edi
 931:	5d                   	pop    %ebp
 932:	c3                   	ret    
 933:	90                   	nop
 934:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 938:	03 71 04             	add    0x4(%ecx),%esi
 93b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 93e:	8b 08                	mov    (%eax),%ecx
 940:	8b 09                	mov    (%ecx),%ecx
 942:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 945:	8b 48 04             	mov    0x4(%eax),%ecx
 948:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 94b:	39 f2                	cmp    %esi,%edx
 94d:	75 d8                	jne    927 <free+0x47>
    p->s.size += bp->s.size;
 94f:	03 4b fc             	add    -0x4(%ebx),%ecx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 952:	a3 ac 0d 00 00       	mov    %eax,0xdac
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 957:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 95a:	8b 53 f8             	mov    -0x8(%ebx),%edx
 95d:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 95f:	5b                   	pop    %ebx
 960:	5e                   	pop    %esi
 961:	5f                   	pop    %edi
 962:	5d                   	pop    %ebp
 963:	c3                   	ret    
 964:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 96a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000970 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 970:	55                   	push   %ebp
 971:	89 e5                	mov    %esp,%ebp
 973:	57                   	push   %edi
 974:	56                   	push   %esi
 975:	53                   	push   %ebx
 976:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 979:	8b 55 08             	mov    0x8(%ebp),%edx
  if((prevp = freep) == 0){
 97c:	8b 0d ac 0d 00 00    	mov    0xdac,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 982:	83 c2 07             	add    $0x7,%edx
 985:	c1 ea 03             	shr    $0x3,%edx
  if((prevp = freep) == 0){
 988:	85 c9                	test   %ecx,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 98a:	8d 5a 01             	lea    0x1(%edx),%ebx
  if((prevp = freep) == 0){
 98d:	0f 84 93 00 00 00    	je     a26 <malloc+0xb6>
 993:	8b 01                	mov    (%ecx),%eax
 995:	8b 78 04             	mov    0x4(%eax),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 998:	39 fb                	cmp    %edi,%ebx
 99a:	76 64                	jbe    a00 <malloc+0x90>
 99c:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 9a3:	eb 0c                	jmp    9b1 <malloc+0x41>
 9a5:	8d 76 00             	lea    0x0(%esi),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9a8:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
 9aa:	8b 78 04             	mov    0x4(%eax),%edi
 9ad:	39 fb                	cmp    %edi,%ebx
 9af:	76 4f                	jbe    a00 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9b1:	3b 05 ac 0d 00 00    	cmp    0xdac,%eax
 9b7:	89 c1                	mov    %eax,%ecx
 9b9:	75 ed                	jne    9a8 <malloc+0x38>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 9bb:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 9c1:	b8 00 80 00 00       	mov    $0x8000,%eax
 9c6:	0f 43 c6             	cmovae %esi,%eax
 9c9:	bf 00 10 00 00       	mov    $0x1000,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 9ce:	89 04 24             	mov    %eax,(%esp)
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 9d1:	0f 43 fb             	cmovae %ebx,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 9d4:	e8 61 fc ff ff       	call   63a <sbrk>
  if(p == (char*)-1)
 9d9:	83 f8 ff             	cmp    $0xffffffff,%eax
 9dc:	74 18                	je     9f6 <malloc+0x86>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 9de:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 9e1:	83 c0 08             	add    $0x8,%eax
 9e4:	89 04 24             	mov    %eax,(%esp)
 9e7:	e8 f4 fe ff ff       	call   8e0 <free>
  return freep;
 9ec:	8b 0d ac 0d 00 00    	mov    0xdac,%ecx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 9f2:	85 c9                	test   %ecx,%ecx
 9f4:	75 b2                	jne    9a8 <malloc+0x38>
        return 0;
 9f6:	31 c0                	xor    %eax,%eax
 9f8:	eb 1e                	jmp    a18 <malloc+0xa8>
 9fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 a00:	39 fb                	cmp    %edi,%ebx
 a02:	74 1c                	je     a20 <malloc+0xb0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 a04:	29 df                	sub    %ebx,%edi
 a06:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 a09:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 a0c:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 a0f:	89 0d ac 0d 00 00    	mov    %ecx,0xdac
      return (void*)(p + 1);
 a15:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a18:	83 c4 1c             	add    $0x1c,%esp
 a1b:	5b                   	pop    %ebx
 a1c:	5e                   	pop    %esi
 a1d:	5f                   	pop    %edi
 a1e:	5d                   	pop    %ebp
 a1f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 a20:	8b 10                	mov    (%eax),%edx
 a22:	89 11                	mov    %edx,(%ecx)
 a24:	eb e9                	jmp    a0f <malloc+0x9f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 a26:	c7 05 ac 0d 00 00 b0 	movl   $0xdb0,0xdac
 a2d:	0d 00 00 
    base.s.size = 0;
 a30:	b8 b0 0d 00 00       	mov    $0xdb0,%eax
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 a35:	c7 05 b0 0d 00 00 b0 	movl   $0xdb0,0xdb0
 a3c:	0d 00 00 
    base.s.size = 0;
 a3f:	c7 05 b4 0d 00 00 00 	movl   $0x0,0xdb4
 a46:	00 00 00 
 a49:	e9 4e ff ff ff       	jmp    99c <malloc+0x2c>
