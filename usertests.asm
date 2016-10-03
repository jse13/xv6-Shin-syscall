
_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return randstate;
}

int
main(int argc, char *argv[])
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 e4 f0             	and    $0xfffffff0,%esp
       6:	83 ec 10             	sub    $0x10,%esp
  printf(1, "usertests starting\n");
       9:	c7 44 24 04 7b 50 00 	movl   $0x507b,0x4(%esp)
      10:	00 
      11:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      18:	e8 33 3d 00 00       	call   3d50 <printf>

  if(open("usertests.ran", 0) >= 0){
      1d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
      24:	00 
      25:	c7 04 24 8f 50 00 00 	movl   $0x508f,(%esp)
      2c:	e8 21 3c 00 00       	call   3c52 <open>
      31:	85 c0                	test   %eax,%eax
      33:	78 19                	js     4e <main+0x4e>
    printf(1, "already ran user tests -- rebuild fs.img\n");
      35:	c7 44 24 04 f8 57 00 	movl   $0x57f8,0x4(%esp)
      3c:	00 
      3d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      44:	e8 07 3d 00 00       	call   3d50 <printf>
    exit();
      49:	e8 c4 3b 00 00       	call   3c12 <exit>
  }
  close(open("usertests.ran", O_CREATE));
      4e:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
      55:	00 
      56:	c7 04 24 8f 50 00 00 	movl   $0x508f,(%esp)
      5d:	e8 f0 3b 00 00       	call   3c52 <open>
      62:	89 04 24             	mov    %eax,(%esp)
      65:	e8 d0 3b 00 00       	call   3c3a <close>

  createdelete();
      6a:	e8 91 12 00 00       	call   1300 <createdelete>
  linkunlink();
      6f:	e8 ec 1b 00 00       	call   1c60 <linkunlink>
  concreate();
      74:	e8 c7 18 00 00       	call   1940 <concreate>
  fourfiles();
      79:	e8 62 10 00 00       	call   10e0 <fourfiles>
      7e:	66 90                	xchg   %ax,%ax
  sharedfd();
      80:	e8 7b 0e 00 00       	call   f00 <sharedfd>

  bigargtest();
      85:	e8 86 35 00 00       	call   3610 <bigargtest>
  bigwrite();
      8a:	e8 c1 25 00 00       	call   2650 <bigwrite>
      8f:	90                   	nop
  bigargtest();
      90:	e8 7b 35 00 00       	call   3610 <bigargtest>
  bsstest();
      95:	e8 f6 34 00 00       	call   3590 <bsstest>
  sbrktest();
      9a:	e8 d1 2f 00 00       	call   3070 <sbrktest>
      9f:	90                   	nop
  validatetest();
      a0:	e8 3b 34 00 00       	call   34e0 <validatetest>

  opentest();
      a5:	e8 66 03 00 00       	call   410 <opentest>
  writetest();
      aa:	e8 01 04 00 00       	call   4b0 <writetest>
      af:	90                   	nop
  writetest1();
      b0:	e8 0b 06 00 00       	call   6c0 <writetest1>
  createtest();
      b5:	e8 f6 07 00 00       	call   8b0 <createtest>

  openiputtest();
      ba:	e8 41 02 00 00       	call   300 <openiputtest>
      bf:	90                   	nop
  exitiputtest();
      c0:	e8 4b 01 00 00       	call   210 <exitiputtest>
  iputtest();
      c5:	e8 66 00 00 00       	call   130 <iputtest>

  mem();
      ca:	e8 61 0d 00 00       	call   e30 <mem>
      cf:	90                   	nop
  pipe1();
      d0:	e8 bb 09 00 00       	call   a90 <pipe1>
  preempt();
      d5:	e8 66 0b 00 00       	call   c40 <preempt>
  exitwait();
      da:	e8 c1 0c 00 00       	call   da0 <exitwait>
      df:	90                   	nop

  rmdot();
      e0:	e8 cb 29 00 00       	call   2ab0 <rmdot>
  fourteen();
      e5:	e8 66 28 00 00       	call   2950 <fourteen>
  bigfile();
      ea:	e8 61 26 00 00       	call   2750 <bigfile>
      ef:	90                   	nop
  subdir();
      f0:	e8 cb 1d 00 00       	call   1ec0 <subdir>
  linktest();
      f5:	e8 e6 15 00 00       	call   16e0 <linktest>
  unlinkread();
      fa:	e8 11 14 00 00       	call   1510 <unlinkread>
      ff:	90                   	nop
  dirfile();
     100:	e8 3b 2b 00 00       	call   2c40 <dirfile>
  iref();
     105:	e8 76 2d 00 00       	call   2e80 <iref>
  forktest();
     10a:	e8 91 2e 00 00       	call   2fa0 <forktest>
     10f:	90                   	nop
  bigdir(); // slow
     110:	e8 5b 1c 00 00       	call   1d70 <bigdir>

  uio();
     115:	e8 16 38 00 00       	call   3930 <uio>

  exectest();
     11a:	e8 21 09 00 00       	call   a40 <exectest>
     11f:	90                   	nop

  exit();
     120:	e8 ed 3a 00 00       	call   3c12 <exit>
     125:	66 90                	xchg   %ax,%ax
     127:	66 90                	xchg   %ax,%ax
     129:	66 90                	xchg   %ax,%ax
     12b:	66 90                	xchg   %ax,%ax
     12d:	66 90                	xchg   %ax,%ax
     12f:	90                   	nop

00000130 <iputtest>:
int stdout = 1;

// does chdir() call iput(p->cwd) in a transaction?
void
iputtest(void)
{
     130:	55                   	push   %ebp
     131:	89 e5                	mov    %esp,%ebp
     133:	83 ec 18             	sub    $0x18,%esp
  printf(stdout, "iput test\n");
     136:	a1 fc 60 00 00       	mov    0x60fc,%eax
     13b:	c7 44 24 04 44 41 00 	movl   $0x4144,0x4(%esp)
     142:	00 
     143:	89 04 24             	mov    %eax,(%esp)
     146:	e8 05 3c 00 00       	call   3d50 <printf>

  if(mkdir("iputdir") < 0){
     14b:	c7 04 24 d7 40 00 00 	movl   $0x40d7,(%esp)
     152:	e8 23 3b 00 00       	call   3c7a <mkdir>
     157:	85 c0                	test   %eax,%eax
     159:	78 4b                	js     1a6 <iputtest+0x76>
    printf(stdout, "mkdir failed\n");
    exit();
  }
  if(chdir("iputdir") < 0){
     15b:	c7 04 24 d7 40 00 00 	movl   $0x40d7,(%esp)
     162:	e8 1b 3b 00 00       	call   3c82 <chdir>
     167:	85 c0                	test   %eax,%eax
     169:	0f 88 85 00 00 00    	js     1f4 <iputtest+0xc4>
    printf(stdout, "chdir iputdir failed\n");
    exit();
  }
  if(unlink("../iputdir") < 0){
     16f:	c7 04 24 d4 40 00 00 	movl   $0x40d4,(%esp)
     176:	e8 e7 3a 00 00       	call   3c62 <unlink>
     17b:	85 c0                	test   %eax,%eax
     17d:	78 5b                	js     1da <iputtest+0xaa>
    printf(stdout, "unlink ../iputdir failed\n");
    exit();
  }
  if(chdir("/") < 0){
     17f:	c7 04 24 f9 40 00 00 	movl   $0x40f9,(%esp)
     186:	e8 f7 3a 00 00       	call   3c82 <chdir>
     18b:	85 c0                	test   %eax,%eax
     18d:	78 31                	js     1c0 <iputtest+0x90>
    printf(stdout, "chdir / failed\n");
    exit();
  }
  printf(stdout, "iput test ok\n");
     18f:	a1 fc 60 00 00       	mov    0x60fc,%eax
     194:	c7 44 24 04 7c 41 00 	movl   $0x417c,0x4(%esp)
     19b:	00 
     19c:	89 04 24             	mov    %eax,(%esp)
     19f:	e8 ac 3b 00 00       	call   3d50 <printf>
}
     1a4:	c9                   	leave  
     1a5:	c3                   	ret    
iputtest(void)
{
  printf(stdout, "iput test\n");

  if(mkdir("iputdir") < 0){
    printf(stdout, "mkdir failed\n");
     1a6:	a1 fc 60 00 00       	mov    0x60fc,%eax
     1ab:	c7 44 24 04 b0 40 00 	movl   $0x40b0,0x4(%esp)
     1b2:	00 
     1b3:	89 04 24             	mov    %eax,(%esp)
     1b6:	e8 95 3b 00 00       	call   3d50 <printf>
    exit();
     1bb:	e8 52 3a 00 00       	call   3c12 <exit>
  if(unlink("../iputdir") < 0){
    printf(stdout, "unlink ../iputdir failed\n");
    exit();
  }
  if(chdir("/") < 0){
    printf(stdout, "chdir / failed\n");
     1c0:	a1 fc 60 00 00       	mov    0x60fc,%eax
     1c5:	c7 44 24 04 fb 40 00 	movl   $0x40fb,0x4(%esp)
     1cc:	00 
     1cd:	89 04 24             	mov    %eax,(%esp)
     1d0:	e8 7b 3b 00 00       	call   3d50 <printf>
    exit();
     1d5:	e8 38 3a 00 00       	call   3c12 <exit>
  if(chdir("iputdir") < 0){
    printf(stdout, "chdir iputdir failed\n");
    exit();
  }
  if(unlink("../iputdir") < 0){
    printf(stdout, "unlink ../iputdir failed\n");
     1da:	a1 fc 60 00 00       	mov    0x60fc,%eax
     1df:	c7 44 24 04 df 40 00 	movl   $0x40df,0x4(%esp)
     1e6:	00 
     1e7:	89 04 24             	mov    %eax,(%esp)
     1ea:	e8 61 3b 00 00       	call   3d50 <printf>
    exit();
     1ef:	e8 1e 3a 00 00       	call   3c12 <exit>
  if(mkdir("iputdir") < 0){
    printf(stdout, "mkdir failed\n");
    exit();
  }
  if(chdir("iputdir") < 0){
    printf(stdout, "chdir iputdir failed\n");
     1f4:	a1 fc 60 00 00       	mov    0x60fc,%eax
     1f9:	c7 44 24 04 be 40 00 	movl   $0x40be,0x4(%esp)
     200:	00 
     201:	89 04 24             	mov    %eax,(%esp)
     204:	e8 47 3b 00 00       	call   3d50 <printf>
    exit();
     209:	e8 04 3a 00 00       	call   3c12 <exit>
     20e:	66 90                	xchg   %ax,%ax

00000210 <exitiputtest>:
}

// does exit() call iput(p->cwd) in a transaction?
void
exitiputtest(void)
{
     210:	55                   	push   %ebp
     211:	89 e5                	mov    %esp,%ebp
     213:	83 ec 18             	sub    $0x18,%esp
  int pid;

  printf(stdout, "exitiput test\n");
     216:	a1 fc 60 00 00       	mov    0x60fc,%eax
     21b:	c7 44 24 04 0b 41 00 	movl   $0x410b,0x4(%esp)
     222:	00 
     223:	89 04 24             	mov    %eax,(%esp)
     226:	e8 25 3b 00 00       	call   3d50 <printf>

  pid = fork();
     22b:	e8 da 39 00 00       	call   3c0a <fork>
  if(pid < 0){
     230:	83 f8 00             	cmp    $0x0,%eax
     233:	7c 75                	jl     2aa <exitiputtest+0x9a>
    printf(stdout, "fork failed\n");
    exit();
  }
  if(pid == 0){
     235:	75 39                	jne    270 <exitiputtest+0x60>
    if(mkdir("iputdir") < 0){
     237:	c7 04 24 d7 40 00 00 	movl   $0x40d7,(%esp)
     23e:	e8 37 3a 00 00       	call   3c7a <mkdir>
     243:	85 c0                	test   %eax,%eax
     245:	0f 88 93 00 00 00    	js     2de <exitiputtest+0xce>
      printf(stdout, "mkdir failed\n");
      exit();
    }
    if(chdir("iputdir") < 0){
     24b:	c7 04 24 d7 40 00 00 	movl   $0x40d7,(%esp)
     252:	e8 2b 3a 00 00       	call   3c82 <chdir>
     257:	85 c0                	test   %eax,%eax
     259:	78 69                	js     2c4 <exitiputtest+0xb4>
      printf(stdout, "child chdir failed\n");
      exit();
    }
    if(unlink("../iputdir") < 0){
     25b:	c7 04 24 d4 40 00 00 	movl   $0x40d4,(%esp)
     262:	e8 fb 39 00 00       	call   3c62 <unlink>
     267:	85 c0                	test   %eax,%eax
     269:	78 25                	js     290 <exitiputtest+0x80>
      printf(stdout, "unlink ../iputdir failed\n");
      exit();
    }
    exit();
     26b:	e8 a2 39 00 00       	call   3c12 <exit>
  }
  wait();
     270:	e8 a5 39 00 00       	call   3c1a <wait>
  printf(stdout, "exitiput test ok\n");
     275:	a1 fc 60 00 00       	mov    0x60fc,%eax
     27a:	c7 44 24 04 2e 41 00 	movl   $0x412e,0x4(%esp)
     281:	00 
     282:	89 04 24             	mov    %eax,(%esp)
     285:	e8 c6 3a 00 00       	call   3d50 <printf>
}
     28a:	c9                   	leave  
     28b:	c3                   	ret    
     28c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(chdir("iputdir") < 0){
      printf(stdout, "child chdir failed\n");
      exit();
    }
    if(unlink("../iputdir") < 0){
      printf(stdout, "unlink ../iputdir failed\n");
     290:	a1 fc 60 00 00       	mov    0x60fc,%eax
     295:	c7 44 24 04 df 40 00 	movl   $0x40df,0x4(%esp)
     29c:	00 
     29d:	89 04 24             	mov    %eax,(%esp)
     2a0:	e8 ab 3a 00 00       	call   3d50 <printf>
      exit();
     2a5:	e8 68 39 00 00       	call   3c12 <exit>

  printf(stdout, "exitiput test\n");

  pid = fork();
  if(pid < 0){
    printf(stdout, "fork failed\n");
     2aa:	a1 fc 60 00 00       	mov    0x60fc,%eax
     2af:	c7 44 24 04 f1 4f 00 	movl   $0x4ff1,0x4(%esp)
     2b6:	00 
     2b7:	89 04 24             	mov    %eax,(%esp)
     2ba:	e8 91 3a 00 00       	call   3d50 <printf>
    exit();
     2bf:	e8 4e 39 00 00       	call   3c12 <exit>
    if(mkdir("iputdir") < 0){
      printf(stdout, "mkdir failed\n");
      exit();
    }
    if(chdir("iputdir") < 0){
      printf(stdout, "child chdir failed\n");
     2c4:	a1 fc 60 00 00       	mov    0x60fc,%eax
     2c9:	c7 44 24 04 1a 41 00 	movl   $0x411a,0x4(%esp)
     2d0:	00 
     2d1:	89 04 24             	mov    %eax,(%esp)
     2d4:	e8 77 3a 00 00       	call   3d50 <printf>
      exit();
     2d9:	e8 34 39 00 00       	call   3c12 <exit>
    printf(stdout, "fork failed\n");
    exit();
  }
  if(pid == 0){
    if(mkdir("iputdir") < 0){
      printf(stdout, "mkdir failed\n");
     2de:	a1 fc 60 00 00       	mov    0x60fc,%eax
     2e3:	c7 44 24 04 b0 40 00 	movl   $0x40b0,0x4(%esp)
     2ea:	00 
     2eb:	89 04 24             	mov    %eax,(%esp)
     2ee:	e8 5d 3a 00 00       	call   3d50 <printf>
      exit();
     2f3:	e8 1a 39 00 00       	call   3c12 <exit>
     2f8:	90                   	nop
     2f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000300 <openiputtest>:
//      for(i = 0; i < 10000; i++)
//        yield();
//    }
void
openiputtest(void)
{
     300:	55                   	push   %ebp
     301:	89 e5                	mov    %esp,%ebp
     303:	83 ec 18             	sub    $0x18,%esp
  int pid;

  printf(stdout, "openiput test\n");
     306:	a1 fc 60 00 00       	mov    0x60fc,%eax
     30b:	c7 44 24 04 40 41 00 	movl   $0x4140,0x4(%esp)
     312:	00 
     313:	89 04 24             	mov    %eax,(%esp)
     316:	e8 35 3a 00 00       	call   3d50 <printf>
  if(mkdir("oidir") < 0){
     31b:	c7 04 24 4f 41 00 00 	movl   $0x414f,(%esp)
     322:	e8 53 39 00 00       	call   3c7a <mkdir>
     327:	85 c0                	test   %eax,%eax
     329:	0f 88 9e 00 00 00    	js     3cd <openiputtest+0xcd>
    printf(stdout, "mkdir oidir failed\n");
    exit();
  }
  pid = fork();
     32f:	e8 d6 38 00 00       	call   3c0a <fork>
  if(pid < 0){
     334:	83 f8 00             	cmp    $0x0,%eax
     337:	0f 8c aa 00 00 00    	jl     3e7 <openiputtest+0xe7>
     33d:	8d 76 00             	lea    0x0(%esi),%esi
    printf(stdout, "fork failed\n");
    exit();
  }
  if(pid == 0){
     340:	75 36                	jne    378 <openiputtest+0x78>
    int fd = open("oidir", O_RDWR);
     342:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
     349:	00 
     34a:	c7 04 24 4f 41 00 00 	movl   $0x414f,(%esp)
     351:	e8 fc 38 00 00       	call   3c52 <open>
    if(fd >= 0){
     356:	85 c0                	test   %eax,%eax
     358:	78 6e                	js     3c8 <openiputtest+0xc8>
      printf(stdout, "open directory for write succeeded\n");
     35a:	a1 fc 60 00 00       	mov    0x60fc,%eax
     35f:	c7 44 24 04 b0 50 00 	movl   $0x50b0,0x4(%esp)
     366:	00 
     367:	89 04 24             	mov    %eax,(%esp)
     36a:	e8 e1 39 00 00       	call   3d50 <printf>
      exit();
     36f:	e8 9e 38 00 00       	call   3c12 <exit>
     374:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
    exit();
  }
  sleep(1);
     378:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     37f:	e8 1e 39 00 00       	call   3ca2 <sleep>
  if(unlink("oidir") != 0){
     384:	c7 04 24 4f 41 00 00 	movl   $0x414f,(%esp)
     38b:	e8 d2 38 00 00       	call   3c62 <unlink>
     390:	85 c0                	test   %eax,%eax
     392:	75 1c                	jne    3b0 <openiputtest+0xb0>
    printf(stdout, "unlink failed\n");
    exit();
  }
  wait();
     394:	e8 81 38 00 00       	call   3c1a <wait>
  printf(stdout, "openiput test ok\n");
     399:	a1 fc 60 00 00       	mov    0x60fc,%eax
     39e:	c7 44 24 04 78 41 00 	movl   $0x4178,0x4(%esp)
     3a5:	00 
     3a6:	89 04 24             	mov    %eax,(%esp)
     3a9:	e8 a2 39 00 00       	call   3d50 <printf>
}
     3ae:	c9                   	leave  
     3af:	c3                   	ret    
    }
    exit();
  }
  sleep(1);
  if(unlink("oidir") != 0){
    printf(stdout, "unlink failed\n");
     3b0:	a1 fc 60 00 00       	mov    0x60fc,%eax
     3b5:	c7 44 24 04 69 41 00 	movl   $0x4169,0x4(%esp)
     3bc:	00 
     3bd:	89 04 24             	mov    %eax,(%esp)
     3c0:	e8 8b 39 00 00       	call   3d50 <printf>
     3c5:	8d 76 00             	lea    0x0(%esi),%esi
    exit();
     3c8:	e8 45 38 00 00       	call   3c12 <exit>
{
  int pid;

  printf(stdout, "openiput test\n");
  if(mkdir("oidir") < 0){
    printf(stdout, "mkdir oidir failed\n");
     3cd:	a1 fc 60 00 00       	mov    0x60fc,%eax
     3d2:	c7 44 24 04 55 41 00 	movl   $0x4155,0x4(%esp)
     3d9:	00 
     3da:	89 04 24             	mov    %eax,(%esp)
     3dd:	e8 6e 39 00 00       	call   3d50 <printf>
    exit();
     3e2:	e8 2b 38 00 00       	call   3c12 <exit>
  }
  pid = fork();
  if(pid < 0){
    printf(stdout, "fork failed\n");
     3e7:	a1 fc 60 00 00       	mov    0x60fc,%eax
     3ec:	c7 44 24 04 f1 4f 00 	movl   $0x4ff1,0x4(%esp)
     3f3:	00 
     3f4:	89 04 24             	mov    %eax,(%esp)
     3f7:	e8 54 39 00 00       	call   3d50 <printf>
    exit();
     3fc:	e8 11 38 00 00       	call   3c12 <exit>
     401:	eb 0d                	jmp    410 <opentest>
     403:	90                   	nop
     404:	90                   	nop
     405:	90                   	nop
     406:	90                   	nop
     407:	90                   	nop
     408:	90                   	nop
     409:	90                   	nop
     40a:	90                   	nop
     40b:	90                   	nop
     40c:	90                   	nop
     40d:	90                   	nop
     40e:	90                   	nop
     40f:	90                   	nop

00000410 <opentest>:

// simple file system tests

void
opentest(void)
{
     410:	55                   	push   %ebp
     411:	89 e5                	mov    %esp,%ebp
     413:	83 ec 18             	sub    $0x18,%esp
  int fd;

  printf(stdout, "open test\n");
     416:	a1 fc 60 00 00       	mov    0x60fc,%eax
     41b:	c7 44 24 04 8a 41 00 	movl   $0x418a,0x4(%esp)
     422:	00 
     423:	89 04 24             	mov    %eax,(%esp)
     426:	e8 25 39 00 00       	call   3d50 <printf>
  fd = open("echo", 0);
     42b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     432:	00 
     433:	c7 04 24 95 41 00 00 	movl   $0x4195,(%esp)
     43a:	e8 13 38 00 00       	call   3c52 <open>
  if(fd < 0){
     43f:	85 c0                	test   %eax,%eax
     441:	78 37                	js     47a <opentest+0x6a>
    printf(stdout, "open echo failed!\n");
    exit();
  }
  close(fd);
     443:	89 04 24             	mov    %eax,(%esp)
     446:	e8 ef 37 00 00       	call   3c3a <close>
  fd = open("doesnotexist", 0);
     44b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     452:	00 
     453:	c7 04 24 ad 41 00 00 	movl   $0x41ad,(%esp)
     45a:	e8 f3 37 00 00       	call   3c52 <open>
  if(fd >= 0){
     45f:	85 c0                	test   %eax,%eax
     461:	79 31                	jns    494 <opentest+0x84>
    printf(stdout, "open doesnotexist succeeded!\n");
    exit();
  }
  printf(stdout, "open test ok\n");
     463:	a1 fc 60 00 00       	mov    0x60fc,%eax
     468:	c7 44 24 04 d8 41 00 	movl   $0x41d8,0x4(%esp)
     46f:	00 
     470:	89 04 24             	mov    %eax,(%esp)
     473:	e8 d8 38 00 00       	call   3d50 <printf>
}
     478:	c9                   	leave  
     479:	c3                   	ret    
  int fd;

  printf(stdout, "open test\n");
  fd = open("echo", 0);
  if(fd < 0){
    printf(stdout, "open echo failed!\n");
     47a:	a1 fc 60 00 00       	mov    0x60fc,%eax
     47f:	c7 44 24 04 9a 41 00 	movl   $0x419a,0x4(%esp)
     486:	00 
     487:	89 04 24             	mov    %eax,(%esp)
     48a:	e8 c1 38 00 00       	call   3d50 <printf>
    exit();
     48f:	e8 7e 37 00 00       	call   3c12 <exit>
  }
  close(fd);
  fd = open("doesnotexist", 0);
  if(fd >= 0){
    printf(stdout, "open doesnotexist succeeded!\n");
     494:	a1 fc 60 00 00       	mov    0x60fc,%eax
     499:	c7 44 24 04 ba 41 00 	movl   $0x41ba,0x4(%esp)
     4a0:	00 
     4a1:	89 04 24             	mov    %eax,(%esp)
     4a4:	e8 a7 38 00 00       	call   3d50 <printf>
    exit();
     4a9:	e8 64 37 00 00       	call   3c12 <exit>
     4ae:	66 90                	xchg   %ax,%ax

000004b0 <writetest>:
  printf(stdout, "open test ok\n");
}

void
writetest(void)
{
     4b0:	55                   	push   %ebp
     4b1:	89 e5                	mov    %esp,%ebp
     4b3:	56                   	push   %esi
     4b4:	53                   	push   %ebx
     4b5:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int i;

  printf(stdout, "small file test\n");
     4b8:	a1 fc 60 00 00       	mov    0x60fc,%eax
     4bd:	c7 44 24 04 e6 41 00 	movl   $0x41e6,0x4(%esp)
     4c4:	00 
     4c5:	89 04 24             	mov    %eax,(%esp)
     4c8:	e8 83 38 00 00       	call   3d50 <printf>
  fd = open("small", O_CREATE|O_RDWR);
     4cd:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     4d4:	00 
     4d5:	c7 04 24 f7 41 00 00 	movl   $0x41f7,(%esp)
     4dc:	e8 71 37 00 00       	call   3c52 <open>
  if(fd >= 0){
     4e1:	85 c0                	test   %eax,%eax
{
  int fd;
  int i;

  printf(stdout, "small file test\n");
  fd = open("small", O_CREATE|O_RDWR);
     4e3:	89 c6                	mov    %eax,%esi
  if(fd >= 0){
     4e5:	0f 88 b1 01 00 00    	js     69c <writetest+0x1ec>
    printf(stdout, "creat small succeeded; ok\n");
     4eb:	a1 fc 60 00 00       	mov    0x60fc,%eax
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
     4f0:	31 db                	xor    %ebx,%ebx
  int i;

  printf(stdout, "small file test\n");
  fd = open("small", O_CREATE|O_RDWR);
  if(fd >= 0){
    printf(stdout, "creat small succeeded; ok\n");
     4f2:	c7 44 24 04 fd 41 00 	movl   $0x41fd,0x4(%esp)
     4f9:	00 
     4fa:	89 04 24             	mov    %eax,(%esp)
     4fd:	e8 4e 38 00 00       	call   3d50 <printf>
     502:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
    if(write(fd, "aaaaaaaaaa", 10) != 10){
     508:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     50f:	00 
     510:	c7 44 24 04 34 42 00 	movl   $0x4234,0x4(%esp)
     517:	00 
     518:	89 34 24             	mov    %esi,(%esp)
     51b:	e8 12 37 00 00       	call   3c32 <write>
     520:	83 f8 0a             	cmp    $0xa,%eax
     523:	0f 85 e9 00 00 00    	jne    612 <writetest+0x162>
      printf(stdout, "error: write aa %d new file failed\n", i);
      exit();
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
     529:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     530:	00 
     531:	c7 44 24 04 3f 42 00 	movl   $0x423f,0x4(%esp)
     538:	00 
     539:	89 34 24             	mov    %esi,(%esp)
     53c:	e8 f1 36 00 00       	call   3c32 <write>
     541:	83 f8 0a             	cmp    $0xa,%eax
     544:	0f 85 e6 00 00 00    	jne    630 <writetest+0x180>
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
     54a:	83 c3 01             	add    $0x1,%ebx
     54d:	83 fb 64             	cmp    $0x64,%ebx
     550:	75 b6                	jne    508 <writetest+0x58>
    if(write(fd, "bbbbbbbbbb", 10) != 10){
      printf(stdout, "error: write bb %d new file failed\n", i);
      exit();
    }
  }
  printf(stdout, "writes ok\n");
     552:	a1 fc 60 00 00       	mov    0x60fc,%eax
     557:	c7 44 24 04 4a 42 00 	movl   $0x424a,0x4(%esp)
     55e:	00 
     55f:	89 04 24             	mov    %eax,(%esp)
     562:	e8 e9 37 00 00       	call   3d50 <printf>
  close(fd);
     567:	89 34 24             	mov    %esi,(%esp)
     56a:	e8 cb 36 00 00       	call   3c3a <close>
  fd = open("small", O_RDONLY);
     56f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     576:	00 
     577:	c7 04 24 f7 41 00 00 	movl   $0x41f7,(%esp)
     57e:	e8 cf 36 00 00       	call   3c52 <open>
  if(fd >= 0){
     583:	85 c0                	test   %eax,%eax
      exit();
    }
  }
  printf(stdout, "writes ok\n");
  close(fd);
  fd = open("small", O_RDONLY);
     585:	89 c3                	mov    %eax,%ebx
  if(fd >= 0){
     587:	0f 88 c1 00 00 00    	js     64e <writetest+0x19e>
    printf(stdout, "open small succeeded ok\n");
     58d:	a1 fc 60 00 00       	mov    0x60fc,%eax
     592:	c7 44 24 04 55 42 00 	movl   $0x4255,0x4(%esp)
     599:	00 
     59a:	89 04 24             	mov    %eax,(%esp)
     59d:	e8 ae 37 00 00       	call   3d50 <printf>
  } else {
    printf(stdout, "error: open small failed!\n");
    exit();
  }
  i = read(fd, buf, 2000);
     5a2:	c7 44 24 08 d0 07 00 	movl   $0x7d0,0x8(%esp)
     5a9:	00 
     5aa:	c7 44 24 04 e0 88 00 	movl   $0x88e0,0x4(%esp)
     5b1:	00 
     5b2:	89 1c 24             	mov    %ebx,(%esp)
     5b5:	e8 70 36 00 00       	call   3c2a <read>
  if(i == 2000){
     5ba:	3d d0 07 00 00       	cmp    $0x7d0,%eax
     5bf:	0f 85 a3 00 00 00    	jne    668 <writetest+0x1b8>
    printf(stdout, "read succeeded ok\n");
     5c5:	a1 fc 60 00 00       	mov    0x60fc,%eax
     5ca:	c7 44 24 04 89 42 00 	movl   $0x4289,0x4(%esp)
     5d1:	00 
     5d2:	89 04 24             	mov    %eax,(%esp)
     5d5:	e8 76 37 00 00       	call   3d50 <printf>
  } else {
    printf(stdout, "read failed\n");
    exit();
  }
  close(fd);
     5da:	89 1c 24             	mov    %ebx,(%esp)
     5dd:	e8 58 36 00 00       	call   3c3a <close>

  if(unlink("small") < 0){
     5e2:	c7 04 24 f7 41 00 00 	movl   $0x41f7,(%esp)
     5e9:	e8 74 36 00 00       	call   3c62 <unlink>
     5ee:	85 c0                	test   %eax,%eax
     5f0:	0f 88 8c 00 00 00    	js     682 <writetest+0x1d2>
    printf(stdout, "unlink small failed\n");
    exit();
  }
  printf(stdout, "small file test ok\n");
     5f6:	a1 fc 60 00 00       	mov    0x60fc,%eax
     5fb:	c7 44 24 04 b1 42 00 	movl   $0x42b1,0x4(%esp)
     602:	00 
     603:	89 04 24             	mov    %eax,(%esp)
     606:	e8 45 37 00 00       	call   3d50 <printf>
}
     60b:	83 c4 10             	add    $0x10,%esp
     60e:	5b                   	pop    %ebx
     60f:	5e                   	pop    %esi
     610:	5d                   	pop    %ebp
     611:	c3                   	ret    
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
    if(write(fd, "aaaaaaaaaa", 10) != 10){
      printf(stdout, "error: write aa %d new file failed\n", i);
     612:	a1 fc 60 00 00       	mov    0x60fc,%eax
     617:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     61b:	c7 44 24 04 d4 50 00 	movl   $0x50d4,0x4(%esp)
     622:	00 
     623:	89 04 24             	mov    %eax,(%esp)
     626:	e8 25 37 00 00       	call   3d50 <printf>
      exit();
     62b:	e8 e2 35 00 00       	call   3c12 <exit>
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
      printf(stdout, "error: write bb %d new file failed\n", i);
     630:	a1 fc 60 00 00       	mov    0x60fc,%eax
     635:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     639:	c7 44 24 04 f8 50 00 	movl   $0x50f8,0x4(%esp)
     640:	00 
     641:	89 04 24             	mov    %eax,(%esp)
     644:	e8 07 37 00 00       	call   3d50 <printf>
      exit();
     649:	e8 c4 35 00 00       	call   3c12 <exit>
  close(fd);
  fd = open("small", O_RDONLY);
  if(fd >= 0){
    printf(stdout, "open small succeeded ok\n");
  } else {
    printf(stdout, "error: open small failed!\n");
     64e:	a1 fc 60 00 00       	mov    0x60fc,%eax
     653:	c7 44 24 04 6e 42 00 	movl   $0x426e,0x4(%esp)
     65a:	00 
     65b:	89 04 24             	mov    %eax,(%esp)
     65e:	e8 ed 36 00 00       	call   3d50 <printf>
    exit();
     663:	e8 aa 35 00 00       	call   3c12 <exit>
  }
  i = read(fd, buf, 2000);
  if(i == 2000){
    printf(stdout, "read succeeded ok\n");
  } else {
    printf(stdout, "read failed\n");
     668:	a1 fc 60 00 00       	mov    0x60fc,%eax
     66d:	c7 44 24 04 b5 45 00 	movl   $0x45b5,0x4(%esp)
     674:	00 
     675:	89 04 24             	mov    %eax,(%esp)
     678:	e8 d3 36 00 00       	call   3d50 <printf>
    exit();
     67d:	e8 90 35 00 00       	call   3c12 <exit>
  }
  close(fd);

  if(unlink("small") < 0){
    printf(stdout, "unlink small failed\n");
     682:	a1 fc 60 00 00       	mov    0x60fc,%eax
     687:	c7 44 24 04 9c 42 00 	movl   $0x429c,0x4(%esp)
     68e:	00 
     68f:	89 04 24             	mov    %eax,(%esp)
     692:	e8 b9 36 00 00       	call   3d50 <printf>
    exit();
     697:	e8 76 35 00 00       	call   3c12 <exit>
  printf(stdout, "small file test\n");
  fd = open("small", O_CREATE|O_RDWR);
  if(fd >= 0){
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
     69c:	a1 fc 60 00 00       	mov    0x60fc,%eax
     6a1:	c7 44 24 04 18 42 00 	movl   $0x4218,0x4(%esp)
     6a8:	00 
     6a9:	89 04 24             	mov    %eax,(%esp)
     6ac:	e8 9f 36 00 00       	call   3d50 <printf>
    exit();
     6b1:	e8 5c 35 00 00       	call   3c12 <exit>
     6b6:	8d 76 00             	lea    0x0(%esi),%esi
     6b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006c0 <writetest1>:
  printf(stdout, "small file test ok\n");
}

void
writetest1(void)
{
     6c0:	55                   	push   %ebp
     6c1:	89 e5                	mov    %esp,%ebp
     6c3:	56                   	push   %esi
     6c4:	53                   	push   %ebx
     6c5:	83 ec 10             	sub    $0x10,%esp
  int i, fd, n;

  printf(stdout, "big files test\n");
     6c8:	a1 fc 60 00 00       	mov    0x60fc,%eax
     6cd:	c7 44 24 04 c5 42 00 	movl   $0x42c5,0x4(%esp)
     6d4:	00 
     6d5:	89 04 24             	mov    %eax,(%esp)
     6d8:	e8 73 36 00 00       	call   3d50 <printf>

  fd = open("big", O_CREATE|O_RDWR);
     6dd:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     6e4:	00 
     6e5:	c7 04 24 3f 43 00 00 	movl   $0x433f,(%esp)
     6ec:	e8 61 35 00 00       	call   3c52 <open>
  if(fd < 0){
     6f1:	85 c0                	test   %eax,%eax
{
  int i, fd, n;

  printf(stdout, "big files test\n");

  fd = open("big", O_CREATE|O_RDWR);
     6f3:	89 c6                	mov    %eax,%esi
  if(fd < 0){
     6f5:	0f 88 7a 01 00 00    	js     875 <writetest1+0x1b5>
     6fb:	31 db                	xor    %ebx,%ebx
     6fd:	8d 76 00             	lea    0x0(%esi),%esi
    exit();
  }

  for(i = 0; i < MAXFILE; i++){
    ((int*)buf)[0] = i;
    if(write(fd, buf, 512) != 512){
     700:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
     707:	00 
     708:	c7 44 24 04 e0 88 00 	movl   $0x88e0,0x4(%esp)
     70f:	00 
     710:	89 34 24             	mov    %esi,(%esp)
    printf(stdout, "error: creat big failed!\n");
    exit();
  }

  for(i = 0; i < MAXFILE; i++){
    ((int*)buf)[0] = i;
     713:	89 1d e0 88 00 00    	mov    %ebx,0x88e0
    if(write(fd, buf, 512) != 512){
     719:	e8 14 35 00 00       	call   3c32 <write>
     71e:	3d 00 02 00 00       	cmp    $0x200,%eax
     723:	0f 85 b2 00 00 00    	jne    7db <writetest1+0x11b>
  if(fd < 0){
    printf(stdout, "error: creat big failed!\n");
    exit();
  }

  for(i = 0; i < MAXFILE; i++){
     729:	83 c3 01             	add    $0x1,%ebx
     72c:	81 fb 8c 00 00 00    	cmp    $0x8c,%ebx
     732:	75 cc                	jne    700 <writetest1+0x40>
      printf(stdout, "error: write big file failed\n", i);
      exit();
    }
  }

  close(fd);
     734:	89 34 24             	mov    %esi,(%esp)
     737:	e8 fe 34 00 00       	call   3c3a <close>

  fd = open("big", O_RDONLY);
     73c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     743:	00 
     744:	c7 04 24 3f 43 00 00 	movl   $0x433f,(%esp)
     74b:	e8 02 35 00 00       	call   3c52 <open>
  if(fd < 0){
     750:	85 c0                	test   %eax,%eax
    }
  }

  close(fd);

  fd = open("big", O_RDONLY);
     752:	89 c6                	mov    %eax,%esi
  if(fd < 0){
     754:	0f 88 01 01 00 00    	js     85b <writetest1+0x19b>
     75a:	31 db                	xor    %ebx,%ebx
     75c:	eb 1d                	jmp    77b <writetest1+0xbb>
     75e:	66 90                	xchg   %ax,%ax
      if(n == MAXFILE - 1){
        printf(stdout, "read only %d blocks from big", n);
        exit();
      }
      break;
    } else if(i != 512){
     760:	3d 00 02 00 00       	cmp    $0x200,%eax
     765:	0f 85 b0 00 00 00    	jne    81b <writetest1+0x15b>
      printf(stdout, "read failed %d\n", i);
      exit();
    }
    if(((int*)buf)[0] != n){
     76b:	a1 e0 88 00 00       	mov    0x88e0,%eax
     770:	39 d8                	cmp    %ebx,%eax
     772:	0f 85 81 00 00 00    	jne    7f9 <writetest1+0x139>
      printf(stdout, "read content of block %d is %d\n",
             n, ((int*)buf)[0]);
      exit();
    }
    n++;
     778:	83 c3 01             	add    $0x1,%ebx
    exit();
  }

  n = 0;
  for(;;){
    i = read(fd, buf, 512);
     77b:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
     782:	00 
     783:	c7 44 24 04 e0 88 00 	movl   $0x88e0,0x4(%esp)
     78a:	00 
     78b:	89 34 24             	mov    %esi,(%esp)
     78e:	e8 97 34 00 00       	call   3c2a <read>
    if(i == 0){
     793:	85 c0                	test   %eax,%eax
     795:	75 c9                	jne    760 <writetest1+0xa0>
      if(n == MAXFILE - 1){
     797:	81 fb 8b 00 00 00    	cmp    $0x8b,%ebx
     79d:	0f 84 96 00 00 00    	je     839 <writetest1+0x179>
             n, ((int*)buf)[0]);
      exit();
    }
    n++;
  }
  close(fd);
     7a3:	89 34 24             	mov    %esi,(%esp)
     7a6:	e8 8f 34 00 00       	call   3c3a <close>
  if(unlink("big") < 0){
     7ab:	c7 04 24 3f 43 00 00 	movl   $0x433f,(%esp)
     7b2:	e8 ab 34 00 00       	call   3c62 <unlink>
     7b7:	85 c0                	test   %eax,%eax
     7b9:	0f 88 d0 00 00 00    	js     88f <writetest1+0x1cf>
    printf(stdout, "unlink big failed\n");
    exit();
  }
  printf(stdout, "big files ok\n");
     7bf:	a1 fc 60 00 00       	mov    0x60fc,%eax
     7c4:	c7 44 24 04 66 43 00 	movl   $0x4366,0x4(%esp)
     7cb:	00 
     7cc:	89 04 24             	mov    %eax,(%esp)
     7cf:	e8 7c 35 00 00       	call   3d50 <printf>
}
     7d4:	83 c4 10             	add    $0x10,%esp
     7d7:	5b                   	pop    %ebx
     7d8:	5e                   	pop    %esi
     7d9:	5d                   	pop    %ebp
     7da:	c3                   	ret    
  }

  for(i = 0; i < MAXFILE; i++){
    ((int*)buf)[0] = i;
    if(write(fd, buf, 512) != 512){
      printf(stdout, "error: write big file failed\n", i);
     7db:	a1 fc 60 00 00       	mov    0x60fc,%eax
     7e0:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     7e4:	c7 44 24 04 ef 42 00 	movl   $0x42ef,0x4(%esp)
     7eb:	00 
     7ec:	89 04 24             	mov    %eax,(%esp)
     7ef:	e8 5c 35 00 00       	call   3d50 <printf>
      exit();
     7f4:	e8 19 34 00 00       	call   3c12 <exit>
    } else if(i != 512){
      printf(stdout, "read failed %d\n", i);
      exit();
    }
    if(((int*)buf)[0] != n){
      printf(stdout, "read content of block %d is %d\n",
     7f9:	89 44 24 0c          	mov    %eax,0xc(%esp)
     7fd:	a1 fc 60 00 00       	mov    0x60fc,%eax
     802:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     806:	c7 44 24 04 1c 51 00 	movl   $0x511c,0x4(%esp)
     80d:	00 
     80e:	89 04 24             	mov    %eax,(%esp)
     811:	e8 3a 35 00 00       	call   3d50 <printf>
             n, ((int*)buf)[0]);
      exit();
     816:	e8 f7 33 00 00       	call   3c12 <exit>
        printf(stdout, "read only %d blocks from big", n);
        exit();
      }
      break;
    } else if(i != 512){
      printf(stdout, "read failed %d\n", i);
     81b:	89 44 24 08          	mov    %eax,0x8(%esp)
     81f:	a1 fc 60 00 00       	mov    0x60fc,%eax
     824:	c7 44 24 04 43 43 00 	movl   $0x4343,0x4(%esp)
     82b:	00 
     82c:	89 04 24             	mov    %eax,(%esp)
     82f:	e8 1c 35 00 00       	call   3d50 <printf>
      exit();
     834:	e8 d9 33 00 00       	call   3c12 <exit>
  n = 0;
  for(;;){
    i = read(fd, buf, 512);
    if(i == 0){
      if(n == MAXFILE - 1){
        printf(stdout, "read only %d blocks from big", n);
     839:	a1 fc 60 00 00       	mov    0x60fc,%eax
     83e:	c7 44 24 08 8b 00 00 	movl   $0x8b,0x8(%esp)
     845:	00 
     846:	c7 44 24 04 26 43 00 	movl   $0x4326,0x4(%esp)
     84d:	00 
     84e:	89 04 24             	mov    %eax,(%esp)
     851:	e8 fa 34 00 00       	call   3d50 <printf>
        exit();
     856:	e8 b7 33 00 00       	call   3c12 <exit>

  close(fd);

  fd = open("big", O_RDONLY);
  if(fd < 0){
    printf(stdout, "error: open big failed!\n");
     85b:	a1 fc 60 00 00       	mov    0x60fc,%eax
     860:	c7 44 24 04 0d 43 00 	movl   $0x430d,0x4(%esp)
     867:	00 
     868:	89 04 24             	mov    %eax,(%esp)
     86b:	e8 e0 34 00 00       	call   3d50 <printf>
    exit();
     870:	e8 9d 33 00 00       	call   3c12 <exit>

  printf(stdout, "big files test\n");

  fd = open("big", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(stdout, "error: creat big failed!\n");
     875:	a1 fc 60 00 00       	mov    0x60fc,%eax
     87a:	c7 44 24 04 d5 42 00 	movl   $0x42d5,0x4(%esp)
     881:	00 
     882:	89 04 24             	mov    %eax,(%esp)
     885:	e8 c6 34 00 00       	call   3d50 <printf>
    exit();
     88a:	e8 83 33 00 00       	call   3c12 <exit>
    }
    n++;
  }
  close(fd);
  if(unlink("big") < 0){
    printf(stdout, "unlink big failed\n");
     88f:	a1 fc 60 00 00       	mov    0x60fc,%eax
     894:	c7 44 24 04 53 43 00 	movl   $0x4353,0x4(%esp)
     89b:	00 
     89c:	89 04 24             	mov    %eax,(%esp)
     89f:	e8 ac 34 00 00       	call   3d50 <printf>
    exit();
     8a4:	e8 69 33 00 00       	call   3c12 <exit>
     8a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000008b0 <createtest>:
  printf(stdout, "big files ok\n");
}

void
createtest(void)
{
     8b0:	55                   	push   %ebp
     8b1:	89 e5                	mov    %esp,%ebp
     8b3:	53                   	push   %ebx
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");

  name[0] = 'a';
  name[2] = '\0';
     8b4:	bb 30 00 00 00       	mov    $0x30,%ebx
  printf(stdout, "big files ok\n");
}

void
createtest(void)
{
     8b9:	83 ec 14             	sub    $0x14,%esp
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");
     8bc:	a1 fc 60 00 00       	mov    0x60fc,%eax
     8c1:	c7 44 24 04 3c 51 00 	movl   $0x513c,0x4(%esp)
     8c8:	00 
     8c9:	89 04 24             	mov    %eax,(%esp)
     8cc:	e8 7f 34 00 00       	call   3d50 <printf>

  name[0] = 'a';
     8d1:	c6 05 e0 a8 00 00 61 	movb   $0x61,0xa8e0
  name[2] = '\0';
     8d8:	c6 05 e2 a8 00 00 00 	movb   $0x0,0xa8e2
     8df:	90                   	nop
  for(i = 0; i < 52; i++){
    name[1] = '0' + i;
    fd = open(name, O_CREATE|O_RDWR);
     8e0:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     8e7:	00 
     8e8:	c7 04 24 e0 a8 00 00 	movl   $0xa8e0,(%esp)
  printf(stdout, "many creates, followed by unlink test\n");

  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
    name[1] = '0' + i;
     8ef:	88 1d e1 a8 00 00    	mov    %bl,0xa8e1
     8f5:	83 c3 01             	add    $0x1,%ebx
    fd = open(name, O_CREATE|O_RDWR);
     8f8:	e8 55 33 00 00       	call   3c52 <open>
    close(fd);
     8fd:	89 04 24             	mov    %eax,(%esp)
     900:	e8 35 33 00 00       	call   3c3a <close>

  printf(stdout, "many creates, followed by unlink test\n");

  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
     905:	80 fb 64             	cmp    $0x64,%bl
     908:	75 d6                	jne    8e0 <createtest+0x30>
    name[1] = '0' + i;
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
     90a:	c6 05 e0 a8 00 00 61 	movb   $0x61,0xa8e0
  name[2] = '\0';
     911:	bb 30 00 00 00       	mov    $0x30,%ebx
     916:	c6 05 e2 a8 00 00 00 	movb   $0x0,0xa8e2
     91d:	8d 76 00             	lea    0x0(%esi),%esi
  for(i = 0; i < 52; i++){
    name[1] = '0' + i;
     920:	88 1d e1 a8 00 00    	mov    %bl,0xa8e1
     926:	83 c3 01             	add    $0x1,%ebx
    unlink(name);
     929:	c7 04 24 e0 a8 00 00 	movl   $0xa8e0,(%esp)
     930:	e8 2d 33 00 00       	call   3c62 <unlink>
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
     935:	80 fb 64             	cmp    $0x64,%bl
     938:	75 e6                	jne    920 <createtest+0x70>
    name[1] = '0' + i;
    unlink(name);
  }
  printf(stdout, "many creates, followed by unlink; ok\n");
     93a:	a1 fc 60 00 00       	mov    0x60fc,%eax
     93f:	c7 44 24 04 64 51 00 	movl   $0x5164,0x4(%esp)
     946:	00 
     947:	89 04 24             	mov    %eax,(%esp)
     94a:	e8 01 34 00 00       	call   3d50 <printf>
}
     94f:	83 c4 14             	add    $0x14,%esp
     952:	5b                   	pop    %ebx
     953:	5d                   	pop    %ebp
     954:	c3                   	ret    
     955:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000960 <dirtest>:

void dirtest(void)
{
     960:	55                   	push   %ebp
     961:	89 e5                	mov    %esp,%ebp
     963:	83 ec 18             	sub    $0x18,%esp
  printf(stdout, "mkdir test\n");
     966:	a1 fc 60 00 00       	mov    0x60fc,%eax
     96b:	c7 44 24 04 74 43 00 	movl   $0x4374,0x4(%esp)
     972:	00 
     973:	89 04 24             	mov    %eax,(%esp)
     976:	e8 d5 33 00 00       	call   3d50 <printf>

  if(mkdir("dir0") < 0){
     97b:	c7 04 24 80 43 00 00 	movl   $0x4380,(%esp)
     982:	e8 f3 32 00 00       	call   3c7a <mkdir>
     987:	85 c0                	test   %eax,%eax
     989:	78 4b                	js     9d6 <dirtest+0x76>
    printf(stdout, "mkdir failed\n");
    exit();
  }

  if(chdir("dir0") < 0){
     98b:	c7 04 24 80 43 00 00 	movl   $0x4380,(%esp)
     992:	e8 eb 32 00 00       	call   3c82 <chdir>
     997:	85 c0                	test   %eax,%eax
     999:	0f 88 85 00 00 00    	js     a24 <dirtest+0xc4>
    printf(stdout, "chdir dir0 failed\n");
    exit();
  }

  if(chdir("..") < 0){
     99f:	c7 04 24 25 49 00 00 	movl   $0x4925,(%esp)
     9a6:	e8 d7 32 00 00       	call   3c82 <chdir>
     9ab:	85 c0                	test   %eax,%eax
     9ad:	78 5b                	js     a0a <dirtest+0xaa>
    printf(stdout, "chdir .. failed\n");
    exit();
  }

  if(unlink("dir0") < 0){
     9af:	c7 04 24 80 43 00 00 	movl   $0x4380,(%esp)
     9b6:	e8 a7 32 00 00       	call   3c62 <unlink>
     9bb:	85 c0                	test   %eax,%eax
     9bd:	78 31                	js     9f0 <dirtest+0x90>
    printf(stdout, "unlink dir0 failed\n");
    exit();
  }
  printf(stdout, "mkdir test ok\n");
     9bf:	a1 fc 60 00 00       	mov    0x60fc,%eax
     9c4:	c7 44 24 04 bd 43 00 	movl   $0x43bd,0x4(%esp)
     9cb:	00 
     9cc:	89 04 24             	mov    %eax,(%esp)
     9cf:	e8 7c 33 00 00       	call   3d50 <printf>
}
     9d4:	c9                   	leave  
     9d5:	c3                   	ret    
void dirtest(void)
{
  printf(stdout, "mkdir test\n");

  if(mkdir("dir0") < 0){
    printf(stdout, "mkdir failed\n");
     9d6:	a1 fc 60 00 00       	mov    0x60fc,%eax
     9db:	c7 44 24 04 b0 40 00 	movl   $0x40b0,0x4(%esp)
     9e2:	00 
     9e3:	89 04 24             	mov    %eax,(%esp)
     9e6:	e8 65 33 00 00       	call   3d50 <printf>
    exit();
     9eb:	e8 22 32 00 00       	call   3c12 <exit>
    printf(stdout, "chdir .. failed\n");
    exit();
  }

  if(unlink("dir0") < 0){
    printf(stdout, "unlink dir0 failed\n");
     9f0:	a1 fc 60 00 00       	mov    0x60fc,%eax
     9f5:	c7 44 24 04 a9 43 00 	movl   $0x43a9,0x4(%esp)
     9fc:	00 
     9fd:	89 04 24             	mov    %eax,(%esp)
     a00:	e8 4b 33 00 00       	call   3d50 <printf>
    exit();
     a05:	e8 08 32 00 00       	call   3c12 <exit>
    printf(stdout, "chdir dir0 failed\n");
    exit();
  }

  if(chdir("..") < 0){
    printf(stdout, "chdir .. failed\n");
     a0a:	a1 fc 60 00 00       	mov    0x60fc,%eax
     a0f:	c7 44 24 04 98 43 00 	movl   $0x4398,0x4(%esp)
     a16:	00 
     a17:	89 04 24             	mov    %eax,(%esp)
     a1a:	e8 31 33 00 00       	call   3d50 <printf>
    exit();
     a1f:	e8 ee 31 00 00       	call   3c12 <exit>
    printf(stdout, "mkdir failed\n");
    exit();
  }

  if(chdir("dir0") < 0){
    printf(stdout, "chdir dir0 failed\n");
     a24:	a1 fc 60 00 00       	mov    0x60fc,%eax
     a29:	c7 44 24 04 85 43 00 	movl   $0x4385,0x4(%esp)
     a30:	00 
     a31:	89 04 24             	mov    %eax,(%esp)
     a34:	e8 17 33 00 00       	call   3d50 <printf>
    exit();
     a39:	e8 d4 31 00 00       	call   3c12 <exit>
     a3e:	66 90                	xchg   %ax,%ax

00000a40 <exectest>:
  printf(stdout, "mkdir test ok\n");
}

void
exectest(void)
{
     a40:	55                   	push   %ebp
     a41:	89 e5                	mov    %esp,%ebp
     a43:	83 ec 18             	sub    $0x18,%esp
  printf(stdout, "exec test\n");
     a46:	a1 fc 60 00 00       	mov    0x60fc,%eax
     a4b:	c7 44 24 04 cc 43 00 	movl   $0x43cc,0x4(%esp)
     a52:	00 
     a53:	89 04 24             	mov    %eax,(%esp)
     a56:	e8 f5 32 00 00       	call   3d50 <printf>
  if(exec("echo", echoargv) < 0){
     a5b:	c7 44 24 04 00 61 00 	movl   $0x6100,0x4(%esp)
     a62:	00 
     a63:	c7 04 24 95 41 00 00 	movl   $0x4195,(%esp)
     a6a:	e8 db 31 00 00       	call   3c4a <exec>
     a6f:	85 c0                	test   %eax,%eax
     a71:	78 02                	js     a75 <exectest+0x35>
    printf(stdout, "exec echo failed\n");
    exit();
  }
}
     a73:	c9                   	leave  
     a74:	c3                   	ret    
void
exectest(void)
{
  printf(stdout, "exec test\n");
  if(exec("echo", echoargv) < 0){
    printf(stdout, "exec echo failed\n");
     a75:	a1 fc 60 00 00       	mov    0x60fc,%eax
     a7a:	c7 44 24 04 d7 43 00 	movl   $0x43d7,0x4(%esp)
     a81:	00 
     a82:	89 04 24             	mov    %eax,(%esp)
     a85:	e8 c6 32 00 00       	call   3d50 <printf>
    exit();
     a8a:	e8 83 31 00 00       	call   3c12 <exit>
     a8f:	90                   	nop

00000a90 <pipe1>:

// simple fork and pipe read/write

void
pipe1(void)
{
     a90:	55                   	push   %ebp
     a91:	89 e5                	mov    %esp,%ebp
     a93:	57                   	push   %edi
     a94:	56                   	push   %esi
     a95:	53                   	push   %ebx
     a96:	83 ec 3c             	sub    $0x3c,%esp
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
     a99:	8d 45 e0             	lea    -0x20(%ebp),%eax
     a9c:	89 04 24             	mov    %eax,(%esp)
     a9f:	e8 7e 31 00 00       	call   3c22 <pipe>
     aa4:	85 c0                	test   %eax,%eax
     aa6:	0f 85 46 01 00 00    	jne    bf2 <pipe1+0x162>
    printf(1, "pipe() failed\n");
    exit();
  }
  pid = fork();
     aac:	e8 59 31 00 00       	call   3c0a <fork>
  seq = 0;
  if(pid == 0){
     ab1:	83 f8 00             	cmp    $0x0,%eax
     ab4:	0f 84 8c 00 00 00    	je     b46 <pipe1+0xb6>
        printf(1, "pipe1 oops 1\n");
        exit();
      }
    }
    exit();
  } else if(pid > 0){
     aba:	0f 8e 4b 01 00 00    	jle    c0b <pipe1+0x17b>
    close(fds[1]);
     ac0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    total = 0;
    cc = 1;
     ac3:	bf 01 00 00 00       	mov    $0x1,%edi
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit();
  }
  pid = fork();
  seq = 0;
     ac8:	31 db                	xor    %ebx,%ebx
        exit();
      }
    }
    exit();
  } else if(pid > 0){
    close(fds[1]);
     aca:	89 04 24             	mov    %eax,(%esp)
     acd:	e8 68 31 00 00       	call   3c3a <close>
    total = 0;
     ad2:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
     ad9:	8b 45 e0             	mov    -0x20(%ebp),%eax
     adc:	89 7c 24 08          	mov    %edi,0x8(%esp)
     ae0:	c7 44 24 04 e0 88 00 	movl   $0x88e0,0x4(%esp)
     ae7:	00 
     ae8:	89 04 24             	mov    %eax,(%esp)
     aeb:	e8 3a 31 00 00       	call   3c2a <read>
     af0:	85 c0                	test   %eax,%eax
     af2:	0f 8e ab 00 00 00    	jle    ba3 <pipe1+0x113>
}

// simple fork and pipe read/write

void
pipe1(void)
     af8:	89 d9                	mov    %ebx,%ecx
     afa:	8d 34 03             	lea    (%ebx,%eax,1),%esi
     afd:	f7 d9                	neg    %ecx
     aff:	90                   	nop
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     b00:	0f b6 94 0b e0 88 00 	movzbl 0x88e0(%ebx,%ecx,1),%edx
     b07:	00 
     b08:	31 da                	xor    %ebx,%edx
     b0a:	83 c3 01             	add    $0x1,%ebx
     b0d:	84 d2                	test   %dl,%dl
     b0f:	75 19                	jne    b2a <pipe1+0x9a>
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
     b11:	39 f3                	cmp    %esi,%ebx
     b13:	75 eb                	jne    b00 <pipe1+0x70>
          printf(1, "pipe1 oops 2\n");
          return;
        }
      }
      total += n;
      cc = cc * 2;
     b15:	01 ff                	add    %edi,%edi
        if((buf[i] & 0xff) != (seq++ & 0xff)){
          printf(1, "pipe1 oops 2\n");
          return;
        }
      }
      total += n;
     b17:	01 45 d4             	add    %eax,-0x2c(%ebp)
      cc = cc * 2;
      if(cc > sizeof(buf))
        cc = sizeof(buf);
     b1a:	81 ff 01 20 00 00    	cmp    $0x2001,%edi
     b20:	b8 00 20 00 00       	mov    $0x2000,%eax
     b25:	0f 43 f8             	cmovae %eax,%edi
     b28:	eb af                	jmp    ad9 <pipe1+0x49>
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
        if((buf[i] & 0xff) != (seq++ & 0xff)){
          printf(1, "pipe1 oops 2\n");
     b2a:	c7 44 24 04 06 44 00 	movl   $0x4406,0x4(%esp)
     b31:	00 
     b32:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b39:	e8 12 32 00 00       	call   3d50 <printf>
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
}
     b3e:	83 c4 3c             	add    $0x3c,%esp
     b41:	5b                   	pop    %ebx
     b42:	5e                   	pop    %esi
     b43:	5f                   	pop    %edi
     b44:	5d                   	pop    %ebp
     b45:	c3                   	ret    
    exit();
  }
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
     b46:	8b 45 e0             	mov    -0x20(%ebp),%eax
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit();
  }
  pid = fork();
  seq = 0;
     b49:	31 f6                	xor    %esi,%esi
  if(pid == 0){
    close(fds[0]);
     b4b:	89 04 24             	mov    %eax,(%esp)
     b4e:	e8 e7 30 00 00       	call   3c3a <close>
}

// simple fork and pipe read/write

void
pipe1(void)
     b53:	89 f0                	mov    %esi,%eax
     b55:	89 f3                	mov    %esi,%ebx
     b57:	8d 96 09 04 00 00    	lea    0x409(%esi),%edx
     b5d:	f7 d8                	neg    %eax
     b5f:	90                   	nop
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
        buf[i] = seq++;
     b60:	88 9c 18 e0 88 00 00 	mov    %bl,0x88e0(%eax,%ebx,1)
     b67:	83 c3 01             	add    $0x1,%ebx
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
     b6a:	39 d3                	cmp    %edx,%ebx
     b6c:	75 f2                	jne    b60 <pipe1+0xd0>
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
     b6e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     b71:	89 de                	mov    %ebx,%esi
     b73:	c7 44 24 08 09 04 00 	movl   $0x409,0x8(%esp)
     b7a:	00 
     b7b:	c7 44 24 04 e0 88 00 	movl   $0x88e0,0x4(%esp)
     b82:	00 
     b83:	89 04 24             	mov    %eax,(%esp)
     b86:	e8 a7 30 00 00       	call   3c32 <write>
     b8b:	3d 09 04 00 00       	cmp    $0x409,%eax
     b90:	0f 85 8e 00 00 00    	jne    c24 <pipe1+0x194>
  }
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
     b96:	81 fb 2d 14 00 00    	cmp    $0x142d,%ebx
     b9c:	75 b5                	jne    b53 <pipe1+0xc3>
      if(cc > sizeof(buf))
        cc = sizeof(buf);
    }
    if(total != 5 * 1033){
      printf(1, "pipe1 oops 3 total %d\n", total);
      exit();
     b9e:	e8 6f 30 00 00       	call   3c12 <exit>
      total += n;
      cc = cc * 2;
      if(cc > sizeof(buf))
        cc = sizeof(buf);
    }
    if(total != 5 * 1033){
     ba3:	81 7d d4 2d 14 00 00 	cmpl   $0x142d,-0x2c(%ebp)
     baa:	75 29                	jne    bd5 <pipe1+0x145>
      printf(1, "pipe1 oops 3 total %d\n", total);
      exit();
    }
    close(fds[0]);
     bac:	8b 45 e0             	mov    -0x20(%ebp),%eax
     baf:	89 04 24             	mov    %eax,(%esp)
     bb2:	e8 83 30 00 00       	call   3c3a <close>
    wait();
     bb7:	e8 5e 30 00 00       	call   3c1a <wait>
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
     bbc:	c7 44 24 04 2b 44 00 	movl   $0x442b,0x4(%esp)
     bc3:	00 
     bc4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     bcb:	e8 80 31 00 00       	call   3d50 <printf>
     bd0:	e9 69 ff ff ff       	jmp    b3e <pipe1+0xae>
      cc = cc * 2;
      if(cc > sizeof(buf))
        cc = sizeof(buf);
    }
    if(total != 5 * 1033){
      printf(1, "pipe1 oops 3 total %d\n", total);
     bd5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     bd8:	c7 44 24 04 14 44 00 	movl   $0x4414,0x4(%esp)
     bdf:	00 
     be0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     be7:	89 44 24 08          	mov    %eax,0x8(%esp)
     beb:	e8 60 31 00 00       	call   3d50 <printf>
     bf0:	eb ac                	jmp    b9e <pipe1+0x10e>
{
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
     bf2:	c7 44 24 04 e9 43 00 	movl   $0x43e9,0x4(%esp)
     bf9:	00 
     bfa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     c01:	e8 4a 31 00 00       	call   3d50 <printf>
    exit();
     c06:	e8 07 30 00 00       	call   3c12 <exit>
      exit();
    }
    close(fds[0]);
    wait();
  } else {
    printf(1, "fork() failed\n");
     c0b:	c7 44 24 04 35 44 00 	movl   $0x4435,0x4(%esp)
     c12:	00 
     c13:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     c1a:	e8 31 31 00 00       	call   3d50 <printf>
    exit();
     c1f:	e8 ee 2f 00 00       	call   3c12 <exit>
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
        printf(1, "pipe1 oops 1\n");
     c24:	c7 44 24 04 f8 43 00 	movl   $0x43f8,0x4(%esp)
     c2b:	00 
     c2c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     c33:	e8 18 31 00 00       	call   3d50 <printf>
        exit();
     c38:	e8 d5 2f 00 00       	call   3c12 <exit>
     c3d:	8d 76 00             	lea    0x0(%esi),%esi

00000c40 <preempt>:
}

// meant to be run w/ at most two CPUs
void
preempt(void)
{
     c40:	55                   	push   %ebp
     c41:	89 e5                	mov    %esp,%ebp
     c43:	57                   	push   %edi
     c44:	56                   	push   %esi
     c45:	53                   	push   %ebx
     c46:	83 ec 2c             	sub    $0x2c,%esp
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
     c49:	c7 44 24 04 44 44 00 	movl   $0x4444,0x4(%esp)
     c50:	00 
     c51:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     c58:	e8 f3 30 00 00       	call   3d50 <printf>
  pid1 = fork();
     c5d:	e8 a8 2f 00 00       	call   3c0a <fork>
  if(pid1 == 0)
     c62:	85 c0                	test   %eax,%eax
{
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
  pid1 = fork();
     c64:	89 c7                	mov    %eax,%edi
  if(pid1 == 0)
     c66:	75 02                	jne    c6a <preempt+0x2a>
     c68:	eb fe                	jmp    c68 <preempt+0x28>
     c6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    for(;;)
      ;

  pid2 = fork();
     c70:	e8 95 2f 00 00       	call   3c0a <fork>
  if(pid2 == 0)
     c75:	85 c0                	test   %eax,%eax
  pid1 = fork();
  if(pid1 == 0)
    for(;;)
      ;

  pid2 = fork();
     c77:	89 c6                	mov    %eax,%esi
  if(pid2 == 0)
     c79:	75 02                	jne    c7d <preempt+0x3d>
     c7b:	eb fe                	jmp    c7b <preempt+0x3b>
    for(;;)
      ;

  pipe(pfds);
     c7d:	8d 45 e0             	lea    -0x20(%ebp),%eax
     c80:	89 04 24             	mov    %eax,(%esp)
     c83:	e8 9a 2f 00 00       	call   3c22 <pipe>
  pid3 = fork();
     c88:	e8 7d 2f 00 00       	call   3c0a <fork>
  if(pid3 == 0){
     c8d:	85 c0                	test   %eax,%eax
  if(pid2 == 0)
    for(;;)
      ;

  pipe(pfds);
  pid3 = fork();
     c8f:	89 c3                	mov    %eax,%ebx
  if(pid3 == 0){
     c91:	75 4c                	jne    cdf <preempt+0x9f>
    close(pfds[0]);
     c93:	8b 45 e0             	mov    -0x20(%ebp),%eax
     c96:	89 04 24             	mov    %eax,(%esp)
     c99:	e8 9c 2f 00 00       	call   3c3a <close>
    if(write(pfds[1], "x", 1) != 1)
     c9e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ca1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     ca8:	00 
     ca9:	c7 44 24 04 09 4a 00 	movl   $0x4a09,0x4(%esp)
     cb0:	00 
     cb1:	89 04 24             	mov    %eax,(%esp)
     cb4:	e8 79 2f 00 00       	call   3c32 <write>
     cb9:	83 f8 01             	cmp    $0x1,%eax
     cbc:	74 14                	je     cd2 <preempt+0x92>
      printf(1, "preempt write error");
     cbe:	c7 44 24 04 4e 44 00 	movl   $0x444e,0x4(%esp)
     cc5:	00 
     cc6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     ccd:	e8 7e 30 00 00       	call   3d50 <printf>
    close(pfds[1]);
     cd2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     cd5:	89 04 24             	mov    %eax,(%esp)
     cd8:	e8 5d 2f 00 00       	call   3c3a <close>
     cdd:	eb fe                	jmp    cdd <preempt+0x9d>
    for(;;)
      ;
  }

  close(pfds[1]);
     cdf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ce2:	89 04 24             	mov    %eax,(%esp)
     ce5:	e8 50 2f 00 00       	call   3c3a <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     cea:	8b 45 e0             	mov    -0x20(%ebp),%eax
     ced:	c7 44 24 08 00 20 00 	movl   $0x2000,0x8(%esp)
     cf4:	00 
     cf5:	c7 44 24 04 e0 88 00 	movl   $0x88e0,0x4(%esp)
     cfc:	00 
     cfd:	89 04 24             	mov    %eax,(%esp)
     d00:	e8 25 2f 00 00       	call   3c2a <read>
     d05:	83 f8 01             	cmp    $0x1,%eax
     d08:	74 1c                	je     d26 <preempt+0xe6>
    printf(1, "preempt read error");
     d0a:	c7 44 24 04 62 44 00 	movl   $0x4462,0x4(%esp)
     d11:	00 
     d12:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     d19:	e8 32 30 00 00       	call   3d50 <printf>
  printf(1, "wait... ");
  wait();
  wait();
  wait();
  printf(1, "preempt ok\n");
}
     d1e:	83 c4 2c             	add    $0x2c,%esp
     d21:	5b                   	pop    %ebx
     d22:	5e                   	pop    %esi
     d23:	5f                   	pop    %edi
     d24:	5d                   	pop    %ebp
     d25:	c3                   	ret    
  close(pfds[1]);
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    printf(1, "preempt read error");
    return;
  }
  close(pfds[0]);
     d26:	8b 45 e0             	mov    -0x20(%ebp),%eax
     d29:	89 04 24             	mov    %eax,(%esp)
     d2c:	e8 09 2f 00 00       	call   3c3a <close>
  printf(1, "kill... ");
     d31:	c7 44 24 04 75 44 00 	movl   $0x4475,0x4(%esp)
     d38:	00 
     d39:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     d40:	e8 0b 30 00 00       	call   3d50 <printf>
  kill(pid1);
     d45:	89 3c 24             	mov    %edi,(%esp)
     d48:	e8 f5 2e 00 00       	call   3c42 <kill>
  kill(pid2);
     d4d:	89 34 24             	mov    %esi,(%esp)
     d50:	e8 ed 2e 00 00       	call   3c42 <kill>
  kill(pid3);
     d55:	89 1c 24             	mov    %ebx,(%esp)
     d58:	e8 e5 2e 00 00       	call   3c42 <kill>
  printf(1, "wait... ");
     d5d:	c7 44 24 04 7e 44 00 	movl   $0x447e,0x4(%esp)
     d64:	00 
     d65:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     d6c:	e8 df 2f 00 00       	call   3d50 <printf>
  wait();
     d71:	e8 a4 2e 00 00       	call   3c1a <wait>
  wait();
     d76:	e8 9f 2e 00 00       	call   3c1a <wait>
     d7b:	90                   	nop
     d7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  wait();
     d80:	e8 95 2e 00 00       	call   3c1a <wait>
  printf(1, "preempt ok\n");
     d85:	c7 44 24 04 87 44 00 	movl   $0x4487,0x4(%esp)
     d8c:	00 
     d8d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     d94:	e8 b7 2f 00 00       	call   3d50 <printf>
     d99:	eb 83                	jmp    d1e <preempt+0xde>
     d9b:	90                   	nop
     d9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000da0 <exitwait>:
}

// try to find any races between exit and wait
void
exitwait(void)
{
     da0:	55                   	push   %ebp
     da1:	89 e5                	mov    %esp,%ebp
     da3:	56                   	push   %esi
     da4:	be 64 00 00 00       	mov    $0x64,%esi
     da9:	53                   	push   %ebx
     daa:	83 ec 10             	sub    $0x10,%esp
     dad:	eb 13                	jmp    dc2 <exitwait+0x22>
     daf:	90                   	nop
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
      return;
    }
    if(pid){
     db0:	74 79                	je     e2b <exitwait+0x8b>
      if(wait() != pid){
     db2:	e8 63 2e 00 00       	call   3c1a <wait>
     db7:	39 d8                	cmp    %ebx,%eax
     db9:	75 35                	jne    df0 <exitwait+0x50>
void
exitwait(void)
{
  int i, pid;

  for(i = 0; i < 100; i++){
     dbb:	83 ee 01             	sub    $0x1,%esi
     dbe:	66 90                	xchg   %ax,%ax
     dc0:	74 4e                	je     e10 <exitwait+0x70>
    pid = fork();
     dc2:	e8 43 2e 00 00       	call   3c0a <fork>
    if(pid < 0){
     dc7:	83 f8 00             	cmp    $0x0,%eax
exitwait(void)
{
  int i, pid;

  for(i = 0; i < 100; i++){
    pid = fork();
     dca:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
     dcc:	7d e2                	jge    db0 <exitwait+0x10>
      printf(1, "fork failed\n");
     dce:	c7 44 24 04 f1 4f 00 	movl   $0x4ff1,0x4(%esp)
     dd5:	00 
     dd6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     ddd:	e8 6e 2f 00 00       	call   3d50 <printf>
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
}
     de2:	83 c4 10             	add    $0x10,%esp
     de5:	5b                   	pop    %ebx
     de6:	5e                   	pop    %esi
     de7:	5d                   	pop    %ebp
     de8:	c3                   	ret    
     de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      printf(1, "fork failed\n");
      return;
    }
    if(pid){
      if(wait() != pid){
        printf(1, "wait wrong pid\n");
     df0:	c7 44 24 04 93 44 00 	movl   $0x4493,0x4(%esp)
     df7:	00 
     df8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     dff:	e8 4c 2f 00 00       	call   3d50 <printf>
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
}
     e04:	83 c4 10             	add    $0x10,%esp
     e07:	5b                   	pop    %ebx
     e08:	5e                   	pop    %esi
     e09:	5d                   	pop    %ebp
     e0a:	c3                   	ret    
     e0b:	90                   	nop
     e0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      }
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
     e10:	c7 44 24 04 a3 44 00 	movl   $0x44a3,0x4(%esp)
     e17:	00 
     e18:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     e1f:	e8 2c 2f 00 00       	call   3d50 <printf>
}
     e24:	83 c4 10             	add    $0x10,%esp
     e27:	5b                   	pop    %ebx
     e28:	5e                   	pop    %esi
     e29:	5d                   	pop    %ebp
     e2a:	c3                   	ret    
      if(wait() != pid){
        printf(1, "wait wrong pid\n");
        return;
      }
    } else {
      exit();
     e2b:	e8 e2 2d 00 00       	call   3c12 <exit>

00000e30 <mem>:
  printf(1, "exitwait ok\n");
}

void
mem(void)
{
     e30:	55                   	push   %ebp
     e31:	89 e5                	mov    %esp,%ebp
     e33:	57                   	push   %edi
     e34:	56                   	push   %esi
     e35:	53                   	push   %ebx
  void *m1, *m2;
  int pid, ppid;

  printf(1, "mem test\n");
  ppid = getpid();
  if((pid = fork()) == 0){
     e36:	31 db                	xor    %ebx,%ebx
  printf(1, "exitwait ok\n");
}

void
mem(void)
{
     e38:	83 ec 1c             	sub    $0x1c,%esp
  void *m1, *m2;
  int pid, ppid;

  printf(1, "mem test\n");
     e3b:	c7 44 24 04 b0 44 00 	movl   $0x44b0,0x4(%esp)
     e42:	00 
     e43:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     e4a:	e8 01 2f 00 00       	call   3d50 <printf>
  ppid = getpid();
     e4f:	e8 3e 2e 00 00       	call   3c92 <getpid>
     e54:	89 c6                	mov    %eax,%esi
  if((pid = fork()) == 0){
     e56:	e8 af 2d 00 00       	call   3c0a <fork>
     e5b:	85 c0                	test   %eax,%eax
     e5d:	74 0d                	je     e6c <mem+0x3c>
     e5f:	90                   	nop
     e60:	eb 5f                	jmp    ec1 <mem+0x91>
     e62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
      *(char**)m2 = m1;
     e68:	89 18                	mov    %ebx,(%eax)
     e6a:	89 c3                	mov    %eax,%ebx

  printf(1, "mem test\n");
  ppid = getpid();
  if((pid = fork()) == 0){
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
     e6c:	c7 04 24 11 27 00 00 	movl   $0x2711,(%esp)
     e73:	e8 58 31 00 00       	call   3fd0 <malloc>
     e78:	85 c0                	test   %eax,%eax
     e7a:	75 ec                	jne    e68 <mem+0x38>
      *(char**)m2 = m1;
      m1 = m2;
    }
    while(m1){
     e7c:	85 db                	test   %ebx,%ebx
     e7e:	74 10                	je     e90 <mem+0x60>
      m2 = *(char**)m1;
     e80:	8b 3b                	mov    (%ebx),%edi
      free(m1);
     e82:	89 1c 24             	mov    %ebx,(%esp)
     e85:	e8 b6 30 00 00       	call   3f40 <free>
      m1 = m2;
     e8a:	89 fb                	mov    %edi,%ebx
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
      *(char**)m2 = m1;
      m1 = m2;
    }
    while(m1){
     e8c:	85 db                	test   %ebx,%ebx
     e8e:	75 f0                	jne    e80 <mem+0x50>
      m2 = *(char**)m1;
      free(m1);
      m1 = m2;
    }
    m1 = malloc(1024*20);
     e90:	c7 04 24 00 50 00 00 	movl   $0x5000,(%esp)
     e97:	e8 34 31 00 00       	call   3fd0 <malloc>
    if(m1 == 0){
     e9c:	85 c0                	test   %eax,%eax
     e9e:	74 30                	je     ed0 <mem+0xa0>
      printf(1, "couldn't allocate mem?!!\n");
      kill(ppid);
      exit();
    }
    free(m1);
     ea0:	89 04 24             	mov    %eax,(%esp)
     ea3:	e8 98 30 00 00       	call   3f40 <free>
    printf(1, "mem ok\n");
     ea8:	c7 44 24 04 d4 44 00 	movl   $0x44d4,0x4(%esp)
     eaf:	00 
     eb0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     eb7:	e8 94 2e 00 00       	call   3d50 <printf>
    exit();
     ebc:	e8 51 2d 00 00       	call   3c12 <exit>
  } else {
    wait();
  }
}
     ec1:	83 c4 1c             	add    $0x1c,%esp
     ec4:	5b                   	pop    %ebx
     ec5:	5e                   	pop    %esi
     ec6:	5f                   	pop    %edi
     ec7:	5d                   	pop    %ebp
    }
    free(m1);
    printf(1, "mem ok\n");
    exit();
  } else {
    wait();
     ec8:	e9 4d 2d 00 00       	jmp    3c1a <wait>
     ecd:	8d 76 00             	lea    0x0(%esi),%esi
      free(m1);
      m1 = m2;
    }
    m1 = malloc(1024*20);
    if(m1 == 0){
      printf(1, "couldn't allocate mem?!!\n");
     ed0:	c7 44 24 04 ba 44 00 	movl   $0x44ba,0x4(%esp)
     ed7:	00 
     ed8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     edf:	e8 6c 2e 00 00       	call   3d50 <printf>
      kill(ppid);
     ee4:	89 34 24             	mov    %esi,(%esp)
     ee7:	e8 56 2d 00 00       	call   3c42 <kill>
      exit();
     eec:	e8 21 2d 00 00       	call   3c12 <exit>
     ef1:	eb 0d                	jmp    f00 <sharedfd>
     ef3:	90                   	nop
     ef4:	90                   	nop
     ef5:	90                   	nop
     ef6:	90                   	nop
     ef7:	90                   	nop
     ef8:	90                   	nop
     ef9:	90                   	nop
     efa:	90                   	nop
     efb:	90                   	nop
     efc:	90                   	nop
     efd:	90                   	nop
     efe:	90                   	nop
     eff:	90                   	nop

00000f00 <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(void)
{
     f00:	55                   	push   %ebp
     f01:	89 e5                	mov    %esp,%ebp
     f03:	57                   	push   %edi
     f04:	56                   	push   %esi
     f05:	53                   	push   %ebx
     f06:	83 ec 3c             	sub    $0x3c,%esp
  int fd, pid, i, n, nc, np;
  char buf[10];

  printf(1, "sharedfd test\n");
     f09:	c7 44 24 04 dc 44 00 	movl   $0x44dc,0x4(%esp)
     f10:	00 
     f11:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f18:	e8 33 2e 00 00       	call   3d50 <printf>

  unlink("sharedfd");
     f1d:	c7 04 24 eb 44 00 00 	movl   $0x44eb,(%esp)
     f24:	e8 39 2d 00 00       	call   3c62 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
     f29:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     f30:	00 
     f31:	c7 04 24 eb 44 00 00 	movl   $0x44eb,(%esp)
     f38:	e8 15 2d 00 00       	call   3c52 <open>
  if(fd < 0){
     f3d:	85 c0                	test   %eax,%eax
  char buf[10];

  printf(1, "sharedfd test\n");

  unlink("sharedfd");
  fd = open("sharedfd", O_CREATE|O_RDWR);
     f3f:	89 c7                	mov    %eax,%edi
  if(fd < 0){
     f41:	0f 88 31 01 00 00    	js     1078 <sharedfd+0x178>
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork();
     f47:	e8 be 2c 00 00       	call   3c0a <fork>
  memset(buf, pid==0?'c':'p', sizeof(buf));
     f4c:	8d 75 de             	lea    -0x22(%ebp),%esi
     f4f:	bb e8 03 00 00       	mov    $0x3e8,%ebx
     f54:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     f5b:	00 
     f5c:	89 34 24             	mov    %esi,(%esp)
     f5f:	83 f8 01             	cmp    $0x1,%eax
  fd = open("sharedfd", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork();
     f62:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
     f65:	19 c0                	sbb    %eax,%eax
     f67:	83 e0 f3             	and    $0xfffffff3,%eax
     f6a:	83 c0 70             	add    $0x70,%eax
     f6d:	89 44 24 04          	mov    %eax,0x4(%esp)
     f71:	e8 0a 2b 00 00       	call   3a80 <memset>
     f76:	eb 05                	jmp    f7d <sharedfd+0x7d>
  for(i = 0; i < 1000; i++){
     f78:	83 eb 01             	sub    $0x1,%ebx
     f7b:	74 2d                	je     faa <sharedfd+0xaa>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
     f7d:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     f84:	00 
     f85:	89 74 24 04          	mov    %esi,0x4(%esp)
     f89:	89 3c 24             	mov    %edi,(%esp)
     f8c:	e8 a1 2c 00 00       	call   3c32 <write>
     f91:	83 f8 0a             	cmp    $0xa,%eax
     f94:	74 e2                	je     f78 <sharedfd+0x78>
      printf(1, "fstests: write sharedfd failed\n");
     f96:	c7 44 24 04 b8 51 00 	movl   $0x51b8,0x4(%esp)
     f9d:	00 
     f9e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     fa5:	e8 a6 2d 00 00       	call   3d50 <printf>
      break;
    }
  }
  if(pid == 0)
     faa:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     fad:	85 c0                	test   %eax,%eax
     faf:	0f 84 17 01 00 00    	je     10cc <sharedfd+0x1cc>
    exit();
  else
    wait();
     fb5:	e8 60 2c 00 00       	call   3c1a <wait>
  close(fd);
  fd = open("sharedfd", 0);
  if(fd < 0){
     fba:	31 db                	xor    %ebx,%ebx
  }
  if(pid == 0)
    exit();
  else
    wait();
  close(fd);
     fbc:	89 3c 24             	mov    %edi,(%esp)
// More file system tests

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(void)
     fbf:	8d 7d e8             	lea    -0x18(%ebp),%edi
  }
  if(pid == 0)
    exit();
  else
    wait();
  close(fd);
     fc2:	e8 73 2c 00 00       	call   3c3a <close>
  fd = open("sharedfd", 0);
     fc7:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     fce:	00 
     fcf:	c7 04 24 eb 44 00 00 	movl   $0x44eb,(%esp)
     fd6:	e8 77 2c 00 00       	call   3c52 <open>
  if(fd < 0){
     fdb:	31 d2                	xor    %edx,%edx
     fdd:	85 c0                	test   %eax,%eax
  if(pid == 0)
    exit();
  else
    wait();
  close(fd);
  fd = open("sharedfd", 0);
     fdf:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  if(fd < 0){
     fe2:	0f 88 ac 00 00 00    	js     1094 <sharedfd+0x194>
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
     fe8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     feb:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     ff2:	00 
     ff3:	89 74 24 04          	mov    %esi,0x4(%esp)
     ff7:	89 55 d0             	mov    %edx,-0x30(%ebp)
     ffa:	89 04 24             	mov    %eax,(%esp)
     ffd:	e8 28 2c 00 00       	call   3c2a <read>
    1002:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1005:	85 c0                	test   %eax,%eax
    1007:	7e 26                	jle    102f <sharedfd+0x12f>
    1009:	89 f0                	mov    %esi,%eax
    100b:	eb 15                	jmp    1022 <sharedfd+0x122>
    100d:	8d 76 00             	lea    0x0(%esi),%esi
    for(i = 0; i < sizeof(buf); i++){
      if(buf[i] == 'c')
        nc++;
      if(buf[i] == 'p')
        np++;
    1010:	80 f9 70             	cmp    $0x70,%cl
    1013:	0f 94 c1             	sete   %cl
    1016:	0f b6 c9             	movzbl %cl,%ecx
    1019:	01 cb                	add    %ecx,%ebx
    101b:	83 c0 01             	add    $0x1,%eax
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i = 0; i < sizeof(buf); i++){
    101e:	39 f8                	cmp    %edi,%eax
    1020:	74 c6                	je     fe8 <sharedfd+0xe8>
      if(buf[i] == 'c')
    1022:	0f b6 08             	movzbl (%eax),%ecx
    1025:	80 f9 63             	cmp    $0x63,%cl
    1028:	75 e6                	jne    1010 <sharedfd+0x110>
        nc++;
    102a:	83 c2 01             	add    $0x1,%edx
    102d:	eb ec                	jmp    101b <sharedfd+0x11b>
      if(buf[i] == 'p')
        np++;
    }
  }
  close(fd);
    102f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    1032:	89 55 d0             	mov    %edx,-0x30(%ebp)
    1035:	89 04 24             	mov    %eax,(%esp)
    1038:	e8 fd 2b 00 00       	call   3c3a <close>
  unlink("sharedfd");
    103d:	c7 04 24 eb 44 00 00 	movl   $0x44eb,(%esp)
    1044:	e8 19 2c 00 00       	call   3c62 <unlink>
  if(nc == 10000 && np == 10000){
    1049:	81 fb 10 27 00 00    	cmp    $0x2710,%ebx
    104f:	8b 55 d0             	mov    -0x30(%ebp),%edx
    1052:	75 5c                	jne    10b0 <sharedfd+0x1b0>
    1054:	81 fa 10 27 00 00    	cmp    $0x2710,%edx
    105a:	75 54                	jne    10b0 <sharedfd+0x1b0>
    printf(1, "sharedfd ok\n");
    105c:	c7 44 24 04 f4 44 00 	movl   $0x44f4,0x4(%esp)
    1063:	00 
    1064:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    106b:	e8 e0 2c 00 00       	call   3d50 <printf>
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    exit();
  }
}
    1070:	83 c4 3c             	add    $0x3c,%esp
    1073:	5b                   	pop    %ebx
    1074:	5e                   	pop    %esi
    1075:	5f                   	pop    %edi
    1076:	5d                   	pop    %ebp
    1077:	c3                   	ret    
  printf(1, "sharedfd test\n");

  unlink("sharedfd");
  fd = open("sharedfd", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for writing");
    1078:	c7 44 24 04 8c 51 00 	movl   $0x518c,0x4(%esp)
    107f:	00 
    1080:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1087:	e8 c4 2c 00 00       	call   3d50 <printf>
    printf(1, "sharedfd ok\n");
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    exit();
  }
}
    108c:	83 c4 3c             	add    $0x3c,%esp
    108f:	5b                   	pop    %ebx
    1090:	5e                   	pop    %esi
    1091:	5f                   	pop    %edi
    1092:	5d                   	pop    %ebp
    1093:	c3                   	ret    
  else
    wait();
  close(fd);
  fd = open("sharedfd", 0);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for reading\n");
    1094:	c7 44 24 04 d8 51 00 	movl   $0x51d8,0x4(%esp)
    109b:	00 
    109c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10a3:	e8 a8 2c 00 00       	call   3d50 <printf>
    printf(1, "sharedfd ok\n");
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    exit();
  }
}
    10a8:	83 c4 3c             	add    $0x3c,%esp
    10ab:	5b                   	pop    %ebx
    10ac:	5e                   	pop    %esi
    10ad:	5f                   	pop    %edi
    10ae:	5d                   	pop    %ebp
    10af:	c3                   	ret    
  close(fd);
  unlink("sharedfd");
  if(nc == 10000 && np == 10000){
    printf(1, "sharedfd ok\n");
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    10b0:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
    10b4:	89 54 24 08          	mov    %edx,0x8(%esp)
    10b8:	c7 44 24 04 01 45 00 	movl   $0x4501,0x4(%esp)
    10bf:	00 
    10c0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10c7:	e8 84 2c 00 00       	call   3d50 <printf>
    exit();
    10cc:	e8 41 2b 00 00       	call   3c12 <exit>
    10d1:	eb 0d                	jmp    10e0 <fourfiles>
    10d3:	90                   	nop
    10d4:	90                   	nop
    10d5:	90                   	nop
    10d6:	90                   	nop
    10d7:	90                   	nop
    10d8:	90                   	nop
    10d9:	90                   	nop
    10da:	90                   	nop
    10db:	90                   	nop
    10dc:	90                   	nop
    10dd:	90                   	nop
    10de:	90                   	nop
    10df:	90                   	nop

000010e0 <fourfiles>:

// four processes write different files at the same
// time, to test block allocation.
void
fourfiles(void)
{
    10e0:	55                   	push   %ebp
    10e1:	89 e5                	mov    %esp,%ebp
    10e3:	57                   	push   %edi
    10e4:	56                   	push   %esi
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
  char *fname;

  printf(1, "fourfiles test\n");
    10e5:	be 16 45 00 00       	mov    $0x4516,%esi

// four processes write different files at the same
// time, to test block allocation.
void
fourfiles(void)
{
    10ea:	53                   	push   %ebx
  char *names[] = { "f0", "f1", "f2", "f3" };
  char *fname;

  printf(1, "fourfiles test\n");

  for(pi = 0; pi < 4; pi++){
    10eb:	31 db                	xor    %ebx,%ebx

// four processes write different files at the same
// time, to test block allocation.
void
fourfiles(void)
{
    10ed:	83 ec 3c             	sub    $0x3c,%esp
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
  char *fname;

  printf(1, "fourfiles test\n");
    10f0:	c7 44 24 04 1c 45 00 	movl   $0x451c,0x4(%esp)
    10f7:	00 
    10f8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
// time, to test block allocation.
void
fourfiles(void)
{
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
    10ff:	c7 45 d8 16 45 00 00 	movl   $0x4516,-0x28(%ebp)
    1106:	c7 45 dc 5f 46 00 00 	movl   $0x465f,-0x24(%ebp)
    110d:	c7 45 e0 63 46 00 00 	movl   $0x4663,-0x20(%ebp)
    1114:	c7 45 e4 19 45 00 00 	movl   $0x4519,-0x1c(%ebp)
  char *fname;

  printf(1, "fourfiles test\n");
    111b:	e8 30 2c 00 00       	call   3d50 <printf>

  for(pi = 0; pi < 4; pi++){
    fname = names[pi];
    unlink(fname);
    1120:	89 34 24             	mov    %esi,(%esp)
    1123:	e8 3a 2b 00 00       	call   3c62 <unlink>

    pid = fork();
    1128:	e8 dd 2a 00 00       	call   3c0a <fork>
    if(pid < 0){
    112d:	83 f8 00             	cmp    $0x0,%eax
    1130:	0f 8c 90 01 00 00    	jl     12c6 <fourfiles+0x1e6>
      printf(1, "fork failed\n");
      exit();
    }

    if(pid == 0){
    1136:	0f 84 eb 00 00 00    	je     1227 <fourfiles+0x147>
  char *names[] = { "f0", "f1", "f2", "f3" };
  char *fname;

  printf(1, "fourfiles test\n");

  for(pi = 0; pi < 4; pi++){
    113c:	83 c3 01             	add    $0x1,%ebx
    113f:	83 fb 04             	cmp    $0x4,%ebx
    1142:	74 06                	je     114a <fourfiles+0x6a>
    1144:	8b 74 9d d8          	mov    -0x28(%ebp,%ebx,4),%esi
    1148:	eb d6                	jmp    1120 <fourfiles+0x40>
      exit();
    }
  }

  for(pi = 0; pi < 4; pi++){
    wait();
    114a:	e8 cb 2a 00 00       	call   3c1a <wait>
    114f:	bf 30 00 00 00       	mov    $0x30,%edi
    1154:	e8 c1 2a 00 00       	call   3c1a <wait>
    1159:	e8 bc 2a 00 00       	call   3c1a <wait>
    115e:	e8 b7 2a 00 00       	call   3c1a <wait>
    1163:	c7 45 d4 16 45 00 00 	movl   $0x4516,-0x2c(%ebp)
  }

  for(i = 0; i < 2; i++){
    fname = names[i];
    fd = open(fname, 0);
    116a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    total = 0;
    116d:	31 db                	xor    %ebx,%ebx
    wait();
  }

  for(i = 0; i < 2; i++){
    fname = names[i];
    fd = open(fname, 0);
    116f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1176:	00 
    1177:	89 04 24             	mov    %eax,(%esp)
    117a:	e8 d3 2a 00 00       	call   3c52 <open>
    117f:	89 c6                	mov    %eax,%esi
    1181:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
    1188:	c7 44 24 08 00 20 00 	movl   $0x2000,0x8(%esp)
    118f:	00 
    1190:	c7 44 24 04 e0 88 00 	movl   $0x88e0,0x4(%esp)
    1197:	00 
    1198:	89 34 24             	mov    %esi,(%esp)
    119b:	e8 8a 2a 00 00       	call   3c2a <read>
    11a0:	85 c0                	test   %eax,%eax
    11a2:	7e 1a                	jle    11be <fourfiles+0xde>
    11a4:	31 d2                	xor    %edx,%edx
    11a6:	66 90                	xchg   %ax,%ax
      for(j = 0; j < n; j++){
        if(buf[j] != '0'+i){
    11a8:	0f be 8a e0 88 00 00 	movsbl 0x88e0(%edx),%ecx
    11af:	39 cf                	cmp    %ecx,%edi
    11b1:	75 5b                	jne    120e <fourfiles+0x12e>
  for(i = 0; i < 2; i++){
    fname = names[i];
    fd = open(fname, 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
    11b3:	83 c2 01             	add    $0x1,%edx
    11b6:	39 c2                	cmp    %eax,%edx
    11b8:	75 ee                	jne    11a8 <fourfiles+0xc8>
        if(buf[j] != '0'+i){
          printf(1, "wrong char\n");
          exit();
        }
      }
      total += n;
    11ba:	01 d3                	add    %edx,%ebx
    11bc:	eb ca                	jmp    1188 <fourfiles+0xa8>
    }
    close(fd);
    11be:	89 34 24             	mov    %esi,(%esp)
    11c1:	e8 74 2a 00 00       	call   3c3a <close>
    if(total != 12*500){
    11c6:	81 fb 70 17 00 00    	cmp    $0x1770,%ebx
    11cc:	0f 85 d7 00 00 00    	jne    12a9 <fourfiles+0x1c9>
      printf(1, "wrong length %d\n", total);
      exit();
    }
    unlink(fname);
    11d2:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    11d5:	89 04 24             	mov    %eax,(%esp)
    11d8:	e8 85 2a 00 00       	call   3c62 <unlink>

  for(pi = 0; pi < 4; pi++){
    wait();
  }

  for(i = 0; i < 2; i++){
    11dd:	83 ff 31             	cmp    $0x31,%edi
    11e0:	75 1c                	jne    11fe <fourfiles+0x11e>
      exit();
    }
    unlink(fname);
  }

  printf(1, "fourfiles ok\n");
    11e2:	c7 44 24 04 5a 45 00 	movl   $0x455a,0x4(%esp)
    11e9:	00 
    11ea:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11f1:	e8 5a 2b 00 00       	call   3d50 <printf>
}
    11f6:	83 c4 3c             	add    $0x3c,%esp
    11f9:	5b                   	pop    %ebx
    11fa:	5e                   	pop    %esi
    11fb:	5f                   	pop    %edi
    11fc:	5d                   	pop    %ebp
    11fd:	c3                   	ret    
    11fe:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1201:	bf 31 00 00 00       	mov    $0x31,%edi
    1206:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1209:	e9 5c ff ff ff       	jmp    116a <fourfiles+0x8a>
    fd = open(fname, 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
        if(buf[j] != '0'+i){
          printf(1, "wrong char\n");
    120e:	c7 44 24 04 3d 45 00 	movl   $0x453d,0x4(%esp)
    1215:	00 
    1216:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    121d:	e8 2e 2b 00 00       	call   3d50 <printf>
          exit();
    1222:	e8 eb 29 00 00       	call   3c12 <exit>
      printf(1, "fork failed\n");
      exit();
    }

    if(pid == 0){
      fd = open(fname, O_CREATE | O_RDWR);
    1227:	89 34 24             	mov    %esi,(%esp)
    122a:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1231:	00 
    1232:	e8 1b 2a 00 00       	call   3c52 <open>
      if(fd < 0){
    1237:	85 c0                	test   %eax,%eax
      printf(1, "fork failed\n");
      exit();
    }

    if(pid == 0){
      fd = open(fname, O_CREATE | O_RDWR);
    1239:	89 c6                	mov    %eax,%esi
      if(fd < 0){
    123b:	0f 88 9e 00 00 00    	js     12df <fourfiles+0x1ff>
        printf(1, "create failed\n");
        exit();
      }

      memset(buf, '0'+pi, 512);
    1241:	83 c3 30             	add    $0x30,%ebx
    1244:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    1248:	bb 0c 00 00 00       	mov    $0xc,%ebx
    124d:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    1254:	00 
    1255:	c7 04 24 e0 88 00 00 	movl   $0x88e0,(%esp)
    125c:	e8 1f 28 00 00       	call   3a80 <memset>
    1261:	eb 0a                	jmp    126d <fourfiles+0x18d>
    1263:	90                   	nop
    1264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(i = 0; i < 12; i++){
    1268:	83 eb 01             	sub    $0x1,%ebx
    126b:	74 b5                	je     1222 <fourfiles+0x142>
        if((n = write(fd, buf, 500)) != 500){
    126d:	c7 44 24 08 f4 01 00 	movl   $0x1f4,0x8(%esp)
    1274:	00 
    1275:	c7 44 24 04 e0 88 00 	movl   $0x88e0,0x4(%esp)
    127c:	00 
    127d:	89 34 24             	mov    %esi,(%esp)
    1280:	e8 ad 29 00 00       	call   3c32 <write>
    1285:	3d f4 01 00 00       	cmp    $0x1f4,%eax
    128a:	74 dc                	je     1268 <fourfiles+0x188>
          printf(1, "write failed %d\n", n);
    128c:	89 44 24 08          	mov    %eax,0x8(%esp)
    1290:	c7 44 24 04 2c 45 00 	movl   $0x452c,0x4(%esp)
    1297:	00 
    1298:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    129f:	e8 ac 2a 00 00       	call   3d50 <printf>
          exit();
    12a4:	e8 69 29 00 00       	call   3c12 <exit>
      }
      total += n;
    }
    close(fd);
    if(total != 12*500){
      printf(1, "wrong length %d\n", total);
    12a9:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    12ad:	c7 44 24 04 49 45 00 	movl   $0x4549,0x4(%esp)
    12b4:	00 
    12b5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    12bc:	e8 8f 2a 00 00       	call   3d50 <printf>
      exit();
    12c1:	e8 4c 29 00 00       	call   3c12 <exit>
    fname = names[pi];
    unlink(fname);

    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
    12c6:	c7 44 24 04 f1 4f 00 	movl   $0x4ff1,0x4(%esp)
    12cd:	00 
    12ce:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    12d5:	e8 76 2a 00 00       	call   3d50 <printf>
      exit();
    12da:	e8 33 29 00 00       	call   3c12 <exit>
    }

    if(pid == 0){
      fd = open(fname, O_CREATE | O_RDWR);
      if(fd < 0){
        printf(1, "create failed\n");
    12df:	c7 44 24 04 b7 47 00 	movl   $0x47b7,0x4(%esp)
    12e6:	00 
    12e7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    12ee:	e8 5d 2a 00 00       	call   3d50 <printf>
        exit();
    12f3:	e8 1a 29 00 00       	call   3c12 <exit>
    12f8:	90                   	nop
    12f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001300 <createdelete>:
}

// four processes create and delete different files in same directory
void
createdelete(void)
{
    1300:	55                   	push   %ebp
    1301:	89 e5                	mov    %esp,%ebp
    1303:	57                   	push   %edi
    1304:	56                   	push   %esi
    1305:	53                   	push   %ebx
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");

  for(pi = 0; pi < 4; pi++){
    1306:	31 db                	xor    %ebx,%ebx
}

// four processes create and delete different files in same directory
void
createdelete(void)
{
    1308:	83 ec 4c             	sub    $0x4c,%esp
  enum { N = 20 };
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");
    130b:	c7 44 24 04 68 45 00 	movl   $0x4568,0x4(%esp)
    1312:	00 
    1313:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    131a:	e8 31 2a 00 00       	call   3d50 <printf>

  for(pi = 0; pi < 4; pi++){
    pid = fork();
    131f:	e8 e6 28 00 00       	call   3c0a <fork>
    if(pid < 0){
    1324:	83 f8 00             	cmp    $0x0,%eax
    1327:	0f 8c b0 01 00 00    	jl     14dd <createdelete+0x1dd>
    132d:	8d 76 00             	lea    0x0(%esi),%esi
      printf(1, "fork failed\n");
      exit();
    }

    if(pid == 0){
    1330:	0f 84 0d 01 00 00    	je     1443 <createdelete+0x143>
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");

  for(pi = 0; pi < 4; pi++){
    1336:	83 c3 01             	add    $0x1,%ebx
    1339:	83 fb 04             	cmp    $0x4,%ebx
    133c:	75 e1                	jne    131f <createdelete+0x1f>
    133e:	66 90                	xchg   %ax,%ax
      exit();
    }
  }

  for(pi = 0; pi < 4; pi++){
    wait();
    1340:	e8 d5 28 00 00       	call   3c1a <wait>
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    1345:	31 f6                	xor    %esi,%esi
      exit();
    }
  }

  for(pi = 0; pi < 4; pi++){
    wait();
    1347:	e8 ce 28 00 00       	call   3c1a <wait>
    134c:	8d 7d c8             	lea    -0x38(%ebp),%edi
    134f:	e8 c6 28 00 00       	call   3c1a <wait>
    1354:	e8 c1 28 00 00       	call   3c1a <wait>
  }

  name[0] = name[1] = name[2] = 0;
    1359:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    135d:	8d 76 00             	lea    0x0(%esi),%esi
    1360:	85 f6                	test   %esi,%esi
  printf(1, "fourfiles ok\n");
}

// four processes create and delete different files in same directory
void
createdelete(void)
    1362:	bb 70 00 00 00       	mov    $0x70,%ebx
    1367:	8d 46 30             	lea    0x30(%esi),%eax
    136a:	0f 94 45 c7          	sete   -0x39(%ebp)
    136e:	83 fe 09             	cmp    $0x9,%esi
    1371:	88 45 c6             	mov    %al,-0x3a(%ebp)
    1374:	0f 9f c0             	setg   %al
    1377:	08 45 c7             	or     %al,-0x39(%ebp)
      name[1] = '0' + i;
      fd = open(name, 0);
      if((i == 0 || i >= N/2) && fd < 0){
        printf(1, "oops createdelete %s didn't exist\n", name);
        exit();
      } else if((i >= 1 && i < N/2) && fd >= 0){
    137a:	8d 46 ff             	lea    -0x1(%esi),%eax
    137d:	89 45 c0             	mov    %eax,-0x40(%ebp)

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + pi;
      name[1] = '0' + i;
    1380:	0f b6 45 c6          	movzbl -0x3a(%ebp),%eax
      fd = open(name, 0);
    1384:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    138b:	00 
    138c:	89 3c 24             	mov    %edi,(%esp)
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + pi;
    138f:	88 5d c8             	mov    %bl,-0x38(%ebp)
      name[1] = '0' + i;
    1392:	88 45 c9             	mov    %al,-0x37(%ebp)
      fd = open(name, 0);
    1395:	e8 b8 28 00 00       	call   3c52 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    139a:	80 7d c7 00          	cmpb   $0x0,-0x39(%ebp)
    139e:	74 30                	je     13d0 <createdelete+0xd0>
    13a0:	85 c0                	test   %eax,%eax
    13a2:	0f 88 18 01 00 00    	js     14c0 <createdelete+0x1c0>
        printf(1, "oops createdelete %s didn't exist\n", name);
        exit();
      } else if((i >= 1 && i < N/2) && fd >= 0){
    13a8:	83 7d c0 08          	cmpl   $0x8,-0x40(%ebp)
    13ac:	0f 87 87 00 00 00    	ja     1439 <createdelete+0x139>
        printf(1, "oops createdelete %s did exist\n", name);
    13b2:	89 7c 24 08          	mov    %edi,0x8(%esp)
    13b6:	c7 44 24 04 28 52 00 	movl   $0x5228,0x4(%esp)
    13bd:	00 
    13be:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13c5:	e8 86 29 00 00       	call   3d50 <printf>
        exit();
    13ca:	e8 43 28 00 00       	call   3c12 <exit>
    13cf:	90                   	nop
      name[1] = '0' + i;
      fd = open(name, 0);
      if((i == 0 || i >= N/2) && fd < 0){
        printf(1, "oops createdelete %s didn't exist\n", name);
        exit();
      } else if((i >= 1 && i < N/2) && fd >= 0){
    13d0:	85 c0                	test   %eax,%eax
    13d2:	79 de                	jns    13b2 <createdelete+0xb2>
    13d4:	83 c3 01             	add    $0x1,%ebx
    wait();
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
    13d7:	80 fb 74             	cmp    $0x74,%bl
    13da:	75 a4                	jne    1380 <createdelete+0x80>
  for(pi = 0; pi < 4; pi++){
    wait();
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    13dc:	83 c6 01             	add    $0x1,%esi
    13df:	83 fe 14             	cmp    $0x14,%esi
    13e2:	0f 85 78 ff ff ff    	jne    1360 <createdelete+0x60>
    13e8:	be 70 00 00 00       	mov    $0x70,%esi
    13ed:	8d 76 00             	lea    0x0(%esi),%esi
  printf(1, "fourfiles ok\n");
}

// four processes create and delete different files in same directory
void
createdelete(void)
    13f0:	8d 46 c0             	lea    -0x40(%esi),%eax
    13f3:	bb 04 00 00 00       	mov    $0x4,%ebx
    13f8:	88 45 c7             	mov    %al,-0x39(%ebp)
    }
  }

  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + i;
    13fb:	89 f0                	mov    %esi,%eax
    13fd:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[1] = '0' + i;
    1400:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
      unlink(name);
    1404:	89 3c 24             	mov    %edi,(%esp)
  }

  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + i;
      name[1] = '0' + i;
    1407:	88 45 c9             	mov    %al,-0x37(%ebp)
      unlink(name);
    140a:	e8 53 28 00 00       	call   3c62 <unlink>
        close(fd);
    }
  }

  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
    140f:	83 eb 01             	sub    $0x1,%ebx
    1412:	75 e7                	jne    13fb <createdelete+0xfb>
    1414:	83 c6 01             	add    $0x1,%esi
      if(fd >= 0)
        close(fd);
    }
  }

  for(i = 0; i < N; i++){
    1417:	89 f0                	mov    %esi,%eax
    1419:	3c 84                	cmp    $0x84,%al
    141b:	75 d3                	jne    13f0 <createdelete+0xf0>
      name[1] = '0' + i;
      unlink(name);
    }
  }

  printf(1, "createdelete ok\n");
    141d:	c7 44 24 04 7b 45 00 	movl   $0x457b,0x4(%esp)
    1424:	00 
    1425:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    142c:	e8 1f 29 00 00       	call   3d50 <printf>
}
    1431:	83 c4 4c             	add    $0x4c,%esp
    1434:	5b                   	pop    %ebx
    1435:	5e                   	pop    %esi
    1436:	5f                   	pop    %edi
    1437:	5d                   	pop    %ebp
    1438:	c3                   	ret    
      } else if((i >= 1 && i < N/2) && fd >= 0){
        printf(1, "oops createdelete %s did exist\n", name);
        exit();
      }
      if(fd >= 0)
        close(fd);
    1439:	89 04 24             	mov    %eax,(%esp)
    143c:	e8 f9 27 00 00       	call   3c3a <close>
    1441:	eb 91                	jmp    13d4 <createdelete+0xd4>
      printf(1, "fork failed\n");
      exit();
    }

    if(pid == 0){
      name[0] = 'p' + pi;
    1443:	83 c3 70             	add    $0x70,%ebx
    1446:	88 5d c8             	mov    %bl,-0x38(%ebp)
    1449:	8d 7d c8             	lea    -0x38(%ebp),%edi
      name[2] = '\0';
    144c:	bb 01 00 00 00       	mov    $0x1,%ebx
    1451:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    1455:	eb 09                	jmp    1460 <createdelete+0x160>
    1457:	90                   	nop
      for(i = 0; i < N; i++){
    1458:	83 fb 14             	cmp    $0x14,%ebx
    145b:	74 7b                	je     14d8 <createdelete+0x1d8>
    145d:	83 c3 01             	add    $0x1,%ebx
  printf(1, "fourfiles ok\n");
}

// four processes create and delete different files in same directory
void
createdelete(void)
    1460:	8d 43 2f             	lea    0x2f(%ebx),%eax
    if(pid == 0){
      name[0] = 'p' + pi;
      name[2] = '\0';
      for(i = 0; i < N; i++){
        name[1] = '0' + i;
        fd = open(name, O_CREATE | O_RDWR);
    1463:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    146a:	00 
  printf(1, "fourfiles ok\n");
}

// four processes create and delete different files in same directory
void
createdelete(void)
    146b:	8d 73 ff             	lea    -0x1(%ebx),%esi
    if(pid == 0){
      name[0] = 'p' + pi;
      name[2] = '\0';
      for(i = 0; i < N; i++){
        name[1] = '0' + i;
        fd = open(name, O_CREATE | O_RDWR);
    146e:	89 3c 24             	mov    %edi,(%esp)
  printf(1, "fourfiles ok\n");
}

// four processes create and delete different files in same directory
void
createdelete(void)
    1471:	88 45 c9             	mov    %al,-0x37(%ebp)
    if(pid == 0){
      name[0] = 'p' + pi;
      name[2] = '\0';
      for(i = 0; i < N; i++){
        name[1] = '0' + i;
        fd = open(name, O_CREATE | O_RDWR);
    1474:	e8 d9 27 00 00       	call   3c52 <open>
        if(fd < 0){
    1479:	85 c0                	test   %eax,%eax
    147b:	78 79                	js     14f6 <createdelete+0x1f6>
          printf(1, "create failed\n");
          exit();
        }
        close(fd);
    147d:	89 04 24             	mov    %eax,(%esp)
    1480:	e8 b5 27 00 00       	call   3c3a <close>
        if(i > 0 && (i % 2 ) == 0){
    1485:	85 f6                	test   %esi,%esi
    1487:	74 d4                	je     145d <createdelete+0x15d>
    1489:	f7 c6 01 00 00 00    	test   $0x1,%esi
    148f:	75 c7                	jne    1458 <createdelete+0x158>
          name[1] = '0' + (i / 2);
    1491:	d1 fe                	sar    %esi
    1493:	8d 46 30             	lea    0x30(%esi),%eax
          if(unlink(name) < 0){
    1496:	89 3c 24             	mov    %edi,(%esp)
          printf(1, "create failed\n");
          exit();
        }
        close(fd);
        if(i > 0 && (i % 2 ) == 0){
          name[1] = '0' + (i / 2);
    1499:	88 45 c9             	mov    %al,-0x37(%ebp)
          if(unlink(name) < 0){
    149c:	e8 c1 27 00 00       	call   3c62 <unlink>
    14a1:	85 c0                	test   %eax,%eax
    14a3:	79 b3                	jns    1458 <createdelete+0x158>
            printf(1, "unlink failed\n");
    14a5:	c7 44 24 04 69 41 00 	movl   $0x4169,0x4(%esp)
    14ac:	00 
    14ad:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    14b4:	e8 97 28 00 00       	call   3d50 <printf>
            exit();
    14b9:	e8 54 27 00 00       	call   3c12 <exit>
    14be:	66 90                	xchg   %ax,%ax
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + pi;
      name[1] = '0' + i;
      fd = open(name, 0);
      if((i == 0 || i >= N/2) && fd < 0){
        printf(1, "oops createdelete %s didn't exist\n", name);
    14c0:	89 7c 24 08          	mov    %edi,0x8(%esp)
    14c4:	c7 44 24 04 04 52 00 	movl   $0x5204,0x4(%esp)
    14cb:	00 
    14cc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    14d3:	e8 78 28 00 00       	call   3d50 <printf>
        exit();
    14d8:	e8 35 27 00 00       	call   3c12 <exit>
  printf(1, "createdelete test\n");

  for(pi = 0; pi < 4; pi++){
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
    14dd:	c7 44 24 04 f1 4f 00 	movl   $0x4ff1,0x4(%esp)
    14e4:	00 
    14e5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    14ec:	e8 5f 28 00 00       	call   3d50 <printf>
      exit();
    14f1:	e8 1c 27 00 00       	call   3c12 <exit>
      name[2] = '\0';
      for(i = 0; i < N; i++){
        name[1] = '0' + i;
        fd = open(name, O_CREATE | O_RDWR);
        if(fd < 0){
          printf(1, "create failed\n");
    14f6:	c7 44 24 04 b7 47 00 	movl   $0x47b7,0x4(%esp)
    14fd:	00 
    14fe:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1505:	e8 46 28 00 00       	call   3d50 <printf>
          exit();
    150a:	e8 03 27 00 00       	call   3c12 <exit>
    150f:	90                   	nop

00001510 <unlinkread>:
}

// can I unlink a file and still read it?
void
unlinkread(void)
{
    1510:	55                   	push   %ebp
    1511:	89 e5                	mov    %esp,%ebp
    1513:	56                   	push   %esi
    1514:	53                   	push   %ebx
    1515:	83 ec 10             	sub    $0x10,%esp
  int fd, fd1;

  printf(1, "unlinkread test\n");
    1518:	c7 44 24 04 8c 45 00 	movl   $0x458c,0x4(%esp)
    151f:	00 
    1520:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1527:	e8 24 28 00 00       	call   3d50 <printf>
  fd = open("unlinkread", O_CREATE | O_RDWR);
    152c:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1533:	00 
    1534:	c7 04 24 9d 45 00 00 	movl   $0x459d,(%esp)
    153b:	e8 12 27 00 00       	call   3c52 <open>
  if(fd < 0){
    1540:	85 c0                	test   %eax,%eax
unlinkread(void)
{
  int fd, fd1;

  printf(1, "unlinkread test\n");
  fd = open("unlinkread", O_CREATE | O_RDWR);
    1542:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1544:	0f 88 fe 00 00 00    	js     1648 <unlinkread+0x138>
    printf(1, "create unlinkread failed\n");
    exit();
  }
  write(fd, "hello", 5);
    154a:	c7 44 24 08 05 00 00 	movl   $0x5,0x8(%esp)
    1551:	00 
    1552:	c7 44 24 04 c2 45 00 	movl   $0x45c2,0x4(%esp)
    1559:	00 
    155a:	89 04 24             	mov    %eax,(%esp)
    155d:	e8 d0 26 00 00       	call   3c32 <write>
  close(fd);
    1562:	89 1c 24             	mov    %ebx,(%esp)
    1565:	e8 d0 26 00 00       	call   3c3a <close>

  fd = open("unlinkread", O_RDWR);
    156a:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    1571:	00 
    1572:	c7 04 24 9d 45 00 00 	movl   $0x459d,(%esp)
    1579:	e8 d4 26 00 00       	call   3c52 <open>
  if(fd < 0){
    157e:	85 c0                	test   %eax,%eax
    exit();
  }
  write(fd, "hello", 5);
  close(fd);

  fd = open("unlinkread", O_RDWR);
    1580:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1582:	0f 88 3d 01 00 00    	js     16c5 <unlinkread+0x1b5>
    printf(1, "open unlinkread failed\n");
    exit();
  }
  if(unlink("unlinkread") != 0){
    1588:	c7 04 24 9d 45 00 00 	movl   $0x459d,(%esp)
    158f:	e8 ce 26 00 00       	call   3c62 <unlink>
    1594:	85 c0                	test   %eax,%eax
    1596:	0f 85 10 01 00 00    	jne    16ac <unlinkread+0x19c>
    printf(1, "unlink unlinkread failed\n");
    exit();
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    159c:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    15a3:	00 
    15a4:	c7 04 24 9d 45 00 00 	movl   $0x459d,(%esp)
    15ab:	e8 a2 26 00 00       	call   3c52 <open>
  write(fd1, "yyy", 3);
    15b0:	c7 44 24 08 03 00 00 	movl   $0x3,0x8(%esp)
    15b7:	00 
    15b8:	c7 44 24 04 fa 45 00 	movl   $0x45fa,0x4(%esp)
    15bf:	00 
  if(unlink("unlinkread") != 0){
    printf(1, "unlink unlinkread failed\n");
    exit();
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    15c0:	89 c6                	mov    %eax,%esi
  write(fd1, "yyy", 3);
    15c2:	89 04 24             	mov    %eax,(%esp)
    15c5:	e8 68 26 00 00       	call   3c32 <write>
  close(fd1);
    15ca:	89 34 24             	mov    %esi,(%esp)
    15cd:	e8 68 26 00 00       	call   3c3a <close>

  if(read(fd, buf, sizeof(buf)) != 5){
    15d2:	c7 44 24 08 00 20 00 	movl   $0x2000,0x8(%esp)
    15d9:	00 
    15da:	c7 44 24 04 e0 88 00 	movl   $0x88e0,0x4(%esp)
    15e1:	00 
    15e2:	89 1c 24             	mov    %ebx,(%esp)
    15e5:	e8 40 26 00 00       	call   3c2a <read>
    15ea:	83 f8 05             	cmp    $0x5,%eax
    15ed:	0f 85 a0 00 00 00    	jne    1693 <unlinkread+0x183>
    printf(1, "unlinkread read failed");
    exit();
  }
  if(buf[0] != 'h'){
    15f3:	80 3d e0 88 00 00 68 	cmpb   $0x68,0x88e0
    15fa:	75 7e                	jne    167a <unlinkread+0x16a>
    printf(1, "unlinkread wrong data\n");
    exit();
  }
  if(write(fd, buf, 10) != 10){
    15fc:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1603:	00 
    1604:	c7 44 24 04 e0 88 00 	movl   $0x88e0,0x4(%esp)
    160b:	00 
    160c:	89 1c 24             	mov    %ebx,(%esp)
    160f:	e8 1e 26 00 00       	call   3c32 <write>
    1614:	83 f8 0a             	cmp    $0xa,%eax
    1617:	75 48                	jne    1661 <unlinkread+0x151>
    printf(1, "unlinkread write failed\n");
    exit();
  }
  close(fd);
    1619:	89 1c 24             	mov    %ebx,(%esp)
    161c:	e8 19 26 00 00       	call   3c3a <close>
  unlink("unlinkread");
    1621:	c7 04 24 9d 45 00 00 	movl   $0x459d,(%esp)
    1628:	e8 35 26 00 00       	call   3c62 <unlink>
  printf(1, "unlinkread ok\n");
    162d:	c7 44 24 04 45 46 00 	movl   $0x4645,0x4(%esp)
    1634:	00 
    1635:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    163c:	e8 0f 27 00 00       	call   3d50 <printf>
}
    1641:	83 c4 10             	add    $0x10,%esp
    1644:	5b                   	pop    %ebx
    1645:	5e                   	pop    %esi
    1646:	5d                   	pop    %ebp
    1647:	c3                   	ret    
  int fd, fd1;

  printf(1, "unlinkread test\n");
  fd = open("unlinkread", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create unlinkread failed\n");
    1648:	c7 44 24 04 a8 45 00 	movl   $0x45a8,0x4(%esp)
    164f:	00 
    1650:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1657:	e8 f4 26 00 00       	call   3d50 <printf>
    exit();
    165c:	e8 b1 25 00 00       	call   3c12 <exit>
  if(buf[0] != 'h'){
    printf(1, "unlinkread wrong data\n");
    exit();
  }
  if(write(fd, buf, 10) != 10){
    printf(1, "unlinkread write failed\n");
    1661:	c7 44 24 04 2c 46 00 	movl   $0x462c,0x4(%esp)
    1668:	00 
    1669:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1670:	e8 db 26 00 00       	call   3d50 <printf>
    exit();
    1675:	e8 98 25 00 00       	call   3c12 <exit>
  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "unlinkread read failed");
    exit();
  }
  if(buf[0] != 'h'){
    printf(1, "unlinkread wrong data\n");
    167a:	c7 44 24 04 15 46 00 	movl   $0x4615,0x4(%esp)
    1681:	00 
    1682:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1689:	e8 c2 26 00 00       	call   3d50 <printf>
    exit();
    168e:	e8 7f 25 00 00       	call   3c12 <exit>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
  write(fd1, "yyy", 3);
  close(fd1);

  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "unlinkread read failed");
    1693:	c7 44 24 04 fe 45 00 	movl   $0x45fe,0x4(%esp)
    169a:	00 
    169b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    16a2:	e8 a9 26 00 00       	call   3d50 <printf>
    exit();
    16a7:	e8 66 25 00 00       	call   3c12 <exit>
  if(fd < 0){
    printf(1, "open unlinkread failed\n");
    exit();
  }
  if(unlink("unlinkread") != 0){
    printf(1, "unlink unlinkread failed\n");
    16ac:	c7 44 24 04 e0 45 00 	movl   $0x45e0,0x4(%esp)
    16b3:	00 
    16b4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    16bb:	e8 90 26 00 00       	call   3d50 <printf>
    exit();
    16c0:	e8 4d 25 00 00       	call   3c12 <exit>
  write(fd, "hello", 5);
  close(fd);

  fd = open("unlinkread", O_RDWR);
  if(fd < 0){
    printf(1, "open unlinkread failed\n");
    16c5:	c7 44 24 04 c8 45 00 	movl   $0x45c8,0x4(%esp)
    16cc:	00 
    16cd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    16d4:	e8 77 26 00 00       	call   3d50 <printf>
    exit();
    16d9:	e8 34 25 00 00       	call   3c12 <exit>
    16de:	66 90                	xchg   %ax,%ax

000016e0 <linktest>:
  printf(1, "unlinkread ok\n");
}

void
linktest(void)
{
    16e0:	55                   	push   %ebp
    16e1:	89 e5                	mov    %esp,%ebp
    16e3:	53                   	push   %ebx
    16e4:	83 ec 14             	sub    $0x14,%esp
  int fd;

  printf(1, "linktest\n");
    16e7:	c7 44 24 04 54 46 00 	movl   $0x4654,0x4(%esp)
    16ee:	00 
    16ef:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    16f6:	e8 55 26 00 00       	call   3d50 <printf>

  unlink("lf1");
    16fb:	c7 04 24 5e 46 00 00 	movl   $0x465e,(%esp)
    1702:	e8 5b 25 00 00       	call   3c62 <unlink>
  unlink("lf2");
    1707:	c7 04 24 62 46 00 00 	movl   $0x4662,(%esp)
    170e:	e8 4f 25 00 00       	call   3c62 <unlink>

  fd = open("lf1", O_CREATE|O_RDWR);
    1713:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    171a:	00 
    171b:	c7 04 24 5e 46 00 00 	movl   $0x465e,(%esp)
    1722:	e8 2b 25 00 00       	call   3c52 <open>
  if(fd < 0){
    1727:	85 c0                	test   %eax,%eax
  printf(1, "linktest\n");

  unlink("lf1");
  unlink("lf2");

  fd = open("lf1", O_CREATE|O_RDWR);
    1729:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    172b:	0f 88 26 01 00 00    	js     1857 <linktest+0x177>
    printf(1, "create lf1 failed\n");
    exit();
  }
  if(write(fd, "hello", 5) != 5){
    1731:	c7 44 24 08 05 00 00 	movl   $0x5,0x8(%esp)
    1738:	00 
    1739:	c7 44 24 04 c2 45 00 	movl   $0x45c2,0x4(%esp)
    1740:	00 
    1741:	89 04 24             	mov    %eax,(%esp)
    1744:	e8 e9 24 00 00       	call   3c32 <write>
    1749:	83 f8 05             	cmp    $0x5,%eax
    174c:	0f 85 cd 01 00 00    	jne    191f <linktest+0x23f>
    printf(1, "write lf1 failed\n");
    exit();
  }
  close(fd);
    1752:	89 1c 24             	mov    %ebx,(%esp)
    1755:	e8 e0 24 00 00       	call   3c3a <close>

  if(link("lf1", "lf2") < 0){
    175a:	c7 44 24 04 62 46 00 	movl   $0x4662,0x4(%esp)
    1761:	00 
    1762:	c7 04 24 5e 46 00 00 	movl   $0x465e,(%esp)
    1769:	e8 04 25 00 00       	call   3c72 <link>
    176e:	85 c0                	test   %eax,%eax
    1770:	0f 88 90 01 00 00    	js     1906 <linktest+0x226>
    printf(1, "link lf1 lf2 failed\n");
    exit();
  }
  unlink("lf1");
    1776:	c7 04 24 5e 46 00 00 	movl   $0x465e,(%esp)
    177d:	e8 e0 24 00 00       	call   3c62 <unlink>

  if(open("lf1", 0) >= 0){
    1782:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1789:	00 
    178a:	c7 04 24 5e 46 00 00 	movl   $0x465e,(%esp)
    1791:	e8 bc 24 00 00       	call   3c52 <open>
    1796:	85 c0                	test   %eax,%eax
    1798:	0f 89 4f 01 00 00    	jns    18ed <linktest+0x20d>
    printf(1, "unlinked lf1 but it is still there!\n");
    exit();
  }

  fd = open("lf2", 0);
    179e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    17a5:	00 
    17a6:	c7 04 24 62 46 00 00 	movl   $0x4662,(%esp)
    17ad:	e8 a0 24 00 00       	call   3c52 <open>
  if(fd < 0){
    17b2:	85 c0                	test   %eax,%eax
  if(open("lf1", 0) >= 0){
    printf(1, "unlinked lf1 but it is still there!\n");
    exit();
  }

  fd = open("lf2", 0);
    17b4:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    17b6:	0f 88 18 01 00 00    	js     18d4 <linktest+0x1f4>
    printf(1, "open lf2 failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    17bc:	c7 44 24 08 00 20 00 	movl   $0x2000,0x8(%esp)
    17c3:	00 
    17c4:	c7 44 24 04 e0 88 00 	movl   $0x88e0,0x4(%esp)
    17cb:	00 
    17cc:	89 04 24             	mov    %eax,(%esp)
    17cf:	e8 56 24 00 00       	call   3c2a <read>
    17d4:	83 f8 05             	cmp    $0x5,%eax
    17d7:	0f 85 de 00 00 00    	jne    18bb <linktest+0x1db>
    printf(1, "read lf2 failed\n");
    exit();
  }
  close(fd);
    17dd:	89 1c 24             	mov    %ebx,(%esp)
    17e0:	e8 55 24 00 00       	call   3c3a <close>

  if(link("lf2", "lf2") >= 0){
    17e5:	c7 44 24 04 62 46 00 	movl   $0x4662,0x4(%esp)
    17ec:	00 
    17ed:	c7 04 24 62 46 00 00 	movl   $0x4662,(%esp)
    17f4:	e8 79 24 00 00       	call   3c72 <link>
    17f9:	85 c0                	test   %eax,%eax
    17fb:	0f 89 a1 00 00 00    	jns    18a2 <linktest+0x1c2>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    exit();
  }

  unlink("lf2");
    1801:	c7 04 24 62 46 00 00 	movl   $0x4662,(%esp)
    1808:	e8 55 24 00 00       	call   3c62 <unlink>
  if(link("lf2", "lf1") >= 0){
    180d:	c7 44 24 04 5e 46 00 	movl   $0x465e,0x4(%esp)
    1814:	00 
    1815:	c7 04 24 62 46 00 00 	movl   $0x4662,(%esp)
    181c:	e8 51 24 00 00       	call   3c72 <link>
    1821:	85 c0                	test   %eax,%eax
    1823:	79 64                	jns    1889 <linktest+0x1a9>
    printf(1, "link non-existant succeeded! oops\n");
    exit();
  }

  if(link(".", "lf1") >= 0){
    1825:	c7 44 24 04 5e 46 00 	movl   $0x465e,0x4(%esp)
    182c:	00 
    182d:	c7 04 24 26 49 00 00 	movl   $0x4926,(%esp)
    1834:	e8 39 24 00 00       	call   3c72 <link>
    1839:	85 c0                	test   %eax,%eax
    183b:	79 33                	jns    1870 <linktest+0x190>
    printf(1, "link . lf1 succeeded! oops\n");
    exit();
  }

  printf(1, "linktest ok\n");
    183d:	c7 44 24 04 fc 46 00 	movl   $0x46fc,0x4(%esp)
    1844:	00 
    1845:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    184c:	e8 ff 24 00 00       	call   3d50 <printf>
}
    1851:	83 c4 14             	add    $0x14,%esp
    1854:	5b                   	pop    %ebx
    1855:	5d                   	pop    %ebp
    1856:	c3                   	ret    
  unlink("lf1");
  unlink("lf2");

  fd = open("lf1", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "create lf1 failed\n");
    1857:	c7 44 24 04 66 46 00 	movl   $0x4666,0x4(%esp)
    185e:	00 
    185f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1866:	e8 e5 24 00 00       	call   3d50 <printf>
    exit();
    186b:	e8 a2 23 00 00       	call   3c12 <exit>
    printf(1, "link non-existant succeeded! oops\n");
    exit();
  }

  if(link(".", "lf1") >= 0){
    printf(1, "link . lf1 succeeded! oops\n");
    1870:	c7 44 24 04 e0 46 00 	movl   $0x46e0,0x4(%esp)
    1877:	00 
    1878:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    187f:	e8 cc 24 00 00       	call   3d50 <printf>
    exit();
    1884:	e8 89 23 00 00       	call   3c12 <exit>
    exit();
  }

  unlink("lf2");
  if(link("lf2", "lf1") >= 0){
    printf(1, "link non-existant succeeded! oops\n");
    1889:	c7 44 24 04 70 52 00 	movl   $0x5270,0x4(%esp)
    1890:	00 
    1891:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1898:	e8 b3 24 00 00       	call   3d50 <printf>
    exit();
    189d:	e8 70 23 00 00       	call   3c12 <exit>
    exit();
  }
  close(fd);

  if(link("lf2", "lf2") >= 0){
    printf(1, "link lf2 lf2 succeeded! oops\n");
    18a2:	c7 44 24 04 c2 46 00 	movl   $0x46c2,0x4(%esp)
    18a9:	00 
    18aa:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    18b1:	e8 9a 24 00 00       	call   3d50 <printf>
    exit();
    18b6:	e8 57 23 00 00       	call   3c12 <exit>
  if(fd < 0){
    printf(1, "open lf2 failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "read lf2 failed\n");
    18bb:	c7 44 24 04 b1 46 00 	movl   $0x46b1,0x4(%esp)
    18c2:	00 
    18c3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    18ca:	e8 81 24 00 00       	call   3d50 <printf>
    exit();
    18cf:	e8 3e 23 00 00       	call   3c12 <exit>
    exit();
  }

  fd = open("lf2", 0);
  if(fd < 0){
    printf(1, "open lf2 failed\n");
    18d4:	c7 44 24 04 a0 46 00 	movl   $0x46a0,0x4(%esp)
    18db:	00 
    18dc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    18e3:	e8 68 24 00 00       	call   3d50 <printf>
    exit();
    18e8:	e8 25 23 00 00       	call   3c12 <exit>
    exit();
  }
  unlink("lf1");

  if(open("lf1", 0) >= 0){
    printf(1, "unlinked lf1 but it is still there!\n");
    18ed:	c7 44 24 04 48 52 00 	movl   $0x5248,0x4(%esp)
    18f4:	00 
    18f5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    18fc:	e8 4f 24 00 00       	call   3d50 <printf>
    exit();
    1901:	e8 0c 23 00 00       	call   3c12 <exit>
    exit();
  }
  close(fd);

  if(link("lf1", "lf2") < 0){
    printf(1, "link lf1 lf2 failed\n");
    1906:	c7 44 24 04 8b 46 00 	movl   $0x468b,0x4(%esp)
    190d:	00 
    190e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1915:	e8 36 24 00 00       	call   3d50 <printf>
    exit();
    191a:	e8 f3 22 00 00       	call   3c12 <exit>
  if(fd < 0){
    printf(1, "create lf1 failed\n");
    exit();
  }
  if(write(fd, "hello", 5) != 5){
    printf(1, "write lf1 failed\n");
    191f:	c7 44 24 04 79 46 00 	movl   $0x4679,0x4(%esp)
    1926:	00 
    1927:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    192e:	e8 1d 24 00 00       	call   3d50 <printf>
    exit();
    1933:	e8 da 22 00 00       	call   3c12 <exit>
    1938:	90                   	nop
    1939:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001940 <concreate>:
}

// test concurrent create/link/unlink of the same file
void
concreate(void)
{
    1940:	55                   	push   %ebp
    1941:	89 e5                	mov    %esp,%ebp
    1943:	57                   	push   %edi
    1944:	56                   	push   %esi
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    1945:	31 f6                	xor    %esi,%esi
}

// test concurrent create/link/unlink of the same file
void
concreate(void)
{
    1947:	53                   	push   %ebx
    1948:	83 ec 6c             	sub    $0x6c,%esp
  struct {
    ushort inum;
    char name[14];
  } de;

  printf(1, "concreate test\n");
    194b:	c7 44 24 04 09 47 00 	movl   $0x4709,0x4(%esp)
    1952:	00 
    1953:	8d 5d ad             	lea    -0x53(%ebp),%ebx
    1956:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    195d:	e8 ee 23 00 00       	call   3d50 <printf>
  file[0] = 'C';
    1962:	c6 45 ad 43          	movb   $0x43,-0x53(%ebp)
  file[2] = '\0';
    1966:	c6 45 af 00          	movb   $0x0,-0x51(%ebp)
    196a:	eb 4f                	jmp    19bb <concreate+0x7b>
    196c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
    1970:	b8 56 55 55 55       	mov    $0x55555556,%eax
    1975:	f7 ee                	imul   %esi
    1977:	89 f0                	mov    %esi,%eax
    1979:	c1 f8 1f             	sar    $0x1f,%eax
    197c:	29 c2                	sub    %eax,%edx
    197e:	8d 04 52             	lea    (%edx,%edx,2),%eax
    1981:	89 f2                	mov    %esi,%edx
    1983:	29 c2                	sub    %eax,%edx
    1985:	83 fa 01             	cmp    $0x1,%edx
    1988:	74 7e                	je     1a08 <concreate+0xc8>
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
      link("C0", file);
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    198a:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1991:	00 
    1992:	89 1c 24             	mov    %ebx,(%esp)
    1995:	e8 b8 22 00 00       	call   3c52 <open>
      if(fd < 0){
    199a:	85 c0                	test   %eax,%eax
    199c:	0f 88 43 02 00 00    	js     1be5 <concreate+0x2a5>
        printf(1, "concreate create %s failed\n", file);
        exit();
      }
      close(fd);
    19a2:	89 04 24             	mov    %eax,(%esp)
    19a5:	e8 90 22 00 00       	call   3c3a <close>
    }
    if(pid == 0)
    19aa:	85 ff                	test   %edi,%edi
    19ac:	74 52                	je     1a00 <concreate+0xc0>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    19ae:	83 c6 01             	add    $0x1,%esi
      close(fd);
    }
    if(pid == 0)
      exit();
    else
      wait();
    19b1:	e8 64 22 00 00       	call   3c1a <wait>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    19b6:	83 fe 28             	cmp    $0x28,%esi
    19b9:	74 6d                	je     1a28 <concreate+0xe8>
  printf(1, "linktest ok\n");
}

// test concurrent create/link/unlink of the same file
void
concreate(void)
    19bb:	8d 46 30             	lea    0x30(%esi),%eax
  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    unlink(file);
    19be:	89 1c 24             	mov    %ebx,(%esp)
  printf(1, "linktest ok\n");
}

// test concurrent create/link/unlink of the same file
void
concreate(void)
    19c1:	88 45 ae             	mov    %al,-0x52(%ebp)
  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    unlink(file);
    19c4:	e8 99 22 00 00       	call   3c62 <unlink>
    pid = fork();
    19c9:	e8 3c 22 00 00       	call   3c0a <fork>
    if(pid && (i % 3) == 1){
    19ce:	85 c0                	test   %eax,%eax
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    19d0:	89 c7                	mov    %eax,%edi
    if(pid && (i % 3) == 1){
    19d2:	75 9c                	jne    1970 <concreate+0x30>
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
    19d4:	b8 67 66 66 66       	mov    $0x66666667,%eax
    19d9:	f7 ee                	imul   %esi
    19db:	89 f0                	mov    %esi,%eax
    19dd:	c1 f8 1f             	sar    $0x1f,%eax
    19e0:	d1 fa                	sar    %edx
    19e2:	29 c2                	sub    %eax,%edx
    19e4:	8d 04 92             	lea    (%edx,%edx,4),%eax
    19e7:	89 f2                	mov    %esi,%edx
    19e9:	29 c2                	sub    %eax,%edx
    19eb:	83 fa 01             	cmp    $0x1,%edx
    19ee:	75 9a                	jne    198a <concreate+0x4a>
      link("C0", file);
    19f0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    19f4:	c7 04 24 19 47 00 00 	movl   $0x4719,(%esp)
    19fb:	e8 72 22 00 00       	call   3c72 <link>
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
      i = de.name[1] - '0';
      if(i < 0 || i >= sizeof(fa)){
        printf(1, "concreate weird file %s\n", de.name);
        exit();
    1a00:	e8 0d 22 00 00       	call   3c12 <exit>
    1a05:	8d 76 00             	lea    0x0(%esi),%esi
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
      link("C0", file);
    1a08:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    1a0c:	83 c6 01             	add    $0x1,%esi
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
      link("C0", file);
    1a0f:	c7 04 24 19 47 00 00 	movl   $0x4719,(%esp)
    1a16:	e8 57 22 00 00       	call   3c72 <link>
      close(fd);
    }
    if(pid == 0)
      exit();
    else
      wait();
    1a1b:	e8 fa 21 00 00       	call   3c1a <wait>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    1a20:	83 fe 28             	cmp    $0x28,%esi
    1a23:	75 96                	jne    19bb <concreate+0x7b>
    1a25:	8d 76 00             	lea    0x0(%esi),%esi
      exit();
    else
      wait();
  }

  memset(fa, 0, sizeof(fa));
    1a28:	8d 45 c0             	lea    -0x40(%ebp),%eax
    1a2b:	c7 44 24 08 28 00 00 	movl   $0x28,0x8(%esp)
    1a32:	00 
    1a33:	8d 7d b0             	lea    -0x50(%ebp),%edi
    1a36:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1a3d:	00 
    1a3e:	89 04 24             	mov    %eax,(%esp)
    1a41:	e8 3a 20 00 00       	call   3a80 <memset>
  fd = open(".", 0);
    1a46:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1a4d:	00 
    1a4e:	c7 04 24 26 49 00 00 	movl   $0x4926,(%esp)
    1a55:	e8 f8 21 00 00       	call   3c52 <open>
  n = 0;
    1a5a:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
    else
      wait();
  }

  memset(fa, 0, sizeof(fa));
  fd = open(".", 0);
    1a61:	89 c6                	mov    %eax,%esi
    1a63:	90                   	nop
    1a64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  n = 0;
  while(read(fd, &de, sizeof(de)) > 0){
    1a68:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    1a6f:	00 
    1a70:	89 7c 24 04          	mov    %edi,0x4(%esp)
    1a74:	89 34 24             	mov    %esi,(%esp)
    1a77:	e8 ae 21 00 00       	call   3c2a <read>
    1a7c:	85 c0                	test   %eax,%eax
    1a7e:	7e 40                	jle    1ac0 <concreate+0x180>
    if(de.inum == 0)
    1a80:	66 83 7d b0 00       	cmpw   $0x0,-0x50(%ebp)
    1a85:	74 e1                	je     1a68 <concreate+0x128>
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    1a87:	80 7d b2 43          	cmpb   $0x43,-0x4e(%ebp)
    1a8b:	75 db                	jne    1a68 <concreate+0x128>
    1a8d:	80 7d b4 00          	cmpb   $0x0,-0x4c(%ebp)
    1a91:	75 d5                	jne    1a68 <concreate+0x128>
      i = de.name[1] - '0';
    1a93:	0f be 45 b3          	movsbl -0x4d(%ebp),%eax
    1a97:	83 e8 30             	sub    $0x30,%eax
      if(i < 0 || i >= sizeof(fa)){
    1a9a:	83 f8 27             	cmp    $0x27,%eax
    1a9d:	0f 87 5f 01 00 00    	ja     1c02 <concreate+0x2c2>
        printf(1, "concreate weird file %s\n", de.name);
        exit();
      }
      if(fa[i]){
    1aa3:	80 7c 05 c0 00       	cmpb   $0x0,-0x40(%ebp,%eax,1)
    1aa8:	0f 85 8d 01 00 00    	jne    1c3b <concreate+0x2fb>
        printf(1, "concreate duplicate file %s\n", de.name);
        exit();
      }
      fa[i] = 1;
    1aae:	c6 44 05 c0 01       	movb   $0x1,-0x40(%ebp,%eax,1)
      n++;
    1ab3:	83 45 a4 01          	addl   $0x1,-0x5c(%ebp)
    1ab7:	eb af                	jmp    1a68 <concreate+0x128>
    1ab9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
  }
  close(fd);
    1ac0:	89 34 24             	mov    %esi,(%esp)
    1ac3:	e8 72 21 00 00       	call   3c3a <close>

  if(n != 40){
    1ac8:	83 7d a4 28          	cmpl   $0x28,-0x5c(%ebp)
    1acc:	0f 85 50 01 00 00    	jne    1c22 <concreate+0x2e2>
    1ad2:	31 f6                	xor    %esi,%esi
    1ad4:	eb 7f                	jmp    1b55 <concreate+0x215>
    1ad6:	66 90                	xchg   %ax,%ax
    if(pid < 0){
      printf(1, "fork failed\n");
      exit();
    }
    if(((i % 3) == 0 && pid == 0) ||
       ((i % 3) == 1 && pid != 0)){
    1ad8:	85 ff                	test   %edi,%edi
    1ada:	0f 84 ae 00 00 00    	je     1b8e <concreate+0x24e>
      close(open(file, 0));
    1ae0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1ae7:	00 
    1ae8:	89 1c 24             	mov    %ebx,(%esp)
    1aeb:	e8 62 21 00 00       	call   3c52 <open>
    1af0:	89 04 24             	mov    %eax,(%esp)
    1af3:	e8 42 21 00 00       	call   3c3a <close>
      close(open(file, 0));
    1af8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1aff:	00 
    1b00:	89 1c 24             	mov    %ebx,(%esp)
    1b03:	e8 4a 21 00 00       	call   3c52 <open>
    1b08:	89 04 24             	mov    %eax,(%esp)
    1b0b:	e8 2a 21 00 00       	call   3c3a <close>
      close(open(file, 0));
    1b10:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1b17:	00 
    1b18:	89 1c 24             	mov    %ebx,(%esp)
    1b1b:	e8 32 21 00 00       	call   3c52 <open>
    1b20:	89 04 24             	mov    %eax,(%esp)
    1b23:	e8 12 21 00 00       	call   3c3a <close>
      close(open(file, 0));
    1b28:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1b2f:	00 
    1b30:	89 1c 24             	mov    %ebx,(%esp)
    1b33:	e8 1a 21 00 00       	call   3c52 <open>
    1b38:	89 04 24             	mov    %eax,(%esp)
    1b3b:	e8 fa 20 00 00       	call   3c3a <close>
      unlink(file);
      unlink(file);
      unlink(file);
      unlink(file);
    }
    if(pid == 0)
    1b40:	85 ff                	test   %edi,%edi
    1b42:	0f 84 b8 fe ff ff    	je     1a00 <concreate+0xc0>
  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    exit();
  }

  for(i = 0; i < 40; i++){
    1b48:	83 c6 01             	add    $0x1,%esi
      unlink(file);
    }
    if(pid == 0)
      exit();
    else
      wait();
    1b4b:	e8 ca 20 00 00       	call   3c1a <wait>
  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    exit();
  }

  for(i = 0; i < 40; i++){
    1b50:	83 fe 28             	cmp    $0x28,%esi
    1b53:	74 5b                	je     1bb0 <concreate+0x270>
  printf(1, "linktest ok\n");
}

// test concurrent create/link/unlink of the same file
void
concreate(void)
    1b55:	8d 46 30             	lea    0x30(%esi),%eax
    1b58:	88 45 ae             	mov    %al,-0x52(%ebp)
    exit();
  }

  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    pid = fork();
    1b5b:	e8 aa 20 00 00       	call   3c0a <fork>
    if(pid < 0){
    1b60:	85 c0                	test   %eax,%eax
    exit();
  }

  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    pid = fork();
    1b62:	89 c7                	mov    %eax,%edi
    if(pid < 0){
    1b64:	78 66                	js     1bcc <concreate+0x28c>
      printf(1, "fork failed\n");
      exit();
    }
    if(((i % 3) == 0 && pid == 0) ||
    1b66:	b8 56 55 55 55       	mov    $0x55555556,%eax
    1b6b:	f7 ee                	imul   %esi
    1b6d:	89 f0                	mov    %esi,%eax
    1b6f:	c1 f8 1f             	sar    $0x1f,%eax
    1b72:	29 c2                	sub    %eax,%edx
    1b74:	8d 04 52             	lea    (%edx,%edx,2),%eax
    1b77:	89 f2                	mov    %esi,%edx
    1b79:	29 c2                	sub    %eax,%edx
    1b7b:	89 d0                	mov    %edx,%eax
    1b7d:	09 f8                	or     %edi,%eax
    1b7f:	0f 84 5b ff ff ff    	je     1ae0 <concreate+0x1a0>
    1b85:	83 fa 01             	cmp    $0x1,%edx
    1b88:	0f 84 4a ff ff ff    	je     1ad8 <concreate+0x198>
      close(open(file, 0));
      close(open(file, 0));
      close(open(file, 0));
      close(open(file, 0));
    } else {
      unlink(file);
    1b8e:	89 1c 24             	mov    %ebx,(%esp)
    1b91:	e8 cc 20 00 00       	call   3c62 <unlink>
      unlink(file);
    1b96:	89 1c 24             	mov    %ebx,(%esp)
    1b99:	e8 c4 20 00 00       	call   3c62 <unlink>
      unlink(file);
    1b9e:	89 1c 24             	mov    %ebx,(%esp)
    1ba1:	e8 bc 20 00 00       	call   3c62 <unlink>
      unlink(file);
    1ba6:	89 1c 24             	mov    %ebx,(%esp)
    1ba9:	e8 b4 20 00 00       	call   3c62 <unlink>
    1bae:	eb 90                	jmp    1b40 <concreate+0x200>
      exit();
    else
      wait();
  }

  printf(1, "concreate ok\n");
    1bb0:	c7 44 24 04 6e 47 00 	movl   $0x476e,0x4(%esp)
    1bb7:	00 
    1bb8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1bbf:	e8 8c 21 00 00       	call   3d50 <printf>
}
    1bc4:	83 c4 6c             	add    $0x6c,%esp
    1bc7:	5b                   	pop    %ebx
    1bc8:	5e                   	pop    %esi
    1bc9:	5f                   	pop    %edi
    1bca:	5d                   	pop    %ebp
    1bcb:	c3                   	ret    

  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
    1bcc:	c7 44 24 04 f1 4f 00 	movl   $0x4ff1,0x4(%esp)
    1bd3:	00 
    1bd4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1bdb:	e8 70 21 00 00       	call   3d50 <printf>
      exit();
    1be0:	e8 2d 20 00 00       	call   3c12 <exit>
    } else if(pid == 0 && (i % 5) == 1){
      link("C0", file);
    } else {
      fd = open(file, O_CREATE | O_RDWR);
      if(fd < 0){
        printf(1, "concreate create %s failed\n", file);
    1be5:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    1be9:	c7 44 24 04 1c 47 00 	movl   $0x471c,0x4(%esp)
    1bf0:	00 
    1bf1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1bf8:	e8 53 21 00 00       	call   3d50 <printf>
        exit();
    1bfd:	e8 10 20 00 00       	call   3c12 <exit>
    if(de.inum == 0)
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
      i = de.name[1] - '0';
      if(i < 0 || i >= sizeof(fa)){
        printf(1, "concreate weird file %s\n", de.name);
    1c02:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1c05:	89 44 24 08          	mov    %eax,0x8(%esp)
    1c09:	c7 44 24 04 38 47 00 	movl   $0x4738,0x4(%esp)
    1c10:	00 
    1c11:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c18:	e8 33 21 00 00       	call   3d50 <printf>
    1c1d:	e9 de fd ff ff       	jmp    1a00 <concreate+0xc0>
    }
  }
  close(fd);

  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    1c22:	c7 44 24 04 94 52 00 	movl   $0x5294,0x4(%esp)
    1c29:	00 
    1c2a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c31:	e8 1a 21 00 00       	call   3d50 <printf>
    exit();
    1c36:	e8 d7 1f 00 00       	call   3c12 <exit>
      if(i < 0 || i >= sizeof(fa)){
        printf(1, "concreate weird file %s\n", de.name);
        exit();
      }
      if(fa[i]){
        printf(1, "concreate duplicate file %s\n", de.name);
    1c3b:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1c3e:	89 44 24 08          	mov    %eax,0x8(%esp)
    1c42:	c7 44 24 04 51 47 00 	movl   $0x4751,0x4(%esp)
    1c49:	00 
    1c4a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c51:	e8 fa 20 00 00       	call   3d50 <printf>
        exit();
    1c56:	e8 b7 1f 00 00       	call   3c12 <exit>
    1c5b:	90                   	nop
    1c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001c60 <linkunlink>:

// another concurrent link/unlink/create test,
// to look for deadlocks.
void
linkunlink()
{
    1c60:	55                   	push   %ebp
    1c61:	89 e5                	mov    %esp,%ebp
    1c63:	57                   	push   %edi
    1c64:	56                   	push   %esi
    1c65:	53                   	push   %ebx
    1c66:	83 ec 2c             	sub    $0x2c,%esp
  int pid, i;

  printf(1, "linkunlink test\n");
    1c69:	c7 44 24 04 7c 47 00 	movl   $0x477c,0x4(%esp)
    1c70:	00 
    1c71:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c78:	e8 d3 20 00 00       	call   3d50 <printf>

  unlink("x");
    1c7d:	c7 04 24 09 4a 00 00 	movl   $0x4a09,(%esp)
    1c84:	e8 d9 1f 00 00       	call   3c62 <unlink>
  pid = fork();
    1c89:	e8 7c 1f 00 00       	call   3c0a <fork>
  if(pid < 0){
    1c8e:	85 c0                	test   %eax,%eax
  int pid, i;

  printf(1, "linkunlink test\n");

  unlink("x");
  pid = fork();
    1c90:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(pid < 0){
    1c93:	0f 88 b8 00 00 00    	js     1d51 <linkunlink+0xf1>
    printf(1, "fork failed\n");
    exit();
  }

  unsigned int x = (pid ? 1 : 97);
    1c99:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
    1c9d:	bb 64 00 00 00       	mov    $0x64,%ebx
  for(i = 0; i < 100; i++){
    x = x * 1103515245 + 12345;
    if((x % 3) == 0){
    1ca2:	be ab aa aa aa       	mov    $0xaaaaaaab,%esi
  if(pid < 0){
    printf(1, "fork failed\n");
    exit();
  }

  unsigned int x = (pid ? 1 : 97);
    1ca7:	19 ff                	sbb    %edi,%edi
    1ca9:	83 e7 60             	and    $0x60,%edi
    1cac:	83 c7 01             	add    $0x1,%edi
    1caf:	eb 1d                	jmp    1cce <linkunlink+0x6e>
    1cb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 100; i++){
    x = x * 1103515245 + 12345;
    if((x % 3) == 0){
      close(open("x", O_RDWR | O_CREATE));
    } else if((x % 3) == 1){
    1cb8:	83 fa 01             	cmp    $0x1,%edx
    1cbb:	74 7b                	je     1d38 <linkunlink+0xd8>
      link("cat", "x");
    } else {
      unlink("x");
    1cbd:	c7 04 24 09 4a 00 00 	movl   $0x4a09,(%esp)
    1cc4:	e8 99 1f 00 00       	call   3c62 <unlink>
    printf(1, "fork failed\n");
    exit();
  }

  unsigned int x = (pid ? 1 : 97);
  for(i = 0; i < 100; i++){
    1cc9:	83 eb 01             	sub    $0x1,%ebx
    1ccc:	74 3c                	je     1d0a <linkunlink+0xaa>
    x = x * 1103515245 + 12345;
    1cce:	69 cf 6d 4e c6 41    	imul   $0x41c64e6d,%edi,%ecx
    1cd4:	8d b9 39 30 00 00    	lea    0x3039(%ecx),%edi
    if((x % 3) == 0){
    1cda:	89 f8                	mov    %edi,%eax
    1cdc:	f7 e6                	mul    %esi
    1cde:	d1 ea                	shr    %edx
    1ce0:	8d 04 52             	lea    (%edx,%edx,2),%eax
    1ce3:	89 fa                	mov    %edi,%edx
    1ce5:	29 c2                	sub    %eax,%edx
    1ce7:	75 cf                	jne    1cb8 <linkunlink+0x58>
      close(open("x", O_RDWR | O_CREATE));
    1ce9:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1cf0:	00 
    1cf1:	c7 04 24 09 4a 00 00 	movl   $0x4a09,(%esp)
    1cf8:	e8 55 1f 00 00       	call   3c52 <open>
    1cfd:	89 04 24             	mov    %eax,(%esp)
    1d00:	e8 35 1f 00 00       	call   3c3a <close>
    printf(1, "fork failed\n");
    exit();
  }

  unsigned int x = (pid ? 1 : 97);
  for(i = 0; i < 100; i++){
    1d05:	83 eb 01             	sub    $0x1,%ebx
    1d08:	75 c4                	jne    1cce <linkunlink+0x6e>
    } else {
      unlink("x");
    }
  }

  if(pid)
    1d0a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1d0d:	85 c0                	test   %eax,%eax
    1d0f:	74 59                	je     1d6a <linkunlink+0x10a>
    wait();
    1d11:	e8 04 1f 00 00       	call   3c1a <wait>
  else
    exit();

  printf(1, "linkunlink ok\n");
    1d16:	c7 44 24 04 91 47 00 	movl   $0x4791,0x4(%esp)
    1d1d:	00 
    1d1e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d25:	e8 26 20 00 00       	call   3d50 <printf>
}
    1d2a:	83 c4 2c             	add    $0x2c,%esp
    1d2d:	5b                   	pop    %ebx
    1d2e:	5e                   	pop    %esi
    1d2f:	5f                   	pop    %edi
    1d30:	5d                   	pop    %ebp
    1d31:	c3                   	ret    
    1d32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(i = 0; i < 100; i++){
    x = x * 1103515245 + 12345;
    if((x % 3) == 0){
      close(open("x", O_RDWR | O_CREATE));
    } else if((x % 3) == 1){
      link("cat", "x");
    1d38:	c7 44 24 04 09 4a 00 	movl   $0x4a09,0x4(%esp)
    1d3f:	00 
    1d40:	c7 04 24 8d 47 00 00 	movl   $0x478d,(%esp)
    1d47:	e8 26 1f 00 00       	call   3c72 <link>
    1d4c:	e9 78 ff ff ff       	jmp    1cc9 <linkunlink+0x69>
  printf(1, "linkunlink test\n");

  unlink("x");
  pid = fork();
  if(pid < 0){
    printf(1, "fork failed\n");
    1d51:	c7 44 24 04 f1 4f 00 	movl   $0x4ff1,0x4(%esp)
    1d58:	00 
    1d59:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d60:	e8 eb 1f 00 00       	call   3d50 <printf>
    exit();
    1d65:	e8 a8 1e 00 00       	call   3c12 <exit>
  }

  if(pid)
    wait();
  else
    exit();
    1d6a:	e8 a3 1e 00 00       	call   3c12 <exit>
    1d6f:	90                   	nop

00001d70 <bigdir>:
}

// directory that uses indirect blocks
void
bigdir(void)
{
    1d70:	55                   	push   %ebp
    1d71:	89 e5                	mov    %esp,%ebp
    1d73:	56                   	push   %esi
    1d74:	53                   	push   %ebx
    1d75:	83 ec 20             	sub    $0x20,%esp
  int i, fd;
  char name[10];

  printf(1, "bigdir test\n");
    1d78:	c7 44 24 04 a0 47 00 	movl   $0x47a0,0x4(%esp)
    1d7f:	00 
    1d80:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d87:	e8 c4 1f 00 00       	call   3d50 <printf>
  unlink("bd");
    1d8c:	c7 04 24 ad 47 00 00 	movl   $0x47ad,(%esp)
    1d93:	e8 ca 1e 00 00       	call   3c62 <unlink>

  fd = open("bd", O_CREATE);
    1d98:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    1d9f:	00 
    1da0:	c7 04 24 ad 47 00 00 	movl   $0x47ad,(%esp)
    1da7:	e8 a6 1e 00 00       	call   3c52 <open>
  if(fd < 0){
    1dac:	85 c0                	test   %eax,%eax
    1dae:	0f 88 e6 00 00 00    	js     1e9a <bigdir+0x12a>
    printf(1, "bigdir create failed\n");
    exit();
  }
  close(fd);
    1db4:	89 04 24             	mov    %eax,(%esp)

  for(i = 0; i < 500; i++){
    1db7:	31 db                	xor    %ebx,%ebx
  fd = open("bd", O_CREATE);
  if(fd < 0){
    printf(1, "bigdir create failed\n");
    exit();
  }
  close(fd);
    1db9:	e8 7c 1e 00 00       	call   3c3a <close>
    1dbe:	8d 75 ee             	lea    -0x12(%ebp),%esi
    1dc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    1dc8:	89 d8                	mov    %ebx,%eax
    1dca:	c1 f8 06             	sar    $0x6,%eax
    1dcd:	83 c0 30             	add    $0x30,%eax
    1dd0:	88 45 ef             	mov    %al,-0x11(%ebp)
    name[2] = '0' + (i % 64);
    1dd3:	89 d8                	mov    %ebx,%eax
    1dd5:	83 e0 3f             	and    $0x3f,%eax
    1dd8:	83 c0 30             	add    $0x30,%eax
    name[3] = '\0';
    if(link("bd", name) != 0){
    1ddb:	89 74 24 04          	mov    %esi,0x4(%esp)
    1ddf:	c7 04 24 ad 47 00 00 	movl   $0x47ad,(%esp)
    exit();
  }
  close(fd);

  for(i = 0; i < 500; i++){
    name[0] = 'x';
    1de6:	c6 45 ee 78          	movb   $0x78,-0x12(%ebp)
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    1dea:	88 45 f0             	mov    %al,-0x10(%ebp)
    name[3] = '\0';
    1ded:	c6 45 f1 00          	movb   $0x0,-0xf(%ebp)
    if(link("bd", name) != 0){
    1df1:	e8 7c 1e 00 00       	call   3c72 <link>
    1df6:	85 c0                	test   %eax,%eax
    1df8:	75 6e                	jne    1e68 <bigdir+0xf8>
    printf(1, "bigdir create failed\n");
    exit();
  }
  close(fd);

  for(i = 0; i < 500; i++){
    1dfa:	83 c3 01             	add    $0x1,%ebx
    1dfd:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    1e03:	75 c3                	jne    1dc8 <bigdir+0x58>
      printf(1, "bigdir link failed\n");
      exit();
    }
  }

  unlink("bd");
    1e05:	c7 04 24 ad 47 00 00 	movl   $0x47ad,(%esp)
  for(i = 0; i < 500; i++){
    1e0c:	66 31 db             	xor    %bx,%bx
      printf(1, "bigdir link failed\n");
      exit();
    }
  }

  unlink("bd");
    1e0f:	e8 4e 1e 00 00       	call   3c62 <unlink>
    1e14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < 500; i++){
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    1e18:	89 d8                	mov    %ebx,%eax
    1e1a:	c1 f8 06             	sar    $0x6,%eax
    1e1d:	83 c0 30             	add    $0x30,%eax
    1e20:	88 45 ef             	mov    %al,-0x11(%ebp)
    name[2] = '0' + (i % 64);
    1e23:	89 d8                	mov    %ebx,%eax
    1e25:	83 e0 3f             	and    $0x3f,%eax
    1e28:	83 c0 30             	add    $0x30,%eax
    name[3] = '\0';
    if(unlink(name) != 0){
    1e2b:	89 34 24             	mov    %esi,(%esp)
    }
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    name[0] = 'x';
    1e2e:	c6 45 ee 78          	movb   $0x78,-0x12(%ebp)
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    1e32:	88 45 f0             	mov    %al,-0x10(%ebp)
    name[3] = '\0';
    1e35:	c6 45 f1 00          	movb   $0x0,-0xf(%ebp)
    if(unlink(name) != 0){
    1e39:	e8 24 1e 00 00       	call   3c62 <unlink>
    1e3e:	85 c0                	test   %eax,%eax
    1e40:	75 3f                	jne    1e81 <bigdir+0x111>
      exit();
    }
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    1e42:	83 c3 01             	add    $0x1,%ebx
    1e45:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    1e4b:	75 cb                	jne    1e18 <bigdir+0xa8>
      printf(1, "bigdir unlink failed");
      exit();
    }
  }

  printf(1, "bigdir ok\n");
    1e4d:	c7 44 24 04 ef 47 00 	movl   $0x47ef,0x4(%esp)
    1e54:	00 
    1e55:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1e5c:	e8 ef 1e 00 00       	call   3d50 <printf>
}
    1e61:	83 c4 20             	add    $0x20,%esp
    1e64:	5b                   	pop    %ebx
    1e65:	5e                   	pop    %esi
    1e66:	5d                   	pop    %ebp
    1e67:	c3                   	ret    
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(link("bd", name) != 0){
      printf(1, "bigdir link failed\n");
    1e68:	c7 44 24 04 c6 47 00 	movl   $0x47c6,0x4(%esp)
    1e6f:	00 
    1e70:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1e77:	e8 d4 1e 00 00       	call   3d50 <printf>
      exit();
    1e7c:	e8 91 1d 00 00       	call   3c12 <exit>
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(unlink(name) != 0){
      printf(1, "bigdir unlink failed");
    1e81:	c7 44 24 04 da 47 00 	movl   $0x47da,0x4(%esp)
    1e88:	00 
    1e89:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1e90:	e8 bb 1e 00 00       	call   3d50 <printf>
      exit();
    1e95:	e8 78 1d 00 00       	call   3c12 <exit>
  printf(1, "bigdir test\n");
  unlink("bd");

  fd = open("bd", O_CREATE);
  if(fd < 0){
    printf(1, "bigdir create failed\n");
    1e9a:	c7 44 24 04 b0 47 00 	movl   $0x47b0,0x4(%esp)
    1ea1:	00 
    1ea2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ea9:	e8 a2 1e 00 00       	call   3d50 <printf>
    exit();
    1eae:	e8 5f 1d 00 00       	call   3c12 <exit>
    1eb3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001ec0 <subdir>:
  printf(1, "bigdir ok\n");
}

void
subdir(void)
{
    1ec0:	55                   	push   %ebp
    1ec1:	89 e5                	mov    %esp,%ebp
    1ec3:	53                   	push   %ebx
    1ec4:	83 ec 14             	sub    $0x14,%esp
  int fd, cc;

  printf(1, "subdir test\n");
    1ec7:	c7 44 24 04 fa 47 00 	movl   $0x47fa,0x4(%esp)
    1ece:	00 
    1ecf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ed6:	e8 75 1e 00 00       	call   3d50 <printf>

  unlink("ff");
    1edb:	c7 04 24 83 48 00 00 	movl   $0x4883,(%esp)
    1ee2:	e8 7b 1d 00 00       	call   3c62 <unlink>
  if(mkdir("dd") != 0){
    1ee7:	c7 04 24 20 49 00 00 	movl   $0x4920,(%esp)
    1eee:	e8 87 1d 00 00       	call   3c7a <mkdir>
    1ef3:	85 c0                	test   %eax,%eax
    1ef5:	0f 85 07 06 00 00    	jne    2502 <subdir+0x642>
    printf(1, "subdir mkdir dd failed\n");
    exit();
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    1efb:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1f02:	00 
    1f03:	c7 04 24 59 48 00 00 	movl   $0x4859,(%esp)
    1f0a:	e8 43 1d 00 00       	call   3c52 <open>
  if(fd < 0){
    1f0f:	85 c0                	test   %eax,%eax
  if(mkdir("dd") != 0){
    printf(1, "subdir mkdir dd failed\n");
    exit();
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    1f11:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1f13:	0f 88 d0 05 00 00    	js     24e9 <subdir+0x629>
    printf(1, "create dd/ff failed\n");
    exit();
  }
  write(fd, "ff", 2);
    1f19:	c7 44 24 08 02 00 00 	movl   $0x2,0x8(%esp)
    1f20:	00 
    1f21:	c7 44 24 04 83 48 00 	movl   $0x4883,0x4(%esp)
    1f28:	00 
    1f29:	89 04 24             	mov    %eax,(%esp)
    1f2c:	e8 01 1d 00 00       	call   3c32 <write>
  close(fd);
    1f31:	89 1c 24             	mov    %ebx,(%esp)
    1f34:	e8 01 1d 00 00       	call   3c3a <close>

  if(unlink("dd") >= 0){
    1f39:	c7 04 24 20 49 00 00 	movl   $0x4920,(%esp)
    1f40:	e8 1d 1d 00 00       	call   3c62 <unlink>
    1f45:	85 c0                	test   %eax,%eax
    1f47:	0f 89 83 05 00 00    	jns    24d0 <subdir+0x610>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    exit();
  }

  if(mkdir("/dd/dd") != 0){
    1f4d:	c7 04 24 34 48 00 00 	movl   $0x4834,(%esp)
    1f54:	e8 21 1d 00 00       	call   3c7a <mkdir>
    1f59:	85 c0                	test   %eax,%eax
    1f5b:	0f 85 56 05 00 00    	jne    24b7 <subdir+0x5f7>
    printf(1, "subdir mkdir dd/dd failed\n");
    exit();
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1f61:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1f68:	00 
    1f69:	c7 04 24 56 48 00 00 	movl   $0x4856,(%esp)
    1f70:	e8 dd 1c 00 00       	call   3c52 <open>
  if(fd < 0){
    1f75:	85 c0                	test   %eax,%eax
  if(mkdir("/dd/dd") != 0){
    printf(1, "subdir mkdir dd/dd failed\n");
    exit();
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1f77:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1f79:	0f 88 25 04 00 00    	js     23a4 <subdir+0x4e4>
    printf(1, "create dd/dd/ff failed\n");
    exit();
  }
  write(fd, "FF", 2);
    1f7f:	c7 44 24 08 02 00 00 	movl   $0x2,0x8(%esp)
    1f86:	00 
    1f87:	c7 44 24 04 77 48 00 	movl   $0x4877,0x4(%esp)
    1f8e:	00 
    1f8f:	89 04 24             	mov    %eax,(%esp)
    1f92:	e8 9b 1c 00 00       	call   3c32 <write>
  close(fd);
    1f97:	89 1c 24             	mov    %ebx,(%esp)
    1f9a:	e8 9b 1c 00 00       	call   3c3a <close>

  fd = open("dd/dd/../ff", 0);
    1f9f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1fa6:	00 
    1fa7:	c7 04 24 7a 48 00 00 	movl   $0x487a,(%esp)
    1fae:	e8 9f 1c 00 00       	call   3c52 <open>
  if(fd < 0){
    1fb3:	85 c0                	test   %eax,%eax
    exit();
  }
  write(fd, "FF", 2);
  close(fd);

  fd = open("dd/dd/../ff", 0);
    1fb5:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1fb7:	0f 88 ce 03 00 00    	js     238b <subdir+0x4cb>
    printf(1, "open dd/dd/../ff failed\n");
    exit();
  }
  cc = read(fd, buf, sizeof(buf));
    1fbd:	c7 44 24 08 00 20 00 	movl   $0x2000,0x8(%esp)
    1fc4:	00 
    1fc5:	c7 44 24 04 e0 88 00 	movl   $0x88e0,0x4(%esp)
    1fcc:	00 
    1fcd:	89 04 24             	mov    %eax,(%esp)
    1fd0:	e8 55 1c 00 00       	call   3c2a <read>
  if(cc != 2 || buf[0] != 'f'){
    1fd5:	83 f8 02             	cmp    $0x2,%eax
    1fd8:	0f 85 fe 02 00 00    	jne    22dc <subdir+0x41c>
    1fde:	80 3d e0 88 00 00 66 	cmpb   $0x66,0x88e0
    1fe5:	0f 85 f1 02 00 00    	jne    22dc <subdir+0x41c>
    printf(1, "dd/dd/../ff wrong content\n");
    exit();
  }
  close(fd);
    1feb:	89 1c 24             	mov    %ebx,(%esp)
    1fee:	e8 47 1c 00 00       	call   3c3a <close>

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    1ff3:	c7 44 24 04 ba 48 00 	movl   $0x48ba,0x4(%esp)
    1ffa:	00 
    1ffb:	c7 04 24 56 48 00 00 	movl   $0x4856,(%esp)
    2002:	e8 6b 1c 00 00       	call   3c72 <link>
    2007:	85 c0                	test   %eax,%eax
    2009:	0f 85 c7 03 00 00    	jne    23d6 <subdir+0x516>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    exit();
  }

  if(unlink("dd/dd/ff") != 0){
    200f:	c7 04 24 56 48 00 00 	movl   $0x4856,(%esp)
    2016:	e8 47 1c 00 00       	call   3c62 <unlink>
    201b:	85 c0                	test   %eax,%eax
    201d:	0f 85 eb 02 00 00    	jne    230e <subdir+0x44e>
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2023:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    202a:	00 
    202b:	c7 04 24 56 48 00 00 	movl   $0x4856,(%esp)
    2032:	e8 1b 1c 00 00       	call   3c52 <open>
    2037:	85 c0                	test   %eax,%eax
    2039:	0f 89 5f 04 00 00    	jns    249e <subdir+0x5de>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    exit();
  }

  if(chdir("dd") != 0){
    203f:	c7 04 24 20 49 00 00 	movl   $0x4920,(%esp)
    2046:	e8 37 1c 00 00       	call   3c82 <chdir>
    204b:	85 c0                	test   %eax,%eax
    204d:	0f 85 32 04 00 00    	jne    2485 <subdir+0x5c5>
    printf(1, "chdir dd failed\n");
    exit();
  }
  if(chdir("dd/../../dd") != 0){
    2053:	c7 04 24 ee 48 00 00 	movl   $0x48ee,(%esp)
    205a:	e8 23 1c 00 00       	call   3c82 <chdir>
    205f:	85 c0                	test   %eax,%eax
    2061:	0f 85 8e 02 00 00    	jne    22f5 <subdir+0x435>
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("dd/../../../dd") != 0){
    2067:	c7 04 24 14 49 00 00 	movl   $0x4914,(%esp)
    206e:	e8 0f 1c 00 00       	call   3c82 <chdir>
    2073:	85 c0                	test   %eax,%eax
    2075:	0f 85 7a 02 00 00    	jne    22f5 <subdir+0x435>
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("./..") != 0){
    207b:	c7 04 24 23 49 00 00 	movl   $0x4923,(%esp)
    2082:	e8 fb 1b 00 00       	call   3c82 <chdir>
    2087:	85 c0                	test   %eax,%eax
    2089:	0f 85 2e 03 00 00    	jne    23bd <subdir+0x4fd>
    printf(1, "chdir ./.. failed\n");
    exit();
  }

  fd = open("dd/dd/ffff", 0);
    208f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2096:	00 
    2097:	c7 04 24 ba 48 00 00 	movl   $0x48ba,(%esp)
    209e:	e8 af 1b 00 00       	call   3c52 <open>
  if(fd < 0){
    20a3:	85 c0                	test   %eax,%eax
  if(chdir("./..") != 0){
    printf(1, "chdir ./.. failed\n");
    exit();
  }

  fd = open("dd/dd/ffff", 0);
    20a5:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    20a7:	0f 88 81 05 00 00    	js     262e <subdir+0x76e>
    printf(1, "open dd/dd/ffff failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    20ad:	c7 44 24 08 00 20 00 	movl   $0x2000,0x8(%esp)
    20b4:	00 
    20b5:	c7 44 24 04 e0 88 00 	movl   $0x88e0,0x4(%esp)
    20bc:	00 
    20bd:	89 04 24             	mov    %eax,(%esp)
    20c0:	e8 65 1b 00 00       	call   3c2a <read>
    20c5:	83 f8 02             	cmp    $0x2,%eax
    20c8:	0f 85 47 05 00 00    	jne    2615 <subdir+0x755>
    printf(1, "read dd/dd/ffff wrong len\n");
    exit();
  }
  close(fd);
    20ce:	89 1c 24             	mov    %ebx,(%esp)
    20d1:	e8 64 1b 00 00       	call   3c3a <close>

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    20d6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    20dd:	00 
    20de:	c7 04 24 56 48 00 00 	movl   $0x4856,(%esp)
    20e5:	e8 68 1b 00 00       	call   3c52 <open>
    20ea:	85 c0                	test   %eax,%eax
    20ec:	0f 89 4e 02 00 00    	jns    2340 <subdir+0x480>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    exit();
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    20f2:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    20f9:	00 
    20fa:	c7 04 24 6e 49 00 00 	movl   $0x496e,(%esp)
    2101:	e8 4c 1b 00 00       	call   3c52 <open>
    2106:	85 c0                	test   %eax,%eax
    2108:	0f 89 19 02 00 00    	jns    2327 <subdir+0x467>
    printf(1, "create dd/ff/ff succeeded!\n");
    exit();
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    210e:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    2115:	00 
    2116:	c7 04 24 93 49 00 00 	movl   $0x4993,(%esp)
    211d:	e8 30 1b 00 00       	call   3c52 <open>
    2122:	85 c0                	test   %eax,%eax
    2124:	0f 89 42 03 00 00    	jns    246c <subdir+0x5ac>
    printf(1, "create dd/xx/ff succeeded!\n");
    exit();
  }
  if(open("dd", O_CREATE) >= 0){
    212a:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    2131:	00 
    2132:	c7 04 24 20 49 00 00 	movl   $0x4920,(%esp)
    2139:	e8 14 1b 00 00       	call   3c52 <open>
    213e:	85 c0                	test   %eax,%eax
    2140:	0f 89 0d 03 00 00    	jns    2453 <subdir+0x593>
    printf(1, "create dd succeeded!\n");
    exit();
  }
  if(open("dd", O_RDWR) >= 0){
    2146:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    214d:	00 
    214e:	c7 04 24 20 49 00 00 	movl   $0x4920,(%esp)
    2155:	e8 f8 1a 00 00       	call   3c52 <open>
    215a:	85 c0                	test   %eax,%eax
    215c:	0f 89 d8 02 00 00    	jns    243a <subdir+0x57a>
    printf(1, "open dd rdwr succeeded!\n");
    exit();
  }
  if(open("dd", O_WRONLY) >= 0){
    2162:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    2169:	00 
    216a:	c7 04 24 20 49 00 00 	movl   $0x4920,(%esp)
    2171:	e8 dc 1a 00 00       	call   3c52 <open>
    2176:	85 c0                	test   %eax,%eax
    2178:	0f 89 a3 02 00 00    	jns    2421 <subdir+0x561>
    printf(1, "open dd wronly succeeded!\n");
    exit();
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    217e:	c7 44 24 04 02 4a 00 	movl   $0x4a02,0x4(%esp)
    2185:	00 
    2186:	c7 04 24 6e 49 00 00 	movl   $0x496e,(%esp)
    218d:	e8 e0 1a 00 00       	call   3c72 <link>
    2192:	85 c0                	test   %eax,%eax
    2194:	0f 84 6e 02 00 00    	je     2408 <subdir+0x548>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    219a:	c7 44 24 04 02 4a 00 	movl   $0x4a02,0x4(%esp)
    21a1:	00 
    21a2:	c7 04 24 93 49 00 00 	movl   $0x4993,(%esp)
    21a9:	e8 c4 1a 00 00       	call   3c72 <link>
    21ae:	85 c0                	test   %eax,%eax
    21b0:	0f 84 39 02 00 00    	je     23ef <subdir+0x52f>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    21b6:	c7 44 24 04 ba 48 00 	movl   $0x48ba,0x4(%esp)
    21bd:	00 
    21be:	c7 04 24 59 48 00 00 	movl   $0x4859,(%esp)
    21c5:	e8 a8 1a 00 00       	call   3c72 <link>
    21ca:	85 c0                	test   %eax,%eax
    21cc:	0f 84 a0 01 00 00    	je     2372 <subdir+0x4b2>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    exit();
  }
  if(mkdir("dd/ff/ff") == 0){
    21d2:	c7 04 24 6e 49 00 00 	movl   $0x496e,(%esp)
    21d9:	e8 9c 1a 00 00       	call   3c7a <mkdir>
    21de:	85 c0                	test   %eax,%eax
    21e0:	0f 84 73 01 00 00    	je     2359 <subdir+0x499>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/xx/ff") == 0){
    21e6:	c7 04 24 93 49 00 00 	movl   $0x4993,(%esp)
    21ed:	e8 88 1a 00 00       	call   3c7a <mkdir>
    21f2:	85 c0                	test   %eax,%eax
    21f4:	0f 84 02 04 00 00    	je     25fc <subdir+0x73c>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/dd/ffff") == 0){
    21fa:	c7 04 24 ba 48 00 00 	movl   $0x48ba,(%esp)
    2201:	e8 74 1a 00 00       	call   3c7a <mkdir>
    2206:	85 c0                	test   %eax,%eax
    2208:	0f 84 d5 03 00 00    	je     25e3 <subdir+0x723>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    exit();
  }
  if(unlink("dd/xx/ff") == 0){
    220e:	c7 04 24 93 49 00 00 	movl   $0x4993,(%esp)
    2215:	e8 48 1a 00 00       	call   3c62 <unlink>
    221a:	85 c0                	test   %eax,%eax
    221c:	0f 84 a8 03 00 00    	je     25ca <subdir+0x70a>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    exit();
  }
  if(unlink("dd/ff/ff") == 0){
    2222:	c7 04 24 6e 49 00 00 	movl   $0x496e,(%esp)
    2229:	e8 34 1a 00 00       	call   3c62 <unlink>
    222e:	85 c0                	test   %eax,%eax
    2230:	0f 84 7b 03 00 00    	je     25b1 <subdir+0x6f1>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/ff") == 0){
    2236:	c7 04 24 59 48 00 00 	movl   $0x4859,(%esp)
    223d:	e8 40 1a 00 00       	call   3c82 <chdir>
    2242:	85 c0                	test   %eax,%eax
    2244:	0f 84 4e 03 00 00    	je     2598 <subdir+0x6d8>
    printf(1, "chdir dd/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/xx") == 0){
    224a:	c7 04 24 05 4a 00 00 	movl   $0x4a05,(%esp)
    2251:	e8 2c 1a 00 00       	call   3c82 <chdir>
    2256:	85 c0                	test   %eax,%eax
    2258:	0f 84 21 03 00 00    	je     257f <subdir+0x6bf>
    printf(1, "chdir dd/xx succeeded!\n");
    exit();
  }

  if(unlink("dd/dd/ffff") != 0){
    225e:	c7 04 24 ba 48 00 00 	movl   $0x48ba,(%esp)
    2265:	e8 f8 19 00 00       	call   3c62 <unlink>
    226a:	85 c0                	test   %eax,%eax
    226c:	0f 85 9c 00 00 00    	jne    230e <subdir+0x44e>
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(unlink("dd/ff") != 0){
    2272:	c7 04 24 59 48 00 00 	movl   $0x4859,(%esp)
    2279:	e8 e4 19 00 00       	call   3c62 <unlink>
    227e:	85 c0                	test   %eax,%eax
    2280:	0f 85 e0 02 00 00    	jne    2566 <subdir+0x6a6>
    printf(1, "unlink dd/ff failed\n");
    exit();
  }
  if(unlink("dd") == 0){
    2286:	c7 04 24 20 49 00 00 	movl   $0x4920,(%esp)
    228d:	e8 d0 19 00 00       	call   3c62 <unlink>
    2292:	85 c0                	test   %eax,%eax
    2294:	0f 84 b3 02 00 00    	je     254d <subdir+0x68d>
    printf(1, "unlink non-empty dd succeeded!\n");
    exit();
  }
  if(unlink("dd/dd") < 0){
    229a:	c7 04 24 35 48 00 00 	movl   $0x4835,(%esp)
    22a1:	e8 bc 19 00 00       	call   3c62 <unlink>
    22a6:	85 c0                	test   %eax,%eax
    22a8:	0f 88 86 02 00 00    	js     2534 <subdir+0x674>
    printf(1, "unlink dd/dd failed\n");
    exit();
  }
  if(unlink("dd") < 0){
    22ae:	c7 04 24 20 49 00 00 	movl   $0x4920,(%esp)
    22b5:	e8 a8 19 00 00       	call   3c62 <unlink>
    22ba:	85 c0                	test   %eax,%eax
    22bc:	0f 88 59 02 00 00    	js     251b <subdir+0x65b>
    printf(1, "unlink dd failed\n");
    exit();
  }

  printf(1, "subdir ok\n");
    22c2:	c7 44 24 04 02 4b 00 	movl   $0x4b02,0x4(%esp)
    22c9:	00 
    22ca:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    22d1:	e8 7a 1a 00 00       	call   3d50 <printf>
}
    22d6:	83 c4 14             	add    $0x14,%esp
    22d9:	5b                   	pop    %ebx
    22da:	5d                   	pop    %ebp
    22db:	c3                   	ret    
    printf(1, "open dd/dd/../ff failed\n");
    exit();
  }
  cc = read(fd, buf, sizeof(buf));
  if(cc != 2 || buf[0] != 'f'){
    printf(1, "dd/dd/../ff wrong content\n");
    22dc:	c7 44 24 04 9f 48 00 	movl   $0x489f,0x4(%esp)
    22e3:	00 
    22e4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    22eb:	e8 60 1a 00 00       	call   3d50 <printf>
    exit();
    22f0:	e8 1d 19 00 00       	call   3c12 <exit>
  if(chdir("dd") != 0){
    printf(1, "chdir dd failed\n");
    exit();
  }
  if(chdir("dd/../../dd") != 0){
    printf(1, "chdir dd/../../dd failed\n");
    22f5:	c7 44 24 04 fa 48 00 	movl   $0x48fa,0x4(%esp)
    22fc:	00 
    22fd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2304:	e8 47 1a 00 00       	call   3d50 <printf>
    exit();
    2309:	e8 04 19 00 00       	call   3c12 <exit>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    exit();
  }

  if(unlink("dd/dd/ff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    230e:	c7 44 24 04 c5 48 00 	movl   $0x48c5,0x4(%esp)
    2315:	00 
    2316:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    231d:	e8 2e 1a 00 00       	call   3d50 <printf>
    exit();
    2322:	e8 eb 18 00 00       	call   3c12 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    exit();
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/ff/ff succeeded!\n");
    2327:	c7 44 24 04 77 49 00 	movl   $0x4977,0x4(%esp)
    232e:	00 
    232f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2336:	e8 15 1a 00 00       	call   3d50 <printf>
    exit();
    233b:	e8 d2 18 00 00       	call   3c12 <exit>
    exit();
  }
  close(fd);

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    2340:	c7 44 24 04 38 53 00 	movl   $0x5338,0x4(%esp)
    2347:	00 
    2348:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    234f:	e8 fc 19 00 00       	call   3d50 <printf>
    exit();
    2354:	e8 b9 18 00 00       	call   3c12 <exit>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    exit();
  }
  if(mkdir("dd/ff/ff") == 0){
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    2359:	c7 44 24 04 0b 4a 00 	movl   $0x4a0b,0x4(%esp)
    2360:	00 
    2361:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2368:	e8 e3 19 00 00       	call   3d50 <printf>
    exit();
    236d:	e8 a0 18 00 00       	call   3c12 <exit>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    2372:	c7 44 24 04 a8 53 00 	movl   $0x53a8,0x4(%esp)
    2379:	00 
    237a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2381:	e8 ca 19 00 00       	call   3d50 <printf>
    exit();
    2386:	e8 87 18 00 00       	call   3c12 <exit>
  write(fd, "FF", 2);
  close(fd);

  fd = open("dd/dd/../ff", 0);
  if(fd < 0){
    printf(1, "open dd/dd/../ff failed\n");
    238b:	c7 44 24 04 86 48 00 	movl   $0x4886,0x4(%esp)
    2392:	00 
    2393:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    239a:	e8 b1 19 00 00       	call   3d50 <printf>
    exit();
    239f:	e8 6e 18 00 00       	call   3c12 <exit>
    exit();
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create dd/dd/ff failed\n");
    23a4:	c7 44 24 04 5f 48 00 	movl   $0x485f,0x4(%esp)
    23ab:	00 
    23ac:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    23b3:	e8 98 19 00 00       	call   3d50 <printf>
    exit();
    23b8:	e8 55 18 00 00       	call   3c12 <exit>
  if(chdir("dd/../../../dd") != 0){
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("./..") != 0){
    printf(1, "chdir ./.. failed\n");
    23bd:	c7 44 24 04 28 49 00 	movl   $0x4928,0x4(%esp)
    23c4:	00 
    23c5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    23cc:	e8 7f 19 00 00       	call   3d50 <printf>
    exit();
    23d1:	e8 3c 18 00 00       	call   3c12 <exit>
    exit();
  }
  close(fd);

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    23d6:	c7 44 24 04 f0 52 00 	movl   $0x52f0,0x4(%esp)
    23dd:	00 
    23de:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    23e5:	e8 66 19 00 00       	call   3d50 <printf>
    exit();
    23ea:	e8 23 18 00 00       	call   3c12 <exit>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    23ef:	c7 44 24 04 84 53 00 	movl   $0x5384,0x4(%esp)
    23f6:	00 
    23f7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    23fe:	e8 4d 19 00 00       	call   3d50 <printf>
    exit();
    2403:	e8 0a 18 00 00       	call   3c12 <exit>
  if(open("dd", O_WRONLY) >= 0){
    printf(1, "open dd wronly succeeded!\n");
    exit();
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    2408:	c7 44 24 04 60 53 00 	movl   $0x5360,0x4(%esp)
    240f:	00 
    2410:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2417:	e8 34 19 00 00       	call   3d50 <printf>
    exit();
    241c:	e8 f1 17 00 00       	call   3c12 <exit>
  if(open("dd", O_RDWR) >= 0){
    printf(1, "open dd rdwr succeeded!\n");
    exit();
  }
  if(open("dd", O_WRONLY) >= 0){
    printf(1, "open dd wronly succeeded!\n");
    2421:	c7 44 24 04 e7 49 00 	movl   $0x49e7,0x4(%esp)
    2428:	00 
    2429:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2430:	e8 1b 19 00 00       	call   3d50 <printf>
    exit();
    2435:	e8 d8 17 00 00       	call   3c12 <exit>
  if(open("dd", O_CREATE) >= 0){
    printf(1, "create dd succeeded!\n");
    exit();
  }
  if(open("dd", O_RDWR) >= 0){
    printf(1, "open dd rdwr succeeded!\n");
    243a:	c7 44 24 04 ce 49 00 	movl   $0x49ce,0x4(%esp)
    2441:	00 
    2442:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2449:	e8 02 19 00 00       	call   3d50 <printf>
    exit();
    244e:	e8 bf 17 00 00       	call   3c12 <exit>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/xx/ff succeeded!\n");
    exit();
  }
  if(open("dd", O_CREATE) >= 0){
    printf(1, "create dd succeeded!\n");
    2453:	c7 44 24 04 b8 49 00 	movl   $0x49b8,0x4(%esp)
    245a:	00 
    245b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2462:	e8 e9 18 00 00       	call   3d50 <printf>
    exit();
    2467:	e8 a6 17 00 00       	call   3c12 <exit>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/ff/ff succeeded!\n");
    exit();
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/xx/ff succeeded!\n");
    246c:	c7 44 24 04 9c 49 00 	movl   $0x499c,0x4(%esp)
    2473:	00 
    2474:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    247b:	e8 d0 18 00 00       	call   3d50 <printf>
    exit();
    2480:	e8 8d 17 00 00       	call   3c12 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    exit();
  }

  if(chdir("dd") != 0){
    printf(1, "chdir dd failed\n");
    2485:	c7 44 24 04 dd 48 00 	movl   $0x48dd,0x4(%esp)
    248c:	00 
    248d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2494:	e8 b7 18 00 00       	call   3d50 <printf>
    exit();
    2499:	e8 74 17 00 00       	call   3c12 <exit>
  if(unlink("dd/dd/ff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    249e:	c7 44 24 04 14 53 00 	movl   $0x5314,0x4(%esp)
    24a5:	00 
    24a6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    24ad:	e8 9e 18 00 00       	call   3d50 <printf>
    exit();
    24b2:	e8 5b 17 00 00       	call   3c12 <exit>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    exit();
  }

  if(mkdir("/dd/dd") != 0){
    printf(1, "subdir mkdir dd/dd failed\n");
    24b7:	c7 44 24 04 3b 48 00 	movl   $0x483b,0x4(%esp)
    24be:	00 
    24bf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    24c6:	e8 85 18 00 00       	call   3d50 <printf>
    exit();
    24cb:	e8 42 17 00 00       	call   3c12 <exit>
  }
  write(fd, "ff", 2);
  close(fd);

  if(unlink("dd") >= 0){
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    24d0:	c7 44 24 04 c8 52 00 	movl   $0x52c8,0x4(%esp)
    24d7:	00 
    24d8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    24df:	e8 6c 18 00 00       	call   3d50 <printf>
    exit();
    24e4:	e8 29 17 00 00       	call   3c12 <exit>
    exit();
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create dd/ff failed\n");
    24e9:	c7 44 24 04 1f 48 00 	movl   $0x481f,0x4(%esp)
    24f0:	00 
    24f1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    24f8:	e8 53 18 00 00       	call   3d50 <printf>
    exit();
    24fd:	e8 10 17 00 00       	call   3c12 <exit>

  printf(1, "subdir test\n");

  unlink("ff");
  if(mkdir("dd") != 0){
    printf(1, "subdir mkdir dd failed\n");
    2502:	c7 44 24 04 07 48 00 	movl   $0x4807,0x4(%esp)
    2509:	00 
    250a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2511:	e8 3a 18 00 00       	call   3d50 <printf>
    exit();
    2516:	e8 f7 16 00 00       	call   3c12 <exit>
  if(unlink("dd/dd") < 0){
    printf(1, "unlink dd/dd failed\n");
    exit();
  }
  if(unlink("dd") < 0){
    printf(1, "unlink dd failed\n");
    251b:	c7 44 24 04 f0 4a 00 	movl   $0x4af0,0x4(%esp)
    2522:	00 
    2523:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    252a:	e8 21 18 00 00       	call   3d50 <printf>
    exit();
    252f:	e8 de 16 00 00       	call   3c12 <exit>
  if(unlink("dd") == 0){
    printf(1, "unlink non-empty dd succeeded!\n");
    exit();
  }
  if(unlink("dd/dd") < 0){
    printf(1, "unlink dd/dd failed\n");
    2534:	c7 44 24 04 db 4a 00 	movl   $0x4adb,0x4(%esp)
    253b:	00 
    253c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2543:	e8 08 18 00 00       	call   3d50 <printf>
    exit();
    2548:	e8 c5 16 00 00       	call   3c12 <exit>
  if(unlink("dd/ff") != 0){
    printf(1, "unlink dd/ff failed\n");
    exit();
  }
  if(unlink("dd") == 0){
    printf(1, "unlink non-empty dd succeeded!\n");
    254d:	c7 44 24 04 cc 53 00 	movl   $0x53cc,0x4(%esp)
    2554:	00 
    2555:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    255c:	e8 ef 17 00 00       	call   3d50 <printf>
    exit();
    2561:	e8 ac 16 00 00       	call   3c12 <exit>
  if(unlink("dd/dd/ffff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(unlink("dd/ff") != 0){
    printf(1, "unlink dd/ff failed\n");
    2566:	c7 44 24 04 c6 4a 00 	movl   $0x4ac6,0x4(%esp)
    256d:	00 
    256e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2575:	e8 d6 17 00 00       	call   3d50 <printf>
    exit();
    257a:	e8 93 16 00 00       	call   3c12 <exit>
  if(chdir("dd/ff") == 0){
    printf(1, "chdir dd/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/xx") == 0){
    printf(1, "chdir dd/xx succeeded!\n");
    257f:	c7 44 24 04 ae 4a 00 	movl   $0x4aae,0x4(%esp)
    2586:	00 
    2587:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    258e:	e8 bd 17 00 00       	call   3d50 <printf>
    exit();
    2593:	e8 7a 16 00 00       	call   3c12 <exit>
  if(unlink("dd/ff/ff") == 0){
    printf(1, "unlink dd/ff/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/ff") == 0){
    printf(1, "chdir dd/ff succeeded!\n");
    2598:	c7 44 24 04 96 4a 00 	movl   $0x4a96,0x4(%esp)
    259f:	00 
    25a0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    25a7:	e8 a4 17 00 00       	call   3d50 <printf>
    exit();
    25ac:	e8 61 16 00 00       	call   3c12 <exit>
  if(unlink("dd/xx/ff") == 0){
    printf(1, "unlink dd/xx/ff succeeded!\n");
    exit();
  }
  if(unlink("dd/ff/ff") == 0){
    printf(1, "unlink dd/ff/ff succeeded!\n");
    25b1:	c7 44 24 04 7a 4a 00 	movl   $0x4a7a,0x4(%esp)
    25b8:	00 
    25b9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    25c0:	e8 8b 17 00 00       	call   3d50 <printf>
    exit();
    25c5:	e8 48 16 00 00       	call   3c12 <exit>
  if(mkdir("dd/dd/ffff") == 0){
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    exit();
  }
  if(unlink("dd/xx/ff") == 0){
    printf(1, "unlink dd/xx/ff succeeded!\n");
    25ca:	c7 44 24 04 5e 4a 00 	movl   $0x4a5e,0x4(%esp)
    25d1:	00 
    25d2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    25d9:	e8 72 17 00 00       	call   3d50 <printf>
    exit();
    25de:	e8 2f 16 00 00       	call   3c12 <exit>
  if(mkdir("dd/xx/ff") == 0){
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/dd/ffff") == 0){
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    25e3:	c7 44 24 04 41 4a 00 	movl   $0x4a41,0x4(%esp)
    25ea:	00 
    25eb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    25f2:	e8 59 17 00 00       	call   3d50 <printf>
    exit();
    25f7:	e8 16 16 00 00       	call   3c12 <exit>
  if(mkdir("dd/ff/ff") == 0){
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/xx/ff") == 0){
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    25fc:	c7 44 24 04 26 4a 00 	movl   $0x4a26,0x4(%esp)
    2603:	00 
    2604:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    260b:	e8 40 17 00 00       	call   3d50 <printf>
    exit();
    2610:	e8 fd 15 00 00       	call   3c12 <exit>
  if(fd < 0){
    printf(1, "open dd/dd/ffff failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    printf(1, "read dd/dd/ffff wrong len\n");
    2615:	c7 44 24 04 53 49 00 	movl   $0x4953,0x4(%esp)
    261c:	00 
    261d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2624:	e8 27 17 00 00       	call   3d50 <printf>
    exit();
    2629:	e8 e4 15 00 00       	call   3c12 <exit>
    exit();
  }

  fd = open("dd/dd/ffff", 0);
  if(fd < 0){
    printf(1, "open dd/dd/ffff failed\n");
    262e:	c7 44 24 04 3b 49 00 	movl   $0x493b,0x4(%esp)
    2635:	00 
    2636:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    263d:	e8 0e 17 00 00       	call   3d50 <printf>
    exit();
    2642:	e8 cb 15 00 00       	call   3c12 <exit>
    2647:	89 f6                	mov    %esi,%esi
    2649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002650 <bigwrite>:
}

// test writes that are larger than the log.
void
bigwrite(void)
{
    2650:	55                   	push   %ebp
    2651:	89 e5                	mov    %esp,%ebp
    2653:	56                   	push   %esi
    2654:	53                   	push   %ebx
  int fd, sz;

  printf(1, "bigwrite test\n");

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    2655:	bb f3 01 00 00       	mov    $0x1f3,%ebx
}

// test writes that are larger than the log.
void
bigwrite(void)
{
    265a:	83 ec 10             	sub    $0x10,%esp
  int fd, sz;

  printf(1, "bigwrite test\n");
    265d:	c7 44 24 04 0d 4b 00 	movl   $0x4b0d,0x4(%esp)
    2664:	00 
    2665:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    266c:	e8 df 16 00 00       	call   3d50 <printf>

  unlink("bigwrite");
    2671:	c7 04 24 1c 4b 00 00 	movl   $0x4b1c,(%esp)
    2678:	e8 e5 15 00 00       	call   3c62 <unlink>
    267d:	8d 76 00             	lea    0x0(%esi),%esi
  for(sz = 499; sz < 12*512; sz += 471){
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2680:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    2687:	00 
    2688:	c7 04 24 1c 4b 00 00 	movl   $0x4b1c,(%esp)
    268f:	e8 be 15 00 00       	call   3c52 <open>
    if(fd < 0){
    2694:	85 c0                	test   %eax,%eax

  printf(1, "bigwrite test\n");

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2696:	89 c6                	mov    %eax,%esi
    if(fd < 0){
    2698:	0f 88 8e 00 00 00    	js     272c <bigwrite+0xdc>
      printf(1, "cannot create bigwrite\n");
      exit();
    }
    int i;
    for(i = 0; i < 2; i++){
      int cc = write(fd, buf, sz);
    269e:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    26a2:	c7 44 24 04 e0 88 00 	movl   $0x88e0,0x4(%esp)
    26a9:	00 
    26aa:	89 04 24             	mov    %eax,(%esp)
    26ad:	e8 80 15 00 00       	call   3c32 <write>
      if(cc != sz){
    26b2:	39 d8                	cmp    %ebx,%eax
    26b4:	75 55                	jne    270b <bigwrite+0xbb>
      printf(1, "cannot create bigwrite\n");
      exit();
    }
    int i;
    for(i = 0; i < 2; i++){
      int cc = write(fd, buf, sz);
    26b6:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    26ba:	c7 44 24 04 e0 88 00 	movl   $0x88e0,0x4(%esp)
    26c1:	00 
    26c2:	89 34 24             	mov    %esi,(%esp)
    26c5:	e8 68 15 00 00       	call   3c32 <write>
      if(cc != sz){
    26ca:	39 c3                	cmp    %eax,%ebx
    26cc:	75 3d                	jne    270b <bigwrite+0xbb>
        printf(1, "write(%d) ret %d\n", sz, cc);
        exit();
      }
    }
    close(fd);
    26ce:	89 34 24             	mov    %esi,(%esp)
  int fd, sz;

  printf(1, "bigwrite test\n");

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    26d1:	81 c3 d7 01 00 00    	add    $0x1d7,%ebx
      if(cc != sz){
        printf(1, "write(%d) ret %d\n", sz, cc);
        exit();
      }
    }
    close(fd);
    26d7:	e8 5e 15 00 00       	call   3c3a <close>
    unlink("bigwrite");
    26dc:	c7 04 24 1c 4b 00 00 	movl   $0x4b1c,(%esp)
    26e3:	e8 7a 15 00 00       	call   3c62 <unlink>
  int fd, sz;

  printf(1, "bigwrite test\n");

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    26e8:	81 fb 07 18 00 00    	cmp    $0x1807,%ebx
    26ee:	75 90                	jne    2680 <bigwrite+0x30>
    }
    close(fd);
    unlink("bigwrite");
  }

  printf(1, "bigwrite ok\n");
    26f0:	c7 44 24 04 4f 4b 00 	movl   $0x4b4f,0x4(%esp)
    26f7:	00 
    26f8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    26ff:	e8 4c 16 00 00       	call   3d50 <printf>
}
    2704:	83 c4 10             	add    $0x10,%esp
    2707:	5b                   	pop    %ebx
    2708:	5e                   	pop    %esi
    2709:	5d                   	pop    %ebp
    270a:	c3                   	ret    
    }
    int i;
    for(i = 0; i < 2; i++){
      int cc = write(fd, buf, sz);
      if(cc != sz){
        printf(1, "write(%d) ret %d\n", sz, cc);
    270b:	89 44 24 0c          	mov    %eax,0xc(%esp)
    270f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    2713:	c7 44 24 04 3d 4b 00 	movl   $0x4b3d,0x4(%esp)
    271a:	00 
    271b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2722:	e8 29 16 00 00       	call   3d50 <printf>
        exit();
    2727:	e8 e6 14 00 00       	call   3c12 <exit>

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    fd = open("bigwrite", O_CREATE | O_RDWR);
    if(fd < 0){
      printf(1, "cannot create bigwrite\n");
    272c:	c7 44 24 04 25 4b 00 	movl   $0x4b25,0x4(%esp)
    2733:	00 
    2734:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    273b:	e8 10 16 00 00       	call   3d50 <printf>
      exit();
    2740:	e8 cd 14 00 00       	call   3c12 <exit>
    2745:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002750 <bigfile>:
  printf(1, "bigwrite ok\n");
}

void
bigfile(void)
{
    2750:	55                   	push   %ebp
    2751:	89 e5                	mov    %esp,%ebp
    2753:	57                   	push   %edi
    2754:	56                   	push   %esi
    2755:	53                   	push   %ebx
    2756:	83 ec 1c             	sub    $0x1c,%esp
  int fd, i, total, cc;

  printf(1, "bigfile test\n");
    2759:	c7 44 24 04 5c 4b 00 	movl   $0x4b5c,0x4(%esp)
    2760:	00 
    2761:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2768:	e8 e3 15 00 00       	call   3d50 <printf>

  unlink("bigfile");
    276d:	c7 04 24 78 4b 00 00 	movl   $0x4b78,(%esp)
    2774:	e8 e9 14 00 00       	call   3c62 <unlink>
  fd = open("bigfile", O_CREATE | O_RDWR);
    2779:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    2780:	00 
    2781:	c7 04 24 78 4b 00 00 	movl   $0x4b78,(%esp)
    2788:	e8 c5 14 00 00       	call   3c52 <open>
  if(fd < 0){
    278d:	85 c0                	test   %eax,%eax
  int fd, i, total, cc;

  printf(1, "bigfile test\n");

  unlink("bigfile");
  fd = open("bigfile", O_CREATE | O_RDWR);
    278f:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    2791:	0f 88 84 01 00 00    	js     291b <bigfile+0x1cb>
    2797:	31 db                	xor    %ebx,%ebx
    2799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    printf(1, "cannot create bigfile");
    exit();
  }
  for(i = 0; i < 20; i++){
    memset(buf, i, 600);
    27a0:	c7 44 24 08 58 02 00 	movl   $0x258,0x8(%esp)
    27a7:	00 
    27a8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    27ac:	c7 04 24 e0 88 00 00 	movl   $0x88e0,(%esp)
    27b3:	e8 c8 12 00 00       	call   3a80 <memset>
    if(write(fd, buf, 600) != 600){
    27b8:	c7 44 24 08 58 02 00 	movl   $0x258,0x8(%esp)
    27bf:	00 
    27c0:	c7 44 24 04 e0 88 00 	movl   $0x88e0,0x4(%esp)
    27c7:	00 
    27c8:	89 34 24             	mov    %esi,(%esp)
    27cb:	e8 62 14 00 00       	call   3c32 <write>
    27d0:	3d 58 02 00 00       	cmp    $0x258,%eax
    27d5:	0f 85 0e 01 00 00    	jne    28e9 <bigfile+0x199>
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "cannot create bigfile");
    exit();
  }
  for(i = 0; i < 20; i++){
    27db:	83 c3 01             	add    $0x1,%ebx
    27de:	83 fb 14             	cmp    $0x14,%ebx
    27e1:	75 bd                	jne    27a0 <bigfile+0x50>
    if(write(fd, buf, 600) != 600){
      printf(1, "write bigfile failed\n");
      exit();
    }
  }
  close(fd);
    27e3:	89 34 24             	mov    %esi,(%esp)
    27e6:	e8 4f 14 00 00       	call   3c3a <close>

  fd = open("bigfile", 0);
    27eb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    27f2:	00 
    27f3:	c7 04 24 78 4b 00 00 	movl   $0x4b78,(%esp)
    27fa:	e8 53 14 00 00       	call   3c52 <open>
  if(fd < 0){
    27ff:	85 c0                	test   %eax,%eax
      exit();
    }
  }
  close(fd);

  fd = open("bigfile", 0);
    2801:	89 c7                	mov    %eax,%edi
  if(fd < 0){
    2803:	0f 88 f9 00 00 00    	js     2902 <bigfile+0x1b2>
    2809:	31 f6                	xor    %esi,%esi
    280b:	31 db                	xor    %ebx,%ebx
    280d:	eb 34                	jmp    2843 <bigfile+0xf3>
    280f:	90                   	nop
      printf(1, "read bigfile failed\n");
      exit();
    }
    if(cc == 0)
      break;
    if(cc != 300){
    2810:	3d 2c 01 00 00       	cmp    $0x12c,%eax
    2815:	0f 85 9c 00 00 00    	jne    28b7 <bigfile+0x167>
      printf(1, "short read bigfile\n");
      exit();
    }
    if(buf[0] != i/2 || buf[299] != i/2){
    281b:	0f be 15 e0 88 00 00 	movsbl 0x88e0,%edx
    2822:	89 d8                	mov    %ebx,%eax
    2824:	c1 e8 1f             	shr    $0x1f,%eax
    2827:	01 d8                	add    %ebx,%eax
    2829:	d1 f8                	sar    %eax
    282b:	39 c2                	cmp    %eax,%edx
    282d:	75 6f                	jne    289e <bigfile+0x14e>
    282f:	0f be 05 0b 8a 00 00 	movsbl 0x8a0b,%eax
    2836:	39 c2                	cmp    %eax,%edx
    2838:	75 64                	jne    289e <bigfile+0x14e>
      printf(1, "read bigfile wrong data\n");
      exit();
    }
    total += cc;
    283a:	81 c6 2c 01 00 00    	add    $0x12c,%esi
  if(fd < 0){
    printf(1, "cannot open bigfile\n");
    exit();
  }
  total = 0;
  for(i = 0; ; i++){
    2840:	83 c3 01             	add    $0x1,%ebx
    cc = read(fd, buf, 300);
    2843:	c7 44 24 08 2c 01 00 	movl   $0x12c,0x8(%esp)
    284a:	00 
    284b:	c7 44 24 04 e0 88 00 	movl   $0x88e0,0x4(%esp)
    2852:	00 
    2853:	89 3c 24             	mov    %edi,(%esp)
    2856:	e8 cf 13 00 00       	call   3c2a <read>
    if(cc < 0){
    285b:	83 f8 00             	cmp    $0x0,%eax
    285e:	7c 70                	jl     28d0 <bigfile+0x180>
      printf(1, "read bigfile failed\n");
      exit();
    }
    if(cc == 0)
    2860:	75 ae                	jne    2810 <bigfile+0xc0>
      printf(1, "read bigfile wrong data\n");
      exit();
    }
    total += cc;
  }
  close(fd);
    2862:	89 3c 24             	mov    %edi,(%esp)
    2865:	e8 d0 13 00 00       	call   3c3a <close>
  if(total != 20*600){
    286a:	81 fe e0 2e 00 00    	cmp    $0x2ee0,%esi
    2870:	0f 85 be 00 00 00    	jne    2934 <bigfile+0x1e4>
    printf(1, "read bigfile wrong total\n");
    exit();
  }
  unlink("bigfile");
    2876:	c7 04 24 78 4b 00 00 	movl   $0x4b78,(%esp)
    287d:	e8 e0 13 00 00       	call   3c62 <unlink>

  printf(1, "bigfile test ok\n");
    2882:	c7 44 24 04 07 4c 00 	movl   $0x4c07,0x4(%esp)
    2889:	00 
    288a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2891:	e8 ba 14 00 00       	call   3d50 <printf>
}
    2896:	83 c4 1c             	add    $0x1c,%esp
    2899:	5b                   	pop    %ebx
    289a:	5e                   	pop    %esi
    289b:	5f                   	pop    %edi
    289c:	5d                   	pop    %ebp
    289d:	c3                   	ret    
    if(cc != 300){
      printf(1, "short read bigfile\n");
      exit();
    }
    if(buf[0] != i/2 || buf[299] != i/2){
      printf(1, "read bigfile wrong data\n");
    289e:	c7 44 24 04 d4 4b 00 	movl   $0x4bd4,0x4(%esp)
    28a5:	00 
    28a6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    28ad:	e8 9e 14 00 00       	call   3d50 <printf>
      exit();
    28b2:	e8 5b 13 00 00       	call   3c12 <exit>
      exit();
    }
    if(cc == 0)
      break;
    if(cc != 300){
      printf(1, "short read bigfile\n");
    28b7:	c7 44 24 04 c0 4b 00 	movl   $0x4bc0,0x4(%esp)
    28be:	00 
    28bf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    28c6:	e8 85 14 00 00       	call   3d50 <printf>
      exit();
    28cb:	e8 42 13 00 00       	call   3c12 <exit>
  }
  total = 0;
  for(i = 0; ; i++){
    cc = read(fd, buf, 300);
    if(cc < 0){
      printf(1, "read bigfile failed\n");
    28d0:	c7 44 24 04 ab 4b 00 	movl   $0x4bab,0x4(%esp)
    28d7:	00 
    28d8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    28df:	e8 6c 14 00 00       	call   3d50 <printf>
      exit();
    28e4:	e8 29 13 00 00       	call   3c12 <exit>
    exit();
  }
  for(i = 0; i < 20; i++){
    memset(buf, i, 600);
    if(write(fd, buf, 600) != 600){
      printf(1, "write bigfile failed\n");
    28e9:	c7 44 24 04 80 4b 00 	movl   $0x4b80,0x4(%esp)
    28f0:	00 
    28f1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    28f8:	e8 53 14 00 00       	call   3d50 <printf>
      exit();
    28fd:	e8 10 13 00 00       	call   3c12 <exit>
  }
  close(fd);

  fd = open("bigfile", 0);
  if(fd < 0){
    printf(1, "cannot open bigfile\n");
    2902:	c7 44 24 04 96 4b 00 	movl   $0x4b96,0x4(%esp)
    2909:	00 
    290a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2911:	e8 3a 14 00 00       	call   3d50 <printf>
    exit();
    2916:	e8 f7 12 00 00       	call   3c12 <exit>
  printf(1, "bigfile test\n");

  unlink("bigfile");
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "cannot create bigfile");
    291b:	c7 44 24 04 6a 4b 00 	movl   $0x4b6a,0x4(%esp)
    2922:	00 
    2923:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    292a:	e8 21 14 00 00       	call   3d50 <printf>
    exit();
    292f:	e8 de 12 00 00       	call   3c12 <exit>
    }
    total += cc;
  }
  close(fd);
  if(total != 20*600){
    printf(1, "read bigfile wrong total\n");
    2934:	c7 44 24 04 ed 4b 00 	movl   $0x4bed,0x4(%esp)
    293b:	00 
    293c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2943:	e8 08 14 00 00       	call   3d50 <printf>
    exit();
    2948:	e8 c5 12 00 00       	call   3c12 <exit>
    294d:	8d 76 00             	lea    0x0(%esi),%esi

00002950 <fourteen>:
  printf(1, "bigfile test ok\n");
}

void
fourteen(void)
{
    2950:	55                   	push   %ebp
    2951:	89 e5                	mov    %esp,%ebp
    2953:	83 ec 18             	sub    $0x18,%esp
  int fd;

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");
    2956:	c7 44 24 04 18 4c 00 	movl   $0x4c18,0x4(%esp)
    295d:	00 
    295e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2965:	e8 e6 13 00 00       	call   3d50 <printf>

  if(mkdir("12345678901234") != 0){
    296a:	c7 04 24 53 4c 00 00 	movl   $0x4c53,(%esp)
    2971:	e8 04 13 00 00       	call   3c7a <mkdir>
    2976:	85 c0                	test   %eax,%eax
    2978:	0f 85 92 00 00 00    	jne    2a10 <fourteen+0xc0>
    printf(1, "mkdir 12345678901234 failed\n");
    exit();
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    297e:	c7 04 24 ec 53 00 00 	movl   $0x53ec,(%esp)
    2985:	e8 f0 12 00 00       	call   3c7a <mkdir>
    298a:	85 c0                	test   %eax,%eax
    298c:	0f 85 fb 00 00 00    	jne    2a8d <fourteen+0x13d>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    exit();
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    2992:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    2999:	00 
    299a:	c7 04 24 3c 54 00 00 	movl   $0x543c,(%esp)
    29a1:	e8 ac 12 00 00       	call   3c52 <open>
  if(fd < 0){
    29a6:	85 c0                	test   %eax,%eax
    29a8:	0f 88 c6 00 00 00    	js     2a74 <fourteen+0x124>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    exit();
  }
  close(fd);
    29ae:	89 04 24             	mov    %eax,(%esp)
    29b1:	e8 84 12 00 00       	call   3c3a <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    29b6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    29bd:	00 
    29be:	c7 04 24 ac 54 00 00 	movl   $0x54ac,(%esp)
    29c5:	e8 88 12 00 00       	call   3c52 <open>
  if(fd < 0){
    29ca:	85 c0                	test   %eax,%eax
    29cc:	0f 88 89 00 00 00    	js     2a5b <fourteen+0x10b>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    exit();
  }
  close(fd);
    29d2:	89 04 24             	mov    %eax,(%esp)
    29d5:	e8 60 12 00 00       	call   3c3a <close>

  if(mkdir("12345678901234/12345678901234") == 0){
    29da:	c7 04 24 44 4c 00 00 	movl   $0x4c44,(%esp)
    29e1:	e8 94 12 00 00       	call   3c7a <mkdir>
    29e6:	85 c0                	test   %eax,%eax
    29e8:	74 58                	je     2a42 <fourteen+0xf2>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    exit();
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    29ea:	c7 04 24 48 55 00 00 	movl   $0x5548,(%esp)
    29f1:	e8 84 12 00 00       	call   3c7a <mkdir>
    29f6:	85 c0                	test   %eax,%eax
    29f8:	74 2f                	je     2a29 <fourteen+0xd9>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    exit();
  }

  printf(1, "fourteen ok\n");
    29fa:	c7 44 24 04 62 4c 00 	movl   $0x4c62,0x4(%esp)
    2a01:	00 
    2a02:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a09:	e8 42 13 00 00       	call   3d50 <printf>
}
    2a0e:	c9                   	leave  
    2a0f:	c3                   	ret    

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");

  if(mkdir("12345678901234") != 0){
    printf(1, "mkdir 12345678901234 failed\n");
    2a10:	c7 44 24 04 27 4c 00 	movl   $0x4c27,0x4(%esp)
    2a17:	00 
    2a18:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a1f:	e8 2c 13 00 00       	call   3d50 <printf>
    exit();
    2a24:	e8 e9 11 00 00       	call   3c12 <exit>
  if(mkdir("12345678901234/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    exit();
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    2a29:	c7 44 24 04 68 55 00 	movl   $0x5568,0x4(%esp)
    2a30:	00 
    2a31:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a38:	e8 13 13 00 00       	call   3d50 <printf>
    exit();
    2a3d:	e8 d0 11 00 00       	call   3c12 <exit>
    exit();
  }
  close(fd);

  if(mkdir("12345678901234/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    2a42:	c7 44 24 04 18 55 00 	movl   $0x5518,0x4(%esp)
    2a49:	00 
    2a4a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a51:	e8 fa 12 00 00       	call   3d50 <printf>
    exit();
    2a56:	e8 b7 11 00 00       	call   3c12 <exit>
    exit();
  }
  close(fd);
  fd = open("12345678901234/12345678901234/12345678901234", 0);
  if(fd < 0){
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    2a5b:	c7 44 24 04 dc 54 00 	movl   $0x54dc,0x4(%esp)
    2a62:	00 
    2a63:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a6a:	e8 e1 12 00 00       	call   3d50 <printf>
    exit();
    2a6f:	e8 9e 11 00 00       	call   3c12 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    exit();
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
  if(fd < 0){
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    2a74:	c7 44 24 04 6c 54 00 	movl   $0x546c,0x4(%esp)
    2a7b:	00 
    2a7c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a83:	e8 c8 12 00 00       	call   3d50 <printf>
    exit();
    2a88:	e8 85 11 00 00       	call   3c12 <exit>
  if(mkdir("12345678901234") != 0){
    printf(1, "mkdir 12345678901234 failed\n");
    exit();
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    2a8d:	c7 44 24 04 0c 54 00 	movl   $0x540c,0x4(%esp)
    2a94:	00 
    2a95:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a9c:	e8 af 12 00 00       	call   3d50 <printf>
    exit();
    2aa1:	e8 6c 11 00 00       	call   3c12 <exit>
    2aa6:	8d 76 00             	lea    0x0(%esi),%esi
    2aa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002ab0 <rmdot>:
  printf(1, "fourteen ok\n");
}

void
rmdot(void)
{
    2ab0:	55                   	push   %ebp
    2ab1:	89 e5                	mov    %esp,%ebp
    2ab3:	83 ec 18             	sub    $0x18,%esp
  printf(1, "rmdot test\n");
    2ab6:	c7 44 24 04 6f 4c 00 	movl   $0x4c6f,0x4(%esp)
    2abd:	00 
    2abe:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ac5:	e8 86 12 00 00       	call   3d50 <printf>
  if(mkdir("dots") != 0){
    2aca:	c7 04 24 7b 4c 00 00 	movl   $0x4c7b,(%esp)
    2ad1:	e8 a4 11 00 00       	call   3c7a <mkdir>
    2ad6:	85 c0                	test   %eax,%eax
    2ad8:	0f 85 9a 00 00 00    	jne    2b78 <rmdot+0xc8>
    printf(1, "mkdir dots failed\n");
    exit();
  }
  if(chdir("dots") != 0){
    2ade:	c7 04 24 7b 4c 00 00 	movl   $0x4c7b,(%esp)
    2ae5:	e8 98 11 00 00       	call   3c82 <chdir>
    2aea:	85 c0                	test   %eax,%eax
    2aec:	0f 85 35 01 00 00    	jne    2c27 <rmdot+0x177>
    printf(1, "chdir dots failed\n");
    exit();
  }
  if(unlink(".") == 0){
    2af2:	c7 04 24 26 49 00 00 	movl   $0x4926,(%esp)
    2af9:	e8 64 11 00 00       	call   3c62 <unlink>
    2afe:	85 c0                	test   %eax,%eax
    2b00:	0f 84 08 01 00 00    	je     2c0e <rmdot+0x15e>
    printf(1, "rm . worked!\n");
    exit();
  }
  if(unlink("..") == 0){
    2b06:	c7 04 24 25 49 00 00 	movl   $0x4925,(%esp)
    2b0d:	e8 50 11 00 00       	call   3c62 <unlink>
    2b12:	85 c0                	test   %eax,%eax
    2b14:	0f 84 db 00 00 00    	je     2bf5 <rmdot+0x145>
    printf(1, "rm .. worked!\n");
    exit();
  }
  if(chdir("/") != 0){
    2b1a:	c7 04 24 f9 40 00 00 	movl   $0x40f9,(%esp)
    2b21:	e8 5c 11 00 00       	call   3c82 <chdir>
    2b26:	85 c0                	test   %eax,%eax
    2b28:	0f 85 ae 00 00 00    	jne    2bdc <rmdot+0x12c>
    printf(1, "chdir / failed\n");
    exit();
  }
  if(unlink("dots/.") == 0){
    2b2e:	c7 04 24 c3 4c 00 00 	movl   $0x4cc3,(%esp)
    2b35:	e8 28 11 00 00       	call   3c62 <unlink>
    2b3a:	85 c0                	test   %eax,%eax
    2b3c:	0f 84 81 00 00 00    	je     2bc3 <rmdot+0x113>
    printf(1, "unlink dots/. worked!\n");
    exit();
  }
  if(unlink("dots/..") == 0){
    2b42:	c7 04 24 e1 4c 00 00 	movl   $0x4ce1,(%esp)
    2b49:	e8 14 11 00 00       	call   3c62 <unlink>
    2b4e:	85 c0                	test   %eax,%eax
    2b50:	74 58                	je     2baa <rmdot+0xfa>
    printf(1, "unlink dots/.. worked!\n");
    exit();
  }
  if(unlink("dots") != 0){
    2b52:	c7 04 24 7b 4c 00 00 	movl   $0x4c7b,(%esp)
    2b59:	e8 04 11 00 00       	call   3c62 <unlink>
    2b5e:	85 c0                	test   %eax,%eax
    2b60:	75 2f                	jne    2b91 <rmdot+0xe1>
    printf(1, "unlink dots failed!\n");
    exit();
  }
  printf(1, "rmdot ok\n");
    2b62:	c7 44 24 04 16 4d 00 	movl   $0x4d16,0x4(%esp)
    2b69:	00 
    2b6a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2b71:	e8 da 11 00 00       	call   3d50 <printf>
}
    2b76:	c9                   	leave  
    2b77:	c3                   	ret    
void
rmdot(void)
{
  printf(1, "rmdot test\n");
  if(mkdir("dots") != 0){
    printf(1, "mkdir dots failed\n");
    2b78:	c7 44 24 04 80 4c 00 	movl   $0x4c80,0x4(%esp)
    2b7f:	00 
    2b80:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2b87:	e8 c4 11 00 00       	call   3d50 <printf>
    exit();
    2b8c:	e8 81 10 00 00       	call   3c12 <exit>
  if(unlink("dots/..") == 0){
    printf(1, "unlink dots/.. worked!\n");
    exit();
  }
  if(unlink("dots") != 0){
    printf(1, "unlink dots failed!\n");
    2b91:	c7 44 24 04 01 4d 00 	movl   $0x4d01,0x4(%esp)
    2b98:	00 
    2b99:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ba0:	e8 ab 11 00 00       	call   3d50 <printf>
    exit();
    2ba5:	e8 68 10 00 00       	call   3c12 <exit>
  if(unlink("dots/.") == 0){
    printf(1, "unlink dots/. worked!\n");
    exit();
  }
  if(unlink("dots/..") == 0){
    printf(1, "unlink dots/.. worked!\n");
    2baa:	c7 44 24 04 e9 4c 00 	movl   $0x4ce9,0x4(%esp)
    2bb1:	00 
    2bb2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2bb9:	e8 92 11 00 00       	call   3d50 <printf>
    exit();
    2bbe:	e8 4f 10 00 00       	call   3c12 <exit>
  if(chdir("/") != 0){
    printf(1, "chdir / failed\n");
    exit();
  }
  if(unlink("dots/.") == 0){
    printf(1, "unlink dots/. worked!\n");
    2bc3:	c7 44 24 04 ca 4c 00 	movl   $0x4cca,0x4(%esp)
    2bca:	00 
    2bcb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2bd2:	e8 79 11 00 00       	call   3d50 <printf>
    exit();
    2bd7:	e8 36 10 00 00       	call   3c12 <exit>
  if(unlink("..") == 0){
    printf(1, "rm .. worked!\n");
    exit();
  }
  if(chdir("/") != 0){
    printf(1, "chdir / failed\n");
    2bdc:	c7 44 24 04 fb 40 00 	movl   $0x40fb,0x4(%esp)
    2be3:	00 
    2be4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2beb:	e8 60 11 00 00       	call   3d50 <printf>
    exit();
    2bf0:	e8 1d 10 00 00       	call   3c12 <exit>
  if(unlink(".") == 0){
    printf(1, "rm . worked!\n");
    exit();
  }
  if(unlink("..") == 0){
    printf(1, "rm .. worked!\n");
    2bf5:	c7 44 24 04 b4 4c 00 	movl   $0x4cb4,0x4(%esp)
    2bfc:	00 
    2bfd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c04:	e8 47 11 00 00       	call   3d50 <printf>
    exit();
    2c09:	e8 04 10 00 00       	call   3c12 <exit>
  if(chdir("dots") != 0){
    printf(1, "chdir dots failed\n");
    exit();
  }
  if(unlink(".") == 0){
    printf(1, "rm . worked!\n");
    2c0e:	c7 44 24 04 a6 4c 00 	movl   $0x4ca6,0x4(%esp)
    2c15:	00 
    2c16:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c1d:	e8 2e 11 00 00       	call   3d50 <printf>
    exit();
    2c22:	e8 eb 0f 00 00       	call   3c12 <exit>
  if(mkdir("dots") != 0){
    printf(1, "mkdir dots failed\n");
    exit();
  }
  if(chdir("dots") != 0){
    printf(1, "chdir dots failed\n");
    2c27:	c7 44 24 04 93 4c 00 	movl   $0x4c93,0x4(%esp)
    2c2e:	00 
    2c2f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c36:	e8 15 11 00 00       	call   3d50 <printf>
    exit();
    2c3b:	e8 d2 0f 00 00       	call   3c12 <exit>

00002c40 <dirfile>:
  printf(1, "rmdot ok\n");
}

void
dirfile(void)
{
    2c40:	55                   	push   %ebp
    2c41:	89 e5                	mov    %esp,%ebp
    2c43:	53                   	push   %ebx
    2c44:	83 ec 14             	sub    $0x14,%esp
  int fd;

  printf(1, "dir vs file\n");
    2c47:	c7 44 24 04 20 4d 00 	movl   $0x4d20,0x4(%esp)
    2c4e:	00 
    2c4f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c56:	e8 f5 10 00 00       	call   3d50 <printf>

  fd = open("dirfile", O_CREATE);
    2c5b:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    2c62:	00 
    2c63:	c7 04 24 2d 4d 00 00 	movl   $0x4d2d,(%esp)
    2c6a:	e8 e3 0f 00 00       	call   3c52 <open>
  if(fd < 0){
    2c6f:	85 c0                	test   %eax,%eax
    2c71:	0f 88 4e 01 00 00    	js     2dc5 <dirfile+0x185>
    printf(1, "create dirfile failed\n");
    exit();
  }
  close(fd);
    2c77:	89 04 24             	mov    %eax,(%esp)
    2c7a:	e8 bb 0f 00 00       	call   3c3a <close>
  if(chdir("dirfile") == 0){
    2c7f:	c7 04 24 2d 4d 00 00 	movl   $0x4d2d,(%esp)
    2c86:	e8 f7 0f 00 00       	call   3c82 <chdir>
    2c8b:	85 c0                	test   %eax,%eax
    2c8d:	0f 84 19 01 00 00    	je     2dac <dirfile+0x16c>
    printf(1, "chdir dirfile succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", 0);
    2c93:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2c9a:	00 
    2c9b:	c7 04 24 66 4d 00 00 	movl   $0x4d66,(%esp)
    2ca2:	e8 ab 0f 00 00       	call   3c52 <open>
  if(fd >= 0){
    2ca7:	85 c0                	test   %eax,%eax
    2ca9:	0f 89 e4 00 00 00    	jns    2d93 <dirfile+0x153>
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", O_CREATE);
    2caf:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    2cb6:	00 
    2cb7:	c7 04 24 66 4d 00 00 	movl   $0x4d66,(%esp)
    2cbe:	e8 8f 0f 00 00       	call   3c52 <open>
  if(fd >= 0){
    2cc3:	85 c0                	test   %eax,%eax
    2cc5:	0f 89 c8 00 00 00    	jns    2d93 <dirfile+0x153>
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  if(mkdir("dirfile/xx") == 0){
    2ccb:	c7 04 24 66 4d 00 00 	movl   $0x4d66,(%esp)
    2cd2:	e8 a3 0f 00 00       	call   3c7a <mkdir>
    2cd7:	85 c0                	test   %eax,%eax
    2cd9:	0f 84 7c 01 00 00    	je     2e5b <dirfile+0x21b>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile/xx") == 0){
    2cdf:	c7 04 24 66 4d 00 00 	movl   $0x4d66,(%esp)
    2ce6:	e8 77 0f 00 00       	call   3c62 <unlink>
    2ceb:	85 c0                	test   %eax,%eax
    2ced:	0f 84 4f 01 00 00    	je     2e42 <dirfile+0x202>
    printf(1, "unlink dirfile/xx succeeded!\n");
    exit();
  }
  if(link("README", "dirfile/xx") == 0){
    2cf3:	c7 44 24 04 66 4d 00 	movl   $0x4d66,0x4(%esp)
    2cfa:	00 
    2cfb:	c7 04 24 ca 4d 00 00 	movl   $0x4dca,(%esp)
    2d02:	e8 6b 0f 00 00       	call   3c72 <link>
    2d07:	85 c0                	test   %eax,%eax
    2d09:	0f 84 1a 01 00 00    	je     2e29 <dirfile+0x1e9>
    printf(1, "link to dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile") != 0){
    2d0f:	c7 04 24 2d 4d 00 00 	movl   $0x4d2d,(%esp)
    2d16:	e8 47 0f 00 00       	call   3c62 <unlink>
    2d1b:	85 c0                	test   %eax,%eax
    2d1d:	0f 85 ed 00 00 00    	jne    2e10 <dirfile+0x1d0>
    printf(1, "unlink dirfile failed!\n");
    exit();
  }

  fd = open(".", O_RDWR);
    2d23:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    2d2a:	00 
    2d2b:	c7 04 24 26 49 00 00 	movl   $0x4926,(%esp)
    2d32:	e8 1b 0f 00 00       	call   3c52 <open>
  if(fd >= 0){
    2d37:	85 c0                	test   %eax,%eax
    2d39:	0f 89 b8 00 00 00    	jns    2df7 <dirfile+0x1b7>
    printf(1, "open . for writing succeeded!\n");
    exit();
  }
  fd = open(".", 0);
    2d3f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2d46:	00 
    2d47:	c7 04 24 26 49 00 00 	movl   $0x4926,(%esp)
    2d4e:	e8 ff 0e 00 00       	call   3c52 <open>
  if(write(fd, "x", 1) > 0){
    2d53:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    2d5a:	00 
    2d5b:	c7 44 24 04 09 4a 00 	movl   $0x4a09,0x4(%esp)
    2d62:	00 
    2d63:	89 04 24             	mov    %eax,(%esp)
  fd = open(".", O_RDWR);
  if(fd >= 0){
    printf(1, "open . for writing succeeded!\n");
    exit();
  }
  fd = open(".", 0);
    2d66:	89 c3                	mov    %eax,%ebx
  if(write(fd, "x", 1) > 0){
    2d68:	e8 c5 0e 00 00       	call   3c32 <write>
    2d6d:	85 c0                	test   %eax,%eax
    2d6f:	7f 6d                	jg     2dde <dirfile+0x19e>
    printf(1, "write . succeeded!\n");
    exit();
  }
  close(fd);
    2d71:	89 1c 24             	mov    %ebx,(%esp)
    2d74:	e8 c1 0e 00 00       	call   3c3a <close>

  printf(1, "dir vs file OK\n");
    2d79:	c7 44 24 04 fd 4d 00 	movl   $0x4dfd,0x4(%esp)
    2d80:	00 
    2d81:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2d88:	e8 c3 0f 00 00       	call   3d50 <printf>
}
    2d8d:	83 c4 14             	add    $0x14,%esp
    2d90:	5b                   	pop    %ebx
    2d91:	5d                   	pop    %ebp
    2d92:	c3                   	ret    
    printf(1, "chdir dirfile succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", 0);
  if(fd >= 0){
    printf(1, "create dirfile/xx succeeded!\n");
    2d93:	c7 44 24 04 71 4d 00 	movl   $0x4d71,0x4(%esp)
    2d9a:	00 
    2d9b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2da2:	e8 a9 0f 00 00       	call   3d50 <printf>
    exit();
    2da7:	e8 66 0e 00 00       	call   3c12 <exit>
    printf(1, "create dirfile failed\n");
    exit();
  }
  close(fd);
  if(chdir("dirfile") == 0){
    printf(1, "chdir dirfile succeeded!\n");
    2dac:	c7 44 24 04 4c 4d 00 	movl   $0x4d4c,0x4(%esp)
    2db3:	00 
    2db4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2dbb:	e8 90 0f 00 00       	call   3d50 <printf>
    exit();
    2dc0:	e8 4d 0e 00 00       	call   3c12 <exit>

  printf(1, "dir vs file\n");

  fd = open("dirfile", O_CREATE);
  if(fd < 0){
    printf(1, "create dirfile failed\n");
    2dc5:	c7 44 24 04 35 4d 00 	movl   $0x4d35,0x4(%esp)
    2dcc:	00 
    2dcd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2dd4:	e8 77 0f 00 00       	call   3d50 <printf>
    exit();
    2dd9:	e8 34 0e 00 00       	call   3c12 <exit>
    printf(1, "open . for writing succeeded!\n");
    exit();
  }
  fd = open(".", 0);
  if(write(fd, "x", 1) > 0){
    printf(1, "write . succeeded!\n");
    2dde:	c7 44 24 04 e9 4d 00 	movl   $0x4de9,0x4(%esp)
    2de5:	00 
    2de6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ded:	e8 5e 0f 00 00       	call   3d50 <printf>
    exit();
    2df2:	e8 1b 0e 00 00       	call   3c12 <exit>
    exit();
  }

  fd = open(".", O_RDWR);
  if(fd >= 0){
    printf(1, "open . for writing succeeded!\n");
    2df7:	c7 44 24 04 bc 55 00 	movl   $0x55bc,0x4(%esp)
    2dfe:	00 
    2dff:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e06:	e8 45 0f 00 00       	call   3d50 <printf>
    exit();
    2e0b:	e8 02 0e 00 00       	call   3c12 <exit>
  if(link("README", "dirfile/xx") == 0){
    printf(1, "link to dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile") != 0){
    printf(1, "unlink dirfile failed!\n");
    2e10:	c7 44 24 04 d1 4d 00 	movl   $0x4dd1,0x4(%esp)
    2e17:	00 
    2e18:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e1f:	e8 2c 0f 00 00       	call   3d50 <printf>
    exit();
    2e24:	e8 e9 0d 00 00       	call   3c12 <exit>
  if(unlink("dirfile/xx") == 0){
    printf(1, "unlink dirfile/xx succeeded!\n");
    exit();
  }
  if(link("README", "dirfile/xx") == 0){
    printf(1, "link to dirfile/xx succeeded!\n");
    2e29:	c7 44 24 04 9c 55 00 	movl   $0x559c,0x4(%esp)
    2e30:	00 
    2e31:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e38:	e8 13 0f 00 00       	call   3d50 <printf>
    exit();
    2e3d:	e8 d0 0d 00 00       	call   3c12 <exit>
  if(mkdir("dirfile/xx") == 0){
    printf(1, "mkdir dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile/xx") == 0){
    printf(1, "unlink dirfile/xx succeeded!\n");
    2e42:	c7 44 24 04 ac 4d 00 	movl   $0x4dac,0x4(%esp)
    2e49:	00 
    2e4a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e51:	e8 fa 0e 00 00       	call   3d50 <printf>
    exit();
    2e56:	e8 b7 0d 00 00       	call   3c12 <exit>
  if(fd >= 0){
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  if(mkdir("dirfile/xx") == 0){
    printf(1, "mkdir dirfile/xx succeeded!\n");
    2e5b:	c7 44 24 04 8f 4d 00 	movl   $0x4d8f,0x4(%esp)
    2e62:	00 
    2e63:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e6a:	e8 e1 0e 00 00       	call   3d50 <printf>
    exit();
    2e6f:	e8 9e 0d 00 00       	call   3c12 <exit>
    2e74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    2e7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00002e80 <iref>:
}

// test that iput() is called at the end of _namei()
void
iref(void)
{
    2e80:	55                   	push   %ebp
    2e81:	89 e5                	mov    %esp,%ebp
    2e83:	53                   	push   %ebx
  int i, fd;

  printf(1, "empty file name\n");
    2e84:	bb 33 00 00 00       	mov    $0x33,%ebx
}

// test that iput() is called at the end of _namei()
void
iref(void)
{
    2e89:	83 ec 14             	sub    $0x14,%esp
  int i, fd;

  printf(1, "empty file name\n");
    2e8c:	c7 44 24 04 0d 4e 00 	movl   $0x4e0d,0x4(%esp)
    2e93:	00 
    2e94:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e9b:	e8 b0 0e 00 00       	call   3d50 <printf>

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    if(mkdir("irefd") != 0){
    2ea0:	c7 04 24 1e 4e 00 00 	movl   $0x4e1e,(%esp)
    2ea7:	e8 ce 0d 00 00       	call   3c7a <mkdir>
    2eac:	85 c0                	test   %eax,%eax
    2eae:	0f 85 af 00 00 00    	jne    2f63 <iref+0xe3>
      printf(1, "mkdir irefd failed\n");
      exit();
    }
    if(chdir("irefd") != 0){
    2eb4:	c7 04 24 1e 4e 00 00 	movl   $0x4e1e,(%esp)
    2ebb:	e8 c2 0d 00 00       	call   3c82 <chdir>
    2ec0:	85 c0                	test   %eax,%eax
    2ec2:	0f 85 b4 00 00 00    	jne    2f7c <iref+0xfc>
      printf(1, "chdir irefd failed\n");
      exit();
    }

    mkdir("");
    2ec8:	c7 04 24 d3 44 00 00 	movl   $0x44d3,(%esp)
    2ecf:	e8 a6 0d 00 00       	call   3c7a <mkdir>
    link("README", "");
    2ed4:	c7 44 24 04 d3 44 00 	movl   $0x44d3,0x4(%esp)
    2edb:	00 
    2edc:	c7 04 24 ca 4d 00 00 	movl   $0x4dca,(%esp)
    2ee3:	e8 8a 0d 00 00       	call   3c72 <link>
    fd = open("", O_CREATE);
    2ee8:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    2eef:	00 
    2ef0:	c7 04 24 d3 44 00 00 	movl   $0x44d3,(%esp)
    2ef7:	e8 56 0d 00 00       	call   3c52 <open>
    if(fd >= 0)
    2efc:	85 c0                	test   %eax,%eax
    2efe:	78 08                	js     2f08 <iref+0x88>
      close(fd);
    2f00:	89 04 24             	mov    %eax,(%esp)
    2f03:	e8 32 0d 00 00       	call   3c3a <close>
    fd = open("xx", O_CREATE);
    2f08:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    2f0f:	00 
    2f10:	c7 04 24 08 4a 00 00 	movl   $0x4a08,(%esp)
    2f17:	e8 36 0d 00 00       	call   3c52 <open>
    if(fd >= 0)
    2f1c:	85 c0                	test   %eax,%eax
    2f1e:	78 08                	js     2f28 <iref+0xa8>
      close(fd);
    2f20:	89 04 24             	mov    %eax,(%esp)
    2f23:	e8 12 0d 00 00       	call   3c3a <close>
    unlink("xx");
    2f28:	c7 04 24 08 4a 00 00 	movl   $0x4a08,(%esp)
    2f2f:	e8 2e 0d 00 00       	call   3c62 <unlink>
  int i, fd;

  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    2f34:	83 eb 01             	sub    $0x1,%ebx
    2f37:	0f 85 63 ff ff ff    	jne    2ea0 <iref+0x20>
    if(fd >= 0)
      close(fd);
    unlink("xx");
  }

  chdir("/");
    2f3d:	c7 04 24 f9 40 00 00 	movl   $0x40f9,(%esp)
    2f44:	e8 39 0d 00 00       	call   3c82 <chdir>
  printf(1, "empty file name OK\n");
    2f49:	c7 44 24 04 4c 4e 00 	movl   $0x4e4c,0x4(%esp)
    2f50:	00 
    2f51:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2f58:	e8 f3 0d 00 00       	call   3d50 <printf>
}
    2f5d:	83 c4 14             	add    $0x14,%esp
    2f60:	5b                   	pop    %ebx
    2f61:	5d                   	pop    %ebp
    2f62:	c3                   	ret    
  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    if(mkdir("irefd") != 0){
      printf(1, "mkdir irefd failed\n");
    2f63:	c7 44 24 04 24 4e 00 	movl   $0x4e24,0x4(%esp)
    2f6a:	00 
    2f6b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2f72:	e8 d9 0d 00 00       	call   3d50 <printf>
      exit();
    2f77:	e8 96 0c 00 00       	call   3c12 <exit>
    }
    if(chdir("irefd") != 0){
      printf(1, "chdir irefd failed\n");
    2f7c:	c7 44 24 04 38 4e 00 	movl   $0x4e38,0x4(%esp)
    2f83:	00 
    2f84:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2f8b:	e8 c0 0d 00 00       	call   3d50 <printf>
      exit();
    2f90:	e8 7d 0c 00 00       	call   3c12 <exit>
    2f95:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2f99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00002fa0 <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
    2fa0:	55                   	push   %ebp
    2fa1:	89 e5                	mov    %esp,%ebp
    2fa3:	53                   	push   %ebx
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<1000; n++){
    2fa4:	31 db                	xor    %ebx,%ebx
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
    2fa6:	83 ec 14             	sub    $0x14,%esp
  int n, pid;

  printf(1, "fork test\n");
    2fa9:	c7 44 24 04 60 4e 00 	movl   $0x4e60,0x4(%esp)
    2fb0:	00 
    2fb1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2fb8:	e8 93 0d 00 00       	call   3d50 <printf>
    2fbd:	eb 13                	jmp    2fd2 <forktest+0x32>
    2fbf:	90                   	nop

  for(n=0; n<1000; n++){
    pid = fork();
    if(pid < 0)
      break;
    if(pid == 0)
    2fc0:	0f 84 87 00 00 00    	je     304d <forktest+0xad>
{
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<1000; n++){
    2fc6:	83 c3 01             	add    $0x1,%ebx
    2fc9:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    2fcf:	90                   	nop
    2fd0:	74 4e                	je     3020 <forktest+0x80>
    pid = fork();
    2fd2:	e8 33 0c 00 00       	call   3c0a <fork>
    if(pid < 0)
    2fd7:	83 f8 00             	cmp    $0x0,%eax
    2fda:	7d e4                	jge    2fc0 <forktest+0x20>
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    exit();
  }

  for(; n > 0; n--){
    2fdc:	85 db                	test   %ebx,%ebx
    2fde:	66 90                	xchg   %ax,%ax
    2fe0:	74 15                	je     2ff7 <forktest+0x57>
    2fe2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(wait() < 0){
    2fe8:	e8 2d 0c 00 00       	call   3c1a <wait>
    2fed:	85 c0                	test   %eax,%eax
    2fef:	90                   	nop
    2ff0:	78 47                	js     3039 <forktest+0x99>
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    exit();
  }

  for(; n > 0; n--){
    2ff2:	83 eb 01             	sub    $0x1,%ebx
    2ff5:	75 f1                	jne    2fe8 <forktest+0x48>
      printf(1, "wait stopped early\n");
      exit();
    }
  }

  if(wait() != -1){
    2ff7:	e8 1e 0c 00 00       	call   3c1a <wait>
    2ffc:	83 f8 ff             	cmp    $0xffffffff,%eax
    2fff:	90                   	nop
    3000:	75 50                	jne    3052 <forktest+0xb2>
    printf(1, "wait got too many\n");
    exit();
  }

  printf(1, "fork test OK\n");
    3002:	c7 44 24 04 92 4e 00 	movl   $0x4e92,0x4(%esp)
    3009:	00 
    300a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3011:	e8 3a 0d 00 00       	call   3d50 <printf>
}
    3016:	83 c4 14             	add    $0x14,%esp
    3019:	5b                   	pop    %ebx
    301a:	5d                   	pop    %ebp
    301b:	c3                   	ret    
    301c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(pid == 0)
      exit();
  }

  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    3020:	c7 44 24 04 dc 55 00 	movl   $0x55dc,0x4(%esp)
    3027:	00 
    3028:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    302f:	e8 1c 0d 00 00       	call   3d50 <printf>
    exit();
    3034:	e8 d9 0b 00 00       	call   3c12 <exit>
  }

  for(; n > 0; n--){
    if(wait() < 0){
      printf(1, "wait stopped early\n");
    3039:	c7 44 24 04 6b 4e 00 	movl   $0x4e6b,0x4(%esp)
    3040:	00 
    3041:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3048:	e8 03 0d 00 00       	call   3d50 <printf>
      exit();
    304d:	e8 c0 0b 00 00       	call   3c12 <exit>
    }
  }

  if(wait() != -1){
    printf(1, "wait got too many\n");
    3052:	c7 44 24 04 7f 4e 00 	movl   $0x4e7f,0x4(%esp)
    3059:	00 
    305a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3061:	e8 ea 0c 00 00       	call   3d50 <printf>
    exit();
    3066:	e8 a7 0b 00 00       	call   3c12 <exit>
    306b:	90                   	nop
    306c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003070 <sbrktest>:
  printf(1, "fork test OK\n");
}

void
sbrktest(void)
{
    3070:	55                   	push   %ebp
    3071:	89 e5                	mov    %esp,%ebp
    3073:	57                   	push   %edi
    3074:	56                   	push   %esi
  oldbrk = sbrk(0);

  // can one sbrk() less than a page?
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
    3075:	31 f6                	xor    %esi,%esi
  printf(1, "fork test OK\n");
}

void
sbrktest(void)
{
    3077:	53                   	push   %ebx
    3078:	83 ec 7c             	sub    $0x7c,%esp
  int fds[2], pid, pids[10], ppid;
  char *a, *b, *c, *lastaddr, *oldbrk, *p, scratch;
  uint amt;

  printf(stdout, "sbrk test\n");
    307b:	a1 fc 60 00 00       	mov    0x60fc,%eax
    3080:	c7 44 24 04 a0 4e 00 	movl   $0x4ea0,0x4(%esp)
    3087:	00 
    3088:	89 04 24             	mov    %eax,(%esp)
    308b:	e8 c0 0c 00 00       	call   3d50 <printf>
  oldbrk = sbrk(0);
    3090:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3097:	e8 fe 0b 00 00       	call   3c9a <sbrk>

  // can one sbrk() less than a page?
  a = sbrk(0);
    309c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  int fds[2], pid, pids[10], ppid;
  char *a, *b, *c, *lastaddr, *oldbrk, *p, scratch;
  uint amt;

  printf(stdout, "sbrk test\n");
  oldbrk = sbrk(0);
    30a3:	89 45 a4             	mov    %eax,-0x5c(%ebp)

  // can one sbrk() less than a page?
  a = sbrk(0);
    30a6:	e8 ef 0b 00 00       	call   3c9a <sbrk>
    30ab:	89 c3                	mov    %eax,%ebx
    30ad:	8d 76 00             	lea    0x0(%esi),%esi
  int i;
  for(i = 0; i < 5000; i++){
    b = sbrk(1);
    30b0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    30b7:	e8 de 0b 00 00       	call   3c9a <sbrk>
    if(b != a){
    30bc:	39 d8                	cmp    %ebx,%eax
    30be:	0f 85 7a 02 00 00    	jne    333e <sbrktest+0x2ce>
  oldbrk = sbrk(0);

  // can one sbrk() less than a page?
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
    30c4:	83 c6 01             	add    $0x1,%esi
    b = sbrk(1);
    if(b != a){
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
      exit();
    }
    *b = 1;
    30c7:	c6 03 01             	movb   $0x1,(%ebx)
    a = b + 1;
    30ca:	83 c3 01             	add    $0x1,%ebx
  oldbrk = sbrk(0);

  // can one sbrk() less than a page?
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
    30cd:	81 fe 88 13 00 00    	cmp    $0x1388,%esi
    30d3:	75 db                	jne    30b0 <sbrktest+0x40>
      exit();
    }
    *b = 1;
    a = b + 1;
  }
  pid = fork();
    30d5:	e8 30 0b 00 00       	call   3c0a <fork>
  if(pid < 0){
    30da:	85 c0                	test   %eax,%eax
      exit();
    }
    *b = 1;
    a = b + 1;
  }
  pid = fork();
    30dc:	89 c6                	mov    %eax,%esi
  if(pid < 0){
    30de:	0f 88 c8 03 00 00    	js     34ac <sbrktest+0x43c>
    printf(stdout, "sbrk test fork failed\n");
    exit();
  }
  c = sbrk(1);
    30e4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  c = sbrk(1);
  if(c != a + 1){
    30eb:	83 c3 01             	add    $0x1,%ebx
  pid = fork();
  if(pid < 0){
    printf(stdout, "sbrk test fork failed\n");
    exit();
  }
  c = sbrk(1);
    30ee:	e8 a7 0b 00 00       	call   3c9a <sbrk>
  c = sbrk(1);
    30f3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    30fa:	e8 9b 0b 00 00       	call   3c9a <sbrk>
  if(c != a + 1){
    30ff:	39 d8                	cmp    %ebx,%eax
    3101:	0f 85 8b 03 00 00    	jne    3492 <sbrktest+0x422>
    printf(stdout, "sbrk test failed post-fork\n");
    exit();
  }
  if(pid == 0)
    3107:	85 f6                	test   %esi,%esi
    3109:	0f 84 7e 03 00 00    	je     348d <sbrktest+0x41d>
    310f:	90                   	nop
    exit();
  wait();
    3110:	e8 05 0b 00 00       	call   3c1a <wait>

  // can one grow address space to something big?
#define BIG (100*1024*1024)
  a = sbrk(0);
    3115:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    311c:	e8 79 0b 00 00       	call   3c9a <sbrk>
  amt = (BIG) - (uint)a;
    3121:	ba 00 00 40 06       	mov    $0x6400000,%edx
    3126:	29 c2                	sub    %eax,%edx
    exit();
  wait();

  // can one grow address space to something big?
#define BIG (100*1024*1024)
  a = sbrk(0);
    3128:	89 c3                	mov    %eax,%ebx
  amt = (BIG) - (uint)a;
  p = sbrk(amt);
    312a:	89 14 24             	mov    %edx,(%esp)
    312d:	e8 68 0b 00 00       	call   3c9a <sbrk>
  if (p != a) {
    3132:	39 d8                	cmp    %ebx,%eax
    3134:	0f 85 3e 03 00 00    	jne    3478 <sbrktest+0x408>
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    exit();
  }
  lastaddr = (char*) (BIG-1);
  *lastaddr = 99;
    313a:	c6 05 ff ff 3f 06 63 	movb   $0x63,0x63fffff

  // can one de-allocate?
  a = sbrk(0);
    3141:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3148:	e8 4d 0b 00 00       	call   3c9a <sbrk>
  c = sbrk(-4096);
    314d:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
  }
  lastaddr = (char*) (BIG-1);
  *lastaddr = 99;

  // can one de-allocate?
  a = sbrk(0);
    3154:	89 c3                	mov    %eax,%ebx
  c = sbrk(-4096);
    3156:	e8 3f 0b 00 00       	call   3c9a <sbrk>
  if(c == (char*)0xffffffff){
    315b:	83 f8 ff             	cmp    $0xffffffff,%eax
    315e:	0f 84 fa 02 00 00    	je     345e <sbrktest+0x3ee>
    printf(stdout, "sbrk could not deallocate\n");
    exit();
  }
  c = sbrk(0);
    3164:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    316b:	e8 2a 0b 00 00       	call   3c9a <sbrk>
  if(c != a - 4096){
    3170:	8d 93 00 f0 ff ff    	lea    -0x1000(%ebx),%edx
    3176:	39 d0                	cmp    %edx,%eax
    3178:	0f 85 be 02 00 00    	jne    343c <sbrktest+0x3cc>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    exit();
  }

  // can one re-allocate that page?
  a = sbrk(0);
    317e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3185:	e8 10 0b 00 00       	call   3c9a <sbrk>
  c = sbrk(4096);
    318a:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    exit();
  }

  // can one re-allocate that page?
  a = sbrk(0);
    3191:	89 c6                	mov    %eax,%esi
  c = sbrk(4096);
    3193:	e8 02 0b 00 00       	call   3c9a <sbrk>
  if(c != a || sbrk(0) != a + 4096){
    3198:	39 f0                	cmp    %esi,%eax
    exit();
  }

  // can one re-allocate that page?
  a = sbrk(0);
  c = sbrk(4096);
    319a:	89 c3                	mov    %eax,%ebx
  if(c != a || sbrk(0) != a + 4096){
    319c:	0f 85 78 02 00 00    	jne    341a <sbrktest+0x3aa>
    31a2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    31a9:	e8 ec 0a 00 00       	call   3c9a <sbrk>
    31ae:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
    31b4:	39 d0                	cmp    %edx,%eax
    31b6:	0f 85 5e 02 00 00    	jne    341a <sbrktest+0x3aa>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    exit();
  }
  if(*lastaddr == 99){
    31bc:	80 3d ff ff 3f 06 63 	cmpb   $0x63,0x63fffff
    31c3:	0f 84 37 02 00 00    	je     3400 <sbrktest+0x390>
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    exit();
  }

  a = sbrk(0);
    31c9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    31d0:	e8 c5 0a 00 00       	call   3c9a <sbrk>
  c = sbrk(-(sbrk(0) - oldbrk));
    31d5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    exit();
  }

  a = sbrk(0);
    31dc:	89 c3                	mov    %eax,%ebx
  c = sbrk(-(sbrk(0) - oldbrk));
    31de:	e8 b7 0a 00 00       	call   3c9a <sbrk>
    31e3:	8b 55 a4             	mov    -0x5c(%ebp),%edx
    31e6:	29 c2                	sub    %eax,%edx
    31e8:	89 14 24             	mov    %edx,(%esp)
    31eb:	e8 aa 0a 00 00       	call   3c9a <sbrk>
  if(c != a){
    31f0:	39 d8                	cmp    %ebx,%eax
    31f2:	0f 85 e6 01 00 00    	jne    33de <sbrktest+0x36e>
    31f8:	bb 00 00 00 80       	mov    $0x80000000,%ebx
    31fd:	8d 76 00             	lea    0x0(%esi),%esi
    exit();
  }

  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    ppid = getpid();
    3200:	e8 8d 0a 00 00       	call   3c92 <getpid>
    3205:	89 c6                	mov    %eax,%esi
    pid = fork();
    3207:	e8 fe 09 00 00       	call   3c0a <fork>
    if(pid < 0){
    320c:	83 f8 00             	cmp    $0x0,%eax
    320f:	0f 8c af 01 00 00    	jl     33c4 <sbrktest+0x354>
      printf(stdout, "fork failed\n");
      exit();
    }
    if(pid == 0){
    3215:	0f 84 7c 01 00 00    	je     3397 <sbrktest+0x327>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    exit();
  }

  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    321b:	81 c3 50 c3 00 00    	add    $0xc350,%ebx
    if(pid == 0){
      printf(stdout, "oops could read %x = %x\n", a, *a);
      kill(ppid);
      exit();
    }
    wait();
    3221:	e8 f4 09 00 00       	call   3c1a <wait>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    exit();
  }

  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    3226:	81 fb 80 84 1e 80    	cmp    $0x801e8480,%ebx
    322c:	75 d2                	jne    3200 <sbrktest+0x190>
    wait();
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  if(pipe(fds) != 0){
    322e:	8d 45 b8             	lea    -0x48(%ebp),%eax
    3231:	89 04 24             	mov    %eax,(%esp)
    3234:	e8 e9 09 00 00       	call   3c22 <pipe>
    3239:	85 c0                	test   %eax,%eax
    323b:	0f 85 3d 01 00 00    	jne    337e <sbrktest+0x30e>
    3241:	8d 5d c0             	lea    -0x40(%ebp),%ebx

  printf(1, "fork test OK\n");
}

void
sbrktest(void)
    3244:	8d 75 e8             	lea    -0x18(%ebp),%esi
    3247:	89 df                	mov    %ebx,%edi
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit();
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if((pids[i] = fork()) == 0){
    3249:	e8 bc 09 00 00       	call   3c0a <fork>
    324e:	85 c0                	test   %eax,%eax
    3250:	89 07                	mov    %eax,(%edi)
    3252:	0f 84 a1 00 00 00    	je     32f9 <sbrktest+0x289>
      sbrk(BIG - (uint)sbrk(0));
      write(fds[1], "x", 1);
      // sit around until killed
      for(;;) sleep(1000);
    }
    if(pids[i] != -1)
    3258:	83 f8 ff             	cmp    $0xffffffff,%eax
    325b:	74 1a                	je     3277 <sbrktest+0x207>
      read(fds[0], &scratch, 1);
    325d:	8d 45 b7             	lea    -0x49(%ebp),%eax
    3260:	89 44 24 04          	mov    %eax,0x4(%esp)
    3264:	8b 45 b8             	mov    -0x48(%ebp),%eax
    3267:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    326e:	00 
    326f:	89 04 24             	mov    %eax,(%esp)
    3272:	e8 b3 09 00 00       	call   3c2a <read>
    3277:	83 c7 04             	add    $0x4,%edi
  // failed allocation?
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit();
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    327a:	39 f7                	cmp    %esi,%edi
    327c:	75 cb                	jne    3249 <sbrktest+0x1d9>
    if(pids[i] != -1)
      read(fds[0], &scratch, 1);
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
    327e:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    3285:	e8 10 0a 00 00       	call   3c9a <sbrk>
    328a:	89 45 a0             	mov    %eax,-0x60(%ebp)
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if(pids[i] == -1)
    328d:	8b 03                	mov    (%ebx),%eax
    328f:	83 f8 ff             	cmp    $0xffffffff,%eax
    3292:	74 0d                	je     32a1 <sbrktest+0x231>
      continue;
    kill(pids[i]);
    3294:	89 04 24             	mov    %eax,(%esp)
    3297:	e8 a6 09 00 00       	call   3c42 <kill>
    wait();
    329c:	e8 79 09 00 00       	call   3c1a <wait>
    32a1:	83 c3 04             	add    $0x4,%ebx
      read(fds[0], &scratch, 1);
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    32a4:	39 de                	cmp    %ebx,%esi
    32a6:	75 e5                	jne    328d <sbrktest+0x21d>
    if(pids[i] == -1)
      continue;
    kill(pids[i]);
    wait();
  }
  if(c == (char*)0xffffffff){
    32a8:	83 7d a0 ff          	cmpl   $0xffffffff,-0x60(%ebp)
    32ac:	0f 84 b2 00 00 00    	je     3364 <sbrktest+0x2f4>
    printf(stdout, "failed sbrk leaked memory\n");
    exit();
  }

  if(sbrk(0) > oldbrk)
    32b2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    32b9:	e8 dc 09 00 00       	call   3c9a <sbrk>
    32be:	39 45 a4             	cmp    %eax,-0x5c(%ebp)
    32c1:	73 19                	jae    32dc <sbrktest+0x26c>
    sbrk(-(sbrk(0) - oldbrk));
    32c3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    32ca:	e8 cb 09 00 00       	call   3c9a <sbrk>
    32cf:	8b 7d a4             	mov    -0x5c(%ebp),%edi
    32d2:	29 c7                	sub    %eax,%edi
    32d4:	89 3c 24             	mov    %edi,(%esp)
    32d7:	e8 be 09 00 00       	call   3c9a <sbrk>

  printf(stdout, "sbrk test OK\n");
    32dc:	a1 fc 60 00 00       	mov    0x60fc,%eax
    32e1:	c7 44 24 04 48 4f 00 	movl   $0x4f48,0x4(%esp)
    32e8:	00 
    32e9:	89 04 24             	mov    %eax,(%esp)
    32ec:	e8 5f 0a 00 00       	call   3d50 <printf>
}
    32f1:	83 c4 7c             	add    $0x7c,%esp
    32f4:	5b                   	pop    %ebx
    32f5:	5e                   	pop    %esi
    32f6:	5f                   	pop    %edi
    32f7:	5d                   	pop    %ebp
    32f8:	c3                   	ret    
    exit();
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if((pids[i] = fork()) == 0){
      // allocate a lot of memory
      sbrk(BIG - (uint)sbrk(0));
    32f9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3300:	e8 95 09 00 00       	call   3c9a <sbrk>
    3305:	ba 00 00 40 06       	mov    $0x6400000,%edx
    330a:	29 c2                	sub    %eax,%edx
    330c:	89 14 24             	mov    %edx,(%esp)
    330f:	e8 86 09 00 00       	call   3c9a <sbrk>
      write(fds[1], "x", 1);
    3314:	8b 45 bc             	mov    -0x44(%ebp),%eax
    3317:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    331e:	00 
    331f:	c7 44 24 04 09 4a 00 	movl   $0x4a09,0x4(%esp)
    3326:	00 
    3327:	89 04 24             	mov    %eax,(%esp)
    332a:	e8 03 09 00 00       	call   3c32 <write>
    332f:	90                   	nop
      // sit around until killed
      for(;;) sleep(1000);
    3330:	c7 04 24 e8 03 00 00 	movl   $0x3e8,(%esp)
    3337:	e8 66 09 00 00       	call   3ca2 <sleep>
    333c:	eb f2                	jmp    3330 <sbrktest+0x2c0>
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
    b = sbrk(1);
    if(b != a){
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    333e:	89 44 24 10          	mov    %eax,0x10(%esp)
    3342:	a1 fc 60 00 00       	mov    0x60fc,%eax
    3347:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
    334b:	89 74 24 08          	mov    %esi,0x8(%esp)
    334f:	c7 44 24 04 ab 4e 00 	movl   $0x4eab,0x4(%esp)
    3356:	00 
    3357:	89 04 24             	mov    %eax,(%esp)
    335a:	e8 f1 09 00 00       	call   3d50 <printf>
      exit();
    335f:	e8 ae 08 00 00       	call   3c12 <exit>
      continue;
    kill(pids[i]);
    wait();
  }
  if(c == (char*)0xffffffff){
    printf(stdout, "failed sbrk leaked memory\n");
    3364:	a1 fc 60 00 00       	mov    0x60fc,%eax
    3369:	c7 44 24 04 2d 4f 00 	movl   $0x4f2d,0x4(%esp)
    3370:	00 
    3371:	89 04 24             	mov    %eax,(%esp)
    3374:	e8 d7 09 00 00       	call   3d50 <printf>
    exit();
    3379:	e8 94 08 00 00       	call   3c12 <exit>
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    337e:	c7 44 24 04 e9 43 00 	movl   $0x43e9,0x4(%esp)
    3385:	00 
    3386:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    338d:	e8 be 09 00 00       	call   3d50 <printf>
    exit();
    3392:	e8 7b 08 00 00       	call   3c12 <exit>
    if(pid < 0){
      printf(stdout, "fork failed\n");
      exit();
    }
    if(pid == 0){
      printf(stdout, "oops could read %x = %x\n", a, *a);
    3397:	0f be 03             	movsbl (%ebx),%eax
    339a:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    339e:	c7 44 24 04 14 4f 00 	movl   $0x4f14,0x4(%esp)
    33a5:	00 
    33a6:	89 44 24 0c          	mov    %eax,0xc(%esp)
    33aa:	a1 fc 60 00 00       	mov    0x60fc,%eax
    33af:	89 04 24             	mov    %eax,(%esp)
    33b2:	e8 99 09 00 00       	call   3d50 <printf>
      kill(ppid);
    33b7:	89 34 24             	mov    %esi,(%esp)
    33ba:	e8 83 08 00 00       	call   3c42 <kill>
      exit();
    33bf:	e8 4e 08 00 00       	call   3c12 <exit>
  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    ppid = getpid();
    pid = fork();
    if(pid < 0){
      printf(stdout, "fork failed\n");
    33c4:	a1 fc 60 00 00       	mov    0x60fc,%eax
    33c9:	c7 44 24 04 f1 4f 00 	movl   $0x4ff1,0x4(%esp)
    33d0:	00 
    33d1:	89 04 24             	mov    %eax,(%esp)
    33d4:	e8 77 09 00 00       	call   3d50 <printf>
      exit();
    33d9:	e8 34 08 00 00       	call   3c12 <exit>
  }

  a = sbrk(0);
  c = sbrk(-(sbrk(0) - oldbrk));
  if(c != a){
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    33de:	89 44 24 0c          	mov    %eax,0xc(%esp)
    33e2:	a1 fc 60 00 00       	mov    0x60fc,%eax
    33e7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    33eb:	c7 44 24 04 d0 56 00 	movl   $0x56d0,0x4(%esp)
    33f2:	00 
    33f3:	89 04 24             	mov    %eax,(%esp)
    33f6:	e8 55 09 00 00       	call   3d50 <printf>
    exit();
    33fb:	e8 12 08 00 00       	call   3c12 <exit>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    exit();
  }
  if(*lastaddr == 99){
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    3400:	a1 fc 60 00 00       	mov    0x60fc,%eax
    3405:	c7 44 24 04 a0 56 00 	movl   $0x56a0,0x4(%esp)
    340c:	00 
    340d:	89 04 24             	mov    %eax,(%esp)
    3410:	e8 3b 09 00 00       	call   3d50 <printf>
    exit();
    3415:	e8 f8 07 00 00       	call   3c12 <exit>

  // can one re-allocate that page?
  a = sbrk(0);
  c = sbrk(4096);
  if(c != a || sbrk(0) != a + 4096){
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    341a:	a1 fc 60 00 00       	mov    0x60fc,%eax
    341f:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
    3423:	89 74 24 08          	mov    %esi,0x8(%esp)
    3427:	c7 44 24 04 78 56 00 	movl   $0x5678,0x4(%esp)
    342e:	00 
    342f:	89 04 24             	mov    %eax,(%esp)
    3432:	e8 19 09 00 00       	call   3d50 <printf>
    exit();
    3437:	e8 d6 07 00 00       	call   3c12 <exit>
    printf(stdout, "sbrk could not deallocate\n");
    exit();
  }
  c = sbrk(0);
  if(c != a - 4096){
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    343c:	89 44 24 0c          	mov    %eax,0xc(%esp)
    3440:	a1 fc 60 00 00       	mov    0x60fc,%eax
    3445:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    3449:	c7 44 24 04 40 56 00 	movl   $0x5640,0x4(%esp)
    3450:	00 
    3451:	89 04 24             	mov    %eax,(%esp)
    3454:	e8 f7 08 00 00       	call   3d50 <printf>
    exit();
    3459:	e8 b4 07 00 00       	call   3c12 <exit>

  // can one de-allocate?
  a = sbrk(0);
  c = sbrk(-4096);
  if(c == (char*)0xffffffff){
    printf(stdout, "sbrk could not deallocate\n");
    345e:	a1 fc 60 00 00       	mov    0x60fc,%eax
    3463:	c7 44 24 04 f9 4e 00 	movl   $0x4ef9,0x4(%esp)
    346a:	00 
    346b:	89 04 24             	mov    %eax,(%esp)
    346e:	e8 dd 08 00 00       	call   3d50 <printf>
    exit();
    3473:	e8 9a 07 00 00       	call   3c12 <exit>
#define BIG (100*1024*1024)
  a = sbrk(0);
  amt = (BIG) - (uint)a;
  p = sbrk(amt);
  if (p != a) {
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    3478:	a1 fc 60 00 00       	mov    0x60fc,%eax
    347d:	c7 44 24 04 00 56 00 	movl   $0x5600,0x4(%esp)
    3484:	00 
    3485:	89 04 24             	mov    %eax,(%esp)
    3488:	e8 c3 08 00 00       	call   3d50 <printf>
    exit();
    348d:	e8 80 07 00 00       	call   3c12 <exit>
    exit();
  }
  c = sbrk(1);
  c = sbrk(1);
  if(c != a + 1){
    printf(stdout, "sbrk test failed post-fork\n");
    3492:	a1 fc 60 00 00       	mov    0x60fc,%eax
    3497:	c7 44 24 04 dd 4e 00 	movl   $0x4edd,0x4(%esp)
    349e:	00 
    349f:	89 04 24             	mov    %eax,(%esp)
    34a2:	e8 a9 08 00 00       	call   3d50 <printf>
    exit();
    34a7:	e8 66 07 00 00       	call   3c12 <exit>
    *b = 1;
    a = b + 1;
  }
  pid = fork();
  if(pid < 0){
    printf(stdout, "sbrk test fork failed\n");
    34ac:	a1 fc 60 00 00       	mov    0x60fc,%eax
    34b1:	c7 44 24 04 c6 4e 00 	movl   $0x4ec6,0x4(%esp)
    34b8:	00 
    34b9:	89 04 24             	mov    %eax,(%esp)
    34bc:	e8 8f 08 00 00       	call   3d50 <printf>
    exit();
    34c1:	e8 4c 07 00 00       	call   3c12 <exit>
    34c6:	8d 76 00             	lea    0x0(%esi),%esi
    34c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000034d0 <validateint>:
  printf(stdout, "sbrk test OK\n");
}

void
validateint(int *p)
{
    34d0:	55                   	push   %ebp
    34d1:	89 e5                	mov    %esp,%ebp
      "int %2\n\t"
      "mov %%ebx, %%esp" :
      "=a" (res) :
      "a" (SYS_sleep), "n" (T_SYSCALL), "c" (p) :
      "ebx");
}
    34d3:	5d                   	pop    %ebp
    34d4:	c3                   	ret    
    34d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    34d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000034e0 <validatetest>:

void
validatetest(void)
{
    34e0:	55                   	push   %ebp
    34e1:	89 e5                	mov    %esp,%ebp
    34e3:	56                   	push   %esi
    34e4:	53                   	push   %ebx
  uint p;

  printf(stdout, "validate test\n");
  hi = 1100*1024;

  for(p = 0; p <= (uint)hi; p += 4096){
    34e5:	31 db                	xor    %ebx,%ebx
      "ebx");
}

void
validatetest(void)
{
    34e7:	83 ec 10             	sub    $0x10,%esp
  int hi, pid;
  uint p;

  printf(stdout, "validate test\n");
    34ea:	a1 fc 60 00 00       	mov    0x60fc,%eax
    34ef:	c7 44 24 04 56 4f 00 	movl   $0x4f56,0x4(%esp)
    34f6:	00 
    34f7:	89 04 24             	mov    %eax,(%esp)
    34fa:	e8 51 08 00 00       	call   3d50 <printf>
    34ff:	90                   	nop
  hi = 1100*1024;

  for(p = 0; p <= (uint)hi; p += 4096){
    if((pid = fork()) == 0){
    3500:	e8 05 07 00 00       	call   3c0a <fork>
    3505:	85 c0                	test   %eax,%eax
    3507:	89 c6                	mov    %eax,%esi
    3509:	74 79                	je     3584 <validatetest+0xa4>
      // try to crash the kernel by passing in a badly placed integer
      validateint((int*)p);
      exit();
    }
    sleep(0);
    350b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3512:	e8 8b 07 00 00       	call   3ca2 <sleep>
    sleep(0);
    3517:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    351e:	e8 7f 07 00 00       	call   3ca2 <sleep>
    kill(pid);
    3523:	89 34 24             	mov    %esi,(%esp)
    3526:	e8 17 07 00 00       	call   3c42 <kill>
    wait();
    352b:	e8 ea 06 00 00       	call   3c1a <wait>

    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
    3530:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    3534:	c7 04 24 65 4f 00 00 	movl   $0x4f65,(%esp)
    353b:	e8 32 07 00 00       	call   3c72 <link>
    3540:	83 f8 ff             	cmp    $0xffffffff,%eax
    3543:	75 2a                	jne    356f <validatetest+0x8f>
  uint p;

  printf(stdout, "validate test\n");
  hi = 1100*1024;

  for(p = 0; p <= (uint)hi; p += 4096){
    3545:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    354b:	81 fb 00 40 11 00    	cmp    $0x114000,%ebx
    3551:	75 ad                	jne    3500 <validatetest+0x20>
      printf(stdout, "link should not succeed\n");
      exit();
    }
  }

  printf(stdout, "validate ok\n");
    3553:	a1 fc 60 00 00       	mov    0x60fc,%eax
    3558:	c7 44 24 04 89 4f 00 	movl   $0x4f89,0x4(%esp)
    355f:	00 
    3560:	89 04 24             	mov    %eax,(%esp)
    3563:	e8 e8 07 00 00       	call   3d50 <printf>
}
    3568:	83 c4 10             	add    $0x10,%esp
    356b:	5b                   	pop    %ebx
    356c:	5e                   	pop    %esi
    356d:	5d                   	pop    %ebp
    356e:	c3                   	ret    
    kill(pid);
    wait();

    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
      printf(stdout, "link should not succeed\n");
    356f:	a1 fc 60 00 00       	mov    0x60fc,%eax
    3574:	c7 44 24 04 70 4f 00 	movl   $0x4f70,0x4(%esp)
    357b:	00 
    357c:	89 04 24             	mov    %eax,(%esp)
    357f:	e8 cc 07 00 00       	call   3d50 <printf>
      exit();
    3584:	e8 89 06 00 00       	call   3c12 <exit>
    3589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00003590 <bsstest>:

// does unintialized data start out zero?
char uninit[10000];
void
bsstest(void)
{
    3590:	55                   	push   %ebp
    3591:	89 e5                	mov    %esp,%ebp
    3593:	83 ec 18             	sub    $0x18,%esp
  int i;

  printf(stdout, "bss test\n");
    3596:	a1 fc 60 00 00       	mov    0x60fc,%eax
    359b:	c7 44 24 04 96 4f 00 	movl   $0x4f96,0x4(%esp)
    35a2:	00 
    35a3:	89 04 24             	mov    %eax,(%esp)
    35a6:	e8 a5 07 00 00       	call   3d50 <printf>
  for(i = 0; i < sizeof(uninit); i++){
    if(uninit[i] != '\0'){
    35ab:	80 3d c0 61 00 00 00 	cmpb   $0x0,0x61c0
    35b2:	75 36                	jne    35ea <bsstest+0x5a>
    35b4:	b8 01 00 00 00       	mov    $0x1,%eax
    35b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    35c0:	80 b8 c0 61 00 00 00 	cmpb   $0x0,0x61c0(%eax)
    35c7:	75 21                	jne    35ea <bsstest+0x5a>
bsstest(void)
{
  int i;

  printf(stdout, "bss test\n");
  for(i = 0; i < sizeof(uninit); i++){
    35c9:	83 c0 01             	add    $0x1,%eax
    35cc:	3d 10 27 00 00       	cmp    $0x2710,%eax
    35d1:	75 ed                	jne    35c0 <bsstest+0x30>
    if(uninit[i] != '\0'){
      printf(stdout, "bss test failed\n");
      exit();
    }
  }
  printf(stdout, "bss test ok\n");
    35d3:	a1 fc 60 00 00       	mov    0x60fc,%eax
    35d8:	c7 44 24 04 b1 4f 00 	movl   $0x4fb1,0x4(%esp)
    35df:	00 
    35e0:	89 04 24             	mov    %eax,(%esp)
    35e3:	e8 68 07 00 00       	call   3d50 <printf>
}
    35e8:	c9                   	leave  
    35e9:	c3                   	ret    
  int i;

  printf(stdout, "bss test\n");
  for(i = 0; i < sizeof(uninit); i++){
    if(uninit[i] != '\0'){
      printf(stdout, "bss test failed\n");
    35ea:	a1 fc 60 00 00       	mov    0x60fc,%eax
    35ef:	c7 44 24 04 a0 4f 00 	movl   $0x4fa0,0x4(%esp)
    35f6:	00 
    35f7:	89 04 24             	mov    %eax,(%esp)
    35fa:	e8 51 07 00 00       	call   3d50 <printf>
      exit();
    35ff:	e8 0e 06 00 00       	call   3c12 <exit>
    3604:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    360a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00003610 <bigargtest>:
// does exec return an error if the arguments
// are larger than a page? or does it write
// below the stack and wreck the instructions/data?
void
bigargtest(void)
{
    3610:	55                   	push   %ebp
    3611:	89 e5                	mov    %esp,%ebp
    3613:	83 ec 18             	sub    $0x18,%esp
  int pid, fd;

  unlink("bigarg-ok");
    3616:	c7 04 24 be 4f 00 00 	movl   $0x4fbe,(%esp)
    361d:	e8 40 06 00 00       	call   3c62 <unlink>
  pid = fork();
    3622:	e8 e3 05 00 00       	call   3c0a <fork>
  if(pid == 0){
    3627:	83 f8 00             	cmp    $0x0,%eax
    362a:	74 44                	je     3670 <bigargtest+0x60>
    362c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    exec("echo", args);
    printf(stdout, "bigarg test ok\n");
    fd = open("bigarg-ok", O_CREATE);
    close(fd);
    exit();
  } else if(pid < 0){
    3630:	0f 8c d0 00 00 00    	jl     3706 <bigargtest+0xf6>
    printf(stdout, "bigargtest: fork failed\n");
    exit();
  }
  wait();
    3636:	e8 df 05 00 00       	call   3c1a <wait>
  fd = open("bigarg-ok", 0);
    363b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    3642:	00 
    3643:	c7 04 24 be 4f 00 00 	movl   $0x4fbe,(%esp)
    364a:	e8 03 06 00 00       	call   3c52 <open>
  if(fd < 0){
    364f:	85 c0                	test   %eax,%eax
    3651:	0f 88 95 00 00 00    	js     36ec <bigargtest+0xdc>
    printf(stdout, "bigarg test failed!\n");
    exit();
  }
  close(fd);
    3657:	89 04 24             	mov    %eax,(%esp)
    365a:	e8 db 05 00 00       	call   3c3a <close>
  unlink("bigarg-ok");
    365f:	c7 04 24 be 4f 00 00 	movl   $0x4fbe,(%esp)
    3666:	e8 f7 05 00 00       	call   3c62 <unlink>
}
    366b:	c9                   	leave  
    366c:	c3                   	ret    
    366d:	8d 76 00             	lea    0x0(%esi),%esi
  pid = fork();
  if(pid == 0){
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    3670:	c7 04 85 20 61 00 00 	movl   $0x56f4,0x6120(,%eax,4)
    3677:	f4 56 00 00 
  unlink("bigarg-ok");
  pid = fork();
  if(pid == 0){
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
    367b:	83 c0 01             	add    $0x1,%eax
    367e:	83 f8 1f             	cmp    $0x1f,%eax
    3681:	75 ed                	jne    3670 <bigargtest+0x60>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    args[MAXARG-1] = 0;
    printf(stdout, "bigarg test\n");
    3683:	a1 fc 60 00 00       	mov    0x60fc,%eax
    3688:	c7 44 24 04 c8 4f 00 	movl   $0x4fc8,0x4(%esp)
    368f:	00 
  if(pid == 0){
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    args[MAXARG-1] = 0;
    3690:	c7 05 9c 61 00 00 00 	movl   $0x0,0x619c
    3697:	00 00 00 
    printf(stdout, "bigarg test\n");
    369a:	89 04 24             	mov    %eax,(%esp)
    369d:	e8 ae 06 00 00       	call   3d50 <printf>
    exec("echo", args);
    36a2:	c7 44 24 04 20 61 00 	movl   $0x6120,0x4(%esp)
    36a9:	00 
    36aa:	c7 04 24 95 41 00 00 	movl   $0x4195,(%esp)
    36b1:	e8 94 05 00 00       	call   3c4a <exec>
    printf(stdout, "bigarg test ok\n");
    36b6:	a1 fc 60 00 00       	mov    0x60fc,%eax
    36bb:	c7 44 24 04 d5 4f 00 	movl   $0x4fd5,0x4(%esp)
    36c2:	00 
    36c3:	89 04 24             	mov    %eax,(%esp)
    36c6:	e8 85 06 00 00       	call   3d50 <printf>
    fd = open("bigarg-ok", O_CREATE);
    36cb:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    36d2:	00 
    36d3:	c7 04 24 be 4f 00 00 	movl   $0x4fbe,(%esp)
    36da:	e8 73 05 00 00       	call   3c52 <open>
    close(fd);
    36df:	89 04 24             	mov    %eax,(%esp)
    36e2:	e8 53 05 00 00       	call   3c3a <close>
    exit();
    36e7:	e8 26 05 00 00       	call   3c12 <exit>
    exit();
  }
  wait();
  fd = open("bigarg-ok", 0);
  if(fd < 0){
    printf(stdout, "bigarg test failed!\n");
    36ec:	a1 fc 60 00 00       	mov    0x60fc,%eax
    36f1:	c7 44 24 04 fe 4f 00 	movl   $0x4ffe,0x4(%esp)
    36f8:	00 
    36f9:	89 04 24             	mov    %eax,(%esp)
    36fc:	e8 4f 06 00 00       	call   3d50 <printf>
    exit();
    3701:	e8 0c 05 00 00       	call   3c12 <exit>
    printf(stdout, "bigarg test ok\n");
    fd = open("bigarg-ok", O_CREATE);
    close(fd);
    exit();
  } else if(pid < 0){
    printf(stdout, "bigargtest: fork failed\n");
    3706:	a1 fc 60 00 00       	mov    0x60fc,%eax
    370b:	c7 44 24 04 e5 4f 00 	movl   $0x4fe5,0x4(%esp)
    3712:	00 
    3713:	89 04 24             	mov    %eax,(%esp)
    3716:	e8 35 06 00 00       	call   3d50 <printf>
    exit();
    371b:	e8 f2 04 00 00       	call   3c12 <exit>

00003720 <fsfull>:

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    3720:	55                   	push   %ebp
    3721:	89 e5                	mov    %esp,%ebp
    3723:	57                   	push   %edi
    3724:	56                   	push   %esi
    3725:	53                   	push   %ebx
  int nfiles;
  int fsblocks = 0;

  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    3726:	31 db                	xor    %ebx,%ebx

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    3728:	83 ec 5c             	sub    $0x5c,%esp
  int nfiles;
  int fsblocks = 0;

  printf(1, "fsfull test\n");
    372b:	c7 44 24 04 13 50 00 	movl   $0x5013,0x4(%esp)
    3732:	00 
    3733:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    373a:	e8 11 06 00 00       	call   3d50 <printf>
    373f:	90                   	nop

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    3740:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    3745:	89 d9                	mov    %ebx,%ecx
    3747:	f7 eb                	imul   %ebx
    name[2] = '0' + (nfiles % 1000) / 100;
    3749:	89 de                	mov    %ebx,%esi
  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    374b:	c1 f9 1f             	sar    $0x1f,%ecx
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    374e:	89 df                	mov    %ebx,%edi
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    printf(1, "writing %s\n", name);
    3750:	c7 44 24 04 20 50 00 	movl   $0x5020,0x4(%esp)
    3757:	00 
    3758:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    375f:	c1 fa 06             	sar    $0x6,%edx
    3762:	29 ca                	sub    %ecx,%edx
    3764:	8d 42 30             	lea    0x30(%edx),%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    3767:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    376d:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    3770:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax

  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    3775:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    3779:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    377d:	29 d6                	sub    %edx,%esi
    377f:	f7 ee                	imul   %esi
    name[3] = '0' + (nfiles % 100) / 10;
    3781:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    3786:	c1 fe 1f             	sar    $0x1f,%esi
    3789:	c1 fa 05             	sar    $0x5,%edx
    378c:	29 f2                	sub    %esi,%edx
    name[3] = '0' + (nfiles % 100) / 10;
    378e:	be 67 66 66 66       	mov    $0x66666667,%esi

  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    3793:	83 c2 30             	add    $0x30,%edx
    3796:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    3799:	f7 eb                	imul   %ebx
    379b:	c1 fa 05             	sar    $0x5,%edx
    379e:	29 ca                	sub    %ecx,%edx
    37a0:	6b d2 64             	imul   $0x64,%edx,%edx
    37a3:	29 d7                	sub    %edx,%edi
    37a5:	89 f8                	mov    %edi,%eax
    37a7:	f7 ee                	imul   %esi
    name[4] = '0' + (nfiles % 10);
    37a9:	89 d8                	mov    %ebx,%eax
  for(nfiles = 0; ; nfiles++){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    37ab:	c1 ff 1f             	sar    $0x1f,%edi
    37ae:	c1 fa 02             	sar    $0x2,%edx
    37b1:	29 fa                	sub    %edi,%edx
    37b3:	83 c2 30             	add    $0x30,%edx
    37b6:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    37b9:	f7 ee                	imul   %esi
    37bb:	c1 fa 02             	sar    $0x2,%edx
    37be:	29 ca                	sub    %ecx,%edx
    37c0:	8d 04 92             	lea    (%edx,%edx,4),%eax
    37c3:	89 da                	mov    %ebx,%edx
    37c5:	01 c0                	add    %eax,%eax
    37c7:	29 c2                	sub    %eax,%edx
    37c9:	89 d0                	mov    %edx,%eax
    37cb:	83 c0 30             	add    $0x30,%eax
    37ce:	88 45 ac             	mov    %al,-0x54(%ebp)
    name[5] = '\0';
    printf(1, "writing %s\n", name);
    37d1:	8d 45 a8             	lea    -0x58(%ebp),%eax
    37d4:	89 44 24 08          	mov    %eax,0x8(%esp)
    37d8:	e8 73 05 00 00       	call   3d50 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    37dd:	8d 55 a8             	lea    -0x58(%ebp),%edx
    37e0:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    37e7:	00 
    37e8:	89 14 24             	mov    %edx,(%esp)
    37eb:	e8 62 04 00 00       	call   3c52 <open>
    if(fd < 0){
    37f0:	85 c0                	test   %eax,%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    printf(1, "writing %s\n", name);
    int fd = open(name, O_CREATE|O_RDWR);
    37f2:	89 c7                	mov    %eax,%edi
    if(fd < 0){
    37f4:	0f 88 13 01 00 00    	js     390d <fsfull+0x1ed>
    37fa:	31 f6                	xor    %esi,%esi
    37fc:	eb 04                	jmp    3802 <fsfull+0xe2>
    37fe:	66 90                	xchg   %ax,%ax
    int total = 0;
    while(1){
      int cc = write(fd, buf, 512);
      if(cc < 512)
        break;
      total += cc;
    3800:	01 c6                	add    %eax,%esi
      printf(1, "open %s failed\n", name);
      break;
    }
    int total = 0;
    while(1){
      int cc = write(fd, buf, 512);
    3802:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    3809:	00 
    380a:	c7 44 24 04 e0 88 00 	movl   $0x88e0,0x4(%esp)
    3811:	00 
    3812:	89 3c 24             	mov    %edi,(%esp)
    3815:	e8 18 04 00 00       	call   3c32 <write>
      if(cc < 512)
    381a:	3d ff 01 00 00       	cmp    $0x1ff,%eax
    381f:	7f df                	jg     3800 <fsfull+0xe0>
        break;
      total += cc;
      fsblocks++;
    }
    printf(1, "wrote %d bytes\n", total);
    3821:	89 74 24 08          	mov    %esi,0x8(%esp)
    3825:	c7 44 24 04 3c 50 00 	movl   $0x503c,0x4(%esp)
    382c:	00 
    382d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3834:	e8 17 05 00 00       	call   3d50 <printf>
    close(fd);
    3839:	89 3c 24             	mov    %edi,(%esp)
    383c:	e8 f9 03 00 00       	call   3c3a <close>
    if(total == 0)
    3841:	85 f6                	test   %esi,%esi
    3843:	0f 84 9f 00 00 00    	je     38e8 <fsfull+0x1c8>
  int nfiles;
  int fsblocks = 0;

  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    3849:	83 c3 01             	add    $0x1,%ebx
    }
    printf(1, "wrote %d bytes\n", total);
    close(fd);
    if(total == 0)
      break;
  }
    384c:	e9 ef fe ff ff       	jmp    3740 <fsfull+0x20>
    3851:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    3858:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    385d:	89 d9                	mov    %ebx,%ecx
    385f:	f7 eb                	imul   %ebx
    name[2] = '0' + (nfiles % 1000) / 100;
    3861:	89 de                	mov    %ebx,%esi
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    3863:	c1 f9 1f             	sar    $0x1f,%ecx
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    3866:	89 df                	mov    %ebx,%edi
      break;
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    3868:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    386c:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    3870:	c1 fa 06             	sar    $0x6,%edx
    3873:	29 ca                	sub    %ecx,%edx
    3875:	8d 42 30             	lea    0x30(%edx),%eax
    name[2] = '0' + (nfiles % 1000) / 100;
    3878:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    387e:	88 45 a9             	mov    %al,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    3881:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    3886:	29 d6                	sub    %edx,%esi
    3888:	f7 ee                	imul   %esi
    name[3] = '0' + (nfiles % 100) / 10;
    388a:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    388f:	c1 fe 1f             	sar    $0x1f,%esi
    3892:	c1 fa 05             	sar    $0x5,%edx
    3895:	29 f2                	sub    %esi,%edx
    name[3] = '0' + (nfiles % 100) / 10;
    3897:	be 67 66 66 66       	mov    $0x66666667,%esi

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    389c:	83 c2 30             	add    $0x30,%edx
    389f:	88 55 aa             	mov    %dl,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    38a2:	f7 eb                	imul   %ebx
    38a4:	c1 fa 05             	sar    $0x5,%edx
    38a7:	29 ca                	sub    %ecx,%edx
    38a9:	6b d2 64             	imul   $0x64,%edx,%edx
    38ac:	29 d7                	sub    %edx,%edi
    38ae:	89 f8                	mov    %edi,%eax
    38b0:	f7 ee                	imul   %esi
    name[4] = '0' + (nfiles % 10);
    38b2:	89 d8                	mov    %ebx,%eax
  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    38b4:	c1 ff 1f             	sar    $0x1f,%edi
    38b7:	c1 fa 02             	sar    $0x2,%edx
    38ba:	29 fa                	sub    %edi,%edx
    38bc:	83 c2 30             	add    $0x30,%edx
    38bf:	88 55 ab             	mov    %dl,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    38c2:	f7 ee                	imul   %esi
    38c4:	c1 fa 02             	sar    $0x2,%edx
    38c7:	29 ca                	sub    %ecx,%edx
    38c9:	8d 04 92             	lea    (%edx,%edx,4),%eax
    38cc:	89 da                	mov    %ebx,%edx
    38ce:	01 c0                	add    %eax,%eax
    name[5] = '\0';
    unlink(name);
    nfiles--;
    38d0:	83 eb 01             	sub    $0x1,%ebx
    char name[64];
    name[0] = 'f';
    name[1] = '0' + nfiles / 1000;
    name[2] = '0' + (nfiles % 1000) / 100;
    name[3] = '0' + (nfiles % 100) / 10;
    name[4] = '0' + (nfiles % 10);
    38d3:	29 c2                	sub    %eax,%edx
    38d5:	89 d0                	mov    %edx,%eax
    38d7:	83 c0 30             	add    $0x30,%eax
    38da:	88 45 ac             	mov    %al,-0x54(%ebp)
    name[5] = '\0';
    unlink(name);
    38dd:	8d 45 a8             	lea    -0x58(%ebp),%eax
    38e0:	89 04 24             	mov    %eax,(%esp)
    38e3:	e8 7a 03 00 00       	call   3c62 <unlink>
    close(fd);
    if(total == 0)
      break;
  }

  while(nfiles >= 0){
    38e8:	83 fb ff             	cmp    $0xffffffff,%ebx
    38eb:	0f 85 67 ff ff ff    	jne    3858 <fsfull+0x138>
    name[5] = '\0';
    unlink(name);
    nfiles--;
  }

  printf(1, "fsfull test finished\n");
    38f1:	c7 44 24 04 4c 50 00 	movl   $0x504c,0x4(%esp)
    38f8:	00 
    38f9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3900:	e8 4b 04 00 00       	call   3d50 <printf>
}
    3905:	83 c4 5c             	add    $0x5c,%esp
    3908:	5b                   	pop    %ebx
    3909:	5e                   	pop    %esi
    390a:	5f                   	pop    %edi
    390b:	5d                   	pop    %ebp
    390c:	c3                   	ret    
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    printf(1, "writing %s\n", name);
    int fd = open(name, O_CREATE|O_RDWR);
    if(fd < 0){
      printf(1, "open %s failed\n", name);
    390d:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3910:	89 44 24 08          	mov    %eax,0x8(%esp)
    3914:	c7 44 24 04 2c 50 00 	movl   $0x502c,0x4(%esp)
    391b:	00 
    391c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3923:	e8 28 04 00 00       	call   3d50 <printf>
    3928:	eb be                	jmp    38e8 <fsfull+0x1c8>
    392a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00003930 <uio>:
  printf(1, "fsfull test finished\n");
}

void
uio()
{
    3930:	55                   	push   %ebp
    3931:	89 e5                	mov    %esp,%ebp
    3933:	83 ec 18             	sub    $0x18,%esp

  ushort port = 0;
  uchar val = 0;
  int pid;

  printf(1, "uio test\n");
    3936:	c7 44 24 04 62 50 00 	movl   $0x5062,0x4(%esp)
    393d:	00 
    393e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3945:	e8 06 04 00 00       	call   3d50 <printf>
  pid = fork();
    394a:	e8 bb 02 00 00       	call   3c0a <fork>
  if(pid == 0){
    394f:	83 f8 00             	cmp    $0x0,%eax
    3952:	74 1d                	je     3971 <uio+0x41>
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    port = RTC_DATA;
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    printf(1, "uio: uio succeeded; test FAILED\n");
    exit();
  } else if(pid < 0){
    3954:	7c 42                	jl     3998 <uio+0x68>
    printf (1, "fork failed\n");
    exit();
  }
  wait();
    3956:	e8 bf 02 00 00       	call   3c1a <wait>
  printf(1, "uio test done\n");
    395b:	c7 44 24 04 6c 50 00 	movl   $0x506c,0x4(%esp)
    3962:	00 
    3963:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    396a:	e8 e1 03 00 00       	call   3d50 <printf>
}
    396f:	c9                   	leave  
    3970:	c3                   	ret    
  pid = fork();
  if(pid == 0){
    port = RTC_ADDR;
    val = 0x09;  /* year */
    /* http://wiki.osdev.org/Inline_Assembly/Examples */
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    3971:	ba 70 00 00 00       	mov    $0x70,%edx
    3976:	b8 09 00 00 00       	mov    $0x9,%eax
    397b:	ee                   	out    %al,(%dx)
    port = RTC_DATA;
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    397c:	b2 71                	mov    $0x71,%dl
    397e:	ec                   	in     (%dx),%al
    printf(1, "uio: uio succeeded; test FAILED\n");
    397f:	c7 44 24 04 d4 57 00 	movl   $0x57d4,0x4(%esp)
    3986:	00 
    3987:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    398e:	e8 bd 03 00 00       	call   3d50 <printf>
    exit();
    3993:	e8 7a 02 00 00       	call   3c12 <exit>
  } else if(pid < 0){
    printf (1, "fork failed\n");
    3998:	c7 44 24 04 f1 4f 00 	movl   $0x4ff1,0x4(%esp)
    399f:	00 
    39a0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    39a7:	e8 a4 03 00 00       	call   3d50 <printf>
    exit();
    39ac:	e8 61 02 00 00       	call   3c12 <exit>
    39b1:	eb 0d                	jmp    39c0 <rand>
    39b3:	90                   	nop
    39b4:	90                   	nop
    39b5:	90                   	nop
    39b6:	90                   	nop
    39b7:	90                   	nop
    39b8:	90                   	nop
    39b9:	90                   	nop
    39ba:	90                   	nop
    39bb:	90                   	nop
    39bc:	90                   	nop
    39bd:	90                   	nop
    39be:	90                   	nop
    39bf:	90                   	nop

000039c0 <rand>:

unsigned long randstate = 1;
unsigned int
rand()
{
  randstate = randstate * 1664525 + 1013904223;
    39c0:	69 05 f8 60 00 00 0d 	imul   $0x19660d,0x60f8,%eax
    39c7:	66 19 00 
}

unsigned long randstate = 1;
unsigned int
rand()
{
    39ca:	55                   	push   %ebp
    39cb:	89 e5                	mov    %esp,%ebp
  randstate = randstate * 1664525 + 1013904223;
  return randstate;
}
    39cd:	5d                   	pop    %ebp

unsigned long randstate = 1;
unsigned int
rand()
{
  randstate = randstate * 1664525 + 1013904223;
    39ce:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    39d3:	a3 f8 60 00 00       	mov    %eax,0x60f8
  return randstate;
}
    39d8:	c3                   	ret    
    39d9:	66 90                	xchg   %ax,%ax
    39db:	66 90                	xchg   %ax,%ax
    39dd:	66 90                	xchg   %ax,%ax
    39df:	90                   	nop

000039e0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    39e0:	55                   	push   %ebp
    39e1:	89 e5                	mov    %esp,%ebp
    39e3:	8b 45 08             	mov    0x8(%ebp),%eax
    39e6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    39e9:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    39ea:	89 c2                	mov    %eax,%edx
    39ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    39f0:	0f b6 19             	movzbl (%ecx),%ebx
    39f3:	83 c1 01             	add    $0x1,%ecx
    39f6:	88 1a                	mov    %bl,(%edx)
    39f8:	83 c2 01             	add    $0x1,%edx
    39fb:	84 db                	test   %bl,%bl
    39fd:	75 f1                	jne    39f0 <strcpy+0x10>
    ;
  return os;
}
    39ff:	5b                   	pop    %ebx
    3a00:	5d                   	pop    %ebp
    3a01:	c3                   	ret    
    3a02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3a09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003a10 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3a10:	55                   	push   %ebp
    3a11:	89 e5                	mov    %esp,%ebp
    3a13:	8b 55 08             	mov    0x8(%ebp),%edx
    3a16:	56                   	push   %esi
    3a17:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    3a1a:	53                   	push   %ebx
  while(*p && *p == *q)
    3a1b:	0f b6 02             	movzbl (%edx),%eax
    3a1e:	0f b6 19             	movzbl (%ecx),%ebx
    3a21:	84 c0                	test   %al,%al
    3a23:	75 16                	jne    3a3b <strcmp+0x2b>
    3a25:	eb 21                	jmp    3a48 <strcmp+0x38>
    3a27:	90                   	nop
    p++, q++;
    3a28:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    3a2b:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
    3a2f:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    3a32:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    3a35:	84 c0                	test   %al,%al
    3a37:	74 0f                	je     3a48 <strcmp+0x38>
    p++, q++;
    3a39:	89 f1                	mov    %esi,%ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    3a3b:	38 d8                	cmp    %bl,%al
    3a3d:	74 e9                	je     3a28 <strcmp+0x18>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    3a3f:	29 d8                	sub    %ebx,%eax
}
    3a41:	5b                   	pop    %ebx
    3a42:	5e                   	pop    %esi
    3a43:	5d                   	pop    %ebp
    3a44:	c3                   	ret    
    3a45:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    3a48:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
    3a4a:	29 d8                	sub    %ebx,%eax
}
    3a4c:	5b                   	pop    %ebx
    3a4d:	5e                   	pop    %esi
    3a4e:	5d                   	pop    %ebp
    3a4f:	c3                   	ret    

00003a50 <strlen>:

uint
strlen(char *s)
{
    3a50:	55                   	push   %ebp
    3a51:	89 e5                	mov    %esp,%ebp
    3a53:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    3a56:	80 39 00             	cmpb   $0x0,(%ecx)
    3a59:	74 12                	je     3a6d <strlen+0x1d>
    3a5b:	31 d2                	xor    %edx,%edx
    3a5d:	8d 76 00             	lea    0x0(%esi),%esi
    3a60:	83 c2 01             	add    $0x1,%edx
    3a63:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    3a67:	89 d0                	mov    %edx,%eax
    3a69:	75 f5                	jne    3a60 <strlen+0x10>
    ;
  return n;
}
    3a6b:	5d                   	pop    %ebp
    3a6c:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
    3a6d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
    3a6f:	5d                   	pop    %ebp
    3a70:	c3                   	ret    
    3a71:	eb 0d                	jmp    3a80 <memset>
    3a73:	90                   	nop
    3a74:	90                   	nop
    3a75:	90                   	nop
    3a76:	90                   	nop
    3a77:	90                   	nop
    3a78:	90                   	nop
    3a79:	90                   	nop
    3a7a:	90                   	nop
    3a7b:	90                   	nop
    3a7c:	90                   	nop
    3a7d:	90                   	nop
    3a7e:	90                   	nop
    3a7f:	90                   	nop

00003a80 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3a80:	55                   	push   %ebp
    3a81:	89 e5                	mov    %esp,%ebp
    3a83:	8b 55 08             	mov    0x8(%ebp),%edx
    3a86:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    3a87:	8b 4d 10             	mov    0x10(%ebp),%ecx
    3a8a:	8b 45 0c             	mov    0xc(%ebp),%eax
    3a8d:	89 d7                	mov    %edx,%edi
    3a8f:	fc                   	cld    
    3a90:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    3a92:	89 d0                	mov    %edx,%eax
    3a94:	5f                   	pop    %edi
    3a95:	5d                   	pop    %ebp
    3a96:	c3                   	ret    
    3a97:	89 f6                	mov    %esi,%esi
    3a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003aa0 <strchr>:

char*
strchr(const char *s, char c)
{
    3aa0:	55                   	push   %ebp
    3aa1:	89 e5                	mov    %esp,%ebp
    3aa3:	8b 45 08             	mov    0x8(%ebp),%eax
    3aa6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    3aaa:	0f b6 10             	movzbl (%eax),%edx
    3aad:	84 d2                	test   %dl,%dl
    3aaf:	75 11                	jne    3ac2 <strchr+0x22>
    3ab1:	eb 15                	jmp    3ac8 <strchr+0x28>
    3ab3:	90                   	nop
    3ab4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3ab8:	83 c0 01             	add    $0x1,%eax
    3abb:	0f b6 10             	movzbl (%eax),%edx
    3abe:	84 d2                	test   %dl,%dl
    3ac0:	74 06                	je     3ac8 <strchr+0x28>
    if(*s == c)
    3ac2:	38 ca                	cmp    %cl,%dl
    3ac4:	75 f2                	jne    3ab8 <strchr+0x18>
      return (char*)s;
  return 0;
}
    3ac6:	5d                   	pop    %ebp
    3ac7:	c3                   	ret    
strchr(const char *s, char c)
{
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
    3ac8:	31 c0                	xor    %eax,%eax
}
    3aca:	5d                   	pop    %ebp
    3acb:	90                   	nop
    3acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3ad0:	c3                   	ret    
    3ad1:	eb 0d                	jmp    3ae0 <gets>
    3ad3:	90                   	nop
    3ad4:	90                   	nop
    3ad5:	90                   	nop
    3ad6:	90                   	nop
    3ad7:	90                   	nop
    3ad8:	90                   	nop
    3ad9:	90                   	nop
    3ada:	90                   	nop
    3adb:	90                   	nop
    3adc:	90                   	nop
    3add:	90                   	nop
    3ade:	90                   	nop
    3adf:	90                   	nop

00003ae0 <gets>:

char*
gets(char *buf, int max)
{
    3ae0:	55                   	push   %ebp
    3ae1:	89 e5                	mov    %esp,%ebp
    3ae3:	57                   	push   %edi
    3ae4:	56                   	push   %esi
    3ae5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3ae6:	31 db                	xor    %ebx,%ebx
  return 0;
}

char*
gets(char *buf, int max)
{
    3ae8:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    3aeb:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3aee:	8d 73 01             	lea    0x1(%ebx),%esi
    3af1:	3b 75 0c             	cmp    0xc(%ebp),%esi
    3af4:	7d 42                	jge    3b38 <gets+0x58>
    cc = read(0, &c, 1);
    3af6:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3afd:	00 
    3afe:	89 7c 24 04          	mov    %edi,0x4(%esp)
    3b02:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3b09:	e8 1c 01 00 00       	call   3c2a <read>
    if(cc < 1)
    3b0e:	85 c0                	test   %eax,%eax
    3b10:	7e 26                	jle    3b38 <gets+0x58>
      break;
    buf[i++] = c;
    3b12:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    3b16:	89 f3                	mov    %esi,%ebx
    3b18:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
    3b1b:	3c 0d                	cmp    $0xd,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    3b1d:	88 44 32 ff          	mov    %al,-0x1(%edx,%esi,1)
    if(c == '\n' || c == '\r')
    3b21:	74 04                	je     3b27 <gets+0x47>
    3b23:	3c 0a                	cmp    $0xa,%al
    3b25:	75 c7                	jne    3aee <gets+0xe>
      break;
  }
  buf[i] = '\0';
    3b27:	8b 45 08             	mov    0x8(%ebp),%eax
    3b2a:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    3b2e:	83 c4 2c             	add    $0x2c,%esp
    3b31:	5b                   	pop    %ebx
    3b32:	5e                   	pop    %esi
    3b33:	5f                   	pop    %edi
    3b34:	5d                   	pop    %ebp
    3b35:	c3                   	ret    
    3b36:	66 90                	xchg   %ax,%ax
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    3b38:	8b 45 08             	mov    0x8(%ebp),%eax
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
    3b3b:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    3b3d:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    3b41:	83 c4 2c             	add    $0x2c,%esp
    3b44:	5b                   	pop    %ebx
    3b45:	5e                   	pop    %esi
    3b46:	5f                   	pop    %edi
    3b47:	5d                   	pop    %ebp
    3b48:	c3                   	ret    
    3b49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00003b50 <stat>:

int
stat(char *n, struct stat *st)
{
    3b50:	55                   	push   %ebp
    3b51:	89 e5                	mov    %esp,%ebp
    3b53:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3b56:	8b 45 08             	mov    0x8(%ebp),%eax
    3b59:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    3b60:	00 
  return buf;
}

int
stat(char *n, struct stat *st)
{
    3b61:	89 5d f8             	mov    %ebx,-0x8(%ebp)
    3b64:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3b67:	89 04 24             	mov    %eax,(%esp)
    3b6a:	e8 e3 00 00 00       	call   3c52 <open>
  if(fd < 0)
    3b6f:	85 c0                	test   %eax,%eax
stat(char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3b71:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
    3b73:	78 2b                	js     3ba0 <stat+0x50>
    return -1;
  r = fstat(fd, st);
    3b75:	8b 45 0c             	mov    0xc(%ebp),%eax
    3b78:	89 1c 24             	mov    %ebx,(%esp)
    3b7b:	89 44 24 04          	mov    %eax,0x4(%esp)
    3b7f:	e8 e6 00 00 00       	call   3c6a <fstat>
  close(fd);
    3b84:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
    3b87:	89 c6                	mov    %eax,%esi
  close(fd);
    3b89:	e8 ac 00 00 00       	call   3c3a <close>
  return r;
}
    3b8e:	89 f0                	mov    %esi,%eax
    3b90:	8b 5d f8             	mov    -0x8(%ebp),%ebx
    3b93:	8b 75 fc             	mov    -0x4(%ebp),%esi
    3b96:	89 ec                	mov    %ebp,%esp
    3b98:	5d                   	pop    %ebp
    3b99:	c3                   	ret    
    3b9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
    3ba0:	be ff ff ff ff       	mov    $0xffffffff,%esi
    3ba5:	eb e7                	jmp    3b8e <stat+0x3e>
    3ba7:	89 f6                	mov    %esi,%esi
    3ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00003bb0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
    3bb0:	55                   	push   %ebp
    3bb1:	89 e5                	mov    %esp,%ebp
    3bb3:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3bb6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3bb7:	0f be 11             	movsbl (%ecx),%edx
    3bba:	8d 42 d0             	lea    -0x30(%edx),%eax
    3bbd:	3c 09                	cmp    $0x9,%al
    3bbf:	b8 00 00 00 00       	mov    $0x0,%eax
    3bc4:	77 17                	ja     3bdd <atoi+0x2d>
    3bc6:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
    3bc8:	83 c1 01             	add    $0x1,%ecx
    3bcb:	8d 04 80             	lea    (%eax,%eax,4),%eax
    3bce:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3bd2:	0f be 11             	movsbl (%ecx),%edx
    3bd5:	8d 5a d0             	lea    -0x30(%edx),%ebx
    3bd8:	80 fb 09             	cmp    $0x9,%bl
    3bdb:	76 eb                	jbe    3bc8 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
    3bdd:	5b                   	pop    %ebx
    3bde:	5d                   	pop    %ebp
    3bdf:	c3                   	ret    

00003be0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    3be0:	55                   	push   %ebp
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, void *vsrc, int n)
    3be1:	31 d2                	xor    %edx,%edx
{
    3be3:	89 e5                	mov    %esp,%ebp
    3be5:	56                   	push   %esi
    3be6:	8b 45 08             	mov    0x8(%ebp),%eax
    3be9:	53                   	push   %ebx
    3bea:	8b 5d 10             	mov    0x10(%ebp),%ebx
    3bed:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    3bf0:	85 db                	test   %ebx,%ebx
    3bf2:	7e 12                	jle    3c06 <memmove+0x26>
    3bf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    3bf8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    3bfc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    3bff:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    3c02:	39 da                	cmp    %ebx,%edx
    3c04:	75 f2                	jne    3bf8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
    3c06:	5b                   	pop    %ebx
    3c07:	5e                   	pop    %esi
    3c08:	5d                   	pop    %ebp
    3c09:	c3                   	ret    

00003c0a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    3c0a:	b8 01 00 00 00       	mov    $0x1,%eax
    3c0f:	cd 40                	int    $0x40
    3c11:	c3                   	ret    

00003c12 <exit>:
SYSCALL(exit)
    3c12:	b8 02 00 00 00       	mov    $0x2,%eax
    3c17:	cd 40                	int    $0x40
    3c19:	c3                   	ret    

00003c1a <wait>:
SYSCALL(wait)
    3c1a:	b8 03 00 00 00       	mov    $0x3,%eax
    3c1f:	cd 40                	int    $0x40
    3c21:	c3                   	ret    

00003c22 <pipe>:
SYSCALL(pipe)
    3c22:	b8 04 00 00 00       	mov    $0x4,%eax
    3c27:	cd 40                	int    $0x40
    3c29:	c3                   	ret    

00003c2a <read>:
SYSCALL(read)
    3c2a:	b8 05 00 00 00       	mov    $0x5,%eax
    3c2f:	cd 40                	int    $0x40
    3c31:	c3                   	ret    

00003c32 <write>:
SYSCALL(write)
    3c32:	b8 10 00 00 00       	mov    $0x10,%eax
    3c37:	cd 40                	int    $0x40
    3c39:	c3                   	ret    

00003c3a <close>:
SYSCALL(close)
    3c3a:	b8 15 00 00 00       	mov    $0x15,%eax
    3c3f:	cd 40                	int    $0x40
    3c41:	c3                   	ret    

00003c42 <kill>:
SYSCALL(kill)
    3c42:	b8 06 00 00 00       	mov    $0x6,%eax
    3c47:	cd 40                	int    $0x40
    3c49:	c3                   	ret    

00003c4a <exec>:
SYSCALL(exec)
    3c4a:	b8 07 00 00 00       	mov    $0x7,%eax
    3c4f:	cd 40                	int    $0x40
    3c51:	c3                   	ret    

00003c52 <open>:
SYSCALL(open)
    3c52:	b8 0f 00 00 00       	mov    $0xf,%eax
    3c57:	cd 40                	int    $0x40
    3c59:	c3                   	ret    

00003c5a <mknod>:
SYSCALL(mknod)
    3c5a:	b8 11 00 00 00       	mov    $0x11,%eax
    3c5f:	cd 40                	int    $0x40
    3c61:	c3                   	ret    

00003c62 <unlink>:
SYSCALL(unlink)
    3c62:	b8 12 00 00 00       	mov    $0x12,%eax
    3c67:	cd 40                	int    $0x40
    3c69:	c3                   	ret    

00003c6a <fstat>:
SYSCALL(fstat)
    3c6a:	b8 08 00 00 00       	mov    $0x8,%eax
    3c6f:	cd 40                	int    $0x40
    3c71:	c3                   	ret    

00003c72 <link>:
SYSCALL(link)
    3c72:	b8 13 00 00 00       	mov    $0x13,%eax
    3c77:	cd 40                	int    $0x40
    3c79:	c3                   	ret    

00003c7a <mkdir>:
SYSCALL(mkdir)
    3c7a:	b8 14 00 00 00       	mov    $0x14,%eax
    3c7f:	cd 40                	int    $0x40
    3c81:	c3                   	ret    

00003c82 <chdir>:
SYSCALL(chdir)
    3c82:	b8 09 00 00 00       	mov    $0x9,%eax
    3c87:	cd 40                	int    $0x40
    3c89:	c3                   	ret    

00003c8a <dup>:
SYSCALL(dup)
    3c8a:	b8 0a 00 00 00       	mov    $0xa,%eax
    3c8f:	cd 40                	int    $0x40
    3c91:	c3                   	ret    

00003c92 <getpid>:
SYSCALL(getpid)
    3c92:	b8 0b 00 00 00       	mov    $0xb,%eax
    3c97:	cd 40                	int    $0x40
    3c99:	c3                   	ret    

00003c9a <sbrk>:
SYSCALL(sbrk)
    3c9a:	b8 0c 00 00 00       	mov    $0xc,%eax
    3c9f:	cd 40                	int    $0x40
    3ca1:	c3                   	ret    

00003ca2 <sleep>:
SYSCALL(sleep)
    3ca2:	b8 0d 00 00 00       	mov    $0xd,%eax
    3ca7:	cd 40                	int    $0x40
    3ca9:	c3                   	ret    

00003caa <uptime>:
SYSCALL(uptime)
    3caa:	b8 0e 00 00 00       	mov    $0xe,%eax
    3caf:	cd 40                	int    $0x40
    3cb1:	c3                   	ret    

00003cb2 <getprocs>:
SYSCALL(getprocs)
    3cb2:	b8 16 00 00 00       	mov    $0x16,%eax
    3cb7:	cd 40                	int    $0x40
    3cb9:	c3                   	ret    
    3cba:	66 90                	xchg   %ax,%ax
    3cbc:	66 90                	xchg   %ax,%ax
    3cbe:	66 90                	xchg   %ax,%ax

00003cc0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    3cc0:	55                   	push   %ebp
    3cc1:	89 e5                	mov    %esp,%ebp
    3cc3:	57                   	push   %edi
    3cc4:	89 c7                	mov    %eax,%edi
    3cc6:	56                   	push   %esi
    3cc7:	53                   	push   %ebx
    3cc8:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    3ccb:	8b 45 08             	mov    0x8(%ebp),%eax
    3cce:	85 c0                	test   %eax,%eax
    3cd0:	74 76                	je     3d48 <printint+0x88>
    3cd2:	89 d0                	mov    %edx,%eax
    3cd4:	c1 e8 1f             	shr    $0x1f,%eax
    3cd7:	84 c0                	test   %al,%al
    3cd9:	74 6d                	je     3d48 <printint+0x88>
    neg = 1;
    x = -xx;
    3cdb:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    3cdd:	bb 01 00 00 00       	mov    $0x1,%ebx
    x = -xx;
    3ce2:	f7 d8                	neg    %eax
  } else {
    x = xx;
  }

  i = 0;
    3ce4:	31 f6                	xor    %esi,%esi
    3ce6:	eb 02                	jmp    3cea <printint+0x2a>
  do{
    buf[i++] = digits[x % base];
    3ce8:	89 d6                	mov    %edx,%esi
    3cea:	31 d2                	xor    %edx,%edx
    3cec:	f7 f1                	div    %ecx
    3cee:	0f b6 92 2b 58 00 00 	movzbl 0x582b(%edx),%edx
  }while((x /= base) != 0);
    3cf5:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    3cf7:	88 54 35 d8          	mov    %dl,-0x28(%ebp,%esi,1)
    3cfb:	8d 56 01             	lea    0x1(%esi),%edx
  }while((x /= base) != 0);
    3cfe:	75 e8                	jne    3ce8 <printint+0x28>
  if(neg)
    3d00:	85 db                	test   %ebx,%ebx
    3d02:	74 08                	je     3d0c <printint+0x4c>
    buf[i++] = '-';
    3d04:	c6 44 15 d8 2d       	movb   $0x2d,-0x28(%ebp,%edx,1)
    3d09:	8d 56 02             	lea    0x2(%esi),%edx

  while(--i >= 0)
    3d0c:	8d 5a ff             	lea    -0x1(%edx),%ebx
    3d0f:	83 fb ff             	cmp    $0xffffffff,%ebx
    3d12:	8d 75 d7             	lea    -0x29(%ebp),%esi
    3d15:	74 25                	je     3d3c <printint+0x7c>
    3d17:	90                   	nop
    3d18:	0f b6 44 1d d8       	movzbl -0x28(%ebp,%ebx,1),%eax
    3d1d:	83 eb 01             	sub    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3d20:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3d27:	00 
    3d28:	89 74 24 04          	mov    %esi,0x4(%esp)
    3d2c:	89 3c 24             	mov    %edi,(%esp)
    3d2f:	88 45 d7             	mov    %al,-0x29(%ebp)
    3d32:	e8 fb fe ff ff       	call   3c32 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    3d37:	83 fb ff             	cmp    $0xffffffff,%ebx
    3d3a:	75 dc                	jne    3d18 <printint+0x58>
    putc(fd, buf[i]);
}
    3d3c:	83 c4 3c             	add    $0x3c,%esp
    3d3f:	5b                   	pop    %ebx
    3d40:	5e                   	pop    %esi
    3d41:	5f                   	pop    %edi
    3d42:	5d                   	pop    %ebp
    3d43:	c3                   	ret    
    3d44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    3d48:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    3d4a:	31 db                	xor    %ebx,%ebx
    3d4c:	eb 96                	jmp    3ce4 <printint+0x24>
    3d4e:	66 90                	xchg   %ax,%ax

00003d50 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    3d50:	55                   	push   %ebp
    3d51:	89 e5                	mov    %esp,%ebp
    3d53:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    3d54:	31 ff                	xor    %edi,%edi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    3d56:	56                   	push   %esi
    3d57:	53                   	push   %ebx
    3d58:	83 ec 3c             	sub    $0x3c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3d5b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    3d5e:	8d 55 10             	lea    0x10(%ebp),%edx
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    3d61:	8b 75 08             	mov    0x8(%ebp),%esi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    3d64:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
    3d67:	0f be 03             	movsbl (%ebx),%eax
    putc(fd, buf[i]);
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
    3d6a:	83 c3 01             	add    $0x1,%ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3d6d:	84 c0                	test   %al,%al
    3d6f:	75 39                	jne    3daa <printf+0x5a>
    3d71:	e9 c2 00 00 00       	jmp    3e38 <printf+0xe8>
    3d76:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    3d78:	83 fa 25             	cmp    $0x25,%edx
    3d7b:	0f 84 bf 00 00 00    	je     3e40 <printf+0xf0>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3d81:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    3d84:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3d8b:	00 
    3d8c:	89 44 24 04          	mov    %eax,0x4(%esp)
    3d90:	89 34 24             	mov    %esi,(%esp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
    3d93:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3d96:	e8 97 fe ff ff       	call   3c32 <write>
    3d9b:	83 c3 01             	add    $0x1,%ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3d9e:	0f be 43 ff          	movsbl -0x1(%ebx),%eax
    3da2:	84 c0                	test   %al,%al
    3da4:	0f 84 8e 00 00 00    	je     3e38 <printf+0xe8>
    c = fmt[i] & 0xff;
    3daa:	0f b6 d0             	movzbl %al,%edx
    if(state == 0){
    3dad:	85 ff                	test   %edi,%edi
    3daf:	74 c7                	je     3d78 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    3db1:	83 ff 25             	cmp    $0x25,%edi
    3db4:	75 e5                	jne    3d9b <printf+0x4b>
      if(c == 'd'){
    3db6:	83 fa 64             	cmp    $0x64,%edx
    3db9:	0f 84 31 01 00 00    	je     3ef0 <printf+0x1a0>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    3dbf:	25 f7 00 00 00       	and    $0xf7,%eax
    3dc4:	83 f8 70             	cmp    $0x70,%eax
    3dc7:	0f 84 83 00 00 00    	je     3e50 <printf+0x100>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    3dcd:	83 fa 73             	cmp    $0x73,%edx
    3dd0:	0f 84 a2 00 00 00    	je     3e78 <printf+0x128>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    3dd6:	83 fa 63             	cmp    $0x63,%edx
    3dd9:	0f 84 35 01 00 00    	je     3f14 <printf+0x1c4>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    3ddf:	83 fa 25             	cmp    $0x25,%edx
    3de2:	0f 84 e0 00 00 00    	je     3ec8 <printf+0x178>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3de8:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    3deb:	83 c3 01             	add    $0x1,%ebx
    3dee:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3df5:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    3df6:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3df8:	89 44 24 04          	mov    %eax,0x4(%esp)
    3dfc:	89 34 24             	mov    %esi,(%esp)
    3dff:	89 55 d0             	mov    %edx,-0x30(%ebp)
    3e02:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
    3e06:	e8 27 fe ff ff       	call   3c32 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    3e0b:	8b 55 d0             	mov    -0x30(%ebp),%edx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3e0e:	8d 45 e7             	lea    -0x19(%ebp),%eax
    3e11:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3e18:	00 
    3e19:	89 44 24 04          	mov    %eax,0x4(%esp)
    3e1d:	89 34 24             	mov    %esi,(%esp)
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    3e20:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3e23:	e8 0a fe ff ff       	call   3c32 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3e28:	0f be 43 ff          	movsbl -0x1(%ebx),%eax
    3e2c:	84 c0                	test   %al,%al
    3e2e:	0f 85 76 ff ff ff    	jne    3daa <printf+0x5a>
    3e34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    3e38:	83 c4 3c             	add    $0x3c,%esp
    3e3b:	5b                   	pop    %ebx
    3e3c:	5e                   	pop    %esi
    3e3d:	5f                   	pop    %edi
    3e3e:	5d                   	pop    %ebp
    3e3f:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    3e40:	bf 25 00 00 00       	mov    $0x25,%edi
    3e45:	e9 51 ff ff ff       	jmp    3d9b <printf+0x4b>
    3e4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    3e50:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    3e53:	b9 10 00 00 00       	mov    $0x10,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    3e58:	31 ff                	xor    %edi,%edi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    3e5a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3e61:	8b 10                	mov    (%eax),%edx
    3e63:	89 f0                	mov    %esi,%eax
    3e65:	e8 56 fe ff ff       	call   3cc0 <printint>
        ap++;
    3e6a:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    3e6e:	e9 28 ff ff ff       	jmp    3d9b <printf+0x4b>
    3e73:	90                   	nop
    3e74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
    3e78:	8b 55 d4             	mov    -0x2c(%ebp),%edx
        ap++;
        if(s == 0)
          s = "(null)";
    3e7b:	b8 24 58 00 00       	mov    $0x5824,%eax
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
    3e80:	8b 3a                	mov    (%edx),%edi
        ap++;
    3e82:	83 c2 04             	add    $0x4,%edx
    3e85:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        if(s == 0)
          s = "(null)";
    3e88:	85 ff                	test   %edi,%edi
    3e8a:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
    3e8d:	0f b6 07             	movzbl (%edi),%eax
    3e90:	84 c0                	test   %al,%al
    3e92:	74 28                	je     3ebc <printf+0x16c>
    3e94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3e98:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3e9b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
    3e9e:	83 c7 01             	add    $0x1,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3ea1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3ea8:	00 
    3ea9:	89 44 24 04          	mov    %eax,0x4(%esp)
    3ead:	89 34 24             	mov    %esi,(%esp)
    3eb0:	e8 7d fd ff ff       	call   3c32 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    3eb5:	0f b6 07             	movzbl (%edi),%eax
    3eb8:	84 c0                	test   %al,%al
    3eba:	75 dc                	jne    3e98 <printf+0x148>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    3ebc:	31 ff                	xor    %edi,%edi
    3ebe:	e9 d8 fe ff ff       	jmp    3d9b <printf+0x4b>
    3ec3:	90                   	nop
    3ec4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3ec8:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    3ecb:	31 ff                	xor    %edi,%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3ecd:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3ed4:	00 
    3ed5:	89 44 24 04          	mov    %eax,0x4(%esp)
    3ed9:	89 34 24             	mov    %esi,(%esp)
    3edc:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
    3ee0:	e8 4d fd ff ff       	call   3c32 <write>
    3ee5:	e9 b1 fe ff ff       	jmp    3d9b <printf+0x4b>
    3eea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    3ef0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    3ef3:	b9 0a 00 00 00       	mov    $0xa,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    3ef8:	66 31 ff             	xor    %di,%di
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    3efb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3f02:	8b 10                	mov    (%eax),%edx
    3f04:	89 f0                	mov    %esi,%eax
    3f06:	e8 b5 fd ff ff       	call   3cc0 <printint>
        ap++;
    3f0b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    3f0f:	e9 87 fe ff ff       	jmp    3d9b <printf+0x4b>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
    3f14:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    3f17:	31 ff                	xor    %edi,%edi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
    3f19:	8b 02                	mov    (%edx),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3f1b:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3f22:	00 
    3f23:	89 34 24             	mov    %esi,(%esp)
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
    3f26:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3f29:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    3f2c:	89 44 24 04          	mov    %eax,0x4(%esp)
    3f30:	e8 fd fc ff ff       	call   3c32 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
    3f35:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    3f39:	e9 5d fe ff ff       	jmp    3d9b <printf+0x4b>
    3f3e:	66 90                	xchg   %ax,%ax

00003f40 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3f40:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3f41:	a1 a0 61 00 00       	mov    0x61a0,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
    3f46:	89 e5                	mov    %esp,%ebp
    3f48:	57                   	push   %edi
    3f49:	56                   	push   %esi
    3f4a:	53                   	push   %ebx
    3f4b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3f4e:	8b 08                	mov    (%eax),%ecx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
    3f50:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3f53:	39 d0                	cmp    %edx,%eax
    3f55:	72 11                	jb     3f68 <free+0x28>
    3f57:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3f58:	39 c8                	cmp    %ecx,%eax
    3f5a:	72 04                	jb     3f60 <free+0x20>
    3f5c:	39 ca                	cmp    %ecx,%edx
    3f5e:	72 10                	jb     3f70 <free+0x30>
    3f60:	89 c8                	mov    %ecx,%eax
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3f62:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3f64:	8b 08                	mov    (%eax),%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3f66:	73 f0                	jae    3f58 <free+0x18>
    3f68:	39 ca                	cmp    %ecx,%edx
    3f6a:	72 04                	jb     3f70 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3f6c:	39 c8                	cmp    %ecx,%eax
    3f6e:	72 f0                	jb     3f60 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
    3f70:	8b 73 fc             	mov    -0x4(%ebx),%esi
    3f73:	8d 3c f2             	lea    (%edx,%esi,8),%edi
    3f76:	39 cf                	cmp    %ecx,%edi
    3f78:	74 1e                	je     3f98 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    3f7a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
    3f7d:	8b 48 04             	mov    0x4(%eax),%ecx
    3f80:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
    3f83:	39 f2                	cmp    %esi,%edx
    3f85:	74 28                	je     3faf <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    3f87:	89 10                	mov    %edx,(%eax)
  freep = p;
    3f89:	a3 a0 61 00 00       	mov    %eax,0x61a0
}
    3f8e:	5b                   	pop    %ebx
    3f8f:	5e                   	pop    %esi
    3f90:	5f                   	pop    %edi
    3f91:	5d                   	pop    %ebp
    3f92:	c3                   	ret    
    3f93:	90                   	nop
    3f94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    3f98:	03 71 04             	add    0x4(%ecx),%esi
    3f9b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    3f9e:	8b 08                	mov    (%eax),%ecx
    3fa0:	8b 09                	mov    (%ecx),%ecx
    3fa2:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    3fa5:	8b 48 04             	mov    0x4(%eax),%ecx
    3fa8:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
    3fab:	39 f2                	cmp    %esi,%edx
    3fad:	75 d8                	jne    3f87 <free+0x47>
    p->s.size += bp->s.size;
    3faf:	03 4b fc             	add    -0x4(%ebx),%ecx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
    3fb2:	a3 a0 61 00 00       	mov    %eax,0x61a0
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    3fb7:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    3fba:	8b 53 f8             	mov    -0x8(%ebx),%edx
    3fbd:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
    3fbf:	5b                   	pop    %ebx
    3fc0:	5e                   	pop    %esi
    3fc1:	5f                   	pop    %edi
    3fc2:	5d                   	pop    %ebp
    3fc3:	c3                   	ret    
    3fc4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    3fca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00003fd0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3fd0:	55                   	push   %ebp
    3fd1:	89 e5                	mov    %esp,%ebp
    3fd3:	57                   	push   %edi
    3fd4:	56                   	push   %esi
    3fd5:	53                   	push   %ebx
    3fd6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3fd9:	8b 55 08             	mov    0x8(%ebp),%edx
  if((prevp = freep) == 0){
    3fdc:	8b 0d a0 61 00 00    	mov    0x61a0,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3fe2:	83 c2 07             	add    $0x7,%edx
    3fe5:	c1 ea 03             	shr    $0x3,%edx
  if((prevp = freep) == 0){
    3fe8:	85 c9                	test   %ecx,%ecx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3fea:	8d 5a 01             	lea    0x1(%edx),%ebx
  if((prevp = freep) == 0){
    3fed:	0f 84 93 00 00 00    	je     4086 <malloc+0xb6>
    3ff3:	8b 01                	mov    (%ecx),%eax
    3ff5:	8b 78 04             	mov    0x4(%eax),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    3ff8:	39 fb                	cmp    %edi,%ebx
    3ffa:	76 64                	jbe    4060 <malloc+0x90>
    3ffc:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    4003:	eb 0c                	jmp    4011 <malloc+0x41>
    4005:	8d 76 00             	lea    0x0(%esi),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4008:	8b 01                	mov    (%ecx),%eax
    if(p->s.size >= nunits){
    400a:	8b 78 04             	mov    0x4(%eax),%edi
    400d:	39 fb                	cmp    %edi,%ebx
    400f:	76 4f                	jbe    4060 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    4011:	3b 05 a0 61 00 00    	cmp    0x61a0,%eax
    4017:	89 c1                	mov    %eax,%ecx
    4019:	75 ed                	jne    4008 <malloc+0x38>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    401b:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
    4021:	b8 00 80 00 00       	mov    $0x8000,%eax
    4026:	0f 43 c6             	cmovae %esi,%eax
    4029:	bf 00 10 00 00       	mov    $0x1000,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    402e:	89 04 24             	mov    %eax,(%esp)
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    4031:	0f 43 fb             	cmovae %ebx,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    4034:	e8 61 fc ff ff       	call   3c9a <sbrk>
  if(p == (char*)-1)
    4039:	83 f8 ff             	cmp    $0xffffffff,%eax
    403c:	74 18                	je     4056 <malloc+0x86>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    403e:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
    4041:	83 c0 08             	add    $0x8,%eax
    4044:	89 04 24             	mov    %eax,(%esp)
    4047:	e8 f4 fe ff ff       	call   3f40 <free>
  return freep;
    404c:	8b 0d a0 61 00 00    	mov    0x61a0,%ecx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    4052:	85 c9                	test   %ecx,%ecx
    4054:	75 b2                	jne    4008 <malloc+0x38>
        return 0;
    4056:	31 c0                	xor    %eax,%eax
    4058:	eb 1e                	jmp    4078 <malloc+0xa8>
    405a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
    4060:	39 fb                	cmp    %edi,%ebx
    4062:	74 1c                	je     4080 <malloc+0xb0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    4064:	29 df                	sub    %ebx,%edi
    4066:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
    4069:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
    406c:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
    406f:	89 0d a0 61 00 00    	mov    %ecx,0x61a0
      return (void*)(p + 1);
    4075:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    4078:	83 c4 1c             	add    $0x1c,%esp
    407b:	5b                   	pop    %ebx
    407c:	5e                   	pop    %esi
    407d:	5f                   	pop    %edi
    407e:	5d                   	pop    %ebp
    407f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    4080:	8b 10                	mov    (%eax),%edx
    4082:	89 11                	mov    %edx,(%ecx)
    4084:	eb e9                	jmp    406f <malloc+0x9f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    4086:	c7 05 a0 61 00 00 a4 	movl   $0x61a4,0x61a0
    408d:	61 00 00 
    base.s.size = 0;
    4090:	b8 a4 61 00 00       	mov    $0x61a4,%eax
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    4095:	c7 05 a4 61 00 00 a4 	movl   $0x61a4,0x61a4
    409c:	61 00 00 
    base.s.size = 0;
    409f:	c7 05 a8 61 00 00 00 	movl   $0x0,0x61a8
    40a6:	00 00 00 
    40a9:	e9 4e ff ff ff       	jmp    3ffc <malloc+0x2c>
