
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return 0;
}

int
main(void)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 e4 f0             	and    $0xfffffff0,%esp
       6:	83 ec 10             	sub    $0x10,%esp
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
       9:	eb 0e                	jmp    19 <main+0x19>
       b:	90                   	nop
       c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(fd >= 3){
      10:	83 f8 02             	cmp    $0x2,%eax
      13:	0f 8f cd 00 00 00    	jg     e6 <main+0xe6>
{
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
      19:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
      20:	00 
      21:	c7 04 24 41 13 00 00 	movl   $0x1341,(%esp)
      28:	e8 15 0e 00 00       	call   e42 <open>
      2d:	85 c0                	test   %eax,%eax
      2f:	79 df                	jns    10 <main+0x10>
      31:	eb 23                	jmp    56 <main+0x56>
      33:	90                   	nop
      34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      38:	80 3d 62 19 00 00 20 	cmpb   $0x20,0x1962
      3f:	90                   	nop
      40:	74 60                	je     a2 <main+0xa2>
      42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      buf[strlen(buf)-1] = 0;  // chop \n
      if(chdir(buf+3) < 0)
        printf(2, "cannot cd %s\n", buf+3);
      continue;
    }
    if(fork1() == 0)
      48:	e8 43 01 00 00       	call   190 <fork1>
      4d:	85 c0                	test   %eax,%eax
      4f:	74 38                	je     89 <main+0x89>
      runcmd(parsecmd(buf));
    wait();
      51:	e8 b4 0d 00 00       	call   e0a <wait>
      break;
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
      56:	c7 44 24 04 64 00 00 	movl   $0x64,0x4(%esp)
      5d:	00 
      5e:	c7 04 24 60 19 00 00 	movl   $0x1960,(%esp)
      65:	e8 96 00 00 00       	call   100 <getcmd>
      6a:	85 c0                	test   %eax,%eax
      6c:	78 2f                	js     9d <main+0x9d>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      6e:	80 3d 60 19 00 00 63 	cmpb   $0x63,0x1960
      75:	75 d1                	jne    48 <main+0x48>
      77:	80 3d 61 19 00 00 64 	cmpb   $0x64,0x1961
      7e:	74 b8                	je     38 <main+0x38>
      buf[strlen(buf)-1] = 0;  // chop \n
      if(chdir(buf+3) < 0)
        printf(2, "cannot cd %s\n", buf+3);
      continue;
    }
    if(fork1() == 0)
      80:	e8 0b 01 00 00       	call   190 <fork1>
      85:	85 c0                	test   %eax,%eax
      87:	75 c8                	jne    51 <main+0x51>
      runcmd(parsecmd(buf));
      89:	c7 04 24 60 19 00 00 	movl   $0x1960,(%esp)
      90:	e8 bb 0a 00 00       	call   b50 <parsecmd>
      95:	89 04 24             	mov    %eax,(%esp)
      98:	e8 13 01 00 00       	call   1b0 <runcmd>
    wait();
  }
  exit();
      9d:	e8 60 0d 00 00       	call   e02 <exit>

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      // Chdir must be called by the parent, not the child.
      buf[strlen(buf)-1] = 0;  // chop \n
      a2:	c7 04 24 60 19 00 00 	movl   $0x1960,(%esp)
      a9:	e8 92 0b 00 00       	call   c40 <strlen>
      if(chdir(buf+3) < 0)
      ae:	c7 04 24 63 19 00 00 	movl   $0x1963,(%esp)

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      // Chdir must be called by the parent, not the child.
      buf[strlen(buf)-1] = 0;  // chop \n
      b5:	c6 80 5f 19 00 00 00 	movb   $0x0,0x195f(%eax)
      if(chdir(buf+3) < 0)
      bc:	e8 b1 0d 00 00       	call   e72 <chdir>
      c1:	85 c0                	test   %eax,%eax
      c3:	79 91                	jns    56 <main+0x56>
        printf(2, "cannot cd %s\n", buf+3);
      c5:	c7 44 24 08 63 19 00 	movl   $0x1963,0x8(%esp)
      cc:	00 
      cd:	c7 44 24 04 49 13 00 	movl   $0x1349,0x4(%esp)
      d4:	00 
      d5:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
      dc:	e8 5f 0e 00 00       	call   f40 <printf>
      e1:	e9 70 ff ff ff       	jmp    56 <main+0x56>
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
    if(fd >= 3){
      close(fd);
      e6:	89 04 24             	mov    %eax,(%esp)
      e9:	e8 3c 0d 00 00       	call   e2a <close>
      ee:	66 90                	xchg   %ax,%ax
      break;
      f0:	e9 61 ff ff ff       	jmp    56 <main+0x56>
      f5:	66 90                	xchg   %ax,%ax
      f7:	66 90                	xchg   %ax,%ax
      f9:	66 90                	xchg   %ax,%ax
      fb:	66 90                	xchg   %ax,%ax
      fd:	66 90                	xchg   %ax,%ax
      ff:	90                   	nop

00000100 <getcmd>:
  exit();
}

int
getcmd(char *buf, int nbuf)
{
     100:	55                   	push   %ebp
     101:	89 e5                	mov    %esp,%ebp
     103:	83 ec 18             	sub    $0x18,%esp
     106:	89 5d f8             	mov    %ebx,-0x8(%ebp)
     109:	8b 5d 08             	mov    0x8(%ebp),%ebx
     10c:	89 75 fc             	mov    %esi,-0x4(%ebp)
     10f:	8b 75 0c             	mov    0xc(%ebp),%esi
  printf(2, "$ ");
     112:	c7 44 24 04 a0 12 00 	movl   $0x12a0,0x4(%esp)
     119:	00 
     11a:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     121:	e8 1a 0e 00 00       	call   f40 <printf>
  memset(buf, 0, nbuf);
     126:	89 74 24 08          	mov    %esi,0x8(%esp)
     12a:	89 1c 24             	mov    %ebx,(%esp)
     12d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     134:	00 
     135:	e8 36 0b 00 00       	call   c70 <memset>
  gets(buf, nbuf);
     13a:	89 74 24 04          	mov    %esi,0x4(%esp)
     13e:	89 1c 24             	mov    %ebx,(%esp)
     141:	e8 8a 0b 00 00       	call   cd0 <gets>
  if(buf[0] == 0) // EOF
    return -1;
  return 0;
}
     146:	8b 75 fc             	mov    -0x4(%ebp),%esi
{
  printf(2, "$ ");
  memset(buf, 0, nbuf);
  gets(buf, nbuf);
  if(buf[0] == 0) // EOF
    return -1;
     149:	80 3b 01             	cmpb   $0x1,(%ebx)
  return 0;
}
     14c:	8b 5d f8             	mov    -0x8(%ebp),%ebx
{
  printf(2, "$ ");
  memset(buf, 0, nbuf);
  gets(buf, nbuf);
  if(buf[0] == 0) // EOF
    return -1;
     14f:	19 c0                	sbb    %eax,%eax
  return 0;
}
     151:	89 ec                	mov    %ebp,%esp
     153:	5d                   	pop    %ebp
     154:	c3                   	ret    
     155:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000160 <panic>:
  exit();
}

void
panic(char *s)
{
     160:	55                   	push   %ebp
     161:	89 e5                	mov    %esp,%ebp
     163:	83 ec 18             	sub    $0x18,%esp
  printf(2, "%s\n", s);
     166:	8b 45 08             	mov    0x8(%ebp),%eax
     169:	c7 44 24 04 3d 13 00 	movl   $0x133d,0x4(%esp)
     170:	00 
     171:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     178:	89 44 24 08          	mov    %eax,0x8(%esp)
     17c:	e8 bf 0d 00 00       	call   f40 <printf>
  exit();
     181:	e8 7c 0c 00 00       	call   e02 <exit>
     186:	8d 76 00             	lea    0x0(%esi),%esi
     189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000190 <fork1>:
}

int
fork1(void)
{
     190:	55                   	push   %ebp
     191:	89 e5                	mov    %esp,%ebp
     193:	83 ec 18             	sub    $0x18,%esp
  int pid;

  pid = fork();
     196:	e8 5f 0c 00 00       	call   dfa <fork>
  if(pid == -1)
     19b:	83 f8 ff             	cmp    $0xffffffff,%eax
     19e:	74 02                	je     1a2 <fork1+0x12>
    panic("fork");
  return pid;
}
     1a0:	c9                   	leave  
     1a1:	c3                   	ret    
{
  int pid;

  pid = fork();
  if(pid == -1)
    panic("fork");
     1a2:	c7 04 24 a3 12 00 00 	movl   $0x12a3,(%esp)
     1a9:	e8 b2 ff ff ff       	call   160 <panic>
     1ae:	66 90                	xchg   %ax,%ax

000001b0 <runcmd>:
struct cmd *parsecmd(char*);

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
{
     1b0:	55                   	push   %ebp
     1b1:	89 e5                	mov    %esp,%ebp
     1b3:	53                   	push   %ebx
     1b4:	83 ec 24             	sub    $0x24,%esp
     1b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     1ba:	85 db                	test   %ebx,%ebx
     1bc:	74 5f                	je     21d <runcmd+0x6d>
    exit();

  switch(cmd->type){
     1be:	83 3b 05             	cmpl   $0x5,(%ebx)
     1c1:	76 62                	jbe    225 <runcmd+0x75>
  default:
    panic("runcmd");
     1c3:	c7 04 24 a8 12 00 00 	movl   $0x12a8,(%esp)
     1ca:	e8 91 ff ff ff       	call   160 <panic>
    runcmd(lcmd->right);
    break;

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    if(pipe(p) < 0)
     1cf:	8d 45 f0             	lea    -0x10(%ebp),%eax
     1d2:	89 04 24             	mov    %eax,(%esp)
     1d5:	e8 38 0c 00 00       	call   e12 <pipe>
     1da:	85 c0                	test   %eax,%eax
     1dc:	0f 88 f9 00 00 00    	js     2db <runcmd+0x12b>
      panic("pipe");
    if(fork1() == 0){
     1e2:	e8 a9 ff ff ff       	call   190 <fork1>
     1e7:	85 c0                	test   %eax,%eax
     1e9:	0f 84 30 01 00 00    	je     31f <runcmd+0x16f>
     1ef:	90                   	nop
      dup(p[1]);
      close(p[0]);
      close(p[1]);
      runcmd(pcmd->left);
    }
    if(fork1() == 0){
     1f0:	e8 9b ff ff ff       	call   190 <fork1>
     1f5:	85 c0                	test   %eax,%eax
     1f7:	0f 84 ea 00 00 00    	je     2e7 <runcmd+0x137>
      dup(p[0]);
      close(p[0]);
      close(p[1]);
      runcmd(pcmd->right);
    }
    close(p[0]);
     1fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
     200:	89 04 24             	mov    %eax,(%esp)
     203:	e8 22 0c 00 00       	call   e2a <close>
    close(p[1]);
     208:	8b 45 f4             	mov    -0xc(%ebp),%eax
     20b:	89 04 24             	mov    %eax,(%esp)
     20e:	e8 17 0c 00 00       	call   e2a <close>
    wait();
     213:	e8 f2 0b 00 00       	call   e0a <wait>
    wait();
     218:	e8 ed 0b 00 00       	call   e0a <wait>
     21d:	8d 76 00             	lea    0x0(%esi),%esi
  case REDIR:
    rcmd = (struct redircmd*)cmd;
    close(rcmd->fd);
    if(open(rcmd->file, rcmd->mode) < 0){
      printf(2, "open %s failed\n", rcmd->file);
      exit();
     220:	e8 dd 0b 00 00       	call   e02 <exit>
  struct redircmd *rcmd;

  if(cmd == 0)
    exit();

  switch(cmd->type){
     225:	8b 03                	mov    (%ebx),%eax
     227:	ff 24 85 58 13 00 00 	jmp    *0x1358(,%eax,4)
     22e:	66 90                	xchg   %ax,%ax
    wait();
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    if(fork1() == 0)
     230:	e8 5b ff ff ff       	call   190 <fork1>
     235:	85 c0                	test   %eax,%eax
     237:	75 e4                	jne    21d <runcmd+0x6d>
     239:	eb 3f                	jmp    27a <runcmd+0xca>
     23b:	90                   	nop
     23c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    runcmd(rcmd->cmd);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    if(fork1() == 0)
     240:	e8 4b ff ff ff       	call   190 <fork1>
     245:	85 c0                	test   %eax,%eax
     247:	74 31                	je     27a <runcmd+0xca>
      runcmd(lcmd->left);
    wait();
     249:	e8 bc 0b 00 00       	call   e0a <wait>
    runcmd(lcmd->right);
     24e:	8b 43 08             	mov    0x8(%ebx),%eax
     251:	89 04 24             	mov    %eax,(%esp)
     254:	e8 57 ff ff ff       	call   1b0 <runcmd>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    close(rcmd->fd);
     259:	8b 43 14             	mov    0x14(%ebx),%eax
     25c:	89 04 24             	mov    %eax,(%esp)
     25f:	e8 c6 0b 00 00       	call   e2a <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     264:	8b 43 10             	mov    0x10(%ebx),%eax
     267:	89 44 24 04          	mov    %eax,0x4(%esp)
     26b:	8b 43 08             	mov    0x8(%ebx),%eax
     26e:	89 04 24             	mov    %eax,(%esp)
     271:	e8 cc 0b 00 00       	call   e42 <open>
     276:	85 c0                	test   %eax,%eax
     278:	78 41                	js     2bb <runcmd+0x10b>
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    if(fork1() == 0)
      runcmd(bcmd->cmd);
     27a:	8b 43 04             	mov    0x4(%ebx),%eax
     27d:	89 04 24             	mov    %eax,(%esp)
     280:	e8 2b ff ff ff       	call   1b0 <runcmd>
  default:
    panic("runcmd");

  case EXEC:
    ecmd = (struct execcmd*)cmd;
    if(ecmd->argv[0] == 0)
     285:	8b 43 04             	mov    0x4(%ebx),%eax
     288:	85 c0                	test   %eax,%eax
     28a:	74 91                	je     21d <runcmd+0x6d>
      exit();
    exec(ecmd->argv[0], ecmd->argv);
     28c:	8d 53 04             	lea    0x4(%ebx),%edx
     28f:	89 54 24 04          	mov    %edx,0x4(%esp)
     293:	89 04 24             	mov    %eax,(%esp)
     296:	e8 9f 0b 00 00       	call   e3a <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
     29b:	8b 43 04             	mov    0x4(%ebx),%eax
     29e:	c7 44 24 04 af 12 00 	movl   $0x12af,0x4(%esp)
     2a5:	00 
     2a6:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     2ad:	89 44 24 08          	mov    %eax,0x8(%esp)
     2b1:	e8 8a 0c 00 00       	call   f40 <printf>
    break;
     2b6:	e9 62 ff ff ff       	jmp    21d <runcmd+0x6d>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    close(rcmd->fd);
    if(open(rcmd->file, rcmd->mode) < 0){
      printf(2, "open %s failed\n", rcmd->file);
     2bb:	8b 43 08             	mov    0x8(%ebx),%eax
     2be:	c7 44 24 04 bf 12 00 	movl   $0x12bf,0x4(%esp)
     2c5:	00 
     2c6:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     2cd:	89 44 24 08          	mov    %eax,0x8(%esp)
     2d1:	e8 6a 0c 00 00       	call   f40 <printf>
     2d6:	e9 42 ff ff ff       	jmp    21d <runcmd+0x6d>
    break;

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    if(pipe(p) < 0)
      panic("pipe");
     2db:	c7 04 24 cf 12 00 00 	movl   $0x12cf,(%esp)
     2e2:	e8 79 fe ff ff       	call   160 <panic>
      close(p[0]);
      close(p[1]);
      runcmd(pcmd->left);
    }
    if(fork1() == 0){
      close(0);
     2e7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     2ee:	e8 37 0b 00 00       	call   e2a <close>
      dup(p[0]);
     2f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
     2f6:	89 04 24             	mov    %eax,(%esp)
     2f9:	e8 7c 0b 00 00       	call   e7a <dup>
      close(p[0]);
     2fe:	8b 45 f0             	mov    -0x10(%ebp),%eax
     301:	89 04 24             	mov    %eax,(%esp)
     304:	e8 21 0b 00 00       	call   e2a <close>
      close(p[1]);
     309:	8b 45 f4             	mov    -0xc(%ebp),%eax
     30c:	89 04 24             	mov    %eax,(%esp)
     30f:	e8 16 0b 00 00       	call   e2a <close>
      runcmd(pcmd->right);
     314:	8b 43 08             	mov    0x8(%ebx),%eax
     317:	89 04 24             	mov    %eax,(%esp)
     31a:	e8 91 fe ff ff       	call   1b0 <runcmd>
  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    if(pipe(p) < 0)
      panic("pipe");
    if(fork1() == 0){
      close(1);
     31f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     326:	e8 ff 0a 00 00       	call   e2a <close>
      dup(p[1]);
     32b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     32e:	89 04 24             	mov    %eax,(%esp)
     331:	e8 44 0b 00 00       	call   e7a <dup>
      close(p[0]);
     336:	8b 45 f0             	mov    -0x10(%ebp),%eax
     339:	89 04 24             	mov    %eax,(%esp)
     33c:	e8 e9 0a 00 00       	call   e2a <close>
      close(p[1]);
     341:	8b 45 f4             	mov    -0xc(%ebp),%eax
     344:	89 04 24             	mov    %eax,(%esp)
     347:	e8 de 0a 00 00       	call   e2a <close>
      runcmd(pcmd->left);
     34c:	8b 43 04             	mov    0x4(%ebx),%eax
     34f:	89 04 24             	mov    %eax,(%esp)
     352:	e8 59 fe ff ff       	call   1b0 <runcmd>
     357:	89 f6                	mov    %esi,%esi
     359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000360 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     360:	55                   	push   %ebp
     361:	89 e5                	mov    %esp,%ebp
     363:	53                   	push   %ebx
     364:	83 ec 14             	sub    $0x14,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     367:	c7 04 24 54 00 00 00 	movl   $0x54,(%esp)
     36e:	e8 4d 0e 00 00       	call   11c0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     373:	c7 44 24 08 54 00 00 	movl   $0x54,0x8(%esp)
     37a:	00 
     37b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     382:	00 
struct cmd*
execcmd(void)
{
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     383:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     385:	89 04 24             	mov    %eax,(%esp)
     388:	e8 e3 08 00 00       	call   c70 <memset>
  cmd->type = EXEC;
  return (struct cmd*)cmd;
}
     38d:	89 d8                	mov    %ebx,%eax
{
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = EXEC;
     38f:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
     395:	83 c4 14             	add    $0x14,%esp
     398:	5b                   	pop    %ebx
     399:	5d                   	pop    %ebp
     39a:	c3                   	ret    
     39b:	90                   	nop
     39c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000003a0 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     3a0:	55                   	push   %ebp
     3a1:	89 e5                	mov    %esp,%ebp
     3a3:	53                   	push   %ebx
     3a4:	83 ec 14             	sub    $0x14,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3a7:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
     3ae:	e8 0d 0e 00 00       	call   11c0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     3b3:	c7 44 24 08 18 00 00 	movl   $0x18,0x8(%esp)
     3ba:	00 
     3bb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     3c2:	00 
     3c3:	89 04 24             	mov    %eax,(%esp)
struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3c6:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     3c8:	e8 a3 08 00 00       	call   c70 <memset>
  cmd->type = REDIR;
  cmd->cmd = subcmd;
     3cd:	8b 45 08             	mov    0x8(%ebp),%eax
{
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = REDIR;
     3d0:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     3d6:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     3d9:	8b 45 0c             	mov    0xc(%ebp),%eax
     3dc:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     3df:	8b 45 10             	mov    0x10(%ebp),%eax
     3e2:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     3e5:	8b 45 14             	mov    0x14(%ebp),%eax
     3e8:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     3eb:	8b 45 18             	mov    0x18(%ebp),%eax
     3ee:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     3f1:	83 c4 14             	add    $0x14,%esp
     3f4:	89 d8                	mov    %ebx,%eax
     3f6:	5b                   	pop    %ebx
     3f7:	5d                   	pop    %ebp
     3f8:	c3                   	ret    
     3f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000400 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     400:	55                   	push   %ebp
     401:	89 e5                	mov    %esp,%ebp
     403:	53                   	push   %ebx
     404:	83 ec 14             	sub    $0x14,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     407:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     40e:	e8 ad 0d 00 00       	call   11c0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     413:	c7 44 24 08 0c 00 00 	movl   $0xc,0x8(%esp)
     41a:	00 
     41b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     422:	00 
     423:	89 04 24             	mov    %eax,(%esp)
struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     426:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     428:	e8 43 08 00 00       	call   c70 <memset>
  cmd->type = PIPE;
  cmd->left = left;
     42d:	8b 45 08             	mov    0x8(%ebp),%eax
{
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = PIPE;
     430:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     436:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     439:	8b 45 0c             	mov    0xc(%ebp),%eax
     43c:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     43f:	83 c4 14             	add    $0x14,%esp
     442:	89 d8                	mov    %ebx,%eax
     444:	5b                   	pop    %ebx
     445:	5d                   	pop    %ebp
     446:	c3                   	ret    
     447:	89 f6                	mov    %esi,%esi
     449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000450 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     450:	55                   	push   %ebp
     451:	89 e5                	mov    %esp,%ebp
     453:	53                   	push   %ebx
     454:	83 ec 14             	sub    $0x14,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     457:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     45e:	e8 5d 0d 00 00       	call   11c0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     463:	c7 44 24 08 0c 00 00 	movl   $0xc,0x8(%esp)
     46a:	00 
     46b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     472:	00 
     473:	89 04 24             	mov    %eax,(%esp)
struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     476:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     478:	e8 f3 07 00 00       	call   c70 <memset>
  cmd->type = LIST;
  cmd->left = left;
     47d:	8b 45 08             	mov    0x8(%ebp),%eax
{
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = LIST;
     480:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     486:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     489:	8b 45 0c             	mov    0xc(%ebp),%eax
     48c:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     48f:	83 c4 14             	add    $0x14,%esp
     492:	89 d8                	mov    %ebx,%eax
     494:	5b                   	pop    %ebx
     495:	5d                   	pop    %ebp
     496:	c3                   	ret    
     497:	89 f6                	mov    %esi,%esi
     499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004a0 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     4a0:	55                   	push   %ebp
     4a1:	89 e5                	mov    %esp,%ebp
     4a3:	53                   	push   %ebx
     4a4:	83 ec 14             	sub    $0x14,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4a7:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     4ae:	e8 0d 0d 00 00       	call   11c0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     4b3:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
     4ba:	00 
     4bb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     4c2:	00 
     4c3:	89 04 24             	mov    %eax,(%esp)
struct cmd*
backcmd(struct cmd *subcmd)
{
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4c6:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     4c8:	e8 a3 07 00 00       	call   c70 <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
     4cd:	8b 45 08             	mov    0x8(%ebp),%eax
{
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
  memset(cmd, 0, sizeof(*cmd));
  cmd->type = BACK;
     4d0:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     4d6:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     4d9:	83 c4 14             	add    $0x14,%esp
     4dc:	89 d8                	mov    %ebx,%eax
     4de:	5b                   	pop    %ebx
     4df:	5d                   	pop    %ebp
     4e0:	c3                   	ret    
     4e1:	eb 0d                	jmp    4f0 <gettoken>
     4e3:	90                   	nop
     4e4:	90                   	nop
     4e5:	90                   	nop
     4e6:	90                   	nop
     4e7:	90                   	nop
     4e8:	90                   	nop
     4e9:	90                   	nop
     4ea:	90                   	nop
     4eb:	90                   	nop
     4ec:	90                   	nop
     4ed:	90                   	nop
     4ee:	90                   	nop
     4ef:	90                   	nop

000004f0 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     4f0:	55                   	push   %ebp
     4f1:	89 e5                	mov    %esp,%ebp
     4f3:	57                   	push   %edi
     4f4:	56                   	push   %esi
     4f5:	53                   	push   %ebx
     4f6:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int ret;

  s = *ps;
     4f9:	8b 45 08             	mov    0x8(%ebp),%eax
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     4fc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     4ff:	8b 75 10             	mov    0x10(%ebp),%esi
  char *s;
  int ret;

  s = *ps;
     502:	8b 38                	mov    (%eax),%edi
  while(s < es && strchr(whitespace, *s))
     504:	39 df                	cmp    %ebx,%edi
     506:	72 0f                	jb     517 <gettoken+0x27>
     508:	eb 24                	jmp    52e <gettoken+0x3e>
     50a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    s++;
     510:	83 c7 01             	add    $0x1,%edi
{
  char *s;
  int ret;

  s = *ps;
  while(s < es && strchr(whitespace, *s))
     513:	39 df                	cmp    %ebx,%edi
     515:	74 17                	je     52e <gettoken+0x3e>
     517:	0f be 07             	movsbl (%edi),%eax
     51a:	c7 04 24 50 19 00 00 	movl   $0x1950,(%esp)
     521:	89 44 24 04          	mov    %eax,0x4(%esp)
     525:	e8 66 07 00 00       	call   c90 <strchr>
     52a:	85 c0                	test   %eax,%eax
     52c:	75 e2                	jne    510 <gettoken+0x20>
    s++;
  if(q)
     52e:	85 f6                	test   %esi,%esi
     530:	74 02                	je     534 <gettoken+0x44>
    *q = s;
     532:	89 3e                	mov    %edi,(%esi)
  ret = *s;
     534:	0f b6 0f             	movzbl (%edi),%ecx
     537:	0f be f1             	movsbl %cl,%esi
  switch(*s){
     53a:	80 f9 3c             	cmp    $0x3c,%cl
  s = *ps;
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
     53d:	89 f0                	mov    %esi,%eax
  switch(*s){
     53f:	7f 4f                	jg     590 <gettoken+0xa0>
     541:	80 f9 3b             	cmp    $0x3b,%cl
     544:	0f 8c 9e 00 00 00    	jl     5e8 <gettoken+0xf8>
  case '&':
  case '<':
    s++;
    break;
  case '>':
    s++;
     54a:	83 c7 01             	add    $0x1,%edi
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     54d:	8b 45 14             	mov    0x14(%ebp),%eax
     550:	85 c0                	test   %eax,%eax
     552:	74 05                	je     559 <gettoken+0x69>
    *eq = s;
     554:	8b 45 14             	mov    0x14(%ebp),%eax
     557:	89 38                	mov    %edi,(%eax)

  while(s < es && strchr(whitespace, *s))
     559:	39 df                	cmp    %ebx,%edi
     55b:	72 0a                	jb     567 <gettoken+0x77>
     55d:	eb 1f                	jmp    57e <gettoken+0x8e>
     55f:	90                   	nop
    s++;
     560:	83 c7 01             	add    $0x1,%edi
    break;
  }
  if(eq)
    *eq = s;

  while(s < es && strchr(whitespace, *s))
     563:	39 df                	cmp    %ebx,%edi
     565:	74 17                	je     57e <gettoken+0x8e>
     567:	0f be 07             	movsbl (%edi),%eax
     56a:	c7 04 24 50 19 00 00 	movl   $0x1950,(%esp)
     571:	89 44 24 04          	mov    %eax,0x4(%esp)
     575:	e8 16 07 00 00       	call   c90 <strchr>
     57a:	85 c0                	test   %eax,%eax
     57c:	75 e2                	jne    560 <gettoken+0x70>
    s++;
  *ps = s;
     57e:	8b 45 08             	mov    0x8(%ebp),%eax
     581:	89 38                	mov    %edi,(%eax)
  return ret;
}
     583:	83 c4 1c             	add    $0x1c,%esp
     586:	89 f0                	mov    %esi,%eax
     588:	5b                   	pop    %ebx
     589:	5e                   	pop    %esi
     58a:	5f                   	pop    %edi
     58b:	5d                   	pop    %ebp
     58c:	c3                   	ret    
     58d:	8d 76 00             	lea    0x0(%esi),%esi
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
     590:	80 f9 3e             	cmp    $0x3e,%cl
     593:	74 73                	je     608 <gettoken+0x118>
     595:	80 f9 7c             	cmp    $0x7c,%cl
     598:	74 b0                	je     54a <gettoken+0x5a>
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     59a:	39 fb                	cmp    %edi,%ebx
     59c:	77 2b                	ja     5c9 <gettoken+0xd9>
     59e:	66 90                	xchg   %ax,%ax
     5a0:	eb 3b                	jmp    5dd <gettoken+0xed>
     5a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     5a8:	0f be 07             	movsbl (%edi),%eax
     5ab:	c7 04 24 48 19 00 00 	movl   $0x1948,(%esp)
     5b2:	89 44 24 04          	mov    %eax,0x4(%esp)
     5b6:	e8 d5 06 00 00       	call   c90 <strchr>
     5bb:	85 c0                	test   %eax,%eax
     5bd:	75 1e                	jne    5dd <gettoken+0xed>
      s++;
     5bf:	83 c7 01             	add    $0x1,%edi
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     5c2:	39 df                	cmp    %ebx,%edi
     5c4:	74 17                	je     5dd <gettoken+0xed>
     5c6:	0f be 07             	movsbl (%edi),%eax
     5c9:	89 44 24 04          	mov    %eax,0x4(%esp)
     5cd:	c7 04 24 50 19 00 00 	movl   $0x1950,(%esp)
     5d4:	e8 b7 06 00 00       	call   c90 <strchr>
     5d9:	85 c0                	test   %eax,%eax
     5db:	74 cb                	je     5a8 <gettoken+0xb8>
      ret = '+';
      s++;
    }
    break;
  default:
    ret = 'a';
     5dd:	be 61 00 00 00       	mov    $0x61,%esi
     5e2:	e9 66 ff ff ff       	jmp    54d <gettoken+0x5d>
     5e7:	90                   	nop
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
     5e8:	80 f9 29             	cmp    $0x29,%cl
     5eb:	7f ad                	jg     59a <gettoken+0xaa>
     5ed:	80 f9 28             	cmp    $0x28,%cl
     5f0:	0f 8d 54 ff ff ff    	jge    54a <gettoken+0x5a>
     5f6:	84 c9                	test   %cl,%cl
     5f8:	0f 84 4f ff ff ff    	je     54d <gettoken+0x5d>
     5fe:	80 f9 26             	cmp    $0x26,%cl
     601:	75 97                	jne    59a <gettoken+0xaa>
     603:	e9 42 ff ff ff       	jmp    54a <gettoken+0x5a>
  case '<':
    s++;
    break;
  case '>':
    s++;
    if(*s == '>'){
     608:	80 7f 01 3e          	cmpb   $0x3e,0x1(%edi)
     60c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     610:	0f 85 34 ff ff ff    	jne    54a <gettoken+0x5a>
      ret = '+';
      s++;
     616:	83 c7 02             	add    $0x2,%edi
    s++;
    break;
  case '>':
    s++;
    if(*s == '>'){
      ret = '+';
     619:	be 2b 00 00 00       	mov    $0x2b,%esi
     61e:	e9 2a ff ff ff       	jmp    54d <gettoken+0x5d>
     623:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000630 <peek>:
  return ret;
}

int
peek(char **ps, char *es, char *toks)
{
     630:	55                   	push   %ebp
     631:	89 e5                	mov    %esp,%ebp
     633:	57                   	push   %edi
     634:	56                   	push   %esi
     635:	53                   	push   %ebx
     636:	83 ec 1c             	sub    $0x1c,%esp
     639:	8b 7d 08             	mov    0x8(%ebp),%edi
     63c:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
     63f:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     641:	39 f3                	cmp    %esi,%ebx
     643:	72 0a                	jb     64f <peek+0x1f>
     645:	eb 1f                	jmp    666 <peek+0x36>
     647:	90                   	nop
    s++;
     648:	83 c3 01             	add    $0x1,%ebx
peek(char **ps, char *es, char *toks)
{
  char *s;

  s = *ps;
  while(s < es && strchr(whitespace, *s))
     64b:	39 f3                	cmp    %esi,%ebx
     64d:	74 17                	je     666 <peek+0x36>
     64f:	0f be 03             	movsbl (%ebx),%eax
     652:	c7 04 24 50 19 00 00 	movl   $0x1950,(%esp)
     659:	89 44 24 04          	mov    %eax,0x4(%esp)
     65d:	e8 2e 06 00 00       	call   c90 <strchr>
     662:	85 c0                	test   %eax,%eax
     664:	75 e2                	jne    648 <peek+0x18>
    s++;
  *ps = s;
     666:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     668:	0f be 13             	movsbl (%ebx),%edx
     66b:	31 c0                	xor    %eax,%eax
     66d:	84 d2                	test   %dl,%dl
     66f:	74 17                	je     688 <peek+0x58>
     671:	8b 45 10             	mov    0x10(%ebp),%eax
     674:	89 54 24 04          	mov    %edx,0x4(%esp)
     678:	89 04 24             	mov    %eax,(%esp)
     67b:	e8 10 06 00 00       	call   c90 <strchr>
     680:	85 c0                	test   %eax,%eax
     682:	0f 95 c0             	setne  %al
     685:	0f b6 c0             	movzbl %al,%eax
}
     688:	83 c4 1c             	add    $0x1c,%esp
     68b:	5b                   	pop    %ebx
     68c:	5e                   	pop    %esi
     68d:	5f                   	pop    %edi
     68e:	5d                   	pop    %ebp
     68f:	c3                   	ret    

00000690 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     690:	55                   	push   %ebp
     691:	89 e5                	mov    %esp,%ebp
     693:	57                   	push   %edi
     694:	56                   	push   %esi
     695:	53                   	push   %ebx
     696:	83 ec 3c             	sub    $0x3c,%esp
     699:	8b 75 0c             	mov    0xc(%ebp),%esi
     69c:	8b 5d 10             	mov    0x10(%ebp),%ebx
     69f:	90                   	nop
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     6a0:	c7 44 24 08 f1 12 00 	movl   $0x12f1,0x8(%esp)
     6a7:	00 
     6a8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     6ac:	89 34 24             	mov    %esi,(%esp)
     6af:	e8 7c ff ff ff       	call   630 <peek>
     6b4:	85 c0                	test   %eax,%eax
     6b6:	0f 84 9c 00 00 00    	je     758 <parseredirs+0xc8>
    tok = gettoken(ps, es, 0, 0);
     6bc:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     6c3:	00 
     6c4:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     6cb:	00 
     6cc:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     6d0:	89 34 24             	mov    %esi,(%esp)
     6d3:	e8 18 fe ff ff       	call   4f0 <gettoken>
    if(gettoken(ps, es, &q, &eq) != 'a')
     6d8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     6dc:	89 34 24             	mov    %esi,(%esp)
{
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
    tok = gettoken(ps, es, 0, 0);
     6df:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
     6e1:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     6e4:	89 44 24 0c          	mov    %eax,0xc(%esp)
     6e8:	8d 45 e0             	lea    -0x20(%ebp),%eax
     6eb:	89 44 24 08          	mov    %eax,0x8(%esp)
     6ef:	e8 fc fd ff ff       	call   4f0 <gettoken>
     6f4:	83 f8 61             	cmp    $0x61,%eax
     6f7:	75 6a                	jne    763 <parseredirs+0xd3>
      panic("missing file for redirection");
    switch(tok){
     6f9:	83 ff 3c             	cmp    $0x3c,%edi
     6fc:	74 42                	je     740 <parseredirs+0xb0>
     6fe:	83 ff 3e             	cmp    $0x3e,%edi
     701:	74 05                	je     708 <parseredirs+0x78>
     703:	83 ff 2b             	cmp    $0x2b,%edi
     706:	75 98                	jne    6a0 <parseredirs+0x10>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     708:	c7 44 24 10 01 00 00 	movl   $0x1,0x10(%esp)
     70f:	00 
     710:	c7 44 24 0c 01 02 00 	movl   $0x201,0xc(%esp)
     717:	00 
     718:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     71b:	89 44 24 08          	mov    %eax,0x8(%esp)
     71f:	8b 45 e0             	mov    -0x20(%ebp),%eax
     722:	89 44 24 04          	mov    %eax,0x4(%esp)
     726:	8b 45 08             	mov    0x8(%ebp),%eax
     729:	89 04 24             	mov    %eax,(%esp)
     72c:	e8 6f fc ff ff       	call   3a0 <redircmd>
     731:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     734:	e9 67 ff ff ff       	jmp    6a0 <parseredirs+0x10>
     739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
      panic("missing file for redirection");
    switch(tok){
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     740:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
     747:	00 
     748:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     74f:	00 
     750:	eb c6                	jmp    718 <parseredirs+0x88>
     752:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    }
  }
  return cmd;
}
     758:	8b 45 08             	mov    0x8(%ebp),%eax
     75b:	83 c4 3c             	add    $0x3c,%esp
     75e:	5b                   	pop    %ebx
     75f:	5e                   	pop    %esi
     760:	5f                   	pop    %edi
     761:	5d                   	pop    %ebp
     762:	c3                   	ret    
  char *q, *eq;

  while(peek(ps, es, "<>")){
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
      panic("missing file for redirection");
     763:	c7 04 24 d4 12 00 00 	movl   $0x12d4,(%esp)
     76a:	e8 f1 f9 ff ff       	call   160 <panic>
     76f:	90                   	nop

00000770 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     770:	55                   	push   %ebp
     771:	89 e5                	mov    %esp,%ebp
     773:	57                   	push   %edi
     774:	56                   	push   %esi
     775:	53                   	push   %ebx
     776:	83 ec 3c             	sub    $0x3c,%esp
     779:	8b 75 08             	mov    0x8(%ebp),%esi
     77c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     77f:	c7 44 24 08 f4 12 00 	movl   $0x12f4,0x8(%esp)
     786:	00 
     787:	89 34 24             	mov    %esi,(%esp)
     78a:	89 7c 24 04          	mov    %edi,0x4(%esp)
     78e:	e8 9d fe ff ff       	call   630 <peek>
     793:	85 c0                	test   %eax,%eax
     795:	0f 85 a5 00 00 00    	jne    840 <parseexec+0xd0>
    return parseblock(ps, es);

  ret = execcmd();
     79b:	e8 c0 fb ff ff       	call   360 <execcmd>
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     7a0:	89 7c 24 08          	mov    %edi,0x8(%esp)
     7a4:	89 74 24 04          	mov    %esi,0x4(%esp)
     7a8:	89 04 24             	mov    %eax,(%esp)
  struct cmd *ret;

  if(peek(ps, es, "("))
    return parseblock(ps, es);

  ret = execcmd();
     7ab:	89 45 cc             	mov    %eax,-0x34(%ebp)
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     7ae:	e8 dd fe ff ff       	call   690 <parseredirs>
     7b3:	8b 5d cc             	mov    -0x34(%ebp),%ebx
    return parseblock(ps, es);

  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
     7b6:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  ret = parseredirs(ret, ps, es);
     7bd:	89 45 d0             	mov    %eax,-0x30(%ebp)
  while(!peek(ps, es, "|)&;")){
     7c0:	eb 1c                	jmp    7de <parseexec+0x6e>
     7c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     7c8:	8b 45 d0             	mov    -0x30(%ebp),%eax
     7cb:	89 7c 24 08          	mov    %edi,0x8(%esp)
     7cf:	89 74 24 04          	mov    %esi,0x4(%esp)
     7d3:	89 04 24             	mov    %eax,(%esp)
     7d6:	e8 b5 fe ff ff       	call   690 <parseredirs>
     7db:	89 45 d0             	mov    %eax,-0x30(%ebp)
  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
     7de:	c7 44 24 08 0b 13 00 	movl   $0x130b,0x8(%esp)
     7e5:	00 
     7e6:	89 7c 24 04          	mov    %edi,0x4(%esp)
     7ea:	89 34 24             	mov    %esi,(%esp)
     7ed:	e8 3e fe ff ff       	call   630 <peek>
     7f2:	85 c0                	test   %eax,%eax
     7f4:	75 6a                	jne    860 <parseexec+0xf0>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     7f6:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     7f9:	8d 55 e0             	lea    -0x20(%ebp),%edx
     7fc:	89 44 24 0c          	mov    %eax,0xc(%esp)
     800:	89 54 24 08          	mov    %edx,0x8(%esp)
     804:	89 7c 24 04          	mov    %edi,0x4(%esp)
     808:	89 34 24             	mov    %esi,(%esp)
     80b:	e8 e0 fc ff ff       	call   4f0 <gettoken>
     810:	85 c0                	test   %eax,%eax
     812:	74 4c                	je     860 <parseexec+0xf0>
      break;
    if(tok != 'a')
     814:	83 f8 61             	cmp    $0x61,%eax
     817:	75 68                	jne    881 <parseexec+0x111>
      panic("syntax");
    cmd->argv[argc] = q;
     819:	8b 45 e0             	mov    -0x20(%ebp),%eax
    cmd->eargv[argc] = eq;
    argc++;
     81c:	83 45 d4 01          	addl   $0x1,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
    if(tok != 'a')
      panic("syntax");
    cmd->argv[argc] = q;
     820:	89 43 04             	mov    %eax,0x4(%ebx)
    cmd->eargv[argc] = eq;
     823:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     826:	89 43 2c             	mov    %eax,0x2c(%ebx)
     829:	83 c3 04             	add    $0x4,%ebx
    argc++;
    if(argc >= MAXARGS)
     82c:	83 7d d4 0a          	cmpl   $0xa,-0x2c(%ebp)
     830:	75 96                	jne    7c8 <parseexec+0x58>
      panic("too many args");
     832:	c7 04 24 fd 12 00 00 	movl   $0x12fd,(%esp)
     839:	e8 22 f9 ff ff       	call   160 <panic>
     83e:	66 90                	xchg   %ax,%ax
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
    return parseblock(ps, es);
     840:	89 7c 24 04          	mov    %edi,0x4(%esp)
     844:	89 34 24             	mov    %esi,(%esp)
     847:	e8 94 01 00 00       	call   9e0 <parseblock>
     84c:	89 45 d0             	mov    %eax,-0x30(%ebp)
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     84f:	8b 45 d0             	mov    -0x30(%ebp),%eax
     852:	83 c4 3c             	add    $0x3c,%esp
     855:	5b                   	pop    %ebx
     856:	5e                   	pop    %esi
     857:	5f                   	pop    %edi
     858:	5d                   	pop    %ebp
     859:	c3                   	ret    
     85a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
     860:	8b 45 cc             	mov    -0x34(%ebp),%eax
     863:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     866:	c7 44 90 04 00 00 00 	movl   $0x0,0x4(%eax,%edx,4)
     86d:	00 
  cmd->eargv[argc] = 0;
     86e:	c7 44 90 2c 00 00 00 	movl   $0x0,0x2c(%eax,%edx,4)
     875:	00 
  return ret;
}
     876:	8b 45 d0             	mov    -0x30(%ebp),%eax
     879:	83 c4 3c             	add    $0x3c,%esp
     87c:	5b                   	pop    %ebx
     87d:	5e                   	pop    %esi
     87e:	5f                   	pop    %edi
     87f:	5d                   	pop    %ebp
     880:	c3                   	ret    
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
    if(tok != 'a')
      panic("syntax");
     881:	c7 04 24 f6 12 00 00 	movl   $0x12f6,(%esp)
     888:	e8 d3 f8 ff ff       	call   160 <panic>
     88d:	8d 76 00             	lea    0x0(%esi),%esi

00000890 <parsepipe>:
  return cmd;
}

struct cmd*
parsepipe(char **ps, char *es)
{
     890:	55                   	push   %ebp
     891:	89 e5                	mov    %esp,%ebp
     893:	83 ec 28             	sub    $0x28,%esp
     896:	89 5d f4             	mov    %ebx,-0xc(%ebp)
     899:	8b 5d 08             	mov    0x8(%ebp),%ebx
     89c:	89 75 f8             	mov    %esi,-0x8(%ebp)
     89f:	8b 75 0c             	mov    0xc(%ebp),%esi
     8a2:	89 7d fc             	mov    %edi,-0x4(%ebp)
  struct cmd *cmd;

  cmd = parseexec(ps, es);
     8a5:	89 1c 24             	mov    %ebx,(%esp)
     8a8:	89 74 24 04          	mov    %esi,0x4(%esp)
     8ac:	e8 bf fe ff ff       	call   770 <parseexec>
  if(peek(ps, es, "|")){
     8b1:	c7 44 24 08 10 13 00 	movl   $0x1310,0x8(%esp)
     8b8:	00 
     8b9:	89 74 24 04          	mov    %esi,0x4(%esp)
     8bd:	89 1c 24             	mov    %ebx,(%esp)
struct cmd*
parsepipe(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parseexec(ps, es);
     8c0:	89 c7                	mov    %eax,%edi
  if(peek(ps, es, "|")){
     8c2:	e8 69 fd ff ff       	call   630 <peek>
     8c7:	85 c0                	test   %eax,%eax
     8c9:	75 15                	jne    8e0 <parsepipe+0x50>
    gettoken(ps, es, 0, 0);
    cmd = pipecmd(cmd, parsepipe(ps, es));
  }
  return cmd;
}
     8cb:	89 f8                	mov    %edi,%eax
     8cd:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     8d0:	8b 75 f8             	mov    -0x8(%ebp),%esi
     8d3:	8b 7d fc             	mov    -0x4(%ebp),%edi
     8d6:	89 ec                	mov    %ebp,%esp
     8d8:	5d                   	pop    %ebp
     8d9:	c3                   	ret    
     8da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  struct cmd *cmd;

  cmd = parseexec(ps, es);
  if(peek(ps, es, "|")){
    gettoken(ps, es, 0, 0);
     8e0:	89 74 24 04          	mov    %esi,0x4(%esp)
     8e4:	89 1c 24             	mov    %ebx,(%esp)
     8e7:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     8ee:	00 
     8ef:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     8f6:	00 
     8f7:	e8 f4 fb ff ff       	call   4f0 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     8fc:	89 74 24 04          	mov    %esi,0x4(%esp)
     900:	89 1c 24             	mov    %ebx,(%esp)
     903:	e8 88 ff ff ff       	call   890 <parsepipe>
  }
  return cmd;
}
     908:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  struct cmd *cmd;

  cmd = parseexec(ps, es);
  if(peek(ps, es, "|")){
    gettoken(ps, es, 0, 0);
    cmd = pipecmd(cmd, parsepipe(ps, es));
     90b:	89 7d 08             	mov    %edi,0x8(%ebp)
  }
  return cmd;
}
     90e:	8b 75 f8             	mov    -0x8(%ebp),%esi
     911:	8b 7d fc             	mov    -0x4(%ebp),%edi
  struct cmd *cmd;

  cmd = parseexec(ps, es);
  if(peek(ps, es, "|")){
    gettoken(ps, es, 0, 0);
    cmd = pipecmd(cmd, parsepipe(ps, es));
     914:	89 45 0c             	mov    %eax,0xc(%ebp)
  }
  return cmd;
}
     917:	89 ec                	mov    %ebp,%esp
     919:	5d                   	pop    %ebp
  struct cmd *cmd;

  cmd = parseexec(ps, es);
  if(peek(ps, es, "|")){
    gettoken(ps, es, 0, 0);
    cmd = pipecmd(cmd, parsepipe(ps, es));
     91a:	e9 e1 fa ff ff       	jmp    400 <pipecmd>
     91f:	90                   	nop

00000920 <parseline>:
  return cmd;
}

struct cmd*
parseline(char **ps, char *es)
{
     920:	55                   	push   %ebp
     921:	89 e5                	mov    %esp,%ebp
     923:	57                   	push   %edi
     924:	56                   	push   %esi
     925:	53                   	push   %ebx
     926:	83 ec 1c             	sub    $0x1c,%esp
     929:	8b 5d 08             	mov    0x8(%ebp),%ebx
     92c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
     92f:	89 1c 24             	mov    %ebx,(%esp)
     932:	89 74 24 04          	mov    %esi,0x4(%esp)
     936:	e8 55 ff ff ff       	call   890 <parsepipe>
     93b:	89 c7                	mov    %eax,%edi
  while(peek(ps, es, "&")){
     93d:	eb 27                	jmp    966 <parseline+0x46>
     93f:	90                   	nop
    gettoken(ps, es, 0, 0);
     940:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     947:	00 
     948:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     94f:	00 
     950:	89 74 24 04          	mov    %esi,0x4(%esp)
     954:	89 1c 24             	mov    %ebx,(%esp)
     957:	e8 94 fb ff ff       	call   4f0 <gettoken>
    cmd = backcmd(cmd);
     95c:	89 3c 24             	mov    %edi,(%esp)
     95f:	e8 3c fb ff ff       	call   4a0 <backcmd>
     964:	89 c7                	mov    %eax,%edi
parseline(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
  while(peek(ps, es, "&")){
     966:	c7 44 24 08 12 13 00 	movl   $0x1312,0x8(%esp)
     96d:	00 
     96e:	89 74 24 04          	mov    %esi,0x4(%esp)
     972:	89 1c 24             	mov    %ebx,(%esp)
     975:	e8 b6 fc ff ff       	call   630 <peek>
     97a:	85 c0                	test   %eax,%eax
     97c:	75 c2                	jne    940 <parseline+0x20>
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
     97e:	c7 44 24 08 0e 13 00 	movl   $0x130e,0x8(%esp)
     985:	00 
     986:	89 74 24 04          	mov    %esi,0x4(%esp)
     98a:	89 1c 24             	mov    %ebx,(%esp)
     98d:	e8 9e fc ff ff       	call   630 <peek>
     992:	85 c0                	test   %eax,%eax
     994:	75 0a                	jne    9a0 <parseline+0x80>
    gettoken(ps, es, 0, 0);
    cmd = listcmd(cmd, parseline(ps, es));
  }
  return cmd;
}
     996:	83 c4 1c             	add    $0x1c,%esp
     999:	89 f8                	mov    %edi,%eax
     99b:	5b                   	pop    %ebx
     99c:	5e                   	pop    %esi
     99d:	5f                   	pop    %edi
     99e:	5d                   	pop    %ebp
     99f:	c3                   	ret    
  while(peek(ps, es, "&")){
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
    gettoken(ps, es, 0, 0);
     9a0:	89 74 24 04          	mov    %esi,0x4(%esp)
     9a4:	89 1c 24             	mov    %ebx,(%esp)
     9a7:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     9ae:	00 
     9af:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     9b6:	00 
     9b7:	e8 34 fb ff ff       	call   4f0 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     9bc:	89 74 24 04          	mov    %esi,0x4(%esp)
     9c0:	89 1c 24             	mov    %ebx,(%esp)
     9c3:	e8 58 ff ff ff       	call   920 <parseline>
     9c8:	89 7d 08             	mov    %edi,0x8(%ebp)
     9cb:	89 45 0c             	mov    %eax,0xc(%ebp)
  }
  return cmd;
}
     9ce:	83 c4 1c             	add    $0x1c,%esp
     9d1:	5b                   	pop    %ebx
     9d2:	5e                   	pop    %esi
     9d3:	5f                   	pop    %edi
     9d4:	5d                   	pop    %ebp
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
    gettoken(ps, es, 0, 0);
    cmd = listcmd(cmd, parseline(ps, es));
     9d5:	e9 76 fa ff ff       	jmp    450 <listcmd>
     9da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000009e0 <parseblock>:
  return cmd;
}

struct cmd*
parseblock(char **ps, char *es)
{
     9e0:	55                   	push   %ebp
     9e1:	89 e5                	mov    %esp,%ebp
     9e3:	83 ec 28             	sub    $0x28,%esp
     9e6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
     9e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
     9ec:	89 75 f8             	mov    %esi,-0x8(%ebp)
     9ef:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct cmd *cmd;

  if(!peek(ps, es, "("))
     9f2:	c7 44 24 08 f4 12 00 	movl   $0x12f4,0x8(%esp)
     9f9:	00 
  return cmd;
}

struct cmd*
parseblock(char **ps, char *es)
{
     9fa:	89 7d fc             	mov    %edi,-0x4(%ebp)
  struct cmd *cmd;

  if(!peek(ps, es, "("))
     9fd:	89 1c 24             	mov    %ebx,(%esp)
     a00:	89 74 24 04          	mov    %esi,0x4(%esp)
     a04:	e8 27 fc ff ff       	call   630 <peek>
     a09:	85 c0                	test   %eax,%eax
     a0b:	74 7b                	je     a88 <parseblock+0xa8>
    panic("parseblock");
  gettoken(ps, es, 0, 0);
     a0d:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     a14:	00 
     a15:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     a1c:	00 
     a1d:	89 74 24 04          	mov    %esi,0x4(%esp)
     a21:	89 1c 24             	mov    %ebx,(%esp)
     a24:	e8 c7 fa ff ff       	call   4f0 <gettoken>
  cmd = parseline(ps, es);
     a29:	89 74 24 04          	mov    %esi,0x4(%esp)
     a2d:	89 1c 24             	mov    %ebx,(%esp)
     a30:	e8 eb fe ff ff       	call   920 <parseline>
  if(!peek(ps, es, ")"))
     a35:	c7 44 24 08 30 13 00 	movl   $0x1330,0x8(%esp)
     a3c:	00 
     a3d:	89 74 24 04          	mov    %esi,0x4(%esp)
     a41:	89 1c 24             	mov    %ebx,(%esp)
  struct cmd *cmd;

  if(!peek(ps, es, "("))
    panic("parseblock");
  gettoken(ps, es, 0, 0);
  cmd = parseline(ps, es);
     a44:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     a46:	e8 e5 fb ff ff       	call   630 <peek>
     a4b:	85 c0                	test   %eax,%eax
     a4d:	74 45                	je     a94 <parseblock+0xb4>
    panic("syntax - missing )");
  gettoken(ps, es, 0, 0);
     a4f:	89 74 24 04          	mov    %esi,0x4(%esp)
     a53:	89 1c 24             	mov    %ebx,(%esp)
     a56:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     a5d:	00 
     a5e:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     a65:	00 
     a66:	e8 85 fa ff ff       	call   4f0 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     a6b:	89 74 24 08          	mov    %esi,0x8(%esp)
     a6f:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     a73:	89 3c 24             	mov    %edi,(%esp)
     a76:	e8 15 fc ff ff       	call   690 <parseredirs>
  return cmd;
}
     a7b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
     a7e:	8b 75 f8             	mov    -0x8(%ebp),%esi
     a81:	8b 7d fc             	mov    -0x4(%ebp),%edi
     a84:	89 ec                	mov    %ebp,%esp
     a86:	5d                   	pop    %ebp
     a87:	c3                   	ret    
parseblock(char **ps, char *es)
{
  struct cmd *cmd;

  if(!peek(ps, es, "("))
    panic("parseblock");
     a88:	c7 04 24 14 13 00 00 	movl   $0x1314,(%esp)
     a8f:	e8 cc f6 ff ff       	call   160 <panic>
  gettoken(ps, es, 0, 0);
  cmd = parseline(ps, es);
  if(!peek(ps, es, ")"))
    panic("syntax - missing )");
     a94:	c7 04 24 1f 13 00 00 	movl   $0x131f,(%esp)
     a9b:	e8 c0 f6 ff ff       	call   160 <panic>

00000aa0 <nulterminate>:
}

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     aa0:	55                   	push   %ebp
     aa1:	89 e5                	mov    %esp,%ebp
     aa3:	53                   	push   %ebx
     aa4:	83 ec 14             	sub    $0x14,%esp
     aa7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     aaa:	85 db                	test   %ebx,%ebx
     aac:	74 05                	je     ab3 <nulterminate+0x13>
    return 0;

  switch(cmd->type){
     aae:	83 3b 05             	cmpl   $0x5,(%ebx)
     ab1:	76 0d                	jbe    ac0 <nulterminate+0x20>
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     ab3:	83 c4 14             	add    $0x14,%esp
     ab6:	89 d8                	mov    %ebx,%eax
     ab8:	5b                   	pop    %ebx
     ab9:	5d                   	pop    %ebp
     aba:	c3                   	ret    
     abb:	90                   	nop
     abc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  struct redircmd *rcmd;

  if(cmd == 0)
    return 0;

  switch(cmd->type){
     ac0:	8b 03                	mov    (%ebx),%eax
     ac2:	ff 24 85 70 13 00 00 	jmp    *0x1370(,%eax,4)
     ac9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    nulterminate(pcmd->right);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
     ad0:	8b 43 04             	mov    0x4(%ebx),%eax
     ad3:	89 04 24             	mov    %eax,(%esp)
     ad6:	e8 c5 ff ff ff       	call   aa0 <nulterminate>
    nulterminate(lcmd->right);
     adb:	8b 43 08             	mov    0x8(%ebx),%eax
     ade:	89 04 24             	mov    %eax,(%esp)
     ae1:	e8 ba ff ff ff       	call   aa0 <nulterminate>
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     ae6:	83 c4 14             	add    $0x14,%esp
     ae9:	89 d8                	mov    %ebx,%eax
     aeb:	5b                   	pop    %ebx
     aec:	5d                   	pop    %ebp
     aed:	c3                   	ret    
     aee:	66 90                	xchg   %ax,%ax
    nulterminate(lcmd->right);
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
     af0:	8b 43 04             	mov    0x4(%ebx),%eax
     af3:	89 04 24             	mov    %eax,(%esp)
     af6:	e8 a5 ff ff ff       	call   aa0 <nulterminate>
    break;
  }
  return cmd;
}
     afb:	83 c4 14             	add    $0x14,%esp
     afe:	89 d8                	mov    %ebx,%eax
     b00:	5b                   	pop    %ebx
     b01:	5d                   	pop    %ebp
     b02:	c3                   	ret    
     b03:	90                   	nop
     b04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      *ecmd->eargv[i] = 0;
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
     b08:	8b 43 04             	mov    0x4(%ebx),%eax
     b0b:	89 04 24             	mov    %eax,(%esp)
     b0e:	e8 8d ff ff ff       	call   aa0 <nulterminate>
    *rcmd->efile = 0;
     b13:	8b 43 0c             	mov    0xc(%ebx),%eax
     b16:	c6 00 00             	movb   $0x0,(%eax)
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     b19:	83 c4 14             	add    $0x14,%esp
     b1c:	89 d8                	mov    %ebx,%eax
     b1e:	5b                   	pop    %ebx
     b1f:	5d                   	pop    %ebp
     b20:	c3                   	ret    
     b21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return 0;

  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     b28:	8b 4b 04             	mov    0x4(%ebx),%ecx
     b2b:	89 da                	mov    %ebx,%edx
     b2d:	85 c9                	test   %ecx,%ecx
     b2f:	74 82                	je     ab3 <nulterminate+0x13>
     b31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *ecmd->eargv[i] = 0;
     b38:	8b 42 2c             	mov    0x2c(%edx),%eax
     b3b:	83 c2 04             	add    $0x4,%edx
     b3e:	c6 00 00             	movb   $0x0,(%eax)
    return 0;

  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     b41:	8b 42 04             	mov    0x4(%edx),%eax
     b44:	85 c0                	test   %eax,%eax
     b46:	75 f0                	jne    b38 <nulterminate+0x98>
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     b48:	83 c4 14             	add    $0x14,%esp
     b4b:	89 d8                	mov    %ebx,%eax
     b4d:	5b                   	pop    %ebx
     b4e:	5d                   	pop    %ebp
     b4f:	c3                   	ret    

00000b50 <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
     b50:	55                   	push   %ebp
     b51:	89 e5                	mov    %esp,%ebp
     b53:	56                   	push   %esi
     b54:	53                   	push   %ebx
     b55:	83 ec 10             	sub    $0x10,%esp
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
     b58:	8b 5d 08             	mov    0x8(%ebp),%ebx
     b5b:	89 1c 24             	mov    %ebx,(%esp)
     b5e:	e8 dd 00 00 00       	call   c40 <strlen>
     b63:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     b65:	8d 45 08             	lea    0x8(%ebp),%eax
     b68:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     b6c:	89 04 24             	mov    %eax,(%esp)
     b6f:	e8 ac fd ff ff       	call   920 <parseline>
  peek(&s, es, "");
     b74:	c7 44 24 08 be 12 00 	movl   $0x12be,0x8(%esp)
     b7b:	00 
     b7c:	89 5c 24 04          	mov    %ebx,0x4(%esp)
{
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
  cmd = parseline(&s, es);
     b80:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     b82:	8d 45 08             	lea    0x8(%ebp),%eax
     b85:	89 04 24             	mov    %eax,(%esp)
     b88:	e8 a3 fa ff ff       	call   630 <peek>
  if(s != es){
     b8d:	8b 45 08             	mov    0x8(%ebp),%eax
     b90:	39 d8                	cmp    %ebx,%eax
     b92:	75 11                	jne    ba5 <parsecmd+0x55>
    printf(2, "leftovers: %s\n", s);
    panic("syntax");
  }
  nulterminate(cmd);
     b94:	89 34 24             	mov    %esi,(%esp)
     b97:	e8 04 ff ff ff       	call   aa0 <nulterminate>
  return cmd;
}
     b9c:	83 c4 10             	add    $0x10,%esp
     b9f:	89 f0                	mov    %esi,%eax
     ba1:	5b                   	pop    %ebx
     ba2:	5e                   	pop    %esi
     ba3:	5d                   	pop    %ebp
     ba4:	c3                   	ret    

  es = s + strlen(s);
  cmd = parseline(&s, es);
  peek(&s, es, "");
  if(s != es){
    printf(2, "leftovers: %s\n", s);
     ba5:	89 44 24 08          	mov    %eax,0x8(%esp)
     ba9:	c7 44 24 04 32 13 00 	movl   $0x1332,0x4(%esp)
     bb0:	00 
     bb1:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     bb8:	e8 83 03 00 00       	call   f40 <printf>
    panic("syntax");
     bbd:	c7 04 24 f6 12 00 00 	movl   $0x12f6,(%esp)
     bc4:	e8 97 f5 ff ff       	call   160 <panic>
     bc9:	66 90                	xchg   %ax,%ax
     bcb:	66 90                	xchg   %ax,%ax
     bcd:	66 90                	xchg   %ax,%ax
     bcf:	90                   	nop

00000bd0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     bd0:	55                   	push   %ebp
     bd1:	89 e5                	mov    %esp,%ebp
     bd3:	8b 45 08             	mov    0x8(%ebp),%eax
     bd6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     bd9:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     bda:	89 c2                	mov    %eax,%edx
     bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     be0:	0f b6 19             	movzbl (%ecx),%ebx
     be3:	83 c1 01             	add    $0x1,%ecx
     be6:	88 1a                	mov    %bl,(%edx)
     be8:	83 c2 01             	add    $0x1,%edx
     beb:	84 db                	test   %bl,%bl
     bed:	75 f1                	jne    be0 <strcpy+0x10>
    ;
  return os;
}
     bef:	5b                   	pop    %ebx
     bf0:	5d                   	pop    %ebp
     bf1:	c3                   	ret    
     bf2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c00 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     c00:	55                   	push   %ebp
     c01:	89 e5                	mov    %esp,%ebp
     c03:	8b 55 08             	mov    0x8(%ebp),%edx
     c06:	56                   	push   %esi
     c07:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     c0a:	53                   	push   %ebx
  while(*p && *p == *q)
     c0b:	0f b6 02             	movzbl (%edx),%eax
     c0e:	0f b6 19             	movzbl (%ecx),%ebx
     c11:	84 c0                	test   %al,%al
     c13:	75 16                	jne    c2b <strcmp+0x2b>
     c15:	eb 21                	jmp    c38 <strcmp+0x38>
     c17:	90                   	nop
    p++, q++;
     c18:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     c1b:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
     c1f:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
     c22:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     c25:	84 c0                	test   %al,%al
     c27:	74 0f                	je     c38 <strcmp+0x38>
    p++, q++;
     c29:	89 f1                	mov    %esi,%ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     c2b:	38 d8                	cmp    %bl,%al
     c2d:	74 e9                	je     c18 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
     c2f:	29 d8                	sub    %ebx,%eax
}
     c31:	5b                   	pop    %ebx
     c32:	5e                   	pop    %esi
     c33:	5d                   	pop    %ebp
     c34:	c3                   	ret    
     c35:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     c38:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
     c3a:	29 d8                	sub    %ebx,%eax
}
     c3c:	5b                   	pop    %ebx
     c3d:	5e                   	pop    %esi
     c3e:	5d                   	pop    %ebp
     c3f:	c3                   	ret    

00000c40 <strlen>:

uint
strlen(char *s)
{
     c40:	55                   	push   %ebp
     c41:	89 e5                	mov    %esp,%ebp
     c43:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     c46:	80 39 00             	cmpb   $0x0,(%ecx)
     c49:	74 12                	je     c5d <strlen+0x1d>
     c4b:	31 d2                	xor    %edx,%edx
     c4d:	8d 76 00             	lea    0x0(%esi),%esi
     c50:	83 c2 01             	add    $0x1,%edx
     c53:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     c57:	89 d0                	mov    %edx,%eax
     c59:	75 f5                	jne    c50 <strlen+0x10>
    ;
  return n;
}
     c5b:	5d                   	pop    %ebp
     c5c:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
     c5d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
     c5f:	5d                   	pop    %ebp
     c60:	c3                   	ret    
     c61:	eb 0d                	jmp    c70 <memset>
     c63:	90                   	nop
     c64:	90                   	nop
     c65:	90                   	nop
     c66:	90                   	nop
     c67:	90                   	nop
     c68:	90                   	nop
     c69:	90                   	nop
     c6a:	90                   	nop
     c6b:	90                   	nop
     c6c:	90                   	nop
     c6d:	90                   	nop
     c6e:	90                   	nop
     c6f:	90                   	nop

00000c70 <memset>:

void*
memset(void *dst, int c, uint n)
{
     c70:	55                   	push   %ebp
     c71:	89 e5                	mov    %esp,%ebp
     c73:	8b 55 08             	mov    0x8(%ebp),%edx
     c76:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     c77:	8b 4d 10             	mov    0x10(%ebp),%ecx
     c7a:	8b 45 0c             	mov    0xc(%ebp),%eax
     c7d:	89 d7                	mov    %edx,%edi
     c7f:	fc                   	cld    
     c80:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     c82:	89 d0                	mov    %edx,%eax
     c84:	5f                   	pop    %edi
     c85:	5d                   	pop    %ebp
     c86:	c3                   	ret    
     c87:	89 f6                	mov    %esi,%esi
     c89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c90 <strchr>:

char*
strchr(const char *s, char c)
{
     c90:	55                   	push   %ebp
     c91:	89 e5                	mov    %esp,%ebp
     c93:	8b 45 08             	mov    0x8(%ebp),%eax
     c96:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
     c9a:	0f b6 10             	movzbl (%eax),%edx
     c9d:	84 d2                	test   %dl,%dl
     c9f:	75 11                	jne    cb2 <strchr+0x22>
     ca1:	eb 15                	jmp    cb8 <strchr+0x28>
     ca3:	90                   	nop
     ca4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     ca8:	83 c0 01             	add    $0x1,%eax
     cab:	0f b6 10             	movzbl (%eax),%edx
     cae:	84 d2                	test   %dl,%dl
     cb0:	74 06                	je     cb8 <strchr+0x28>
    if(*s == c)
     cb2:	38 ca                	cmp    %cl,%dl
     cb4:	75 f2                	jne    ca8 <strchr+0x18>
      return (char*)s;
  return 0;
}
     cb6:	5d                   	pop    %ebp
     cb7:	c3                   	ret    
strchr(const char *s, char c)
{
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
     cb8:	31 c0                	xor    %eax,%eax
}
     cba:	5d                   	pop    %ebp
     cbb:	90                   	nop
     cbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     cc0:	c3                   	ret    
     cc1:	eb 0d                	jmp    cd0 <gets>
     cc3:	90                   	nop
     cc4:	90                   	nop
     cc5:	90                   	nop
     cc6:	90                   	nop
     cc7:	90                   	nop
     cc8:	90                   	nop
     cc9:	90                   	nop
     cca:	90                   	nop
     ccb:	90                   	nop
     ccc:	90                   	nop
     ccd:	90                   	nop
     cce:	90                   	nop
     ccf:	90                   	nop

00000cd0 <gets>:

char*
gets(char *buf, int max)
{
     cd0:	55                   	push   %ebp
     cd1:	89 e5                	mov    %esp,%ebp
     cd3:	57                   	push   %edi
     cd4:	56                   	push   %esi
     cd5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     cd6:	31 db                	xor    %ebx,%ebx
  return 0;
}

char*
gets(char *buf, int max)
{
     cd8:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
     cdb:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     cde:	8d 73 01             	lea    0x1(%ebx),%esi
     ce1:	3b 75 0c             	cmp    0xc(%ebp),%esi
     ce4:	7d 42                	jge    d28 <gets+0x58>
    cc = read(0, &c, 1);
     ce6:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     ced:	00 
     cee:	89 7c 24 04          	mov    %edi,0x4(%esp)
     cf2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     cf9:	e8 1c 01 00 00       	call   e1a <read>
    if(cc < 1)
     cfe:	85 c0                	test   %eax,%eax
     d00:	7e 26                	jle    d28 <gets+0x58>
      break;
    buf[i++] = c;
     d02:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     d06:	89 f3                	mov    %esi,%ebx
     d08:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
     d0b:	3c 0d                	cmp    $0xd,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
     d0d:	88 44 32 ff          	mov    %al,-0x1(%edx,%esi,1)
    if(c == '\n' || c == '\r')
     d11:	74 04                	je     d17 <gets+0x47>
     d13:	3c 0a                	cmp    $0xa,%al
     d15:	75 c7                	jne    cde <gets+0xe>
      break;
  }
  buf[i] = '\0';
     d17:	8b 45 08             	mov    0x8(%ebp),%eax
     d1a:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
     d1e:	83 c4 2c             	add    $0x2c,%esp
     d21:	5b                   	pop    %ebx
     d22:	5e                   	pop    %esi
     d23:	5f                   	pop    %edi
     d24:	5d                   	pop    %ebp
     d25:	c3                   	ret    
     d26:	66 90                	xchg   %ax,%ax
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     d28:	8b 45 08             	mov    0x8(%ebp),%eax
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
     d2b:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     d2d:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
     d31:	83 c4 2c             	add    $0x2c,%esp
     d34:	5b                   	pop    %ebx
     d35:	5e                   	pop    %esi
     d36:	5f                   	pop    %edi
     d37:	5d                   	pop    %ebp
     d38:	c3                   	ret    
     d39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000d40 <stat>:

int
stat(char *n, struct stat *st)
{
     d40:	55                   	push   %ebp
     d41:	89 e5                	mov    %esp,%ebp
     d43:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     d46:	8b 45 08             	mov    0x8(%ebp),%eax
     d49:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     d50:	00 
  return buf;
}

int
stat(char *n, struct stat *st)
{
     d51:	89 5d f8             	mov    %ebx,-0x8(%ebp)
     d54:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     d57:	89 04 24             	mov    %eax,(%esp)
     d5a:	e8 e3 00 00 00       	call   e42 <open>
  if(fd < 0)
     d5f:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     d61:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
     d63:	78 2b                	js     d90 <stat+0x50>
    return -1;
  r = fstat(fd, st);
     d65:	8b 45 0c             	mov    0xc(%ebp),%eax
     d68:	89 1c 24             	mov    %ebx,(%esp)
     d6b:	89 44 24 04          	mov    %eax,0x4(%esp)
     d6f:	e8 e6 00 00 00       	call   e5a <fstat>
  close(fd);
     d74:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
     d77:	89 c6                	mov    %eax,%esi
  close(fd);
     d79:	e8 ac 00 00 00       	call   e2a <close>
  return r;
}
     d7e:	89 f0                	mov    %esi,%eax
     d80:	8b 5d f8             	mov    -0x8(%ebp),%ebx
     d83:	8b 75 fc             	mov    -0x4(%ebp),%esi
     d86:	89 ec                	mov    %ebp,%esp
     d88:	5d                   	pop    %ebp
     d89:	c3                   	ret    
     d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
     d90:	be ff ff ff ff       	mov    $0xffffffff,%esi
     d95:	eb e7                	jmp    d7e <stat+0x3e>
     d97:	89 f6                	mov    %esi,%esi
     d99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000da0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
     da0:	55                   	push   %ebp
     da1:	89 e5                	mov    %esp,%ebp
     da3:	8b 4d 08             	mov    0x8(%ebp),%ecx
     da6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     da7:	0f be 11             	movsbl (%ecx),%edx
     daa:	8d 42 d0             	lea    -0x30(%edx),%eax
     dad:	3c 09                	cmp    $0x9,%al
     daf:	b8 00 00 00 00       	mov    $0x0,%eax
     db4:	77 17                	ja     dcd <atoi+0x2d>
     db6:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
     db8:	83 c1 01             	add    $0x1,%ecx
     dbb:	8d 04 80             	lea    (%eax,%eax,4),%eax
     dbe:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     dc2:	0f be 11             	movsbl (%ecx),%edx
     dc5:	8d 5a d0             	lea    -0x30(%edx),%ebx
     dc8:	80 fb 09             	cmp    $0x9,%bl
     dcb:	76 eb                	jbe    db8 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
     dcd:	5b                   	pop    %ebx
     dce:	5d                   	pop    %ebp
     dcf:	c3                   	ret    

00000dd0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     dd0:	55                   	push   %ebp
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
     dd1:	31 d2                	xor    %edx,%edx
{
     dd3:	89 e5                	mov    %esp,%ebp
     dd5:	56                   	push   %esi
     dd6:	8b 45 08             	mov    0x8(%ebp),%eax
     dd9:	53                   	push   %ebx
     dda:	8b 5d 10             	mov    0x10(%ebp),%ebx
     ddd:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     de0:	85 db                	test   %ebx,%ebx
     de2:	7e 12                	jle    df6 <memmove+0x26>
     de4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
     de8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
     dec:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     def:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     df2:	39 da                	cmp    %ebx,%edx
     df4:	75 f2                	jne    de8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
     df6:	5b                   	pop    %ebx
     df7:	5e                   	pop    %esi
     df8:	5d                   	pop    %ebp
     df9:	c3                   	ret    

00000dfa <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     dfa:	b8 01 00 00 00       	mov    $0x1,%eax
     dff:	cd 40                	int    $0x40
     e01:	c3                   	ret    

00000e02 <exit>:
SYSCALL(exit)
     e02:	b8 02 00 00 00       	mov    $0x2,%eax
     e07:	cd 40                	int    $0x40
     e09:	c3                   	ret    

00000e0a <wait>:
SYSCALL(wait)
     e0a:	b8 03 00 00 00       	mov    $0x3,%eax
     e0f:	cd 40                	int    $0x40
     e11:	c3                   	ret    

00000e12 <pipe>:
SYSCALL(pipe)
     e12:	b8 04 00 00 00       	mov    $0x4,%eax
     e17:	cd 40                	int    $0x40
     e19:	c3                   	ret    

00000e1a <read>:
SYSCALL(read)
     e1a:	b8 05 00 00 00       	mov    $0x5,%eax
     e1f:	cd 40                	int    $0x40
     e21:	c3                   	ret    

00000e22 <write>:
SYSCALL(write)
     e22:	b8 10 00 00 00       	mov    $0x10,%eax
     e27:	cd 40                	int    $0x40
     e29:	c3                   	ret    

00000e2a <close>:
SYSCALL(close)
     e2a:	b8 15 00 00 00       	mov    $0x15,%eax
     e2f:	cd 40                	int    $0x40
     e31:	c3                   	ret    

00000e32 <kill>:
SYSCALL(kill)
     e32:	b8 06 00 00 00       	mov    $0x6,%eax
     e37:	cd 40                	int    $0x40
     e39:	c3                   	ret    

00000e3a <exec>:
SYSCALL(exec)
     e3a:	b8 07 00 00 00       	mov    $0x7,%eax
     e3f:	cd 40                	int    $0x40
     e41:	c3                   	ret    

00000e42 <open>:
SYSCALL(open)
     e42:	b8 0f 00 00 00       	mov    $0xf,%eax
     e47:	cd 40                	int    $0x40
     e49:	c3                   	ret    

00000e4a <mknod>:
SYSCALL(mknod)
     e4a:	b8 11 00 00 00       	mov    $0x11,%eax
     e4f:	cd 40                	int    $0x40
     e51:	c3                   	ret    

00000e52 <unlink>:
SYSCALL(unlink)
     e52:	b8 12 00 00 00       	mov    $0x12,%eax
     e57:	cd 40                	int    $0x40
     e59:	c3                   	ret    

00000e5a <fstat>:
SYSCALL(fstat)
     e5a:	b8 08 00 00 00       	mov    $0x8,%eax
     e5f:	cd 40                	int    $0x40
     e61:	c3                   	ret    

00000e62 <link>:
SYSCALL(link)
     e62:	b8 13 00 00 00       	mov    $0x13,%eax
     e67:	cd 40                	int    $0x40
     e69:	c3                   	ret    

00000e6a <mkdir>:
SYSCALL(mkdir)
     e6a:	b8 14 00 00 00       	mov    $0x14,%eax
     e6f:	cd 40                	int    $0x40
     e71:	c3                   	ret    

00000e72 <chdir>:
SYSCALL(chdir)
     e72:	b8 09 00 00 00       	mov    $0x9,%eax
     e77:	cd 40                	int    $0x40
     e79:	c3                   	ret    

00000e7a <dup>:
SYSCALL(dup)
     e7a:	b8 0a 00 00 00       	mov    $0xa,%eax
     e7f:	cd 40                	int    $0x40
     e81:	c3                   	ret    

00000e82 <getpid>:
SYSCALL(getpid)
     e82:	b8 0b 00 00 00       	mov    $0xb,%eax
     e87:	cd 40                	int    $0x40
     e89:	c3                   	ret    

00000e8a <sbrk>:
SYSCALL(sbrk)
     e8a:	b8 0c 00 00 00       	mov    $0xc,%eax
     e8f:	cd 40                	int    $0x40
     e91:	c3                   	ret    

00000e92 <sleep>:
SYSCALL(sleep)
     e92:	b8 0d 00 00 00       	mov    $0xd,%eax
     e97:	cd 40                	int    $0x40
     e99:	c3                   	ret    

00000e9a <uptime>:
SYSCALL(uptime)
     e9a:	b8 0e 00 00 00       	mov    $0xe,%eax
     e9f:	cd 40                	int    $0x40
     ea1:	c3                   	ret    

00000ea2 <getprocs>:
SYSCALL(getprocs)
     ea2:	b8 16 00 00 00       	mov    $0x16,%eax
     ea7:	cd 40                	int    $0x40
     ea9:	c3                   	ret    
     eaa:	66 90                	xchg   %ax,%ax
     eac:	66 90                	xchg   %ax,%ax
     eae:	66 90                	xchg   %ax,%ax

00000eb0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     eb0:	55                   	push   %ebp
     eb1:	89 e5                	mov    %esp,%ebp
     eb3:	57                   	push   %edi
     eb4:	89 c7                	mov    %eax,%edi
     eb6:	56                   	push   %esi
     eb7:	53                   	push   %ebx
     eb8:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     ebb:	8b 45 08             	mov    0x8(%ebp),%eax
     ebe:	85 c0                	test   %eax,%eax
     ec0:	74 76                	je     f38 <printint+0x88>
     ec2:	89 d0                	mov    %edx,%eax
     ec4:	c1 e8 1f             	shr    $0x1f,%eax
     ec7:	84 c0                	test   %al,%al
     ec9:	74 6d                	je     f38 <printint+0x88>
    neg = 1;
    x = -xx;
     ecb:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
     ecd:	bb 01 00 00 00       	mov    $0x1,%ebx
    x = -xx;
     ed2:	f7 d8                	neg    %eax
  } else {
    x = xx;
  }

  i = 0;
     ed4:	31 f6                	xor    %esi,%esi
     ed6:	eb 02                	jmp    eda <printint+0x2a>
  do{
    buf[i++] = digits[x % base];
     ed8:	89 d6                	mov    %edx,%esi
     eda:	31 d2                	xor    %edx,%edx
     edc:	f7 f1                	div    %ecx
     ede:	0f b6 92 8f 13 00 00 	movzbl 0x138f(%edx),%edx
  }while((x /= base) != 0);
     ee5:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
     ee7:	88 54 35 d8          	mov    %dl,-0x28(%ebp,%esi,1)
     eeb:	8d 56 01             	lea    0x1(%esi),%edx
  }while((x /= base) != 0);
     eee:	75 e8                	jne    ed8 <printint+0x28>
  if(neg)
     ef0:	85 db                	test   %ebx,%ebx
     ef2:	74 08                	je     efc <printint+0x4c>
    buf[i++] = '-';
     ef4:	c6 44 15 d8 2d       	movb   $0x2d,-0x28(%ebp,%edx,1)
     ef9:	8d 56 02             	lea    0x2(%esi),%edx

  while(--i >= 0)
     efc:	8d 5a ff             	lea    -0x1(%edx),%ebx
     eff:	83 fb ff             	cmp    $0xffffffff,%ebx
     f02:	8d 75 d7             	lea    -0x29(%ebp),%esi
     f05:	74 25                	je     f2c <printint+0x7c>
     f07:	90                   	nop
     f08:	0f b6 44 1d d8       	movzbl -0x28(%ebp,%ebx,1),%eax
     f0d:	83 eb 01             	sub    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     f10:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     f17:	00 
     f18:	89 74 24 04          	mov    %esi,0x4(%esp)
     f1c:	89 3c 24             	mov    %edi,(%esp)
     f1f:	88 45 d7             	mov    %al,-0x29(%ebp)
     f22:	e8 fb fe ff ff       	call   e22 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     f27:	83 fb ff             	cmp    $0xffffffff,%ebx
     f2a:	75 dc                	jne    f08 <printint+0x58>
    putc(fd, buf[i]);
}
     f2c:	83 c4 3c             	add    $0x3c,%esp
     f2f:	5b                   	pop    %ebx
     f30:	5e                   	pop    %esi
     f31:	5f                   	pop    %edi
     f32:	5d                   	pop    %ebp
     f33:	c3                   	ret    
     f34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     f38:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     f3a:	31 db                	xor    %ebx,%ebx
     f3c:	eb 96                	jmp    ed4 <printint+0x24>
     f3e:	66 90                	xchg   %ax,%ax

00000f40 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     f40:	55                   	push   %ebp
     f41:	89 e5                	mov    %esp,%ebp
     f43:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     f44:	31 ff                	xor    %edi,%edi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     f46:	56                   	push   %esi
     f47:	53                   	push   %ebx
     f48:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     f4b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
     f4e:	8d 55 10             	lea    0x10(%ebp),%edx
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     f51:	8b 75 08             	mov    0x8(%ebp),%esi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
     f54:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
     f57:	0f be 03             	movsbl (%ebx),%eax
    putc(fd, buf[i]);
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
     f5a:	83 c3 01             	add    $0x1,%ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     f5d:	84 c0                	test   %al,%al
     f5f:	75 39                	jne    f9a <printf+0x5a>
     f61:	e9 c2 00 00 00       	jmp    1028 <printf+0xe8>
     f66:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
     f68:	83 fa 25             	cmp    $0x25,%edx
     f6b:	0f 84 bf 00 00 00    	je     1030 <printf+0xf0>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     f71:	8d 45 e2             	lea    -0x1e(%ebp),%eax
     f74:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     f7b:	00 
     f7c:	89 44 24 04          	mov    %eax,0x4(%esp)
     f80:	89 34 24             	mov    %esi,(%esp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
     f83:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     f86:	e8 97 fe ff ff       	call   e22 <write>
     f8b:	83 c3 01             	add    $0x1,%ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     f8e:	0f be 43 ff          	movsbl -0x1(%ebx),%eax
     f92:	84 c0                	test   %al,%al
     f94:	0f 84 8e 00 00 00    	je     1028 <printf+0xe8>
    c = fmt[i] & 0xff;
     f9a:	0f b6 d0             	movzbl %al,%edx
    if(state == 0){
     f9d:	85 ff                	test   %edi,%edi
     f9f:	74 c7                	je     f68 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
     fa1:	83 ff 25             	cmp    $0x25,%edi
     fa4:	75 e5                	jne    f8b <printf+0x4b>
      if(c == 'd'){
     fa6:	83 fa 64             	cmp    $0x64,%edx
     fa9:	0f 84 31 01 00 00    	je     10e0 <printf+0x1a0>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
     faf:	25 f7 00 00 00       	and    $0xf7,%eax
     fb4:	83 f8 70             	cmp    $0x70,%eax
     fb7:	0f 84 83 00 00 00    	je     1040 <printf+0x100>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
     fbd:	83 fa 73             	cmp    $0x73,%edx
     fc0:	0f 84 a2 00 00 00    	je     1068 <printf+0x128>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     fc6:	83 fa 63             	cmp    $0x63,%edx
     fc9:	0f 84 35 01 00 00    	je     1104 <printf+0x1c4>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
     fcf:	83 fa 25             	cmp    $0x25,%edx
     fd2:	0f 84 e0 00 00 00    	je     10b8 <printf+0x178>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     fd8:	8d 45 e6             	lea    -0x1a(%ebp),%eax
     fdb:	83 c3 01             	add    $0x1,%ebx
     fde:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     fe5:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     fe6:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     fe8:	89 44 24 04          	mov    %eax,0x4(%esp)
     fec:	89 34 24             	mov    %esi,(%esp)
     fef:	89 55 d0             	mov    %edx,-0x30(%ebp)
     ff2:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
     ff6:	e8 27 fe ff ff       	call   e22 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
     ffb:	8b 55 d0             	mov    -0x30(%ebp),%edx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     ffe:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1001:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1008:	00 
    1009:	89 44 24 04          	mov    %eax,0x4(%esp)
    100d:	89 34 24             	mov    %esi,(%esp)
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    1010:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1013:	e8 0a fe ff ff       	call   e22 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1018:	0f be 43 ff          	movsbl -0x1(%ebx),%eax
    101c:	84 c0                	test   %al,%al
    101e:	0f 85 76 ff ff ff    	jne    f9a <printf+0x5a>
    1024:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1028:	83 c4 3c             	add    $0x3c,%esp
    102b:	5b                   	pop    %ebx
    102c:	5e                   	pop    %esi
    102d:	5f                   	pop    %edi
    102e:	5d                   	pop    %ebp
    102f:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    1030:	bf 25 00 00 00       	mov    $0x25,%edi
    1035:	e9 51 ff ff ff       	jmp    f8b <printf+0x4b>
    103a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    1040:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    1043:	b9 10 00 00 00       	mov    $0x10,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1048:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    104a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1051:	8b 10                	mov    (%eax),%edx
    1053:	89 f0                	mov    %esi,%eax
    1055:	e8 56 fe ff ff       	call   eb0 <printint>
        ap++;
    105a:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    105e:	e9 28 ff ff ff       	jmp    f8b <printf+0x4b>
    1063:	90                   	nop
    1064:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
    1068:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        ap++;
        if(s == 0)
          s = "(null)";
    106b:	b8 88 13 00 00       	mov    $0x1388,%eax
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
    1070:	8b 3a                	mov    (%edx),%edi
        ap++;
    1072:	83 c2 04             	add    $0x4,%edx
    1075:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
          s = "(null)";
    1078:	85 ff                	test   %edi,%edi
    107a:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
    107d:	0f b6 07             	movzbl (%edi),%eax
    1080:	84 c0                	test   %al,%al
    1082:	74 28                	je     10ac <printf+0x16c>
    1084:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1088:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    108b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
    108e:	83 c7 01             	add    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1091:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1098:	00 
    1099:	89 44 24 04          	mov    %eax,0x4(%esp)
    109d:	89 34 24             	mov    %esi,(%esp)
    10a0:	e8 7d fd ff ff       	call   e22 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    10a5:	0f b6 07             	movzbl (%edi),%eax
    10a8:	84 c0                	test   %al,%al
    10aa:	75 dc                	jne    1088 <printf+0x148>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    10ac:	31 ff                	xor    %edi,%edi
    10ae:	e9 d8 fe ff ff       	jmp    f8b <printf+0x4b>
    10b3:	90                   	nop
    10b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    10b8:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    10bb:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    10bd:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    10c4:	00 
    10c5:	89 44 24 04          	mov    %eax,0x4(%esp)
    10c9:	89 34 24             	mov    %esi,(%esp)
    10cc:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
    10d0:	e8 4d fd ff ff       	call   e22 <write>
    10d5:	e9 b1 fe ff ff       	jmp    f8b <printf+0x4b>
    10da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    10e0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    10e3:	b9 0a 00 00 00       	mov    $0xa,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    10e8:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    10eb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10f2:	8b 10                	mov    (%eax),%edx
    10f4:	89 f0                	mov    %esi,%eax
    10f6:	e8 b5 fd ff ff       	call   eb0 <printint>
        ap++;
    10fb:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    10ff:	e9 87 fe ff ff       	jmp    f8b <printf+0x4b>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
    1104:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1107:	31 ff                	xor    %edi,%edi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
    1109:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    110b:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1112:	00 
    1113:	89 34 24             	mov    %esi,(%esp)
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
    1116:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    1119:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    111c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1120:	e8 fd fc ff ff       	call   e22 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
    1125:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    1129:	e9 5d fe ff ff       	jmp    f8b <printf+0x4b>
    112e:	66 90                	xchg   %ax,%ax

00001130 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1130:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1131:	a1 c4 19 00 00       	mov    0x19c4,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    1136:	89 e5                	mov    %esp,%ebp
    1138:	57                   	push   %edi
    1139:	56                   	push   %esi
    113a:	53                   	push   %ebx
    113b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    113e:	8b 08                	mov    (%eax),%ecx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1140:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1143:	39 d0                	cmp    %edx,%eax
    1145:	72 11                	jb     1158 <free+0x28>
    1147:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1148:	39 c8                	cmp    %ecx,%eax
    114a:	72 04                	jb     1150 <free+0x20>
    114c:	39 ca                	cmp    %ecx,%edx
    114e:	72 10                	jb     1160 <free+0x30>
    1150:	89 c8                	mov    %ecx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1152:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1154:	8b 08                	mov    (%eax),%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1156:	73 f0                	jae    1148 <free+0x18>
    1158:	39 ca                	cmp    %ecx,%edx
    115a:	72 04                	jb     1160 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    115c:	39 c8                	cmp    %ecx,%eax
    115e:	72 f0                	jb     1150 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1160:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1163:	8d 3c f2             	lea    (%edx,%esi,8),%edi
    1166:	39 cf                	cmp    %ecx,%edi
    1168:	74 1e                	je     1188 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    116a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
    116d:	8b 48 04             	mov    0x4(%eax),%ecx
    1170:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
    1173:	39 f2                	cmp    %esi,%edx
    1175:	74 28                	je     119f <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1177:	89 10                	mov    %edx,(%eax)
  freep = p;
    1179:	a3 c4 19 00 00       	mov    %eax,0x19c4
}
    117e:	5b                   	pop    %ebx
    117f:	5e                   	pop    %esi
    1180:	5f                   	pop    %edi
    1181:	5d                   	pop    %ebp
    1182:	c3                   	ret    
    1183:	90                   	nop
    1184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    1188:	03 71 04             	add    0x4(%ecx),%esi
    118b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    118e:	8b 08                	mov    (%eax),%ecx
    1190:	8b 09                	mov    (%ecx),%ecx
    1192:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    1195:	8b 48 04             	mov    0x4(%eax),%ecx
    1198:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
    119b:	39 f2                	cmp    %esi,%edx
    119d:	75 d8                	jne    1177 <free+0x47>
    p->s.size += bp->s.size;
    119f:	03 4b fc             	add    -0x4(%ebx),%ecx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
    11a2:	a3 c4 19 00 00       	mov    %eax,0x19c4
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    11a7:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    11aa:	8b 53 f8             	mov    -0x8(%ebx),%edx
    11ad:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
    11af:	5b                   	pop    %ebx
    11b0:	5e                   	pop    %esi
    11b1:	5f                   	pop    %edi
    11b2:	5d                   	pop    %ebp
    11b3:	c3                   	ret    
    11b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    11ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000011c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    11c0:	55                   	push   %ebp
    11c1:	89 e5                	mov    %esp,%ebp
    11c3:	57                   	push   %edi
    11c4:	56                   	push   %esi
    11c5:	53                   	push   %ebx
    11c6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    11c9:	8b 55 08             	mov    0x8(%ebp),%edx
  if((prevp = freep) == 0){
    11cc:	8b 0d c4 19 00 00    	mov    0x19c4,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    11d2:	83 c2 07             	add    $0x7,%edx
    11d5:	c1 ea 03             	shr    $0x3,%edx
  if((prevp = freep) == 0){
    11d8:	85 c9                	test   %ecx,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    11da:	8d 5a 01             	lea    0x1(%edx),%ebx
  if((prevp = freep) == 0){
    11dd:	0f 84 93 00 00 00    	je     1276 <malloc+0xb6>
    11e3:	8b 01                	mov    (%ecx),%eax
    11e5:	8b 78 04             	mov    0x4(%eax),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    11e8:	39 fb                	cmp    %edi,%ebx
    11ea:	76 64                	jbe    1250 <malloc+0x90>
    11ec:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    11f3:	eb 0c                	jmp    1201 <malloc+0x41>
    11f5:	8d 76 00             	lea    0x0(%esi),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    11f8:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    11fa:	8b 78 04             	mov    0x4(%eax),%edi
    11fd:	39 fb                	cmp    %edi,%ebx
    11ff:	76 4f                	jbe    1250 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1201:	3b 05 c4 19 00 00    	cmp    0x19c4,%eax
    1207:	89 c1                	mov    %eax,%ecx
    1209:	75 ed                	jne    11f8 <malloc+0x38>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    120b:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
    1211:	b8 00 80 00 00       	mov    $0x8000,%eax
    1216:	0f 43 c6             	cmovae %esi,%eax
    1219:	bf 00 10 00 00       	mov    $0x1000,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    121e:	89 04 24             	mov    %eax,(%esp)
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    1221:	0f 43 fb             	cmovae %ebx,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    1224:	e8 61 fc ff ff       	call   e8a <sbrk>
  if(p == (char*)-1)
    1229:	83 f8 ff             	cmp    $0xffffffff,%eax
    122c:	74 18                	je     1246 <malloc+0x86>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    122e:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
    1231:	83 c0 08             	add    $0x8,%eax
    1234:	89 04 24             	mov    %eax,(%esp)
    1237:	e8 f4 fe ff ff       	call   1130 <free>
  return freep;
    123c:	8b 0d c4 19 00 00    	mov    0x19c4,%ecx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    1242:	85 c9                	test   %ecx,%ecx
    1244:	75 b2                	jne    11f8 <malloc+0x38>
        return 0;
    1246:	31 c0                	xor    %eax,%eax
    1248:	eb 1e                	jmp    1268 <malloc+0xa8>
    124a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    1250:	39 fb                	cmp    %edi,%ebx
    1252:	74 1c                	je     1270 <malloc+0xb0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    1254:	29 df                	sub    %ebx,%edi
    1256:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
    1259:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
    125c:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    125f:	89 0d c4 19 00 00    	mov    %ecx,0x19c4
      return (void*)(p + 1);
    1265:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    1268:	83 c4 1c             	add    $0x1c,%esp
    126b:	5b                   	pop    %ebx
    126c:	5e                   	pop    %esi
    126d:	5f                   	pop    %edi
    126e:	5d                   	pop    %ebp
    126f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    1270:	8b 10                	mov    (%eax),%edx
    1272:	89 11                	mov    %edx,(%ecx)
    1274:	eb e9                	jmp    125f <malloc+0x9f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    1276:	c7 05 c4 19 00 00 c8 	movl   $0x19c8,0x19c4
    127d:	19 00 00 
    base.s.size = 0;
    1280:	b8 c8 19 00 00       	mov    $0x19c8,%eax
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    1285:	c7 05 c8 19 00 00 c8 	movl   $0x19c8,0x19c8
    128c:	19 00 00 
    base.s.size = 0;
    128f:	c7 05 cc 19 00 00 00 	movl   $0x0,0x19cc
    1296:	00 00 00 
    1299:	e9 4e ff ff ff       	jmp    11ec <malloc+0x2c>
