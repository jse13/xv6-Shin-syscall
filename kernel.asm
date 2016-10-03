
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4 0f                	in     $0xf,%al

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc b0 b5 10 80       	mov    $0x8010b5b0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 50 2e 10 80       	mov    $0x80102e50,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
80100046:	c7 44 24 04 e0 6d 10 	movl   $0x80106de0,0x4(%esp)
8010004d:	80 
8010004e:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100055:	e8 96 40 00 00       	call   801040f0 <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
8010005a:	b9 c4 f4 10 80       	mov    $0x8010f4c4,%ecx
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010005f:	b8 f4 b5 10 80       	mov    $0x8010b5f4,%eax

  initlock(&bcache.lock, "bcache");

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
80100064:	c7 05 d0 f4 10 80 c4 	movl   $0x8010f4c4,0x8010f4d0
8010006b:	f4 10 80 
  bcache.head.next = &bcache.head;
8010006e:	c7 05 d4 f4 10 80 c4 	movl   $0x8010f4c4,0x8010f4d4
80100075:	f4 10 80 
80100078:	eb 08                	jmp    80100082 <binit+0x42>
8010007a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100080:	89 d0                	mov    %edx,%eax
    b->next = bcache.head.next;
80100082:	89 48 10             	mov    %ecx,0x10(%eax)
80100085:	89 c1                	mov    %eax,%ecx
    b->prev = &bcache.head;
80100087:	c7 40 0c c4 f4 10 80 	movl   $0x8010f4c4,0xc(%eax)
    b->dev = -1;
8010008e:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    bcache.head.next->prev = b;
80100095:	8b 15 d4 f4 10 80    	mov    0x8010f4d4,%edx
8010009b:	89 42 0c             	mov    %eax,0xc(%edx)

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010009e:	8d 90 18 02 00 00    	lea    0x218(%eax),%edx
801000a4:	81 fa c4 f4 10 80    	cmp    $0x8010f4c4,%edx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    b->dev = -1;
    bcache.head.next->prev = b;
    bcache.head.next = b;
801000aa:	a3 d4 f4 10 80       	mov    %eax,0x8010f4d4

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000af:	75 cf                	jne    80100080 <binit+0x40>
    b->prev = &bcache.head;
    b->dev = -1;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
801000b1:	c9                   	leave  
801000b2:	c3                   	ret    
801000b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801000b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000c0 <bread>:
}

// Return a B_BUSY buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000c0:	55                   	push   %ebp
801000c1:	89 e5                	mov    %esp,%ebp
801000c3:	57                   	push   %edi
801000c4:	56                   	push   %esi
801000c5:	53                   	push   %ebx
801000c6:	83 ec 1c             	sub    $0x1c,%esp
801000c9:	8b 75 08             	mov    0x8(%ebp),%esi
static struct buf*
bget(uint dev, uint blockno)
{
  struct buf *b;

  acquire(&bcache.lock);
801000cc:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
}

// Return a B_BUSY buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d3:	8b 7d 0c             	mov    0xc(%ebp),%edi
static struct buf*
bget(uint dev, uint blockno)
{
  struct buf *b;

  acquire(&bcache.lock);
801000d6:	e8 95 40 00 00       	call   80104170 <acquire>

 loop:
  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000db:	8b 1d d4 f4 10 80    	mov    0x8010f4d4,%ebx
801000e1:	81 fb c4 f4 10 80    	cmp    $0x8010f4c4,%ebx
801000e7:	75 12                	jne    801000fb <bread+0x3b>
801000e9:	eb 35                	jmp    80100120 <bread+0x60>
801000eb:	90                   	nop
801000ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801000f0:	8b 5b 10             	mov    0x10(%ebx),%ebx
801000f3:	81 fb c4 f4 10 80    	cmp    $0x8010f4c4,%ebx
801000f9:	74 25                	je     80100120 <bread+0x60>
    if(b->dev == dev && b->blockno == blockno){
801000fb:	3b 73 04             	cmp    0x4(%ebx),%esi
801000fe:	75 f0                	jne    801000f0 <bread+0x30>
80100100:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100103:	75 eb                	jne    801000f0 <bread+0x30>
      if(!(b->flags & B_BUSY)){
80100105:	8b 03                	mov    (%ebx),%eax
80100107:	a8 01                	test   $0x1,%al
80100109:	74 64                	je     8010016f <bread+0xaf>
        b->flags |= B_BUSY;
        release(&bcache.lock);
        return b;
      }
      sleep(b, &bcache.lock);
8010010b:	c7 44 24 04 c0 b5 10 	movl   $0x8010b5c0,0x4(%esp)
80100112:	80 
80100113:	89 1c 24             	mov    %ebx,(%esp)
80100116:	e8 85 3c 00 00       	call   80103da0 <sleep>
8010011b:	eb be                	jmp    801000db <bread+0x1b>
8010011d:	8d 76 00             	lea    0x0(%esi),%esi
  }

  // Not cached; recycle some non-busy and clean buffer.
  // "clean" because B_DIRTY and !B_BUSY means log.c
  // hasn't yet committed the changes to the buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d d0 f4 10 80    	mov    0x8010f4d0,%ebx
80100126:	81 fb c4 f4 10 80    	cmp    $0x8010f4c4,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x7b>
8010012e:	eb 52                	jmp    80100182 <bread+0xc2>
80100130:	8b 5b 0c             	mov    0xc(%ebx),%ebx
80100133:	81 fb c4 f4 10 80    	cmp    $0x8010f4c4,%ebx
80100139:	74 47                	je     80100182 <bread+0xc2>
    if((b->flags & B_BUSY) == 0 && (b->flags & B_DIRTY) == 0){
8010013b:	f6 03 05             	testb  $0x5,(%ebx)
8010013e:	75 f0                	jne    80100130 <bread+0x70>
      b->dev = dev;
80100140:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
80100143:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = B_BUSY;
80100146:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
      release(&bcache.lock);
8010014c:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100153:	e8 48 41 00 00       	call   801042a0 <release>
bread(uint dev, uint blockno)
{
  struct buf *b;

  b = bget(dev, blockno);
  if(!(b->flags & B_VALID)) {
80100158:	f6 03 02             	testb  $0x2,(%ebx)
8010015b:	75 08                	jne    80100165 <bread+0xa5>
    iderw(b);
8010015d:	89 1c 24             	mov    %ebx,(%esp)
80100160:	e8 fb 1f 00 00       	call   80102160 <iderw>
  }
  return b;
}
80100165:	83 c4 1c             	add    $0x1c,%esp
80100168:	89 d8                	mov    %ebx,%eax
8010016a:	5b                   	pop    %ebx
8010016b:	5e                   	pop    %esi
8010016c:	5f                   	pop    %edi
8010016d:	5d                   	pop    %ebp
8010016e:	c3                   	ret    
 loop:
  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    if(b->dev == dev && b->blockno == blockno){
      if(!(b->flags & B_BUSY)){
        b->flags |= B_BUSY;
8010016f:	83 c8 01             	or     $0x1,%eax
80100172:	89 03                	mov    %eax,(%ebx)
        release(&bcache.lock);
80100174:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
8010017b:	e8 20 41 00 00       	call   801042a0 <release>
80100180:	eb d6                	jmp    80100158 <bread+0x98>
      b->flags = B_BUSY;
      release(&bcache.lock);
      return b;
    }
  }
  panic("bget: no buffers");
80100182:	c7 04 24 e7 6d 10 80 	movl   $0x80106de7,(%esp)
80100189:	e8 a2 01 00 00       	call   80100330 <panic>
8010018e:	66 90                	xchg   %ax,%ax

80100190 <bwrite>:
}

// Write b's contents to disk.  Must be B_BUSY.
void
bwrite(struct buf *b)
{
80100190:	55                   	push   %ebp
80100191:	89 e5                	mov    %esp,%ebp
80100193:	83 ec 18             	sub    $0x18,%esp
80100196:	8b 45 08             	mov    0x8(%ebp),%eax
  if((b->flags & B_BUSY) == 0)
80100199:	8b 10                	mov    (%eax),%edx
8010019b:	f6 c2 01             	test   $0x1,%dl
8010019e:	74 0e                	je     801001ae <bwrite+0x1e>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001a0:	83 ca 04             	or     $0x4,%edx
801001a3:	89 10                	mov    %edx,(%eax)
  iderw(b);
801001a5:	89 45 08             	mov    %eax,0x8(%ebp)
}
801001a8:	c9                   	leave  
bwrite(struct buf *b)
{
  if((b->flags & B_BUSY) == 0)
    panic("bwrite");
  b->flags |= B_DIRTY;
  iderw(b);
801001a9:	e9 b2 1f 00 00       	jmp    80102160 <iderw>
// Write b's contents to disk.  Must be B_BUSY.
void
bwrite(struct buf *b)
{
  if((b->flags & B_BUSY) == 0)
    panic("bwrite");
801001ae:	c7 04 24 f8 6d 10 80 	movl   $0x80106df8,(%esp)
801001b5:	e8 76 01 00 00       	call   80100330 <panic>
801001ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801001c0 <brelse>:

// Release a B_BUSY buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001c0:	55                   	push   %ebp
801001c1:	89 e5                	mov    %esp,%ebp
801001c3:	53                   	push   %ebx
801001c4:	83 ec 14             	sub    $0x14,%esp
801001c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((b->flags & B_BUSY) == 0)
801001ca:	f6 03 01             	testb  $0x1,(%ebx)
801001cd:	74 57                	je     80100226 <brelse+0x66>
    panic("brelse");

  acquire(&bcache.lock);
801001cf:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
801001d6:	e8 95 3f 00 00       	call   80104170 <acquire>

  b->next->prev = b->prev;
801001db:	8b 43 10             	mov    0x10(%ebx),%eax
801001de:	8b 53 0c             	mov    0xc(%ebx),%edx
801001e1:	89 50 0c             	mov    %edx,0xc(%eax)
  b->prev->next = b->next;
801001e4:	8b 43 0c             	mov    0xc(%ebx),%eax
801001e7:	8b 53 10             	mov    0x10(%ebx),%edx
801001ea:	89 50 10             	mov    %edx,0x10(%eax)
  b->next = bcache.head.next;
801001ed:	a1 d4 f4 10 80       	mov    0x8010f4d4,%eax
  b->prev = &bcache.head;
801001f2:	c7 43 0c c4 f4 10 80 	movl   $0x8010f4c4,0xc(%ebx)

  acquire(&bcache.lock);

  b->next->prev = b->prev;
  b->prev->next = b->next;
  b->next = bcache.head.next;
801001f9:	89 43 10             	mov    %eax,0x10(%ebx)
  b->prev = &bcache.head;
  bcache.head.next->prev = b;
801001fc:	a1 d4 f4 10 80       	mov    0x8010f4d4,%eax
80100201:	89 58 0c             	mov    %ebx,0xc(%eax)
  bcache.head.next = b;
80100204:	89 1d d4 f4 10 80    	mov    %ebx,0x8010f4d4

  b->flags &= ~B_BUSY;
8010020a:	83 23 fe             	andl   $0xfffffffe,(%ebx)
  wakeup(b);
8010020d:	89 1c 24             	mov    %ebx,(%esp)
80100210:	e8 2b 3d 00 00       	call   80103f40 <wakeup>

  release(&bcache.lock);
80100215:	c7 45 08 c0 b5 10 80 	movl   $0x8010b5c0,0x8(%ebp)
}
8010021c:	83 c4 14             	add    $0x14,%esp
8010021f:	5b                   	pop    %ebx
80100220:	5d                   	pop    %ebp
  bcache.head.next = b;

  b->flags &= ~B_BUSY;
  wakeup(b);

  release(&bcache.lock);
80100221:	e9 7a 40 00 00       	jmp    801042a0 <release>
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  if((b->flags & B_BUSY) == 0)
    panic("brelse");
80100226:	c7 04 24 ff 6d 10 80 	movl   $0x80106dff,(%esp)
8010022d:	e8 fe 00 00 00       	call   80100330 <panic>
80100232:	66 90                	xchg   %ax,%ax
80100234:	66 90                	xchg   %ax,%ax
80100236:	66 90                	xchg   %ax,%ax
80100238:	66 90                	xchg   %ax,%ax
8010023a:	66 90                	xchg   %ax,%ax
8010023c:	66 90                	xchg   %ax,%ax
8010023e:	66 90                	xchg   %ax,%ax

80100240 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100240:	55                   	push   %ebp
80100241:	89 e5                	mov    %esp,%ebp
80100243:	57                   	push   %edi
80100244:	56                   	push   %esi
80100245:	53                   	push   %ebx
80100246:	83 ec 1c             	sub    $0x1c,%esp
  uint target;
  int c;

  iunlock(ip);
80100249:	8b 45 08             	mov    0x8(%ebp),%eax
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
8010024c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  uint target;
  int c;

  iunlock(ip);
8010024f:	89 04 24             	mov    %eax,(%esp)
80100252:	e8 49 15 00 00       	call   801017a0 <iunlock>
  target = n;
  acquire(&cons.lock);
  while(n > 0){
80100257:	89 de                	mov    %ebx,%esi
  uint target;
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
80100259:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100260:	e8 0b 3f 00 00       	call   80104170 <acquire>
  while(n > 0){
80100265:	85 db                	test   %ebx,%ebx
80100267:	7f 28                	jg     80100291 <consoleread+0x51>
80100269:	e9 be 00 00 00       	jmp    8010032c <consoleread+0xec>
8010026e:	66 90                	xchg   %ax,%ax
    while(input.r == input.w){
      if(proc->killed){
80100270:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100276:	8b 40 24             	mov    0x24(%eax),%eax
80100279:	85 c0                	test   %eax,%eax
8010027b:	75 7b                	jne    801002f8 <consoleread+0xb8>
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
8010027d:	c7 44 24 04 20 a5 10 	movl   $0x8010a520,0x4(%esp)
80100284:	80 
80100285:	c7 04 24 60 f7 10 80 	movl   $0x8010f760,(%esp)
8010028c:	e8 0f 3b 00 00       	call   80103da0 <sleep>

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
80100291:	8b 15 60 f7 10 80    	mov    0x8010f760,%edx
80100297:	3b 15 64 f7 10 80    	cmp    0x8010f764,%edx
8010029d:	74 d1                	je     80100270 <consoleread+0x30>
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
8010029f:	89 d0                	mov    %edx,%eax
801002a1:	83 e0 7f             	and    $0x7f,%eax
801002a4:	0f b6 88 e0 f6 10 80 	movzbl -0x7fef0920(%eax),%ecx
801002ab:	8d 7a 01             	lea    0x1(%edx),%edi
801002ae:	89 3d 60 f7 10 80    	mov    %edi,0x8010f760
801002b4:	0f be c1             	movsbl %cl,%eax
    if(c == C('D')){  // EOF
801002b7:	83 f8 04             	cmp    $0x4,%eax
801002ba:	74 62                	je     8010031e <consoleread+0xde>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
801002bc:	8b 55 0c             	mov    0xc(%ebp),%edx
    --n;
801002bf:	83 ee 01             	sub    $0x1,%esi
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
801002c2:	88 0a                	mov    %cl,(%edx)
801002c4:	83 c2 01             	add    $0x1,%edx
    --n;
    if(c == '\n')
801002c7:	83 f8 0a             	cmp    $0xa,%eax
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
801002ca:	89 55 0c             	mov    %edx,0xc(%ebp)
    --n;
    if(c == '\n')
801002cd:	74 59                	je     80100328 <consoleread+0xe8>
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
801002cf:	85 f6                	test   %esi,%esi
801002d1:	75 be                	jne    80100291 <consoleread+0x51>
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&cons.lock);
801002d3:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
801002da:	e8 c1 3f 00 00       	call   801042a0 <release>
  ilock(ip);
801002df:	8b 45 08             	mov    0x8(%ebp),%eax
801002e2:	89 04 24             	mov    %eax,(%esp)
801002e5:	e8 a6 13 00 00       	call   80101690 <ilock>

  return target - n;
}
801002ea:	83 c4 1c             	add    $0x1c,%esp
801002ed:	89 d8                	mov    %ebx,%eax
801002ef:	5b                   	pop    %ebx
801002f0:	5e                   	pop    %esi
801002f1:	5f                   	pop    %edi
801002f2:	5d                   	pop    %ebp
801002f3:	c3                   	ret    
801002f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
      if(proc->killed){
        release(&cons.lock);
801002f8:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
        ilock(ip);
        return -1;
801002ff:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
      if(proc->killed){
        release(&cons.lock);
80100304:	e8 97 3f 00 00       	call   801042a0 <release>
        ilock(ip);
80100309:	8b 55 08             	mov    0x8(%ebp),%edx
8010030c:	89 14 24             	mov    %edx,(%esp)
8010030f:	e8 7c 13 00 00       	call   80101690 <ilock>
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
80100314:	83 c4 1c             	add    $0x1c,%esp
80100317:	89 d8                	mov    %ebx,%eax
80100319:	5b                   	pop    %ebx
8010031a:	5e                   	pop    %esi
8010031b:	5f                   	pop    %edi
8010031c:	5d                   	pop    %ebp
8010031d:	c3                   	ret    
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
8010031e:	39 f3                	cmp    %esi,%ebx
80100320:	76 06                	jbe    80100328 <consoleread+0xe8>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100322:	89 15 60 f7 10 80    	mov    %edx,0x8010f760
80100328:	29 f3                	sub    %esi,%ebx
8010032a:	eb a7                	jmp    801002d3 <consoleread+0x93>
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
8010032c:	31 db                	xor    %ebx,%ebx
8010032e:	eb a3                	jmp    801002d3 <consoleread+0x93>

80100330 <panic>:
    release(&cons.lock);
}

void
panic(char *s)
{
80100330:	55                   	push   %ebp
80100331:	89 e5                	mov    %esp,%ebp
80100333:	56                   	push   %esi
80100334:	53                   	push   %ebx
80100335:	83 ec 40             	sub    $0x40,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100338:	fa                   	cli    
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
80100339:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
8010033f:	8d 5d d0             	lea    -0x30(%ebp),%ebx
{
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
80100342:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
80100349:	00 00 00 
  if(locking)
    release(&cons.lock);
}

void
panic(char *s)
8010034c:	8d 75 f8             	lea    -0x8(%ebp),%esi
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
8010034f:	0f b6 00             	movzbl (%eax),%eax
80100352:	c7 04 24 06 6e 10 80 	movl   $0x80106e06,(%esp)
80100359:	89 44 24 04          	mov    %eax,0x4(%esp)
8010035d:	e8 9e 02 00 00       	call   80100600 <cprintf>
  cprintf(s);
80100362:	8b 45 08             	mov    0x8(%ebp),%eax
80100365:	89 04 24             	mov    %eax,(%esp)
80100368:	e8 93 02 00 00       	call   80100600 <cprintf>
  cprintf("\n");
8010036d:	c7 04 24 16 73 10 80 	movl   $0x80107316,(%esp)
80100374:	e8 87 02 00 00       	call   80100600 <cprintf>
  getcallerpcs(&s, pcs);
80100379:	8d 45 08             	lea    0x8(%ebp),%eax
8010037c:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100380:	89 04 24             	mov    %eax,(%esp)
80100383:	e8 88 3d 00 00       	call   80104110 <getcallerpcs>
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
80100388:	8b 03                	mov    (%ebx),%eax
8010038a:	83 c3 04             	add    $0x4,%ebx
8010038d:	c7 04 24 22 6e 10 80 	movl   $0x80106e22,(%esp)
80100394:	89 44 24 04          	mov    %eax,0x4(%esp)
80100398:	e8 63 02 00 00       	call   80100600 <cprintf>
  cons.locking = 0;
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
8010039d:	39 f3                	cmp    %esi,%ebx
8010039f:	75 e7                	jne    80100388 <panic+0x58>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
801003a1:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
801003a8:	00 00 00 
801003ab:	eb fe                	jmp    801003ab <panic+0x7b>
801003ad:	8d 76 00             	lea    0x0(%esi),%esi

801003b0 <consputc>:
}

void
consputc(int c)
{
  if(panicked){
801003b0:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
801003b6:	85 d2                	test   %edx,%edx
801003b8:	74 06                	je     801003c0 <consputc+0x10>
801003ba:	fa                   	cli    
801003bb:	eb fe                	jmp    801003bb <consputc+0xb>
801003bd:	8d 76 00             	lea    0x0(%esi),%esi
  crt[pos] = ' ' | 0x0700;
}

void
consputc(int c)
{
801003c0:	55                   	push   %ebp
801003c1:	89 e5                	mov    %esp,%ebp
801003c3:	57                   	push   %edi
801003c4:	56                   	push   %esi
801003c5:	89 c6                	mov    %eax,%esi
801003c7:	53                   	push   %ebx
801003c8:	83 ec 1c             	sub    $0x1c,%esp
    cli();
    for(;;)
      ;
  }

  if(c == BACKSPACE){
801003cb:	3d 00 01 00 00       	cmp    $0x100,%eax
801003d0:	0f 84 af 00 00 00    	je     80100485 <consputc+0xd5>
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
801003d6:	89 04 24             	mov    %eax,(%esp)
801003d9:	e8 42 55 00 00       	call   80105920 <uartputc>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801003de:	bf d4 03 00 00       	mov    $0x3d4,%edi
801003e3:	b8 0e 00 00 00       	mov    $0xe,%eax
801003e8:	89 fa                	mov    %edi,%edx
801003ea:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801003eb:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
801003f0:	89 ca                	mov    %ecx,%edx
801003f2:	ec                   	in     (%dx),%al
{
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
801003f3:	0f b6 d8             	movzbl %al,%ebx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801003f6:	89 fa                	mov    %edi,%edx
801003f8:	c1 e3 08             	shl    $0x8,%ebx
801003fb:	b8 0f 00 00 00       	mov    $0xf,%eax
80100400:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100401:	89 ca                	mov    %ecx,%edx
80100403:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
80100404:	0f b6 c0             	movzbl %al,%eax
80100407:	09 c3                	or     %eax,%ebx

  if(c == '\n')
80100409:	83 fe 0a             	cmp    $0xa,%esi
8010040c:	0f 84 00 01 00 00    	je     80100512 <consputc+0x162>
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
80100412:	81 fe 00 01 00 00    	cmp    $0x100,%esi
80100418:	0f 84 e6 00 00 00    	je     80100504 <consputc+0x154>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
8010041e:	81 e6 ff 00 00 00    	and    $0xff,%esi
80100424:	81 ce 00 07 00 00    	or     $0x700,%esi
8010042a:	66 89 b4 1b 00 80 0b 	mov    %si,-0x7ff48000(%ebx,%ebx,1)
80100431:	80 
80100432:	83 c3 01             	add    $0x1,%ebx

  if(pos < 0 || pos > 25*80)
80100435:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
8010043b:	0f 87 b7 00 00 00    	ja     801004f8 <consputc+0x148>
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
80100441:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
80100447:	8d b4 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%esi
8010044e:	7f 5e                	jg     801004ae <consputc+0xfe>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100450:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100455:	b8 0e 00 00 00       	mov    $0xe,%eax
8010045a:	89 fa                	mov    %edi,%edx
8010045c:	ee                   	out    %al,(%dx)
8010045d:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
  }

  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
80100462:	89 d8                	mov    %ebx,%eax
80100464:	c1 f8 08             	sar    $0x8,%eax
80100467:	89 ca                	mov    %ecx,%edx
80100469:	ee                   	out    %al,(%dx)
8010046a:	b8 0f 00 00 00       	mov    $0xf,%eax
8010046f:	89 fa                	mov    %edi,%edx
80100471:	ee                   	out    %al,(%dx)
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
80100472:	0f b6 c3             	movzbl %bl,%eax
80100475:	89 ca                	mov    %ecx,%edx
80100477:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
80100478:	66 c7 06 20 07       	movw   $0x720,(%esi)
  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(c);
}
8010047d:	83 c4 1c             	add    $0x1c,%esp
80100480:	5b                   	pop    %ebx
80100481:	5e                   	pop    %esi
80100482:	5f                   	pop    %edi
80100483:	5d                   	pop    %ebp
80100484:	c3                   	ret    
    for(;;)
      ;
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100485:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010048c:	e8 8f 54 00 00       	call   80105920 <uartputc>
80100491:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100498:	e8 83 54 00 00       	call   80105920 <uartputc>
8010049d:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004a4:	e8 77 54 00 00       	call   80105920 <uartputc>
801004a9:	e9 30 ff ff ff       	jmp    801003de <consputc+0x2e>

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004ae:	c7 44 24 08 60 0e 00 	movl   $0xe60,0x8(%esp)
801004b5:	00 
    pos -= 80;
801004b6:	8d 7b b0             	lea    -0x50(%ebx),%edi

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004b9:	c7 44 24 04 a0 80 0b 	movl   $0x800b80a0,0x4(%esp)
801004c0:	80 
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801004c1:	8d b4 3f 00 80 0b 80 	lea    -0x7ff48000(%edi,%edi,1),%esi

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004c8:	c7 04 24 00 80 0b 80 	movl   $0x800b8000,(%esp)
801004cf:	e8 cc 3e 00 00       	call   801043a0 <memmove>
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801004d4:	b8 d0 07 00 00       	mov    $0x7d0,%eax
801004d9:	29 d8                	sub    %ebx,%eax
  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
    pos -= 80;
801004db:	89 fb                	mov    %edi,%ebx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801004dd:	01 c0                	add    %eax,%eax
801004df:	89 44 24 08          	mov    %eax,0x8(%esp)
801004e3:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801004ea:	00 
801004eb:	89 34 24             	mov    %esi,(%esp)
801004ee:	e8 fd 3d 00 00       	call   801042f0 <memset>
801004f3:	e9 58 ff ff ff       	jmp    80100450 <consputc+0xa0>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");
801004f8:	c7 04 24 26 6e 10 80 	movl   $0x80106e26,(%esp)
801004ff:	e8 2c fe ff ff       	call   80100330 <panic>
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
80100504:	31 c0                	xor    %eax,%eax
80100506:	85 db                	test   %ebx,%ebx
80100508:	0f 9f c0             	setg   %al
8010050b:	29 c3                	sub    %eax,%ebx
8010050d:	e9 23 ff ff ff       	jmp    80100435 <consputc+0x85>
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
80100512:	89 d8                	mov    %ebx,%eax
80100514:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100519:	f7 ea                	imul   %edx
8010051b:	c1 ea 05             	shr    $0x5,%edx
8010051e:	8d 04 92             	lea    (%edx,%edx,4),%eax
80100521:	c1 e0 04             	shl    $0x4,%eax
80100524:	8d 58 50             	lea    0x50(%eax),%ebx
80100527:	e9 09 ff ff ff       	jmp    80100435 <consputc+0x85>
8010052c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100530 <consolewrite>:
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100530:	55                   	push   %ebp
80100531:	89 e5                	mov    %esp,%ebp
80100533:	57                   	push   %edi
80100534:	56                   	push   %esi
80100535:	53                   	push   %ebx
80100536:	83 ec 1c             	sub    $0x1c,%esp
  int i;

  iunlock(ip);
80100539:	8b 45 08             	mov    0x8(%ebp),%eax
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
8010053c:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
8010053f:	89 04 24             	mov    %eax,(%esp)
80100542:	e8 59 12 00 00       	call   801017a0 <iunlock>
  acquire(&cons.lock);
80100547:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010054e:	e8 1d 3c 00 00       	call   80104170 <acquire>
80100553:	8b 7d 0c             	mov    0xc(%ebp),%edi
  for(i = 0; i < n; i++)
80100556:	85 f6                	test   %esi,%esi

  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
80100558:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
8010055b:	7e 12                	jle    8010056f <consolewrite+0x3f>
8010055d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100560:	0f b6 07             	movzbl (%edi),%eax
80100563:	83 c7 01             	add    $0x1,%edi
80100566:	e8 45 fe ff ff       	call   801003b0 <consputc>
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
8010056b:	39 df                	cmp    %ebx,%edi
8010056d:	75 f1                	jne    80100560 <consolewrite+0x30>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
8010056f:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100576:	e8 25 3d 00 00       	call   801042a0 <release>
  ilock(ip);
8010057b:	8b 45 08             	mov    0x8(%ebp),%eax
8010057e:	89 04 24             	mov    %eax,(%esp)
80100581:	e8 0a 11 00 00       	call   80101690 <ilock>

  return n;
}
80100586:	83 c4 1c             	add    $0x1c,%esp
80100589:	89 f0                	mov    %esi,%eax
8010058b:	5b                   	pop    %ebx
8010058c:	5e                   	pop    %esi
8010058d:	5f                   	pop    %edi
8010058e:	5d                   	pop    %ebp
8010058f:	c3                   	ret    

80100590 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
80100590:	55                   	push   %ebp
80100591:	89 e5                	mov    %esp,%ebp
80100593:	57                   	push   %edi
80100594:	56                   	push   %esi
80100595:	89 d6                	mov    %edx,%esi
80100597:	53                   	push   %ebx
80100598:	83 ec 1c             	sub    $0x1c,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
8010059b:	85 c9                	test   %ecx,%ecx
8010059d:	74 59                	je     801005f8 <printint+0x68>
8010059f:	85 c0                	test   %eax,%eax
801005a1:	79 55                	jns    801005f8 <printint+0x68>
    x = -xx;
801005a3:	f7 d8                	neg    %eax
801005a5:	bf 01 00 00 00       	mov    $0x1,%edi
  else
    x = xx;

  i = 0;
801005aa:	31 c9                	xor    %ecx,%ecx
801005ac:	eb 04                	jmp    801005b2 <printint+0x22>
801005ae:	66 90                	xchg   %ax,%ax
  do{
    buf[i++] = digits[x % base];
801005b0:	89 d9                	mov    %ebx,%ecx
801005b2:	31 d2                	xor    %edx,%edx
801005b4:	f7 f6                	div    %esi
801005b6:	8d 59 01             	lea    0x1(%ecx),%ebx
801005b9:	0f b6 92 51 6e 10 80 	movzbl -0x7fef91af(%edx),%edx
  }while((x /= base) != 0);
801005c0:	85 c0                	test   %eax,%eax
  else
    x = xx;

  i = 0;
  do{
    buf[i++] = digits[x % base];
801005c2:	88 54 0d d8          	mov    %dl,-0x28(%ebp,%ecx,1)
  }while((x /= base) != 0);
801005c6:	75 e8                	jne    801005b0 <printint+0x20>

  if(sign)
801005c8:	85 ff                	test   %edi,%edi
801005ca:	74 16                	je     801005e2 <printint+0x52>
    buf[i++] = '-';
801005cc:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
801005d1:	8d 59 02             	lea    0x2(%ecx),%ebx
801005d4:	eb 0c                	jmp    801005e2 <printint+0x52>
801005d6:	66 90                	xchg   %ax,%ax

  while(--i >= 0)
    consputc(buf[i]);
801005d8:	0f be 44 1d d8       	movsbl -0x28(%ebp,%ebx,1),%eax
801005dd:	e8 ce fd ff ff       	call   801003b0 <consputc>
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
801005e2:	83 eb 01             	sub    $0x1,%ebx
801005e5:	83 fb ff             	cmp    $0xffffffff,%ebx
801005e8:	75 ee                	jne    801005d8 <printint+0x48>
    consputc(buf[i]);
}
801005ea:	83 c4 1c             	add    $0x1c,%esp
801005ed:	5b                   	pop    %ebx
801005ee:	5e                   	pop    %esi
801005ef:	5f                   	pop    %edi
801005f0:	5d                   	pop    %ebp
801005f1:	c3                   	ret    
801005f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  uint x;

  if(sign && (sign = xx < 0))
    x = -xx;
  else
    x = xx;
801005f8:	31 ff                	xor    %edi,%edi
801005fa:	eb ae                	jmp    801005aa <printint+0x1a>
801005fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100600 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 2c             	sub    $0x2c,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100609:	a1 54 a5 10 80       	mov    0x8010a554,%eax
  if(locking)
8010060e:	85 c0                	test   %eax,%eax
{
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100610:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
80100613:	0f 85 27 01 00 00    	jne    80100740 <cprintf+0x140>
    acquire(&cons.lock);

  if (fmt == 0)
80100619:	8b 75 08             	mov    0x8(%ebp),%esi
8010061c:	85 f6                	test   %esi,%esi
8010061e:	0f 84 2d 01 00 00    	je     80100751 <cprintf+0x151>
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100624:	0f b6 06             	movzbl (%esi),%eax
    acquire(&cons.lock);

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
80100627:	8d 55 0c             	lea    0xc(%ebp),%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010062a:	31 db                	xor    %ebx,%ebx
    acquire(&cons.lock);

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
8010062c:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010062f:	85 c0                	test   %eax,%eax
80100631:	75 3d                	jne    80100670 <cprintf+0x70>
80100633:	e9 80 00 00 00       	jmp    801006b8 <cprintf+0xb8>
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
80100638:	83 fa 25             	cmp    $0x25,%edx
8010063b:	0f 84 b7 00 00 00    	je     801006f8 <cprintf+0xf8>
80100641:	83 fa 64             	cmp    $0x64,%edx
80100644:	0f 84 8e 00 00 00    	je     801006d8 <cprintf+0xd8>
    case '%':
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
8010064a:	b8 25 00 00 00       	mov    $0x25,%eax
8010064f:	89 55 dc             	mov    %edx,-0x24(%ebp)
80100652:	e8 59 fd ff ff       	call   801003b0 <consputc>
      consputc(c);
80100657:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010065a:	89 d0                	mov    %edx,%eax
8010065c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100660:	e8 4b fd ff ff       	call   801003b0 <consputc>

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100665:	83 c3 01             	add    $0x1,%ebx
80100668:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
8010066c:	85 c0                	test   %eax,%eax
8010066e:	74 48                	je     801006b8 <cprintf+0xb8>
    if(c != '%'){
80100670:	83 f8 25             	cmp    $0x25,%eax
80100673:	75 eb                	jne    80100660 <cprintf+0x60>
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
80100675:	83 c3 01             	add    $0x1,%ebx
80100678:	0f b6 14 1e          	movzbl (%esi,%ebx,1),%edx
    if(c == 0)
8010067c:	85 d2                	test   %edx,%edx
8010067e:	74 38                	je     801006b8 <cprintf+0xb8>
      break;
    switch(c){
80100680:	83 fa 70             	cmp    $0x70,%edx
80100683:	74 0d                	je     80100692 <cprintf+0x92>
80100685:	7e b1                	jle    80100638 <cprintf+0x38>
80100687:	83 fa 73             	cmp    $0x73,%edx
8010068a:	74 7c                	je     80100708 <cprintf+0x108>
8010068c:	83 fa 78             	cmp    $0x78,%edx
8010068f:	90                   	nop
80100690:	75 b8                	jne    8010064a <cprintf+0x4a>
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
80100692:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100695:	31 c9                	xor    %ecx,%ecx

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100697:	83 c3 01             	add    $0x1,%ebx
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
8010069a:	8b 02                	mov    (%edx),%eax
8010069c:	83 c2 04             	add    $0x4,%edx
8010069f:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801006a2:	ba 10 00 00 00       	mov    $0x10,%edx
801006a7:	e8 e4 fe ff ff       	call   80100590 <printint>

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006ac:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
801006b0:	85 c0                	test   %eax,%eax
801006b2:	75 bc                	jne    80100670 <cprintf+0x70>
801006b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      consputc(c);
      break;
    }
  }

  if(locking)
801006b8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801006bb:	85 c0                	test   %eax,%eax
801006bd:	74 0c                	je     801006cb <cprintf+0xcb>
    release(&cons.lock);
801006bf:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
801006c6:	e8 d5 3b 00 00       	call   801042a0 <release>
}
801006cb:	83 c4 2c             	add    $0x2c,%esp
801006ce:	5b                   	pop    %ebx
801006cf:	5e                   	pop    %esi
801006d0:	5f                   	pop    %edi
801006d1:	5d                   	pop    %ebp
801006d2:	c3                   	ret    
801006d3:	90                   	nop
801006d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
    case 'd':
      printint(*argp++, 10, 1);
801006d8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801006db:	b9 01 00 00 00       	mov    $0x1,%ecx
801006e0:	8b 02                	mov    (%edx),%eax
801006e2:	83 c2 04             	add    $0x4,%edx
801006e5:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801006e8:	ba 0a 00 00 00       	mov    $0xa,%edx
801006ed:	e8 9e fe ff ff       	call   80100590 <printint>
      break;
801006f2:	e9 6e ff ff ff       	jmp    80100665 <cprintf+0x65>
801006f7:	90                   	nop
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
801006f8:	b8 25 00 00 00       	mov    $0x25,%eax
801006fd:	e8 ae fc ff ff       	call   801003b0 <consputc>
      break;
80100702:	e9 5e ff ff ff       	jmp    80100665 <cprintf+0x65>
80100707:	90                   	nop
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
80100708:	8b 45 e4             	mov    -0x1c(%ebp),%eax
        s = "(null)";
8010070b:	ba 39 6e 10 80       	mov    $0x80106e39,%edx
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
80100710:	8b 38                	mov    (%eax),%edi
80100712:	83 c0 04             	add    $0x4,%eax
80100715:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        s = "(null)";
80100718:	85 ff                	test   %edi,%edi
8010071a:	0f 44 fa             	cmove  %edx,%edi
      for(; *s; s++)
8010071d:	0f be 07             	movsbl (%edi),%eax
80100720:	84 c0                	test   %al,%al
80100722:	0f 84 3d ff ff ff    	je     80100665 <cprintf+0x65>
80100728:	83 c7 01             	add    $0x1,%edi
        consputc(*s);
8010072b:	e8 80 fc ff ff       	call   801003b0 <consputc>
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
80100730:	0f be 07             	movsbl (%edi),%eax
80100733:	84 c0                	test   %al,%al
80100735:	75 f1                	jne    80100728 <cprintf+0x128>
80100737:	e9 29 ff ff ff       	jmp    80100665 <cprintf+0x65>
8010073c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);
80100740:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100747:	e8 24 3a 00 00       	call   80104170 <acquire>
8010074c:	e9 c8 fe ff ff       	jmp    80100619 <cprintf+0x19>

  if (fmt == 0)
    panic("null fmt");
80100751:	c7 04 24 40 6e 10 80 	movl   $0x80106e40,(%esp)
80100758:	e8 d3 fb ff ff       	call   80100330 <panic>
8010075d:	8d 76 00             	lea    0x0(%esi),%esi

80100760 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
80100760:	55                   	push   %ebp
80100761:	89 e5                	mov    %esp,%ebp
80100763:	57                   	push   %edi
80100764:	56                   	push   %esi
  int c, doprocdump = 0;
80100765:	31 f6                	xor    %esi,%esi

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
80100767:	53                   	push   %ebx
80100768:	83 ec 1c             	sub    $0x1c,%esp
8010076b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int c, doprocdump = 0;

  acquire(&cons.lock);
8010076e:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100775:	e8 f6 39 00 00       	call   80104170 <acquire>
8010077a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  while((c = getc()) >= 0){
80100780:	ff d3                	call   *%ebx
80100782:	85 c0                	test   %eax,%eax
80100784:	89 c7                	mov    %eax,%edi
80100786:	0f 88 94 00 00 00    	js     80100820 <consoleintr+0xc0>
    switch(c){
8010078c:	83 ff 10             	cmp    $0x10,%edi
8010078f:	90                   	nop
80100790:	0f 84 e2 00 00 00    	je     80100878 <consoleintr+0x118>
80100796:	0f 8f a4 00 00 00    	jg     80100840 <consoleintr+0xe0>
8010079c:	83 ff 08             	cmp    $0x8,%edi
8010079f:	90                   	nop
801007a0:	0f 84 a8 00 00 00    	je     8010084e <consoleintr+0xee>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
801007a6:	85 ff                	test   %edi,%edi
801007a8:	74 d6                	je     80100780 <consoleintr+0x20>
801007aa:	a1 68 f7 10 80       	mov    0x8010f768,%eax
801007af:	89 c2                	mov    %eax,%edx
801007b1:	2b 15 60 f7 10 80    	sub    0x8010f760,%edx
801007b7:	83 fa 7f             	cmp    $0x7f,%edx
801007ba:	77 c4                	ja     80100780 <consoleintr+0x20>
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
801007bc:	89 c2                	mov    %eax,%edx
801007be:	83 e2 7f             	and    $0x7f,%edx
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
801007c1:	83 ff 0d             	cmp    $0xd,%edi
801007c4:	0f 84 1a 01 00 00    	je     801008e4 <consoleintr+0x184>
        input.buf[input.e++ % INPUT_BUF] = c;
801007ca:	83 c0 01             	add    $0x1,%eax
801007cd:	89 f9                	mov    %edi,%ecx
801007cf:	88 8a e0 f6 10 80    	mov    %cl,-0x7fef0920(%edx)
801007d5:	a3 68 f7 10 80       	mov    %eax,0x8010f768
        consputc(c);
801007da:	89 f8                	mov    %edi,%eax
801007dc:	e8 cf fb ff ff       	call   801003b0 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801007e1:	83 ff 04             	cmp    $0x4,%edi
801007e4:	a1 68 f7 10 80       	mov    0x8010f768,%eax
801007e9:	74 12                	je     801007fd <consoleintr+0x9d>
801007eb:	83 ff 0a             	cmp    $0xa,%edi
801007ee:	74 0d                	je     801007fd <consoleintr+0x9d>
801007f0:	8b 15 60 f7 10 80    	mov    0x8010f760,%edx
801007f6:	83 ea 80             	sub    $0xffffff80,%edx
801007f9:	39 d0                	cmp    %edx,%eax
801007fb:	75 83                	jne    80100780 <consoleintr+0x20>
          input.w = input.e;
          wakeup(&input.r);
801007fd:	c7 04 24 60 f7 10 80 	movl   $0x8010f760,(%esp)
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
        consputc(c);
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
          input.w = input.e;
80100804:	a3 64 f7 10 80       	mov    %eax,0x8010f764
          wakeup(&input.r);
80100809:	e8 32 37 00 00       	call   80103f40 <wakeup>
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
8010080e:	ff d3                	call   *%ebx
80100810:	85 c0                	test   %eax,%eax
80100812:	89 c7                	mov    %eax,%edi
80100814:	0f 89 72 ff ff ff    	jns    8010078c <consoleintr+0x2c>
8010081a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        }
      }
      break;
    }
  }
  release(&cons.lock);
80100820:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100827:	e8 74 3a 00 00       	call   801042a0 <release>
  if(doprocdump) {
8010082c:	85 f6                	test   %esi,%esi
8010082e:	0f 85 a4 00 00 00    	jne    801008d8 <consoleintr+0x178>
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100834:	83 c4 1c             	add    $0x1c,%esp
80100837:	5b                   	pop    %ebx
80100838:	5e                   	pop    %esi
80100839:	5f                   	pop    %edi
8010083a:	5d                   	pop    %ebp
8010083b:	c3                   	ret    
8010083c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
80100840:	83 ff 15             	cmp    $0x15,%edi
80100843:	74 43                	je     80100888 <consoleintr+0x128>
80100845:	83 ff 7f             	cmp    $0x7f,%edi
80100848:	0f 85 58 ff ff ff    	jne    801007a6 <consoleintr+0x46>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
8010084e:	a1 68 f7 10 80       	mov    0x8010f768,%eax
80100853:	3b 05 64 f7 10 80    	cmp    0x8010f764,%eax
80100859:	0f 84 21 ff ff ff    	je     80100780 <consoleintr+0x20>
        input.e--;
8010085f:	83 e8 01             	sub    $0x1,%eax
80100862:	a3 68 f7 10 80       	mov    %eax,0x8010f768
        consputc(BACKSPACE);
80100867:	b8 00 01 00 00       	mov    $0x100,%eax
8010086c:	e8 3f fb ff ff       	call   801003b0 <consputc>
80100871:	e9 0a ff ff ff       	jmp    80100780 <consoleintr+0x20>
80100876:	66 90                	xchg   %ax,%ax
  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
80100878:	be 01 00 00 00       	mov    $0x1,%esi
8010087d:	e9 fe fe ff ff       	jmp    80100780 <consoleintr+0x20>
80100882:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100888:	a1 68 f7 10 80       	mov    0x8010f768,%eax
8010088d:	3b 05 64 f7 10 80    	cmp    0x8010f764,%eax
80100893:	75 2b                	jne    801008c0 <consoleintr+0x160>
80100895:	e9 e6 fe ff ff       	jmp    80100780 <consoleintr+0x20>
8010089a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
801008a0:	a3 68 f7 10 80       	mov    %eax,0x8010f768
        consputc(BACKSPACE);
801008a5:	b8 00 01 00 00       	mov    $0x100,%eax
801008aa:	e8 01 fb ff ff       	call   801003b0 <consputc>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
801008af:	a1 68 f7 10 80       	mov    0x8010f768,%eax
801008b4:	3b 05 64 f7 10 80    	cmp    0x8010f764,%eax
801008ba:	0f 84 c0 fe ff ff    	je     80100780 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
801008c0:	83 e8 01             	sub    $0x1,%eax
801008c3:	89 c2                	mov    %eax,%edx
801008c5:	83 e2 7f             	and    $0x7f,%edx
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
801008c8:	80 ba e0 f6 10 80 0a 	cmpb   $0xa,-0x7fef0920(%edx)
801008cf:	75 cf                	jne    801008a0 <consoleintr+0x140>
801008d1:	e9 aa fe ff ff       	jmp    80100780 <consoleintr+0x20>
801008d6:	66 90                	xchg   %ax,%ax
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
  }
}
801008d8:	83 c4 1c             	add    $0x1c,%esp
801008db:	5b                   	pop    %ebx
801008dc:	5e                   	pop    %esi
801008dd:	5f                   	pop    %edi
801008de:	5d                   	pop    %ebp
      break;
    }
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
801008df:	e9 3c 37 00 00       	jmp    80104020 <procdump>
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
801008e4:	83 c0 01             	add    $0x1,%eax
801008e7:	c6 82 e0 f6 10 80 0a 	movb   $0xa,-0x7fef0920(%edx)
801008ee:	a3 68 f7 10 80       	mov    %eax,0x8010f768
        consputc(c);
801008f3:	b8 0a 00 00 00       	mov    $0xa,%eax
801008f8:	e8 b3 fa ff ff       	call   801003b0 <consputc>
801008fd:	a1 68 f7 10 80       	mov    0x8010f768,%eax
80100902:	e9 f6 fe ff ff       	jmp    801007fd <consoleintr+0x9d>
80100907:	89 f6                	mov    %esi,%esi
80100909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100910 <consoleinit>:
  return n;
}

void
consoleinit(void)
{
80100910:	55                   	push   %ebp
80100911:	89 e5                	mov    %esp,%ebp
80100913:	83 ec 18             	sub    $0x18,%esp
  initlock(&cons.lock, "console");
80100916:	c7 44 24 04 49 6e 10 	movl   $0x80106e49,0x4(%esp)
8010091d:	80 
8010091e:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100925:	e8 c6 37 00 00       	call   801040f0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  picenable(IRQ_KBD);
8010092a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
void
consoleinit(void)
{
  initlock(&cons.lock, "console");

  devsw[CONSOLE].write = consolewrite;
80100931:	c7 05 2c 01 11 80 30 	movl   $0x80100530,0x8011012c
80100938:	05 10 80 
  devsw[CONSOLE].read = consoleread;
8010093b:	c7 05 28 01 11 80 40 	movl   $0x80100240,0x80110128
80100942:	02 10 80 
  cons.locking = 1;
80100945:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
8010094c:	00 00 00 

  picenable(IRQ_KBD);
8010094f:	e8 9c 28 00 00       	call   801031f0 <picenable>
  ioapicenable(IRQ_KBD, 0);
80100954:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010095b:	00 
8010095c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80100963:	e8 88 19 00 00       	call   801022f0 <ioapicenable>
}
80100968:	c9                   	leave  
80100969:	c3                   	ret    
8010096a:	66 90                	xchg   %ax,%ax
8010096c:	66 90                	xchg   %ax,%ax
8010096e:	66 90                	xchg   %ax,%ax

80100970 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100970:	55                   	push   %ebp
80100971:	89 e5                	mov    %esp,%ebp
80100973:	57                   	push   %edi
80100974:	56                   	push   %esi
80100975:	53                   	push   %ebx
80100976:	81 ec 2c 01 00 00    	sub    $0x12c,%esp
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  begin_op();
8010097c:	e8 ff 21 00 00       	call   80102b80 <begin_op>
  if((ip = namei(path)) == 0){
80100981:	8b 55 08             	mov    0x8(%ebp),%edx
80100984:	89 14 24             	mov    %edx,(%esp)
80100987:	e8 a4 15 00 00       	call   80101f30 <namei>
8010098c:	85 c0                	test   %eax,%eax
8010098e:	89 c3                	mov    %eax,%ebx
80100990:	74 37                	je     801009c9 <exec+0x59>
    end_op();
    return -1;
  }
  ilock(ip);
80100992:	89 04 24             	mov    %eax,(%esp)
80100995:	e8 f6 0c 00 00       	call   80101690 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
8010099a:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
801009a0:	c7 44 24 0c 34 00 00 	movl   $0x34,0xc(%esp)
801009a7:	00 
801009a8:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
801009af:	00 
801009b0:	89 44 24 04          	mov    %eax,0x4(%esp)
801009b4:	89 1c 24             	mov    %ebx,(%esp)
801009b7:	e8 d4 0f 00 00       	call   80101990 <readi>
801009bc:	83 f8 33             	cmp    $0x33,%eax
801009bf:	77 1f                	ja     801009e0 <exec+0x70>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
801009c1:	89 1c 24             	mov    %ebx,(%esp)
801009c4:	e8 77 0f 00 00       	call   80101940 <iunlockput>
    end_op();
801009c9:	e8 22 22 00 00       	call   80102bf0 <end_op>
  }
  return -1;
801009ce:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801009d3:	81 c4 2c 01 00 00    	add    $0x12c,%esp
801009d9:	5b                   	pop    %ebx
801009da:	5e                   	pop    %esi
801009db:	5f                   	pop    %edi
801009dc:	5d                   	pop    %ebp
801009dd:	c3                   	ret    
801009de:	66 90                	xchg   %ax,%ax
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
801009e0:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
801009e7:	45 4c 46 
801009ea:	75 d5                	jne    801009c1 <exec+0x51>
    goto bad;

  if((pgdir = setupkvm()) == 0)
801009ec:	e8 ff 5c 00 00       	call   801066f0 <setupkvm>
801009f1:	85 c0                	test   %eax,%eax
801009f3:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
801009f9:	74 c6                	je     801009c1 <exec+0x51>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
801009fb:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100a02:	00 
80100a03:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100a09:	0f 84 ca 02 00 00    	je     80100cd9 <exec+0x369>
80100a0f:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
80100a16:	00 00 00 
80100a19:	31 ff                	xor    %edi,%edi
80100a1b:	eb 18                	jmp    80100a35 <exec+0xc5>
80100a1d:	8d 76 00             	lea    0x0(%esi),%esi
80100a20:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100a27:	83 c7 01             	add    $0x1,%edi
#include "defs.h"
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
80100a2a:	83 c6 20             	add    $0x20,%esi
  if((pgdir = setupkvm()) == 0)
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a2d:	39 f8                	cmp    %edi,%eax
80100a2f:	0f 8e be 00 00 00    	jle    80100af3 <exec+0x183>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100a35:	8d 8d 04 ff ff ff    	lea    -0xfc(%ebp),%ecx
80100a3b:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
80100a42:	00 
80100a43:	89 74 24 08          	mov    %esi,0x8(%esp)
80100a47:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80100a4b:	89 1c 24             	mov    %ebx,(%esp)
80100a4e:	e8 3d 0f 00 00       	call   80101990 <readi>
80100a53:	83 f8 20             	cmp    $0x20,%eax
80100a56:	0f 85 84 00 00 00    	jne    80100ae0 <exec+0x170>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100a5c:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100a63:	75 bb                	jne    80100a20 <exec+0xb0>
      continue;
    if(ph.memsz < ph.filesz)
80100a65:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100a6b:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100a71:	72 6d                	jb     80100ae0 <exec+0x170>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100a73:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100a79:	72 65                	jb     80100ae0 <exec+0x170>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100a7b:	89 44 24 08          	mov    %eax,0x8(%esp)
80100a7f:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100a85:	89 44 24 04          	mov    %eax,0x4(%esp)
80100a89:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100a8f:	89 04 24             	mov    %eax,(%esp)
80100a92:	e8 a9 5f 00 00       	call   80106a40 <allocuvm>
80100a97:	85 c0                	test   %eax,%eax
80100a99:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100a9f:	74 3f                	je     80100ae0 <exec+0x170>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100aa1:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100aa7:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100aac:	75 32                	jne    80100ae0 <exec+0x170>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100aae:	8b 95 14 ff ff ff    	mov    -0xec(%ebp),%edx
80100ab4:	89 44 24 04          	mov    %eax,0x4(%esp)
80100ab8:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100abe:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80100ac2:	89 54 24 10          	mov    %edx,0x10(%esp)
80100ac6:	8b 95 08 ff ff ff    	mov    -0xf8(%ebp),%edx
80100acc:	89 04 24             	mov    %eax,(%esp)
80100acf:	89 54 24 0c          	mov    %edx,0xc(%esp)
80100ad3:	e8 08 5e 00 00       	call   801068e0 <loaduvm>
80100ad8:	85 c0                	test   %eax,%eax
80100ada:	0f 89 40 ff ff ff    	jns    80100a20 <exec+0xb0>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100ae0:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100ae6:	89 04 24             	mov    %eax,(%esp)
80100ae9:	e8 82 60 00 00       	call   80106b70 <freevm>
80100aee:	e9 ce fe ff ff       	jmp    801009c1 <exec+0x51>
80100af3:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100af9:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
80100aff:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
80100b05:	8d be 00 20 00 00    	lea    0x2000(%esi),%edi
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100b0b:	89 1c 24             	mov    %ebx,(%esp)
80100b0e:	e8 2d 0e 00 00       	call   80101940 <iunlockput>
  end_op();
80100b13:	e8 d8 20 00 00       	call   80102bf0 <end_op>
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b18:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100b1e:	89 7c 24 08          	mov    %edi,0x8(%esp)
80100b22:	89 74 24 04          	mov    %esi,0x4(%esp)
80100b26:	89 04 24             	mov    %eax,(%esp)
80100b29:	e8 12 5f 00 00       	call   80106a40 <allocuvm>
80100b2e:	85 c0                	test   %eax,%eax
80100b30:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100b36:	75 18                	jne    80100b50 <exec+0x1e0>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100b38:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100b3e:	89 04 24             	mov    %eax,(%esp)
80100b41:	e8 2a 60 00 00       	call   80106b70 <freevm>
  if(ip){
    iunlockput(ip);
    end_op();
  }
  return -1;
80100b46:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100b4b:	e9 83 fe ff ff       	jmp    801009d3 <exec+0x63>
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100b50:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100b56:	2d 00 20 00 00       	sub    $0x2000,%eax
80100b5b:	89 44 24 04          	mov    %eax,0x4(%esp)
80100b5f:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100b65:	89 04 24             	mov    %eax,(%esp)
80100b68:	e8 83 60 00 00       	call   80106bf0 <clearpteu>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100b6d:	8b 55 0c             	mov    0xc(%ebp),%edx
80100b70:	8b 02                	mov    (%edx),%eax
80100b72:	85 c0                	test   %eax,%eax
80100b74:	0f 84 6b 01 00 00    	je     80100ce5 <exec+0x375>
#include "defs.h"
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
80100b7a:	89 d7                	mov    %edx,%edi
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100b7c:	31 f6                	xor    %esi,%esi
#include "defs.h"
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
80100b7e:	8b 9d f4 fe ff ff    	mov    -0x10c(%ebp),%ebx
80100b84:	83 c7 04             	add    $0x4,%edi
80100b87:	89 f2                	mov    %esi,%edx
80100b89:	89 fe                	mov    %edi,%esi
80100b8b:	89 d7                	mov    %edx,%edi
80100b8d:	eb 09                	jmp    80100b98 <exec+0x228>
80100b8f:	90                   	nop
80100b90:	83 c6 04             	add    $0x4,%esi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
80100b93:	83 ff 20             	cmp    $0x20,%edi
80100b96:	74 a0                	je     80100b38 <exec+0x1c8>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100b98:	89 04 24             	mov    %eax,(%esp)
80100b9b:	e8 80 39 00 00       	call   80104520 <strlen>
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100ba0:	8b 4d 0c             	mov    0xc(%ebp),%ecx

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100ba3:	f7 d0                	not    %eax
80100ba5:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100ba7:	8b 01                	mov    (%ecx),%eax

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100ba9:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100bac:	89 04 24             	mov    %eax,(%esp)
80100baf:	e8 6c 39 00 00       	call   80104520 <strlen>
80100bb4:	8b 55 0c             	mov    0xc(%ebp),%edx
80100bb7:	83 c0 01             	add    $0x1,%eax
80100bba:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100bbe:	8b 02                	mov    (%edx),%eax
80100bc0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100bc4:	89 44 24 08          	mov    %eax,0x8(%esp)
80100bc8:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100bce:	89 04 24             	mov    %eax,(%esp)
80100bd1:	e8 6a 61 00 00       	call   80106d40 <copyout>
80100bd6:	85 c0                	test   %eax,%eax
80100bd8:	0f 88 5a ff ff ff    	js     80100b38 <exec+0x1c8>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100bde:	8b 06                	mov    (%esi),%eax
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100be0:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100be6:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100bed:	83 c7 01             	add    $0x1,%edi
80100bf0:	89 75 0c             	mov    %esi,0xc(%ebp)
80100bf3:	85 c0                	test   %eax,%eax
80100bf5:	75 99                	jne    80100b90 <exec+0x220>
80100bf7:	89 fe                	mov    %edi,%esi
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100bf9:	8d 04 b5 04 00 00 00 	lea    0x4(,%esi,4),%eax
80100c00:	89 d9                	mov    %ebx,%ecx
80100c02:	29 c1                	sub    %eax,%ecx

  sp -= (3+argc+1) * 4;
80100c04:	8d 04 b5 10 00 00 00 	lea    0x10(,%esi,4),%eax
80100c0b:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100c0d:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100c11:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100c17:	89 54 24 08          	mov    %edx,0x8(%esp)
80100c1b:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100c1f:	c7 84 b5 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%esi,4)
80100c26:	00 00 00 00 
  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100c2a:	89 04 24             	mov    %eax,(%esp)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
80100c2d:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100c34:	ff ff ff 
  ustack[1] = argc;
80100c37:	89 b5 5c ff ff ff    	mov    %esi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c3d:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100c43:	e8 f8 60 00 00       	call   80106d40 <copyout>
80100c48:	85 c0                	test   %eax,%eax
80100c4a:	0f 88 e8 fe ff ff    	js     80100b38 <exec+0x1c8>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100c50:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100c53:	0f b6 11             	movzbl (%ecx),%edx
80100c56:	84 d2                	test   %dl,%dl
80100c58:	0f 84 9a 00 00 00    	je     80100cf8 <exec+0x388>
#include "defs.h"
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
80100c5e:	89 c8                	mov    %ecx,%eax
80100c60:	83 c0 01             	add    $0x1,%eax
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
    if(*s == '/')
      last = s+1;
80100c63:	80 fa 2f             	cmp    $0x2f,%dl
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100c66:	0f b6 10             	movzbl (%eax),%edx
    if(*s == '/')
      last = s+1;
80100c69:	0f 44 c8             	cmove  %eax,%ecx
80100c6c:	83 c0 01             	add    $0x1,%eax
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100c6f:	84 d2                	test   %dl,%dl
80100c71:	75 f0                	jne    80100c63 <exec+0x2f3>
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));
80100c73:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100c79:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80100c7d:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80100c84:	00 
80100c85:	83 c0 6c             	add    $0x6c,%eax
80100c88:	89 04 24             	mov    %eax,(%esp)
80100c8b:	e8 50 38 00 00       	call   801044e0 <safestrcpy>

  // Commit to the user image.
  oldpgdir = proc->pgdir;
80100c90:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  proc->pgdir = pgdir;
80100c96:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  proc->sz = sz;
80100c9c:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));

  // Commit to the user image.
  oldpgdir = proc->pgdir;
80100ca2:	8b 70 04             	mov    0x4(%eax),%esi
  proc->pgdir = pgdir;
80100ca5:	89 50 04             	mov    %edx,0x4(%eax)
  proc->sz = sz;
80100ca8:	89 08                	mov    %ecx,(%eax)
  proc->tf->eip = elf.entry;  // main
80100caa:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100cb0:	8b 8d 3c ff ff ff    	mov    -0xc4(%ebp),%ecx
80100cb6:	8b 50 18             	mov    0x18(%eax),%edx
80100cb9:	89 4a 38             	mov    %ecx,0x38(%edx)
  proc->tf->esp = sp;
80100cbc:	8b 50 18             	mov    0x18(%eax),%edx
80100cbf:	89 5a 44             	mov    %ebx,0x44(%edx)
  switchuvm(proc);
80100cc2:	89 04 24             	mov    %eax,(%esp)
80100cc5:	e8 e6 5a 00 00       	call   801067b0 <switchuvm>
  freevm(oldpgdir);
80100cca:	89 34 24             	mov    %esi,(%esp)
80100ccd:	e8 9e 5e 00 00       	call   80106b70 <freevm>
  return 0;
80100cd2:	31 c0                	xor    %eax,%eax
80100cd4:	e9 fa fc ff ff       	jmp    801009d3 <exec+0x63>
  if((pgdir = setupkvm()) == 0)
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100cd9:	bf 00 20 00 00       	mov    $0x2000,%edi
80100cde:	31 f6                	xor    %esi,%esi
80100ce0:	e9 26 fe ff ff       	jmp    80100b0b <exec+0x19b>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100ce5:	8b 9d f4 fe ff ff    	mov    -0x10c(%ebp),%ebx
80100ceb:	31 f6                	xor    %esi,%esi
80100ced:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100cf3:	e9 01 ff ff ff       	jmp    80100bf9 <exec+0x289>
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100cf8:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100cfb:	e9 73 ff ff ff       	jmp    80100c73 <exec+0x303>

80100d00 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d00:	55                   	push   %ebp
80100d01:	89 e5                	mov    %esp,%ebp
80100d03:	83 ec 18             	sub    $0x18,%esp
  initlock(&ftable.lock, "ftable");
80100d06:	c7 44 24 04 62 6e 10 	movl   $0x80106e62,0x4(%esp)
80100d0d:	80 
80100d0e:	c7 04 24 80 f7 10 80 	movl   $0x8010f780,(%esp)
80100d15:	e8 d6 33 00 00       	call   801040f0 <initlock>
}
80100d1a:	c9                   	leave  
80100d1b:	c3                   	ret    
80100d1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100d20 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d20:	55                   	push   %ebp
80100d21:	89 e5                	mov    %esp,%ebp
80100d23:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d24:	bb b4 f7 10 80       	mov    $0x8010f7b4,%ebx
}

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d29:	83 ec 14             	sub    $0x14,%esp
  struct file *f;

  acquire(&ftable.lock);
80100d2c:	c7 04 24 80 f7 10 80 	movl   $0x8010f780,(%esp)
80100d33:	e8 38 34 00 00       	call   80104170 <acquire>
80100d38:	eb 11                	jmp    80100d4b <filealloc+0x2b>
80100d3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d40:	83 c3 18             	add    $0x18,%ebx
80100d43:	81 fb 14 01 11 80    	cmp    $0x80110114,%ebx
80100d49:	74 25                	je     80100d70 <filealloc+0x50>
    if(f->ref == 0){
80100d4b:	8b 43 04             	mov    0x4(%ebx),%eax
80100d4e:	85 c0                	test   %eax,%eax
80100d50:	75 ee                	jne    80100d40 <filealloc+0x20>
      f->ref = 1;
80100d52:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100d59:	c7 04 24 80 f7 10 80 	movl   $0x8010f780,(%esp)
80100d60:	e8 3b 35 00 00       	call   801042a0 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100d65:	83 c4 14             	add    $0x14,%esp
80100d68:	89 d8                	mov    %ebx,%eax
80100d6a:	5b                   	pop    %ebx
80100d6b:	5d                   	pop    %ebp
80100d6c:	c3                   	ret    
80100d6d:	8d 76 00             	lea    0x0(%esi),%esi
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100d70:	c7 04 24 80 f7 10 80 	movl   $0x8010f780,(%esp)
  return 0;
80100d77:	31 db                	xor    %ebx,%ebx
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100d79:	e8 22 35 00 00       	call   801042a0 <release>
  return 0;
}
80100d7e:	83 c4 14             	add    $0x14,%esp
80100d81:	89 d8                	mov    %ebx,%eax
80100d83:	5b                   	pop    %ebx
80100d84:	5d                   	pop    %ebp
80100d85:	c3                   	ret    
80100d86:	8d 76 00             	lea    0x0(%esi),%esi
80100d89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100d90 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100d90:	55                   	push   %ebp
80100d91:	89 e5                	mov    %esp,%ebp
80100d93:	53                   	push   %ebx
80100d94:	83 ec 14             	sub    $0x14,%esp
80100d97:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100d9a:	c7 04 24 80 f7 10 80 	movl   $0x8010f780,(%esp)
80100da1:	e8 ca 33 00 00       	call   80104170 <acquire>
  if(f->ref < 1)
80100da6:	8b 43 04             	mov    0x4(%ebx),%eax
80100da9:	85 c0                	test   %eax,%eax
80100dab:	7e 1a                	jle    80100dc7 <filedup+0x37>
    panic("filedup");
  f->ref++;
80100dad:	83 c0 01             	add    $0x1,%eax
80100db0:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100db3:	c7 04 24 80 f7 10 80 	movl   $0x8010f780,(%esp)
80100dba:	e8 e1 34 00 00       	call   801042a0 <release>
  return f;
}
80100dbf:	83 c4 14             	add    $0x14,%esp
80100dc2:	89 d8                	mov    %ebx,%eax
80100dc4:	5b                   	pop    %ebx
80100dc5:	5d                   	pop    %ebp
80100dc6:	c3                   	ret    
struct file*
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
80100dc7:	c7 04 24 69 6e 10 80 	movl   $0x80106e69,(%esp)
80100dce:	e8 5d f5 ff ff       	call   80100330 <panic>
80100dd3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100de0 <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100de0:	55                   	push   %ebp
80100de1:	89 e5                	mov    %esp,%ebp
80100de3:	83 ec 38             	sub    $0x38,%esp
80100de6:	89 7d fc             	mov    %edi,-0x4(%ebp)
80100de9:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct file ff;

  acquire(&ftable.lock);
80100dec:	c7 04 24 80 f7 10 80 	movl   $0x8010f780,(%esp)
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100df3:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80100df6:	89 75 f8             	mov    %esi,-0x8(%ebp)
  struct file ff;

  acquire(&ftable.lock);
80100df9:	e8 72 33 00 00       	call   80104170 <acquire>
  if(f->ref < 1)
80100dfe:	8b 57 04             	mov    0x4(%edi),%edx
80100e01:	85 d2                	test   %edx,%edx
80100e03:	0f 8e a0 00 00 00    	jle    80100ea9 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80100e09:	83 ea 01             	sub    $0x1,%edx
80100e0c:	85 d2                	test   %edx,%edx
80100e0e:	89 57 04             	mov    %edx,0x4(%edi)
80100e11:	74 1d                	je     80100e30 <fileclose+0x50>
    release(&ftable.lock);
80100e13:	c7 45 08 80 f7 10 80 	movl   $0x8010f780,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e1a:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100e1d:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100e20:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100e23:	89 ec                	mov    %ebp,%esp
80100e25:	5d                   	pop    %ebp

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
80100e26:	e9 75 34 00 00       	jmp    801042a0 <release>
80100e2b:	90                   	nop
80100e2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return;
  }
  ff = *f;
80100e30:	0f b6 47 09          	movzbl 0x9(%edi),%eax
80100e34:	8b 37                	mov    (%edi),%esi
80100e36:	8b 5f 0c             	mov    0xc(%edi),%ebx
  f->ref = 0;
  f->type = FD_NONE;
80100e39:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e3f:	88 45 e7             	mov    %al,-0x19(%ebp)
80100e42:	8b 47 10             	mov    0x10(%edi),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100e45:	c7 04 24 80 f7 10 80 	movl   $0x8010f780,(%esp)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e4c:	89 45 e0             	mov    %eax,-0x20(%ebp)
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100e4f:	e8 4c 34 00 00       	call   801042a0 <release>

  if(ff.type == FD_PIPE)
80100e54:	83 fe 01             	cmp    $0x1,%esi
80100e57:	74 17                	je     80100e70 <fileclose+0x90>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100e59:	83 fe 02             	cmp    $0x2,%esi
80100e5c:	74 2a                	je     80100e88 <fileclose+0xa8>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e5e:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100e61:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100e64:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100e67:	89 ec                	mov    %ebp,%esp
80100e69:	5d                   	pop    %ebp
80100e6a:	c3                   	ret    
80100e6b:	90                   	nop
80100e6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);

  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
80100e70:	0f be 75 e7          	movsbl -0x19(%ebp),%esi
80100e74:	89 1c 24             	mov    %ebx,(%esp)
80100e77:	89 74 24 04          	mov    %esi,0x4(%esp)
80100e7b:	e8 40 25 00 00       	call   801033c0 <pipeclose>
80100e80:	eb dc                	jmp    80100e5e <fileclose+0x7e>
80100e82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  else if(ff.type == FD_INODE){
    begin_op();
80100e88:	e8 f3 1c 00 00       	call   80102b80 <begin_op>
    iput(ff.ip);
80100e8d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100e90:	89 04 24             	mov    %eax,(%esp)
80100e93:	e8 58 09 00 00       	call   801017f0 <iput>
    end_op();
  }
}
80100e98:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100e9b:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100e9e:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100ea1:	89 ec                	mov    %ebp,%esp
80100ea3:	5d                   	pop    %ebp
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
80100ea4:	e9 47 1d 00 00       	jmp    80102bf0 <end_op>
{
  struct file ff;

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
80100ea9:	c7 04 24 71 6e 10 80 	movl   $0x80106e71,(%esp)
80100eb0:	e8 7b f4 ff ff       	call   80100330 <panic>
80100eb5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100ec0 <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100ec0:	55                   	push   %ebp
80100ec1:	89 e5                	mov    %esp,%ebp
80100ec3:	53                   	push   %ebx
80100ec4:	83 ec 14             	sub    $0x14,%esp
80100ec7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100eca:	83 3b 02             	cmpl   $0x2,(%ebx)
80100ecd:	75 31                	jne    80100f00 <filestat+0x40>
    ilock(f->ip);
80100ecf:	8b 43 10             	mov    0x10(%ebx),%eax
80100ed2:	89 04 24             	mov    %eax,(%esp)
80100ed5:	e8 b6 07 00 00       	call   80101690 <ilock>
    stati(f->ip, st);
80100eda:	8b 45 0c             	mov    0xc(%ebp),%eax
80100edd:	89 44 24 04          	mov    %eax,0x4(%esp)
80100ee1:	8b 43 10             	mov    0x10(%ebx),%eax
80100ee4:	89 04 24             	mov    %eax,(%esp)
80100ee7:	e8 74 0a 00 00       	call   80101960 <stati>
    iunlock(f->ip);
80100eec:	8b 43 10             	mov    0x10(%ebx),%eax
80100eef:	89 04 24             	mov    %eax,(%esp)
80100ef2:	e8 a9 08 00 00       	call   801017a0 <iunlock>
    return 0;
  }
  return -1;
}
80100ef7:	83 c4 14             	add    $0x14,%esp
{
  if(f->type == FD_INODE){
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
80100efa:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100efc:	5b                   	pop    %ebx
80100efd:	5d                   	pop    %ebp
80100efe:	c3                   	ret    
80100eff:	90                   	nop
80100f00:	83 c4 14             	add    $0x14,%esp
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
80100f03:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100f08:	5b                   	pop    %ebx
80100f09:	5d                   	pop    %ebp
80100f0a:	c3                   	ret    
80100f0b:	90                   	nop
80100f0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f10 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100f10:	55                   	push   %ebp
80100f11:	89 e5                	mov    %esp,%ebp
80100f13:	83 ec 28             	sub    $0x28,%esp
80100f16:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80100f19:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f1c:	89 75 f8             	mov    %esi,-0x8(%ebp)
80100f1f:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f22:	89 7d fc             	mov    %edi,-0x4(%ebp)
80100f25:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100f28:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100f2c:	74 72                	je     80100fa0 <fileread+0x90>
    return -1;
  if(f->type == FD_PIPE)
80100f2e:	8b 03                	mov    (%ebx),%eax
80100f30:	83 f8 01             	cmp    $0x1,%eax
80100f33:	74 53                	je     80100f88 <fileread+0x78>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f35:	83 f8 02             	cmp    $0x2,%eax
80100f38:	75 6d                	jne    80100fa7 <fileread+0x97>
    ilock(f->ip);
80100f3a:	8b 43 10             	mov    0x10(%ebx),%eax
80100f3d:	89 04 24             	mov    %eax,(%esp)
80100f40:	e8 4b 07 00 00       	call   80101690 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f45:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80100f49:	8b 43 14             	mov    0x14(%ebx),%eax
80100f4c:	89 74 24 04          	mov    %esi,0x4(%esp)
80100f50:	89 44 24 08          	mov    %eax,0x8(%esp)
80100f54:	8b 43 10             	mov    0x10(%ebx),%eax
80100f57:	89 04 24             	mov    %eax,(%esp)
80100f5a:	e8 31 0a 00 00       	call   80101990 <readi>
80100f5f:	85 c0                	test   %eax,%eax
80100f61:	89 c6                	mov    %eax,%esi
80100f63:	7e 03                	jle    80100f68 <fileread+0x58>
      f->off += r;
80100f65:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100f68:	8b 43 10             	mov    0x10(%ebx),%eax
80100f6b:	89 04 24             	mov    %eax,(%esp)
80100f6e:	e8 2d 08 00 00       	call   801017a0 <iunlock>
    return r;
  }
  panic("fileread");
}
80100f73:	89 f0                	mov    %esi,%eax
80100f75:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100f78:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100f7b:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100f7e:	89 ec                	mov    %ebp,%esp
80100f80:	5d                   	pop    %ebp
80100f81:	c3                   	ret    
80100f82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100f88:	8b 43 0c             	mov    0xc(%ebx),%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80100f8b:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100f8e:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100f91:	8b 7d fc             	mov    -0x4(%ebp),%edi
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100f94:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80100f97:	89 ec                	mov    %ebp,%esp
80100f99:	5d                   	pop    %ebp
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100f9a:	e9 e1 25 00 00       	jmp    80103580 <piperead>
80100f9f:	90                   	nop
fileread(struct file *f, char *addr, int n)
{
  int r;

  if(f->readable == 0)
    return -1;
80100fa0:	be ff ff ff ff       	mov    $0xffffffff,%esi
80100fa5:	eb cc                	jmp    80100f73 <fileread+0x63>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
80100fa7:	c7 04 24 7b 6e 10 80 	movl   $0x80106e7b,(%esp)
80100fae:	e8 7d f3 ff ff       	call   80100330 <panic>
80100fb3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100fc0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100fc0:	55                   	push   %ebp
80100fc1:	89 e5                	mov    %esp,%ebp
80100fc3:	57                   	push   %edi
80100fc4:	56                   	push   %esi
80100fc5:	53                   	push   %ebx
80100fc6:	83 ec 2c             	sub    $0x2c,%esp
80100fc9:	8b 45 0c             	mov    0xc(%ebp),%eax
80100fcc:	8b 7d 08             	mov    0x8(%ebp),%edi
80100fcf:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100fd2:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
80100fd5:	80 7f 09 00          	cmpb   $0x0,0x9(%edi)

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100fd9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int r;

  if(f->writable == 0)
80100fdc:	0f 84 da 00 00 00    	je     801010bc <filewrite+0xfc>
    return -1;
  if(f->type == FD_PIPE)
80100fe2:	8b 07                	mov    (%edi),%eax
80100fe4:	83 f8 01             	cmp    $0x1,%eax
80100fe7:	0f 84 bd 00 00 00    	je     801010aa <filewrite+0xea>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100fed:	83 f8 02             	cmp    $0x2,%eax
80100ff0:	0f 85 db 00 00 00    	jne    801010d1 <filewrite+0x111>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80100ff6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100ff9:	31 db                	xor    %ebx,%ebx
80100ffb:	85 c0                	test   %eax,%eax
80100ffd:	7f 31                	jg     80101030 <filewrite+0x70>
80100fff:	e9 8c 00 00 00       	jmp    80101090 <filewrite+0xd0>
80101004:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
      iunlock(f->ip);
80101008:	8b 4f 10             	mov    0x10(%edi),%ecx
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
8010100b:	01 47 14             	add    %eax,0x14(%edi)
      iunlock(f->ip);
8010100e:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101011:	89 0c 24             	mov    %ecx,(%esp)
80101014:	e8 87 07 00 00       	call   801017a0 <iunlock>
      end_op();
80101019:	e8 d2 1b 00 00       	call   80102bf0 <end_op>
8010101e:	8b 45 dc             	mov    -0x24(%ebp),%eax

      if(r < 0)
        break;
      if(r != n1)
80101021:	39 f0                	cmp    %esi,%eax
80101023:	0f 85 9c 00 00 00    	jne    801010c5 <filewrite+0x105>
        panic("short filewrite");
      i += r;
80101029:	01 c3                	add    %eax,%ebx
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
8010102b:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
8010102e:	7e 60                	jle    80101090 <filewrite+0xd0>
      int n1 = n - i;
80101030:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80101033:	b8 00 1a 00 00       	mov    $0x1a00,%eax
80101038:	29 de                	sub    %ebx,%esi
8010103a:	81 fe 00 1a 00 00    	cmp    $0x1a00,%esi
80101040:	0f 4f f0             	cmovg  %eax,%esi
      if(n1 > max)
        n1 = max;

      begin_op();
80101043:	e8 38 1b 00 00       	call   80102b80 <begin_op>
      ilock(f->ip);
80101048:	8b 47 10             	mov    0x10(%edi),%eax
8010104b:	89 04 24             	mov    %eax,(%esp)
8010104e:	e8 3d 06 00 00       	call   80101690 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101053:	89 74 24 0c          	mov    %esi,0xc(%esp)
80101057:	8b 47 14             	mov    0x14(%edi),%eax
8010105a:	89 44 24 08          	mov    %eax,0x8(%esp)
8010105e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101061:	01 d8                	add    %ebx,%eax
80101063:	89 44 24 04          	mov    %eax,0x4(%esp)
80101067:	8b 47 10             	mov    0x10(%edi),%eax
8010106a:	89 04 24             	mov    %eax,(%esp)
8010106d:	e8 1e 0a 00 00       	call   80101a90 <writei>
80101072:	85 c0                	test   %eax,%eax
80101074:	7f 92                	jg     80101008 <filewrite+0x48>
        f->off += r;
      iunlock(f->ip);
80101076:	8b 4f 10             	mov    0x10(%edi),%ecx
80101079:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010107c:	89 0c 24             	mov    %ecx,(%esp)
8010107f:	e8 1c 07 00 00       	call   801017a0 <iunlock>
      end_op();
80101084:	e8 67 1b 00 00       	call   80102bf0 <end_op>

      if(r < 0)
80101089:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010108c:	85 c0                	test   %eax,%eax
8010108e:	74 91                	je     80101021 <filewrite+0x61>
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
80101090:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
80101093:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101098:	0f 44 45 e4          	cmove  -0x1c(%ebp),%eax
8010109c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  }
  panic("filewrite");
}
8010109f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801010a2:	83 c4 2c             	add    $0x2c,%esp
801010a5:	5b                   	pop    %ebx
801010a6:	5e                   	pop    %esi
801010a7:	5f                   	pop    %edi
801010a8:	5d                   	pop    %ebp
801010a9:	c3                   	ret    
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
801010aa:	8b 47 0c             	mov    0xc(%edi),%eax
801010ad:	89 45 08             	mov    %eax,0x8(%ebp)
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010b0:	83 c4 2c             	add    $0x2c,%esp
801010b3:	5b                   	pop    %ebx
801010b4:	5e                   	pop    %esi
801010b5:	5f                   	pop    %edi
801010b6:	5d                   	pop    %ebp
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
801010b7:	e9 a4 23 00 00       	jmp    80103460 <pipewrite>
filewrite(struct file *f, char *addr, int n)
{
  int r;

  if(f->writable == 0)
    return -1;
801010bc:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
801010c3:	eb da                	jmp    8010109f <filewrite+0xdf>
      end_op();

      if(r < 0)
        break;
      if(r != n1)
        panic("short filewrite");
801010c5:	c7 04 24 84 6e 10 80 	movl   $0x80106e84,(%esp)
801010cc:	e8 5f f2 ff ff       	call   80100330 <panic>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
801010d1:	c7 04 24 8a 6e 10 80 	movl   $0x80106e8a,(%esp)
801010d8:	e8 53 f2 ff ff       	call   80100330 <panic>
801010dd:	66 90                	xchg   %ax,%ax
801010df:	90                   	nop

801010e0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801010e0:	55                   	push   %ebp
801010e1:	89 e5                	mov    %esp,%ebp
801010e3:	57                   	push   %edi
801010e4:	89 c7                	mov    %eax,%edi
801010e6:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
801010e7:	31 f6                	xor    %esi,%esi
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801010e9:	53                   	push   %ebx
801010ea:	89 d3                	mov    %edx,%ebx
801010ec:	83 ec 2c             	sub    $0x2c,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
801010ef:	c7 04 24 a0 01 11 80 	movl   $0x801101a0,(%esp)
801010f6:	e8 75 30 00 00       	call   80104170 <acquire>

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801010fb:	b8 d4 01 11 80       	mov    $0x801101d4,%eax
80101100:	eb 14                	jmp    80101116 <iget+0x36>
80101102:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101108:	85 f6                	test   %esi,%esi
8010110a:	74 3c                	je     80101148 <iget+0x68>

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010110c:	83 c0 50             	add    $0x50,%eax
8010110f:	3d 74 11 11 80       	cmp    $0x80111174,%eax
80101114:	74 42                	je     80101158 <iget+0x78>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101116:	8b 48 08             	mov    0x8(%eax),%ecx
80101119:	85 c9                	test   %ecx,%ecx
8010111b:	7e eb                	jle    80101108 <iget+0x28>
8010111d:	39 38                	cmp    %edi,(%eax)
8010111f:	75 e7                	jne    80101108 <iget+0x28>
80101121:	39 58 04             	cmp    %ebx,0x4(%eax)
80101124:	75 e2                	jne    80101108 <iget+0x28>
      ip->ref++;
80101126:	83 c1 01             	add    $0x1,%ecx
80101129:	89 48 08             	mov    %ecx,0x8(%eax)
      release(&icache.lock);
8010112c:	c7 04 24 a0 01 11 80 	movl   $0x801101a0,(%esp)
80101133:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101136:	e8 65 31 00 00       	call   801042a0 <release>
      return ip;
8010113b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);

  return ip;
}
8010113e:	83 c4 2c             	add    $0x2c,%esp
80101141:	5b                   	pop    %ebx
80101142:	5e                   	pop    %esi
80101143:	5f                   	pop    %edi
80101144:	5d                   	pop    %ebp
80101145:	c3                   	ret    
80101146:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101148:	85 c9                	test   %ecx,%ecx
8010114a:	0f 44 f0             	cmove  %eax,%esi

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010114d:	83 c0 50             	add    $0x50,%eax
80101150:	3d 74 11 11 80       	cmp    $0x80111174,%eax
80101155:	75 bf                	jne    80101116 <iget+0x36>
80101157:	90                   	nop
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101158:	85 f6                	test   %esi,%esi
8010115a:	74 29                	je     80101185 <iget+0xa5>
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
8010115c:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
8010115e:	89 5e 04             	mov    %ebx,0x4(%esi)
  ip->ref = 1;
80101161:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->flags = 0;
80101168:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
  release(&icache.lock);
8010116f:	c7 04 24 a0 01 11 80 	movl   $0x801101a0,(%esp)
80101176:	e8 25 31 00 00       	call   801042a0 <release>

  return ip;
}
8010117b:	83 c4 2c             	add    $0x2c,%esp
  ip->inum = inum;
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);

  return ip;
8010117e:	89 f0                	mov    %esi,%eax
}
80101180:	5b                   	pop    %ebx
80101181:	5e                   	pop    %esi
80101182:	5f                   	pop    %edi
80101183:	5d                   	pop    %ebp
80101184:	c3                   	ret    
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");
80101185:	c7 04 24 94 6e 10 80 	movl   $0x80106e94,(%esp)
8010118c:	e8 9f f1 ff ff       	call   80100330 <panic>
80101191:	eb 0d                	jmp    801011a0 <balloc>
80101193:	90                   	nop
80101194:	90                   	nop
80101195:	90                   	nop
80101196:	90                   	nop
80101197:	90                   	nop
80101198:	90                   	nop
80101199:	90                   	nop
8010119a:	90                   	nop
8010119b:	90                   	nop
8010119c:	90                   	nop
8010119d:	90                   	nop
8010119e:	90                   	nop
8010119f:	90                   	nop

801011a0 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801011a0:	55                   	push   %ebp
801011a1:	89 e5                	mov    %esp,%ebp
801011a3:	57                   	push   %edi
801011a4:	56                   	push   %esi
801011a5:	53                   	push   %ebx
801011a6:	83 ec 2c             	sub    $0x2c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801011a9:	8b 0d 80 01 11 80    	mov    0x80110180,%ecx
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801011af:	89 45 d8             	mov    %eax,-0x28(%ebp)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801011b2:	85 c9                	test   %ecx,%ecx
801011b4:	0f 84 9b 00 00 00    	je     80101255 <balloc+0xb5>
801011ba:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
801011c1:	8b 55 dc             	mov    -0x24(%ebp),%edx
801011c4:	8b 45 dc             	mov    -0x24(%ebp),%eax
801011c7:	05 ff 0f 00 00       	add    $0xfff,%eax
801011cc:	85 d2                	test   %edx,%edx
801011ce:	0f 49 45 dc          	cmovns -0x24(%ebp),%eax
801011d2:	c1 f8 0c             	sar    $0xc,%eax
801011d5:	03 05 98 01 11 80    	add    0x80110198,%eax
801011db:	89 44 24 04          	mov    %eax,0x4(%esp)
801011df:	8b 45 d8             	mov    -0x28(%ebp),%eax
801011e2:	89 04 24             	mov    %eax,(%esp)
801011e5:	e8 d6 ee ff ff       	call   801000c0 <bread>
801011ea:	8b 15 80 01 11 80    	mov    0x80110180,%edx
801011f0:	8b 75 dc             	mov    -0x24(%ebp),%esi
801011f3:	89 55 e0             	mov    %edx,-0x20(%ebp)
801011f6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011f9:	31 c0                	xor    %eax,%eax
801011fb:	eb 32                	jmp    8010122f <balloc+0x8f>
801011fd:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101200:	89 c1                	mov    %eax,%ecx
80101202:	bf 01 00 00 00       	mov    $0x1,%edi
80101207:	83 e1 07             	and    $0x7,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010120a:	89 c2                	mov    %eax,%edx

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
8010120c:	d3 e7                	shl    %cl,%edi
8010120e:	89 f9                	mov    %edi,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101210:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101213:	c1 fa 03             	sar    $0x3,%edx
80101216:	0f b6 5c 17 18       	movzbl 0x18(%edi,%edx,1),%ebx
8010121b:	0f b6 fb             	movzbl %bl,%edi
8010121e:	85 cf                	test   %ecx,%edi
80101220:	74 46                	je     80101268 <balloc+0xc8>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101222:	83 c0 01             	add    $0x1,%eax
80101225:	83 c6 01             	add    $0x1,%esi
80101228:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010122d:	74 05                	je     80101234 <balloc+0x94>
8010122f:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80101232:	72 cc                	jb     80101200 <balloc+0x60>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101234:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101237:	89 04 24             	mov    %eax,(%esp)
8010123a:	e8 81 ef ff ff       	call   801001c0 <brelse>
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
8010123f:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101246:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101249:	3b 15 80 01 11 80    	cmp    0x80110180,%edx
8010124f:	0f 82 6c ff ff ff    	jb     801011c1 <balloc+0x21>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
80101255:	c7 04 24 a4 6e 10 80 	movl   $0x80106ea4,(%esp)
8010125c:	e8 cf f0 ff ff       	call   80100330 <panic>
80101261:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
80101268:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010126b:	09 d9                	or     %ebx,%ecx
8010126d:	88 4c 10 18          	mov    %cl,0x18(%eax,%edx,1)
        log_write(bp);
80101271:	89 04 24             	mov    %eax,(%esp)
80101274:	e8 a7 1a 00 00       	call   80102d20 <log_write>
        brelse(bp);
80101279:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010127c:	89 04 24             	mov    %eax,(%esp)
8010127f:	e8 3c ef ff ff       	call   801001c0 <brelse>
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
80101284:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101287:	89 74 24 04          	mov    %esi,0x4(%esp)
8010128b:	89 04 24             	mov    %eax,(%esp)
8010128e:	e8 2d ee ff ff       	call   801000c0 <bread>
  memset(bp->data, 0, BSIZE);
80101293:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
8010129a:	00 
8010129b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801012a2:	00 
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
801012a3:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801012a5:	8d 40 18             	lea    0x18(%eax),%eax
801012a8:	89 04 24             	mov    %eax,(%esp)
801012ab:	e8 40 30 00 00       	call   801042f0 <memset>
  log_write(bp);
801012b0:	89 1c 24             	mov    %ebx,(%esp)
801012b3:	e8 68 1a 00 00       	call   80102d20 <log_write>
  brelse(bp);
801012b8:	89 1c 24             	mov    %ebx,(%esp)
801012bb:	e8 00 ef ff ff       	call   801001c0 <brelse>
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
801012c0:	83 c4 2c             	add    $0x2c,%esp
801012c3:	89 f0                	mov    %esi,%eax
801012c5:	5b                   	pop    %ebx
801012c6:	5e                   	pop    %esi
801012c7:	5f                   	pop    %edi
801012c8:	5d                   	pop    %ebp
801012c9:	c3                   	ret    
801012ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801012d0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801012d0:	55                   	push   %ebp
801012d1:	89 e5                	mov    %esp,%ebp
801012d3:	83 ec 38             	sub    $0x38,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801012d6:	83 fa 0b             	cmp    $0xb,%edx

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801012d9:	89 75 f8             	mov    %esi,-0x8(%ebp)
801012dc:	89 c6                	mov    %eax,%esi
801012de:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801012e1:	89 7d fc             	mov    %edi,-0x4(%ebp)
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801012e4:	77 1a                	ja     80101300 <bmap+0x30>
    if((addr = ip->addrs[bn]) == 0)
801012e6:	8d 7a 04             	lea    0x4(%edx),%edi
801012e9:	8b 5c b8 0c          	mov    0xc(%eax,%edi,4),%ebx
801012ed:	85 db                	test   %ebx,%ebx
801012ef:	74 6f                	je     80101360 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801012f1:	89 d8                	mov    %ebx,%eax
801012f3:	8b 75 f8             	mov    -0x8(%ebp),%esi
801012f6:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801012f9:	8b 7d fc             	mov    -0x4(%ebp),%edi
801012fc:	89 ec                	mov    %ebp,%esp
801012fe:	5d                   	pop    %ebp
801012ff:	c3                   	ret    
  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101300:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80101303:	83 fb 7f             	cmp    $0x7f,%ebx
80101306:	0f 87 80 00 00 00    	ja     8010138c <bmap+0xbc>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
8010130c:	8b 40 4c             	mov    0x4c(%eax),%eax
8010130f:	85 c0                	test   %eax,%eax
80101311:	74 6d                	je     80101380 <bmap+0xb0>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
80101313:	89 44 24 04          	mov    %eax,0x4(%esp)
80101317:	8b 06                	mov    (%esi),%eax
80101319:	89 04 24             	mov    %eax,(%esp)
8010131c:	e8 9f ed ff ff       	call   801000c0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101321:	8d 54 98 18          	lea    0x18(%eax,%ebx,4),%edx

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
80101325:	89 c7                	mov    %eax,%edi
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101327:	8b 1a                	mov    (%edx),%ebx
80101329:	85 db                	test   %ebx,%ebx
8010132b:	75 19                	jne    80101346 <bmap+0x76>
      a[bn] = addr = balloc(ip->dev);
8010132d:	8b 06                	mov    (%esi),%eax
8010132f:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101332:	e8 69 fe ff ff       	call   801011a0 <balloc>
80101337:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010133a:	89 02                	mov    %eax,(%edx)
8010133c:	89 c3                	mov    %eax,%ebx
      log_write(bp);
8010133e:	89 3c 24             	mov    %edi,(%esp)
80101341:	e8 da 19 00 00       	call   80102d20 <log_write>
    }
    brelse(bp);
80101346:	89 3c 24             	mov    %edi,(%esp)
80101349:	e8 72 ee ff ff       	call   801001c0 <brelse>
    return addr;
  }

  panic("bmap: out of range");
}
8010134e:	89 d8                	mov    %ebx,%eax
80101350:	8b 75 f8             	mov    -0x8(%ebp),%esi
80101353:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80101356:	8b 7d fc             	mov    -0x4(%ebp),%edi
80101359:	89 ec                	mov    %ebp,%esp
8010135b:	5d                   	pop    %ebp
8010135c:	c3                   	ret    
8010135d:	8d 76 00             	lea    0x0(%esi),%esi
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
80101360:	8b 00                	mov    (%eax),%eax
80101362:	e8 39 fe ff ff       	call   801011a0 <balloc>
80101367:	89 c3                	mov    %eax,%ebx
80101369:	89 44 be 0c          	mov    %eax,0xc(%esi,%edi,4)
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010136d:	89 d8                	mov    %ebx,%eax
8010136f:	8b 75 f8             	mov    -0x8(%ebp),%esi
80101372:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80101375:	8b 7d fc             	mov    -0x4(%ebp),%edi
80101378:	89 ec                	mov    %ebp,%esp
8010137a:	5d                   	pop    %ebp
8010137b:	c3                   	ret    
8010137c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bn -= NDIRECT;

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101380:	8b 06                	mov    (%esi),%eax
80101382:	e8 19 fe ff ff       	call   801011a0 <balloc>
80101387:	89 46 4c             	mov    %eax,0x4c(%esi)
8010138a:	eb 87                	jmp    80101313 <bmap+0x43>
    }
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
8010138c:	c7 04 24 ba 6e 10 80 	movl   $0x80106eba,(%esp)
80101393:	e8 98 ef ff ff       	call   80100330 <panic>
80101398:	90                   	nop
80101399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801013a0 <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
801013a0:	55                   	push   %ebp
801013a1:	89 e5                	mov    %esp,%ebp
801013a3:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;

  bp = bread(dev, 1);
801013a6:	8b 45 08             	mov    0x8(%ebp),%eax
801013a9:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
801013b0:	00 
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
801013b1:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801013b4:	89 75 fc             	mov    %esi,-0x4(%ebp)
801013b7:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct buf *bp;

  bp = bread(dev, 1);
801013ba:	89 04 24             	mov    %eax,(%esp)
801013bd:	e8 fe ec ff ff       	call   801000c0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801013c2:	c7 44 24 08 1c 00 00 	movl   $0x1c,0x8(%esp)
801013c9:	00 
801013ca:	89 34 24             	mov    %esi,(%esp)
void
readsb(int dev, struct superblock *sb)
{
  struct buf *bp;

  bp = bread(dev, 1);
801013cd:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801013cf:	8d 40 18             	lea    0x18(%eax),%eax
801013d2:	89 44 24 04          	mov    %eax,0x4(%esp)
801013d6:	e8 c5 2f 00 00       	call   801043a0 <memmove>
  brelse(bp);
}
801013db:	8b 75 fc             	mov    -0x4(%ebp),%esi
{
  struct buf *bp;

  bp = bread(dev, 1);
  memmove(sb, bp->data, sizeof(*sb));
  brelse(bp);
801013de:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801013e1:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801013e4:	89 ec                	mov    %ebp,%esp
801013e6:	5d                   	pop    %ebp
{
  struct buf *bp;

  bp = bread(dev, 1);
  memmove(sb, bp->data, sizeof(*sb));
  brelse(bp);
801013e7:	e9 d4 ed ff ff       	jmp    801001c0 <brelse>
801013ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801013f0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
801013f0:	55                   	push   %ebp
801013f1:	89 e5                	mov    %esp,%ebp
801013f3:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
801013f6:	89 04 24             	mov    %eax,(%esp)
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
801013f9:	89 7d fc             	mov    %edi,-0x4(%ebp)
801013fc:	89 d7                	mov    %edx,%edi
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
801013fe:	c7 44 24 04 80 01 11 	movl   $0x80110180,0x4(%esp)
80101405:	80 
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101406:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80101409:	89 c3                	mov    %eax,%ebx
8010140b:	89 75 f8             	mov    %esi,-0x8(%ebp)
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
8010140e:	e8 8d ff ff ff       	call   801013a0 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
80101413:	89 fa                	mov    %edi,%edx
80101415:	c1 ea 0c             	shr    $0xc,%edx
80101418:	03 15 98 01 11 80    	add    0x80110198,%edx
8010141e:	89 1c 24             	mov    %ebx,(%esp)
  bi = b % BPB;
  m = 1 << (bi % 8);
80101421:	bb 01 00 00 00       	mov    $0x1,%ebx
{
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
80101426:	89 54 24 04          	mov    %edx,0x4(%esp)
8010142a:	e8 91 ec ff ff       	call   801000c0 <bread>
  bi = b % BPB;
8010142f:	89 fa                	mov    %edi,%edx
  m = 1 << (bi % 8);
80101431:	89 f9                	mov    %edi,%ecx
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
80101433:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
  m = 1 << (bi % 8);
80101439:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
8010143c:	c1 fa 03             	sar    $0x3,%edx
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
8010143f:	d3 e3                	shl    %cl,%ebx
{
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
80101441:	89 c6                	mov    %eax,%esi
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
80101443:	0f b6 44 10 18       	movzbl 0x18(%eax,%edx,1),%eax
80101448:	0f b6 c8             	movzbl %al,%ecx
8010144b:	85 d9                	test   %ebx,%ecx
8010144d:	74 25                	je     80101474 <bfree+0x84>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
8010144f:	f7 d3                	not    %ebx
80101451:	21 c3                	and    %eax,%ebx
80101453:	88 5c 16 18          	mov    %bl,0x18(%esi,%edx,1)
  log_write(bp);
80101457:	89 34 24             	mov    %esi,(%esp)
8010145a:	e8 c1 18 00 00       	call   80102d20 <log_write>
  brelse(bp);
8010145f:	89 34 24             	mov    %esi,(%esp)
80101462:	e8 59 ed ff ff       	call   801001c0 <brelse>
}
80101467:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010146a:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010146d:	8b 7d fc             	mov    -0x4(%ebp),%edi
80101470:	89 ec                	mov    %ebp,%esp
80101472:	5d                   	pop    %ebp
80101473:	c3                   	ret    
  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
80101474:	c7 04 24 cd 6e 10 80 	movl   $0x80106ecd,(%esp)
8010147b:	e8 b0 ee ff ff       	call   80100330 <panic>

80101480 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
80101480:	55                   	push   %ebp
80101481:	89 e5                	mov    %esp,%ebp
80101483:	83 ec 28             	sub    $0x28,%esp
  initlock(&icache.lock, "icache");
80101486:	c7 44 24 04 e0 6e 10 	movl   $0x80106ee0,0x4(%esp)
8010148d:	80 
8010148e:	c7 04 24 a0 01 11 80 	movl   $0x801101a0,(%esp)
80101495:	e8 56 2c 00 00       	call   801040f0 <initlock>
  readsb(dev, &sb);
8010149a:	8b 45 08             	mov    0x8(%ebp),%eax
8010149d:	c7 44 24 04 80 01 11 	movl   $0x80110180,0x4(%esp)
801014a4:	80 
801014a5:	89 04 24             	mov    %eax,(%esp)
801014a8:	e8 f3 fe ff ff       	call   801013a0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801014ad:	a1 98 01 11 80       	mov    0x80110198,%eax
801014b2:	c7 04 24 40 6f 10 80 	movl   $0x80106f40,(%esp)
801014b9:	89 44 24 1c          	mov    %eax,0x1c(%esp)
801014bd:	a1 94 01 11 80       	mov    0x80110194,%eax
801014c2:	89 44 24 18          	mov    %eax,0x18(%esp)
801014c6:	a1 90 01 11 80       	mov    0x80110190,%eax
801014cb:	89 44 24 14          	mov    %eax,0x14(%esp)
801014cf:	a1 8c 01 11 80       	mov    0x8011018c,%eax
801014d4:	89 44 24 10          	mov    %eax,0x10(%esp)
801014d8:	a1 88 01 11 80       	mov    0x80110188,%eax
801014dd:	89 44 24 0c          	mov    %eax,0xc(%esp)
801014e1:	a1 84 01 11 80       	mov    0x80110184,%eax
801014e6:	89 44 24 08          	mov    %eax,0x8(%esp)
801014ea:	a1 80 01 11 80       	mov    0x80110180,%eax
801014ef:	89 44 24 04          	mov    %eax,0x4(%esp)
801014f3:	e8 08 f1 ff ff       	call   80100600 <cprintf>
          inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
801014f8:	c9                   	leave  
801014f9:	c3                   	ret    
801014fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101500 <ialloc>:
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
80101500:	55                   	push   %ebp
80101501:	89 e5                	mov    %esp,%ebp
80101503:	57                   	push   %edi
80101504:	56                   	push   %esi
80101505:	53                   	push   %ebx
80101506:	83 ec 2c             	sub    $0x2c,%esp
80101509:	8b 45 08             	mov    0x8(%ebp),%eax
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
8010150c:	83 3d 88 01 11 80 01 	cmpl   $0x1,0x80110188
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
80101513:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101516:	0f b7 45 0c          	movzwl 0xc(%ebp),%eax
8010151a:	66 89 45 e2          	mov    %ax,-0x1e(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
8010151e:	0f 86 95 00 00 00    	jbe    801015b9 <ialloc+0xb9>
80101524:	bf 01 00 00 00       	mov    $0x1,%edi
80101529:	bb 01 00 00 00       	mov    $0x1,%ebx
8010152e:	eb 15                	jmp    80101545 <ialloc+0x45>
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101530:	89 34 24             	mov    %esi,(%esp)
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101533:	83 c3 01             	add    $0x1,%ebx
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101536:	e8 85 ec ff ff       	call   801001c0 <brelse>
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
8010153b:	89 df                	mov    %ebx,%edi
8010153d:	3b 1d 88 01 11 80    	cmp    0x80110188,%ebx
80101543:	73 74                	jae    801015b9 <ialloc+0xb9>
    bp = bread(dev, IBLOCK(inum, sb));
80101545:	89 f8                	mov    %edi,%eax
80101547:	c1 e8 03             	shr    $0x3,%eax
8010154a:	03 05 94 01 11 80    	add    0x80110194,%eax
80101550:	89 44 24 04          	mov    %eax,0x4(%esp)
80101554:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101557:	89 04 24             	mov    %eax,(%esp)
8010155a:	e8 61 eb ff ff       	call   801000c0 <bread>
8010155f:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + inum%IPB;
80101561:	89 d8                	mov    %ebx,%eax
80101563:	83 e0 07             	and    $0x7,%eax
80101566:	c1 e0 06             	shl    $0x6,%eax
80101569:	8d 4c 06 18          	lea    0x18(%esi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010156d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101571:	75 bd                	jne    80101530 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101573:	89 0c 24             	mov    %ecx,(%esp)
80101576:	c7 44 24 08 40 00 00 	movl   $0x40,0x8(%esp)
8010157d:	00 
8010157e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80101585:	00 
80101586:	89 4d dc             	mov    %ecx,-0x24(%ebp)
80101589:	e8 62 2d 00 00       	call   801042f0 <memset>
      dip->type = type;
8010158e:	0f b7 45 e2          	movzwl -0x1e(%ebp),%eax
80101592:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80101595:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
80101598:	89 34 24             	mov    %esi,(%esp)
8010159b:	e8 80 17 00 00       	call   80102d20 <log_write>
      brelse(bp);
801015a0:	89 34 24             	mov    %esi,(%esp)
801015a3:	e8 18 ec ff ff       	call   801001c0 <brelse>
      return iget(dev, inum);
801015a8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
801015ab:	83 c4 2c             	add    $0x2c,%esp
801015ae:	5b                   	pop    %ebx
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
801015af:	89 fa                	mov    %edi,%edx
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
801015b1:	5e                   	pop    %esi
801015b2:	5f                   	pop    %edi
801015b3:	5d                   	pop    %ebp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
801015b4:	e9 27 fb ff ff       	jmp    801010e0 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
801015b9:	c7 04 24 e7 6e 10 80 	movl   $0x80106ee7,(%esp)
801015c0:	e8 6b ed ff ff       	call   80100330 <panic>
801015c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801015c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801015d0 <iupdate>:
}

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
801015d0:	55                   	push   %ebp
801015d1:	89 e5                	mov    %esp,%ebp
801015d3:	56                   	push   %esi
801015d4:	53                   	push   %ebx
801015d5:	83 ec 10             	sub    $0x10,%esp
801015d8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015db:	8b 43 04             	mov    0x4(%ebx),%eax
801015de:	c1 e8 03             	shr    $0x3,%eax
801015e1:	03 05 94 01 11 80    	add    0x80110194,%eax
801015e7:	89 44 24 04          	mov    %eax,0x4(%esp)
801015eb:	8b 03                	mov    (%ebx),%eax
801015ed:	89 04 24             	mov    %eax,(%esp)
801015f0:	e8 cb ea ff ff       	call   801000c0 <bread>
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801015f5:	8b 53 04             	mov    0x4(%ebx),%edx
801015f8:	83 e2 07             	and    $0x7,%edx
801015fb:	c1 e2 06             	shl    $0x6,%edx
801015fe:	8d 54 10 18          	lea    0x18(%eax,%edx,1),%edx
iupdate(struct inode *ip)
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101602:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
80101604:	0f b7 43 10          	movzwl 0x10(%ebx),%eax
80101608:	66 89 02             	mov    %ax,(%edx)
  dip->major = ip->major;
8010160b:	0f b7 43 12          	movzwl 0x12(%ebx),%eax
8010160f:	66 89 42 02          	mov    %ax,0x2(%edx)
  dip->minor = ip->minor;
80101613:	0f b7 43 14          	movzwl 0x14(%ebx),%eax
80101617:	66 89 42 04          	mov    %ax,0x4(%edx)
  dip->nlink = ip->nlink;
8010161b:	0f b7 43 16          	movzwl 0x16(%ebx),%eax
8010161f:	66 89 42 06          	mov    %ax,0x6(%edx)
  dip->size = ip->size;
80101623:	8b 43 18             	mov    0x18(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101626:	83 c3 1c             	add    $0x1c,%ebx
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
80101629:	89 42 08             	mov    %eax,0x8(%edx)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010162c:	83 c2 0c             	add    $0xc,%edx
8010162f:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101633:	89 14 24             	mov    %edx,(%esp)
80101636:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
8010163d:	00 
8010163e:	e8 5d 2d 00 00       	call   801043a0 <memmove>
  log_write(bp);
80101643:	89 34 24             	mov    %esi,(%esp)
80101646:	e8 d5 16 00 00       	call   80102d20 <log_write>
  brelse(bp);
8010164b:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010164e:	83 c4 10             	add    $0x10,%esp
80101651:	5b                   	pop    %ebx
80101652:	5e                   	pop    %esi
80101653:	5d                   	pop    %ebp
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  log_write(bp);
  brelse(bp);
80101654:	e9 67 eb ff ff       	jmp    801001c0 <brelse>
80101659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101660 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
80101660:	55                   	push   %ebp
80101661:	89 e5                	mov    %esp,%ebp
80101663:	53                   	push   %ebx
80101664:	83 ec 14             	sub    $0x14,%esp
80101667:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010166a:	c7 04 24 a0 01 11 80 	movl   $0x801101a0,(%esp)
80101671:	e8 fa 2a 00 00       	call   80104170 <acquire>
  ip->ref++;
80101676:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010167a:	c7 04 24 a0 01 11 80 	movl   $0x801101a0,(%esp)
80101681:	e8 1a 2c 00 00       	call   801042a0 <release>
  return ip;
}
80101686:	83 c4 14             	add    $0x14,%esp
80101689:	89 d8                	mov    %ebx,%eax
8010168b:	5b                   	pop    %ebx
8010168c:	5d                   	pop    %ebp
8010168d:	c3                   	ret    
8010168e:	66 90                	xchg   %ax,%ax

80101690 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80101690:	55                   	push   %ebp
80101691:	89 e5                	mov    %esp,%ebp
80101693:	56                   	push   %esi
80101694:	53                   	push   %ebx
80101695:	83 ec 10             	sub    $0x10,%esp
80101698:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
8010169b:	85 db                	test   %ebx,%ebx
8010169d:	0f 84 ed 00 00 00    	je     80101790 <ilock+0x100>
801016a3:	8b 43 08             	mov    0x8(%ebx),%eax
801016a6:	85 c0                	test   %eax,%eax
801016a8:	0f 8e e2 00 00 00    	jle    80101790 <ilock+0x100>
    panic("ilock");

  acquire(&icache.lock);
801016ae:	c7 04 24 a0 01 11 80 	movl   $0x801101a0,(%esp)
801016b5:	e8 b6 2a 00 00       	call   80104170 <acquire>
  while(ip->flags & I_BUSY)
801016ba:	8b 43 0c             	mov    0xc(%ebx),%eax
801016bd:	a8 01                	test   $0x1,%al
801016bf:	74 1e                	je     801016df <ilock+0x4f>
801016c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(ip, &icache.lock);
801016c8:	c7 44 24 04 a0 01 11 	movl   $0x801101a0,0x4(%esp)
801016cf:	80 
801016d0:	89 1c 24             	mov    %ebx,(%esp)
801016d3:	e8 c8 26 00 00       	call   80103da0 <sleep>

  if(ip == 0 || ip->ref < 1)
    panic("ilock");

  acquire(&icache.lock);
  while(ip->flags & I_BUSY)
801016d8:	8b 43 0c             	mov    0xc(%ebx),%eax
801016db:	a8 01                	test   $0x1,%al
801016dd:	75 e9                	jne    801016c8 <ilock+0x38>
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
801016df:	83 c8 01             	or     $0x1,%eax
801016e2:	89 43 0c             	mov    %eax,0xc(%ebx)
  release(&icache.lock);
801016e5:	c7 04 24 a0 01 11 80 	movl   $0x801101a0,(%esp)
801016ec:	e8 af 2b 00 00       	call   801042a0 <release>

  if(!(ip->flags & I_VALID)){
801016f1:	f6 43 0c 02          	testb  $0x2,0xc(%ebx)
801016f5:	74 09                	je     80101700 <ilock+0x70>
    brelse(bp);
    ip->flags |= I_VALID;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
801016f7:	83 c4 10             	add    $0x10,%esp
801016fa:	5b                   	pop    %ebx
801016fb:	5e                   	pop    %esi
801016fc:	5d                   	pop    %ebp
801016fd:	c3                   	ret    
801016fe:	66 90                	xchg   %ax,%ax
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
  release(&icache.lock);

  if(!(ip->flags & I_VALID)){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101700:	8b 43 04             	mov    0x4(%ebx),%eax
80101703:	c1 e8 03             	shr    $0x3,%eax
80101706:	03 05 94 01 11 80    	add    0x80110194,%eax
8010170c:	89 44 24 04          	mov    %eax,0x4(%esp)
80101710:	8b 03                	mov    (%ebx),%eax
80101712:	89 04 24             	mov    %eax,(%esp)
80101715:	e8 a6 e9 ff ff       	call   801000c0 <bread>
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010171a:	8b 53 04             	mov    0x4(%ebx),%edx
8010171d:	83 e2 07             	and    $0x7,%edx
80101720:	c1 e2 06             	shl    $0x6,%edx
80101723:	8d 54 10 18          	lea    0x18(%eax,%edx,1),%edx
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
  release(&icache.lock);

  if(!(ip->flags & I_VALID)){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101727:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
80101729:	0f b7 02             	movzwl (%edx),%eax
8010172c:	66 89 43 10          	mov    %ax,0x10(%ebx)
    ip->major = dip->major;
80101730:	0f b7 42 02          	movzwl 0x2(%edx),%eax
80101734:	66 89 43 12          	mov    %ax,0x12(%ebx)
    ip->minor = dip->minor;
80101738:	0f b7 42 04          	movzwl 0x4(%edx),%eax
8010173c:	66 89 43 14          	mov    %ax,0x14(%ebx)
    ip->nlink = dip->nlink;
80101740:	0f b7 42 06          	movzwl 0x6(%edx),%eax
80101744:	66 89 43 16          	mov    %ax,0x16(%ebx)
    ip->size = dip->size;
80101748:	8b 42 08             	mov    0x8(%edx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010174b:	83 c2 0c             	add    $0xc,%edx
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
8010174e:	89 43 18             	mov    %eax,0x18(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101751:	8d 43 1c             	lea    0x1c(%ebx),%eax
80101754:	89 54 24 04          	mov    %edx,0x4(%esp)
80101758:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
8010175f:	00 
80101760:	89 04 24             	mov    %eax,(%esp)
80101763:	e8 38 2c 00 00       	call   801043a0 <memmove>
    brelse(bp);
80101768:	89 34 24             	mov    %esi,(%esp)
8010176b:	e8 50 ea ff ff       	call   801001c0 <brelse>
    ip->flags |= I_VALID;
80101770:	83 4b 0c 02          	orl    $0x2,0xc(%ebx)
    if(ip->type == 0)
80101774:	66 83 7b 10 00       	cmpw   $0x0,0x10(%ebx)
80101779:	0f 85 78 ff ff ff    	jne    801016f7 <ilock+0x67>
      panic("ilock: no type");
8010177f:	c7 04 24 ff 6e 10 80 	movl   $0x80106eff,(%esp)
80101786:	e8 a5 eb ff ff       	call   80100330 <panic>
8010178b:	90                   	nop
8010178c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
80101790:	c7 04 24 f9 6e 10 80 	movl   $0x80106ef9,(%esp)
80101797:	e8 94 eb ff ff       	call   80100330 <panic>
8010179c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801017a0 <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
801017a0:	55                   	push   %ebp
801017a1:	89 e5                	mov    %esp,%ebp
801017a3:	53                   	push   %ebx
801017a4:	83 ec 14             	sub    $0x14,%esp
801017a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
801017aa:	85 db                	test   %ebx,%ebx
801017ac:	74 36                	je     801017e4 <iunlock+0x44>
801017ae:	f6 43 0c 01          	testb  $0x1,0xc(%ebx)
801017b2:	74 30                	je     801017e4 <iunlock+0x44>
801017b4:	8b 43 08             	mov    0x8(%ebx),%eax
801017b7:	85 c0                	test   %eax,%eax
801017b9:	7e 29                	jle    801017e4 <iunlock+0x44>
    panic("iunlock");

  acquire(&icache.lock);
801017bb:	c7 04 24 a0 01 11 80 	movl   $0x801101a0,(%esp)
801017c2:	e8 a9 29 00 00       	call   80104170 <acquire>
  ip->flags &= ~I_BUSY;
801017c7:	83 63 0c fe          	andl   $0xfffffffe,0xc(%ebx)
  wakeup(ip);
801017cb:	89 1c 24             	mov    %ebx,(%esp)
801017ce:	e8 6d 27 00 00       	call   80103f40 <wakeup>
  release(&icache.lock);
801017d3:	c7 45 08 a0 01 11 80 	movl   $0x801101a0,0x8(%ebp)
}
801017da:	83 c4 14             	add    $0x14,%esp
801017dd:	5b                   	pop    %ebx
801017de:	5d                   	pop    %ebp
    panic("iunlock");

  acquire(&icache.lock);
  ip->flags &= ~I_BUSY;
  wakeup(ip);
  release(&icache.lock);
801017df:	e9 bc 2a 00 00       	jmp    801042a0 <release>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
    panic("iunlock");
801017e4:	c7 04 24 0e 6f 10 80 	movl   $0x80106f0e,(%esp)
801017eb:	e8 40 eb ff ff       	call   80100330 <panic>

801017f0 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
801017f0:	55                   	push   %ebp
801017f1:	89 e5                	mov    %esp,%ebp
801017f3:	57                   	push   %edi
801017f4:	56                   	push   %esi
801017f5:	53                   	push   %ebx
801017f6:	83 ec 2c             	sub    $0x2c,%esp
801017f9:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&icache.lock);
801017fc:	c7 04 24 a0 01 11 80 	movl   $0x801101a0,(%esp)
80101803:	e8 68 29 00 00       	call   80104170 <acquire>
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
80101808:	8b 46 08             	mov    0x8(%esi),%eax
8010180b:	83 f8 01             	cmp    $0x1,%eax
8010180e:	0f 85 a1 00 00 00    	jne    801018b5 <iput+0xc5>
80101814:	8b 56 0c             	mov    0xc(%esi),%edx
80101817:	f6 c2 02             	test   $0x2,%dl
8010181a:	0f 84 95 00 00 00    	je     801018b5 <iput+0xc5>
80101820:	66 83 7e 16 00       	cmpw   $0x0,0x16(%esi)
80101825:	0f 85 8a 00 00 00    	jne    801018b5 <iput+0xc5>
    // inode has no links and no other references: truncate and free.
    if(ip->flags & I_BUSY)
8010182b:	f6 c2 01             	test   $0x1,%dl
8010182e:	0f 85 fa 00 00 00    	jne    8010192e <iput+0x13e>
      panic("iput busy");
    ip->flags |= I_BUSY;
80101834:	83 ca 01             	or     $0x1,%edx
80101837:	89 f3                	mov    %esi,%ebx
80101839:	89 56 0c             	mov    %edx,0xc(%esi)
// If that was the last reference and the inode has no links
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
8010183c:	8d 7e 30             	lea    0x30(%esi),%edi
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
    // inode has no links and no other references: truncate and free.
    if(ip->flags & I_BUSY)
      panic("iput busy");
    ip->flags |= I_BUSY;
    release(&icache.lock);
8010183f:	c7 04 24 a0 01 11 80 	movl   $0x801101a0,(%esp)
80101846:	e8 55 2a 00 00       	call   801042a0 <release>
8010184b:	eb 0a                	jmp    80101857 <iput+0x67>
8010184d:	8d 76 00             	lea    0x0(%esi),%esi
80101850:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101853:	39 fb                	cmp    %edi,%ebx
80101855:	74 1c                	je     80101873 <iput+0x83>
    if(ip->addrs[i]){
80101857:	8b 53 1c             	mov    0x1c(%ebx),%edx
8010185a:	85 d2                	test   %edx,%edx
8010185c:	74 f2                	je     80101850 <iput+0x60>
      bfree(ip->dev, ip->addrs[i]);
8010185e:	8b 06                	mov    (%esi),%eax
80101860:	e8 8b fb ff ff       	call   801013f0 <bfree>
      ip->addrs[i] = 0;
80101865:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
8010186c:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
8010186f:	39 fb                	cmp    %edi,%ebx
80101871:	75 e4                	jne    80101857 <iput+0x67>
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
80101873:	8b 46 4c             	mov    0x4c(%esi),%eax
80101876:	85 c0                	test   %eax,%eax
80101878:	75 56                	jne    801018d0 <iput+0xe0>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
8010187a:	c7 46 18 00 00 00 00 	movl   $0x0,0x18(%esi)
  iupdate(ip);
80101881:	89 34 24             	mov    %esi,(%esp)
80101884:	e8 47 fd ff ff       	call   801015d0 <iupdate>
    if(ip->flags & I_BUSY)
      panic("iput busy");
    ip->flags |= I_BUSY;
    release(&icache.lock);
    itrunc(ip);
    ip->type = 0;
80101889:	66 c7 46 10 00 00    	movw   $0x0,0x10(%esi)
    iupdate(ip);
8010188f:	89 34 24             	mov    %esi,(%esp)
80101892:	e8 39 fd ff ff       	call   801015d0 <iupdate>
    acquire(&icache.lock);
80101897:	c7 04 24 a0 01 11 80 	movl   $0x801101a0,(%esp)
8010189e:	e8 cd 28 00 00       	call   80104170 <acquire>
    ip->flags = 0;
801018a3:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
    wakeup(ip);
801018aa:	89 34 24             	mov    %esi,(%esp)
801018ad:	e8 8e 26 00 00       	call   80103f40 <wakeup>
801018b2:	8b 46 08             	mov    0x8(%esi),%eax
  }
  ip->ref--;
801018b5:	83 e8 01             	sub    $0x1,%eax
801018b8:	89 46 08             	mov    %eax,0x8(%esi)
  release(&icache.lock);
801018bb:	c7 45 08 a0 01 11 80 	movl   $0x801101a0,0x8(%ebp)
}
801018c2:	83 c4 2c             	add    $0x2c,%esp
801018c5:	5b                   	pop    %ebx
801018c6:	5e                   	pop    %esi
801018c7:	5f                   	pop    %edi
801018c8:	5d                   	pop    %ebp
    acquire(&icache.lock);
    ip->flags = 0;
    wakeup(ip);
  }
  ip->ref--;
  release(&icache.lock);
801018c9:	e9 d2 29 00 00       	jmp    801042a0 <release>
801018ce:	66 90                	xchg   %ax,%ax
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801018d0:	89 44 24 04          	mov    %eax,0x4(%esp)
801018d4:	8b 06                	mov    (%esi),%eax
    a = (uint*)bp->data;
    for(j = 0; j < NINDIRECT; j++){
801018d6:	31 db                	xor    %ebx,%ebx
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801018d8:	89 04 24             	mov    %eax,(%esp)
801018db:	e8 e0 e7 ff ff       	call   801000c0 <bread>
    a = (uint*)bp->data;
801018e0:	89 c7                	mov    %eax,%edi
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801018e2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
801018e5:	83 c7 18             	add    $0x18,%edi
    for(j = 0; j < NINDIRECT; j++){
801018e8:	31 c0                	xor    %eax,%eax
801018ea:	eb 11                	jmp    801018fd <iput+0x10d>
801018ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801018f0:	83 c3 01             	add    $0x1,%ebx
801018f3:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
801018f9:	89 d8                	mov    %ebx,%eax
801018fb:	74 10                	je     8010190d <iput+0x11d>
      if(a[j])
801018fd:	8b 14 87             	mov    (%edi,%eax,4),%edx
80101900:	85 d2                	test   %edx,%edx
80101902:	74 ec                	je     801018f0 <iput+0x100>
        bfree(ip->dev, a[j]);
80101904:	8b 06                	mov    (%esi),%eax
80101906:	e8 e5 fa ff ff       	call   801013f0 <bfree>
8010190b:	eb e3                	jmp    801018f0 <iput+0x100>
    }
    brelse(bp);
8010190d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101910:	89 04 24             	mov    %eax,(%esp)
80101913:	e8 a8 e8 ff ff       	call   801001c0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101918:	8b 56 4c             	mov    0x4c(%esi),%edx
8010191b:	8b 06                	mov    (%esi),%eax
8010191d:	e8 ce fa ff ff       	call   801013f0 <bfree>
    ip->addrs[NDIRECT] = 0;
80101922:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
80101929:	e9 4c ff ff ff       	jmp    8010187a <iput+0x8a>
{
  acquire(&icache.lock);
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
    // inode has no links and no other references: truncate and free.
    if(ip->flags & I_BUSY)
      panic("iput busy");
8010192e:	c7 04 24 16 6f 10 80 	movl   $0x80106f16,(%esp)
80101935:	e8 f6 e9 ff ff       	call   80100330 <panic>
8010193a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101940 <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101940:	55                   	push   %ebp
80101941:	89 e5                	mov    %esp,%ebp
80101943:	53                   	push   %ebx
80101944:	83 ec 14             	sub    $0x14,%esp
80101947:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
8010194a:	89 1c 24             	mov    %ebx,(%esp)
8010194d:	e8 4e fe ff ff       	call   801017a0 <iunlock>
  iput(ip);
80101952:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101955:	83 c4 14             	add    $0x14,%esp
80101958:	5b                   	pop    %ebx
80101959:	5d                   	pop    %ebp
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
8010195a:	e9 91 fe ff ff       	jmp    801017f0 <iput>
8010195f:	90                   	nop

80101960 <stati>:
}

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
80101960:	55                   	push   %ebp
80101961:	89 e5                	mov    %esp,%ebp
80101963:	8b 55 08             	mov    0x8(%ebp),%edx
80101966:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101969:	8b 0a                	mov    (%edx),%ecx
8010196b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010196e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101971:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101974:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
80101978:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010197b:	0f b7 4a 16          	movzwl 0x16(%edx),%ecx
8010197f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101983:	8b 52 18             	mov    0x18(%edx),%edx
80101986:	89 50 10             	mov    %edx,0x10(%eax)
}
80101989:	5d                   	pop    %ebp
8010198a:	c3                   	ret    
8010198b:	90                   	nop
8010198c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101990 <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101990:	55                   	push   %ebp
80101991:	89 e5                	mov    %esp,%ebp
80101993:	57                   	push   %edi
80101994:	56                   	push   %esi
80101995:	53                   	push   %ebx
80101996:	83 ec 2c             	sub    $0x2c,%esp
80101999:	8b 7d 08             	mov    0x8(%ebp),%edi
8010199c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010199f:	8b 55 14             	mov    0x14(%ebp),%edx
801019a2:	8b 75 10             	mov    0x10(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801019a5:	66 83 7f 10 03       	cmpw   $0x3,0x10(%edi)

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
801019aa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801019ad:	89 55 e0             	mov    %edx,-0x20(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801019b0:	0f 84 aa 00 00 00    	je     80101a60 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
801019b6:	8b 47 18             	mov    0x18(%edi),%eax
801019b9:	39 f0                	cmp    %esi,%eax
801019bb:	0f 82 c7 00 00 00    	jb     80101a88 <readi+0xf8>
801019c1:	8b 55 e0             	mov    -0x20(%ebp),%edx
801019c4:	01 f2                	add    %esi,%edx
801019c6:	0f 82 bc 00 00 00    	jb     80101a88 <readi+0xf8>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
801019cc:	89 c1                	mov    %eax,%ecx
801019ce:	29 f1                	sub    %esi,%ecx
801019d0:	39 d0                	cmp    %edx,%eax
801019d2:	0f 43 4d e0          	cmovae -0x20(%ebp),%ecx
801019d6:	89 4d e0             	mov    %ecx,-0x20(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019d9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801019dc:	31 c9                	xor    %ecx,%ecx
801019de:	85 c0                	test   %eax,%eax
801019e0:	74 6f                	je     80101a51 <readi+0xc1>
801019e2:	89 7d dc             	mov    %edi,-0x24(%ebp)
801019e5:	89 cf                	mov    %ecx,%edi
801019e7:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019e8:	8b 45 dc             	mov    -0x24(%ebp),%eax
801019eb:	89 f2                	mov    %esi,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
801019ed:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019f2:	c1 ea 09             	shr    $0x9,%edx
801019f5:	e8 d6 f8 ff ff       	call   801012d0 <bmap>
801019fa:	8b 55 dc             	mov    -0x24(%ebp),%edx
801019fd:	89 44 24 04          	mov    %eax,0x4(%esp)
80101a01:	8b 02                	mov    (%edx),%eax
80101a03:	89 04 24             	mov    %eax,(%esp)
80101a06:	e8 b5 e6 ff ff       	call   801000c0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101a0b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101a0e:	29 f9                	sub    %edi,%ecx
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a10:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101a12:	89 f0                	mov    %esi,%eax
80101a14:	25 ff 01 00 00       	and    $0x1ff,%eax
80101a19:	29 c3                	sub    %eax,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101a1b:	8d 44 02 18          	lea    0x18(%edx,%eax,1),%eax
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101a1f:	39 cb                	cmp    %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101a21:	89 44 24 04          	mov    %eax,0x4(%esp)
80101a25:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101a28:	0f 47 d9             	cmova  %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101a2b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a2f:	01 df                	add    %ebx,%edi
80101a31:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
80101a33:	89 55 d8             	mov    %edx,-0x28(%ebp)
80101a36:	89 04 24             	mov    %eax,(%esp)
80101a39:	e8 62 29 00 00       	call   801043a0 <memmove>
    brelse(bp);
80101a3e:	8b 55 d8             	mov    -0x28(%ebp),%edx
80101a41:	89 14 24             	mov    %edx,(%esp)
80101a44:	e8 77 e7 ff ff       	call   801001c0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a49:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101a4c:	39 7d e0             	cmp    %edi,-0x20(%ebp)
80101a4f:	77 97                	ja     801019e8 <readi+0x58>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
80101a51:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101a54:	83 c4 2c             	add    $0x2c,%esp
80101a57:	5b                   	pop    %ebx
80101a58:	5e                   	pop    %esi
80101a59:	5f                   	pop    %edi
80101a5a:	5d                   	pop    %ebp
80101a5b:	c3                   	ret    
80101a5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101a60:	0f bf 47 12          	movswl 0x12(%edi),%eax
80101a64:	66 83 f8 09          	cmp    $0x9,%ax
80101a68:	77 1e                	ja     80101a88 <readi+0xf8>
80101a6a:	8b 04 c5 20 01 11 80 	mov    -0x7feefee0(,%eax,8),%eax
80101a71:	85 c0                	test   %eax,%eax
80101a73:	74 13                	je     80101a88 <readi+0xf8>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101a75:	89 55 10             	mov    %edx,0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
80101a78:	83 c4 2c             	add    $0x2c,%esp
80101a7b:	5b                   	pop    %ebx
80101a7c:	5e                   	pop    %esi
80101a7d:	5f                   	pop    %edi
80101a7e:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101a7f:	ff e0                	jmp    *%eax
80101a81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
80101a88:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a8d:	eb c5                	jmp    80101a54 <readi+0xc4>
80101a8f:	90                   	nop

80101a90 <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a90:	55                   	push   %ebp
80101a91:	89 e5                	mov    %esp,%ebp
80101a93:	57                   	push   %edi
80101a94:	56                   	push   %esi
80101a95:	53                   	push   %ebx
80101a96:	83 ec 2c             	sub    $0x2c,%esp
80101a99:	8b 45 08             	mov    0x8(%ebp),%eax
80101a9c:	8b 55 0c             	mov    0xc(%ebp),%edx
80101a9f:	8b 75 10             	mov    0x10(%ebp),%esi
80101aa2:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101aa5:	8b 45 14             	mov    0x14(%ebp),%eax
80101aa8:	89 55 e0             	mov    %edx,-0x20(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101aab:	8b 55 d8             	mov    -0x28(%ebp),%edx

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101aae:	89 45 dc             	mov    %eax,-0x24(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101ab1:	66 83 7a 10 03       	cmpw   $0x3,0x10(%edx)
80101ab6:	0f 84 bc 00 00 00    	je     80101b78 <writei+0xe8>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101abc:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101abf:	39 70 18             	cmp    %esi,0x18(%eax)
80101ac2:	0f 82 e8 00 00 00    	jb     80101bb0 <writei+0x120>
80101ac8:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101acb:	01 f0                	add    %esi,%eax
80101acd:	0f 82 dd 00 00 00    	jb     80101bb0 <writei+0x120>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101ad3:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101ad8:	0f 87 d2 00 00 00    	ja     80101bb0 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101ade:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101ae1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101ae8:	85 c0                	test   %eax,%eax
80101aea:	74 7c                	je     80101b68 <writei+0xd8>
80101aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101af0:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101af3:	89 f2                	mov    %esi,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101af5:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101afa:	c1 ea 09             	shr    $0x9,%edx
80101afd:	e8 ce f7 ff ff       	call   801012d0 <bmap>
80101b02:	8b 55 d8             	mov    -0x28(%ebp),%edx
80101b05:	89 44 24 04          	mov    %eax,0x4(%esp)
80101b09:	8b 02                	mov    (%edx),%eax
80101b0b:	89 04 24             	mov    %eax,(%esp)
80101b0e:	e8 ad e5 ff ff       	call   801000c0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101b13:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80101b16:	2b 4d e4             	sub    -0x1c(%ebp),%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101b19:	8b 55 e0             	mov    -0x20(%ebp),%edx
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b1c:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101b1e:	89 f0                	mov    %esi,%eax
80101b20:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b25:	29 c3                	sub    %eax,%ebx
80101b27:	39 cb                	cmp    %ecx,%ebx
80101b29:	0f 47 d9             	cmova  %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101b2c:	8d 44 07 18          	lea    0x18(%edi,%eax,1),%eax
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b30:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(bp->data + off%BSIZE, src, m);
80101b32:	89 54 24 04          	mov    %edx,0x4(%esp)
80101b36:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101b3a:	89 04 24             	mov    %eax,(%esp)
80101b3d:	e8 5e 28 00 00       	call   801043a0 <memmove>
    log_write(bp);
80101b42:	89 3c 24             	mov    %edi,(%esp)
80101b45:	e8 d6 11 00 00       	call   80102d20 <log_write>
    brelse(bp);
80101b4a:	89 3c 24             	mov    %edi,(%esp)
80101b4d:	e8 6e e6 ff ff       	call   801001c0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b52:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101b55:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101b58:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101b5b:	39 45 dc             	cmp    %eax,-0x24(%ebp)
80101b5e:	77 90                	ja     80101af0 <writei+0x60>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
80101b60:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b63:	3b 70 18             	cmp    0x18(%eax),%esi
80101b66:	77 38                	ja     80101ba0 <writei+0x110>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101b68:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
80101b6b:	83 c4 2c             	add    $0x2c,%esp
80101b6e:	5b                   	pop    %ebx
80101b6f:	5e                   	pop    %esi
80101b70:	5f                   	pop    %edi
80101b71:	5d                   	pop    %ebp
80101b72:	c3                   	ret    
80101b73:	90                   	nop
80101b74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101b78:	0f bf 42 12          	movswl 0x12(%edx),%eax
80101b7c:	66 83 f8 09          	cmp    $0x9,%ax
80101b80:	77 2e                	ja     80101bb0 <writei+0x120>
80101b82:	8b 04 c5 24 01 11 80 	mov    -0x7feefedc(,%eax,8),%eax
80101b89:	85 c0                	test   %eax,%eax
80101b8b:	74 23                	je     80101bb0 <writei+0x120>
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101b8d:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101b90:	89 55 10             	mov    %edx,0x10(%ebp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
80101b93:	83 c4 2c             	add    $0x2c,%esp
80101b96:	5b                   	pop    %ebx
80101b97:	5e                   	pop    %esi
80101b98:	5f                   	pop    %edi
80101b99:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101b9a:	ff e0                	jmp    *%eax
80101b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101ba0:	8b 55 d8             	mov    -0x28(%ebp),%edx
80101ba3:	89 72 18             	mov    %esi,0x18(%edx)
    iupdate(ip);
80101ba6:	89 14 24             	mov    %edx,(%esp)
80101ba9:	e8 22 fa ff ff       	call   801015d0 <iupdate>
80101bae:	eb b8                	jmp    80101b68 <writei+0xd8>
  }
  return n;
}
80101bb0:	83 c4 2c             	add    $0x2c,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
80101bb3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
80101bb8:	5b                   	pop    %ebx
80101bb9:	5e                   	pop    %esi
80101bba:	5f                   	pop    %edi
80101bbb:	5d                   	pop    %ebp
80101bbc:	c3                   	ret    
80101bbd:	8d 76 00             	lea    0x0(%esi),%esi

80101bc0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101bc0:	55                   	push   %ebp
80101bc1:	89 e5                	mov    %esp,%ebp
80101bc3:	83 ec 18             	sub    $0x18,%esp
  return strncmp(s, t, DIRSIZ);
80101bc6:	8b 45 0c             	mov    0xc(%ebp),%eax
80101bc9:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101bd0:	00 
80101bd1:	89 44 24 04          	mov    %eax,0x4(%esp)
80101bd5:	8b 45 08             	mov    0x8(%ebp),%eax
80101bd8:	89 04 24             	mov    %eax,(%esp)
80101bdb:	e8 40 28 00 00       	call   80104420 <strncmp>
}
80101be0:	c9                   	leave  
80101be1:	c3                   	ret    
80101be2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101bf0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101bf0:	55                   	push   %ebp
80101bf1:	89 e5                	mov    %esp,%ebp
80101bf3:	57                   	push   %edi
80101bf4:	56                   	push   %esi
80101bf5:	53                   	push   %ebx
80101bf6:	83 ec 2c             	sub    $0x2c,%esp
80101bf9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101bfc:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
80101c01:	0f 85 8f 00 00 00    	jne    80101c96 <dirlookup+0xa6>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101c07:	8b 53 18             	mov    0x18(%ebx),%edx
80101c0a:	31 ff                	xor    %edi,%edi
80101c0c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101c0f:	85 d2                	test   %edx,%edx
80101c11:	75 0d                	jne    80101c20 <dirlookup+0x30>
80101c13:	eb 6b                	jmp    80101c80 <dirlookup+0x90>
80101c15:	8d 76 00             	lea    0x0(%esi),%esi
80101c18:	83 c7 10             	add    $0x10,%edi
80101c1b:	39 7b 18             	cmp    %edi,0x18(%ebx)
80101c1e:	76 60                	jbe    80101c80 <dirlookup+0x90>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101c20:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80101c27:	00 
80101c28:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101c2c:	89 74 24 04          	mov    %esi,0x4(%esp)
80101c30:	89 1c 24             	mov    %ebx,(%esp)
80101c33:	e8 58 fd ff ff       	call   80101990 <readi>
80101c38:	83 f8 10             	cmp    $0x10,%eax
80101c3b:	75 4d                	jne    80101c8a <dirlookup+0x9a>
      panic("dirlink read");
    if(de.inum == 0)
80101c3d:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101c42:	74 d4                	je     80101c18 <dirlookup+0x28>
      continue;
    if(namecmp(name, de.name) == 0){
80101c44:	8d 45 da             	lea    -0x26(%ebp),%eax
80101c47:	89 44 24 04          	mov    %eax,0x4(%esp)
80101c4b:	8b 45 0c             	mov    0xc(%ebp),%eax
80101c4e:	89 04 24             	mov    %eax,(%esp)
80101c51:	e8 6a ff ff ff       	call   80101bc0 <namecmp>
80101c56:	85 c0                	test   %eax,%eax
80101c58:	75 be                	jne    80101c18 <dirlookup+0x28>
      // entry matches path element
      if(poff)
80101c5a:	8b 45 10             	mov    0x10(%ebp),%eax
80101c5d:	85 c0                	test   %eax,%eax
80101c5f:	74 05                	je     80101c66 <dirlookup+0x76>
        *poff = off;
80101c61:	8b 45 10             	mov    0x10(%ebp),%eax
80101c64:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101c66:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101c6a:	8b 03                	mov    (%ebx),%eax
80101c6c:	e8 6f f4 ff ff       	call   801010e0 <iget>
    }
  }

  return 0;
}
80101c71:	83 c4 2c             	add    $0x2c,%esp
80101c74:	5b                   	pop    %ebx
80101c75:	5e                   	pop    %esi
80101c76:	5f                   	pop    %edi
80101c77:	5d                   	pop    %ebp
80101c78:	c3                   	ret    
80101c79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c80:	83 c4 2c             	add    $0x2c,%esp
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80101c83:	31 c0                	xor    %eax,%eax
}
80101c85:	5b                   	pop    %ebx
80101c86:	5e                   	pop    %esi
80101c87:	5f                   	pop    %edi
80101c88:	5d                   	pop    %ebp
80101c89:	c3                   	ret    
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80101c8a:	c7 04 24 32 6f 10 80 	movl   $0x80106f32,(%esp)
80101c91:	e8 9a e6 ff ff       	call   80100330 <panic>
{
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
80101c96:	c7 04 24 20 6f 10 80 	movl   $0x80106f20,(%esp)
80101c9d:	e8 8e e6 ff ff       	call   80100330 <panic>
80101ca2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ca9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101cb0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101cb0:	55                   	push   %ebp
80101cb1:	89 e5                	mov    %esp,%ebp
80101cb3:	57                   	push   %edi
80101cb4:	89 cf                	mov    %ecx,%edi
80101cb6:	56                   	push   %esi
80101cb7:	53                   	push   %ebx
80101cb8:	89 c3                	mov    %eax,%ebx
80101cba:	83 ec 2c             	sub    $0x2c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101cbd:	80 38 2f             	cmpb   $0x2f,(%eax)
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101cc0:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
80101cc3:	0f 84 16 01 00 00    	je     80101ddf <namex+0x12f>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);
80101cc9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80101ccf:	8b 40 68             	mov    0x68(%eax),%eax
80101cd2:	89 04 24             	mov    %eax,(%esp)
80101cd5:	e8 86 f9 ff ff       	call   80101660 <idup>
80101cda:	89 c6                	mov    %eax,%esi
80101cdc:	eb 05                	jmp    80101ce3 <namex+0x33>
80101cde:	66 90                	xchg   %ax,%ax
{
  char *s;
  int len;

  while(*path == '/')
    path++;
80101ce0:	83 c3 01             	add    $0x1,%ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80101ce3:	0f b6 03             	movzbl (%ebx),%eax
80101ce6:	3c 2f                	cmp    $0x2f,%al
80101ce8:	74 f6                	je     80101ce0 <namex+0x30>
    path++;
  if(*path == 0)
80101cea:	84 c0                	test   %al,%al
80101cec:	0f 84 17 01 00 00    	je     80101e09 <namex+0x159>
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101cf2:	0f b6 03             	movzbl (%ebx),%eax
80101cf5:	89 da                	mov    %ebx,%edx
80101cf7:	3c 2f                	cmp    $0x2f,%al
80101cf9:	0f 84 b1 00 00 00    	je     80101db0 <namex+0x100>
80101cff:	84 c0                	test   %al,%al
80101d01:	75 0f                	jne    80101d12 <namex+0x62>
80101d03:	e9 a8 00 00 00       	jmp    80101db0 <namex+0x100>
80101d08:	3c 2f                	cmp    $0x2f,%al
80101d0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101d10:	74 0a                	je     80101d1c <namex+0x6c>
    path++;
80101d12:	83 c2 01             	add    $0x1,%edx
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101d15:	0f b6 02             	movzbl (%edx),%eax
80101d18:	84 c0                	test   %al,%al
80101d1a:	75 ec                	jne    80101d08 <namex+0x58>
80101d1c:	89 d1                	mov    %edx,%ecx
80101d1e:	29 d9                	sub    %ebx,%ecx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
80101d20:	83 f9 0d             	cmp    $0xd,%ecx
80101d23:	0f 8e 8f 00 00 00    	jle    80101db8 <namex+0x108>
    memmove(name, s, DIRSIZ);
80101d29:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101d2d:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101d34:	00 
80101d35:	89 3c 24             	mov    %edi,(%esp)
80101d38:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101d3b:	e8 60 26 00 00       	call   801043a0 <memmove>
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101d40:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101d43:	89 d3                	mov    %edx,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101d45:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101d48:	75 0e                	jne    80101d58 <namex+0xa8>
80101d4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    path++;
80101d50:	83 c3 01             	add    $0x1,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101d53:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101d56:	74 f8                	je     80101d50 <namex+0xa0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101d58:	89 34 24             	mov    %esi,(%esp)
80101d5b:	e8 30 f9 ff ff       	call   80101690 <ilock>
    if(ip->type != T_DIR){
80101d60:	66 83 7e 10 01       	cmpw   $0x1,0x10(%esi)
80101d65:	0f 85 8a 00 00 00    	jne    80101df5 <namex+0x145>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101d6b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101d6e:	85 d2                	test   %edx,%edx
80101d70:	74 09                	je     80101d7b <namex+0xcb>
80101d72:	80 3b 00             	cmpb   $0x0,(%ebx)
80101d75:	0f 84 b6 00 00 00    	je     80101e31 <namex+0x181>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101d7b:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80101d82:	00 
80101d83:	89 7c 24 04          	mov    %edi,0x4(%esp)
80101d87:	89 34 24             	mov    %esi,(%esp)
80101d8a:	e8 61 fe ff ff       	call   80101bf0 <dirlookup>
      iunlockput(ip);
80101d8f:	89 34 24             	mov    %esi,(%esp)
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101d92:	85 c0                	test   %eax,%eax
80101d94:	0f 84 86 00 00 00    	je     80101e20 <namex+0x170>
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
80101d9a:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101d9d:	e8 9e fb ff ff       	call   80101940 <iunlockput>
    ip = next;
80101da2:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101da5:	89 c6                	mov    %eax,%esi
80101da7:	e9 37 ff ff ff       	jmp    80101ce3 <namex+0x33>
80101dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101db0:	31 c9                	xor    %ecx,%ecx
80101db2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
80101db8:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80101dbc:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101dc0:	89 3c 24             	mov    %edi,(%esp)
80101dc3:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101dc6:	89 4d dc             	mov    %ecx,-0x24(%ebp)
80101dc9:	e8 d2 25 00 00       	call   801043a0 <memmove>
    name[len] = 0;
80101dce:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80101dd1:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101dd4:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101dd8:	89 d3                	mov    %edx,%ebx
80101dda:	e9 66 ff ff ff       	jmp    80101d45 <namex+0x95>
namex(char *path, int nameiparent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
80101ddf:	ba 01 00 00 00       	mov    $0x1,%edx
80101de4:	b8 01 00 00 00       	mov    $0x1,%eax
80101de9:	e8 f2 f2 ff ff       	call   801010e0 <iget>
80101dee:	89 c6                	mov    %eax,%esi
80101df0:	e9 ee fe ff ff       	jmp    80101ce3 <namex+0x33>
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
      iunlockput(ip);
80101df5:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101df8:	31 f6                	xor    %esi,%esi
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
      iunlockput(ip);
80101dfa:	e8 41 fb ff ff       	call   80101940 <iunlockput>
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101dff:	83 c4 2c             	add    $0x2c,%esp
80101e02:	89 f0                	mov    %esi,%eax
80101e04:	5b                   	pop    %ebx
80101e05:	5e                   	pop    %esi
80101e06:	5f                   	pop    %edi
80101e07:	5d                   	pop    %ebp
80101e08:	c3                   	ret    
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101e09:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101e0c:	85 c0                	test   %eax,%eax
80101e0e:	74 ef                	je     80101dff <namex+0x14f>
    iput(ip);
80101e10:	89 34 24             	mov    %esi,(%esp)
    return 0;
80101e13:	31 f6                	xor    %esi,%esi
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
    iput(ip);
80101e15:	e8 d6 f9 ff ff       	call   801017f0 <iput>
    return 0;
80101e1a:	eb e3                	jmp    80101dff <namex+0x14f>
80101e1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
80101e20:	e8 1b fb ff ff       	call   80101940 <iunlockput>
      return 0;
80101e25:	31 f6                	xor    %esi,%esi
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101e27:	83 c4 2c             	add    $0x2c,%esp
80101e2a:	5b                   	pop    %ebx
80101e2b:	89 f0                	mov    %esi,%eax
80101e2d:	5e                   	pop    %esi
80101e2e:	5f                   	pop    %edi
80101e2f:	5d                   	pop    %ebp
80101e30:	c3                   	ret    
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
80101e31:	89 34 24             	mov    %esi,(%esp)
80101e34:	e8 67 f9 ff ff       	call   801017a0 <iunlock>
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101e39:	83 c4 2c             	add    $0x2c,%esp
80101e3c:	89 f0                	mov    %esi,%eax
80101e3e:	5b                   	pop    %ebx
80101e3f:	5e                   	pop    %esi
80101e40:	5f                   	pop    %edi
80101e41:	5d                   	pop    %ebp
80101e42:	c3                   	ret    
80101e43:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101e50 <dirlink>:
}

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80101e50:	55                   	push   %ebp
80101e51:	89 e5                	mov    %esp,%ebp
80101e53:	57                   	push   %edi
80101e54:	56                   	push   %esi
80101e55:	53                   	push   %ebx
80101e56:	83 ec 2c             	sub    $0x2c,%esp
80101e59:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80101e5c:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e5f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80101e66:	00 
80101e67:	89 1c 24             	mov    %ebx,(%esp)
80101e6a:	89 44 24 04          	mov    %eax,0x4(%esp)
80101e6e:	e8 7d fd ff ff       	call   80101bf0 <dirlookup>
80101e73:	85 c0                	test   %eax,%eax
80101e75:	0f 85 89 00 00 00    	jne    80101f04 <dirlink+0xb4>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e7b:	8b 43 18             	mov    0x18(%ebx),%eax
80101e7e:	31 ff                	xor    %edi,%edi
80101e80:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e83:	85 c0                	test   %eax,%eax
80101e85:	75 11                	jne    80101e98 <dirlink+0x48>
80101e87:	eb 33                	jmp    80101ebc <dirlink+0x6c>
80101e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e90:	83 c7 10             	add    $0x10,%edi
80101e93:	39 7b 18             	cmp    %edi,0x18(%ebx)
80101e96:	76 24                	jbe    80101ebc <dirlink+0x6c>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e98:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80101e9f:	00 
80101ea0:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101ea4:	89 74 24 04          	mov    %esi,0x4(%esp)
80101ea8:	89 1c 24             	mov    %ebx,(%esp)
80101eab:	e8 e0 fa ff ff       	call   80101990 <readi>
80101eb0:	83 f8 10             	cmp    $0x10,%eax
80101eb3:	75 5e                	jne    80101f13 <dirlink+0xc3>
      panic("dirlink read");
    if(de.inum == 0)
80101eb5:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101eba:	75 d4                	jne    80101e90 <dirlink+0x40>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
80101ebc:	8b 45 0c             	mov    0xc(%ebp),%eax
80101ebf:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101ec6:	00 
80101ec7:	89 44 24 04          	mov    %eax,0x4(%esp)
80101ecb:	8d 45 da             	lea    -0x26(%ebp),%eax
80101ece:	89 04 24             	mov    %eax,(%esp)
80101ed1:	e8 ba 25 00 00       	call   80104490 <strncpy>
  de.inum = inum;
80101ed6:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ed9:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80101ee0:	00 
80101ee1:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101ee5:	89 74 24 04          	mov    %esi,0x4(%esp)
80101ee9:	89 1c 24             	mov    %ebx,(%esp)
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
80101eec:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ef0:	e8 9b fb ff ff       	call   80101a90 <writei>
80101ef5:	83 f8 10             	cmp    $0x10,%eax
80101ef8:	75 25                	jne    80101f1f <dirlink+0xcf>
    panic("dirlink");

  return 0;
80101efa:	31 c0                	xor    %eax,%eax
}
80101efc:	83 c4 2c             	add    $0x2c,%esp
80101eff:	5b                   	pop    %ebx
80101f00:	5e                   	pop    %esi
80101f01:	5f                   	pop    %edi
80101f02:	5d                   	pop    %ebp
80101f03:	c3                   	ret    
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
80101f04:	89 04 24             	mov    %eax,(%esp)
80101f07:	e8 e4 f8 ff ff       	call   801017f0 <iput>
    return -1;
80101f0c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f11:	eb e9                	jmp    80101efc <dirlink+0xac>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80101f13:	c7 04 24 32 6f 10 80 	movl   $0x80106f32,(%esp)
80101f1a:	e8 11 e4 ff ff       	call   80100330 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
80101f1f:	c7 04 24 02 75 10 80 	movl   $0x80107502,(%esp)
80101f26:	e8 05 e4 ff ff       	call   80100330 <panic>
80101f2b:	90                   	nop
80101f2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101f30 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
80101f30:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101f31:	31 d2                	xor    %edx,%edx
  return ip;
}

struct inode*
namei(char *path)
{
80101f33:	89 e5                	mov    %esp,%ebp
80101f35:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101f38:	8b 45 08             	mov    0x8(%ebp),%eax
80101f3b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101f3e:	e8 6d fd ff ff       	call   80101cb0 <namex>
}
80101f43:	c9                   	leave  
80101f44:	c3                   	ret    
80101f45:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f50 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101f50:	55                   	push   %ebp
  return namex(path, 1, name);
80101f51:	ba 01 00 00 00       	mov    $0x1,%edx
  return namex(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
80101f56:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101f58:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101f5b:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101f5e:	5d                   	pop    %ebp
}

struct inode*
nameiparent(char *path, char *name)
{
  return namex(path, 1, name);
80101f5f:	e9 4c fd ff ff       	jmp    80101cb0 <namex>
80101f64:	66 90                	xchg   %ax,%ax
80101f66:	66 90                	xchg   %ax,%ax
80101f68:	66 90                	xchg   %ax,%ax
80101f6a:	66 90                	xchg   %ax,%ax
80101f6c:	66 90                	xchg   %ax,%ax
80101f6e:	66 90                	xchg   %ax,%ax

80101f70 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101f70:	55                   	push   %ebp
80101f71:	89 c1                	mov    %eax,%ecx
80101f73:	89 e5                	mov    %esp,%ebp
80101f75:	56                   	push   %esi
80101f76:	53                   	push   %ebx
80101f77:	83 ec 10             	sub    $0x10,%esp
  if(b == 0)
80101f7a:	85 c0                	test   %eax,%eax
80101f7c:	0f 84 99 00 00 00    	je     8010201b <idestart+0xab>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101f82:	8b 58 08             	mov    0x8(%eax),%ebx
80101f85:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80101f8b:	0f 87 7e 00 00 00    	ja     8010200f <idestart+0x9f>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101f91:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101f96:	66 90                	xchg   %ax,%ax
80101f98:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101f99:	83 e0 c0             	and    $0xffffffc0,%eax
80101f9c:	3c 40                	cmp    $0x40,%al
80101f9e:	75 f8                	jne    80101f98 <idestart+0x28>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101fa0:	31 f6                	xor    %esi,%esi
80101fa2:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101fa7:	89 f0                	mov    %esi,%eax
80101fa9:	ee                   	out    %al,(%dx)
80101faa:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101faf:	b8 01 00 00 00       	mov    $0x1,%eax
80101fb4:	ee                   	out    %al,(%dx)
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
  }

  release(&idelock);
}
80101fb5:	0f b6 c3             	movzbl %bl,%eax
80101fb8:	b2 f3                	mov    $0xf3,%dl
80101fba:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80101fbb:	89 d8                	mov    %ebx,%eax
80101fbd:	b2 f4                	mov    $0xf4,%dl
80101fbf:	c1 f8 08             	sar    $0x8,%eax
80101fc2:	ee                   	out    %al,(%dx)
80101fc3:	b2 f5                	mov    $0xf5,%dl
80101fc5:	89 f0                	mov    %esi,%eax
80101fc7:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80101fc8:	8b 41 04             	mov    0x4(%ecx),%eax
80101fcb:	b2 f6                	mov    $0xf6,%dl
80101fcd:	83 e0 01             	and    $0x1,%eax
80101fd0:	c1 e0 04             	shl    $0x4,%eax
80101fd3:	83 c8 e0             	or     $0xffffffe0,%eax
80101fd6:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80101fd7:	f6 01 04             	testb  $0x4,(%ecx)
80101fda:	75 14                	jne    80101ff0 <idestart+0x80>
80101fdc:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101fe1:	b8 20 00 00 00       	mov    $0x20,%eax
80101fe6:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101fe7:	83 c4 10             	add    $0x10,%esp
80101fea:	5b                   	pop    %ebx
80101feb:	5e                   	pop    %esi
80101fec:	5d                   	pop    %ebp
80101fed:	c3                   	ret    
80101fee:	66 90                	xchg   %ax,%ax
80101ff0:	b2 f7                	mov    $0xf7,%dl
80101ff2:	b8 30 00 00 00       	mov    $0x30,%eax
80101ff7:	ee                   	out    %al,(%dx)
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
80101ff8:	ba f0 01 00 00       	mov    $0x1f0,%edx
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
80101ffd:	8d 71 18             	lea    0x18(%ecx),%esi
80102000:	b9 80 00 00 00       	mov    $0x80,%ecx
80102005:	fc                   	cld    
80102006:	f3 6f                	rep outsl %ds:(%esi),(%dx)
  } else {
    outb(0x1f7, read_cmd);
  }
}
80102008:	83 c4 10             	add    $0x10,%esp
8010200b:	5b                   	pop    %ebx
8010200c:	5e                   	pop    %esi
8010200d:	5d                   	pop    %ebp
8010200e:	c3                   	ret    
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
  if(b->blockno >= FSSIZE)
    panic("incorrect blockno");
8010200f:	c7 04 24 a5 6f 10 80 	movl   $0x80106fa5,(%esp)
80102016:	e8 15 e3 ff ff       	call   80100330 <panic>
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
8010201b:	c7 04 24 9c 6f 10 80 	movl   $0x80106f9c,(%esp)
80102022:	e8 09 e3 ff ff       	call   80100330 <panic>
80102027:	89 f6                	mov    %esi,%esi
80102029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102030 <ideinit>:
  return 0;
}

void
ideinit(void)
{
80102030:	55                   	push   %ebp
80102031:	89 e5                	mov    %esp,%ebp
80102033:	83 ec 18             	sub    $0x18,%esp
  int i;

  initlock(&idelock, "ide");
80102036:	c7 44 24 04 b7 6f 10 	movl   $0x80106fb7,0x4(%esp)
8010203d:	80 
8010203e:	c7 04 24 60 a5 10 80 	movl   $0x8010a560,(%esp)
80102045:	e8 a6 20 00 00       	call   801040f0 <initlock>
  picenable(IRQ_IDE);
8010204a:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
80102051:	e8 9a 11 00 00       	call   801031f0 <picenable>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102056:	a1 a0 18 11 80       	mov    0x801118a0,%eax
8010205b:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
80102062:	83 e8 01             	sub    $0x1,%eax
80102065:	89 44 24 04          	mov    %eax,0x4(%esp)
80102069:	e8 82 02 00 00       	call   801022f0 <ioapicenable>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010206e:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102073:	90                   	nop
80102074:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102078:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102079:	83 e0 c0             	and    $0xffffffc0,%eax
8010207c:	3c 40                	cmp    $0x40,%al
8010207e:	75 f8                	jne    80102078 <ideinit+0x48>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102080:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102085:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010208a:	ee                   	out    %al,(%dx)
8010208b:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102090:	b2 f7                	mov    $0xf7,%dl
80102092:	eb 09                	jmp    8010209d <ideinit+0x6d>
80102094:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
80102098:	83 e9 01             	sub    $0x1,%ecx
8010209b:	74 0f                	je     801020ac <ideinit+0x7c>
8010209d:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
8010209e:	84 c0                	test   %al,%al
801020a0:	74 f6                	je     80102098 <ideinit+0x68>
      havedisk1 = 1;
801020a2:	c7 05 94 a5 10 80 01 	movl   $0x1,0x8010a594
801020a9:	00 00 00 
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801020ac:	ba f6 01 00 00       	mov    $0x1f6,%edx
801020b1:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
801020b6:	ee                   	out    %al,(%dx)
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
801020b7:	c9                   	leave  
801020b8:	c3                   	ret    
801020b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801020c0 <ideintr>:
}

// Interrupt handler.
void
ideintr(void)
{
801020c0:	55                   	push   %ebp
801020c1:	89 e5                	mov    %esp,%ebp
801020c3:	57                   	push   %edi
801020c4:	56                   	push   %esi
801020c5:	53                   	push   %ebx
801020c6:	83 ec 1c             	sub    $0x1c,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801020c9:	c7 04 24 60 a5 10 80 	movl   $0x8010a560,(%esp)
801020d0:	e8 9b 20 00 00       	call   80104170 <acquire>
  if((b = idequeue) == 0){
801020d5:	8b 1d 98 a5 10 80    	mov    0x8010a598,%ebx
801020db:	85 db                	test   %ebx,%ebx
801020dd:	74 30                	je     8010210f <ideintr+0x4f>
    release(&idelock);
    // cprintf("spurious IDE interrupt\n");
    return;
  }
  idequeue = b->qnext;
801020df:	8b 43 14             	mov    0x14(%ebx),%eax
801020e2:	a3 98 a5 10 80       	mov    %eax,0x8010a598

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801020e7:	8b 33                	mov    (%ebx),%esi
801020e9:	f7 c6 04 00 00 00    	test   $0x4,%esi
801020ef:	74 37                	je     80102128 <ideintr+0x68>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801020f1:	83 e6 fb             	and    $0xfffffffb,%esi
801020f4:	83 ce 02             	or     $0x2,%esi
801020f7:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
801020f9:	89 1c 24             	mov    %ebx,(%esp)
801020fc:	e8 3f 1e 00 00       	call   80103f40 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102101:	a1 98 a5 10 80       	mov    0x8010a598,%eax
80102106:	85 c0                	test   %eax,%eax
80102108:	74 05                	je     8010210f <ideintr+0x4f>
    idestart(idequeue);
8010210a:	e8 61 fe ff ff       	call   80101f70 <idestart>
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
  if((b = idequeue) == 0){
    release(&idelock);
8010210f:	c7 04 24 60 a5 10 80 	movl   $0x8010a560,(%esp)
80102116:	e8 85 21 00 00       	call   801042a0 <release>
  // Start disk on next buf in queue.
  if(idequeue != 0)
    idestart(idequeue);

  release(&idelock);
}
8010211b:	83 c4 1c             	add    $0x1c,%esp
8010211e:	5b                   	pop    %ebx
8010211f:	5e                   	pop    %esi
80102120:	5f                   	pop    %edi
80102121:	5d                   	pop    %ebp
80102122:	c3                   	ret    
80102123:	90                   	nop
80102124:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102128:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010212d:	8d 76 00             	lea    0x0(%esi),%esi
80102130:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102131:	89 c1                	mov    %eax,%ecx
80102133:	83 e1 c0             	and    $0xffffffc0,%ecx
80102136:	80 f9 40             	cmp    $0x40,%cl
80102139:	75 f5                	jne    80102130 <ideintr+0x70>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010213b:	a8 21                	test   $0x21,%al
8010213d:	75 b2                	jne    801020f1 <ideintr+0x31>
  }
  idequeue = b->qnext;

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);
8010213f:	8d 7b 18             	lea    0x18(%ebx),%edi
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld; rep insl" :
80102142:	b9 80 00 00 00       	mov    $0x80,%ecx
80102147:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010214c:	fc                   	cld    
8010214d:	f3 6d                	rep insl (%dx),%es:(%edi)
8010214f:	8b 33                	mov    (%ebx),%esi
80102151:	eb 9e                	jmp    801020f1 <ideintr+0x31>
80102153:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102160 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102160:	55                   	push   %ebp
80102161:	89 e5                	mov    %esp,%ebp
80102163:	53                   	push   %ebx
80102164:	83 ec 14             	sub    $0x14,%esp
80102167:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!(b->flags & B_BUSY))
8010216a:	8b 03                	mov    (%ebx),%eax
8010216c:	a8 01                	test   $0x1,%al
8010216e:	0f 84 9f 00 00 00    	je     80102213 <iderw+0xb3>
    panic("iderw: buf not busy");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
80102174:	83 e0 06             	and    $0x6,%eax
80102177:	83 f8 02             	cmp    $0x2,%eax
8010217a:	0f 84 ab 00 00 00    	je     8010222b <iderw+0xcb>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
80102180:	8b 53 04             	mov    0x4(%ebx),%edx
80102183:	85 d2                	test   %edx,%edx
80102185:	74 0d                	je     80102194 <iderw+0x34>
80102187:	a1 94 a5 10 80       	mov    0x8010a594,%eax
8010218c:	85 c0                	test   %eax,%eax
8010218e:	0f 84 8b 00 00 00    	je     8010221f <iderw+0xbf>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102194:	c7 04 24 60 a5 10 80 	movl   $0x8010a560,(%esp)
8010219b:	e8 d0 1f 00 00       	call   80104170 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801021a0:	a1 98 a5 10 80       	mov    0x8010a598,%eax
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
801021a5:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801021ac:	85 c0                	test   %eax,%eax
801021ae:	75 0a                	jne    801021ba <iderw+0x5a>
801021b0:	eb 51                	jmp    80102203 <iderw+0xa3>
801021b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801021b8:	89 d0                	mov    %edx,%eax
801021ba:	8b 50 14             	mov    0x14(%eax),%edx
801021bd:	85 d2                	test   %edx,%edx
801021bf:	75 f7                	jne    801021b8 <iderw+0x58>
801021c1:	83 c0 14             	add    $0x14,%eax
    ;
  *pp = b;
801021c4:	89 18                	mov    %ebx,(%eax)

  // Start disk if necessary.
  if(idequeue == b)
801021c6:	39 1d 98 a5 10 80    	cmp    %ebx,0x8010a598
801021cc:	74 3c                	je     8010220a <iderw+0xaa>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021ce:	8b 03                	mov    (%ebx),%eax
801021d0:	83 e0 06             	and    $0x6,%eax
801021d3:	83 f8 02             	cmp    $0x2,%eax
801021d6:	74 1a                	je     801021f2 <iderw+0x92>
    sleep(b, &idelock);
801021d8:	c7 44 24 04 60 a5 10 	movl   $0x8010a560,0x4(%esp)
801021df:	80 
801021e0:	89 1c 24             	mov    %ebx,(%esp)
801021e3:	e8 b8 1b 00 00       	call   80103da0 <sleep>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021e8:	8b 13                	mov    (%ebx),%edx
801021ea:	83 e2 06             	and    $0x6,%edx
801021ed:	83 fa 02             	cmp    $0x2,%edx
801021f0:	75 e6                	jne    801021d8 <iderw+0x78>
    sleep(b, &idelock);
  }

  release(&idelock);
801021f2:	c7 45 08 60 a5 10 80 	movl   $0x8010a560,0x8(%ebp)
}
801021f9:	83 c4 14             	add    $0x14,%esp
801021fc:	5b                   	pop    %ebx
801021fd:	5d                   	pop    %ebp
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
  }

  release(&idelock);
801021fe:	e9 9d 20 00 00       	jmp    801042a0 <release>

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102203:	b8 98 a5 10 80       	mov    $0x8010a598,%eax
80102208:	eb ba                	jmp    801021c4 <iderw+0x64>
    ;
  *pp = b;

  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
8010220a:	89 d8                	mov    %ebx,%eax
8010220c:	e8 5f fd ff ff       	call   80101f70 <idestart>
80102211:	eb bb                	jmp    801021ce <iderw+0x6e>
iderw(struct buf *b)
{
  struct buf **pp;

  if(!(b->flags & B_BUSY))
    panic("iderw: buf not busy");
80102213:	c7 04 24 bb 6f 10 80 	movl   $0x80106fbb,(%esp)
8010221a:	e8 11 e1 ff ff       	call   80100330 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
    panic("iderw: ide disk 1 not present");
8010221f:	c7 04 24 e4 6f 10 80 	movl   $0x80106fe4,(%esp)
80102226:	e8 05 e1 ff ff       	call   80100330 <panic>
  struct buf **pp;

  if(!(b->flags & B_BUSY))
    panic("iderw: buf not busy");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
8010222b:	c7 04 24 cf 6f 10 80 	movl   $0x80106fcf,(%esp)
80102232:	e8 f9 e0 ff ff       	call   80100330 <panic>
80102237:	66 90                	xchg   %ax,%ax
80102239:	66 90                	xchg   %ax,%ax
8010223b:	66 90                	xchg   %ax,%ax
8010223d:	66 90                	xchg   %ax,%ax
8010223f:	90                   	nop

80102240 <ioapicinit>:
void
ioapicinit(void)
{
  int i, id, maxintr;

  if(!ismp)
80102240:	a1 a4 12 11 80       	mov    0x801112a4,%eax
80102245:	85 c0                	test   %eax,%eax
80102247:	0f 84 a1 00 00 00    	je     801022ee <ioapicinit+0xae>
  ioapic->data = data;
}

void
ioapicinit(void)
{
8010224d:	55                   	push   %ebp
8010224e:	89 e5                	mov    %esp,%ebp
80102250:	56                   	push   %esi
80102251:	53                   	push   %ebx

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
  return ioapic->data;
80102252:	bb 00 00 c0 fe       	mov    $0xfec00000,%ebx
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102257:	83 ec 10             	sub    $0x10,%esp
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010225a:	0f b6 15 a0 12 11 80 	movzbl 0x801112a0,%edx
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
80102261:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102268:	00 00 00 
  return ioapic->data;
8010226b:	8b 35 10 00 c0 fe    	mov    0xfec00010,%esi
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
80102271:	c7 05 00 00 c0 fe 00 	movl   $0x0,0xfec00000
80102278:	00 00 00 
  return ioapic->data;
8010227b:	a1 10 00 c0 fe       	mov    0xfec00010,%eax
  int i, id, maxintr;

  if(!ismp)
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102280:	c7 05 74 11 11 80 00 	movl   $0xfec00000,0x80111174
80102287:	00 c0 fe 
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
8010228a:	c1 ee 10             	shr    $0x10,%esi
  id = ioapicread(REG_ID) >> 24;
8010228d:	c1 e8 18             	shr    $0x18,%eax

  if(!ismp)
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102290:	81 e6 ff 00 00 00    	and    $0xff,%esi
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80102296:	39 c2                	cmp    %eax,%edx
80102298:	74 12                	je     801022ac <ioapicinit+0x6c>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
8010229a:	c7 04 24 04 70 10 80 	movl   $0x80107004,(%esp)
801022a1:	e8 5a e3 ff ff       	call   80100600 <cprintf>
801022a6:	8b 1d 74 11 11 80    	mov    0x80111174,%ebx
  ioapic->data = data;
}

void
ioapicinit(void)
{
801022ac:	ba 10 00 00 00       	mov    $0x10,%edx
801022b1:	31 c0                	xor    %eax,%eax
801022b3:	90                   	nop
801022b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801022b8:	89 13                	mov    %edx,(%ebx)
  ioapic->data = data;
801022ba:	8b 1d 74 11 11 80    	mov    0x80111174,%ebx
}

void
ioapicinit(void)
801022c0:	8d 48 20             	lea    0x20(%eax),%ecx
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801022c3:	81 c9 00 00 01 00    	or     $0x10000,%ecx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
801022c9:	83 c0 01             	add    $0x1,%eax

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
801022cc:	89 4b 10             	mov    %ecx,0x10(%ebx)
}

void
ioapicinit(void)
801022cf:	8d 4a 01             	lea    0x1(%edx),%ecx
801022d2:	83 c2 02             	add    $0x2,%edx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801022d5:	89 0b                	mov    %ecx,(%ebx)
  ioapic->data = data;
801022d7:	8b 1d 74 11 11 80    	mov    0x80111174,%ebx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
801022dd:	39 c6                	cmp    %eax,%esi

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
801022df:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
801022e6:	7d d0                	jge    801022b8 <ioapicinit+0x78>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801022e8:	83 c4 10             	add    $0x10,%esp
801022eb:	5b                   	pop    %ebx
801022ec:	5e                   	pop    %esi
801022ed:	5d                   	pop    %ebp
801022ee:	f3 c3                	repz ret 

801022f0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
  if(!ismp)
801022f0:	8b 15 a4 12 11 80    	mov    0x801112a4,%edx
  }
}

void
ioapicenable(int irq, int cpunum)
{
801022f6:	55                   	push   %ebp
801022f7:	89 e5                	mov    %esp,%ebp
801022f9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!ismp)
801022fc:	85 d2                	test   %edx,%edx
801022fe:	74 29                	je     80102329 <ioapicenable+0x39>
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102300:	8d 48 20             	lea    0x20(%eax),%ecx
80102303:	8d 54 00 10          	lea    0x10(%eax,%eax,1),%edx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102307:	a1 74 11 11 80       	mov    0x80111174,%eax
8010230c:	89 10                	mov    %edx,(%eax)
  ioapic->data = data;
8010230e:	a1 74 11 11 80       	mov    0x80111174,%eax

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102313:	83 c2 01             	add    $0x1,%edx

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
80102316:	89 48 10             	mov    %ecx,0x10(%eax)

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102319:	8b 4d 0c             	mov    0xc(%ebp),%ecx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010231c:	89 10                	mov    %edx,(%eax)
  ioapic->data = data;
8010231e:	a1 74 11 11 80       	mov    0x80111174,%eax

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102323:	c1 e1 18             	shl    $0x18,%ecx

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
80102326:	89 48 10             	mov    %ecx,0x10(%eax)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
80102329:	5d                   	pop    %ebp
8010232a:	c3                   	ret    
8010232b:	66 90                	xchg   %ax,%ax
8010232d:	66 90                	xchg   %ax,%ax
8010232f:	90                   	nop

80102330 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102330:	55                   	push   %ebp
80102331:	89 e5                	mov    %esp,%ebp
80102333:	53                   	push   %ebx
80102334:	83 ec 14             	sub    $0x14,%esp
80102337:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010233a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102340:	75 7c                	jne    801023be <kfree+0x8e>
80102342:	81 fb 48 40 11 80    	cmp    $0x80114048,%ebx
80102348:	72 74                	jb     801023be <kfree+0x8e>
8010234a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102350:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102355:	77 67                	ja     801023be <kfree+0x8e>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102357:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
8010235e:	00 
8010235f:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80102366:	00 
80102367:	89 1c 24             	mov    %ebx,(%esp)
8010236a:	e8 81 1f 00 00       	call   801042f0 <memset>

  if(kmem.use_lock)
8010236f:	8b 15 b4 11 11 80    	mov    0x801111b4,%edx
80102375:	85 d2                	test   %edx,%edx
80102377:	75 37                	jne    801023b0 <kfree+0x80>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102379:	a1 b8 11 11 80       	mov    0x801111b8,%eax
8010237e:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
80102380:	a1 b4 11 11 80       	mov    0x801111b4,%eax

  if(kmem.use_lock)
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
80102385:	89 1d b8 11 11 80    	mov    %ebx,0x801111b8
  if(kmem.use_lock)
8010238b:	85 c0                	test   %eax,%eax
8010238d:	75 09                	jne    80102398 <kfree+0x68>
    release(&kmem.lock);
}
8010238f:	83 c4 14             	add    $0x14,%esp
80102392:	5b                   	pop    %ebx
80102393:	5d                   	pop    %ebp
80102394:	c3                   	ret    
80102395:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
80102398:	c7 45 08 80 11 11 80 	movl   $0x80111180,0x8(%ebp)
}
8010239f:	83 c4 14             	add    $0x14,%esp
801023a2:	5b                   	pop    %ebx
801023a3:	5d                   	pop    %ebp
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
801023a4:	e9 f7 1e 00 00       	jmp    801042a0 <release>
801023a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if(kmem.use_lock)
    acquire(&kmem.lock);
801023b0:	c7 04 24 80 11 11 80 	movl   $0x80111180,(%esp)
801023b7:	e8 b4 1d 00 00       	call   80104170 <acquire>
801023bc:	eb bb                	jmp    80102379 <kfree+0x49>
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
801023be:	c7 04 24 36 70 10 80 	movl   $0x80107036,(%esp)
801023c5:	e8 66 df ff ff       	call   80100330 <panic>
801023ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801023d0 <freerange>:
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
801023d0:	55                   	push   %ebp
801023d1:	89 e5                	mov    %esp,%ebp
801023d3:	56                   	push   %esi
801023d4:	53                   	push   %ebx
801023d5:	83 ec 10             	sub    $0x10,%esp
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801023d8:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
801023db:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801023de:	05 ff 0f 00 00       	add    $0xfff,%eax
801023e3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023e8:	8d 98 00 10 00 00    	lea    0x1000(%eax),%ebx
801023ee:	39 de                	cmp    %ebx,%esi
801023f0:	72 1a                	jb     8010240c <freerange+0x3c>
801023f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    kfree(p);
801023f8:	89 04 24             	mov    %eax,(%esp)
801023fb:	e8 30 ff ff ff       	call   80102330 <kfree>
80102400:	89 d8                	mov    %ebx,%eax
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102402:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102408:	39 f3                	cmp    %esi,%ebx
8010240a:	76 ec                	jbe    801023f8 <freerange+0x28>
    kfree(p);
}
8010240c:	83 c4 10             	add    $0x10,%esp
8010240f:	5b                   	pop    %ebx
80102410:	5e                   	pop    %esi
80102411:	5d                   	pop    %ebp
80102412:	c3                   	ret    
80102413:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102420 <kinit2>:
  freerange(vstart, vend);
}

void
kinit2(void *vstart, void *vend)
{
80102420:	55                   	push   %ebp
80102421:	89 e5                	mov    %esp,%ebp
80102423:	83 ec 18             	sub    $0x18,%esp
  freerange(vstart, vend);
80102426:	8b 45 0c             	mov    0xc(%ebp),%eax
80102429:	89 44 24 04          	mov    %eax,0x4(%esp)
8010242d:	8b 45 08             	mov    0x8(%ebp),%eax
80102430:	89 04 24             	mov    %eax,(%esp)
80102433:	e8 98 ff ff ff       	call   801023d0 <freerange>
  kmem.use_lock = 1;
80102438:	c7 05 b4 11 11 80 01 	movl   $0x1,0x801111b4
8010243f:	00 00 00 
}
80102442:	c9                   	leave  
80102443:	c3                   	ret    
80102444:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010244a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80102450 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
80102450:	55                   	push   %ebp
80102451:	89 e5                	mov    %esp,%ebp
80102453:	83 ec 18             	sub    $0x18,%esp
80102456:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80102459:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010245c:	89 75 fc             	mov    %esi,-0x4(%ebp)
8010245f:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102462:	c7 44 24 04 3c 70 10 	movl   $0x8010703c,0x4(%esp)
80102469:	80 
8010246a:	c7 04 24 80 11 11 80 	movl   $0x80111180,(%esp)
80102471:	e8 7a 1c 00 00       	call   801040f0 <initlock>
  kmem.use_lock = 0;
  freerange(vstart, vend);
80102476:	89 75 0c             	mov    %esi,0xc(%ebp)
}
80102479:	8b 75 fc             	mov    -0x4(%ebp),%esi
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
8010247c:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010247f:	8b 5d f8             	mov    -0x8(%ebp),%ebx
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
80102482:	c7 05 b4 11 11 80 00 	movl   $0x0,0x801111b4
80102489:	00 00 00 
  freerange(vstart, vend);
}
8010248c:	89 ec                	mov    %ebp,%esp
8010248e:	5d                   	pop    %ebp
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
8010248f:	e9 3c ff ff ff       	jmp    801023d0 <freerange>
80102494:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010249a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801024a0 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
801024a0:	55                   	push   %ebp
  struct run *r;

  if(kmem.use_lock)
801024a1:	31 c0                	xor    %eax,%eax
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
801024a3:	89 e5                	mov    %esp,%ebp
801024a5:	53                   	push   %ebx
801024a6:	83 ec 14             	sub    $0x14,%esp
  struct run *r;

  if(kmem.use_lock)
801024a9:	8b 15 b4 11 11 80    	mov    0x801111b4,%edx
801024af:	85 d2                	test   %edx,%edx
801024b1:	75 2d                	jne    801024e0 <kalloc+0x40>
    acquire(&kmem.lock);
  r = kmem.freelist;
801024b3:	8b 1d b8 11 11 80    	mov    0x801111b8,%ebx
  if(r)
801024b9:	85 db                	test   %ebx,%ebx
801024bb:	74 08                	je     801024c5 <kalloc+0x25>
    kmem.freelist = r->next;
801024bd:	8b 13                	mov    (%ebx),%edx
801024bf:	89 15 b8 11 11 80    	mov    %edx,0x801111b8
  if(kmem.use_lock)
801024c5:	85 c0                	test   %eax,%eax
801024c7:	74 0c                	je     801024d5 <kalloc+0x35>
    release(&kmem.lock);
801024c9:	c7 04 24 80 11 11 80 	movl   $0x80111180,(%esp)
801024d0:	e8 cb 1d 00 00       	call   801042a0 <release>
  return (char*)r;
}
801024d5:	83 c4 14             	add    $0x14,%esp
801024d8:	89 d8                	mov    %ebx,%eax
801024da:	5b                   	pop    %ebx
801024db:	5d                   	pop    %ebp
801024dc:	c3                   	ret    
801024dd:	8d 76 00             	lea    0x0(%esi),%esi
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
    acquire(&kmem.lock);
801024e0:	c7 04 24 80 11 11 80 	movl   $0x80111180,(%esp)
801024e7:	e8 84 1c 00 00       	call   80104170 <acquire>
801024ec:	a1 b4 11 11 80       	mov    0x801111b4,%eax
801024f1:	eb c0                	jmp    801024b3 <kalloc+0x13>
801024f3:	66 90                	xchg   %ax,%ax
801024f5:	66 90                	xchg   %ax,%ax
801024f7:	66 90                	xchg   %ax,%ax
801024f9:	66 90                	xchg   %ax,%ax
801024fb:	66 90                	xchg   %ax,%ax
801024fd:	66 90                	xchg   %ax,%ax
801024ff:	90                   	nop

80102500 <kbdgetc>:
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102500:	ba 64 00 00 00       	mov    $0x64,%edx
80102505:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102506:	a8 01                	test   $0x1,%al
80102508:	0f 84 ba 00 00 00    	je     801025c8 <kbdgetc+0xc8>
8010250e:	b2 60                	mov    $0x60,%dl
80102510:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102511:	0f b6 c8             	movzbl %al,%ecx

  if(data == 0xE0){
80102514:	81 f9 e0 00 00 00    	cmp    $0xe0,%ecx
8010251a:	0f 84 88 00 00 00    	je     801025a8 <kbdgetc+0xa8>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102520:	84 c0                	test   %al,%al
80102522:	79 2c                	jns    80102550 <kbdgetc+0x50>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102524:	8b 15 9c a5 10 80    	mov    0x8010a59c,%edx
8010252a:	f6 c2 40             	test   $0x40,%dl
8010252d:	75 05                	jne    80102534 <kbdgetc+0x34>
8010252f:	89 c1                	mov    %eax,%ecx
80102531:	83 e1 7f             	and    $0x7f,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
80102534:	0f b6 81 60 70 10 80 	movzbl -0x7fef8fa0(%ecx),%eax
8010253b:	83 c8 40             	or     $0x40,%eax
8010253e:	0f b6 c0             	movzbl %al,%eax
80102541:	f7 d0                	not    %eax
80102543:	21 d0                	and    %edx,%eax
80102545:	a3 9c a5 10 80       	mov    %eax,0x8010a59c
    return 0;
8010254a:	31 c0                	xor    %eax,%eax
8010254c:	c3                   	ret    
8010254d:	8d 76 00             	lea    0x0(%esi),%esi
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102550:	55                   	push   %ebp
80102551:	89 e5                	mov    %esp,%ebp
80102553:	53                   	push   %ebx
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102554:	8b 1d 9c a5 10 80    	mov    0x8010a59c,%ebx
8010255a:	f6 c3 40             	test   $0x40,%bl
8010255d:	74 09                	je     80102568 <kbdgetc+0x68>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010255f:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102562:	83 e3 bf             	and    $0xffffffbf,%ebx
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102565:	0f b6 c8             	movzbl %al,%ecx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
80102568:	0f b6 91 60 70 10 80 	movzbl -0x7fef8fa0(%ecx),%edx
  shift ^= togglecode[data];
8010256f:	0f b6 81 60 71 10 80 	movzbl -0x7fef8ea0(%ecx),%eax
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
80102576:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
80102578:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010257a:	89 d0                	mov    %edx,%eax
8010257c:	83 e0 03             	and    $0x3,%eax
8010257f:	8b 04 85 60 72 10 80 	mov    -0x7fef8da0(,%eax,4),%eax
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
80102586:	89 15 9c a5 10 80    	mov    %edx,0x8010a59c
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
8010258c:	83 e2 08             	and    $0x8,%edx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
8010258f:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
80102593:	74 0b                	je     801025a0 <kbdgetc+0xa0>
    if('a' <= c && c <= 'z')
80102595:	8d 50 9f             	lea    -0x61(%eax),%edx
80102598:	83 fa 19             	cmp    $0x19,%edx
8010259b:	77 1b                	ja     801025b8 <kbdgetc+0xb8>
      c += 'A' - 'a';
8010259d:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801025a0:	5b                   	pop    %ebx
801025a1:	5d                   	pop    %ebp
801025a2:	c3                   	ret    
801025a3:	90                   	nop
801025a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
801025a8:	83 0d 9c a5 10 80 40 	orl    $0x40,0x8010a59c
    return 0;
801025af:	31 c0                	xor    %eax,%eax
801025b1:	c3                   	ret    
801025b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
801025b8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801025bb:	8d 50 20             	lea    0x20(%eax),%edx
801025be:	83 f9 19             	cmp    $0x19,%ecx
801025c1:	0f 46 c2             	cmovbe %edx,%eax
  }
  return c;
801025c4:	eb da                	jmp    801025a0 <kbdgetc+0xa0>
801025c6:	66 90                	xchg   %ax,%ax
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
    return -1;
801025c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801025cd:	c3                   	ret    
801025ce:	66 90                	xchg   %ax,%ax

801025d0 <kbdintr>:
  return c;
}

void
kbdintr(void)
{
801025d0:	55                   	push   %ebp
801025d1:	89 e5                	mov    %esp,%ebp
801025d3:	83 ec 18             	sub    $0x18,%esp
  consoleintr(kbdgetc);
801025d6:	c7 04 24 00 25 10 80 	movl   $0x80102500,(%esp)
801025dd:	e8 7e e1 ff ff       	call   80100760 <consoleintr>
}
801025e2:	c9                   	leave  
801025e3:	c3                   	ret    
801025e4:	66 90                	xchg   %ax,%ax
801025e6:	66 90                	xchg   %ax,%ax
801025e8:	66 90                	xchg   %ax,%ax
801025ea:	66 90                	xchg   %ax,%ax
801025ec:	66 90                	xchg   %ax,%ax
801025ee:	66 90                	xchg   %ax,%ax

801025f0 <fill_rtcdate>:

  return inb(CMOS_RETURN);
}

static void fill_rtcdate(struct rtcdate *r)
{
801025f0:	55                   	push   %ebp
801025f1:	89 c1                	mov    %eax,%ecx
801025f3:	89 e5                	mov    %esp,%ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801025f5:	ba 70 00 00 00       	mov    $0x70,%edx
801025fa:	53                   	push   %ebx
801025fb:	31 c0                	xor    %eax,%eax
801025fd:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801025fe:	bb 71 00 00 00       	mov    $0x71,%ebx
80102603:	89 da                	mov    %ebx,%edx
80102605:	ec                   	in     (%dx),%al
static uint cmos_read(uint reg)
{
  outb(CMOS_PORT,  reg);
  microdelay(200);

  return inb(CMOS_RETURN);
80102606:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102609:	b2 70                	mov    $0x70,%dl
8010260b:	89 01                	mov    %eax,(%ecx)
8010260d:	b8 02 00 00 00       	mov    $0x2,%eax
80102612:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102613:	89 da                	mov    %ebx,%edx
80102615:	ec                   	in     (%dx),%al
80102616:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102619:	b2 70                	mov    $0x70,%dl
8010261b:	89 41 04             	mov    %eax,0x4(%ecx)
8010261e:	b8 04 00 00 00       	mov    $0x4,%eax
80102623:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102624:	89 da                	mov    %ebx,%edx
80102626:	ec                   	in     (%dx),%al
80102627:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010262a:	b2 70                	mov    $0x70,%dl
8010262c:	89 41 08             	mov    %eax,0x8(%ecx)
8010262f:	b8 07 00 00 00       	mov    $0x7,%eax
80102634:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102635:	89 da                	mov    %ebx,%edx
80102637:	ec                   	in     (%dx),%al
80102638:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010263b:	b2 70                	mov    $0x70,%dl
8010263d:	89 41 0c             	mov    %eax,0xc(%ecx)
80102640:	b8 08 00 00 00       	mov    $0x8,%eax
80102645:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102646:	89 da                	mov    %ebx,%edx
80102648:	ec                   	in     (%dx),%al
80102649:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010264c:	b2 70                	mov    $0x70,%dl
8010264e:	89 41 10             	mov    %eax,0x10(%ecx)
80102651:	b8 09 00 00 00       	mov    $0x9,%eax
80102656:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102657:	89 da                	mov    %ebx,%edx
80102659:	ec                   	in     (%dx),%al
8010265a:	0f b6 d8             	movzbl %al,%ebx
8010265d:	89 59 14             	mov    %ebx,0x14(%ecx)
  r->minute = cmos_read(MINS);
  r->hour   = cmos_read(HOURS);
  r->day    = cmos_read(DAY);
  r->month  = cmos_read(MONTH);
  r->year   = cmos_read(YEAR);
}
80102660:	5b                   	pop    %ebx
80102661:	5d                   	pop    %ebp
80102662:	c3                   	ret    
80102663:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102670 <lapicinit>:
//PAGEBREAK!

void
lapicinit(void)
{
  if(!lapic)
80102670:	a1 bc 11 11 80       	mov    0x801111bc,%eax
}
//PAGEBREAK!

void
lapicinit(void)
{
80102675:	55                   	push   %ebp
80102676:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102678:	85 c0                	test   %eax,%eax
8010267a:	0f 84 c0 00 00 00    	je     80102740 <lapicinit+0xd0>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102680:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102687:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010268a:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010268d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102694:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102697:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010269a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
801026a1:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
801026a4:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026a7:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
801026ae:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
801026b1:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026b4:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
801026bb:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801026be:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026c1:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
801026c8:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801026cb:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801026ce:	8b 50 30             	mov    0x30(%eax),%edx
801026d1:	c1 ea 10             	shr    $0x10,%edx
801026d4:	80 fa 03             	cmp    $0x3,%dl
801026d7:	77 6f                	ja     80102748 <lapicinit+0xd8>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026d9:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801026e0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026e3:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026e6:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026ed:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026f0:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026f3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026fa:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026fd:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102700:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102707:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010270a:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010270d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102714:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102717:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010271a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102721:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102724:	8b 50 20             	mov    0x20(%eax),%edx
80102727:	90                   	nop
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102728:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
8010272e:	80 e6 10             	and    $0x10,%dh
80102731:	75 f5                	jne    80102728 <lapicinit+0xb8>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102733:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
8010273a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010273d:	8b 40 20             	mov    0x20(%eax),%eax
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102740:	5d                   	pop    %ebp
80102741:	c3                   	ret    
80102742:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102748:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
8010274f:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102752:	8b 50 20             	mov    0x20(%eax),%edx
80102755:	eb 82                	jmp    801026d9 <lapicinit+0x69>
80102757:	89 f6                	mov    %esi,%esi
80102759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102760 <cpunum>:
  lapicw(TPR, 0);
}

int
cpunum(void)
{
80102760:	55                   	push   %ebp
80102761:	89 e5                	mov    %esp,%ebp
80102763:	56                   	push   %esi
80102764:	53                   	push   %ebx
80102765:	83 ec 10             	sub    $0x10,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80102768:	9c                   	pushf  
80102769:	58                   	pop    %eax
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
8010276a:	f6 c4 02             	test   $0x2,%ah
8010276d:	74 12                	je     80102781 <cpunum+0x21>
    static int n;
    if(n++ == 0)
8010276f:	a1 a0 a5 10 80       	mov    0x8010a5a0,%eax
80102774:	8d 50 01             	lea    0x1(%eax),%edx
80102777:	85 c0                	test   %eax,%eax
80102779:	89 15 a0 a5 10 80    	mov    %edx,0x8010a5a0
8010277f:	74 4a                	je     801027cb <cpunum+0x6b>
      cprintf("cpu called from %x with interrupts enabled\n",
        __builtin_return_address(0));
  }

  if (!lapic)
80102781:	a1 bc 11 11 80       	mov    0x801111bc,%eax
80102786:	85 c0                	test   %eax,%eax
80102788:	74 5d                	je     801027e7 <cpunum+0x87>
    return 0;

  apicid = lapic[ID] >> 24;
8010278a:	8b 58 20             	mov    0x20(%eax),%ebx
  for (i = 0; i < ncpu; ++i) {
8010278d:	8b 35 a0 18 11 80    	mov    0x801118a0,%esi
  }

  if (!lapic)
    return 0;

  apicid = lapic[ID] >> 24;
80102793:	c1 eb 18             	shr    $0x18,%ebx
  for (i = 0; i < ncpu; ++i) {
80102796:	85 f6                	test   %esi,%esi
80102798:	7e 56                	jle    801027f0 <cpunum+0x90>
    if (cpus[i].apicid == apicid)
8010279a:	0f b6 05 c0 12 11 80 	movzbl 0x801112c0,%eax
801027a1:	39 d8                	cmp    %ebx,%eax
801027a3:	74 42                	je     801027e7 <cpunum+0x87>
801027a5:	ba 7c 13 11 80       	mov    $0x8011137c,%edx

  if (!lapic)
    return 0;

  apicid = lapic[ID] >> 24;
  for (i = 0; i < ncpu; ++i) {
801027aa:	31 c0                	xor    %eax,%eax
801027ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801027b0:	83 c0 01             	add    $0x1,%eax
801027b3:	39 f0                	cmp    %esi,%eax
801027b5:	74 39                	je     801027f0 <cpunum+0x90>
    if (cpus[i].apicid == apicid)
801027b7:	0f b6 0a             	movzbl (%edx),%ecx
801027ba:	81 c2 bc 00 00 00    	add    $0xbc,%edx
801027c0:	39 d9                	cmp    %ebx,%ecx
801027c2:	75 ec                	jne    801027b0 <cpunum+0x50>
      return i;
  }
  panic("unknown apicid\n");
}
801027c4:	83 c4 10             	add    $0x10,%esp
801027c7:	5b                   	pop    %ebx
801027c8:	5e                   	pop    %esi
801027c9:	5d                   	pop    %ebp
801027ca:	c3                   	ret    
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
    static int n;
    if(n++ == 0)
      cprintf("cpu called from %x with interrupts enabled\n",
801027cb:	8b 45 04             	mov    0x4(%ebp),%eax
801027ce:	c7 04 24 70 72 10 80 	movl   $0x80107270,(%esp)
801027d5:	89 44 24 04          	mov    %eax,0x4(%esp)
801027d9:	e8 22 de ff ff       	call   80100600 <cprintf>
        __builtin_return_address(0));
  }

  if (!lapic)
801027de:	a1 bc 11 11 80       	mov    0x801111bc,%eax
801027e3:	85 c0                	test   %eax,%eax
801027e5:	75 a3                	jne    8010278a <cpunum+0x2a>
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return i;
  }
  panic("unknown apicid\n");
}
801027e7:	83 c4 10             	add    $0x10,%esp
      cprintf("cpu called from %x with interrupts enabled\n",
        __builtin_return_address(0));
  }

  if (!lapic)
    return 0;
801027ea:	31 c0                	xor    %eax,%eax
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return i;
  }
  panic("unknown apicid\n");
}
801027ec:	5b                   	pop    %ebx
801027ed:	5e                   	pop    %esi
801027ee:	5d                   	pop    %ebp
801027ef:	c3                   	ret    
  apicid = lapic[ID] >> 24;
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return i;
  }
  panic("unknown apicid\n");
801027f0:	c7 04 24 9c 72 10 80 	movl   $0x8010729c,(%esp)
801027f7:	e8 34 db ff ff       	call   80100330 <panic>
801027fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102800 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102800:	a1 bc 11 11 80       	mov    0x801111bc,%eax
}

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102805:	55                   	push   %ebp
80102806:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102808:	85 c0                	test   %eax,%eax
8010280a:	74 0d                	je     80102819 <lapiceoi+0x19>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010280c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102813:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102816:	8b 40 20             	mov    0x20(%eax),%eax
void
lapiceoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
}
80102819:	5d                   	pop    %ebp
8010281a:	c3                   	ret    
8010281b:	90                   	nop
8010281c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102820 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102820:	55                   	push   %ebp
80102821:	89 e5                	mov    %esp,%ebp
}
80102823:	5d                   	pop    %ebp
80102824:	c3                   	ret    
80102825:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102830 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102830:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102831:	ba 70 00 00 00       	mov    $0x70,%edx
80102836:	89 e5                	mov    %esp,%ebp
80102838:	b8 0f 00 00 00       	mov    $0xf,%eax
8010283d:	53                   	push   %ebx
8010283e:	0f b6 4d 08          	movzbl 0x8(%ebp),%ecx
80102842:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80102845:	ee                   	out    %al,(%dx)
80102846:	b8 0a 00 00 00       	mov    $0xa,%eax
8010284b:	b2 71                	mov    $0x71,%dl
8010284d:	ee                   	out    %al,(%dx)
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
8010284e:	89 d8                	mov    %ebx,%eax
80102850:	c1 e8 04             	shr    $0x4,%eax
80102853:	66 a3 69 04 00 80    	mov    %ax,0x80000469
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102859:	a1 bc 11 11 80       	mov    0x801111bc,%eax
  wrv[0] = 0;
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
8010285e:	c1 e1 18             	shl    $0x18,%ecx
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102861:	66 c7 05 67 04 00 80 	movw   $0x0,0x80000467
80102868:	00 00 
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010286a:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102870:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102873:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
8010287a:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010287d:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102880:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102887:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010288a:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010288d:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102893:	8b 50 20             	mov    0x20(%eax),%edx
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102896:	89 da                	mov    %ebx,%edx
80102898:	c1 ea 0c             	shr    $0xc,%edx
8010289b:	80 ce 06             	or     $0x6,%dh
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010289e:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028a4:	8b 58 20             	mov    0x20(%eax),%ebx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028a7:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028ad:	8b 48 20             	mov    0x20(%eax),%ecx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028b0:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028b6:	8b 40 20             	mov    0x20(%eax),%eax
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
801028b9:	5b                   	pop    %ebx
801028ba:	5d                   	pop    %ebp
801028bb:	c3                   	ret    
801028bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801028c0 <cmostime>:
  r->year   = cmos_read(YEAR);
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
801028c0:	55                   	push   %ebp
801028c1:	ba 70 00 00 00       	mov    $0x70,%edx
801028c6:	89 e5                	mov    %esp,%ebp
801028c8:	b8 0b 00 00 00       	mov    $0xb,%eax
801028cd:	57                   	push   %edi
801028ce:	56                   	push   %esi
801028cf:	53                   	push   %ebx
801028d0:	83 ec 5c             	sub    $0x5c,%esp
801028d3:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028d4:	b2 71                	mov    $0x71,%dl
801028d6:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
801028d7:	83 e0 04             	and    $0x4,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028da:	be 0a 00 00 00       	mov    $0xa,%esi
801028df:	88 45 b7             	mov    %al,-0x49(%ebp)
801028e2:	8d 5d b8             	lea    -0x48(%ebp),%ebx
801028e5:	8d 7d d0             	lea    -0x30(%ebp),%edi

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
801028e8:	89 d8                	mov    %ebx,%eax
801028ea:	e8 01 fd ff ff       	call   801025f0 <fill_rtcdate>
801028ef:	89 f0                	mov    %esi,%eax
801028f1:	ba 70 00 00 00       	mov    $0x70,%edx
801028f6:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028f7:	b2 71                	mov    $0x71,%dl
801028f9:	ec                   	in     (%dx),%al
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
801028fa:	84 c0                	test   %al,%al
801028fc:	78 ea                	js     801028e8 <cmostime+0x28>
        continue;
    fill_rtcdate(&t2);
801028fe:	89 f8                	mov    %edi,%eax
80102900:	e8 eb fc ff ff       	call   801025f0 <fill_rtcdate>
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102905:	c7 44 24 08 18 00 00 	movl   $0x18,0x8(%esp)
8010290c:	00 
8010290d:	89 7c 24 04          	mov    %edi,0x4(%esp)
80102911:	89 1c 24             	mov    %ebx,(%esp)
80102914:	e8 37 1a 00 00       	call   80104350 <memcmp>
80102919:	85 c0                	test   %eax,%eax
8010291b:	75 cb                	jne    801028e8 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
8010291d:	80 7d b7 00          	cmpb   $0x0,-0x49(%ebp)
80102921:	75 78                	jne    8010299b <cmostime+0xdb>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102923:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102926:	89 c2                	mov    %eax,%edx
80102928:	83 e0 0f             	and    $0xf,%eax
8010292b:	c1 ea 04             	shr    $0x4,%edx
8010292e:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102931:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102934:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102937:	8b 45 bc             	mov    -0x44(%ebp),%eax
8010293a:	89 c2                	mov    %eax,%edx
8010293c:	83 e0 0f             	and    $0xf,%eax
8010293f:	c1 ea 04             	shr    $0x4,%edx
80102942:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102945:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102948:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
8010294b:	8b 45 c0             	mov    -0x40(%ebp),%eax
8010294e:	89 c2                	mov    %eax,%edx
80102950:	83 e0 0f             	and    $0xf,%eax
80102953:	c1 ea 04             	shr    $0x4,%edx
80102956:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102959:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010295c:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
8010295f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102962:	89 c2                	mov    %eax,%edx
80102964:	83 e0 0f             	and    $0xf,%eax
80102967:	c1 ea 04             	shr    $0x4,%edx
8010296a:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010296d:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102970:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102973:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102976:	89 c2                	mov    %eax,%edx
80102978:	83 e0 0f             	and    $0xf,%eax
8010297b:	c1 ea 04             	shr    $0x4,%edx
8010297e:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102981:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102984:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102987:	8b 45 cc             	mov    -0x34(%ebp),%eax
8010298a:	89 c2                	mov    %eax,%edx
8010298c:	83 e0 0f             	and    $0xf,%eax
8010298f:	c1 ea 04             	shr    $0x4,%edx
80102992:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102995:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102998:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
8010299b:	8b 55 08             	mov    0x8(%ebp),%edx
8010299e:	8b 45 b8             	mov    -0x48(%ebp),%eax
801029a1:	89 02                	mov    %eax,(%edx)
801029a3:	8b 45 bc             	mov    -0x44(%ebp),%eax
801029a6:	89 42 04             	mov    %eax,0x4(%edx)
801029a9:	8b 45 c0             	mov    -0x40(%ebp),%eax
801029ac:	89 42 08             	mov    %eax,0x8(%edx)
801029af:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801029b2:	89 42 0c             	mov    %eax,0xc(%edx)
801029b5:	8b 45 c8             	mov    -0x38(%ebp),%eax
801029b8:	89 42 10             	mov    %eax,0x10(%edx)
801029bb:	8b 45 cc             	mov    -0x34(%ebp),%eax
801029be:	89 42 14             	mov    %eax,0x14(%edx)
  r->year += 2000;
801029c1:	81 42 14 d0 07 00 00 	addl   $0x7d0,0x14(%edx)
}
801029c8:	83 c4 5c             	add    $0x5c,%esp
801029cb:	5b                   	pop    %ebx
801029cc:	5e                   	pop    %esi
801029cd:	5f                   	pop    %edi
801029ce:	5d                   	pop    %ebp
801029cf:	c3                   	ret    

801029d0 <install_trans>:
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
801029d0:	55                   	push   %ebp
801029d1:	89 e5                	mov    %esp,%ebp
801029d3:	57                   	push   %edi
801029d4:	56                   	push   %esi
801029d5:	53                   	push   %ebx
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801029d6:	31 db                	xor    %ebx,%ebx
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
801029d8:	83 ec 1c             	sub    $0x1c,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801029db:	a1 08 12 11 80       	mov    0x80111208,%eax
801029e0:	85 c0                	test   %eax,%eax
801029e2:	7e 78                	jle    80102a5c <install_trans+0x8c>
801029e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
801029e8:	a1 f4 11 11 80       	mov    0x801111f4,%eax
801029ed:	01 d8                	add    %ebx,%eax
801029ef:	83 c0 01             	add    $0x1,%eax
801029f2:	89 44 24 04          	mov    %eax,0x4(%esp)
801029f6:	a1 04 12 11 80       	mov    0x80111204,%eax
801029fb:	89 04 24             	mov    %eax,(%esp)
801029fe:	e8 bd d6 ff ff       	call   801000c0 <bread>
80102a03:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a05:	8b 04 9d 0c 12 11 80 	mov    -0x7feeedf4(,%ebx,4),%eax
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a0c:	83 c3 01             	add    $0x1,%ebx
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a0f:	89 44 24 04          	mov    %eax,0x4(%esp)
80102a13:	a1 04 12 11 80       	mov    0x80111204,%eax
80102a18:	89 04 24             	mov    %eax,(%esp)
80102a1b:	e8 a0 d6 ff ff       	call   801000c0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102a20:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80102a27:	00 
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a28:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102a2a:	8d 47 18             	lea    0x18(%edi),%eax
80102a2d:	89 44 24 04          	mov    %eax,0x4(%esp)
80102a31:	8d 46 18             	lea    0x18(%esi),%eax
80102a34:	89 04 24             	mov    %eax,(%esp)
80102a37:	e8 64 19 00 00       	call   801043a0 <memmove>
    bwrite(dbuf);  // write dst to disk
80102a3c:	89 34 24             	mov    %esi,(%esp)
80102a3f:	e8 4c d7 ff ff       	call   80100190 <bwrite>
    brelse(lbuf);
80102a44:	89 3c 24             	mov    %edi,(%esp)
80102a47:	e8 74 d7 ff ff       	call   801001c0 <brelse>
    brelse(dbuf);
80102a4c:	89 34 24             	mov    %esi,(%esp)
80102a4f:	e8 6c d7 ff ff       	call   801001c0 <brelse>
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a54:	39 1d 08 12 11 80    	cmp    %ebx,0x80111208
80102a5a:	7f 8c                	jg     801029e8 <install_trans+0x18>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf);
    brelse(dbuf);
  }
}
80102a5c:	83 c4 1c             	add    $0x1c,%esp
80102a5f:	5b                   	pop    %ebx
80102a60:	5e                   	pop    %esi
80102a61:	5f                   	pop    %edi
80102a62:	5d                   	pop    %ebp
80102a63:	c3                   	ret    
80102a64:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102a6a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80102a70 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102a70:	55                   	push   %ebp
80102a71:	89 e5                	mov    %esp,%ebp
80102a73:	56                   	push   %esi
80102a74:	53                   	push   %ebx
80102a75:	83 ec 10             	sub    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102a78:	a1 f4 11 11 80       	mov    0x801111f4,%eax
80102a7d:	89 44 24 04          	mov    %eax,0x4(%esp)
80102a81:	a1 04 12 11 80       	mov    0x80111204,%eax
80102a86:	89 04 24             	mov    %eax,(%esp)
80102a89:	e8 32 d6 ff ff       	call   801000c0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102a8e:	31 d2                	xor    %edx,%edx
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102a90:	89 c6                	mov    %eax,%esi
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102a92:	a1 08 12 11 80       	mov    0x80111208,%eax
80102a97:	8d 5e 18             	lea    0x18(%esi),%ebx
80102a9a:	89 46 18             	mov    %eax,0x18(%esi)
  for (i = 0; i < log.lh.n; i++) {
80102a9d:	a1 08 12 11 80       	mov    0x80111208,%eax
80102aa2:	85 c0                	test   %eax,%eax
80102aa4:	7e 18                	jle    80102abe <write_head+0x4e>
80102aa6:	66 90                	xchg   %ax,%ax
    hb->block[i] = log.lh.block[i];
80102aa8:	8b 0c 95 0c 12 11 80 	mov    -0x7feeedf4(,%edx,4),%ecx
80102aaf:	89 4c 93 04          	mov    %ecx,0x4(%ebx,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102ab3:	83 c2 01             	add    $0x1,%edx
80102ab6:	39 15 08 12 11 80    	cmp    %edx,0x80111208
80102abc:	7f ea                	jg     80102aa8 <write_head+0x38>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
80102abe:	89 34 24             	mov    %esi,(%esp)
80102ac1:	e8 ca d6 ff ff       	call   80100190 <bwrite>
  brelse(buf);
80102ac6:	89 34 24             	mov    %esi,(%esp)
80102ac9:	e8 f2 d6 ff ff       	call   801001c0 <brelse>
}
80102ace:	83 c4 10             	add    $0x10,%esp
80102ad1:	5b                   	pop    %ebx
80102ad2:	5e                   	pop    %esi
80102ad3:	5d                   	pop    %ebp
80102ad4:	c3                   	ret    
80102ad5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102ad9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102ae0 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
80102ae0:	55                   	push   %ebp
80102ae1:	89 e5                	mov    %esp,%ebp
80102ae3:	56                   	push   %esi
80102ae4:	53                   	push   %ebx
80102ae5:	83 ec 30             	sub    $0x30,%esp
80102ae8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80102aeb:	c7 44 24 04 ac 72 10 	movl   $0x801072ac,0x4(%esp)
80102af2:	80 
80102af3:	c7 04 24 c0 11 11 80 	movl   $0x801111c0,(%esp)
80102afa:	e8 f1 15 00 00       	call   801040f0 <initlock>
  readsb(dev, &sb);
80102aff:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102b02:	89 44 24 04          	mov    %eax,0x4(%esp)
80102b06:	89 1c 24             	mov    %ebx,(%esp)
80102b09:	e8 92 e8 ff ff       	call   801013a0 <readsb>
  log.start = sb.logstart;
80102b0e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  log.size = sb.nlog;
80102b11:	8b 55 e8             	mov    -0x18(%ebp),%edx

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102b14:	89 1c 24             	mov    %ebx,(%esp)
  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
80102b17:	89 1d 04 12 11 80    	mov    %ebx,0x80111204

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102b1d:	89 44 24 04          	mov    %eax,0x4(%esp)

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
80102b21:	89 15 f8 11 11 80    	mov    %edx,0x801111f8
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102b27:	a3 f4 11 11 80       	mov    %eax,0x801111f4

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102b2c:	e8 8f d5 ff ff       	call   801000c0 <bread>
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80102b31:	31 d2                	xor    %edx,%edx
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102b33:	8b 58 18             	mov    0x18(%eax),%ebx
80102b36:	8d 70 18             	lea    0x18(%eax),%esi
  for (i = 0; i < log.lh.n; i++) {
80102b39:	85 db                	test   %ebx,%ebx
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102b3b:	89 1d 08 12 11 80    	mov    %ebx,0x80111208
  for (i = 0; i < log.lh.n; i++) {
80102b41:	7e 17                	jle    80102b5a <initlog+0x7a>
80102b43:	90                   	nop
80102b44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    log.lh.block[i] = lh->block[i];
80102b48:	8b 4c 96 04          	mov    0x4(%esi,%edx,4),%ecx
80102b4c:	89 0c 95 0c 12 11 80 	mov    %ecx,-0x7feeedf4(,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80102b53:	83 c2 01             	add    $0x1,%edx
80102b56:	39 da                	cmp    %ebx,%edx
80102b58:	75 ee                	jne    80102b48 <initlog+0x68>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
80102b5a:	89 04 24             	mov    %eax,(%esp)
80102b5d:	e8 5e d6 ff ff       	call   801001c0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102b62:	e8 69 fe ff ff       	call   801029d0 <install_trans>
  log.lh.n = 0;
80102b67:	c7 05 08 12 11 80 00 	movl   $0x0,0x80111208
80102b6e:	00 00 00 
  write_head(); // clear the log
80102b71:	e8 fa fe ff ff       	call   80102a70 <write_head>
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
  recover_from_log();
}
80102b76:	83 c4 30             	add    $0x30,%esp
80102b79:	5b                   	pop    %ebx
80102b7a:	5e                   	pop    %esi
80102b7b:	5d                   	pop    %ebp
80102b7c:	c3                   	ret    
80102b7d:	8d 76 00             	lea    0x0(%esi),%esi

80102b80 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102b80:	55                   	push   %ebp
80102b81:	89 e5                	mov    %esp,%ebp
80102b83:	83 ec 18             	sub    $0x18,%esp
  acquire(&log.lock);
80102b86:	c7 04 24 c0 11 11 80 	movl   $0x801111c0,(%esp)
80102b8d:	e8 de 15 00 00       	call   80104170 <acquire>
80102b92:	eb 18                	jmp    80102bac <begin_op+0x2c>
80102b94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102b98:	c7 44 24 04 c0 11 11 	movl   $0x801111c0,0x4(%esp)
80102b9f:	80 
80102ba0:	c7 04 24 c0 11 11 80 	movl   $0x801111c0,(%esp)
80102ba7:	e8 f4 11 00 00       	call   80103da0 <sleep>
void
begin_op(void)
{
  acquire(&log.lock);
  while(1){
    if(log.committing){
80102bac:	a1 00 12 11 80       	mov    0x80111200,%eax
80102bb1:	85 c0                	test   %eax,%eax
80102bb3:	75 e3                	jne    80102b98 <begin_op+0x18>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102bb5:	a1 fc 11 11 80       	mov    0x801111fc,%eax
80102bba:	8b 15 08 12 11 80    	mov    0x80111208,%edx
80102bc0:	83 c0 01             	add    $0x1,%eax
80102bc3:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102bc6:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102bc9:	83 fa 1e             	cmp    $0x1e,%edx
80102bcc:	7f ca                	jg     80102b98 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102bce:	c7 04 24 c0 11 11 80 	movl   $0x801111c0,(%esp)
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
80102bd5:	a3 fc 11 11 80       	mov    %eax,0x801111fc
      release(&log.lock);
80102bda:	e8 c1 16 00 00       	call   801042a0 <release>
      break;
    }
  }
}
80102bdf:	c9                   	leave  
80102be0:	c3                   	ret    
80102be1:	eb 0d                	jmp    80102bf0 <end_op>
80102be3:	90                   	nop
80102be4:	90                   	nop
80102be5:	90                   	nop
80102be6:	90                   	nop
80102be7:	90                   	nop
80102be8:	90                   	nop
80102be9:	90                   	nop
80102bea:	90                   	nop
80102beb:	90                   	nop
80102bec:	90                   	nop
80102bed:	90                   	nop
80102bee:	90                   	nop
80102bef:	90                   	nop

80102bf0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102bf0:	55                   	push   %ebp
80102bf1:	89 e5                	mov    %esp,%ebp
80102bf3:	57                   	push   %edi
80102bf4:	56                   	push   %esi
80102bf5:	53                   	push   %ebx
80102bf6:	83 ec 1c             	sub    $0x1c,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102bf9:	c7 04 24 c0 11 11 80 	movl   $0x801111c0,(%esp)
80102c00:	e8 6b 15 00 00       	call   80104170 <acquire>
  log.outstanding -= 1;
80102c05:	a1 fc 11 11 80       	mov    0x801111fc,%eax
  if(log.committing)
80102c0a:	8b 15 00 12 11 80    	mov    0x80111200,%edx
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102c10:	83 e8 01             	sub    $0x1,%eax
  if(log.committing)
80102c13:	85 d2                	test   %edx,%edx
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102c15:	a3 fc 11 11 80       	mov    %eax,0x801111fc
  if(log.committing)
80102c1a:	0f 85 f3 00 00 00    	jne    80102d13 <end_op+0x123>
    panic("log.committing");
  if(log.outstanding == 0){
80102c20:	85 c0                	test   %eax,%eax
80102c22:	0f 85 cb 00 00 00    	jne    80102cf3 <end_op+0x103>
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
  }
  release(&log.lock);
80102c28:	c7 04 24 c0 11 11 80 	movl   $0x801111c0,(%esp)
}

static void
commit()
{
  if (log.lh.n > 0) {
80102c2f:	31 db                	xor    %ebx,%ebx
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
  if(log.outstanding == 0){
    do_commit = 1;
    log.committing = 1;
80102c31:	c7 05 00 12 11 80 01 	movl   $0x1,0x80111200
80102c38:	00 00 00 
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
  }
  release(&log.lock);
80102c3b:	e8 60 16 00 00       	call   801042a0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102c40:	a1 08 12 11 80       	mov    0x80111208,%eax
80102c45:	85 c0                	test   %eax,%eax
80102c47:	0f 8e 90 00 00 00    	jle    80102cdd <end_op+0xed>
80102c4d:	8d 76 00             	lea    0x0(%esi),%esi
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102c50:	a1 f4 11 11 80       	mov    0x801111f4,%eax
80102c55:	01 d8                	add    %ebx,%eax
80102c57:	83 c0 01             	add    $0x1,%eax
80102c5a:	89 44 24 04          	mov    %eax,0x4(%esp)
80102c5e:	a1 04 12 11 80       	mov    0x80111204,%eax
80102c63:	89 04 24             	mov    %eax,(%esp)
80102c66:	e8 55 d4 ff ff       	call   801000c0 <bread>
80102c6b:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102c6d:	8b 04 9d 0c 12 11 80 	mov    -0x7feeedf4(,%ebx,4),%eax
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102c74:	83 c3 01             	add    $0x1,%ebx
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102c77:	89 44 24 04          	mov    %eax,0x4(%esp)
80102c7b:	a1 04 12 11 80       	mov    0x80111204,%eax
80102c80:	89 04 24             	mov    %eax,(%esp)
80102c83:	e8 38 d4 ff ff       	call   801000c0 <bread>
    memmove(to->data, from->data, BSIZE);
80102c88:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80102c8f:	00 
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102c90:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102c92:	8d 40 18             	lea    0x18(%eax),%eax
80102c95:	89 44 24 04          	mov    %eax,0x4(%esp)
80102c99:	8d 46 18             	lea    0x18(%esi),%eax
80102c9c:	89 04 24             	mov    %eax,(%esp)
80102c9f:	e8 fc 16 00 00       	call   801043a0 <memmove>
    bwrite(to);  // write the log
80102ca4:	89 34 24             	mov    %esi,(%esp)
80102ca7:	e8 e4 d4 ff ff       	call   80100190 <bwrite>
    brelse(from);
80102cac:	89 3c 24             	mov    %edi,(%esp)
80102caf:	e8 0c d5 ff ff       	call   801001c0 <brelse>
    brelse(to);
80102cb4:	89 34 24             	mov    %esi,(%esp)
80102cb7:	e8 04 d5 ff ff       	call   801001c0 <brelse>
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102cbc:	3b 1d 08 12 11 80    	cmp    0x80111208,%ebx
80102cc2:	7c 8c                	jl     80102c50 <end_op+0x60>
static void
commit()
{
  if (log.lh.n > 0) {
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102cc4:	e8 a7 fd ff ff       	call   80102a70 <write_head>
    install_trans(); // Now install writes to home locations
80102cc9:	e8 02 fd ff ff       	call   801029d0 <install_trans>
    log.lh.n = 0;
80102cce:	c7 05 08 12 11 80 00 	movl   $0x0,0x80111208
80102cd5:	00 00 00 
    write_head();    // Erase the transaction from the log
80102cd8:	e8 93 fd ff ff       	call   80102a70 <write_head>

  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
80102cdd:	c7 04 24 c0 11 11 80 	movl   $0x801111c0,(%esp)
80102ce4:	e8 87 14 00 00       	call   80104170 <acquire>
    log.committing = 0;
80102ce9:	c7 05 00 12 11 80 00 	movl   $0x0,0x80111200
80102cf0:	00 00 00 
    wakeup(&log);
80102cf3:	c7 04 24 c0 11 11 80 	movl   $0x801111c0,(%esp)
80102cfa:	e8 41 12 00 00       	call   80103f40 <wakeup>
    release(&log.lock);
80102cff:	c7 04 24 c0 11 11 80 	movl   $0x801111c0,(%esp)
80102d06:	e8 95 15 00 00       	call   801042a0 <release>
  }
}
80102d0b:	83 c4 1c             	add    $0x1c,%esp
80102d0e:	5b                   	pop    %ebx
80102d0f:	5e                   	pop    %esi
80102d10:	5f                   	pop    %edi
80102d11:	5d                   	pop    %ebp
80102d12:	c3                   	ret    
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
80102d13:	c7 04 24 b0 72 10 80 	movl   $0x801072b0,(%esp)
80102d1a:	e8 11 d6 ff ff       	call   80100330 <panic>
80102d1f:	90                   	nop

80102d20 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102d20:	55                   	push   %ebp
80102d21:	89 e5                	mov    %esp,%ebp
80102d23:	53                   	push   %ebx
80102d24:	83 ec 14             	sub    $0x14,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102d27:	a1 08 12 11 80       	mov    0x80111208,%eax
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102d2c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102d2f:	83 f8 1d             	cmp    $0x1d,%eax
80102d32:	0f 8f a0 00 00 00    	jg     80102dd8 <log_write+0xb8>
80102d38:	8b 15 f8 11 11 80    	mov    0x801111f8,%edx
80102d3e:	83 ea 01             	sub    $0x1,%edx
80102d41:	39 d0                	cmp    %edx,%eax
80102d43:	0f 8d 8f 00 00 00    	jge    80102dd8 <log_write+0xb8>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102d49:	a1 fc 11 11 80       	mov    0x801111fc,%eax
80102d4e:	85 c0                	test   %eax,%eax
80102d50:	0f 8e 8e 00 00 00    	jle    80102de4 <log_write+0xc4>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102d56:	c7 04 24 c0 11 11 80 	movl   $0x801111c0,(%esp)
80102d5d:	e8 0e 14 00 00       	call   80104170 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102d62:	8b 15 08 12 11 80    	mov    0x80111208,%edx
80102d68:	83 fa 00             	cmp    $0x0,%edx
80102d6b:	7e 54                	jle    80102dc1 <log_write+0xa1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102d6d:	8b 4b 08             	mov    0x8(%ebx),%ecx
80102d70:	39 0d 0c 12 11 80    	cmp    %ecx,0x8011120c
80102d76:	74 58                	je     80102dd0 <log_write+0xb0>
80102d78:	31 c0                	xor    %eax,%eax
80102d7a:	eb 0d                	jmp    80102d89 <log_write+0x69>
80102d7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102d80:	39 0c 85 0c 12 11 80 	cmp    %ecx,-0x7feeedf4(,%eax,4)
80102d87:	74 2f                	je     80102db8 <log_write+0x98>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102d89:	83 c0 01             	add    $0x1,%eax
80102d8c:	39 d0                	cmp    %edx,%eax
80102d8e:	75 f0                	jne    80102d80 <log_write+0x60>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102d90:	89 0c 95 0c 12 11 80 	mov    %ecx,-0x7feeedf4(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
80102d97:	83 c2 01             	add    $0x1,%edx
80102d9a:	89 15 08 12 11 80    	mov    %edx,0x80111208
  b->flags |= B_DIRTY; // prevent eviction
80102da0:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102da3:	c7 45 08 c0 11 11 80 	movl   $0x801111c0,0x8(%ebp)
}
80102daa:	83 c4 14             	add    $0x14,%esp
80102dad:	5b                   	pop    %ebx
80102dae:	5d                   	pop    %ebp
  }
  log.lh.block[i] = b->blockno;
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
  release(&log.lock);
80102daf:	e9 ec 14 00 00       	jmp    801042a0 <release>
80102db4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102db8:	89 0c 85 0c 12 11 80 	mov    %ecx,-0x7feeedf4(,%eax,4)
80102dbf:	eb df                	jmp    80102da0 <log_write+0x80>
80102dc1:	8b 43 08             	mov    0x8(%ebx),%eax
80102dc4:	a3 0c 12 11 80       	mov    %eax,0x8011120c
  if (i == log.lh.n)
80102dc9:	75 d5                	jne    80102da0 <log_write+0x80>
80102dcb:	eb ca                	jmp    80102d97 <log_write+0x77>
80102dcd:	8d 76 00             	lea    0x0(%esi),%esi
  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102dd0:	89 0d 0c 12 11 80    	mov    %ecx,0x8011120c
80102dd6:	eb c8                	jmp    80102da0 <log_write+0x80>
log_write(struct buf *b)
{
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
80102dd8:	c7 04 24 bf 72 10 80 	movl   $0x801072bf,(%esp)
80102ddf:	e8 4c d5 ff ff       	call   80100330 <panic>
  if (log.outstanding < 1)
    panic("log_write outside of trans");
80102de4:	c7 04 24 d5 72 10 80 	movl   $0x801072d5,(%esp)
80102deb:	e8 40 d5 ff ff       	call   80100330 <panic>

80102df0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102df0:	55                   	push   %ebp
80102df1:	89 e5                	mov    %esp,%ebp
80102df3:	83 ec 18             	sub    $0x18,%esp
  cprintf("cpu%d: starting\n", cpunum());
80102df6:	e8 65 f9 ff ff       	call   80102760 <cpunum>
80102dfb:	c7 04 24 f0 72 10 80 	movl   $0x801072f0,(%esp)
80102e02:	89 44 24 04          	mov    %eax,0x4(%esp)
80102e06:	e8 f5 d7 ff ff       	call   80100600 <cprintf>
  idtinit();       // load idt register
80102e0b:	e8 40 28 00 00       	call   80105650 <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
80102e10:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102e17:	b8 01 00 00 00       	mov    $0x1,%eax
80102e1c:	f0 87 82 a8 00 00 00 	lock xchg %eax,0xa8(%edx)
  scheduler();     // start running processes
80102e23:	e8 b8 0c 00 00       	call   80103ae0 <scheduler>
80102e28:	90                   	nop
80102e29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102e30 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80102e30:	55                   	push   %ebp
80102e31:	89 e5                	mov    %esp,%ebp
80102e33:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102e36:	e8 55 39 00 00       	call   80106790 <switchkvm>
  seginit();
80102e3b:	e8 80 37 00 00       	call   801065c0 <seginit>
  lapicinit();
80102e40:	e8 2b f8 ff ff       	call   80102670 <lapicinit>
  mpmain();
80102e45:	e8 a6 ff ff ff       	call   80102df0 <mpmain>
80102e4a:	66 90                	xchg   %ax,%ax
80102e4c:	66 90                	xchg   %ax,%ax
80102e4e:	66 90                	xchg   %ax,%ax

80102e50 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80102e50:	55                   	push   %ebp
80102e51:	89 e5                	mov    %esp,%ebp
80102e53:	53                   	push   %ebx
80102e54:	83 e4 f0             	and    $0xfffffff0,%esp
80102e57:	83 ec 10             	sub    $0x10,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102e5a:	c7 44 24 04 00 00 40 	movl   $0x80400000,0x4(%esp)
80102e61:	80 
80102e62:	c7 04 24 48 40 11 80 	movl   $0x80114048,(%esp)
80102e69:	e8 e2 f5 ff ff       	call   80102450 <kinit1>
  kvmalloc();      // kernel page table
80102e6e:	e8 fd 38 00 00       	call   80106770 <kvmalloc>
  mpinit();        // detect other processors
80102e73:	e8 98 01 00 00       	call   80103010 <mpinit>
  lapicinit();     // interrupt controller
80102e78:	e8 f3 f7 ff ff       	call   80102670 <lapicinit>
80102e7d:	8d 76 00             	lea    0x0(%esi),%esi
  seginit();       // segment descriptors
80102e80:	e8 3b 37 00 00       	call   801065c0 <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpunum());
80102e85:	e8 d6 f8 ff ff       	call   80102760 <cpunum>
80102e8a:	c7 04 24 01 73 10 80 	movl   $0x80107301,(%esp)
80102e91:	89 44 24 04          	mov    %eax,0x4(%esp)
80102e95:	e8 66 d7 ff ff       	call   80100600 <cprintf>
  picinit();       // another interrupt controller
80102e9a:	e8 81 03 00 00       	call   80103220 <picinit>
  ioapicinit();    // another interrupt controller
80102e9f:	e8 9c f3 ff ff       	call   80102240 <ioapicinit>
  consoleinit();   // console hardware
80102ea4:	e8 67 da ff ff       	call   80100910 <consoleinit>
  uartinit();      // serial port
80102ea9:	e8 c2 2a 00 00       	call   80105970 <uartinit>
80102eae:	66 90                	xchg   %ax,%ax
  pinit();         // process table
80102eb0:	e8 6b 09 00 00       	call   80103820 <pinit>
  tvinit();        // trap vectors
80102eb5:	e8 06 27 00 00       	call   801055c0 <tvinit>
  binit();         // buffer cache
80102eba:	e8 81 d1 ff ff       	call   80100040 <binit>
80102ebf:	90                   	nop
  fileinit();      // file table
80102ec0:	e8 3b de ff ff       	call   80100d00 <fileinit>
  ideinit();       // disk
80102ec5:	e8 66 f1 ff ff       	call   80102030 <ideinit>
  if(!ismp)
80102eca:	a1 a4 12 11 80       	mov    0x801112a4,%eax
80102ecf:	85 c0                	test   %eax,%eax
80102ed1:	0f 84 ca 00 00 00    	je     80102fa1 <main+0x151>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102ed7:	c7 44 24 08 8a 00 00 	movl   $0x8a,0x8(%esp)
80102ede:	00 

  for(c = cpus; c < cpus+ncpu; c++){
80102edf:	bb c0 12 11 80       	mov    $0x801112c0,%ebx

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102ee4:	c7 44 24 04 8c a4 10 	movl   $0x8010a48c,0x4(%esp)
80102eeb:	80 
80102eec:	c7 04 24 00 70 00 80 	movl   $0x80007000,(%esp)
80102ef3:	e8 a8 14 00 00       	call   801043a0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102ef8:	69 05 a0 18 11 80 bc 	imul   $0xbc,0x801118a0,%eax
80102eff:	00 00 00 
80102f02:	05 c0 12 11 80       	add    $0x801112c0,%eax
80102f07:	39 d8                	cmp    %ebx,%eax
80102f09:	76 78                	jbe    80102f83 <main+0x133>
80102f0b:	90                   	nop
80102f0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(c == cpus+cpunum())  // We've started already.
80102f10:	e8 4b f8 ff ff       	call   80102760 <cpunum>
80102f15:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80102f1b:	05 c0 12 11 80       	add    $0x801112c0,%eax
80102f20:	39 c3                	cmp    %eax,%ebx
80102f22:	74 46                	je     80102f6a <main+0x11a>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102f24:	e8 77 f5 ff ff       	call   801024a0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void**)(code-8) = mpenter;
80102f29:	c7 05 f8 6f 00 80 30 	movl   $0x80102e30,0x80006ff8
80102f30:	2e 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102f33:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
80102f3a:	90 10 00 

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f3d:	05 00 10 00 00       	add    $0x1000,%eax
80102f42:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(void**)(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80102f47:	0f b6 03             	movzbl (%ebx),%eax
80102f4a:	c7 44 24 04 00 70 00 	movl   $0x7000,0x4(%esp)
80102f51:	00 
80102f52:	89 04 24             	mov    %eax,(%esp)
80102f55:	e8 d6 f8 ff ff       	call   80102830 <lapicstartap>
80102f5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80102f60:	8b 83 a8 00 00 00    	mov    0xa8(%ebx),%eax
80102f66:	85 c0                	test   %eax,%eax
80102f68:	74 f6                	je     80102f60 <main+0x110>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80102f6a:	69 05 a0 18 11 80 bc 	imul   $0xbc,0x801118a0,%eax
80102f71:	00 00 00 
80102f74:	81 c3 bc 00 00 00    	add    $0xbc,%ebx
80102f7a:	05 c0 12 11 80       	add    $0x801112c0,%eax
80102f7f:	39 c3                	cmp    %eax,%ebx
80102f81:	72 8d                	jb     80102f10 <main+0xc0>
  fileinit();      // file table
  ideinit();       // disk
  if(!ismp)
    timerinit();   // uniprocessor timer
  startothers();   // start other processors
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80102f83:	c7 44 24 04 00 00 00 	movl   $0x8e000000,0x4(%esp)
80102f8a:	8e 
80102f8b:	c7 04 24 00 00 40 80 	movl   $0x80400000,(%esp)
80102f92:	e8 89 f4 ff ff       	call   80102420 <kinit2>
  userinit();      // first user process
80102f97:	e8 a4 08 00 00       	call   80103840 <userinit>
  mpmain();        // finish this processor's setup
80102f9c:	e8 4f fe ff ff       	call   80102df0 <mpmain>
  tvinit();        // trap vectors
  binit();         // buffer cache
  fileinit();      // file table
  ideinit();       // disk
  if(!ismp)
    timerinit();   // uniprocessor timer
80102fa1:	e8 ba 25 00 00       	call   80105560 <timerinit>
80102fa6:	e9 2c ff ff ff       	jmp    80102ed7 <main+0x87>
80102fab:	66 90                	xchg   %ax,%ax
80102fad:	66 90                	xchg   %ax,%ax
80102faf:	90                   	nop

80102fb0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102fb0:	55                   	push   %ebp
80102fb1:	89 e5                	mov    %esp,%ebp
80102fb3:	57                   	push   %edi
80102fb4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80102fb5:	8d b8 00 00 00 80    	lea    -0x80000000(%eax),%edi
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102fbb:	53                   	push   %ebx
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
80102fbc:	8d 1c 17             	lea    (%edi,%edx,1),%ebx
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102fbf:	83 ec 1c             	sub    $0x1c,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80102fc2:	39 df                	cmp    %ebx,%edi
80102fc4:	73 3b                	jae    80103001 <mpsearch1+0x51>
80102fc6:	66 90                	xchg   %ax,%ax
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102fc8:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
80102fcf:	00 
80102fd0:	c7 44 24 04 18 73 10 	movl   $0x80107318,0x4(%esp)
80102fd7:	80 
80102fd8:	89 3c 24             	mov    %edi,(%esp)
80102fdb:	e8 70 13 00 00       	call   80104350 <memcmp>
80102fe0:	85 c0                	test   %eax,%eax
80102fe2:	75 16                	jne    80102ffa <mpsearch1+0x4a>
80102fe4:	31 c9                	xor    %ecx,%ecx
80102fe6:	31 d2                	xor    %edx,%edx
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
80102fe8:	0f b6 34 17          	movzbl (%edi,%edx,1),%esi
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80102fec:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80102fef:	01 f1                	add    %esi,%ecx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80102ff1:	83 fa 10             	cmp    $0x10,%edx
80102ff4:	75 f2                	jne    80102fe8 <mpsearch1+0x38>
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102ff6:	84 c9                	test   %cl,%cl
80102ff8:	74 09                	je     80103003 <mpsearch1+0x53>
{
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80102ffa:	83 c7 10             	add    $0x10,%edi
80102ffd:	39 fb                	cmp    %edi,%ebx
80102fff:	77 c7                	ja     80102fc8 <mpsearch1+0x18>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80103001:	31 ff                	xor    %edi,%edi
}
80103003:	83 c4 1c             	add    $0x1c,%esp
80103006:	89 f8                	mov    %edi,%eax
80103008:	5b                   	pop    %ebx
80103009:	5e                   	pop    %esi
8010300a:	5f                   	pop    %edi
8010300b:	5d                   	pop    %ebp
8010300c:	c3                   	ret    
8010300d:	8d 76 00             	lea    0x0(%esi),%esi

80103010 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103010:	55                   	push   %ebp
80103011:	89 e5                	mov    %esp,%ebp
80103013:	57                   	push   %edi
80103014:	56                   	push   %esi
80103015:	53                   	push   %ebx
80103016:	83 ec 2c             	sub    $0x2c,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103019:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103020:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103027:	c1 e0 08             	shl    $0x8,%eax
8010302a:	09 d0                	or     %edx,%eax
8010302c:	c1 e0 04             	shl    $0x4,%eax
8010302f:	85 c0                	test   %eax,%eax
80103031:	75 1b                	jne    8010304e <mpinit+0x3e>
    if((mp = mpsearch1(p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103033:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010303a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103041:	c1 e0 08             	shl    $0x8,%eax
80103044:	09 d0                	or     %edx,%eax
80103046:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103049:	2d 00 04 00 00       	sub    $0x400,%eax
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
    if((mp = mpsearch1(p, 1024)))
8010304e:	ba 00 04 00 00       	mov    $0x400,%edx
80103053:	e8 58 ff ff ff       	call   80102fb0 <mpsearch1>
80103058:	85 c0                	test   %eax,%eax
8010305a:	89 c7                	mov    %eax,%edi
8010305c:	0f 84 5e 01 00 00    	je     801031c0 <mpinit+0x1b0>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103062:	8b 77 04             	mov    0x4(%edi),%esi
80103065:	85 f6                	test   %esi,%esi
80103067:	0f 84 e6 00 00 00    	je     80103153 <mpinit+0x143>
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010306d:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80103073:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
8010307a:	00 
8010307b:	c7 44 24 04 1d 73 10 	movl   $0x8010731d,0x4(%esp)
80103082:	80 
80103083:	89 04 24             	mov    %eax,(%esp)
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103086:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103089:	e8 c2 12 00 00       	call   80104350 <memcmp>
8010308e:	85 c0                	test   %eax,%eax
80103090:	0f 85 bd 00 00 00    	jne    80103153 <mpinit+0x143>
    return 0;
  if(conf->version != 1 && conf->version != 4)
80103096:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
8010309d:	3c 04                	cmp    $0x4,%al
8010309f:	0f 85 39 01 00 00    	jne    801031de <mpinit+0x1ce>
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
801030a5:	0f b7 86 04 00 00 80 	movzwl -0x7ffffffc(%esi),%eax
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801030ac:	85 c0                	test   %eax,%eax
801030ae:	74 21                	je     801030d1 <mpinit+0xc1>
801030b0:	31 c9                	xor    %ecx,%ecx
801030b2:	31 d2                	xor    %edx,%edx
801030b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
801030b8:	0f b6 9c 16 00 00 00 	movzbl -0x80000000(%esi,%edx,1),%ebx
801030bf:	80 
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801030c0:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
801030c3:	01 d9                	add    %ebx,%ecx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801030c5:	39 d0                	cmp    %edx,%eax
801030c7:	7f ef                	jg     801030b8 <mpinit+0xa8>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
801030c9:	84 c9                	test   %cl,%cl
801030cb:	0f 85 82 00 00 00    	jne    80103153 <mpinit+0x143>
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
801030d1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801030d4:	85 d2                	test   %edx,%edx
801030d6:	74 7b                	je     80103153 <mpinit+0x143>
    return;
  ismp = 1;
801030d8:	c7 05 a4 12 11 80 01 	movl   $0x1,0x801112a4
801030df:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
801030e2:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
801030e8:	a3 bc 11 11 80       	mov    %eax,0x801111bc
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801030ed:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
801030f4:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
801030fa:	03 55 e4             	add    -0x1c(%ebp),%edx
801030fd:	39 d0                	cmp    %edx,%eax
801030ff:	72 15                	jb     80103116 <mpinit+0x106>
80103101:	e9 9a 00 00 00       	jmp    801031a0 <mpinit+0x190>
80103106:	66 90                	xchg   %ax,%ax
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      ismp = 0;
80103108:	c7 05 a4 12 11 80 00 	movl   $0x0,0x801112a4
8010310f:	00 00 00 

  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103112:	39 c2                	cmp    %eax,%edx
80103114:	76 19                	jbe    8010312f <mpinit+0x11f>
    switch(*p){
80103116:	80 38 04             	cmpb   $0x4,(%eax)
80103119:	77 ed                	ja     80103108 <mpinit+0xf8>
8010311b:	0f b6 08             	movzbl (%eax),%ecx
8010311e:	ff 24 8d 24 73 10 80 	jmp    *-0x7fef8cdc(,%ecx,4)
80103125:	8d 76 00             	lea    0x0(%esi),%esi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103128:	83 c0 08             	add    $0x8,%eax

  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010312b:	39 c2                	cmp    %eax,%edx
8010312d:	77 e7                	ja     80103116 <mpinit+0x106>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp){
8010312f:	a1 a4 12 11 80       	mov    0x801112a4,%eax
80103134:	85 c0                	test   %eax,%eax
80103136:	75 68                	jne    801031a0 <mpinit+0x190>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
80103138:	c7 05 a0 18 11 80 01 	movl   $0x1,0x801118a0
8010313f:	00 00 00 
    lapic = 0;
80103142:	c7 05 bc 11 11 80 00 	movl   $0x0,0x801111bc
80103149:	00 00 00 
    ioapicid = 0;
8010314c:	c6 05 a0 12 11 80 00 	movb   $0x0,0x801112a0
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
80103153:	83 c4 2c             	add    $0x2c,%esp
80103156:	5b                   	pop    %ebx
80103157:	5e                   	pop    %esi
80103158:	5f                   	pop    %edi
80103159:	5d                   	pop    %ebp
8010315a:	c3                   	ret    
8010315b:	90                   	nop
8010315c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
80103160:	8b 0d a0 18 11 80    	mov    0x801118a0,%ecx
80103166:	83 f9 07             	cmp    $0x7,%ecx
80103169:	7f 17                	jg     80103182 <mpinit+0x172>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010316b:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
8010316f:	69 c9 bc 00 00 00    	imul   $0xbc,%ecx,%ecx
        ncpu++;
80103175:	83 05 a0 18 11 80 01 	addl   $0x1,0x801118a0
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010317c:	88 99 c0 12 11 80    	mov    %bl,-0x7feeed40(%ecx)
        ncpu++;
      }
      p += sizeof(struct mpproc);
80103182:	83 c0 14             	add    $0x14,%eax
      continue;
80103185:	eb 8b                	jmp    80103112 <mpinit+0x102>
80103187:	90                   	nop
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
80103188:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
8010318c:	83 c0 08             	add    $0x8,%eax
      }
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
8010318f:	88 0d a0 12 11 80    	mov    %cl,0x801112a0
      p += sizeof(struct mpioapic);
      continue;
80103195:	e9 78 ff ff ff       	jmp    80103112 <mpinit+0x102>
8010319a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    lapic = 0;
    ioapicid = 0;
    return;
  }

  if(mp->imcrp){
801031a0:	80 7f 0c 00          	cmpb   $0x0,0xc(%edi)
801031a4:	74 ad                	je     80103153 <mpinit+0x143>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801031a6:	ba 22 00 00 00       	mov    $0x22,%edx
801031ab:	b8 70 00 00 00       	mov    $0x70,%eax
801031b0:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801031b1:	b2 23                	mov    $0x23,%dl
801031b3:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
801031b4:	83 c8 01             	or     $0x1,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801031b7:	ee                   	out    %al,(%dx)
  }
}
801031b8:	83 c4 2c             	add    $0x2c,%esp
801031bb:	5b                   	pop    %ebx
801031bc:	5e                   	pop    %esi
801031bd:	5f                   	pop    %edi
801031be:	5d                   	pop    %ebp
801031bf:	c3                   	ret    
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
801031c0:	ba 00 00 01 00       	mov    $0x10000,%edx
801031c5:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801031ca:	e8 e1 fd ff ff       	call   80102fb0 <mpsearch1>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801031cf:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
801031d1:	89 c7                	mov    %eax,%edi
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801031d3:	0f 85 89 fe ff ff    	jne    80103062 <mpinit+0x52>
801031d9:	e9 75 ff ff ff       	jmp    80103153 <mpinit+0x143>
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
801031de:	3c 01                	cmp    $0x1,%al
801031e0:	0f 84 bf fe ff ff    	je     801030a5 <mpinit+0x95>
801031e6:	e9 68 ff ff ff       	jmp    80103153 <mpinit+0x143>
801031eb:	66 90                	xchg   %ax,%ax
801031ed:	66 90                	xchg   %ax,%ax
801031ef:	90                   	nop

801031f0 <picenable>:
  outb(IO_PIC2+1, mask >> 8);
}

void
picenable(int irq)
{
801031f0:	55                   	push   %ebp
  picsetmask(irqmask & ~(1<<irq));
801031f1:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
  outb(IO_PIC2+1, mask >> 8);
}

void
picenable(int irq)
{
801031f6:	89 e5                	mov    %esp,%ebp
801031f8:	ba 21 00 00 00       	mov    $0x21,%edx
  picsetmask(irqmask & ~(1<<irq));
801031fd:	8b 4d 08             	mov    0x8(%ebp),%ecx
80103200:	d3 c0                	rol    %cl,%eax
80103202:	66 23 05 00 a0 10 80 	and    0x8010a000,%ax
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
  irqmask = mask;
80103209:	66 a3 00 a0 10 80    	mov    %ax,0x8010a000
8010320f:	ee                   	out    %al,(%dx)
  outb(IO_PIC1+1, mask);
  outb(IO_PIC2+1, mask >> 8);
80103210:	66 c1 e8 08          	shr    $0x8,%ax
80103214:	b2 a1                	mov    $0xa1,%dl
80103216:	ee                   	out    %al,(%dx)

void
picenable(int irq)
{
  picsetmask(irqmask & ~(1<<irq));
}
80103217:	5d                   	pop    %ebp
80103218:	c3                   	ret    
80103219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103220 <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
80103220:	55                   	push   %ebp
80103221:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103226:	89 e5                	mov    %esp,%ebp
80103228:	83 ec 0c             	sub    $0xc,%esp
8010322b:	89 5d f4             	mov    %ebx,-0xc(%ebp)
8010322e:	bb 21 00 00 00       	mov    $0x21,%ebx
80103233:	89 75 f8             	mov    %esi,-0x8(%ebp)
80103236:	89 da                	mov    %ebx,%edx
80103238:	89 7d fc             	mov    %edi,-0x4(%ebp)
8010323b:	ee                   	out    %al,(%dx)
8010323c:	b9 a1 00 00 00       	mov    $0xa1,%ecx
80103241:	89 ca                	mov    %ecx,%edx
80103243:	ee                   	out    %al,(%dx)
80103244:	bf 11 00 00 00       	mov    $0x11,%edi
80103249:	be 20 00 00 00       	mov    $0x20,%esi
8010324e:	89 f8                	mov    %edi,%eax
80103250:	89 f2                	mov    %esi,%edx
80103252:	ee                   	out    %al,(%dx)
80103253:	b8 20 00 00 00       	mov    $0x20,%eax
80103258:	89 da                	mov    %ebx,%edx
8010325a:	ee                   	out    %al,(%dx)
8010325b:	b8 04 00 00 00       	mov    $0x4,%eax
80103260:	ee                   	out    %al,(%dx)
80103261:	b8 03 00 00 00       	mov    $0x3,%eax
80103266:	ee                   	out    %al,(%dx)
80103267:	b3 a0                	mov    $0xa0,%bl
80103269:	89 f8                	mov    %edi,%eax
8010326b:	89 da                	mov    %ebx,%edx
8010326d:	ee                   	out    %al,(%dx)
8010326e:	b8 28 00 00 00       	mov    $0x28,%eax
80103273:	89 ca                	mov    %ecx,%edx
80103275:	ee                   	out    %al,(%dx)
80103276:	b8 02 00 00 00       	mov    $0x2,%eax
8010327b:	ee                   	out    %al,(%dx)
8010327c:	b8 03 00 00 00       	mov    $0x3,%eax
80103281:	ee                   	out    %al,(%dx)
80103282:	bf 68 00 00 00       	mov    $0x68,%edi
80103287:	89 f2                	mov    %esi,%edx
80103289:	89 f8                	mov    %edi,%eax
8010328b:	ee                   	out    %al,(%dx)
8010328c:	b9 0a 00 00 00       	mov    $0xa,%ecx
80103291:	89 c8                	mov    %ecx,%eax
80103293:	ee                   	out    %al,(%dx)
80103294:	89 f8                	mov    %edi,%eax
80103296:	89 da                	mov    %ebx,%edx
80103298:	ee                   	out    %al,(%dx)
80103299:	89 c8                	mov    %ecx,%eax
8010329b:	ee                   	out    %al,(%dx)
  outb(IO_PIC1, 0x0a);             // read IRR by default

  outb(IO_PIC2, 0x68);             // OCW3
  outb(IO_PIC2, 0x0a);             // OCW3

  if(irqmask != 0xFFFF)
8010329c:	0f b7 05 00 a0 10 80 	movzwl 0x8010a000,%eax
801032a3:	66 83 f8 ff          	cmp    $0xffff,%ax
801032a7:	74 0a                	je     801032b3 <picinit+0x93>
801032a9:	b2 21                	mov    $0x21,%dl
801032ab:	ee                   	out    %al,(%dx)
static void
picsetmask(ushort mask)
{
  irqmask = mask;
  outb(IO_PIC1+1, mask);
  outb(IO_PIC2+1, mask >> 8);
801032ac:	66 c1 e8 08          	shr    $0x8,%ax
801032b0:	b2 a1                	mov    $0xa1,%dl
801032b2:	ee                   	out    %al,(%dx)
  outb(IO_PIC2, 0x68);             // OCW3
  outb(IO_PIC2, 0x0a);             // OCW3

  if(irqmask != 0xFFFF)
    picsetmask(irqmask);
}
801032b3:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801032b6:	8b 75 f8             	mov    -0x8(%ebp),%esi
801032b9:	8b 7d fc             	mov    -0x4(%ebp),%edi
801032bc:	89 ec                	mov    %ebp,%esp
801032be:	5d                   	pop    %ebp
801032bf:	c3                   	ret    

801032c0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801032c0:	55                   	push   %ebp
801032c1:	89 e5                	mov    %esp,%ebp
801032c3:	83 ec 28             	sub    $0x28,%esp
801032c6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801032c9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801032cc:	89 75 f8             	mov    %esi,-0x8(%ebp)
801032cf:	8b 75 08             	mov    0x8(%ebp),%esi
801032d2:	89 7d fc             	mov    %edi,-0x4(%ebp)
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801032d5:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801032db:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801032e1:	e8 3a da ff ff       	call   80100d20 <filealloc>
801032e6:	85 c0                	test   %eax,%eax
801032e8:	89 06                	mov    %eax,(%esi)
801032ea:	0f 84 a6 00 00 00    	je     80103396 <pipealloc+0xd6>
801032f0:	e8 2b da ff ff       	call   80100d20 <filealloc>
801032f5:	85 c0                	test   %eax,%eax
801032f7:	89 03                	mov    %eax,(%ebx)
801032f9:	0f 84 89 00 00 00    	je     80103388 <pipealloc+0xc8>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801032ff:	e8 9c f1 ff ff       	call   801024a0 <kalloc>
80103304:	85 c0                	test   %eax,%eax
80103306:	89 c7                	mov    %eax,%edi
80103308:	74 7e                	je     80103388 <pipealloc+0xc8>
    goto bad;
  p->readopen = 1;
8010330a:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103311:	00 00 00 
  p->writeopen = 1;
80103314:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010331b:	00 00 00 
  p->nwrite = 0;
8010331e:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103325:	00 00 00 
  p->nread = 0;
80103328:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
8010332f:	00 00 00 
  initlock(&p->lock, "pipe");
80103332:	89 04 24             	mov    %eax,(%esp)
80103335:	c7 44 24 04 38 73 10 	movl   $0x80107338,0x4(%esp)
8010333c:	80 
8010333d:	e8 ae 0d 00 00       	call   801040f0 <initlock>
  (*f0)->type = FD_PIPE;
80103342:	8b 06                	mov    (%esi),%eax
80103344:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
8010334a:	8b 06                	mov    (%esi),%eax
8010334c:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103350:	8b 06                	mov    (%esi),%eax
80103352:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103356:	8b 06                	mov    (%esi),%eax
80103358:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010335b:	8b 03                	mov    (%ebx),%eax
8010335d:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103363:	8b 03                	mov    (%ebx),%eax
80103365:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103369:	8b 03                	mov    (%ebx),%eax
8010336b:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010336f:	8b 03                	mov    (%ebx),%eax
  return 0;
80103371:	31 db                	xor    %ebx,%ebx
  (*f0)->writable = 0;
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
80103373:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103376:	89 d8                	mov    %ebx,%eax
80103378:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010337b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010337e:	8b 7d fc             	mov    -0x4(%ebp),%edi
80103381:	89 ec                	mov    %ebp,%esp
80103383:	5d                   	pop    %ebp
80103384:	c3                   	ret    
80103385:	8d 76 00             	lea    0x0(%esi),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
80103388:	8b 06                	mov    (%esi),%eax
8010338a:	85 c0                	test   %eax,%eax
8010338c:	74 08                	je     80103396 <pipealloc+0xd6>
    fileclose(*f0);
8010338e:	89 04 24             	mov    %eax,(%esp)
80103391:	e8 4a da ff ff       	call   80100de0 <fileclose>
  if(*f1)
80103396:	8b 03                	mov    (%ebx),%eax
    fileclose(*f1);
  return -1;
80103398:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
    fileclose(*f0);
  if(*f1)
8010339d:	85 c0                	test   %eax,%eax
8010339f:	74 d5                	je     80103376 <pipealloc+0xb6>
    fileclose(*f1);
801033a1:	89 04 24             	mov    %eax,(%esp)
801033a4:	e8 37 da ff ff       	call   80100de0 <fileclose>
  return -1;
}
801033a9:	89 d8                	mov    %ebx,%eax
801033ab:	8b 75 f8             	mov    -0x8(%ebp),%esi
801033ae:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801033b1:	8b 7d fc             	mov    -0x4(%ebp),%edi
801033b4:	89 ec                	mov    %ebp,%esp
801033b6:	5d                   	pop    %ebp
801033b7:	c3                   	ret    
801033b8:	90                   	nop
801033b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801033c0 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801033c0:	55                   	push   %ebp
801033c1:	89 e5                	mov    %esp,%ebp
801033c3:	83 ec 18             	sub    $0x18,%esp
801033c6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801033c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801033cc:	89 75 fc             	mov    %esi,-0x4(%ebp)
801033cf:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801033d2:	89 1c 24             	mov    %ebx,(%esp)
801033d5:	e8 96 0d 00 00       	call   80104170 <acquire>
  if(writable){
801033da:	85 f6                	test   %esi,%esi
801033dc:	74 42                	je     80103420 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
801033de:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
void
pipeclose(struct pipe *p, int writable)
{
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
801033e4:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
801033eb:	00 00 00 
    wakeup(&p->nread);
801033ee:	89 04 24             	mov    %eax,(%esp)
801033f1:	e8 4a 0b 00 00       	call   80103f40 <wakeup>
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
801033f6:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801033fc:	85 d2                	test   %edx,%edx
801033fe:	75 0a                	jne    8010340a <pipeclose+0x4a>
80103400:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103406:	85 c0                	test   %eax,%eax
80103408:	74 36                	je     80103440 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010340a:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010340d:	8b 75 fc             	mov    -0x4(%ebp),%esi
80103410:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80103413:	89 ec                	mov    %ebp,%esp
80103415:	5d                   	pop    %ebp
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103416:	e9 85 0e 00 00       	jmp    801042a0 <release>
8010341b:	90                   	nop
8010341c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
80103420:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
80103426:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
8010342d:	00 00 00 
    wakeup(&p->nwrite);
80103430:	89 04 24             	mov    %eax,(%esp)
80103433:	e8 08 0b 00 00       	call   80103f40 <wakeup>
80103438:	eb bc                	jmp    801033f6 <pipeclose+0x36>
8010343a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
80103440:	89 1c 24             	mov    %ebx,(%esp)
80103443:	e8 58 0e 00 00       	call   801042a0 <release>
    kfree((char*)p);
  } else
    release(&p->lock);
}
80103448:	8b 75 fc             	mov    -0x4(%ebp),%esi
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
8010344b:	89 5d 08             	mov    %ebx,0x8(%ebp)
  } else
    release(&p->lock);
}
8010344e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80103451:	89 ec                	mov    %ebp,%esp
80103453:	5d                   	pop    %ebp
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
80103454:	e9 d7 ee ff ff       	jmp    80102330 <kfree>
80103459:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103460 <pipewrite>:
}

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103460:	55                   	push   %ebp
80103461:	89 e5                	mov    %esp,%ebp
80103463:	57                   	push   %edi
80103464:	56                   	push   %esi
80103465:	53                   	push   %ebx
80103466:	83 ec 2c             	sub    $0x2c,%esp
80103469:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i;

  acquire(&p->lock);
8010346c:	89 3c 24             	mov    %edi,(%esp)
8010346f:	e8 fc 0c 00 00       	call   80104170 <acquire>
  for(i = 0; i < n; i++){
80103474:	8b 45 10             	mov    0x10(%ebp),%eax
80103477:	85 c0                	test   %eax,%eax
80103479:	0f 8e bc 00 00 00    	jle    8010353b <pipewrite+0xdb>
8010347f:	8b 45 0c             	mov    0xc(%ebp),%eax
80103482:	8d b7 34 02 00 00    	lea    0x234(%edi),%esi
80103488:	8b 97 38 02 00 00    	mov    0x238(%edi),%edx
8010348e:	8d 9f 38 02 00 00    	lea    0x238(%edi),%ebx
80103494:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    release(&p->lock);
}

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
80103497:	03 45 10             	add    0x10(%ebp),%eax
8010349a:	89 45 e0             	mov    %eax,-0x20(%ebp)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010349d:	8b 8f 34 02 00 00    	mov    0x234(%edi),%ecx
801034a3:	81 c1 00 02 00 00    	add    $0x200,%ecx
801034a9:	39 ca                	cmp    %ecx,%edx
801034ab:	75 63                	jne    80103510 <pipewrite+0xb0>
      if(p->readopen == 0 || proc->killed){
801034ad:	8b 97 3c 02 00 00    	mov    0x23c(%edi),%edx
801034b3:	85 d2                	test   %edx,%edx
801034b5:	0f 84 9d 00 00 00    	je     80103558 <pipewrite+0xf8>
801034bb:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801034c2:	8b 42 24             	mov    0x24(%edx),%eax
801034c5:	85 c0                	test   %eax,%eax
801034c7:	74 1e                	je     801034e7 <pipewrite+0x87>
801034c9:	e9 8a 00 00 00       	jmp    80103558 <pipewrite+0xf8>
801034ce:	66 90                	xchg   %ax,%ax
801034d0:	8b 87 3c 02 00 00    	mov    0x23c(%edi),%eax
801034d6:	85 c0                	test   %eax,%eax
801034d8:	74 7e                	je     80103558 <pipewrite+0xf8>
801034da:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801034e0:	8b 48 24             	mov    0x24(%eax),%ecx
801034e3:	85 c9                	test   %ecx,%ecx
801034e5:	75 71                	jne    80103558 <pipewrite+0xf8>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801034e7:	89 34 24             	mov    %esi,(%esp)
801034ea:	e8 51 0a 00 00       	call   80103f40 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801034ef:	89 7c 24 04          	mov    %edi,0x4(%esp)
801034f3:	89 1c 24             	mov    %ebx,(%esp)
801034f6:	e8 a5 08 00 00       	call   80103da0 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801034fb:	8b 87 34 02 00 00    	mov    0x234(%edi),%eax
80103501:	8b 97 38 02 00 00    	mov    0x238(%edi),%edx
80103507:	05 00 02 00 00       	add    $0x200,%eax
8010350c:	39 c2                	cmp    %eax,%edx
8010350e:	74 c0                	je     801034d0 <pipewrite+0x70>
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103510:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103513:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80103517:	0f b6 01             	movzbl (%ecx),%eax
8010351a:	89 d1                	mov    %edx,%ecx
8010351c:	83 c2 01             	add    $0x1,%edx
8010351f:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80103525:	88 44 0f 34          	mov    %al,0x34(%edi,%ecx,1)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
80103529:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010352c:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010352f:	89 97 38 02 00 00    	mov    %edx,0x238(%edi)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
80103535:	0f 85 62 ff ff ff    	jne    8010349d <pipewrite+0x3d>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
8010353b:	8d 97 34 02 00 00    	lea    0x234(%edi),%edx
80103541:	89 14 24             	mov    %edx,(%esp)
80103544:	e8 f7 09 00 00       	call   80103f40 <wakeup>
  release(&p->lock);
80103549:	89 3c 24             	mov    %edi,(%esp)
8010354c:	e8 4f 0d 00 00       	call   801042a0 <release>
  return n;
80103551:	eb 14                	jmp    80103567 <pipewrite+0x107>
80103553:	90                   	nop
80103554:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
        release(&p->lock);
80103558:	89 3c 24             	mov    %edi,(%esp)
8010355b:	e8 40 0d 00 00       	call   801042a0 <release>
        return -1;
80103560:	c7 45 10 ff ff ff ff 	movl   $0xffffffff,0x10(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103567:	8b 45 10             	mov    0x10(%ebp),%eax
8010356a:	83 c4 2c             	add    $0x2c,%esp
8010356d:	5b                   	pop    %ebx
8010356e:	5e                   	pop    %esi
8010356f:	5f                   	pop    %edi
80103570:	5d                   	pop    %ebp
80103571:	c3                   	ret    
80103572:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103579:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103580 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103580:	55                   	push   %ebp
80103581:	89 e5                	mov    %esp,%ebp
80103583:	57                   	push   %edi
80103584:	56                   	push   %esi
80103585:	53                   	push   %ebx
80103586:	83 ec 2c             	sub    $0x2c,%esp
80103589:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010358c:	8b 7d 10             	mov    0x10(%ebp),%edi
  int i;

  acquire(&p->lock);
8010358f:	89 1c 24             	mov    %ebx,(%esp)
80103592:	e8 d9 0b 00 00       	call   80104170 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103597:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
8010359d:	3b 8b 38 02 00 00    	cmp    0x238(%ebx),%ecx
801035a3:	75 5b                	jne    80103600 <piperead+0x80>
801035a5:	8b b3 40 02 00 00    	mov    0x240(%ebx),%esi
801035ab:	85 f6                	test   %esi,%esi
801035ad:	74 51                	je     80103600 <piperead+0x80>
801035af:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
801035b5:	eb 25                	jmp    801035dc <piperead+0x5c>
801035b7:	90                   	nop
    if(proc->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801035b8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801035bc:	89 34 24             	mov    %esi,(%esp)
801035bf:	e8 dc 07 00 00       	call   80103da0 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801035c4:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
801035ca:	3b 8b 38 02 00 00    	cmp    0x238(%ebx),%ecx
801035d0:	75 2e                	jne    80103600 <piperead+0x80>
801035d2:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801035d8:	85 c0                	test   %eax,%eax
801035da:	74 24                	je     80103600 <piperead+0x80>
    if(proc->killed){
801035dc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801035e2:	8b 50 24             	mov    0x24(%eax),%edx
801035e5:	85 d2                	test   %edx,%edx
801035e7:	74 cf                	je     801035b8 <piperead+0x38>
      release(&p->lock);
801035e9:	89 1c 24             	mov    %ebx,(%esp)
801035ec:	e8 af 0c 00 00       	call   801042a0 <release>
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
801035f1:	83 c4 2c             	add    $0x2c,%esp

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
    if(proc->killed){
      release(&p->lock);
      return -1;
801035f4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
801035f9:	5b                   	pop    %ebx
801035fa:	5e                   	pop    %esi
801035fb:	5f                   	pop    %edi
801035fc:	5d                   	pop    %ebp
801035fd:	c3                   	ret    
801035fe:	66 90                	xchg   %ax,%ax
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103600:	85 ff                	test   %edi,%edi
80103602:	7e 60                	jle    80103664 <piperead+0xe4>
    if(p->nread == p->nwrite)
80103604:	3b 8b 38 02 00 00    	cmp    0x238(%ebx),%ecx
8010360a:	74 58                	je     80103664 <piperead+0xe4>
  release(&p->lock);
  return n;
}

int
piperead(struct pipe *p, char *addr, int n)
8010360c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010360f:	01 cf                	add    %ecx,%edi
80103611:	89 ca                	mov    %ecx,%edx
80103613:	29 ce                	sub    %ecx,%esi
80103615:	eb 09                	jmp    80103620 <piperead+0xa0>
80103617:	90                   	nop
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    if(p->nread == p->nwrite)
80103618:	39 93 38 02 00 00    	cmp    %edx,0x238(%ebx)
8010361e:	74 20                	je     80103640 <piperead+0xc0>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103620:	89 d0                	mov    %edx,%eax
80103622:	25 ff 01 00 00       	and    $0x1ff,%eax
80103627:	0f b6 44 03 34       	movzbl 0x34(%ebx,%eax,1),%eax
8010362c:	88 04 16             	mov    %al,(%esi,%edx,1)
8010362f:	83 c2 01             	add    $0x1,%edx
  release(&p->lock);
  return n;
}

int
piperead(struct pipe *p, char *addr, int n)
80103632:	89 d0                	mov    %edx,%eax
80103634:	29 c8                	sub    %ecx,%eax
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103636:	39 fa                	cmp    %edi,%edx
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103638:	89 93 34 02 00 00    	mov    %edx,0x234(%ebx)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010363e:	75 d8                	jne    80103618 <piperead+0x98>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103640:	8d 93 38 02 00 00    	lea    0x238(%ebx),%edx
80103646:	89 14 24             	mov    %edx,(%esp)
80103649:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010364c:	e8 ef 08 00 00       	call   80103f40 <wakeup>
  release(&p->lock);
80103651:	89 1c 24             	mov    %ebx,(%esp)
80103654:	e8 47 0c 00 00       	call   801042a0 <release>
80103659:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  return i;
}
8010365c:	83 c4 2c             	add    $0x2c,%esp
8010365f:	5b                   	pop    %ebx
80103660:	5e                   	pop    %esi
80103661:	5f                   	pop    %edi
80103662:	5d                   	pop    %ebp
80103663:	c3                   	ret    
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    if(p->nread == p->nwrite)
80103664:	31 c0                	xor    %eax,%eax
80103666:	eb d8                	jmp    80103640 <piperead+0xc0>
80103668:	66 90                	xchg   %ax,%ax
8010366a:	66 90                	xchg   %ax,%ax
8010366c:	66 90                	xchg   %ax,%ax
8010366e:	66 90                	xchg   %ax,%ax

80103670 <allocproc>:
// state required to run in the kernel.
// Otherwise return 0.
// Must hold ptable.lock.
static struct proc*
allocproc(void)
{
80103670:	55                   	push   %ebp
80103671:	89 e5                	mov    %esp,%ebp
80103673:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103674:	bb f4 18 11 80       	mov    $0x801118f4,%ebx
// state required to run in the kernel.
// Otherwise return 0.
// Must hold ptable.lock.
static struct proc*
allocproc(void)
{
80103679:	83 ec 14             	sub    $0x14,%esp
8010367c:	eb 0d                	jmp    8010368b <allocproc+0x1b>
8010367e:	66 90                	xchg   %ax,%ax
  struct proc *p;
  char *sp;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103680:	83 c3 7c             	add    $0x7c,%ebx
80103683:	81 fb f4 37 11 80    	cmp    $0x801137f4,%ebx
80103689:	74 7d                	je     80103708 <allocproc+0x98>
    if(p->state == UNUSED)
8010368b:	8b 43 0c             	mov    0xc(%ebx),%eax
8010368e:	85 c0                	test   %eax,%eax
80103690:	75 ee                	jne    80103680 <allocproc+0x10>
      goto found;
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103692:	a1 04 a0 10 80       	mov    0x8010a004,%eax
    if(p->state == UNUSED)
      goto found;
  return 0;

found:
  p->state = EMBRYO;
80103697:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
8010369e:	89 43 10             	mov    %eax,0x10(%ebx)
801036a1:	83 c0 01             	add    $0x1,%eax
801036a4:	a3 04 a0 10 80       	mov    %eax,0x8010a004

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801036a9:	e8 f2 ed ff ff       	call   801024a0 <kalloc>
801036ae:	85 c0                	test   %eax,%eax
801036b0:	89 43 08             	mov    %eax,0x8(%ebx)
801036b3:	74 45                	je     801036fa <allocproc+0x8a>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801036b5:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
801036bb:	89 53 18             	mov    %edx,0x18(%ebx)
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;
801036be:	c7 80 b0 0f 00 00 ad 	movl   $0x801055ad,0xfb0(%eax)
801036c5:	55 10 80 

  sp -= sizeof *p->context;
801036c8:	05 9c 0f 00 00       	add    $0xf9c,%eax
  p->context = (struct context*)sp;
801036cd:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
801036d0:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
801036d7:	00 
801036d8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801036df:	00 
801036e0:	89 04 24             	mov    %eax,(%esp)
801036e3:	e8 08 0c 00 00       	call   801042f0 <memset>
  p->context->eip = (uint)forkret;
801036e8:	8b 43 1c             	mov    0x1c(%ebx),%eax
801036eb:	c7 40 10 20 37 10 80 	movl   $0x80103720,0x10(%eax)

  return p;
}
801036f2:	83 c4 14             	add    $0x14,%esp
801036f5:	89 d8                	mov    %ebx,%eax
801036f7:	5b                   	pop    %ebx
801036f8:	5d                   	pop    %ebp
801036f9:	c3                   	ret    
  p->state = EMBRYO;
  p->pid = nextpid++;

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
801036fa:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
80103701:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return 0;
80103708:	31 db                	xor    %ebx,%ebx
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}
8010370a:	83 c4 14             	add    $0x14,%esp
8010370d:	89 d8                	mov    %ebx,%eax
8010370f:	5b                   	pop    %ebx
80103710:	5d                   	pop    %ebp
80103711:	c3                   	ret    
80103712:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103720 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103720:	55                   	push   %ebp
80103721:	89 e5                	mov    %esp,%ebp
80103723:	83 ec 18             	sub    $0x18,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103726:	c7 04 24 c0 18 11 80 	movl   $0x801118c0,(%esp)
8010372d:	e8 6e 0b 00 00       	call   801042a0 <release>

  if (first) {
80103732:	a1 08 a0 10 80       	mov    0x8010a008,%eax
80103737:	85 c0                	test   %eax,%eax
80103739:	75 05                	jne    80103740 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010373b:	c9                   	leave  
8010373c:	c3                   	ret    
8010373d:	8d 76 00             	lea    0x0(%esi),%esi
  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
80103740:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
80103747:	c7 05 08 a0 10 80 00 	movl   $0x0,0x8010a008
8010374e:	00 00 00 
    iinit(ROOTDEV);
80103751:	e8 2a dd ff ff       	call   80101480 <iinit>
    initlog(ROOTDEV);
80103756:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010375d:	e8 7e f3 ff ff       	call   80102ae0 <initlog>
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103762:	c9                   	leave  
80103763:	c3                   	ret    
80103764:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010376a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103770 <getpid>:

static void wakeup1(void *chan);

//Fetch PID of specified process
int
getpid(int procnum) {
80103770:	55                   	push   %ebp
80103771:	89 e5                	mov    %esp,%ebp

  //If process is valid, return pid
  if(ptable.proc[procnum].state != UNUSED)
80103773:	6b 45 08 7c          	imul   $0x7c,0x8(%ebp),%eax
80103777:	8b 90 00 19 11 80    	mov    -0x7feee700(%eax),%edx
8010377d:	85 d2                	test   %edx,%edx
8010377f:	74 0f                	je     80103790 <getpid+0x20>
    return (ptable.proc[procnum].pid);
80103781:	8b 80 04 19 11 80    	mov    -0x7feee6fc(%eax),%eax
  else
    return -2;

}
80103787:	5d                   	pop    %ebp
80103788:	c3                   	ret    
80103789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  //If process is valid, return pid
  if(ptable.proc[procnum].state != UNUSED)
    return (ptable.proc[procnum].pid);
  else
    return -2;
80103790:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax

}
80103795:	5d                   	pop    %ebp
80103796:	c3                   	ret    
80103797:	89 f6                	mov    %esi,%esi
80103799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801037a0 <getppid>:

//Fetch PPID of specified process
int
getppid(int procnum) {
801037a0:	55                   	push   %ebp
801037a1:	89 e5                	mov    %esp,%ebp


  if(ptable.proc[procnum].state != UNUSED) {
801037a3:	6b 45 08 7c          	imul   $0x7c,0x8(%ebp),%eax
801037a7:	8b 90 00 19 11 80    	mov    -0x7feee700(%eax),%edx
801037ad:	85 d2                	test   %edx,%edx
801037af:	74 17                	je     801037c8 <getppid+0x28>
    //If the parent PID is less than 0, there's no parent
    if(ptable.proc[procnum].parent->pid < 0)
801037b1:	8b 80 08 19 11 80    	mov    -0x7feee6f8(%eax),%eax
      return (ptable.proc[procnum].parent->pid);
  }
  else
    return -2;

}
801037b7:	5d                   	pop    %ebp
getppid(int procnum) {


  if(ptable.proc[procnum].state != UNUSED) {
    //If the parent PID is less than 0, there's no parent
    if(ptable.proc[procnum].parent->pid < 0)
801037b8:	8b 50 10             	mov    0x10(%eax),%edx
801037bb:	31 c0                	xor    %eax,%eax
801037bd:	85 d2                	test   %edx,%edx
801037bf:	0f 49 c2             	cmovns %edx,%eax
      return (ptable.proc[procnum].parent->pid);
  }
  else
    return -2;

}
801037c2:	c3                   	ret    
801037c3:	90                   	nop
801037c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    else
      return (ptable.proc[procnum].parent->pid);
  }
  else
    return -2;
801037c8:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax

}
801037cd:	5d                   	pop    %ebp
801037ce:	c3                   	ret    
801037cf:	90                   	nop

801037d0 <getprocname>:

//Get name of specified process
int getprocname(int procnum, char* dest) {
801037d0:	55                   	push   %ebp
801037d1:	89 e5                	mov    %esp,%ebp

  int i = 0;

  if(ptable.proc[procnum].state != UNUSED) {
801037d3:	6b 4d 08 7c          	imul   $0x7c,0x8(%ebp),%ecx
    return -2;

}

//Get name of specified process
int getprocname(int procnum, char* dest) {
801037d7:	53                   	push   %ebx
801037d8:	8b 5d 0c             	mov    0xc(%ebp),%ebx

  int i = 0;

  if(ptable.proc[procnum].state != UNUSED) {
801037db:	8b 81 00 19 11 80    	mov    -0x7feee700(%ecx),%eax
801037e1:	85 c0                	test   %eax,%eax
801037e3:	74 2a                	je     8010380f <getprocname+0x3f>

    for(i = 0; ptable.proc[procnum].name[i] != '\0'; i++) {
801037e5:	0f b6 91 60 19 11 80 	movzbl -0x7feee6a0(%ecx),%edx
    return -2;

}

//Get name of specified process
int getprocname(int procnum, char* dest) {
801037ec:	31 c0                	xor    %eax,%eax

  int i = 0;

  if(ptable.proc[procnum].state != UNUSED) {

    for(i = 0; ptable.proc[procnum].name[i] != '\0'; i++) {
801037ee:	84 d2                	test   %dl,%dl
801037f0:	74 18                	je     8010380a <getprocname+0x3a>
801037f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

      dest[i] = ptable.proc[procnum].name[i]; 
801037f8:	88 14 03             	mov    %dl,(%ebx,%eax,1)

  int i = 0;

  if(ptable.proc[procnum].state != UNUSED) {

    for(i = 0; ptable.proc[procnum].name[i] != '\0'; i++) {
801037fb:	83 c0 01             	add    $0x1,%eax
801037fe:	0f b6 94 01 60 19 11 	movzbl -0x7feee6a0(%ecx,%eax,1),%edx
80103805:	80 
80103806:	84 d2                	test   %dl,%dl
80103808:	75 ee                	jne    801037f8 <getprocname+0x28>

      dest[i] = ptable.proc[procnum].name[i]; 

    }

    return 0;
8010380a:	31 c0                	xor    %eax,%eax
  }
  else 
    return -2;

}
8010380c:	5b                   	pop    %ebx
8010380d:	5d                   	pop    %ebp
8010380e:	c3                   	ret    
    }

    return 0;
  }
  else 
    return -2;
8010380f:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
80103814:	eb f6                	jmp    8010380c <getprocname+0x3c>
80103816:	8d 76 00             	lea    0x0(%esi),%esi
80103819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103820 <pinit>:

}

void
pinit(void)
{
80103820:	55                   	push   %ebp
80103821:	89 e5                	mov    %esp,%ebp
80103823:	83 ec 18             	sub    $0x18,%esp
  initlock(&ptable.lock, "ptable");
80103826:	c7 44 24 04 3d 73 10 	movl   $0x8010733d,0x4(%esp)
8010382d:	80 
8010382e:	c7 04 24 c0 18 11 80 	movl   $0x801118c0,(%esp)
80103835:	e8 b6 08 00 00       	call   801040f0 <initlock>
}
8010383a:	c9                   	leave  
8010383b:	c3                   	ret    
8010383c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103840 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
80103840:	55                   	push   %ebp
80103841:	89 e5                	mov    %esp,%ebp
80103843:	53                   	push   %ebx
80103844:	83 ec 14             	sub    $0x14,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  acquire(&ptable.lock);
80103847:	c7 04 24 c0 18 11 80 	movl   $0x801118c0,(%esp)
8010384e:	e8 1d 09 00 00       	call   80104170 <acquire>

  p = allocproc();
80103853:	e8 18 fe ff ff       	call   80103670 <allocproc>
80103858:	89 c3                	mov    %eax,%ebx
  initproc = p;
8010385a:	a3 a4 a5 10 80       	mov    %eax,0x8010a5a4
  if((p->pgdir = setupkvm()) == 0)
8010385f:	e8 8c 2e 00 00       	call   801066f0 <setupkvm>
80103864:	85 c0                	test   %eax,%eax
80103866:	89 43 04             	mov    %eax,0x4(%ebx)
80103869:	0f 84 c2 00 00 00    	je     80103931 <userinit+0xf1>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
8010386f:	89 04 24             	mov    %eax,(%esp)
80103872:	c7 44 24 08 2c 00 00 	movl   $0x2c,0x8(%esp)
80103879:	00 
8010387a:	c7 44 24 04 60 a4 10 	movl   $0x8010a460,0x4(%esp)
80103881:	80 
80103882:	e8 c9 2f 00 00       	call   80106850 <inituvm>
  p->sz = PGSIZE;
80103887:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
8010388d:	c7 44 24 08 4c 00 00 	movl   $0x4c,0x8(%esp)
80103894:	00 
80103895:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010389c:	00 
8010389d:	8b 43 18             	mov    0x18(%ebx),%eax
801038a0:	89 04 24             	mov    %eax,(%esp)
801038a3:	e8 48 0a 00 00       	call   801042f0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801038a8:	8b 43 18             	mov    0x18(%ebx),%eax
801038ab:	66 c7 40 3c 23 00    	movw   $0x23,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801038b1:	8b 43 18             	mov    0x18(%ebx),%eax
801038b4:	66 c7 40 2c 2b 00    	movw   $0x2b,0x2c(%eax)
  p->tf->es = p->tf->ds;
801038ba:	8b 43 18             	mov    0x18(%ebx),%eax
801038bd:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801038c1:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801038c5:	8b 43 18             	mov    0x18(%ebx),%eax
801038c8:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801038cc:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801038d0:	8b 43 18             	mov    0x18(%ebx),%eax
801038d3:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801038da:	8b 43 18             	mov    0x18(%ebx),%eax
801038dd:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
801038e4:	8b 43 18             	mov    0x18(%ebx),%eax
801038e7:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
801038ee:	8d 43 6c             	lea    0x6c(%ebx),%eax
801038f1:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
801038f8:	00 
801038f9:	c7 44 24 04 5d 73 10 	movl   $0x8010735d,0x4(%esp)
80103900:	80 
80103901:	89 04 24             	mov    %eax,(%esp)
80103904:	e8 d7 0b 00 00       	call   801044e0 <safestrcpy>
  p->cwd = namei("/");
80103909:	c7 04 24 66 73 10 80 	movl   $0x80107366,(%esp)
80103910:	e8 1b e6 ff ff       	call   80101f30 <namei>

  p->state = RUNNABLE;
80103915:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->cwd = namei("/");
8010391c:	89 43 68             	mov    %eax,0x68(%ebx)

  p->state = RUNNABLE;

  release(&ptable.lock);
8010391f:	c7 04 24 c0 18 11 80 	movl   $0x801118c0,(%esp)
80103926:	e8 75 09 00 00       	call   801042a0 <release>
}
8010392b:	83 c4 14             	add    $0x14,%esp
8010392e:	5b                   	pop    %ebx
8010392f:	5d                   	pop    %ebp
80103930:	c3                   	ret    
  acquire(&ptable.lock);

  p = allocproc();
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
80103931:	c7 04 24 44 73 10 80 	movl   $0x80107344,(%esp)
80103938:	e8 f3 c9 ff ff       	call   80100330 <panic>
8010393d:	8d 76 00             	lea    0x0(%esi),%esi

80103940 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80103940:	55                   	push   %ebp
80103941:	89 e5                	mov    %esp,%ebp
80103943:	83 ec 18             	sub    $0x18,%esp
  uint sz;

  sz = proc->sz;
80103946:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
8010394d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  uint sz;

  sz = proc->sz;
80103950:	8b 02                	mov    (%edx),%eax
  if(n > 0){
80103952:	83 f9 00             	cmp    $0x0,%ecx
80103955:	7e 39                	jle    80103990 <growproc+0x50>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
80103957:	01 c1                	add    %eax,%ecx
80103959:	89 4c 24 08          	mov    %ecx,0x8(%esp)
8010395d:	89 44 24 04          	mov    %eax,0x4(%esp)
80103961:	8b 42 04             	mov    0x4(%edx),%eax
80103964:	89 04 24             	mov    %eax,(%esp)
80103967:	e8 d4 30 00 00       	call   80106a40 <allocuvm>
8010396c:	85 c0                	test   %eax,%eax
8010396e:	74 40                	je     801039b0 <growproc+0x70>
80103970:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  proc->sz = sz;
80103977:	89 02                	mov    %eax,(%edx)
  switchuvm(proc);
80103979:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010397f:	89 04 24             	mov    %eax,(%esp)
80103982:	e8 29 2e 00 00       	call   801067b0 <switchuvm>
  return 0;
80103987:	31 c0                	xor    %eax,%eax
}
80103989:	c9                   	leave  
8010398a:	c3                   	ret    
8010398b:	90                   	nop
8010398c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  sz = proc->sz;
  if(n > 0){
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
80103990:	74 e5                	je     80103977 <growproc+0x37>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
80103992:	01 c1                	add    %eax,%ecx
80103994:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80103998:	89 44 24 04          	mov    %eax,0x4(%esp)
8010399c:	8b 42 04             	mov    0x4(%edx),%eax
8010399f:	89 04 24             	mov    %eax,(%esp)
801039a2:	e8 f9 2f 00 00       	call   801069a0 <deallocuvm>
801039a7:	85 c0                	test   %eax,%eax
801039a9:	75 c5                	jne    80103970 <growproc+0x30>
801039ab:	90                   	nop
801039ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint sz;

  sz = proc->sz;
  if(n > 0){
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
      return -1;
801039b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return -1;
  }
  proc->sz = sz;
  switchuvm(proc);
  return 0;
}
801039b5:	c9                   	leave  
801039b6:	c3                   	ret    
801039b7:	89 f6                	mov    %esi,%esi
801039b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801039c0 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
801039c0:	55                   	push   %ebp
801039c1:	89 e5                	mov    %esp,%ebp
801039c3:	57                   	push   %edi
801039c4:	56                   	push   %esi
801039c5:	53                   	push   %ebx
801039c6:	83 ec 1c             	sub    $0x1c,%esp
  int i, pid;
  struct proc *np;

  acquire(&ptable.lock);
801039c9:	c7 04 24 c0 18 11 80 	movl   $0x801118c0,(%esp)
801039d0:	e8 9b 07 00 00       	call   80104170 <acquire>

  // Allocate process.
  if((np = allocproc()) == 0){
801039d5:	e8 96 fc ff ff       	call   80103670 <allocproc>
801039da:	85 c0                	test   %eax,%eax
801039dc:	89 c3                	mov    %eax,%ebx
801039de:	0f 84 e6 00 00 00    	je     80103aca <fork+0x10a>
    release(&ptable.lock);
    return -1;
  }

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
801039e4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801039ea:	8b 10                	mov    (%eax),%edx
801039ec:	89 54 24 04          	mov    %edx,0x4(%esp)
801039f0:	8b 40 04             	mov    0x4(%eax),%eax
801039f3:	89 04 24             	mov    %eax,(%esp)
801039f6:	e8 25 32 00 00       	call   80106c20 <copyuvm>
801039fb:	85 c0                	test   %eax,%eax
801039fd:	89 43 04             	mov    %eax,0x4(%ebx)
80103a00:	0f 84 ab 00 00 00    	je     80103ab1 <fork+0xf1>
    np->kstack = 0;
    np->state = UNUSED;
    release(&ptable.lock);
    return -1;
  }
  np->sz = proc->sz;
80103a06:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  np->parent = proc;
  *np->tf = *proc->tf;
80103a0c:	b9 13 00 00 00       	mov    $0x13,%ecx
80103a11:	8b 7b 18             	mov    0x18(%ebx),%edi
    np->kstack = 0;
    np->state = UNUSED;
    release(&ptable.lock);
    return -1;
  }
  np->sz = proc->sz;
80103a14:	8b 00                	mov    (%eax),%eax
80103a16:	89 03                	mov    %eax,(%ebx)
  np->parent = proc;
80103a18:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103a1e:	89 43 14             	mov    %eax,0x14(%ebx)
  *np->tf = *proc->tf;
80103a21:	8b 70 18             	mov    0x18(%eax),%esi
80103a24:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103a26:	31 f6                	xor    %esi,%esi
  np->sz = proc->sz;
  np->parent = proc;
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80103a28:	8b 43 18             	mov    0x18(%ebx),%eax
80103a2b:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103a32:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  for(i = 0; i < NOFILE; i++)
    if(proc->ofile[i])
80103a40:	8b 44 b2 28          	mov    0x28(%edx,%esi,4),%eax
80103a44:	85 c0                	test   %eax,%eax
80103a46:	74 13                	je     80103a5b <fork+0x9b>
      np->ofile[i] = filedup(proc->ofile[i]);
80103a48:	89 04 24             	mov    %eax,(%esp)
80103a4b:	e8 40 d3 ff ff       	call   80100d90 <filedup>
80103a50:	89 44 b3 28          	mov    %eax,0x28(%ebx,%esi,4)
80103a54:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103a5b:	83 c6 01             	add    $0x1,%esi
80103a5e:	83 fe 10             	cmp    $0x10,%esi
80103a61:	75 dd                	jne    80103a40 <fork+0x80>
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
80103a63:	8b 42 68             	mov    0x68(%edx),%eax
80103a66:	89 04 24             	mov    %eax,(%esp)
80103a69:	e8 f2 db ff ff       	call   80101660 <idup>
80103a6e:	89 43 68             	mov    %eax,0x68(%ebx)

  safestrcpy(np->name, proc->name, sizeof(proc->name));
80103a71:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103a77:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80103a7e:	00 
80103a7f:	83 c0 6c             	add    $0x6c,%eax
80103a82:	89 44 24 04          	mov    %eax,0x4(%esp)
80103a86:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103a89:	89 04 24             	mov    %eax,(%esp)
80103a8c:	e8 4f 0a 00 00       	call   801044e0 <safestrcpy>

  pid = np->pid;
80103a91:	8b 73 10             	mov    0x10(%ebx),%esi

  np->state = RUNNABLE;
80103a94:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  release(&ptable.lock);
80103a9b:	c7 04 24 c0 18 11 80 	movl   $0x801118c0,(%esp)
80103aa2:	e8 f9 07 00 00       	call   801042a0 <release>

  return pid;
}
80103aa7:	83 c4 1c             	add    $0x1c,%esp
80103aaa:	89 f0                	mov    %esi,%eax
80103aac:	5b                   	pop    %ebx
80103aad:	5e                   	pop    %esi
80103aae:	5f                   	pop    %edi
80103aaf:	5d                   	pop    %ebp
80103ab0:	c3                   	ret    
    return -1;
  }

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
    kfree(np->kstack);
80103ab1:	8b 43 08             	mov    0x8(%ebx),%eax
80103ab4:	89 04 24             	mov    %eax,(%esp)
80103ab7:	e8 74 e8 ff ff       	call   80102330 <kfree>
    np->kstack = 0;
80103abc:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
80103ac3:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    release(&ptable.lock);
80103aca:	c7 04 24 c0 18 11 80 	movl   $0x801118c0,(%esp)
    return -1;
80103ad1:	be ff ff ff ff       	mov    $0xffffffff,%esi
  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    release(&ptable.lock);
80103ad6:	e8 c5 07 00 00       	call   801042a0 <release>
    return -1;
80103adb:	eb ca                	jmp    80103aa7 <fork+0xe7>
80103add:	8d 76 00             	lea    0x0(%esi),%esi

80103ae0 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80103ae0:	55                   	push   %ebp
80103ae1:	89 e5                	mov    %esp,%ebp
80103ae3:	53                   	push   %ebx
80103ae4:	83 ec 14             	sub    $0x14,%esp
80103ae7:	90                   	nop
}

static inline void
sti(void)
{
  asm volatile("sti");
80103ae8:	fb                   	sti    
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103ae9:	c7 04 24 c0 18 11 80 	movl   $0x801118c0,(%esp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103af0:	bb f4 18 11 80       	mov    $0x801118f4,%ebx
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103af5:	e8 76 06 00 00       	call   80104170 <acquire>
80103afa:	eb 0f                	jmp    80103b0b <scheduler+0x2b>
80103afc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b00:	83 c3 7c             	add    $0x7c,%ebx
80103b03:	81 fb f4 37 11 80    	cmp    $0x801137f4,%ebx
80103b09:	74 55                	je     80103b60 <scheduler+0x80>
      if(p->state != RUNNABLE)
80103b0b:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103b0f:	75 ef                	jne    80103b00 <scheduler+0x20>

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
      switchuvm(p);
80103b11:	89 1c 24             	mov    %ebx,(%esp)
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
80103b14:	65 89 1d 04 00 00 00 	mov    %ebx,%gs:0x4
      switchuvm(p);
80103b1b:	e8 90 2c 00 00       	call   801067b0 <switchuvm>
      p->state = RUNNING;
      swtch(&cpu->scheduler, p->context);
80103b20:	8b 43 1c             	mov    0x1c(%ebx),%eax
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
      switchuvm(p);
      p->state = RUNNING;
80103b23:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b2a:	83 c3 7c             	add    $0x7c,%ebx
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
      switchuvm(p);
      p->state = RUNNING;
      swtch(&cpu->scheduler, p->context);
80103b2d:	89 44 24 04          	mov    %eax,0x4(%esp)
80103b31:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103b37:	83 c0 04             	add    $0x4,%eax
80103b3a:	89 04 24             	mov    %eax,(%esp)
80103b3d:	e8 f9 09 00 00       	call   8010453b <swtch>
      switchkvm();
80103b42:	e8 49 2c 00 00       	call   80106790 <switchkvm>
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b47:	81 fb f4 37 11 80    	cmp    $0x801137f4,%ebx
      swtch(&cpu->scheduler, p->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
80103b4d:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80103b54:	00 00 00 00 
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b58:	75 b1                	jne    80103b0b <scheduler+0x2b>
80103b5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
    }
    release(&ptable.lock);
80103b60:	c7 04 24 c0 18 11 80 	movl   $0x801118c0,(%esp)
80103b67:	e8 34 07 00 00       	call   801042a0 <release>

  }
80103b6c:	e9 77 ff ff ff       	jmp    80103ae8 <scheduler+0x8>
80103b71:	eb 0d                	jmp    80103b80 <sched>
80103b73:	90                   	nop
80103b74:	90                   	nop
80103b75:	90                   	nop
80103b76:	90                   	nop
80103b77:	90                   	nop
80103b78:	90                   	nop
80103b79:	90                   	nop
80103b7a:	90                   	nop
80103b7b:	90                   	nop
80103b7c:	90                   	nop
80103b7d:	90                   	nop
80103b7e:	90                   	nop
80103b7f:	90                   	nop

80103b80 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
80103b80:	55                   	push   %ebp
80103b81:	89 e5                	mov    %esp,%ebp
80103b83:	53                   	push   %ebx
80103b84:	83 ec 14             	sub    $0x14,%esp
  int intena;

  if(!holding(&ptable.lock))
80103b87:	c7 04 24 c0 18 11 80 	movl   $0x801118c0,(%esp)
80103b8e:	e8 6d 06 00 00       	call   80104200 <holding>
80103b93:	85 c0                	test   %eax,%eax
80103b95:	74 4d                	je     80103be4 <sched+0x64>
    panic("sched ptable.lock");
  if(cpu->ncli != 1)
80103b97:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103b9d:	83 b8 ac 00 00 00 01 	cmpl   $0x1,0xac(%eax)
80103ba4:	75 62                	jne    80103c08 <sched+0x88>
    panic("sched locks");
  if(proc->state == RUNNING)
80103ba6:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103bad:	83 7a 0c 04          	cmpl   $0x4,0xc(%edx)
80103bb1:	74 49                	je     80103bfc <sched+0x7c>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103bb3:	9c                   	pushf  
80103bb4:	59                   	pop    %ecx
    panic("sched running");
  if(readeflags()&FL_IF)
80103bb5:	80 e5 02             	and    $0x2,%ch
80103bb8:	75 36                	jne    80103bf0 <sched+0x70>
    panic("sched interruptible");
  intena = cpu->intena;
80103bba:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
  swtch(&proc->context, cpu->scheduler);
80103bc0:	83 c2 1c             	add    $0x1c,%edx
80103bc3:	8b 40 04             	mov    0x4(%eax),%eax
80103bc6:	89 14 24             	mov    %edx,(%esp)
80103bc9:	89 44 24 04          	mov    %eax,0x4(%esp)
80103bcd:	e8 69 09 00 00       	call   8010453b <swtch>
  cpu->intena = intena;
80103bd2:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103bd8:	89 98 b0 00 00 00    	mov    %ebx,0xb0(%eax)
}
80103bde:	83 c4 14             	add    $0x14,%esp
80103be1:	5b                   	pop    %ebx
80103be2:	5d                   	pop    %ebp
80103be3:	c3                   	ret    
sched(void)
{
  int intena;

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
80103be4:	c7 04 24 68 73 10 80 	movl   $0x80107368,(%esp)
80103beb:	e8 40 c7 ff ff       	call   80100330 <panic>
  if(cpu->ncli != 1)
    panic("sched locks");
  if(proc->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
80103bf0:	c7 04 24 94 73 10 80 	movl   $0x80107394,(%esp)
80103bf7:	e8 34 c7 ff ff       	call   80100330 <panic>
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(cpu->ncli != 1)
    panic("sched locks");
  if(proc->state == RUNNING)
    panic("sched running");
80103bfc:	c7 04 24 86 73 10 80 	movl   $0x80107386,(%esp)
80103c03:	e8 28 c7 ff ff       	call   80100330 <panic>
  int intena;

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(cpu->ncli != 1)
    panic("sched locks");
80103c08:	c7 04 24 7a 73 10 80 	movl   $0x8010737a,(%esp)
80103c0f:	e8 1c c7 ff ff       	call   80100330 <panic>
80103c14:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103c1a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103c20 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80103c20:	55                   	push   %ebp
80103c21:	89 e5                	mov    %esp,%ebp
80103c23:	56                   	push   %esi
80103c24:	53                   	push   %ebx
  struct proc *p;
  int fd;

  if(proc == initproc)
80103c25:	31 db                	xor    %ebx,%ebx
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80103c27:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  int fd;

  if(proc == initproc)
80103c2a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103c30:	3b 05 a4 a5 10 80    	cmp    0x8010a5a4,%eax
80103c36:	75 0e                	jne    80103c46 <exit+0x26>
80103c38:	e9 09 01 00 00       	jmp    80103d46 <exit+0x126>
80103c3d:	8d 76 00             	lea    0x0(%esi),%esi
80103c40:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd]){
80103c46:	8d 73 08             	lea    0x8(%ebx),%esi
80103c49:	8b 44 b0 08          	mov    0x8(%eax,%esi,4),%eax
80103c4d:	85 c0                	test   %eax,%eax
80103c4f:	74 16                	je     80103c67 <exit+0x47>
      fileclose(proc->ofile[fd]);
80103c51:	89 04 24             	mov    %eax,(%esp)
80103c54:	e8 87 d1 ff ff       	call   80100de0 <fileclose>
      proc->ofile[fd] = 0;
80103c59:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103c5f:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80103c66:	00 

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80103c67:	83 c3 01             	add    $0x1,%ebx
80103c6a:	83 fb 10             	cmp    $0x10,%ebx
80103c6d:	75 d1                	jne    80103c40 <exit+0x20>
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  begin_op();
80103c6f:	e8 0c ef ff ff       	call   80102b80 <begin_op>
  iput(proc->cwd);
80103c74:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103c7a:	8b 40 68             	mov    0x68(%eax),%eax
80103c7d:	89 04 24             	mov    %eax,(%esp)
80103c80:	e8 6b db ff ff       	call   801017f0 <iput>
  end_op();
80103c85:	e8 66 ef ff ff       	call   80102bf0 <end_op>
  proc->cwd = 0;
80103c8a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103c90:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

  acquire(&ptable.lock);
80103c97:	c7 04 24 c0 18 11 80 	movl   $0x801118c0,(%esp)
80103c9e:	e8 cd 04 00 00       	call   80104170 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
80103ca3:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103caa:	b8 f4 18 11 80       	mov    $0x801118f4,%eax
  proc->cwd = 0;

  acquire(&ptable.lock);

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
80103caf:	8b 51 14             	mov    0x14(%ecx),%edx
80103cb2:	eb 0e                	jmp    80103cc2 <exit+0xa2>
80103cb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103cb8:	83 c0 7c             	add    $0x7c,%eax
80103cbb:	3d f4 37 11 80       	cmp    $0x801137f4,%eax
80103cc0:	74 1c                	je     80103cde <exit+0xbe>
    if(p->state == SLEEPING && p->chan == chan)
80103cc2:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103cc6:	75 f0                	jne    80103cb8 <exit+0x98>
80103cc8:	3b 50 20             	cmp    0x20(%eax),%edx
80103ccb:	75 eb                	jne    80103cb8 <exit+0x98>
      p->state = RUNNABLE;
80103ccd:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103cd4:	83 c0 7c             	add    $0x7c,%eax
80103cd7:	3d f4 37 11 80       	cmp    $0x801137f4,%eax
80103cdc:	75 e4                	jne    80103cc2 <exit+0xa2>
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc){
      p->parent = initproc;
80103cde:	8b 1d a4 a5 10 80    	mov    0x8010a5a4,%ebx
80103ce4:	ba f4 18 11 80       	mov    $0x801118f4,%edx
80103ce9:	eb 10                	jmp    80103cfb <exit+0xdb>
80103ceb:	90                   	nop
80103cec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103cf0:	83 c2 7c             	add    $0x7c,%edx
80103cf3:	81 fa f4 37 11 80    	cmp    $0x801137f4,%edx
80103cf9:	74 33                	je     80103d2e <exit+0x10e>
    if(p->parent == proc){
80103cfb:	3b 4a 14             	cmp    0x14(%edx),%ecx
80103cfe:	75 f0                	jne    80103cf0 <exit+0xd0>
      p->parent = initproc;
      if(p->state == ZOMBIE)
80103d00:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc){
      p->parent = initproc;
80103d04:	89 5a 14             	mov    %ebx,0x14(%edx)
      if(p->state == ZOMBIE)
80103d07:	75 e7                	jne    80103cf0 <exit+0xd0>
80103d09:	b8 f4 18 11 80       	mov    $0x801118f4,%eax
80103d0e:	eb 0a                	jmp    80103d1a <exit+0xfa>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d10:	83 c0 7c             	add    $0x7c,%eax
80103d13:	3d f4 37 11 80       	cmp    $0x801137f4,%eax
80103d18:	74 d6                	je     80103cf0 <exit+0xd0>
    if(p->state == SLEEPING && p->chan == chan)
80103d1a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103d1e:	75 f0                	jne    80103d10 <exit+0xf0>
80103d20:	3b 58 20             	cmp    0x20(%eax),%ebx
80103d23:	75 eb                	jne    80103d10 <exit+0xf0>
      p->state = RUNNABLE;
80103d25:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103d2c:	eb e2                	jmp    80103d10 <exit+0xf0>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
80103d2e:	c7 41 0c 05 00 00 00 	movl   $0x5,0xc(%ecx)
  sched();
80103d35:	e8 46 fe ff ff       	call   80103b80 <sched>
  panic("zombie exit");
80103d3a:	c7 04 24 b5 73 10 80 	movl   $0x801073b5,(%esp)
80103d41:	e8 ea c5 ff ff       	call   80100330 <panic>
{
  struct proc *p;
  int fd;

  if(proc == initproc)
    panic("init exiting");
80103d46:	c7 04 24 a8 73 10 80 	movl   $0x801073a8,(%esp)
80103d4d:	e8 de c5 ff ff       	call   80100330 <panic>
80103d52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103d60 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
80103d60:	55                   	push   %ebp
80103d61:	89 e5                	mov    %esp,%ebp
80103d63:	83 ec 18             	sub    $0x18,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103d66:	c7 04 24 c0 18 11 80 	movl   $0x801118c0,(%esp)
80103d6d:	e8 fe 03 00 00       	call   80104170 <acquire>
  proc->state = RUNNABLE;
80103d72:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103d78:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80103d7f:	e8 fc fd ff ff       	call   80103b80 <sched>
  release(&ptable.lock);
80103d84:	c7 04 24 c0 18 11 80 	movl   $0x801118c0,(%esp)
80103d8b:	e8 10 05 00 00       	call   801042a0 <release>
}
80103d90:	c9                   	leave  
80103d91:	c3                   	ret    
80103d92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103da0 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80103da0:	55                   	push   %ebp
80103da1:	89 e5                	mov    %esp,%ebp
80103da3:	56                   	push   %esi
80103da4:	53                   	push   %ebx
80103da5:	83 ec 10             	sub    $0x10,%esp
  if(proc == 0)
80103da8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80103dae:	8b 75 08             	mov    0x8(%ebp),%esi
80103db1:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(proc == 0)
80103db4:	85 c0                	test   %eax,%eax
80103db6:	0f 84 8b 00 00 00    	je     80103e47 <sleep+0xa7>
    panic("sleep");

  if(lk == 0)
80103dbc:	85 db                	test   %ebx,%ebx
80103dbe:	74 7b                	je     80103e3b <sleep+0x9b>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103dc0:	81 fb c0 18 11 80    	cmp    $0x801118c0,%ebx
80103dc6:	74 50                	je     80103e18 <sleep+0x78>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103dc8:	c7 04 24 c0 18 11 80 	movl   $0x801118c0,(%esp)
80103dcf:	e8 9c 03 00 00       	call   80104170 <acquire>
    release(lk);
80103dd4:	89 1c 24             	mov    %ebx,(%esp)
80103dd7:	e8 c4 04 00 00       	call   801042a0 <release>
  }

  // Go to sleep.
  proc->chan = chan;
80103ddc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103de2:	89 70 20             	mov    %esi,0x20(%eax)
  proc->state = SLEEPING;
80103de5:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80103dec:	e8 8f fd ff ff       	call   80103b80 <sched>

  // Tidy up.
  proc->chan = 0;
80103df1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103df7:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
80103dfe:	c7 04 24 c0 18 11 80 	movl   $0x801118c0,(%esp)
80103e05:	e8 96 04 00 00       	call   801042a0 <release>
    acquire(lk);
80103e0a:	89 5d 08             	mov    %ebx,0x8(%ebp)
  }
}
80103e0d:	83 c4 10             	add    $0x10,%esp
80103e10:	5b                   	pop    %ebx
80103e11:	5e                   	pop    %esi
80103e12:	5d                   	pop    %ebp
  proc->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
80103e13:	e9 58 03 00 00       	jmp    80104170 <acquire>
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }

  // Go to sleep.
  proc->chan = chan;
80103e18:	89 70 20             	mov    %esi,0x20(%eax)
  proc->state = SLEEPING;
80103e1b:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80103e22:	e8 59 fd ff ff       	call   80103b80 <sched>

  // Tidy up.
  proc->chan = 0;
80103e27:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103e2d:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
80103e34:	83 c4 10             	add    $0x10,%esp
80103e37:	5b                   	pop    %ebx
80103e38:	5e                   	pop    %esi
80103e39:	5d                   	pop    %ebp
80103e3a:	c3                   	ret    
{
  if(proc == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
80103e3b:	c7 04 24 c7 73 10 80 	movl   $0x801073c7,(%esp)
80103e42:	e8 e9 c4 ff ff       	call   80100330 <panic>
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  if(proc == 0)
    panic("sleep");
80103e47:	c7 04 24 c1 73 10 80 	movl   $0x801073c1,(%esp)
80103e4e:	e8 dd c4 ff ff       	call   80100330 <panic>
80103e53:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103e59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103e60 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80103e60:	55                   	push   %ebp
80103e61:	89 e5                	mov    %esp,%ebp
80103e63:	56                   	push   %esi
80103e64:	53                   	push   %ebx
80103e65:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
80103e68:	c7 04 24 c0 18 11 80 	movl   $0x801118c0,(%esp)
80103e6f:	e8 fc 02 00 00       	call   80104170 <acquire>
80103e74:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
80103e7a:	31 d2                	xor    %edx,%edx
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e7c:	bb f4 18 11 80       	mov    $0x801118f4,%ebx
80103e81:	eb 10                	jmp    80103e93 <wait+0x33>
80103e83:	90                   	nop
80103e84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103e88:	83 c3 7c             	add    $0x7c,%ebx
80103e8b:	81 fb f4 37 11 80    	cmp    $0x801137f4,%ebx
80103e91:	74 1d                	je     80103eb0 <wait+0x50>
      if(p->parent != proc)
80103e93:	39 43 14             	cmp    %eax,0x14(%ebx)
80103e96:	75 f0                	jne    80103e88 <wait+0x28>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
80103e98:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103e9c:	74 2f                	je     80103ecd <wait+0x6d>

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e9e:	83 c3 7c             	add    $0x7c,%ebx
      if(p->parent != proc)
        continue;
      havekids = 1;
80103ea1:	ba 01 00 00 00       	mov    $0x1,%edx

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ea6:	81 fb f4 37 11 80    	cmp    $0x801137f4,%ebx
80103eac:	75 e5                	jne    80103e93 <wait+0x33>
80103eae:	66 90                	xchg   %ax,%ax
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
80103eb0:	85 d2                	test   %edx,%edx
80103eb2:	74 6e                	je     80103f22 <wait+0xc2>
80103eb4:	8b 50 24             	mov    0x24(%eax),%edx
80103eb7:	85 d2                	test   %edx,%edx
80103eb9:	75 67                	jne    80103f22 <wait+0xc2>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
80103ebb:	c7 44 24 04 c0 18 11 	movl   $0x801118c0,0x4(%esp)
80103ec2:	80 
80103ec3:	89 04 24             	mov    %eax,(%esp)
80103ec6:	e8 d5 fe ff ff       	call   80103da0 <sleep>
  }
80103ecb:	eb a7                	jmp    80103e74 <wait+0x14>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
80103ecd:	8b 43 08             	mov    0x8(%ebx),%eax
      if(p->parent != proc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
80103ed0:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103ed3:	89 04 24             	mov    %eax,(%esp)
80103ed6:	e8 55 e4 ff ff       	call   80102330 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
80103edb:	8b 43 04             	mov    0x4(%ebx),%eax
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
80103ede:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103ee5:	89 04 24             	mov    %eax,(%esp)
80103ee8:	e8 83 2c 00 00       	call   80106b70 <freevm>
        p->pid = 0;
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
80103eed:	c7 04 24 c0 18 11 80 	movl   $0x801118c0,(%esp)
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
        freevm(p->pgdir);
        p->pid = 0;
80103ef4:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103efb:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103f02:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103f06:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103f0d:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103f14:	e8 87 03 00 00       	call   801042a0 <release>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103f19:	83 c4 10             	add    $0x10,%esp
80103f1c:	89 f0                	mov    %esi,%eax
80103f1e:	5b                   	pop    %ebx
80103f1f:	5e                   	pop    %esi
80103f20:	5d                   	pop    %ebp
80103f21:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
      release(&ptable.lock);
80103f22:	c7 04 24 c0 18 11 80 	movl   $0x801118c0,(%esp)
      return -1;
80103f29:	be ff ff ff ff       	mov    $0xffffffff,%esi
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
      release(&ptable.lock);
80103f2e:	e8 6d 03 00 00       	call   801042a0 <release>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103f33:	83 c4 10             	add    $0x10,%esp
80103f36:	89 f0                	mov    %esi,%eax
80103f38:	5b                   	pop    %ebx
80103f39:	5e                   	pop    %esi
80103f3a:	5d                   	pop    %ebp
80103f3b:	c3                   	ret    
80103f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103f40 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80103f40:	55                   	push   %ebp
80103f41:	89 e5                	mov    %esp,%ebp
80103f43:	53                   	push   %ebx
80103f44:	83 ec 14             	sub    $0x14,%esp
80103f47:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80103f4a:	c7 04 24 c0 18 11 80 	movl   $0x801118c0,(%esp)
80103f51:	e8 1a 02 00 00       	call   80104170 <acquire>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f56:	b8 f4 18 11 80       	mov    $0x801118f4,%eax
80103f5b:	eb 0d                	jmp    80103f6a <wakeup+0x2a>
80103f5d:	8d 76 00             	lea    0x0(%esi),%esi
80103f60:	83 c0 7c             	add    $0x7c,%eax
80103f63:	3d f4 37 11 80       	cmp    $0x801137f4,%eax
80103f68:	74 1e                	je     80103f88 <wakeup+0x48>
    if(p->state == SLEEPING && p->chan == chan)
80103f6a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103f6e:	75 f0                	jne    80103f60 <wakeup+0x20>
80103f70:	3b 58 20             	cmp    0x20(%eax),%ebx
80103f73:	75 eb                	jne    80103f60 <wakeup+0x20>
      p->state = RUNNABLE;
80103f75:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f7c:	83 c0 7c             	add    $0x7c,%eax
80103f7f:	3d f4 37 11 80       	cmp    $0x801137f4,%eax
80103f84:	75 e4                	jne    80103f6a <wakeup+0x2a>
80103f86:	66 90                	xchg   %ax,%ax
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80103f88:	c7 45 08 c0 18 11 80 	movl   $0x801118c0,0x8(%ebp)
}
80103f8f:	83 c4 14             	add    $0x14,%esp
80103f92:	5b                   	pop    %ebx
80103f93:	5d                   	pop    %ebp
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80103f94:	e9 07 03 00 00       	jmp    801042a0 <release>
80103f99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103fa0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80103fa0:	55                   	push   %ebp
80103fa1:	89 e5                	mov    %esp,%ebp
80103fa3:	53                   	push   %ebx
80103fa4:	83 ec 14             	sub    $0x14,%esp
80103fa7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80103faa:	c7 04 24 c0 18 11 80 	movl   $0x801118c0,(%esp)
80103fb1:	e8 ba 01 00 00       	call   80104170 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fb6:	b8 f4 18 11 80       	mov    $0x801118f4,%eax
80103fbb:	eb 0d                	jmp    80103fca <kill+0x2a>
80103fbd:	8d 76 00             	lea    0x0(%esi),%esi
80103fc0:	83 c0 7c             	add    $0x7c,%eax
80103fc3:	3d f4 37 11 80       	cmp    $0x801137f4,%eax
80103fc8:	74 36                	je     80104000 <kill+0x60>
    if(p->pid == pid){
80103fca:	39 58 10             	cmp    %ebx,0x10(%eax)
80103fcd:	75 f1                	jne    80103fc0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80103fcf:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
80103fd3:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80103fda:	74 14                	je     80103ff0 <kill+0x50>
        p->state = RUNNABLE;
      release(&ptable.lock);
80103fdc:	c7 04 24 c0 18 11 80 	movl   $0x801118c0,(%esp)
80103fe3:	e8 b8 02 00 00       	call   801042a0 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80103fe8:	83 c4 14             	add    $0x14,%esp
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
80103feb:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80103fed:	5b                   	pop    %ebx
80103fee:	5d                   	pop    %ebp
80103fef:	c3                   	ret    
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
80103ff0:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103ff7:	eb e3                	jmp    80103fdc <kill+0x3c>
80103ff9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80104000:	c7 04 24 c0 18 11 80 	movl   $0x801118c0,(%esp)
80104007:	e8 94 02 00 00       	call   801042a0 <release>
  return -1;
}
8010400c:	83 c4 14             	add    $0x14,%esp
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
8010400f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104014:	5b                   	pop    %ebx
80104015:	5d                   	pop    %ebp
80104016:	c3                   	ret    
80104017:	89 f6                	mov    %esi,%esi
80104019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104020 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104020:	55                   	push   %ebp
80104021:	89 e5                	mov    %esp,%ebp
80104023:	57                   	push   %edi
80104024:	56                   	push   %esi
80104025:	53                   	push   %ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104026:	bb f4 18 11 80       	mov    $0x801118f4,%ebx
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
8010402b:	83 ec 4c             	sub    $0x4c,%esp
//PAGEBREAK: 36
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
8010402e:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104031:	eb 20                	jmp    80104053 <procdump+0x33>
80104033:	90                   	nop
80104034:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104038:	c7 04 24 16 73 10 80 	movl   $0x80107316,(%esp)
8010403f:	e8 bc c5 ff ff       	call   80100600 <cprintf>
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104044:	83 c3 7c             	add    $0x7c,%ebx
80104047:	81 fb f4 37 11 80    	cmp    $0x801137f4,%ebx
8010404d:	0f 84 8d 00 00 00    	je     801040e0 <procdump+0xc0>
    if(p->state == UNUSED)
80104053:	8b 43 0c             	mov    0xc(%ebx),%eax
80104056:	85 c0                	test   %eax,%eax
80104058:	74 ea                	je     80104044 <procdump+0x24>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010405a:	83 f8 05             	cmp    $0x5,%eax
      state = states[p->state];
    else
      state = "???";
8010405d:	ba d8 73 10 80       	mov    $0x801073d8,%edx
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104062:	77 11                	ja     80104075 <procdump+0x55>
80104064:	8b 14 85 10 74 10 80 	mov    -0x7fef8bf0(,%eax,4),%edx
      state = states[p->state];
    else
      state = "???";
8010406b:	b8 d8 73 10 80       	mov    $0x801073d8,%eax
80104070:	85 d2                	test   %edx,%edx
80104072:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104075:	8d 43 6c             	lea    0x6c(%ebx),%eax
80104078:	89 44 24 0c          	mov    %eax,0xc(%esp)
8010407c:	8b 43 10             	mov    0x10(%ebx),%eax
8010407f:	89 54 24 08          	mov    %edx,0x8(%esp)
80104083:	c7 04 24 dc 73 10 80 	movl   $0x801073dc,(%esp)
8010408a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010408e:	e8 6d c5 ff ff       	call   80100600 <cprintf>
    if(p->state == SLEEPING){
80104093:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
80104097:	75 9f                	jne    80104038 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104099:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010409c:	89 44 24 04          	mov    %eax,0x4(%esp)
801040a0:	8b 43 1c             	mov    0x1c(%ebx),%eax
801040a3:	8d 7d c0             	lea    -0x40(%ebp),%edi
801040a6:	8b 40 0c             	mov    0xc(%eax),%eax
801040a9:	83 c0 08             	add    $0x8,%eax
801040ac:	89 04 24             	mov    %eax,(%esp)
801040af:	e8 5c 00 00 00       	call   80104110 <getcallerpcs>
801040b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
801040b8:	8b 17                	mov    (%edi),%edx
801040ba:	85 d2                	test   %edx,%edx
801040bc:	0f 84 76 ff ff ff    	je     80104038 <procdump+0x18>
        cprintf(" %p", pc[i]);
801040c2:	89 54 24 04          	mov    %edx,0x4(%esp)
801040c6:	83 c7 04             	add    $0x4,%edi
801040c9:	c7 04 24 22 6e 10 80 	movl   $0x80106e22,(%esp)
801040d0:	e8 2b c5 ff ff       	call   80100600 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
801040d5:	39 f7                	cmp    %esi,%edi
801040d7:	75 df                	jne    801040b8 <procdump+0x98>
801040d9:	e9 5a ff ff ff       	jmp    80104038 <procdump+0x18>
801040de:	66 90                	xchg   %ax,%ax
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
801040e0:	83 c4 4c             	add    $0x4c,%esp
801040e3:	5b                   	pop    %ebx
801040e4:	5e                   	pop    %esi
801040e5:	5f                   	pop    %edi
801040e6:	5d                   	pop    %ebp
801040e7:	c3                   	ret    
801040e8:	66 90                	xchg   %ax,%ax
801040ea:	66 90                	xchg   %ax,%ax
801040ec:	66 90                	xchg   %ax,%ax
801040ee:	66 90                	xchg   %ax,%ax

801040f0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801040f0:	55                   	push   %ebp
801040f1:	89 e5                	mov    %esp,%ebp
801040f3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801040f6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801040f9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
801040ff:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
  lk->cpu = 0;
80104102:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104109:	5d                   	pop    %ebp
8010410a:	c3                   	ret    
8010410b:	90                   	nop
8010410c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104110 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104110:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104111:	31 c0                	xor    %eax,%eax
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104113:	89 e5                	mov    %esp,%ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80104115:	8b 55 08             	mov    0x8(%ebp),%edx
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104118:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010411b:	53                   	push   %ebx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
8010411c:	83 ea 08             	sub    $0x8,%edx
8010411f:	90                   	nop
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104120:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104126:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010412c:	77 1a                	ja     80104148 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010412e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104131:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104134:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
80104137:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104139:	83 f8 0a             	cmp    $0xa,%eax
8010413c:	75 e2                	jne    80104120 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010413e:	5b                   	pop    %ebx
8010413f:	5d                   	pop    %ebp
80104140:	c3                   	ret    
80104141:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80104148:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010414f:	83 c0 01             	add    $0x1,%eax
80104152:	83 f8 0a             	cmp    $0xa,%eax
80104155:	74 e7                	je     8010413e <getcallerpcs+0x2e>
    pcs[i] = 0;
80104157:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010415e:	83 c0 01             	add    $0x1,%eax
80104161:	83 f8 0a             	cmp    $0xa,%eax
80104164:	75 e2                	jne    80104148 <getcallerpcs+0x38>
80104166:	eb d6                	jmp    8010413e <getcallerpcs+0x2e>
80104168:	90                   	nop
80104169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104170 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104170:	55                   	push   %ebp
80104171:	89 e5                	mov    %esp,%ebp
80104173:	83 ec 18             	sub    $0x18,%esp
80104176:	9c                   	pushf  
80104177:	59                   	pop    %ecx
}

static inline void
cli(void)
{
  asm volatile("cli");
80104178:	fa                   	cli    
{
  int eflags;

  eflags = readeflags();
  cli();
  if(cpu->ncli == 0)
80104179:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010417f:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
80104185:	85 d2                	test   %edx,%edx
80104187:	75 0c                	jne    80104195 <acquire+0x25>
    cpu->intena = eflags & FL_IF;
80104189:	81 e1 00 02 00 00    	and    $0x200,%ecx
8010418f:	89 88 b0 00 00 00    	mov    %ecx,0xb0(%eax)
  cpu->ncli += 1;
80104195:	83 c2 01             	add    $0x1,%edx
80104198:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
8010419e:	8b 55 08             	mov    0x8(%ebp),%edx

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu;
801041a1:	8b 0a                	mov    (%edx),%ecx
801041a3:	85 c9                	test   %ecx,%ecx
801041a5:	74 05                	je     801041ac <acquire+0x3c>
801041a7:	3b 42 08             	cmp    0x8(%edx),%eax
801041aa:	74 3c                	je     801041e8 <acquire+0x78>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801041ac:	b9 01 00 00 00       	mov    $0x1,%ecx
801041b1:	eb 08                	jmp    801041bb <acquire+0x4b>
801041b3:	90                   	nop
801041b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801041b8:	8b 55 08             	mov    0x8(%ebp),%edx
801041bb:	89 c8                	mov    %ecx,%eax
801041bd:	f0 87 02             	lock xchg %eax,(%edx)
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
801041c0:	85 c0                	test   %eax,%eax
801041c2:	75 f4                	jne    801041b8 <acquire+0x48>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
801041c4:	0f ae f0             	mfence 

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
801041c7:	8b 45 08             	mov    0x8(%ebp),%eax
801041ca:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
801041d1:	89 50 08             	mov    %edx,0x8(%eax)
  getcallerpcs(&lk, lk->pcs);
801041d4:	83 c0 0c             	add    $0xc,%eax
801041d7:	89 44 24 04          	mov    %eax,0x4(%esp)
801041db:	8d 45 08             	lea    0x8(%ebp),%eax
801041de:	89 04 24             	mov    %eax,(%esp)
801041e1:	e8 2a ff ff ff       	call   80104110 <getcallerpcs>
}
801041e6:	c9                   	leave  
801041e7:	c3                   	ret    
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");
801041e8:	c7 04 24 28 74 10 80 	movl   $0x80107428,(%esp)
801041ef:	e8 3c c1 ff ff       	call   80100330 <panic>
801041f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801041fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104200 <holding>:
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104200:	55                   	push   %ebp
  return lock->locked && lock->cpu == cpu;
80104201:	31 c0                	xor    %eax,%eax
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104203:	89 e5                	mov    %esp,%ebp
80104205:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == cpu;
80104208:	8b 0a                	mov    (%edx),%ecx
8010420a:	85 c9                	test   %ecx,%ecx
8010420c:	74 0f                	je     8010421d <holding+0x1d>
8010420e:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104214:	39 42 08             	cmp    %eax,0x8(%edx)
80104217:	0f 94 c0             	sete   %al
8010421a:	0f b6 c0             	movzbl %al,%eax
}
8010421d:	5d                   	pop    %ebp
8010421e:	c3                   	ret    
8010421f:	90                   	nop

80104220 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104220:	55                   	push   %ebp
80104221:	89 e5                	mov    %esp,%ebp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104223:	9c                   	pushf  
80104224:	59                   	pop    %ecx
}

static inline void
cli(void)
{
  asm volatile("cli");
80104225:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(cpu->ncli == 0)
80104226:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010422c:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
80104232:	85 d2                	test   %edx,%edx
80104234:	75 0c                	jne    80104242 <pushcli+0x22>
    cpu->intena = eflags & FL_IF;
80104236:	81 e1 00 02 00 00    	and    $0x200,%ecx
8010423c:	89 88 b0 00 00 00    	mov    %ecx,0xb0(%eax)
  cpu->ncli += 1;
80104242:	83 c2 01             	add    $0x1,%edx
80104245:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
}
8010424b:	5d                   	pop    %ebp
8010424c:	c3                   	ret    
8010424d:	8d 76 00             	lea    0x0(%esi),%esi

80104250 <popcli>:

void
popcli(void)
{
80104250:	55                   	push   %ebp
80104251:	89 e5                	mov    %esp,%ebp
80104253:	83 ec 18             	sub    $0x18,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104256:	9c                   	pushf  
80104257:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104258:	f6 c4 02             	test   $0x2,%ah
8010425b:	75 35                	jne    80104292 <popcli+0x42>
    panic("popcli - interruptible");
  if(--cpu->ncli < 0)
8010425d:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104263:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
80104269:	83 ea 01             	sub    $0x1,%edx
8010426c:	83 fa 00             	cmp    $0x0,%edx
8010426f:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
80104275:	7c 0f                	jl     80104286 <popcli+0x36>
    panic("popcli");
  if(cpu->ncli == 0 && cpu->intena)
80104277:	75 0b                	jne    80104284 <popcli+0x34>
80104279:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
8010427f:	85 c0                	test   %eax,%eax
80104281:	74 01                	je     80104284 <popcli+0x34>
}

static inline void
sti(void)
{
  asm volatile("sti");
80104283:	fb                   	sti    
    sti();
}
80104284:	c9                   	leave  
80104285:	c3                   	ret    
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--cpu->ncli < 0)
    panic("popcli");
80104286:	c7 04 24 47 74 10 80 	movl   $0x80107447,(%esp)
8010428d:	e8 9e c0 ff ff       	call   80100330 <panic>

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
80104292:	c7 04 24 30 74 10 80 	movl   $0x80107430,(%esp)
80104299:	e8 92 c0 ff ff       	call   80100330 <panic>
8010429e:	66 90                	xchg   %ax,%ax

801042a0 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
801042a0:	55                   	push   %ebp
801042a1:	89 e5                	mov    %esp,%ebp
801042a3:	83 ec 18             	sub    $0x18,%esp
801042a6:	8b 45 08             	mov    0x8(%ebp),%eax

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu;
801042a9:	8b 10                	mov    (%eax),%edx
801042ab:	85 d2                	test   %edx,%edx
801042ad:	74 0c                	je     801042bb <release+0x1b>
801042af:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
801042b6:	39 50 08             	cmp    %edx,0x8(%eax)
801042b9:	74 0d                	je     801042c8 <release+0x28>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
801042bb:	c7 04 24 4e 74 10 80 	movl   $0x8010744e,(%esp)
801042c2:	e8 69 c0 ff ff       	call   80100330 <panic>
801042c7:	90                   	nop

  lk->pcs[0] = 0;
801042c8:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
801042cf:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both to not re-order.
  __sync_synchronize();
801042d6:	0f ae f0             	mfence 

  // Release the lock.
  lk->locked = 0;
801042d9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  popcli();
}
801042df:	c9                   	leave  
  __sync_synchronize();

  // Release the lock.
  lk->locked = 0;

  popcli();
801042e0:	e9 6b ff ff ff       	jmp    80104250 <popcli>
801042e5:	66 90                	xchg   %ax,%ax
801042e7:	66 90                	xchg   %ax,%ax
801042e9:	66 90                	xchg   %ax,%ax
801042eb:	66 90                	xchg   %ax,%ax
801042ed:	66 90                	xchg   %ax,%ax
801042ef:	90                   	nop

801042f0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801042f0:	55                   	push   %ebp
801042f1:	89 e5                	mov    %esp,%ebp
801042f3:	83 ec 08             	sub    $0x8,%esp
801042f6:	8b 55 08             	mov    0x8(%ebp),%edx
801042f9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801042fc:	8b 4d 10             	mov    0x10(%ebp),%ecx
801042ff:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if ((int)dst%4 == 0 && n%4 == 0){
80104302:	f6 c2 03             	test   $0x3,%dl
80104305:	75 05                	jne    8010430c <memset+0x1c>
80104307:	f6 c1 03             	test   $0x3,%cl
8010430a:	74 14                	je     80104320 <memset+0x30>
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
8010430c:	89 d7                	mov    %edx,%edi
8010430e:	8b 45 0c             	mov    0xc(%ebp),%eax
80104311:	fc                   	cld    
80104312:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80104314:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104317:	89 d0                	mov    %edx,%eax
80104319:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010431c:	89 ec                	mov    %ebp,%esp
8010431e:	5d                   	pop    %ebp
8010431f:	c3                   	ret    

void*
memset(void *dst, int c, uint n)
{
  if ((int)dst%4 == 0 && n%4 == 0){
    c &= 0xFF;
80104320:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104324:	c1 e9 02             	shr    $0x2,%ecx
80104327:	89 f8                	mov    %edi,%eax
80104329:	89 fb                	mov    %edi,%ebx
8010432b:	c1 e0 18             	shl    $0x18,%eax
8010432e:	c1 e3 10             	shl    $0x10,%ebx
80104331:	09 d8                	or     %ebx,%eax
80104333:	09 f8                	or     %edi,%eax
80104335:	c1 e7 08             	shl    $0x8,%edi
80104338:	09 f8                	or     %edi,%eax
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
8010433a:	89 d7                	mov    %edx,%edi
8010433c:	fc                   	cld    
8010433d:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
8010433f:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104342:	89 d0                	mov    %edx,%eax
80104344:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104347:	89 ec                	mov    %ebp,%esp
80104349:	5d                   	pop    %ebp
8010434a:	c3                   	ret    
8010434b:	90                   	nop
8010434c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104350 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104350:	55                   	push   %ebp
80104351:	89 e5                	mov    %esp,%ebp
80104353:	8b 45 10             	mov    0x10(%ebp),%eax
80104356:	57                   	push   %edi
80104357:	56                   	push   %esi
80104358:	8b 75 0c             	mov    0xc(%ebp),%esi
8010435b:	53                   	push   %ebx
8010435c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010435f:	85 c0                	test   %eax,%eax
80104361:	8d 78 ff             	lea    -0x1(%eax),%edi
80104364:	74 26                	je     8010438c <memcmp+0x3c>
    if(*s1 != *s2)
80104366:	0f b6 03             	movzbl (%ebx),%eax
80104369:	0f b6 0e             	movzbl (%esi),%ecx
8010436c:	38 c8                	cmp    %cl,%al
8010436e:	75 28                	jne    80104398 <memcmp+0x48>
80104370:	31 d2                	xor    %edx,%edx
80104372:	eb 14                	jmp    80104388 <memcmp+0x38>
80104374:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104378:	0f b6 44 13 01       	movzbl 0x1(%ebx,%edx,1),%eax
8010437d:	83 c2 01             	add    $0x1,%edx
80104380:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80104384:	38 c8                	cmp    %cl,%al
80104386:	75 10                	jne    80104398 <memcmp+0x48>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104388:	39 d7                	cmp    %edx,%edi
8010438a:	75 ec                	jne    80104378 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
8010438c:	5b                   	pop    %ebx
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
8010438d:	31 c0                	xor    %eax,%eax
}
8010438f:	5e                   	pop    %esi
80104390:	5f                   	pop    %edi
80104391:	5d                   	pop    %ebp
80104392:	c3                   	ret    
80104393:	90                   	nop
80104394:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104398:	5b                   	pop    %ebx

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
80104399:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
8010439b:	5e                   	pop    %esi
8010439c:	5f                   	pop    %edi
8010439d:	5d                   	pop    %ebp
8010439e:	c3                   	ret    
8010439f:	90                   	nop

801043a0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
801043a0:	55                   	push   %ebp
801043a1:	89 e5                	mov    %esp,%ebp
801043a3:	57                   	push   %edi
801043a4:	8b 45 08             	mov    0x8(%ebp),%eax
801043a7:	56                   	push   %esi
801043a8:	8b 75 0c             	mov    0xc(%ebp),%esi
801043ab:	53                   	push   %ebx
801043ac:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
801043af:	39 c6                	cmp    %eax,%esi
801043b1:	73 35                	jae    801043e8 <memmove+0x48>
801043b3:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
801043b6:	39 c8                	cmp    %ecx,%eax
801043b8:	73 2e                	jae    801043e8 <memmove+0x48>
    s += n;
    d += n;
    while(n-- > 0)
801043ba:	85 db                	test   %ebx,%ebx

  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
801043bc:	8d 3c 18             	lea    (%eax,%ebx,1),%edi
    while(n-- > 0)
801043bf:	8d 53 ff             	lea    -0x1(%ebx),%edx
801043c2:	74 1b                	je     801043df <memmove+0x3f>

  return 0;
}

void*
memmove(void *dst, const void *src, uint n)
801043c4:	f7 db                	neg    %ebx
801043c6:	8d 34 19             	lea    (%ecx,%ebx,1),%esi
801043c9:	01 fb                	add    %edi,%ebx
801043cb:	90                   	nop
801043cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
801043d0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
801043d4:	88 0c 13             	mov    %cl,(%ebx,%edx,1)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
801043d7:	83 ea 01             	sub    $0x1,%edx
801043da:	83 fa ff             	cmp    $0xffffffff,%edx
801043dd:	75 f1                	jne    801043d0 <memmove+0x30>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
801043df:	5b                   	pop    %ebx
801043e0:	5e                   	pop    %esi
801043e1:	5f                   	pop    %edi
801043e2:	5d                   	pop    %ebp
801043e3:	c3                   	ret    
801043e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
801043e8:	31 d2                	xor    %edx,%edx
801043ea:	85 db                	test   %ebx,%ebx
801043ec:	74 f1                	je     801043df <memmove+0x3f>
801043ee:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
801043f0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
801043f4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
801043f7:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
801043fa:	39 da                	cmp    %ebx,%edx
801043fc:	75 f2                	jne    801043f0 <memmove+0x50>
      *d++ = *s++;

  return dst;
}
801043fe:	5b                   	pop    %ebx
801043ff:	5e                   	pop    %esi
80104400:	5f                   	pop    %edi
80104401:	5d                   	pop    %ebp
80104402:	c3                   	ret    
80104403:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104410 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104410:	55                   	push   %ebp
80104411:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104413:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104414:	e9 87 ff ff ff       	jmp    801043a0 <memmove>
80104419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104420 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104420:	55                   	push   %ebp
80104421:	89 e5                	mov    %esp,%ebp
80104423:	57                   	push   %edi
80104424:	8b 7d 10             	mov    0x10(%ebp),%edi
80104427:	56                   	push   %esi
80104428:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010442b:	53                   	push   %ebx
8010442c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(n > 0 && *p && *p == *q)
8010442f:	85 ff                	test   %edi,%edi
80104431:	74 39                	je     8010446c <strncmp+0x4c>
80104433:	0f b6 01             	movzbl (%ecx),%eax
80104436:	0f b6 33             	movzbl (%ebx),%esi
80104439:	84 c0                	test   %al,%al
8010443b:	74 3f                	je     8010447c <strncmp+0x5c>
8010443d:	89 f2                	mov    %esi,%edx
8010443f:	38 d0                	cmp    %dl,%al
80104441:	75 39                	jne    8010447c <strncmp+0x5c>
{
  return memmove(dst, src, n);
}

int
strncmp(const char *p, const char *q, uint n)
80104443:	8d 51 01             	lea    0x1(%ecx),%edx
80104446:	01 cf                	add    %ecx,%edi
80104448:	eb 1b                	jmp    80104465 <strncmp+0x45>
8010444a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  while(n > 0 && *p && *p == *q)
80104450:	0f b6 02             	movzbl (%edx),%eax
80104453:	84 c0                	test   %al,%al
80104455:	74 21                	je     80104478 <strncmp+0x58>
80104457:	0f b6 31             	movzbl (%ecx),%esi
    n--, p++, q++;
8010445a:	89 cb                	mov    %ecx,%ebx
8010445c:	83 c2 01             	add    $0x1,%edx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
8010445f:	89 f1                	mov    %esi,%ecx
80104461:	38 c8                	cmp    %cl,%al
80104463:	75 17                	jne    8010447c <strncmp+0x5c>
80104465:	39 fa                	cmp    %edi,%edx
    n--, p++, q++;
80104467:	8d 4b 01             	lea    0x1(%ebx),%ecx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
8010446a:	75 e4                	jne    80104450 <strncmp+0x30>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
8010446c:	5b                   	pop    %ebx
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
8010446d:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}
8010446f:	5e                   	pop    %esi
80104470:	5f                   	pop    %edi
80104471:	5d                   	pop    %ebp
80104472:	c3                   	ret    
80104473:	90                   	nop
80104474:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104478:	0f b6 73 01          	movzbl 0x1(%ebx),%esi
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
8010447c:	81 e6 ff 00 00 00    	and    $0xff,%esi
}
80104482:	5b                   	pop    %ebx
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80104483:	29 f0                	sub    %esi,%eax
}
80104485:	5e                   	pop    %esi
80104486:	5f                   	pop    %edi
80104487:	5d                   	pop    %ebp
80104488:	c3                   	ret    
80104489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104490 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104490:	55                   	push   %ebp
80104491:	89 e5                	mov    %esp,%ebp
80104493:	57                   	push   %edi
80104494:	8b 7d 08             	mov    0x8(%ebp),%edi
80104497:	56                   	push   %esi
80104498:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010449b:	53                   	push   %ebx
8010449c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010449f:	89 fa                	mov    %edi,%edx
801044a1:	eb 14                	jmp    801044b7 <strncpy+0x27>
801044a3:	90                   	nop
801044a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801044a8:	0f b6 03             	movzbl (%ebx),%eax
801044ab:	83 c3 01             	add    $0x1,%ebx
801044ae:	88 02                	mov    %al,(%edx)
801044b0:	83 c2 01             	add    $0x1,%edx
801044b3:	84 c0                	test   %al,%al
801044b5:	74 0a                	je     801044c1 <strncpy+0x31>
801044b7:	83 e9 01             	sub    $0x1,%ecx
    return 0;
  return (uchar)*p - (uchar)*q;
}

char*
strncpy(char *s, const char *t, int n)
801044ba:	8d 71 01             	lea    0x1(%ecx),%esi
{
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801044bd:	85 f6                	test   %esi,%esi
801044bf:	7f e7                	jg     801044a8 <strncpy+0x18>
    ;
  while(n-- > 0)
801044c1:	85 c9                	test   %ecx,%ecx
    return 0;
  return (uchar)*p - (uchar)*q;
}

char*
strncpy(char *s, const char *t, int n)
801044c3:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
801044c6:	7e 0a                	jle    801044d2 <strncpy+0x42>
    *s++ = 0;
801044c8:	c6 02 00             	movb   $0x0,(%edx)
801044cb:	83 c2 01             	add    $0x1,%edx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
801044ce:	39 c2                	cmp    %eax,%edx
801044d0:	75 f6                	jne    801044c8 <strncpy+0x38>
    *s++ = 0;
  return os;
}
801044d2:	5b                   	pop    %ebx
801044d3:	89 f8                	mov    %edi,%eax
801044d5:	5e                   	pop    %esi
801044d6:	5f                   	pop    %edi
801044d7:	5d                   	pop    %ebp
801044d8:	c3                   	ret    
801044d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801044e0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
801044e0:	55                   	push   %ebp
801044e1:	89 e5                	mov    %esp,%ebp
801044e3:	8b 55 10             	mov    0x10(%ebp),%edx
801044e6:	56                   	push   %esi
801044e7:	8b 45 08             	mov    0x8(%ebp),%eax
801044ea:	53                   	push   %ebx
801044eb:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  if(n <= 0)
801044ee:	85 d2                	test   %edx,%edx
801044f0:	7e 1c                	jle    8010450e <safestrcpy+0x2e>
  return os;
}

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
801044f2:	8d 74 10 ff          	lea    -0x1(%eax,%edx,1),%esi
801044f6:	89 c2                	mov    %eax,%edx
  char *os;

  os = s;
  if(n <= 0)
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
801044f8:	39 f2                	cmp    %esi,%edx
801044fa:	74 0f                	je     8010450b <safestrcpy+0x2b>
801044fc:	0f b6 19             	movzbl (%ecx),%ebx
801044ff:	83 c1 01             	add    $0x1,%ecx
80104502:	88 1a                	mov    %bl,(%edx)
80104504:	83 c2 01             	add    $0x1,%edx
80104507:	84 db                	test   %bl,%bl
80104509:	75 ed                	jne    801044f8 <safestrcpy+0x18>
    ;
  *s = 0;
8010450b:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
8010450e:	5b                   	pop    %ebx
8010450f:	5e                   	pop    %esi
80104510:	5d                   	pop    %ebp
80104511:	c3                   	ret    
80104512:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104520 <strlen>:

int
strlen(const char *s)
{
80104520:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104521:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
80104523:	89 e5                	mov    %esp,%ebp
80104525:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
80104528:	80 3a 00             	cmpb   $0x0,(%edx)
8010452b:	74 0c                	je     80104539 <strlen+0x19>
8010452d:	8d 76 00             	lea    0x0(%esi),%esi
80104530:	83 c0 01             	add    $0x1,%eax
80104533:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104537:	75 f7                	jne    80104530 <strlen+0x10>
    ;
  return n;
}
80104539:	5d                   	pop    %ebp
8010453a:	c3                   	ret    

8010453b <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010453b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010453f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
80104543:	55                   	push   %ebp
  pushl %ebx
80104544:	53                   	push   %ebx
  pushl %esi
80104545:	56                   	push   %esi
  pushl %edi
80104546:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104547:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104549:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
8010454b:	5f                   	pop    %edi
  popl %esi
8010454c:	5e                   	pop    %esi
  popl %ebx
8010454d:	5b                   	pop    %ebx
  popl %ebp
8010454e:	5d                   	pop    %ebp
  ret
8010454f:	c3                   	ret    

80104550 <fetchint>:

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
80104550:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104557:	55                   	push   %ebp
80104558:	89 e5                	mov    %esp,%ebp
8010455a:	8b 45 08             	mov    0x8(%ebp),%eax
  if(addr >= proc->sz || addr+4 > proc->sz)
8010455d:	8b 12                	mov    (%edx),%edx
8010455f:	39 c2                	cmp    %eax,%edx
80104561:	76 15                	jbe    80104578 <fetchint+0x28>
80104563:	8d 48 04             	lea    0x4(%eax),%ecx
80104566:	39 ca                	cmp    %ecx,%edx
80104568:	72 0e                	jb     80104578 <fetchint+0x28>
    return -1;
  *ip = *(int*)(addr);
8010456a:	8b 10                	mov    (%eax),%edx
8010456c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010456f:	89 10                	mov    %edx,(%eax)
  return 0;
80104571:	31 c0                	xor    %eax,%eax
}
80104573:	5d                   	pop    %ebp
80104574:	c3                   	ret    
80104575:	8d 76 00             	lea    0x0(%esi),%esi
// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
    return -1;
80104578:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  *ip = *(int*)(addr);
  return 0;
}
8010457d:	5d                   	pop    %ebp
8010457e:	c3                   	ret    
8010457f:	90                   	nop

80104580 <fetchstr>:
int
fetchstr(uint addr, char **pp)
{
  char *s, *ep;

  if(addr >= proc->sz)
80104580:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104586:	55                   	push   %ebp
80104587:	89 e5                	mov    %esp,%ebp
80104589:	8b 4d 08             	mov    0x8(%ebp),%ecx
  char *s, *ep;

  if(addr >= proc->sz)
8010458c:	39 08                	cmp    %ecx,(%eax)
8010458e:	76 2c                	jbe    801045bc <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104590:	8b 55 0c             	mov    0xc(%ebp),%edx
80104593:	89 c8                	mov    %ecx,%eax
80104595:	89 0a                	mov    %ecx,(%edx)
  ep = (char*)proc->sz;
80104597:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010459e:	8b 12                	mov    (%edx),%edx
  for(s = *pp; s < ep; s++)
801045a0:	39 d1                	cmp    %edx,%ecx
801045a2:	73 18                	jae    801045bc <fetchstr+0x3c>
    if(*s == 0)
801045a4:	80 39 00             	cmpb   $0x0,(%ecx)
801045a7:	75 0c                	jne    801045b5 <fetchstr+0x35>
801045a9:	eb 1d                	jmp    801045c8 <fetchstr+0x48>
801045ab:	90                   	nop
801045ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801045b0:	80 38 00             	cmpb   $0x0,(%eax)
801045b3:	74 13                	je     801045c8 <fetchstr+0x48>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
801045b5:	83 c0 01             	add    $0x1,%eax
801045b8:	39 c2                	cmp    %eax,%edx
801045ba:	77 f4                	ja     801045b0 <fetchstr+0x30>
fetchstr(uint addr, char **pp)
{
  char *s, *ep;

  if(addr >= proc->sz)
    return -1;
801045bc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
    if(*s == 0)
      return s - *pp;
  return -1;
}
801045c1:	5d                   	pop    %ebp
801045c2:	c3                   	ret    
801045c3:	90                   	nop
801045c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
    if(*s == 0)
      return s - *pp;
801045c8:	29 c8                	sub    %ecx,%eax
  return -1;
}
801045ca:	5d                   	pop    %ebp
801045cb:	c3                   	ret    
801045cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801045d0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801045d0:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
}

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801045d7:	55                   	push   %ebp
801045d8:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801045da:	8b 4d 08             	mov    0x8(%ebp),%ecx
801045dd:	8b 42 18             	mov    0x18(%edx),%eax

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
801045e0:	8b 12                	mov    (%edx),%edx

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801045e2:	8b 40 44             	mov    0x44(%eax),%eax
801045e5:	8d 04 88             	lea    (%eax,%ecx,4),%eax
801045e8:	8d 48 04             	lea    0x4(%eax),%ecx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
801045eb:	39 d1                	cmp    %edx,%ecx
801045ed:	73 19                	jae    80104608 <argint+0x38>
801045ef:	8d 48 08             	lea    0x8(%eax),%ecx
801045f2:	39 ca                	cmp    %ecx,%edx
801045f4:	72 12                	jb     80104608 <argint+0x38>
    return -1;
  *ip = *(int*)(addr);
801045f6:	8b 50 04             	mov    0x4(%eax),%edx
801045f9:	8b 45 0c             	mov    0xc(%ebp),%eax
801045fc:	89 10                	mov    %edx,(%eax)
  return 0;
801045fe:	31 c0                	xor    %eax,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
}
80104600:	5d                   	pop    %ebp
80104601:	c3                   	ret    
80104602:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
    return -1;
80104608:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
}
8010460d:	5d                   	pop    %ebp
8010460e:	c3                   	ret    
8010460f:	90                   	nop

80104610 <argptr>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104610:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104616:	55                   	push   %ebp
80104617:	89 e5                	mov    %esp,%ebp
80104619:	53                   	push   %ebx

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
8010461a:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010461d:	8b 50 18             	mov    0x18(%eax),%edx
80104620:	8b 52 44             	mov    0x44(%edx),%edx
80104623:	8d 0c 8a             	lea    (%edx,%ecx,4),%ecx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
80104626:	8b 10                	mov    (%eax),%edx
argptr(int n, char **pp, int size)
{
  int i;

  if(argint(n, &i) < 0)
    return -1;
80104628:	b8 ff ff ff ff       	mov    $0xffffffff,%eax

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
8010462d:	8d 59 04             	lea    0x4(%ecx),%ebx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
80104630:	39 d3                	cmp    %edx,%ebx
80104632:	73 1e                	jae    80104652 <argptr+0x42>
80104634:	8d 59 08             	lea    0x8(%ecx),%ebx
80104637:	39 da                	cmp    %ebx,%edx
80104639:	72 17                	jb     80104652 <argptr+0x42>
    return -1;
  *ip = *(int*)(addr);
8010463b:	8b 49 04             	mov    0x4(%ecx),%ecx
{
  int i;

  if(argint(n, &i) < 0)
    return -1;
  if((uint)i >= proc->sz || (uint)i+size > proc->sz)
8010463e:	39 d1                	cmp    %edx,%ecx
80104640:	73 10                	jae    80104652 <argptr+0x42>
80104642:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104645:	01 cb                	add    %ecx,%ebx
80104647:	39 d3                	cmp    %edx,%ebx
80104649:	77 07                	ja     80104652 <argptr+0x42>
    return -1;
  *pp = (char*)i;
8010464b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010464e:	89 08                	mov    %ecx,(%eax)
  return 0;
80104650:	31 c0                	xor    %eax,%eax
}
80104652:	5b                   	pop    %ebx
80104653:	5d                   	pop    %ebp
80104654:	c3                   	ret    
80104655:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104660 <argstr>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104660:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104666:	55                   	push   %ebp
80104667:	89 e5                	mov    %esp,%ebp

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104669:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010466c:	8b 50 18             	mov    0x18(%eax),%edx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
8010466f:	8b 00                	mov    (%eax),%eax

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104671:	8b 52 44             	mov    0x44(%edx),%edx
80104674:	8d 14 8a             	lea    (%edx,%ecx,4),%edx
80104677:	8d 4a 04             	lea    0x4(%edx),%ecx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
8010467a:	39 c1                	cmp    %eax,%ecx
8010467c:	73 07                	jae    80104685 <argstr+0x25>
8010467e:	8d 4a 08             	lea    0x8(%edx),%ecx
80104681:	39 c8                	cmp    %ecx,%eax
80104683:	73 0b                	jae    80104690 <argstr+0x30>
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
80104685:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
8010468a:	5d                   	pop    %ebp
8010468b:	c3                   	ret    
8010468c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
    return -1;
  *ip = *(int*)(addr);
80104690:	8b 4a 04             	mov    0x4(%edx),%ecx
int
fetchstr(uint addr, char **pp)
{
  char *s, *ep;

  if(addr >= proc->sz)
80104693:	39 c1                	cmp    %eax,%ecx
80104695:	73 ee                	jae    80104685 <argstr+0x25>
    return -1;
  *pp = (char*)addr;
80104697:	8b 55 0c             	mov    0xc(%ebp),%edx
8010469a:	89 c8                	mov    %ecx,%eax
8010469c:	89 0a                	mov    %ecx,(%edx)
  ep = (char*)proc->sz;
8010469e:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801046a5:	8b 12                	mov    (%edx),%edx
  for(s = *pp; s < ep; s++)
801046a7:	39 d1                	cmp    %edx,%ecx
801046a9:	73 da                	jae    80104685 <argstr+0x25>
    if(*s == 0)
801046ab:	80 39 00             	cmpb   $0x0,(%ecx)
801046ae:	75 12                	jne    801046c2 <argstr+0x62>
801046b0:	eb 1e                	jmp    801046d0 <argstr+0x70>
801046b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801046b8:	80 38 00             	cmpb   $0x0,(%eax)
801046bb:	90                   	nop
801046bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046c0:	74 0e                	je     801046d0 <argstr+0x70>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
801046c2:	83 c0 01             	add    $0x1,%eax
801046c5:	39 c2                	cmp    %eax,%edx
801046c7:	77 ef                	ja     801046b8 <argstr+0x58>
801046c9:	eb ba                	jmp    80104685 <argstr+0x25>
801046cb:	90                   	nop
801046cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(*s == 0)
      return s - *pp;
801046d0:	29 c8                	sub    %ecx,%eax
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
801046d2:	5d                   	pop    %ebp
801046d3:	c3                   	ret    
801046d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801046da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801046e0 <syscall>:
[SYS_getprocs]  sys_getprocs,
};

void
syscall(void)
{
801046e0:	55                   	push   %ebp
801046e1:	89 e5                	mov    %esp,%ebp
801046e3:	53                   	push   %ebx
801046e4:	83 ec 14             	sub    $0x14,%esp
  int num;

  num = proc->tf->eax;
801046e7:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801046ee:	8b 5a 18             	mov    0x18(%edx),%ebx
801046f1:	8b 43 1c             	mov    0x1c(%ebx),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801046f4:	8d 48 ff             	lea    -0x1(%eax),%ecx
801046f7:	83 f9 15             	cmp    $0x15,%ecx
801046fa:	77 1c                	ja     80104718 <syscall+0x38>
801046fc:	8b 0c 85 80 74 10 80 	mov    -0x7fef8b80(,%eax,4),%ecx
80104703:	85 c9                	test   %ecx,%ecx
80104705:	74 11                	je     80104718 <syscall+0x38>
    proc->tf->eax = syscalls[num]();
80104707:	ff d1                	call   *%ecx
80104709:	89 43 1c             	mov    %eax,0x1c(%ebx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
  }
}
8010470c:	83 c4 14             	add    $0x14,%esp
8010470f:	5b                   	pop    %ebx
80104710:	5d                   	pop    %ebp
80104711:	c3                   	ret    
80104712:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  num = proc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80104718:	89 44 24 0c          	mov    %eax,0xc(%esp)
            proc->pid, proc->name, num);
8010471c:	8d 42 6c             	lea    0x6c(%edx),%eax
8010471f:	89 44 24 08          	mov    %eax,0x8(%esp)

  num = proc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80104723:	8b 42 10             	mov    0x10(%edx),%eax
80104726:	c7 04 24 56 74 10 80 	movl   $0x80107456,(%esp)
8010472d:	89 44 24 04          	mov    %eax,0x4(%esp)
80104731:	e8 ca be ff ff       	call   80100600 <cprintf>
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
80104736:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010473c:	8b 40 18             	mov    0x18(%eax),%eax
8010473f:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
80104746:	83 c4 14             	add    $0x14,%esp
80104749:	5b                   	pop    %ebx
8010474a:	5d                   	pop    %ebp
8010474b:	c3                   	ret    
8010474c:	66 90                	xchg   %ax,%ax
8010474e:	66 90                	xchg   %ax,%ax

80104750 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104750:	55                   	push   %ebp
80104751:	89 e5                	mov    %esp,%ebp
80104753:	83 ec 58             	sub    $0x58,%esp
80104756:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104759:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010475c:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
8010475f:	8d 5d da             	lea    -0x26(%ebp),%ebx
80104762:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104766:	89 04 24             	mov    %eax,(%esp)
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104769:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010476c:	89 7d fc             	mov    %edi,-0x4(%ebp)
8010476f:	89 4d bc             	mov    %ecx,-0x44(%ebp)
80104772:	66 89 55 c6          	mov    %dx,-0x3a(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104776:	e8 d5 d7 ff ff       	call   80101f50 <nameiparent>
8010477b:	85 c0                	test   %eax,%eax
8010477d:	89 c6                	mov    %eax,%esi
8010477f:	0f 84 eb 00 00 00    	je     80104870 <create+0x120>
    return 0;
  ilock(dp);
80104785:	89 04 24             	mov    %eax,(%esp)
80104788:	e8 03 cf ff ff       	call   80101690 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
8010478d:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104790:	89 44 24 08          	mov    %eax,0x8(%esp)
80104794:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104798:	89 34 24             	mov    %esi,(%esp)
8010479b:	e8 50 d4 ff ff       	call   80101bf0 <dirlookup>
801047a0:	85 c0                	test   %eax,%eax
801047a2:	89 c7                	mov    %eax,%edi
801047a4:	74 52                	je     801047f8 <create+0xa8>
    iunlockput(dp);
801047a6:	89 34 24             	mov    %esi,(%esp)
801047a9:	e8 92 d1 ff ff       	call   80101940 <iunlockput>
    ilock(ip);
801047ae:	89 3c 24             	mov    %edi,(%esp)
801047b1:	e8 da ce ff ff       	call   80101690 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
801047b6:	66 83 7d c6 02       	cmpw   $0x2,-0x3a(%ebp)
801047bb:	75 1b                	jne    801047d8 <create+0x88>
801047bd:	66 83 7f 10 02       	cmpw   $0x2,0x10(%edi)
801047c2:	75 14                	jne    801047d8 <create+0x88>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
801047c4:	89 f8                	mov    %edi,%eax
801047c6:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801047c9:	8b 75 f8             	mov    -0x8(%ebp),%esi
801047cc:	8b 7d fc             	mov    -0x4(%ebp),%edi
801047cf:	89 ec                	mov    %ebp,%esp
801047d1:	5d                   	pop    %ebp
801047d2:	c3                   	ret    
801047d3:	90                   	nop
801047d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
801047d8:	89 3c 24             	mov    %edi,(%esp)
    return 0;
801047db:	31 ff                	xor    %edi,%edi
  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
801047dd:	e8 5e d1 ff ff       	call   80101940 <iunlockput>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
801047e2:	89 f8                	mov    %edi,%eax
801047e4:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801047e7:	8b 75 f8             	mov    -0x8(%ebp),%esi
801047ea:	8b 7d fc             	mov    -0x4(%ebp),%edi
801047ed:	89 ec                	mov    %ebp,%esp
801047ef:	5d                   	pop    %ebp
801047f0:	c3                   	ret    
801047f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
801047f8:	0f bf 45 c6          	movswl -0x3a(%ebp),%eax
801047fc:	89 44 24 04          	mov    %eax,0x4(%esp)
80104800:	8b 06                	mov    (%esi),%eax
80104802:	89 04 24             	mov    %eax,(%esp)
80104805:	e8 f6 cc ff ff       	call   80101500 <ialloc>
8010480a:	85 c0                	test   %eax,%eax
8010480c:	89 c7                	mov    %eax,%edi
8010480e:	0f 84 bf 00 00 00    	je     801048d3 <create+0x183>
    panic("create: ialloc");

  ilock(ip);
80104814:	89 04 24             	mov    %eax,(%esp)
80104817:	e8 74 ce ff ff       	call   80101690 <ilock>
  ip->major = major;
8010481c:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
  ip->minor = minor;
80104820:	0f b7 4d bc          	movzwl -0x44(%ebp),%ecx
  ip->nlink = 1;
80104824:	66 c7 47 16 01 00    	movw   $0x1,0x16(%edi)

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");

  ilock(ip);
  ip->major = major;
8010482a:	66 89 47 12          	mov    %ax,0x12(%edi)
  ip->minor = minor;
8010482e:	66 89 4f 14          	mov    %cx,0x14(%edi)
  ip->nlink = 1;
  iupdate(ip);
80104832:	89 3c 24             	mov    %edi,(%esp)
80104835:	e8 96 cd ff ff       	call   801015d0 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
8010483a:	66 83 7d c6 01       	cmpw   $0x1,-0x3a(%ebp)
8010483f:	74 37                	je     80104878 <create+0x128>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
80104841:	8b 47 04             	mov    0x4(%edi),%eax
80104844:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104848:	89 34 24             	mov    %esi,(%esp)
8010484b:	89 44 24 08          	mov    %eax,0x8(%esp)
8010484f:	e8 fc d5 ff ff       	call   80101e50 <dirlink>
80104854:	85 c0                	test   %eax,%eax
80104856:	78 6f                	js     801048c7 <create+0x177>
    panic("create: dirlink");

  iunlockput(dp);
80104858:	89 34 24             	mov    %esi,(%esp)
8010485b:	e8 e0 d0 ff ff       	call   80101940 <iunlockput>

  return ip;
}
80104860:	89 f8                	mov    %edi,%eax
80104862:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80104865:	8b 75 f8             	mov    -0x8(%ebp),%esi
80104868:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010486b:	89 ec                	mov    %ebp,%esp
8010486d:	5d                   	pop    %ebp
8010486e:	c3                   	ret    
8010486f:	90                   	nop
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
80104870:	31 ff                	xor    %edi,%edi
80104872:	e9 4d ff ff ff       	jmp    801047c4 <create+0x74>
80104877:	90                   	nop
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
80104878:	66 83 46 16 01       	addw   $0x1,0x16(%esi)
    iupdate(dp);
8010487d:	89 34 24             	mov    %esi,(%esp)
80104880:	e8 4b cd ff ff       	call   801015d0 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104885:	8b 47 04             	mov    0x4(%edi),%eax
80104888:	c7 44 24 04 f8 74 10 	movl   $0x801074f8,0x4(%esp)
8010488f:	80 
80104890:	89 3c 24             	mov    %edi,(%esp)
80104893:	89 44 24 08          	mov    %eax,0x8(%esp)
80104897:	e8 b4 d5 ff ff       	call   80101e50 <dirlink>
8010489c:	85 c0                	test   %eax,%eax
8010489e:	78 1b                	js     801048bb <create+0x16b>
801048a0:	8b 46 04             	mov    0x4(%esi),%eax
801048a3:	c7 44 24 04 f7 74 10 	movl   $0x801074f7,0x4(%esp)
801048aa:	80 
801048ab:	89 3c 24             	mov    %edi,(%esp)
801048ae:	89 44 24 08          	mov    %eax,0x8(%esp)
801048b2:	e8 99 d5 ff ff       	call   80101e50 <dirlink>
801048b7:	85 c0                	test   %eax,%eax
801048b9:	79 86                	jns    80104841 <create+0xf1>
      panic("create dots");
801048bb:	c7 04 24 eb 74 10 80 	movl   $0x801074eb,(%esp)
801048c2:	e8 69 ba ff ff       	call   80100330 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
801048c7:	c7 04 24 fa 74 10 80 	movl   $0x801074fa,(%esp)
801048ce:	e8 5d ba ff ff       	call   80100330 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
801048d3:	c7 04 24 dc 74 10 80 	movl   $0x801074dc,(%esp)
801048da:	e8 51 ba ff ff       	call   80100330 <panic>
801048df:	90                   	nop

801048e0 <argfd.constprop.0>:


// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
801048e0:	55                   	push   %ebp
801048e1:	89 e5                	mov    %esp,%ebp
801048e3:	56                   	push   %esi
801048e4:	89 c6                	mov    %eax,%esi
801048e6:	53                   	push   %ebx
801048e7:	89 d3                	mov    %edx,%ebx
801048e9:	83 ec 20             	sub    $0x20,%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
801048ec:	8d 45 f4             	lea    -0xc(%ebp),%eax
801048ef:	89 44 24 04          	mov    %eax,0x4(%esp)
801048f3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801048fa:	e8 d1 fc ff ff       	call   801045d0 <argint>
801048ff:	85 c0                	test   %eax,%eax
80104901:	78 35                	js     80104938 <argfd.constprop.0+0x58>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
80104903:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80104906:	83 f9 0f             	cmp    $0xf,%ecx
80104909:	77 2d                	ja     80104938 <argfd.constprop.0+0x58>
8010490b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104911:	8b 44 88 28          	mov    0x28(%eax,%ecx,4),%eax
80104915:	85 c0                	test   %eax,%eax
80104917:	74 1f                	je     80104938 <argfd.constprop.0+0x58>
    return -1;
  if(pfd)
80104919:	85 f6                	test   %esi,%esi
8010491b:	74 02                	je     8010491f <argfd.constprop.0+0x3f>
    *pfd = fd;
8010491d:	89 0e                	mov    %ecx,(%esi)
  if(pf)
8010491f:	85 db                	test   %ebx,%ebx
80104921:	74 0d                	je     80104930 <argfd.constprop.0+0x50>
    *pf = f;
80104923:	89 03                	mov    %eax,(%ebx)
  return 0;
80104925:	31 c0                	xor    %eax,%eax
}
80104927:	83 c4 20             	add    $0x20,%esp
8010492a:	5b                   	pop    %ebx
8010492b:	5e                   	pop    %esi
8010492c:	5d                   	pop    %ebp
8010492d:	c3                   	ret    
8010492e:	66 90                	xchg   %ax,%ax
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
80104930:	31 c0                	xor    %eax,%eax
80104932:	eb f3                	jmp    80104927 <argfd.constprop.0+0x47>
80104934:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
80104938:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010493d:	eb e8                	jmp    80104927 <argfd.constprop.0+0x47>
8010493f:	90                   	nop

80104940 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
80104940:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104941:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_dup(void)
{
80104943:	89 e5                	mov    %esp,%ebp
80104945:	53                   	push   %ebx
80104946:	83 ec 24             	sub    $0x24,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104949:	8d 55 f4             	lea    -0xc(%ebp),%edx
8010494c:	e8 8f ff ff ff       	call   801048e0 <argfd.constprop.0>
80104951:	85 c0                	test   %eax,%eax
80104953:	78 1b                	js     80104970 <sys_dup+0x30>
    return -1;
  if((fd=fdalloc(f)) < 0)
80104955:	8b 55 f4             	mov    -0xc(%ebp),%edx
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80104958:	31 db                	xor    %ebx,%ebx
8010495a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
    if(proc->ofile[fd] == 0){
80104960:	8b 4c 98 28          	mov    0x28(%eax,%ebx,4),%ecx
80104964:	85 c9                	test   %ecx,%ecx
80104966:	74 18                	je     80104980 <sys_dup+0x40>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80104968:	83 c3 01             	add    $0x1,%ebx
8010496b:	83 fb 10             	cmp    $0x10,%ebx
8010496e:	75 f0                	jne    80104960 <sys_dup+0x20>
{
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
80104970:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80104975:	83 c4 24             	add    $0x24,%esp
80104978:	89 d8                	mov    %ebx,%eax
8010497a:	5b                   	pop    %ebx
8010497b:	5d                   	pop    %ebp
8010497c:	c3                   	ret    
8010497d:	8d 76 00             	lea    0x0(%esi),%esi
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
80104980:	89 54 98 28          	mov    %edx,0x28(%eax,%ebx,4)

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
80104984:	89 14 24             	mov    %edx,(%esp)
80104987:	e8 04 c4 ff ff       	call   80100d90 <filedup>
  return fd;
}
8010498c:	83 c4 24             	add    $0x24,%esp
8010498f:	89 d8                	mov    %ebx,%eax
80104991:	5b                   	pop    %ebx
80104992:	5d                   	pop    %ebp
80104993:	c3                   	ret    
80104994:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010499a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801049a0 <sys_read>:

int
sys_read(void)
{
801049a0:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801049a1:	31 c0                	xor    %eax,%eax
  return fd;
}

int
sys_read(void)
{
801049a3:	89 e5                	mov    %esp,%ebp
801049a5:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801049a8:	8d 55 ec             	lea    -0x14(%ebp),%edx
801049ab:	e8 30 ff ff ff       	call   801048e0 <argfd.constprop.0>
801049b0:	85 c0                	test   %eax,%eax
801049b2:	78 54                	js     80104a08 <sys_read+0x68>
801049b4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801049b7:	89 44 24 04          	mov    %eax,0x4(%esp)
801049bb:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
801049c2:	e8 09 fc ff ff       	call   801045d0 <argint>
801049c7:	85 c0                	test   %eax,%eax
801049c9:	78 3d                	js     80104a08 <sys_read+0x68>
801049cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801049ce:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801049d5:	89 44 24 08          	mov    %eax,0x8(%esp)
801049d9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801049dc:	89 44 24 04          	mov    %eax,0x4(%esp)
801049e0:	e8 2b fc ff ff       	call   80104610 <argptr>
801049e5:	85 c0                	test   %eax,%eax
801049e7:	78 1f                	js     80104a08 <sys_read+0x68>
    return -1;
  return fileread(f, p, n);
801049e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801049ec:	89 44 24 08          	mov    %eax,0x8(%esp)
801049f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049f3:	89 44 24 04          	mov    %eax,0x4(%esp)
801049f7:	8b 45 ec             	mov    -0x14(%ebp),%eax
801049fa:	89 04 24             	mov    %eax,(%esp)
801049fd:	e8 0e c5 ff ff       	call   80100f10 <fileread>
}
80104a02:	c9                   	leave  
80104a03:	c3                   	ret    
80104a04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104a08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fileread(f, p, n);
}
80104a0d:	c9                   	leave  
80104a0e:	c3                   	ret    
80104a0f:	90                   	nop

80104a10 <sys_write>:

int
sys_write(void)
{
80104a10:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104a11:	31 c0                	xor    %eax,%eax
  return fileread(f, p, n);
}

int
sys_write(void)
{
80104a13:	89 e5                	mov    %esp,%ebp
80104a15:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104a18:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104a1b:	e8 c0 fe ff ff       	call   801048e0 <argfd.constprop.0>
80104a20:	85 c0                	test   %eax,%eax
80104a22:	78 54                	js     80104a78 <sys_write+0x68>
80104a24:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104a27:	89 44 24 04          	mov    %eax,0x4(%esp)
80104a2b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80104a32:	e8 99 fb ff ff       	call   801045d0 <argint>
80104a37:	85 c0                	test   %eax,%eax
80104a39:	78 3d                	js     80104a78 <sys_write+0x68>
80104a3b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104a3e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104a45:	89 44 24 08          	mov    %eax,0x8(%esp)
80104a49:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104a4c:	89 44 24 04          	mov    %eax,0x4(%esp)
80104a50:	e8 bb fb ff ff       	call   80104610 <argptr>
80104a55:	85 c0                	test   %eax,%eax
80104a57:	78 1f                	js     80104a78 <sys_write+0x68>
    return -1;
  return filewrite(f, p, n);
80104a59:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104a5c:	89 44 24 08          	mov    %eax,0x8(%esp)
80104a60:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a63:	89 44 24 04          	mov    %eax,0x4(%esp)
80104a67:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104a6a:	89 04 24             	mov    %eax,(%esp)
80104a6d:	e8 4e c5 ff ff       	call   80100fc0 <filewrite>
}
80104a72:	c9                   	leave  
80104a73:	c3                   	ret    
80104a74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104a78:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filewrite(f, p, n);
}
80104a7d:	c9                   	leave  
80104a7e:	c3                   	ret    
80104a7f:	90                   	nop

80104a80 <sys_close>:

int
sys_close(void)
{
80104a80:	55                   	push   %ebp
80104a81:	89 e5                	mov    %esp,%ebp
80104a83:	83 ec 28             	sub    $0x28,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80104a86:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104a89:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104a8c:	e8 4f fe ff ff       	call   801048e0 <argfd.constprop.0>
80104a91:	85 c0                	test   %eax,%eax
80104a93:	78 23                	js     80104ab8 <sys_close+0x38>
    return -1;
  proc->ofile[fd] = 0;
80104a95:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104a98:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a9e:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104aa5:	00 
  fileclose(f);
80104aa6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104aa9:	89 04 24             	mov    %eax,(%esp)
80104aac:	e8 2f c3 ff ff       	call   80100de0 <fileclose>
  return 0;
80104ab1:	31 c0                	xor    %eax,%eax
}
80104ab3:	c9                   	leave  
80104ab4:	c3                   	ret    
80104ab5:	8d 76 00             	lea    0x0(%esi),%esi
{
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
80104ab8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  proc->ofile[fd] = 0;
  fileclose(f);
  return 0;
}
80104abd:	c9                   	leave  
80104abe:	c3                   	ret    
80104abf:	90                   	nop

80104ac0 <sys_fstat>:

int
sys_fstat(void)
{
80104ac0:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104ac1:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
80104ac3:	89 e5                	mov    %esp,%ebp
80104ac5:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104ac8:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104acb:	e8 10 fe ff ff       	call   801048e0 <argfd.constprop.0>
80104ad0:	85 c0                	test   %eax,%eax
80104ad2:	78 34                	js     80104b08 <sys_fstat+0x48>
80104ad4:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104ad7:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
80104ade:	00 
80104adf:	89 44 24 04          	mov    %eax,0x4(%esp)
80104ae3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104aea:	e8 21 fb ff ff       	call   80104610 <argptr>
80104aef:	85 c0                	test   %eax,%eax
80104af1:	78 15                	js     80104b08 <sys_fstat+0x48>
    return -1;
  return filestat(f, st);
80104af3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104af6:	89 44 24 04          	mov    %eax,0x4(%esp)
80104afa:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104afd:	89 04 24             	mov    %eax,(%esp)
80104b00:	e8 bb c3 ff ff       	call   80100ec0 <filestat>
}
80104b05:	c9                   	leave  
80104b06:	c3                   	ret    
80104b07:	90                   	nop
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
80104b08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filestat(f, st);
}
80104b0d:	c9                   	leave  
80104b0e:	c3                   	ret    
80104b0f:	90                   	nop

80104b10 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104b10:	55                   	push   %ebp
80104b11:	89 e5                	mov    %esp,%ebp
80104b13:	57                   	push   %edi
80104b14:	56                   	push   %esi
80104b15:	53                   	push   %ebx
80104b16:	83 ec 3c             	sub    $0x3c,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104b19:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104b1c:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b20:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104b27:	e8 34 fb ff ff       	call   80104660 <argstr>
80104b2c:	85 c0                	test   %eax,%eax
80104b2e:	0f 88 e6 00 00 00    	js     80104c1a <sys_link+0x10a>
80104b34:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104b37:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b3b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104b42:	e8 19 fb ff ff       	call   80104660 <argstr>
80104b47:	85 c0                	test   %eax,%eax
80104b49:	0f 88 cb 00 00 00    	js     80104c1a <sys_link+0x10a>
    return -1;

  begin_op();
80104b4f:	e8 2c e0 ff ff       	call   80102b80 <begin_op>
  if((ip = namei(old)) == 0){
80104b54:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80104b57:	89 04 24             	mov    %eax,(%esp)
80104b5a:	e8 d1 d3 ff ff       	call   80101f30 <namei>
80104b5f:	85 c0                	test   %eax,%eax
80104b61:	89 c3                	mov    %eax,%ebx
80104b63:	0f 84 ac 00 00 00    	je     80104c15 <sys_link+0x105>
    end_op();
    return -1;
  }

  ilock(ip);
80104b69:	89 04 24             	mov    %eax,(%esp)
80104b6c:	e8 1f cb ff ff       	call   80101690 <ilock>
  if(ip->type == T_DIR){
80104b71:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
80104b76:	0f 84 91 00 00 00    	je     80104c0d <sys_link+0xfd>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
80104b7c:	66 83 43 16 01       	addw   $0x1,0x16(%ebx)
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80104b81:	8d 7d da             	lea    -0x26(%ebp),%edi
    end_op();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
80104b84:	89 1c 24             	mov    %ebx,(%esp)
80104b87:	e8 44 ca ff ff       	call   801015d0 <iupdate>
  iunlock(ip);
80104b8c:	89 1c 24             	mov    %ebx,(%esp)
80104b8f:	e8 0c cc ff ff       	call   801017a0 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
80104b94:	8b 45 d0             	mov    -0x30(%ebp),%eax
80104b97:	89 7c 24 04          	mov    %edi,0x4(%esp)
80104b9b:	89 04 24             	mov    %eax,(%esp)
80104b9e:	e8 ad d3 ff ff       	call   80101f50 <nameiparent>
80104ba3:	85 c0                	test   %eax,%eax
80104ba5:	89 c6                	mov    %eax,%esi
80104ba7:	74 4f                	je     80104bf8 <sys_link+0xe8>
    goto bad;
  ilock(dp);
80104ba9:	89 04 24             	mov    %eax,(%esp)
80104bac:	e8 df ca ff ff       	call   80101690 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104bb1:	8b 03                	mov    (%ebx),%eax
80104bb3:	39 06                	cmp    %eax,(%esi)
80104bb5:	75 39                	jne    80104bf0 <sys_link+0xe0>
80104bb7:	8b 43 04             	mov    0x4(%ebx),%eax
80104bba:	89 7c 24 04          	mov    %edi,0x4(%esp)
80104bbe:	89 34 24             	mov    %esi,(%esp)
80104bc1:	89 44 24 08          	mov    %eax,0x8(%esp)
80104bc5:	e8 86 d2 ff ff       	call   80101e50 <dirlink>
80104bca:	85 c0                	test   %eax,%eax
80104bcc:	78 22                	js     80104bf0 <sys_link+0xe0>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
80104bce:	89 34 24             	mov    %esi,(%esp)
80104bd1:	e8 6a cd ff ff       	call   80101940 <iunlockput>
  iput(ip);
80104bd6:	89 1c 24             	mov    %ebx,(%esp)
80104bd9:	e8 12 cc ff ff       	call   801017f0 <iput>

  end_op();
80104bde:	e8 0d e0 ff ff       	call   80102bf0 <end_op>
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
80104be3:	83 c4 3c             	add    $0x3c,%esp
  iunlockput(dp);
  iput(ip);

  end_op();

  return 0;
80104be6:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
80104be8:	5b                   	pop    %ebx
80104be9:	5e                   	pop    %esi
80104bea:	5f                   	pop    %edi
80104beb:	5d                   	pop    %ebp
80104bec:	c3                   	ret    
80104bed:	8d 76 00             	lea    0x0(%esi),%esi

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
80104bf0:	89 34 24             	mov    %esi,(%esp)
80104bf3:	e8 48 cd ff ff       	call   80101940 <iunlockput>
  end_op();

  return 0;

bad:
  ilock(ip);
80104bf8:	89 1c 24             	mov    %ebx,(%esp)
80104bfb:	e8 90 ca ff ff       	call   80101690 <ilock>
  ip->nlink--;
80104c00:	66 83 6b 16 01       	subw   $0x1,0x16(%ebx)
  iupdate(ip);
80104c05:	89 1c 24             	mov    %ebx,(%esp)
80104c08:	e8 c3 c9 ff ff       	call   801015d0 <iupdate>
  iunlockput(ip);
80104c0d:	89 1c 24             	mov    %ebx,(%esp)
80104c10:	e8 2b cd ff ff       	call   80101940 <iunlockput>
  end_op();
80104c15:	e8 d6 df ff ff       	call   80102bf0 <end_op>
  return -1;
}
80104c1a:	83 c4 3c             	add    $0x3c,%esp
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
80104c1d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104c22:	5b                   	pop    %ebx
80104c23:	5e                   	pop    %esi
80104c24:	5f                   	pop    %edi
80104c25:	5d                   	pop    %ebp
80104c26:	c3                   	ret    
80104c27:	89 f6                	mov    %esi,%esi
80104c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c30 <sys_unlink>:
}

//PAGEBREAK!
int
sys_unlink(void)
{
80104c30:	55                   	push   %ebp
80104c31:	89 e5                	mov    %esp,%ebp
80104c33:	57                   	push   %edi
80104c34:	56                   	push   %esi
80104c35:	53                   	push   %ebx
80104c36:	83 ec 5c             	sub    $0x5c,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80104c39:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104c3c:	89 44 24 04          	mov    %eax,0x4(%esp)
80104c40:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104c47:	e8 14 fa ff ff       	call   80104660 <argstr>
80104c4c:	85 c0                	test   %eax,%eax
80104c4e:	0f 88 6c 01 00 00    	js     80104dc0 <sys_unlink+0x190>
    return -1;

  begin_op();
80104c54:	e8 27 df ff ff       	call   80102b80 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80104c59:	8b 45 c0             	mov    -0x40(%ebp),%eax
80104c5c:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80104c5f:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104c63:	89 04 24             	mov    %eax,(%esp)
80104c66:	e8 e5 d2 ff ff       	call   80101f50 <nameiparent>
80104c6b:	85 c0                	test   %eax,%eax
80104c6d:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80104c70:	0f 84 45 01 00 00    	je     80104dbb <sys_unlink+0x18b>
    end_op();
    return -1;
  }

  ilock(dp);
80104c76:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104c79:	89 04 24             	mov    %eax,(%esp)
80104c7c:	e8 0f ca ff ff       	call   80101690 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80104c81:	c7 44 24 04 f8 74 10 	movl   $0x801074f8,0x4(%esp)
80104c88:	80 
80104c89:	89 1c 24             	mov    %ebx,(%esp)
80104c8c:	e8 2f cf ff ff       	call   80101bc0 <namecmp>
80104c91:	85 c0                	test   %eax,%eax
80104c93:	0f 84 17 01 00 00    	je     80104db0 <sys_unlink+0x180>
80104c99:	c7 44 24 04 f7 74 10 	movl   $0x801074f7,0x4(%esp)
80104ca0:	80 
80104ca1:	89 1c 24             	mov    %ebx,(%esp)
80104ca4:	e8 17 cf ff ff       	call   80101bc0 <namecmp>
80104ca9:	85 c0                	test   %eax,%eax
80104cab:	0f 84 ff 00 00 00    	je     80104db0 <sys_unlink+0x180>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80104cb1:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80104cb4:	89 44 24 08          	mov    %eax,0x8(%esp)
80104cb8:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104cbb:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104cbf:	89 04 24             	mov    %eax,(%esp)
80104cc2:	e8 29 cf ff ff       	call   80101bf0 <dirlookup>
80104cc7:	85 c0                	test   %eax,%eax
80104cc9:	89 c3                	mov    %eax,%ebx
80104ccb:	0f 84 df 00 00 00    	je     80104db0 <sys_unlink+0x180>
    goto bad;
  ilock(ip);
80104cd1:	89 04 24             	mov    %eax,(%esp)
80104cd4:	e8 b7 c9 ff ff       	call   80101690 <ilock>

  if(ip->nlink < 1)
80104cd9:	66 83 7b 16 00       	cmpw   $0x0,0x16(%ebx)
80104cde:	0f 8e 19 01 00 00    	jle    80104dfd <sys_unlink+0x1cd>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
80104ce4:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
80104ce9:	8d 75 d8             	lea    -0x28(%ebp),%esi
80104cec:	74 7a                	je     80104d68 <sys_unlink+0x138>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
80104cee:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80104cf5:	00 
80104cf6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80104cfd:	00 
80104cfe:	89 34 24             	mov    %esi,(%esp)
80104d01:	e8 ea f5 ff ff       	call   801042f0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80104d06:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80104d09:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80104d10:	00 
80104d11:	89 74 24 04          	mov    %esi,0x4(%esp)
80104d15:	89 44 24 08          	mov    %eax,0x8(%esp)
80104d19:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104d1c:	89 04 24             	mov    %eax,(%esp)
80104d1f:	e8 6c cd ff ff       	call   80101a90 <writei>
80104d24:	83 f8 10             	cmp    $0x10,%eax
80104d27:	0f 85 c4 00 00 00    	jne    80104df1 <sys_unlink+0x1c1>
    panic("unlink: writei");
  if(ip->type == T_DIR){
80104d2d:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
80104d32:	0f 84 98 00 00 00    	je     80104dd0 <sys_unlink+0x1a0>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
80104d38:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104d3b:	89 04 24             	mov    %eax,(%esp)
80104d3e:	e8 fd cb ff ff       	call   80101940 <iunlockput>

  ip->nlink--;
80104d43:	66 83 6b 16 01       	subw   $0x1,0x16(%ebx)
  iupdate(ip);
80104d48:	89 1c 24             	mov    %ebx,(%esp)
80104d4b:	e8 80 c8 ff ff       	call   801015d0 <iupdate>
  iunlockput(ip);
80104d50:	89 1c 24             	mov    %ebx,(%esp)
80104d53:	e8 e8 cb ff ff       	call   80101940 <iunlockput>

  end_op();
80104d58:	e8 93 de ff ff       	call   80102bf0 <end_op>

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
80104d5d:	83 c4 5c             	add    $0x5c,%esp
  iupdate(ip);
  iunlockput(ip);

  end_op();

  return 0;
80104d60:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
80104d62:	5b                   	pop    %ebx
80104d63:	5e                   	pop    %esi
80104d64:	5f                   	pop    %edi
80104d65:	5d                   	pop    %ebp
80104d66:	c3                   	ret    
80104d67:	90                   	nop
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80104d68:	83 7b 18 20          	cmpl   $0x20,0x18(%ebx)
80104d6c:	76 80                	jbe    80104cee <sys_unlink+0xbe>
80104d6e:	bf 20 00 00 00       	mov    $0x20,%edi
80104d73:	eb 0f                	jmp    80104d84 <sys_unlink+0x154>
80104d75:	8d 76 00             	lea    0x0(%esi),%esi
80104d78:	83 c7 10             	add    $0x10,%edi
80104d7b:	3b 7b 18             	cmp    0x18(%ebx),%edi
80104d7e:	0f 83 6a ff ff ff    	jae    80104cee <sys_unlink+0xbe>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80104d84:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80104d8b:	00 
80104d8c:	89 7c 24 08          	mov    %edi,0x8(%esp)
80104d90:	89 74 24 04          	mov    %esi,0x4(%esp)
80104d94:	89 1c 24             	mov    %ebx,(%esp)
80104d97:	e8 f4 cb ff ff       	call   80101990 <readi>
80104d9c:	83 f8 10             	cmp    $0x10,%eax
80104d9f:	75 44                	jne    80104de5 <sys_unlink+0x1b5>
      panic("isdirempty: readi");
    if(de.inum != 0)
80104da1:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80104da6:	74 d0                	je     80104d78 <sys_unlink+0x148>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
80104da8:	89 1c 24             	mov    %ebx,(%esp)
80104dab:	e8 90 cb ff ff       	call   80101940 <iunlockput>
  end_op();

  return 0;

bad:
  iunlockput(dp);
80104db0:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104db3:	89 04 24             	mov    %eax,(%esp)
80104db6:	e8 85 cb ff ff       	call   80101940 <iunlockput>
  end_op();
80104dbb:	e8 30 de ff ff       	call   80102bf0 <end_op>
  return -1;
}
80104dc0:	83 c4 5c             	add    $0x5c,%esp
  return 0;

bad:
  iunlockput(dp);
  end_op();
  return -1;
80104dc3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104dc8:	5b                   	pop    %ebx
80104dc9:	5e                   	pop    %esi
80104dca:	5f                   	pop    %edi
80104dcb:	5d                   	pop    %ebp
80104dcc:	c3                   	ret    
80104dcd:	8d 76 00             	lea    0x0(%esi),%esi

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
80104dd0:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104dd3:	66 83 68 16 01       	subw   $0x1,0x16(%eax)
    iupdate(dp);
80104dd8:	89 04 24             	mov    %eax,(%esp)
80104ddb:	e8 f0 c7 ff ff       	call   801015d0 <iupdate>
80104de0:	e9 53 ff ff ff       	jmp    80104d38 <sys_unlink+0x108>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
80104de5:	c7 04 24 1c 75 10 80 	movl   $0x8010751c,(%esp)
80104dec:	e8 3f b5 ff ff       	call   80100330 <panic>
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
80104df1:	c7 04 24 2e 75 10 80 	movl   $0x8010752e,(%esp)
80104df8:	e8 33 b5 ff ff       	call   80100330 <panic>
  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
80104dfd:	c7 04 24 0a 75 10 80 	movl   $0x8010750a,(%esp)
80104e04:	e8 27 b5 ff ff       	call   80100330 <panic>
80104e09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104e10 <sys_open>:
  return ip;
}

int
sys_open(void)
{
80104e10:	55                   	push   %ebp
80104e11:	89 e5                	mov    %esp,%ebp
80104e13:	57                   	push   %edi
80104e14:	56                   	push   %esi
80104e15:	53                   	push   %ebx
80104e16:	83 ec 2c             	sub    $0x2c,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80104e19:	8d 45 e0             	lea    -0x20(%ebp),%eax
80104e1c:	89 44 24 04          	mov    %eax,0x4(%esp)
80104e20:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104e27:	e8 34 f8 ff ff       	call   80104660 <argstr>
80104e2c:	85 c0                	test   %eax,%eax
80104e2e:	0f 88 81 00 00 00    	js     80104eb5 <sys_open+0xa5>
80104e34:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80104e37:	89 44 24 04          	mov    %eax,0x4(%esp)
80104e3b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104e42:	e8 89 f7 ff ff       	call   801045d0 <argint>
80104e47:	85 c0                	test   %eax,%eax
80104e49:	78 6a                	js     80104eb5 <sys_open+0xa5>
    return -1;

  begin_op();
80104e4b:	e8 30 dd ff ff       	call   80102b80 <begin_op>

  if(omode & O_CREATE){
80104e50:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80104e54:	75 72                	jne    80104ec8 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80104e56:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104e59:	89 04 24             	mov    %eax,(%esp)
80104e5c:	e8 cf d0 ff ff       	call   80101f30 <namei>
80104e61:	85 c0                	test   %eax,%eax
80104e63:	89 c7                	mov    %eax,%edi
80104e65:	74 49                	je     80104eb0 <sys_open+0xa0>
      end_op();
      return -1;
    }
    ilock(ip);
80104e67:	89 04 24             	mov    %eax,(%esp)
80104e6a:	e8 21 c8 ff ff       	call   80101690 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80104e6f:	66 83 7f 10 01       	cmpw   $0x1,0x10(%edi)
80104e74:	0f 84 ae 00 00 00    	je     80104f28 <sys_open+0x118>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80104e7a:	e8 a1 be ff ff       	call   80100d20 <filealloc>
80104e7f:	85 c0                	test   %eax,%eax
80104e81:	89 c6                	mov    %eax,%esi
80104e83:	74 23                	je     80104ea8 <sys_open+0x98>
80104e85:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104e8c:	31 db                	xor    %ebx,%ebx
80104e8e:	66 90                	xchg   %ax,%ax
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
80104e90:	8b 44 9a 28          	mov    0x28(%edx,%ebx,4),%eax
80104e94:	85 c0                	test   %eax,%eax
80104e96:	74 50                	je     80104ee8 <sys_open+0xd8>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80104e98:	83 c3 01             	add    $0x1,%ebx
80104e9b:	83 fb 10             	cmp    $0x10,%ebx
80104e9e:	75 f0                	jne    80104e90 <sys_open+0x80>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
80104ea0:	89 34 24             	mov    %esi,(%esp)
80104ea3:	e8 38 bf ff ff       	call   80100de0 <fileclose>
    iunlockput(ip);
80104ea8:	89 3c 24             	mov    %edi,(%esp)
80104eab:	e8 90 ca ff ff       	call   80101940 <iunlockput>
    end_op();
80104eb0:	e8 3b dd ff ff       	call   80102bf0 <end_op>
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
80104eb5:	83 c4 2c             	add    $0x2c,%esp
  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
80104eb8:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
80104ebd:	89 d8                	mov    %ebx,%eax
80104ebf:	5b                   	pop    %ebx
80104ec0:	5e                   	pop    %esi
80104ec1:	5f                   	pop    %edi
80104ec2:	5d                   	pop    %ebp
80104ec3:	c3                   	ret    
80104ec4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80104ec8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104ecb:	31 c9                	xor    %ecx,%ecx
80104ecd:	ba 02 00 00 00       	mov    $0x2,%edx
80104ed2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104ed9:	e8 72 f8 ff ff       	call   80104750 <create>
    if(ip == 0){
80104ede:	85 c0                	test   %eax,%eax
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80104ee0:	89 c7                	mov    %eax,%edi
    if(ip == 0){
80104ee2:	75 96                	jne    80104e7a <sys_open+0x6a>
80104ee4:	eb ca                	jmp    80104eb0 <sys_open+0xa0>
80104ee6:	66 90                	xchg   %ax,%ax
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
80104ee8:	89 74 9a 28          	mov    %esi,0x28(%edx,%ebx,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80104eec:	89 3c 24             	mov    %edi,(%esp)
80104eef:	e8 ac c8 ff ff       	call   801017a0 <iunlock>
  end_op();
80104ef4:	e8 f7 dc ff ff       	call   80102bf0 <end_op>

  f->type = FD_INODE;
80104ef9:	c7 06 02 00 00 00    	movl   $0x2,(%esi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80104eff:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  }
  iunlock(ip);
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
80104f02:	89 7e 10             	mov    %edi,0x10(%esi)
  f->off = 0;
80104f05:	c7 46 14 00 00 00 00 	movl   $0x0,0x14(%esi)
  f->readable = !(omode & O_WRONLY);
80104f0c:	89 d0                	mov    %edx,%eax
80104f0e:	83 e0 01             	and    $0x1,%eax
80104f11:	83 f0 01             	xor    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80104f14:	83 e2 03             	and    $0x3,%edx
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80104f17:	88 46 08             	mov    %al,0x8(%esi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
80104f1a:	89 d8                	mov    %ebx,%eax

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80104f1c:	0f 95 46 09          	setne  0x9(%esi)
  return fd;
}
80104f20:	83 c4 2c             	add    $0x2c,%esp
80104f23:	5b                   	pop    %ebx
80104f24:	5e                   	pop    %esi
80104f25:	5f                   	pop    %edi
80104f26:	5d                   	pop    %ebp
80104f27:	c3                   	ret    
    if((ip = namei(path)) == 0){
      end_op();
      return -1;
    }
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
80104f28:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104f2b:	85 d2                	test   %edx,%edx
80104f2d:	0f 84 47 ff ff ff    	je     80104e7a <sys_open+0x6a>
80104f33:	e9 70 ff ff ff       	jmp    80104ea8 <sys_open+0x98>
80104f38:	90                   	nop
80104f39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104f40 <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
80104f40:	55                   	push   %ebp
80104f41:	89 e5                	mov    %esp,%ebp
80104f43:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  begin_op();
80104f46:	e8 35 dc ff ff       	call   80102b80 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80104f4b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104f4e:	89 44 24 04          	mov    %eax,0x4(%esp)
80104f52:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104f59:	e8 02 f7 ff ff       	call   80104660 <argstr>
80104f5e:	85 c0                	test   %eax,%eax
80104f60:	78 2e                	js     80104f90 <sys_mkdir+0x50>
80104f62:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f65:	31 c9                	xor    %ecx,%ecx
80104f67:	ba 01 00 00 00       	mov    $0x1,%edx
80104f6c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104f73:	e8 d8 f7 ff ff       	call   80104750 <create>
80104f78:	85 c0                	test   %eax,%eax
80104f7a:	74 14                	je     80104f90 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80104f7c:	89 04 24             	mov    %eax,(%esp)
80104f7f:	e8 bc c9 ff ff       	call   80101940 <iunlockput>
  end_op();
80104f84:	e8 67 dc ff ff       	call   80102bf0 <end_op>
  return 0;
80104f89:	31 c0                	xor    %eax,%eax
}
80104f8b:	c9                   	leave  
80104f8c:	c3                   	ret    
80104f8d:	8d 76 00             	lea    0x0(%esi),%esi
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
80104f90:	e8 5b dc ff ff       	call   80102bf0 <end_op>
    return -1;
80104f95:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
80104f9a:	c9                   	leave  
80104f9b:	c3                   	ret    
80104f9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104fa0 <sys_mknod>:

int
sys_mknod(void)
{
80104fa0:	55                   	push   %ebp
80104fa1:	89 e5                	mov    %esp,%ebp
80104fa3:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80104fa6:	e8 d5 db ff ff       	call   80102b80 <begin_op>
  if((argstr(0, &path)) < 0 ||
80104fab:	8d 45 ec             	lea    -0x14(%ebp),%eax
80104fae:	89 44 24 04          	mov    %eax,0x4(%esp)
80104fb2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104fb9:	e8 a2 f6 ff ff       	call   80104660 <argstr>
80104fbe:	85 c0                	test   %eax,%eax
80104fc0:	78 5e                	js     80105020 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80104fc2:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104fc5:	89 44 24 04          	mov    %eax,0x4(%esp)
80104fc9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104fd0:	e8 fb f5 ff ff       	call   801045d0 <argint>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
80104fd5:	85 c0                	test   %eax,%eax
80104fd7:	78 47                	js     80105020 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80104fd9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104fdc:	89 44 24 04          	mov    %eax,0x4(%esp)
80104fe0:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80104fe7:	e8 e4 f5 ff ff       	call   801045d0 <argint>
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
80104fec:	85 c0                	test   %eax,%eax
80104fee:	78 30                	js     80105020 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
80104ff0:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80104ff4:	ba 03 00 00 00       	mov    $0x3,%edx
     (ip = create(path, T_DEV, major, minor)) == 0){
80104ff9:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80104ffd:	89 04 24             	mov    %eax,(%esp)
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80105000:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105003:	e8 48 f7 ff ff       	call   80104750 <create>
80105008:	85 c0                	test   %eax,%eax
8010500a:	74 14                	je     80105020 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
8010500c:	89 04 24             	mov    %eax,(%esp)
8010500f:	e8 2c c9 ff ff       	call   80101940 <iunlockput>
  end_op();
80105014:	e8 d7 db ff ff       	call   80102bf0 <end_op>
  return 0;
80105019:	31 c0                	xor    %eax,%eax
}
8010501b:	c9                   	leave  
8010501c:	c3                   	ret    
8010501d:	8d 76 00             	lea    0x0(%esi),%esi
  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
80105020:	e8 cb db ff ff       	call   80102bf0 <end_op>
    return -1;
80105025:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
8010502a:	c9                   	leave  
8010502b:	c3                   	ret    
8010502c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105030 <sys_chdir>:

int
sys_chdir(void)
{
80105030:	55                   	push   %ebp
80105031:	89 e5                	mov    %esp,%ebp
80105033:	53                   	push   %ebx
80105034:	83 ec 24             	sub    $0x24,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105037:	e8 44 db ff ff       	call   80102b80 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
8010503c:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010503f:	89 44 24 04          	mov    %eax,0x4(%esp)
80105043:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010504a:	e8 11 f6 ff ff       	call   80104660 <argstr>
8010504f:	85 c0                	test   %eax,%eax
80105051:	78 5a                	js     801050ad <sys_chdir+0x7d>
80105053:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105056:	89 04 24             	mov    %eax,(%esp)
80105059:	e8 d2 ce ff ff       	call   80101f30 <namei>
8010505e:	85 c0                	test   %eax,%eax
80105060:	89 c3                	mov    %eax,%ebx
80105062:	74 49                	je     801050ad <sys_chdir+0x7d>
    end_op();
    return -1;
  }
  ilock(ip);
80105064:	89 04 24             	mov    %eax,(%esp)
80105067:	e8 24 c6 ff ff       	call   80101690 <ilock>
  if(ip->type != T_DIR){
8010506c:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
    iunlockput(ip);
80105071:	89 1c 24             	mov    %ebx,(%esp)
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
80105074:	75 32                	jne    801050a8 <sys_chdir+0x78>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105076:	e8 25 c7 ff ff       	call   801017a0 <iunlock>
  iput(proc->cwd);
8010507b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105081:	8b 40 68             	mov    0x68(%eax),%eax
80105084:	89 04 24             	mov    %eax,(%esp)
80105087:	e8 64 c7 ff ff       	call   801017f0 <iput>
  end_op();
8010508c:	e8 5f db ff ff       	call   80102bf0 <end_op>
  proc->cwd = ip;
80105091:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105097:	89 58 68             	mov    %ebx,0x68(%eax)
  return 0;
}
8010509a:	83 c4 24             	add    $0x24,%esp
  }
  iunlock(ip);
  iput(proc->cwd);
  end_op();
  proc->cwd = ip;
  return 0;
8010509d:	31 c0                	xor    %eax,%eax
}
8010509f:	5b                   	pop    %ebx
801050a0:	5d                   	pop    %ebp
801050a1:	c3                   	ret    
801050a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
801050a8:	e8 93 c8 ff ff       	call   80101940 <iunlockput>
    end_op();
801050ad:	e8 3e db ff ff       	call   80102bf0 <end_op>
  iunlock(ip);
  iput(proc->cwd);
  end_op();
  proc->cwd = ip;
  return 0;
}
801050b2:	83 c4 24             	add    $0x24,%esp
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
    end_op();
    return -1;
801050b5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  iunlock(ip);
  iput(proc->cwd);
  end_op();
  proc->cwd = ip;
  return 0;
}
801050ba:	5b                   	pop    %ebx
801050bb:	5d                   	pop    %ebp
801050bc:	c3                   	ret    
801050bd:	8d 76 00             	lea    0x0(%esi),%esi

801050c0 <sys_exec>:

int
sys_exec(void)
{
801050c0:	55                   	push   %ebp
801050c1:	89 e5                	mov    %esp,%ebp
801050c3:	57                   	push   %edi
801050c4:	56                   	push   %esi
801050c5:	53                   	push   %ebx
801050c6:	81 ec ac 00 00 00    	sub    $0xac,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801050cc:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
801050d2:	89 44 24 04          	mov    %eax,0x4(%esp)
801050d6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801050dd:	e8 7e f5 ff ff       	call   80104660 <argstr>
801050e2:	85 c0                	test   %eax,%eax
801050e4:	0f 88 8f 00 00 00    	js     80105179 <sys_exec+0xb9>
801050ea:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801050f0:	89 44 24 04          	mov    %eax,0x4(%esp)
801050f4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801050fb:	e8 d0 f4 ff ff       	call   801045d0 <argint>
80105100:	85 c0                	test   %eax,%eax
80105102:	78 75                	js     80105179 <sys_exec+0xb9>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105104:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  for(i=0;; i++){
8010510a:	31 db                	xor    %ebx,%ebx
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010510c:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
80105113:	00 
80105114:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
8010511a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80105121:	00 
80105122:	89 04 24             	mov    %eax,(%esp)
80105125:	e8 c6 f1 ff ff       	call   801042f0 <memset>
8010512a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105130:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
  proc->cwd = ip;
  return 0;
}

int
sys_exec(void)
80105136:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
8010513d:	89 7c 24 04          	mov    %edi,0x4(%esp)
80105141:	01 f0                	add    %esi,%eax
80105143:	89 04 24             	mov    %eax,(%esp)
80105146:	e8 05 f4 ff ff       	call   80104550 <fetchint>
8010514b:	85 c0                	test   %eax,%eax
8010514d:	78 2a                	js     80105179 <sys_exec+0xb9>
      return -1;
    if(uarg == 0){
8010514f:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105155:	85 c0                	test   %eax,%eax
80105157:	74 37                	je     80105190 <sys_exec+0xd0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105159:	8d 95 68 ff ff ff    	lea    -0x98(%ebp),%edx
8010515f:	01 f2                	add    %esi,%edx
80105161:	89 54 24 04          	mov    %edx,0x4(%esp)
80105165:	89 04 24             	mov    %eax,(%esp)
80105168:	e8 13 f4 ff ff       	call   80104580 <fetchstr>
8010516d:	85 c0                	test   %eax,%eax
8010516f:	78 08                	js     80105179 <sys_exec+0xb9>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
80105171:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105174:	83 fb 20             	cmp    $0x20,%ebx
80105177:	75 b7                	jne    80105130 <sys_exec+0x70>
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80105179:	81 c4 ac 00 00 00    	add    $0xac,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
8010517f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80105184:	5b                   	pop    %ebx
80105185:	5e                   	pop    %esi
80105186:	5f                   	pop    %edi
80105187:	5d                   	pop    %ebp
80105188:	c3                   	ret    
80105189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80105190:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105196:	89 44 24 04          	mov    %eax,0x4(%esp)
8010519a:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
801051a0:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801051a7:	00 00 00 00 
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
801051ab:	89 04 24             	mov    %eax,(%esp)
801051ae:	e8 bd b7 ff ff       	call   80100970 <exec>
}
801051b3:	81 c4 ac 00 00 00    	add    $0xac,%esp
801051b9:	5b                   	pop    %ebx
801051ba:	5e                   	pop    %esi
801051bb:	5f                   	pop    %edi
801051bc:	5d                   	pop    %ebp
801051bd:	c3                   	ret    
801051be:	66 90                	xchg   %ax,%ax

801051c0 <sys_pipe>:

int
sys_pipe(void)
{
801051c0:	55                   	push   %ebp
801051c1:	89 e5                	mov    %esp,%ebp
801051c3:	57                   	push   %edi
801051c4:	56                   	push   %esi
801051c5:	53                   	push   %ebx
801051c6:	83 ec 2c             	sub    $0x2c,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801051c9:	8d 45 dc             	lea    -0x24(%ebp),%eax
801051cc:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
801051d3:	00 
801051d4:	89 44 24 04          	mov    %eax,0x4(%esp)
801051d8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801051df:	e8 2c f4 ff ff       	call   80104610 <argptr>
801051e4:	85 c0                	test   %eax,%eax
801051e6:	78 7a                	js     80105262 <sys_pipe+0xa2>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801051e8:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801051eb:	89 44 24 04          	mov    %eax,0x4(%esp)
801051ef:	8d 45 e0             	lea    -0x20(%ebp),%eax
801051f2:	89 04 24             	mov    %eax,(%esp)
801051f5:	e8 c6 e0 ff ff       	call   801032c0 <pipealloc>
801051fa:	85 c0                	test   %eax,%eax
801051fc:	78 64                	js     80105262 <sys_pipe+0xa2>
801051fe:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105205:	31 c0                	xor    %eax,%eax
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105207:	8b 5d e0             	mov    -0x20(%ebp),%ebx
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
8010520a:	8b 54 81 28          	mov    0x28(%ecx,%eax,4),%edx
8010520e:	85 d2                	test   %edx,%edx
80105210:	74 16                	je     80105228 <sys_pipe+0x68>
80105212:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105218:	83 c0 01             	add    $0x1,%eax
8010521b:	83 f8 10             	cmp    $0x10,%eax
8010521e:	74 2f                	je     8010524f <sys_pipe+0x8f>
    if(proc->ofile[fd] == 0){
80105220:	8b 54 81 28          	mov    0x28(%ecx,%eax,4),%edx
80105224:	85 d2                	test   %edx,%edx
80105226:	75 f0                	jne    80105218 <sys_pipe+0x58>
      proc->ofile[fd] = f;
80105228:	8d 70 08             	lea    0x8(%eax),%esi
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
8010522b:	31 d2                	xor    %edx,%edx
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
8010522d:	89 5c b1 08          	mov    %ebx,0x8(%ecx,%esi,4)
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105231:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80105234:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
80105238:	83 7c 91 28 00       	cmpl   $0x0,0x28(%ecx,%edx,4)
8010523d:	74 31                	je     80105270 <sys_pipe+0xb0>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
8010523f:	83 c2 01             	add    $0x1,%edx
80105242:	83 fa 10             	cmp    $0x10,%edx
80105245:	75 f1                	jne    80105238 <sys_pipe+0x78>
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      proc->ofile[fd0] = 0;
80105247:	c7 44 b1 08 00 00 00 	movl   $0x0,0x8(%ecx,%esi,4)
8010524e:	00 
    fileclose(rf);
8010524f:	89 1c 24             	mov    %ebx,(%esp)
80105252:	e8 89 bb ff ff       	call   80100de0 <fileclose>
    fileclose(wf);
80105257:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010525a:	89 04 24             	mov    %eax,(%esp)
8010525d:	e8 7e bb ff ff       	call   80100de0 <fileclose>
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
80105262:	83 c4 2c             	add    $0x2c,%esp
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      proc->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
80105265:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
8010526a:	5b                   	pop    %ebx
8010526b:	5e                   	pop    %esi
8010526c:	5f                   	pop    %edi
8010526d:	5d                   	pop    %ebp
8010526e:	c3                   	ret    
8010526f:	90                   	nop
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
80105270:	89 7c 91 28          	mov    %edi,0x28(%ecx,%edx,4)
      proc->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80105274:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80105277:	89 01                	mov    %eax,(%ecx)
  fd[1] = fd1;
80105279:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010527c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
}
8010527f:	83 c4 2c             	add    $0x2c,%esp
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
80105282:	31 c0                	xor    %eax,%eax
}
80105284:	5b                   	pop    %ebx
80105285:	5e                   	pop    %esi
80105286:	5f                   	pop    %edi
80105287:	5d                   	pop    %ebp
80105288:	c3                   	ret    
80105289:	66 90                	xchg   %ax,%ax
8010528b:	66 90                	xchg   %ax,%ax
8010528d:	66 90                	xchg   %ax,%ax
8010528f:	90                   	nop

80105290 <sys_getprocs>:
//extern void  popuproc(int, struct uproc[]);
//extern int getpid(int);
//extern int getppid(int);

int
sys_getprocs(void) {
80105290:	55                   	push   %ebp
80105291:	89 e5                	mov    %esp,%ebp
80105293:	57                   	push   %edi
80105294:	56                   	push   %esi
80105295:	53                   	push   %ebx
80105296:	83 ec 2c             	sub    $0x2c,%esp
  
  //Get args from stack
  int maxprocs = 0;
  struct uproc* kprocs = 0;
  argint(0, &maxprocs);
80105299:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010529c:	89 44 24 04          	mov    %eax,0x4(%esp)
801052a0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)

int
sys_getprocs(void) {
  
  //Get args from stack
  int maxprocs = 0;
801052a7:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  struct uproc* kprocs = 0;
801052ae:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  argint(0, &maxprocs);
801052b5:	e8 16 f3 ff ff       	call   801045d0 <argint>


  //If maxprocs exceeds max number of procs, bump it down
  if(maxprocs > NPROC)
801052ba:	8b 45 e0             	mov    -0x20(%ebp),%eax
801052bd:	83 f8 40             	cmp    $0x40,%eax
801052c0:	0f 8f a2 00 00 00    	jg     80105368 <sys_getprocs+0xd8>
801052c6:	8d 04 40             	lea    (%eax,%eax,2),%eax
801052c9:	c1 e0 03             	shl    $0x3,%eax
    maxprocs = 64;

  if(argptr(1, (void*)&kprocs, (sizeof(struct uproc) * maxprocs)) == -1)
801052cc:	89 44 24 08          	mov    %eax,0x8(%esp)
801052d0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801052d3:	89 44 24 04          	mov    %eax,0x4(%esp)
801052d7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801052de:	e8 2d f3 ff ff       	call   80104610 <argptr>
801052e3:	83 f8 ff             	cmp    $0xffffffff,%eax
801052e6:	0f 84 ba 00 00 00    	je     801053a6 <sys_getprocs+0x116>
    return -1;

  int i = 0;
  for(i = 0; i < maxprocs; i++) {
801052ec:	8b 45 e0             	mov    -0x20(%ebp),%eax
801052ef:	85 c0                	test   %eax,%eax
801052f1:	0f 8e ab 00 00 00    	jle    801053a2 <sys_getprocs+0x112>
801052f7:	31 f6                	xor    %esi,%esi
801052f9:	31 db                	xor    %ebx,%ebx
801052fb:	eb 28                	jmp    80105325 <sys_getprocs+0x95>
801052fd:	8d 76 00             	lea    0x0(%esi),%esi
    kprocs[i].pid = getpid(i);
    kprocs[i].ppid = getppid(i);
    //getprocname(i, kprocs[i].name);
    if(kprocs[i].pid == -2 || kprocs[i].ppid == -2 || (getprocname(i, kprocs[i].name)) == -2) {
80105300:	83 78 04 fe          	cmpl   $0xfffffffe,0x4(%eax)
80105304:	74 49                	je     8010534f <sys_getprocs+0xbf>
80105306:	83 c0 08             	add    $0x8,%eax
80105309:	89 44 24 04          	mov    %eax,0x4(%esp)
8010530d:	89 1c 24             	mov    %ebx,(%esp)
80105310:	e8 bb e4 ff ff       	call   801037d0 <getprocname>
80105315:	83 f8 fe             	cmp    $0xfffffffe,%eax
80105318:	74 66                	je     80105380 <sys_getprocs+0xf0>

  if(argptr(1, (void*)&kprocs, (sizeof(struct uproc) * maxprocs)) == -1)
    return -1;

  int i = 0;
  for(i = 0; i < maxprocs; i++) {
8010531a:	83 c3 01             	add    $0x1,%ebx
8010531d:	83 c6 18             	add    $0x18,%esi
80105320:	39 5d e0             	cmp    %ebx,-0x20(%ebp)
80105323:	7e 63                	jle    80105388 <sys_getprocs+0xf8>
    kprocs[i].pid = getpid(i);
80105325:	89 1c 24             	mov    %ebx,(%esp)
80105328:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010532b:	e8 40 e4 ff ff       	call   80103770 <getpid>
80105330:	01 f7                	add    %esi,%edi
80105332:	89 07                	mov    %eax,(%edi)
    kprocs[i].ppid = getppid(i);
80105334:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80105337:	89 1c 24             	mov    %ebx,(%esp)
8010533a:	e8 61 e4 ff ff       	call   801037a0 <getppid>
    //getprocname(i, kprocs[i].name);
    if(kprocs[i].pid == -2 || kprocs[i].ppid == -2 || (getprocname(i, kprocs[i].name)) == -2) {
8010533f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    return -1;

  int i = 0;
  for(i = 0; i < maxprocs; i++) {
    kprocs[i].pid = getpid(i);
    kprocs[i].ppid = getppid(i);
80105342:	01 f7                	add    %esi,%edi
80105344:	89 47 04             	mov    %eax,0x4(%edi)
    //getprocname(i, kprocs[i].name);
    if(kprocs[i].pid == -2 || kprocs[i].ppid == -2 || (getprocname(i, kprocs[i].name)) == -2) {
80105347:	8d 04 32             	lea    (%edx,%esi,1),%eax
8010534a:	83 38 fe             	cmpl   $0xfffffffe,(%eax)
8010534d:	75 b1                	jne    80105300 <sys_getprocs+0x70>

      //Add an indicator to the end so that pstree knows its the end of the list
      kprocs[i + 1].pid  = -2;
8010534f:	8d 44 5b 03          	lea    0x3(%ebx,%ebx,2),%eax
80105353:	c7 04 c2 fe ff ff ff 	movl   $0xfffffffe,(%edx,%eax,8)

      //break loop
      return 0; 
8010535a:	31 c0                	xor    %eax,%eax
  }

  kprocs[i].pid  = -2;
  return 0;

}
8010535c:	83 c4 2c             	add    $0x2c,%esp
8010535f:	5b                   	pop    %ebx
80105360:	5e                   	pop    %esi
80105361:	5f                   	pop    %edi
80105362:	5d                   	pop    %ebp
80105363:	c3                   	ret    
80105364:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  argint(0, &maxprocs);


  //If maxprocs exceeds max number of procs, bump it down
  if(maxprocs > NPROC)
    maxprocs = 64;
80105368:	c7 45 e0 40 00 00 00 	movl   $0x40,-0x20(%ebp)
8010536f:	b8 00 06 00 00       	mov    $0x600,%eax
80105374:	e9 53 ff ff ff       	jmp    801052cc <sys_getprocs+0x3c>
80105379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105380:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80105383:	eb ca                	jmp    8010534f <sys_getprocs+0xbf>
80105385:	8d 76 00             	lea    0x0(%esi),%esi
80105388:	8d 04 5b             	lea    (%ebx,%ebx,2),%eax
8010538b:	c1 e0 03             	shl    $0x3,%eax
      //break loop
      return 0; 
    }
  }

  kprocs[i].pid  = -2;
8010538e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80105391:	c7 04 02 fe ff ff ff 	movl   $0xfffffffe,(%edx,%eax,1)
  return 0;

}
80105398:	83 c4 2c             	add    $0x2c,%esp
      return 0; 
    }
  }

  kprocs[i].pid  = -2;
  return 0;
8010539b:	31 c0                	xor    %eax,%eax

}
8010539d:	5b                   	pop    %ebx
8010539e:	5e                   	pop    %esi
8010539f:	5f                   	pop    %edi
801053a0:	5d                   	pop    %ebp
801053a1:	c3                   	ret    

  if(argptr(1, (void*)&kprocs, (sizeof(struct uproc) * maxprocs)) == -1)
    return -1;

  int i = 0;
  for(i = 0; i < maxprocs; i++) {
801053a2:	31 c0                	xor    %eax,%eax
801053a4:	eb e8                	jmp    8010538e <sys_getprocs+0xfe>
  //If maxprocs exceeds max number of procs, bump it down
  if(maxprocs > NPROC)
    maxprocs = 64;

  if(argptr(1, (void*)&kprocs, (sizeof(struct uproc) * maxprocs)) == -1)
    return -1;
801053a6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801053ab:	eb af                	jmp    8010535c <sys_getprocs+0xcc>
801053ad:	8d 76 00             	lea    0x0(%esi),%esi

801053b0 <sys_fork>:
}


int
sys_fork(void)
{
801053b0:	55                   	push   %ebp
801053b1:	89 e5                	mov    %esp,%ebp
  return fork();
}
801053b3:	5d                   	pop    %ebp


int
sys_fork(void)
{
  return fork();
801053b4:	e9 07 e6 ff ff       	jmp    801039c0 <fork>
801053b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801053c0 <sys_exit>:
}

int
sys_exit(void)
{
801053c0:	55                   	push   %ebp
801053c1:	89 e5                	mov    %esp,%ebp
801053c3:	83 ec 08             	sub    $0x8,%esp
  exit();
801053c6:	e8 55 e8 ff ff       	call   80103c20 <exit>
  return 0;  // not reached
}
801053cb:	31 c0                	xor    %eax,%eax
801053cd:	c9                   	leave  
801053ce:	c3                   	ret    
801053cf:	90                   	nop

801053d0 <sys_wait>:

int
sys_wait(void)
{
801053d0:	55                   	push   %ebp
801053d1:	89 e5                	mov    %esp,%ebp
  return wait();
}
801053d3:	5d                   	pop    %ebp
}

int
sys_wait(void)
{
  return wait();
801053d4:	e9 87 ea ff ff       	jmp    80103e60 <wait>
801053d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801053e0 <sys_kill>:
}

int
sys_kill(void)
{
801053e0:	55                   	push   %ebp
801053e1:	89 e5                	mov    %esp,%ebp
801053e3:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
801053e6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053e9:	89 44 24 04          	mov    %eax,0x4(%esp)
801053ed:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801053f4:	e8 d7 f1 ff ff       	call   801045d0 <argint>
801053f9:	85 c0                	test   %eax,%eax
801053fb:	78 13                	js     80105410 <sys_kill+0x30>
    return -1;
  return kill(pid);
801053fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105400:	89 04 24             	mov    %eax,(%esp)
80105403:	e8 98 eb ff ff       	call   80103fa0 <kill>
}
80105408:	c9                   	leave  
80105409:	c3                   	ret    
8010540a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
80105410:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return kill(pid);
}
80105415:	c9                   	leave  
80105416:	c3                   	ret    
80105417:	89 f6                	mov    %esi,%esi
80105419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105420 <sys_getpid>:

int
sys_getpid(void)
{
  return proc->pid;
80105420:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  return kill(pid);
}

int
sys_getpid(void)
{
80105426:	55                   	push   %ebp
80105427:	89 e5                	mov    %esp,%ebp
  return proc->pid;
}
80105429:	5d                   	pop    %ebp
}

int
sys_getpid(void)
{
  return proc->pid;
8010542a:	8b 40 10             	mov    0x10(%eax),%eax
}
8010542d:	c3                   	ret    
8010542e:	66 90                	xchg   %ax,%ax

80105430 <sys_sbrk>:

int
sys_sbrk(void)
{
80105430:	55                   	push   %ebp
80105431:	89 e5                	mov    %esp,%ebp
80105433:	53                   	push   %ebx
80105434:	83 ec 24             	sub    $0x24,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105437:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010543a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010543e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105445:	e8 86 f1 ff ff       	call   801045d0 <argint>
8010544a:	85 c0                	test   %eax,%eax
8010544c:	78 22                	js     80105470 <sys_sbrk+0x40>
    return -1;
  addr = proc->sz;
8010544e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105454:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105456:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105459:	89 04 24             	mov    %eax,(%esp)
8010545c:	e8 df e4 ff ff       	call   80103940 <growproc>
80105461:	85 c0                	test   %eax,%eax
80105463:	78 0b                	js     80105470 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105465:	83 c4 24             	add    $0x24,%esp
80105468:	89 d8                	mov    %ebx,%eax
8010546a:	5b                   	pop    %ebx
8010546b:	5d                   	pop    %ebp
8010546c:	c3                   	ret    
8010546d:	8d 76 00             	lea    0x0(%esi),%esi
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
80105470:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105475:	eb ee                	jmp    80105465 <sys_sbrk+0x35>
80105477:	89 f6                	mov    %esi,%esi
80105479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105480 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
80105480:	55                   	push   %ebp
80105481:	89 e5                	mov    %esp,%ebp
80105483:	53                   	push   %ebx
80105484:	83 ec 24             	sub    $0x24,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105487:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010548a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010548e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105495:	e8 36 f1 ff ff       	call   801045d0 <argint>
8010549a:	85 c0                	test   %eax,%eax
8010549c:	78 7e                	js     8010551c <sys_sleep+0x9c>
    return -1;
  acquire(&tickslock);
8010549e:	c7 04 24 00 38 11 80 	movl   $0x80113800,(%esp)
801054a5:	e8 c6 ec ff ff       	call   80104170 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801054aa:	8b 55 f4             	mov    -0xc(%ebp),%edx
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
801054ad:	8b 1d 40 40 11 80    	mov    0x80114040,%ebx
  while(ticks - ticks0 < n){
801054b3:	85 d2                	test   %edx,%edx
801054b5:	75 29                	jne    801054e0 <sys_sleep+0x60>
801054b7:	eb 4f                	jmp    80105508 <sys_sleep+0x88>
801054b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(proc->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
801054c0:	c7 44 24 04 00 38 11 	movl   $0x80113800,0x4(%esp)
801054c7:	80 
801054c8:	c7 04 24 40 40 11 80 	movl   $0x80114040,(%esp)
801054cf:	e8 cc e8 ff ff       	call   80103da0 <sleep>

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801054d4:	a1 40 40 11 80       	mov    0x80114040,%eax
801054d9:	29 d8                	sub    %ebx,%eax
801054db:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801054de:	73 28                	jae    80105508 <sys_sleep+0x88>
    if(proc->killed){
801054e0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801054e6:	8b 40 24             	mov    0x24(%eax),%eax
801054e9:	85 c0                	test   %eax,%eax
801054eb:	74 d3                	je     801054c0 <sys_sleep+0x40>
      release(&tickslock);
801054ed:	c7 04 24 00 38 11 80 	movl   $0x80113800,(%esp)
801054f4:	e8 a7 ed ff ff       	call   801042a0 <release>
      return -1;
801054f9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
801054fe:	83 c4 24             	add    $0x24,%esp
80105501:	5b                   	pop    %ebx
80105502:	5d                   	pop    %ebp
80105503:	c3                   	ret    
80105504:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
80105508:	c7 04 24 00 38 11 80 	movl   $0x80113800,(%esp)
8010550f:	e8 8c ed ff ff       	call   801042a0 <release>
  return 0;
}
80105514:	83 c4 24             	add    $0x24,%esp
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
80105517:	31 c0                	xor    %eax,%eax
}
80105519:	5b                   	pop    %ebx
8010551a:	5d                   	pop    %ebp
8010551b:	c3                   	ret    
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
8010551c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105521:	eb db                	jmp    801054fe <sys_sleep+0x7e>
80105523:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105530 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105530:	55                   	push   %ebp
80105531:	89 e5                	mov    %esp,%ebp
80105533:	53                   	push   %ebx
80105534:	83 ec 14             	sub    $0x14,%esp
  uint xticks;

  acquire(&tickslock);
80105537:	c7 04 24 00 38 11 80 	movl   $0x80113800,(%esp)
8010553e:	e8 2d ec ff ff       	call   80104170 <acquire>
  xticks = ticks;
80105543:	8b 1d 40 40 11 80    	mov    0x80114040,%ebx
  release(&tickslock);
80105549:	c7 04 24 00 38 11 80 	movl   $0x80113800,(%esp)
80105550:	e8 4b ed ff ff       	call   801042a0 <release>
  return xticks;
}
80105555:	83 c4 14             	add    $0x14,%esp
80105558:	89 d8                	mov    %ebx,%eax
8010555a:	5b                   	pop    %ebx
8010555b:	5d                   	pop    %ebp
8010555c:	c3                   	ret    
8010555d:	66 90                	xchg   %ax,%ax
8010555f:	90                   	nop

80105560 <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
80105560:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105561:	ba 43 00 00 00       	mov    $0x43,%edx
80105566:	89 e5                	mov    %esp,%ebp
80105568:	b8 34 00 00 00       	mov    $0x34,%eax
8010556d:	83 ec 18             	sub    $0x18,%esp
80105570:	ee                   	out    %al,(%dx)
80105571:	b8 9c ff ff ff       	mov    $0xffffff9c,%eax
80105576:	b2 40                	mov    $0x40,%dl
80105578:	ee                   	out    %al,(%dx)
80105579:	b8 2e 00 00 00       	mov    $0x2e,%eax
8010557e:	ee                   	out    %al,(%dx)
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
  picenable(IRQ_TIMER);
8010557f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105586:	e8 65 dc ff ff       	call   801031f0 <picenable>
}
8010558b:	c9                   	leave  
8010558c:	c3                   	ret    

8010558d <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
8010558d:	1e                   	push   %ds
  pushl %es
8010558e:	06                   	push   %es
  pushl %fs
8010558f:	0f a0                	push   %fs
  pushl %gs
80105591:	0f a8                	push   %gs
  pushal
80105593:	60                   	pusha  
  
  # Set up data and per-cpu segments.
  movw $(SEG_KDATA<<3), %ax
80105594:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105598:	8e d8                	mov    %eax,%ds
  movw %ax, %es
8010559a:	8e c0                	mov    %eax,%es
  movw $(SEG_KCPU<<3), %ax
8010559c:	66 b8 18 00          	mov    $0x18,%ax
  movw %ax, %fs
801055a0:	8e e0                	mov    %eax,%fs
  movw %ax, %gs
801055a2:	8e e8                	mov    %eax,%gs

  # Call trap(tf), where tf=%esp
  pushl %esp
801055a4:	54                   	push   %esp
  call trap
801055a5:	e8 d6 00 00 00       	call   80105680 <trap>
  addl $4, %esp
801055aa:	83 c4 04             	add    $0x4,%esp

801055ad <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
801055ad:	61                   	popa   
  popl %gs
801055ae:	0f a9                	pop    %gs
  popl %fs
801055b0:	0f a1                	pop    %fs
  popl %es
801055b2:	07                   	pop    %es
  popl %ds
801055b3:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
801055b4:	83 c4 08             	add    $0x8,%esp
  iret
801055b7:	cf                   	iret   
801055b8:	66 90                	xchg   %ax,%ax
801055ba:	66 90                	xchg   %ax,%ax
801055bc:	66 90                	xchg   %ax,%ax
801055be:	66 90                	xchg   %ax,%ax

801055c0 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
801055c0:	31 c0                	xor    %eax,%eax
801055c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801055c8:	8b 14 85 0c a0 10 80 	mov    -0x7fef5ff4(,%eax,4),%edx
801055cf:	66 c7 04 c5 42 38 11 	movw   $0x8,-0x7feec7be(,%eax,8)
801055d6:	80 08 00 
801055d9:	c6 04 c5 44 38 11 80 	movb   $0x0,-0x7feec7bc(,%eax,8)
801055e0:	00 
801055e1:	c6 04 c5 45 38 11 80 	movb   $0x8e,-0x7feec7bb(,%eax,8)
801055e8:	8e 
801055e9:	66 89 14 c5 40 38 11 	mov    %dx,-0x7feec7c0(,%eax,8)
801055f0:	80 
801055f1:	c1 ea 10             	shr    $0x10,%edx
801055f4:	66 89 14 c5 46 38 11 	mov    %dx,-0x7feec7ba(,%eax,8)
801055fb:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
801055fc:	83 c0 01             	add    $0x1,%eax
801055ff:	3d 00 01 00 00       	cmp    $0x100,%eax
80105604:	75 c2                	jne    801055c8 <tvinit+0x8>
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105606:	55                   	push   %ebp
80105607:	89 e5                	mov    %esp,%ebp
80105609:	83 ec 18             	sub    $0x18,%esp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010560c:	a1 0c a1 10 80       	mov    0x8010a10c,%eax

  initlock(&tickslock, "time");
80105611:	c7 44 24 04 3d 75 10 	movl   $0x8010753d,0x4(%esp)
80105618:	80 
80105619:	c7 04 24 00 38 11 80 	movl   $0x80113800,(%esp)
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105620:	66 c7 05 42 3a 11 80 	movw   $0x8,0x80113a42
80105627:	08 00 
80105629:	66 a3 40 3a 11 80    	mov    %ax,0x80113a40
8010562f:	c1 e8 10             	shr    $0x10,%eax
80105632:	c6 05 44 3a 11 80 00 	movb   $0x0,0x80113a44
80105639:	c6 05 45 3a 11 80 ef 	movb   $0xef,0x80113a45
80105640:	66 a3 46 3a 11 80    	mov    %ax,0x80113a46

  initlock(&tickslock, "time");
80105646:	e8 a5 ea ff ff       	call   801040f0 <initlock>
}
8010564b:	c9                   	leave  
8010564c:	c3                   	ret    
8010564d:	8d 76 00             	lea    0x0(%esi),%esi

80105650 <idtinit>:

void
idtinit(void)
{
80105650:	55                   	push   %ebp
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  pd[1] = (uint)p;
80105651:	b8 40 38 11 80       	mov    $0x80113840,%eax
80105656:	89 e5                	mov    %esp,%ebp
80105658:	83 ec 10             	sub    $0x10,%esp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
8010565b:	66 c7 45 fa ff 07    	movw   $0x7ff,-0x6(%ebp)
  pd[1] = (uint)p;
80105661:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105665:	c1 e8 10             	shr    $0x10,%eax
80105668:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
8010566c:	8d 45 fa             	lea    -0x6(%ebp),%eax
8010566f:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105672:	c9                   	leave  
80105673:	c3                   	ret    
80105674:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010567a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105680 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105680:	55                   	push   %ebp
80105681:	89 e5                	mov    %esp,%ebp
80105683:	83 ec 38             	sub    $0x38,%esp
80105686:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80105689:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010568c:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010568f:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if(tf->trapno == T_SYSCALL){
80105692:	8b 43 30             	mov    0x30(%ebx),%eax
80105695:	83 f8 40             	cmp    $0x40,%eax
80105698:	0f 84 fa 00 00 00    	je     80105798 <trap+0x118>
    if(proc->killed)
      exit();
    return;
  }

  switch(tf->trapno){
8010569e:	83 e8 20             	sub    $0x20,%eax
801056a1:	83 f8 1f             	cmp    $0x1f,%eax
801056a4:	0f 86 8e 00 00 00    	jbe    80105738 <trap+0xb8>
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
801056aa:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
801056b1:	85 c9                	test   %ecx,%ecx
801056b3:	0f 84 ff 01 00 00    	je     801058b8 <trap+0x238>
801056b9:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
801056bd:	0f 84 f5 01 00 00    	je     801058b8 <trap+0x238>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801056c3:	0f 20 d7             	mov    %cr2,%edi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpunum(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801056c6:	8b 73 38             	mov    0x38(%ebx),%esi
801056c9:	e8 92 d0 ff ff       	call   80102760 <cpunum>
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
801056ce:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpunum(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801056d5:	89 7c 24 1c          	mov    %edi,0x1c(%esp)
801056d9:	89 74 24 18          	mov    %esi,0x18(%esp)
801056dd:	89 44 24 14          	mov    %eax,0x14(%esp)
801056e1:	8b 43 34             	mov    0x34(%ebx),%eax
801056e4:	89 44 24 10          	mov    %eax,0x10(%esp)
801056e8:	8b 43 30             	mov    0x30(%ebx),%eax
801056eb:	89 44 24 0c          	mov    %eax,0xc(%esp)
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
801056ef:	8d 42 6c             	lea    0x6c(%edx),%eax
801056f2:	89 44 24 08          	mov    %eax,0x8(%esp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpunum(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801056f6:	8b 42 10             	mov    0x10(%edx),%eax
801056f9:	c7 04 24 a0 75 10 80 	movl   $0x801075a0,(%esp)
80105700:	89 44 24 04          	mov    %eax,0x4(%esp)
80105704:	e8 f7 ae ff ff       	call   80100600 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
            rcr2());
    proc->killed = 1;
80105709:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010570f:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105716:	0f b7 53 3c          	movzwl 0x3c(%ebx),%edx
8010571a:	83 e2 03             	and    $0x3,%edx
8010571d:	66 83 fa 03          	cmp    $0x3,%dx
80105721:	75 43                	jne    80105766 <trap+0xe6>
    exit();
80105723:	e8 f8 e4 ff ff       	call   80103c20 <exit>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105728:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010572e:	85 c0                	test   %eax,%eax
80105730:	75 34                	jne    80105766 <trap+0xe6>
80105732:	eb 50                	jmp    80105784 <trap+0x104>
80105734:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(proc->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105738:	ff 24 85 e4 75 10 80 	jmp    *-0x7fef8a1c(,%eax,4)
8010573f:	90                   	nop
  case T_IRQ0 + IRQ_TIMER:
    if(cpunum() == 0){
80105740:	e8 1b d0 ff ff       	call   80102760 <cpunum>
80105745:	85 c0                	test   %eax,%eax
80105747:	0f 84 3b 01 00 00    	je     80105888 <trap+0x208>
8010574d:	8d 76 00             	lea    0x0(%esi),%esi
      acquire(&tickslock);
      ticks++;
      wakeup(&ticks);
      release(&tickslock);
    }
    lapiceoi();
80105750:	e8 ab d0 ff ff       	call   80102800 <lapiceoi>
80105755:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
8010575b:	85 c0                	test   %eax,%eax
8010575d:	74 25                	je     80105784 <trap+0x104>
8010575f:	8b 50 24             	mov    0x24(%eax),%edx
80105762:	85 d2                	test   %edx,%edx
80105764:	75 b0                	jne    80105716 <trap+0x96>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105766:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
8010576a:	0f 84 f0 00 00 00    	je     80105860 <trap+0x1e0>
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105770:	8b 40 24             	mov    0x24(%eax),%eax
80105773:	85 c0                	test   %eax,%eax
80105775:	74 0d                	je     80105784 <trap+0x104>
80105777:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
8010577b:	83 e0 03             	and    $0x3,%eax
8010577e:	66 83 f8 03          	cmp    $0x3,%ax
80105782:	74 36                	je     801057ba <trap+0x13a>
    exit();
}
80105784:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105787:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010578a:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010578d:	89 ec                	mov    %ebp,%esp
8010578f:	5d                   	pop    %ebp
80105790:	c3                   	ret    
80105791:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(proc->killed)
80105798:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010579e:	8b 70 24             	mov    0x24(%eax),%esi
801057a1:	85 f6                	test   %esi,%esi
801057a3:	75 2b                	jne    801057d0 <trap+0x150>
      exit();
    proc->tf = tf;
801057a5:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
801057a8:	e8 33 ef ff ff       	call   801046e0 <syscall>
    if(proc->killed)
801057ad:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801057b3:	8b 58 24             	mov    0x24(%eax),%ebx
801057b6:	85 db                	test   %ebx,%ebx
801057b8:	74 ca                	je     80105784 <trap+0x104>
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();
}
801057ba:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801057bd:	8b 75 f8             	mov    -0x8(%ebp),%esi
801057c0:	8b 7d fc             	mov    -0x4(%ebp),%edi
801057c3:	89 ec                	mov    %ebp,%esp
801057c5:	5d                   	pop    %ebp
    if(proc->killed)
      exit();
    proc->tf = tf;
    syscall();
    if(proc->killed)
      exit();
801057c6:	e9 55 e4 ff ff       	jmp    80103c20 <exit>
801057cb:	90                   	nop
801057cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(proc->killed)
      exit();
801057d0:	e8 4b e4 ff ff       	call   80103c20 <exit>
801057d5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801057db:	eb c8                	jmp    801057a5 <trap+0x125>
801057dd:	8d 76 00             	lea    0x0(%esi),%esi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
801057e0:	e8 db c8 ff ff       	call   801020c0 <ideintr>
    lapiceoi();
801057e5:	e8 16 d0 ff ff       	call   80102800 <lapiceoi>
801057ea:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
    break;
801057f0:	e9 66 ff ff ff       	jmp    8010575b <trap+0xdb>
801057f5:	8d 76 00             	lea    0x0(%esi),%esi
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801057f8:	8b 7b 38             	mov    0x38(%ebx),%edi
801057fb:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
801057ff:	e8 5c cf ff ff       	call   80102760 <cpunum>
80105804:	c7 04 24 48 75 10 80 	movl   $0x80107548,(%esp)
8010580b:	89 7c 24 0c          	mov    %edi,0xc(%esp)
8010580f:	89 74 24 08          	mov    %esi,0x8(%esp)
80105813:	89 44 24 04          	mov    %eax,0x4(%esp)
80105817:	e8 e4 ad ff ff       	call   80100600 <cprintf>
            cpunum(), tf->cs, tf->eip);
    lapiceoi();
8010581c:	e8 df cf ff ff       	call   80102800 <lapiceoi>
80105821:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
    break;
80105827:	e9 2f ff ff ff       	jmp    8010575b <trap+0xdb>
8010582c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80105830:	e8 eb 01 00 00       	call   80105a20 <uartintr>
    lapiceoi();
80105835:	e8 c6 cf ff ff       	call   80102800 <lapiceoi>
8010583a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
    break;
80105840:	e9 16 ff ff ff       	jmp    8010575b <trap+0xdb>
80105845:	8d 76 00             	lea    0x0(%esi),%esi
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80105848:	e8 83 cd ff ff       	call   801025d0 <kbdintr>
    lapiceoi();
8010584d:	e8 ae cf ff ff       	call   80102800 <lapiceoi>
80105852:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
    break;
80105858:	e9 fe fe ff ff       	jmp    8010575b <trap+0xdb>
8010585d:	8d 76 00             	lea    0x0(%esi),%esi
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105860:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105864:	0f 85 06 ff ff ff    	jne    80105770 <trap+0xf0>
    yield();
8010586a:	e8 f1 e4 ff ff       	call   80103d60 <yield>

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
8010586f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105875:	85 c0                	test   %eax,%eax
80105877:	0f 85 f3 fe ff ff    	jne    80105770 <trap+0xf0>
8010587d:	e9 02 ff ff ff       	jmp    80105784 <trap+0x104>
80105882:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpunum() == 0){
      acquire(&tickslock);
80105888:	c7 04 24 00 38 11 80 	movl   $0x80113800,(%esp)
8010588f:	e8 dc e8 ff ff       	call   80104170 <acquire>
      ticks++;
      wakeup(&ticks);
80105894:	c7 04 24 40 40 11 80 	movl   $0x80114040,(%esp)

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpunum() == 0){
      acquire(&tickslock);
      ticks++;
8010589b:	83 05 40 40 11 80 01 	addl   $0x1,0x80114040
      wakeup(&ticks);
801058a2:	e8 99 e6 ff ff       	call   80103f40 <wakeup>
      release(&tickslock);
801058a7:	c7 04 24 00 38 11 80 	movl   $0x80113800,(%esp)
801058ae:	e8 ed e9 ff ff       	call   801042a0 <release>
801058b3:	e9 95 fe ff ff       	jmp    8010574d <trap+0xcd>
801058b8:	0f 20 d7             	mov    %cr2,%edi

  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801058bb:	8b 73 38             	mov    0x38(%ebx),%esi
801058be:	e8 9d ce ff ff       	call   80102760 <cpunum>
801058c3:	89 7c 24 10          	mov    %edi,0x10(%esp)
801058c7:	89 74 24 0c          	mov    %esi,0xc(%esp)
801058cb:	89 44 24 08          	mov    %eax,0x8(%esp)
801058cf:	8b 43 30             	mov    0x30(%ebx),%eax
801058d2:	c7 04 24 6c 75 10 80 	movl   $0x8010756c,(%esp)
801058d9:	89 44 24 04          	mov    %eax,0x4(%esp)
801058dd:	e8 1e ad ff ff       	call   80100600 <cprintf>
              tf->trapno, cpunum(), tf->eip, rcr2());
      panic("trap");
801058e2:	c7 04 24 42 75 10 80 	movl   $0x80107542,(%esp)
801058e9:	e8 42 aa ff ff       	call   80100330 <panic>
801058ee:	66 90                	xchg   %ax,%ax

801058f0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
801058f0:	a1 a8 a5 10 80       	mov    0x8010a5a8,%eax
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
801058f5:	55                   	push   %ebp
801058f6:	89 e5                	mov    %esp,%ebp
  if(!uart)
801058f8:	85 c0                	test   %eax,%eax
801058fa:	74 14                	je     80105910 <uartgetc+0x20>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801058fc:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105901:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105902:	a8 01                	test   $0x1,%al
80105904:	74 0a                	je     80105910 <uartgetc+0x20>
80105906:	b2 f8                	mov    $0xf8,%dl
80105908:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105909:	0f b6 c0             	movzbl %al,%eax
}
8010590c:	5d                   	pop    %ebp
8010590d:	c3                   	ret    
8010590e:	66 90                	xchg   %ax,%ax

static int
uartgetc(void)
{
  if(!uart)
    return -1;
80105910:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
}
80105915:	5d                   	pop    %ebp
80105916:	c3                   	ret    
80105917:	89 f6                	mov    %esi,%esi
80105919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105920 <uartputc>:
void
uartputc(int c)
{
  int i;

  if(!uart)
80105920:	a1 a8 a5 10 80       	mov    0x8010a5a8,%eax
80105925:	85 c0                	test   %eax,%eax
80105927:	74 3f                	je     80105968 <uartputc+0x48>
    uartputc(*p);
}

void
uartputc(int c)
{
80105929:	55                   	push   %ebp
8010592a:	89 e5                	mov    %esp,%ebp
8010592c:	56                   	push   %esi
8010592d:	be fd 03 00 00       	mov    $0x3fd,%esi
80105932:	53                   	push   %ebx
  int i;

  if(!uart)
80105933:	bb 80 00 00 00       	mov    $0x80,%ebx
    uartputc(*p);
}

void
uartputc(int c)
{
80105938:	83 ec 10             	sub    $0x10,%esp
8010593b:	eb 14                	jmp    80105951 <uartputc+0x31>
8010593d:	8d 76 00             	lea    0x0(%esi),%esi
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
80105940:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
80105947:	e8 d4 ce ff ff       	call   80102820 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010594c:	83 eb 01             	sub    $0x1,%ebx
8010594f:	74 07                	je     80105958 <uartputc+0x38>
80105951:	89 f2                	mov    %esi,%edx
80105953:	ec                   	in     (%dx),%al
80105954:	a8 20                	test   $0x20,%al
80105956:	74 e8                	je     80105940 <uartputc+0x20>
    microdelay(10);
  outb(COM1+0, c);
80105958:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010595c:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105961:	ee                   	out    %al,(%dx)
}
80105962:	83 c4 10             	add    $0x10,%esp
80105965:	5b                   	pop    %ebx
80105966:	5e                   	pop    %esi
80105967:	5d                   	pop    %ebp
80105968:	f3 c3                	repz ret 
8010596a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105970 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80105970:	55                   	push   %ebp
80105971:	31 c9                	xor    %ecx,%ecx
80105973:	89 e5                	mov    %esp,%ebp
80105975:	89 c8                	mov    %ecx,%eax
80105977:	57                   	push   %edi
80105978:	bf fa 03 00 00       	mov    $0x3fa,%edi
8010597d:	56                   	push   %esi
8010597e:	89 fa                	mov    %edi,%edx
80105980:	53                   	push   %ebx
80105981:	83 ec 1c             	sub    $0x1c,%esp
80105984:	ee                   	out    %al,(%dx)
80105985:	be fb 03 00 00       	mov    $0x3fb,%esi
8010598a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
8010598f:	89 f2                	mov    %esi,%edx
80105991:	ee                   	out    %al,(%dx)
80105992:	b8 0c 00 00 00       	mov    $0xc,%eax
80105997:	b2 f8                	mov    $0xf8,%dl
80105999:	ee                   	out    %al,(%dx)
8010599a:	bb f9 03 00 00       	mov    $0x3f9,%ebx
8010599f:	89 c8                	mov    %ecx,%eax
801059a1:	89 da                	mov    %ebx,%edx
801059a3:	ee                   	out    %al,(%dx)
801059a4:	b8 03 00 00 00       	mov    $0x3,%eax
801059a9:	89 f2                	mov    %esi,%edx
801059ab:	ee                   	out    %al,(%dx)
801059ac:	b2 fc                	mov    $0xfc,%dl
801059ae:	89 c8                	mov    %ecx,%eax
801059b0:	ee                   	out    %al,(%dx)
801059b1:	b8 01 00 00 00       	mov    $0x1,%eax
801059b6:	89 da                	mov    %ebx,%edx
801059b8:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801059b9:	b2 fd                	mov    $0xfd,%dl
801059bb:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
801059bc:	3c ff                	cmp    $0xff,%al
801059be:	74 52                	je     80105a12 <uartinit+0xa2>
    return;
  uart = 1;
801059c0:	c7 05 a8 a5 10 80 01 	movl   $0x1,0x8010a5a8
801059c7:	00 00 00 
801059ca:	89 fa                	mov    %edi,%edx
801059cc:	ec                   	in     (%dx),%al
801059cd:	b2 f8                	mov    $0xf8,%dl
801059cf:	ec                   	in     (%dx),%al

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  picenable(IRQ_COM1);
801059d0:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
801059d7:	bb 64 76 10 80       	mov    $0x80107664,%ebx

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  picenable(IRQ_COM1);
801059dc:	e8 0f d8 ff ff       	call   801031f0 <picenable>
  ioapicenable(IRQ_COM1, 0);
801059e1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801059e8:	00 
801059e9:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
801059f0:	e8 fb c8 ff ff       	call   801022f0 <ioapicenable>

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
801059f5:	b8 78 00 00 00       	mov    $0x78,%eax
801059fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    uartputc(*p);
80105a00:	89 04 24             	mov    %eax,(%esp)
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105a03:	83 c3 01             	add    $0x1,%ebx
    uartputc(*p);
80105a06:	e8 15 ff ff ff       	call   80105920 <uartputc>
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105a0b:	0f be 03             	movsbl (%ebx),%eax
80105a0e:	84 c0                	test   %al,%al
80105a10:	75 ee                	jne    80105a00 <uartinit+0x90>
    uartputc(*p);
}
80105a12:	83 c4 1c             	add    $0x1c,%esp
80105a15:	5b                   	pop    %ebx
80105a16:	5e                   	pop    %esi
80105a17:	5f                   	pop    %edi
80105a18:	5d                   	pop    %ebp
80105a19:	c3                   	ret    
80105a1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105a20 <uartintr>:
  return inb(COM1+0);
}

void
uartintr(void)
{
80105a20:	55                   	push   %ebp
80105a21:	89 e5                	mov    %esp,%ebp
80105a23:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
80105a26:	c7 04 24 f0 58 10 80 	movl   $0x801058f0,(%esp)
80105a2d:	e8 2e ad ff ff       	call   80100760 <consoleintr>
}
80105a32:	c9                   	leave  
80105a33:	c3                   	ret    

80105a34 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105a34:	6a 00                	push   $0x0
  pushl $0
80105a36:	6a 00                	push   $0x0
  jmp alltraps
80105a38:	e9 50 fb ff ff       	jmp    8010558d <alltraps>

80105a3d <vector1>:
.globl vector1
vector1:
  pushl $0
80105a3d:	6a 00                	push   $0x0
  pushl $1
80105a3f:	6a 01                	push   $0x1
  jmp alltraps
80105a41:	e9 47 fb ff ff       	jmp    8010558d <alltraps>

80105a46 <vector2>:
.globl vector2
vector2:
  pushl $0
80105a46:	6a 00                	push   $0x0
  pushl $2
80105a48:	6a 02                	push   $0x2
  jmp alltraps
80105a4a:	e9 3e fb ff ff       	jmp    8010558d <alltraps>

80105a4f <vector3>:
.globl vector3
vector3:
  pushl $0
80105a4f:	6a 00                	push   $0x0
  pushl $3
80105a51:	6a 03                	push   $0x3
  jmp alltraps
80105a53:	e9 35 fb ff ff       	jmp    8010558d <alltraps>

80105a58 <vector4>:
.globl vector4
vector4:
  pushl $0
80105a58:	6a 00                	push   $0x0
  pushl $4
80105a5a:	6a 04                	push   $0x4
  jmp alltraps
80105a5c:	e9 2c fb ff ff       	jmp    8010558d <alltraps>

80105a61 <vector5>:
.globl vector5
vector5:
  pushl $0
80105a61:	6a 00                	push   $0x0
  pushl $5
80105a63:	6a 05                	push   $0x5
  jmp alltraps
80105a65:	e9 23 fb ff ff       	jmp    8010558d <alltraps>

80105a6a <vector6>:
.globl vector6
vector6:
  pushl $0
80105a6a:	6a 00                	push   $0x0
  pushl $6
80105a6c:	6a 06                	push   $0x6
  jmp alltraps
80105a6e:	e9 1a fb ff ff       	jmp    8010558d <alltraps>

80105a73 <vector7>:
.globl vector7
vector7:
  pushl $0
80105a73:	6a 00                	push   $0x0
  pushl $7
80105a75:	6a 07                	push   $0x7
  jmp alltraps
80105a77:	e9 11 fb ff ff       	jmp    8010558d <alltraps>

80105a7c <vector8>:
.globl vector8
vector8:
  pushl $8
80105a7c:	6a 08                	push   $0x8
  jmp alltraps
80105a7e:	e9 0a fb ff ff       	jmp    8010558d <alltraps>

80105a83 <vector9>:
.globl vector9
vector9:
  pushl $0
80105a83:	6a 00                	push   $0x0
  pushl $9
80105a85:	6a 09                	push   $0x9
  jmp alltraps
80105a87:	e9 01 fb ff ff       	jmp    8010558d <alltraps>

80105a8c <vector10>:
.globl vector10
vector10:
  pushl $10
80105a8c:	6a 0a                	push   $0xa
  jmp alltraps
80105a8e:	e9 fa fa ff ff       	jmp    8010558d <alltraps>

80105a93 <vector11>:
.globl vector11
vector11:
  pushl $11
80105a93:	6a 0b                	push   $0xb
  jmp alltraps
80105a95:	e9 f3 fa ff ff       	jmp    8010558d <alltraps>

80105a9a <vector12>:
.globl vector12
vector12:
  pushl $12
80105a9a:	6a 0c                	push   $0xc
  jmp alltraps
80105a9c:	e9 ec fa ff ff       	jmp    8010558d <alltraps>

80105aa1 <vector13>:
.globl vector13
vector13:
  pushl $13
80105aa1:	6a 0d                	push   $0xd
  jmp alltraps
80105aa3:	e9 e5 fa ff ff       	jmp    8010558d <alltraps>

80105aa8 <vector14>:
.globl vector14
vector14:
  pushl $14
80105aa8:	6a 0e                	push   $0xe
  jmp alltraps
80105aaa:	e9 de fa ff ff       	jmp    8010558d <alltraps>

80105aaf <vector15>:
.globl vector15
vector15:
  pushl $0
80105aaf:	6a 00                	push   $0x0
  pushl $15
80105ab1:	6a 0f                	push   $0xf
  jmp alltraps
80105ab3:	e9 d5 fa ff ff       	jmp    8010558d <alltraps>

80105ab8 <vector16>:
.globl vector16
vector16:
  pushl $0
80105ab8:	6a 00                	push   $0x0
  pushl $16
80105aba:	6a 10                	push   $0x10
  jmp alltraps
80105abc:	e9 cc fa ff ff       	jmp    8010558d <alltraps>

80105ac1 <vector17>:
.globl vector17
vector17:
  pushl $17
80105ac1:	6a 11                	push   $0x11
  jmp alltraps
80105ac3:	e9 c5 fa ff ff       	jmp    8010558d <alltraps>

80105ac8 <vector18>:
.globl vector18
vector18:
  pushl $0
80105ac8:	6a 00                	push   $0x0
  pushl $18
80105aca:	6a 12                	push   $0x12
  jmp alltraps
80105acc:	e9 bc fa ff ff       	jmp    8010558d <alltraps>

80105ad1 <vector19>:
.globl vector19
vector19:
  pushl $0
80105ad1:	6a 00                	push   $0x0
  pushl $19
80105ad3:	6a 13                	push   $0x13
  jmp alltraps
80105ad5:	e9 b3 fa ff ff       	jmp    8010558d <alltraps>

80105ada <vector20>:
.globl vector20
vector20:
  pushl $0
80105ada:	6a 00                	push   $0x0
  pushl $20
80105adc:	6a 14                	push   $0x14
  jmp alltraps
80105ade:	e9 aa fa ff ff       	jmp    8010558d <alltraps>

80105ae3 <vector21>:
.globl vector21
vector21:
  pushl $0
80105ae3:	6a 00                	push   $0x0
  pushl $21
80105ae5:	6a 15                	push   $0x15
  jmp alltraps
80105ae7:	e9 a1 fa ff ff       	jmp    8010558d <alltraps>

80105aec <vector22>:
.globl vector22
vector22:
  pushl $0
80105aec:	6a 00                	push   $0x0
  pushl $22
80105aee:	6a 16                	push   $0x16
  jmp alltraps
80105af0:	e9 98 fa ff ff       	jmp    8010558d <alltraps>

80105af5 <vector23>:
.globl vector23
vector23:
  pushl $0
80105af5:	6a 00                	push   $0x0
  pushl $23
80105af7:	6a 17                	push   $0x17
  jmp alltraps
80105af9:	e9 8f fa ff ff       	jmp    8010558d <alltraps>

80105afe <vector24>:
.globl vector24
vector24:
  pushl $0
80105afe:	6a 00                	push   $0x0
  pushl $24
80105b00:	6a 18                	push   $0x18
  jmp alltraps
80105b02:	e9 86 fa ff ff       	jmp    8010558d <alltraps>

80105b07 <vector25>:
.globl vector25
vector25:
  pushl $0
80105b07:	6a 00                	push   $0x0
  pushl $25
80105b09:	6a 19                	push   $0x19
  jmp alltraps
80105b0b:	e9 7d fa ff ff       	jmp    8010558d <alltraps>

80105b10 <vector26>:
.globl vector26
vector26:
  pushl $0
80105b10:	6a 00                	push   $0x0
  pushl $26
80105b12:	6a 1a                	push   $0x1a
  jmp alltraps
80105b14:	e9 74 fa ff ff       	jmp    8010558d <alltraps>

80105b19 <vector27>:
.globl vector27
vector27:
  pushl $0
80105b19:	6a 00                	push   $0x0
  pushl $27
80105b1b:	6a 1b                	push   $0x1b
  jmp alltraps
80105b1d:	e9 6b fa ff ff       	jmp    8010558d <alltraps>

80105b22 <vector28>:
.globl vector28
vector28:
  pushl $0
80105b22:	6a 00                	push   $0x0
  pushl $28
80105b24:	6a 1c                	push   $0x1c
  jmp alltraps
80105b26:	e9 62 fa ff ff       	jmp    8010558d <alltraps>

80105b2b <vector29>:
.globl vector29
vector29:
  pushl $0
80105b2b:	6a 00                	push   $0x0
  pushl $29
80105b2d:	6a 1d                	push   $0x1d
  jmp alltraps
80105b2f:	e9 59 fa ff ff       	jmp    8010558d <alltraps>

80105b34 <vector30>:
.globl vector30
vector30:
  pushl $0
80105b34:	6a 00                	push   $0x0
  pushl $30
80105b36:	6a 1e                	push   $0x1e
  jmp alltraps
80105b38:	e9 50 fa ff ff       	jmp    8010558d <alltraps>

80105b3d <vector31>:
.globl vector31
vector31:
  pushl $0
80105b3d:	6a 00                	push   $0x0
  pushl $31
80105b3f:	6a 1f                	push   $0x1f
  jmp alltraps
80105b41:	e9 47 fa ff ff       	jmp    8010558d <alltraps>

80105b46 <vector32>:
.globl vector32
vector32:
  pushl $0
80105b46:	6a 00                	push   $0x0
  pushl $32
80105b48:	6a 20                	push   $0x20
  jmp alltraps
80105b4a:	e9 3e fa ff ff       	jmp    8010558d <alltraps>

80105b4f <vector33>:
.globl vector33
vector33:
  pushl $0
80105b4f:	6a 00                	push   $0x0
  pushl $33
80105b51:	6a 21                	push   $0x21
  jmp alltraps
80105b53:	e9 35 fa ff ff       	jmp    8010558d <alltraps>

80105b58 <vector34>:
.globl vector34
vector34:
  pushl $0
80105b58:	6a 00                	push   $0x0
  pushl $34
80105b5a:	6a 22                	push   $0x22
  jmp alltraps
80105b5c:	e9 2c fa ff ff       	jmp    8010558d <alltraps>

80105b61 <vector35>:
.globl vector35
vector35:
  pushl $0
80105b61:	6a 00                	push   $0x0
  pushl $35
80105b63:	6a 23                	push   $0x23
  jmp alltraps
80105b65:	e9 23 fa ff ff       	jmp    8010558d <alltraps>

80105b6a <vector36>:
.globl vector36
vector36:
  pushl $0
80105b6a:	6a 00                	push   $0x0
  pushl $36
80105b6c:	6a 24                	push   $0x24
  jmp alltraps
80105b6e:	e9 1a fa ff ff       	jmp    8010558d <alltraps>

80105b73 <vector37>:
.globl vector37
vector37:
  pushl $0
80105b73:	6a 00                	push   $0x0
  pushl $37
80105b75:	6a 25                	push   $0x25
  jmp alltraps
80105b77:	e9 11 fa ff ff       	jmp    8010558d <alltraps>

80105b7c <vector38>:
.globl vector38
vector38:
  pushl $0
80105b7c:	6a 00                	push   $0x0
  pushl $38
80105b7e:	6a 26                	push   $0x26
  jmp alltraps
80105b80:	e9 08 fa ff ff       	jmp    8010558d <alltraps>

80105b85 <vector39>:
.globl vector39
vector39:
  pushl $0
80105b85:	6a 00                	push   $0x0
  pushl $39
80105b87:	6a 27                	push   $0x27
  jmp alltraps
80105b89:	e9 ff f9 ff ff       	jmp    8010558d <alltraps>

80105b8e <vector40>:
.globl vector40
vector40:
  pushl $0
80105b8e:	6a 00                	push   $0x0
  pushl $40
80105b90:	6a 28                	push   $0x28
  jmp alltraps
80105b92:	e9 f6 f9 ff ff       	jmp    8010558d <alltraps>

80105b97 <vector41>:
.globl vector41
vector41:
  pushl $0
80105b97:	6a 00                	push   $0x0
  pushl $41
80105b99:	6a 29                	push   $0x29
  jmp alltraps
80105b9b:	e9 ed f9 ff ff       	jmp    8010558d <alltraps>

80105ba0 <vector42>:
.globl vector42
vector42:
  pushl $0
80105ba0:	6a 00                	push   $0x0
  pushl $42
80105ba2:	6a 2a                	push   $0x2a
  jmp alltraps
80105ba4:	e9 e4 f9 ff ff       	jmp    8010558d <alltraps>

80105ba9 <vector43>:
.globl vector43
vector43:
  pushl $0
80105ba9:	6a 00                	push   $0x0
  pushl $43
80105bab:	6a 2b                	push   $0x2b
  jmp alltraps
80105bad:	e9 db f9 ff ff       	jmp    8010558d <alltraps>

80105bb2 <vector44>:
.globl vector44
vector44:
  pushl $0
80105bb2:	6a 00                	push   $0x0
  pushl $44
80105bb4:	6a 2c                	push   $0x2c
  jmp alltraps
80105bb6:	e9 d2 f9 ff ff       	jmp    8010558d <alltraps>

80105bbb <vector45>:
.globl vector45
vector45:
  pushl $0
80105bbb:	6a 00                	push   $0x0
  pushl $45
80105bbd:	6a 2d                	push   $0x2d
  jmp alltraps
80105bbf:	e9 c9 f9 ff ff       	jmp    8010558d <alltraps>

80105bc4 <vector46>:
.globl vector46
vector46:
  pushl $0
80105bc4:	6a 00                	push   $0x0
  pushl $46
80105bc6:	6a 2e                	push   $0x2e
  jmp alltraps
80105bc8:	e9 c0 f9 ff ff       	jmp    8010558d <alltraps>

80105bcd <vector47>:
.globl vector47
vector47:
  pushl $0
80105bcd:	6a 00                	push   $0x0
  pushl $47
80105bcf:	6a 2f                	push   $0x2f
  jmp alltraps
80105bd1:	e9 b7 f9 ff ff       	jmp    8010558d <alltraps>

80105bd6 <vector48>:
.globl vector48
vector48:
  pushl $0
80105bd6:	6a 00                	push   $0x0
  pushl $48
80105bd8:	6a 30                	push   $0x30
  jmp alltraps
80105bda:	e9 ae f9 ff ff       	jmp    8010558d <alltraps>

80105bdf <vector49>:
.globl vector49
vector49:
  pushl $0
80105bdf:	6a 00                	push   $0x0
  pushl $49
80105be1:	6a 31                	push   $0x31
  jmp alltraps
80105be3:	e9 a5 f9 ff ff       	jmp    8010558d <alltraps>

80105be8 <vector50>:
.globl vector50
vector50:
  pushl $0
80105be8:	6a 00                	push   $0x0
  pushl $50
80105bea:	6a 32                	push   $0x32
  jmp alltraps
80105bec:	e9 9c f9 ff ff       	jmp    8010558d <alltraps>

80105bf1 <vector51>:
.globl vector51
vector51:
  pushl $0
80105bf1:	6a 00                	push   $0x0
  pushl $51
80105bf3:	6a 33                	push   $0x33
  jmp alltraps
80105bf5:	e9 93 f9 ff ff       	jmp    8010558d <alltraps>

80105bfa <vector52>:
.globl vector52
vector52:
  pushl $0
80105bfa:	6a 00                	push   $0x0
  pushl $52
80105bfc:	6a 34                	push   $0x34
  jmp alltraps
80105bfe:	e9 8a f9 ff ff       	jmp    8010558d <alltraps>

80105c03 <vector53>:
.globl vector53
vector53:
  pushl $0
80105c03:	6a 00                	push   $0x0
  pushl $53
80105c05:	6a 35                	push   $0x35
  jmp alltraps
80105c07:	e9 81 f9 ff ff       	jmp    8010558d <alltraps>

80105c0c <vector54>:
.globl vector54
vector54:
  pushl $0
80105c0c:	6a 00                	push   $0x0
  pushl $54
80105c0e:	6a 36                	push   $0x36
  jmp alltraps
80105c10:	e9 78 f9 ff ff       	jmp    8010558d <alltraps>

80105c15 <vector55>:
.globl vector55
vector55:
  pushl $0
80105c15:	6a 00                	push   $0x0
  pushl $55
80105c17:	6a 37                	push   $0x37
  jmp alltraps
80105c19:	e9 6f f9 ff ff       	jmp    8010558d <alltraps>

80105c1e <vector56>:
.globl vector56
vector56:
  pushl $0
80105c1e:	6a 00                	push   $0x0
  pushl $56
80105c20:	6a 38                	push   $0x38
  jmp alltraps
80105c22:	e9 66 f9 ff ff       	jmp    8010558d <alltraps>

80105c27 <vector57>:
.globl vector57
vector57:
  pushl $0
80105c27:	6a 00                	push   $0x0
  pushl $57
80105c29:	6a 39                	push   $0x39
  jmp alltraps
80105c2b:	e9 5d f9 ff ff       	jmp    8010558d <alltraps>

80105c30 <vector58>:
.globl vector58
vector58:
  pushl $0
80105c30:	6a 00                	push   $0x0
  pushl $58
80105c32:	6a 3a                	push   $0x3a
  jmp alltraps
80105c34:	e9 54 f9 ff ff       	jmp    8010558d <alltraps>

80105c39 <vector59>:
.globl vector59
vector59:
  pushl $0
80105c39:	6a 00                	push   $0x0
  pushl $59
80105c3b:	6a 3b                	push   $0x3b
  jmp alltraps
80105c3d:	e9 4b f9 ff ff       	jmp    8010558d <alltraps>

80105c42 <vector60>:
.globl vector60
vector60:
  pushl $0
80105c42:	6a 00                	push   $0x0
  pushl $60
80105c44:	6a 3c                	push   $0x3c
  jmp alltraps
80105c46:	e9 42 f9 ff ff       	jmp    8010558d <alltraps>

80105c4b <vector61>:
.globl vector61
vector61:
  pushl $0
80105c4b:	6a 00                	push   $0x0
  pushl $61
80105c4d:	6a 3d                	push   $0x3d
  jmp alltraps
80105c4f:	e9 39 f9 ff ff       	jmp    8010558d <alltraps>

80105c54 <vector62>:
.globl vector62
vector62:
  pushl $0
80105c54:	6a 00                	push   $0x0
  pushl $62
80105c56:	6a 3e                	push   $0x3e
  jmp alltraps
80105c58:	e9 30 f9 ff ff       	jmp    8010558d <alltraps>

80105c5d <vector63>:
.globl vector63
vector63:
  pushl $0
80105c5d:	6a 00                	push   $0x0
  pushl $63
80105c5f:	6a 3f                	push   $0x3f
  jmp alltraps
80105c61:	e9 27 f9 ff ff       	jmp    8010558d <alltraps>

80105c66 <vector64>:
.globl vector64
vector64:
  pushl $0
80105c66:	6a 00                	push   $0x0
  pushl $64
80105c68:	6a 40                	push   $0x40
  jmp alltraps
80105c6a:	e9 1e f9 ff ff       	jmp    8010558d <alltraps>

80105c6f <vector65>:
.globl vector65
vector65:
  pushl $0
80105c6f:	6a 00                	push   $0x0
  pushl $65
80105c71:	6a 41                	push   $0x41
  jmp alltraps
80105c73:	e9 15 f9 ff ff       	jmp    8010558d <alltraps>

80105c78 <vector66>:
.globl vector66
vector66:
  pushl $0
80105c78:	6a 00                	push   $0x0
  pushl $66
80105c7a:	6a 42                	push   $0x42
  jmp alltraps
80105c7c:	e9 0c f9 ff ff       	jmp    8010558d <alltraps>

80105c81 <vector67>:
.globl vector67
vector67:
  pushl $0
80105c81:	6a 00                	push   $0x0
  pushl $67
80105c83:	6a 43                	push   $0x43
  jmp alltraps
80105c85:	e9 03 f9 ff ff       	jmp    8010558d <alltraps>

80105c8a <vector68>:
.globl vector68
vector68:
  pushl $0
80105c8a:	6a 00                	push   $0x0
  pushl $68
80105c8c:	6a 44                	push   $0x44
  jmp alltraps
80105c8e:	e9 fa f8 ff ff       	jmp    8010558d <alltraps>

80105c93 <vector69>:
.globl vector69
vector69:
  pushl $0
80105c93:	6a 00                	push   $0x0
  pushl $69
80105c95:	6a 45                	push   $0x45
  jmp alltraps
80105c97:	e9 f1 f8 ff ff       	jmp    8010558d <alltraps>

80105c9c <vector70>:
.globl vector70
vector70:
  pushl $0
80105c9c:	6a 00                	push   $0x0
  pushl $70
80105c9e:	6a 46                	push   $0x46
  jmp alltraps
80105ca0:	e9 e8 f8 ff ff       	jmp    8010558d <alltraps>

80105ca5 <vector71>:
.globl vector71
vector71:
  pushl $0
80105ca5:	6a 00                	push   $0x0
  pushl $71
80105ca7:	6a 47                	push   $0x47
  jmp alltraps
80105ca9:	e9 df f8 ff ff       	jmp    8010558d <alltraps>

80105cae <vector72>:
.globl vector72
vector72:
  pushl $0
80105cae:	6a 00                	push   $0x0
  pushl $72
80105cb0:	6a 48                	push   $0x48
  jmp alltraps
80105cb2:	e9 d6 f8 ff ff       	jmp    8010558d <alltraps>

80105cb7 <vector73>:
.globl vector73
vector73:
  pushl $0
80105cb7:	6a 00                	push   $0x0
  pushl $73
80105cb9:	6a 49                	push   $0x49
  jmp alltraps
80105cbb:	e9 cd f8 ff ff       	jmp    8010558d <alltraps>

80105cc0 <vector74>:
.globl vector74
vector74:
  pushl $0
80105cc0:	6a 00                	push   $0x0
  pushl $74
80105cc2:	6a 4a                	push   $0x4a
  jmp alltraps
80105cc4:	e9 c4 f8 ff ff       	jmp    8010558d <alltraps>

80105cc9 <vector75>:
.globl vector75
vector75:
  pushl $0
80105cc9:	6a 00                	push   $0x0
  pushl $75
80105ccb:	6a 4b                	push   $0x4b
  jmp alltraps
80105ccd:	e9 bb f8 ff ff       	jmp    8010558d <alltraps>

80105cd2 <vector76>:
.globl vector76
vector76:
  pushl $0
80105cd2:	6a 00                	push   $0x0
  pushl $76
80105cd4:	6a 4c                	push   $0x4c
  jmp alltraps
80105cd6:	e9 b2 f8 ff ff       	jmp    8010558d <alltraps>

80105cdb <vector77>:
.globl vector77
vector77:
  pushl $0
80105cdb:	6a 00                	push   $0x0
  pushl $77
80105cdd:	6a 4d                	push   $0x4d
  jmp alltraps
80105cdf:	e9 a9 f8 ff ff       	jmp    8010558d <alltraps>

80105ce4 <vector78>:
.globl vector78
vector78:
  pushl $0
80105ce4:	6a 00                	push   $0x0
  pushl $78
80105ce6:	6a 4e                	push   $0x4e
  jmp alltraps
80105ce8:	e9 a0 f8 ff ff       	jmp    8010558d <alltraps>

80105ced <vector79>:
.globl vector79
vector79:
  pushl $0
80105ced:	6a 00                	push   $0x0
  pushl $79
80105cef:	6a 4f                	push   $0x4f
  jmp alltraps
80105cf1:	e9 97 f8 ff ff       	jmp    8010558d <alltraps>

80105cf6 <vector80>:
.globl vector80
vector80:
  pushl $0
80105cf6:	6a 00                	push   $0x0
  pushl $80
80105cf8:	6a 50                	push   $0x50
  jmp alltraps
80105cfa:	e9 8e f8 ff ff       	jmp    8010558d <alltraps>

80105cff <vector81>:
.globl vector81
vector81:
  pushl $0
80105cff:	6a 00                	push   $0x0
  pushl $81
80105d01:	6a 51                	push   $0x51
  jmp alltraps
80105d03:	e9 85 f8 ff ff       	jmp    8010558d <alltraps>

80105d08 <vector82>:
.globl vector82
vector82:
  pushl $0
80105d08:	6a 00                	push   $0x0
  pushl $82
80105d0a:	6a 52                	push   $0x52
  jmp alltraps
80105d0c:	e9 7c f8 ff ff       	jmp    8010558d <alltraps>

80105d11 <vector83>:
.globl vector83
vector83:
  pushl $0
80105d11:	6a 00                	push   $0x0
  pushl $83
80105d13:	6a 53                	push   $0x53
  jmp alltraps
80105d15:	e9 73 f8 ff ff       	jmp    8010558d <alltraps>

80105d1a <vector84>:
.globl vector84
vector84:
  pushl $0
80105d1a:	6a 00                	push   $0x0
  pushl $84
80105d1c:	6a 54                	push   $0x54
  jmp alltraps
80105d1e:	e9 6a f8 ff ff       	jmp    8010558d <alltraps>

80105d23 <vector85>:
.globl vector85
vector85:
  pushl $0
80105d23:	6a 00                	push   $0x0
  pushl $85
80105d25:	6a 55                	push   $0x55
  jmp alltraps
80105d27:	e9 61 f8 ff ff       	jmp    8010558d <alltraps>

80105d2c <vector86>:
.globl vector86
vector86:
  pushl $0
80105d2c:	6a 00                	push   $0x0
  pushl $86
80105d2e:	6a 56                	push   $0x56
  jmp alltraps
80105d30:	e9 58 f8 ff ff       	jmp    8010558d <alltraps>

80105d35 <vector87>:
.globl vector87
vector87:
  pushl $0
80105d35:	6a 00                	push   $0x0
  pushl $87
80105d37:	6a 57                	push   $0x57
  jmp alltraps
80105d39:	e9 4f f8 ff ff       	jmp    8010558d <alltraps>

80105d3e <vector88>:
.globl vector88
vector88:
  pushl $0
80105d3e:	6a 00                	push   $0x0
  pushl $88
80105d40:	6a 58                	push   $0x58
  jmp alltraps
80105d42:	e9 46 f8 ff ff       	jmp    8010558d <alltraps>

80105d47 <vector89>:
.globl vector89
vector89:
  pushl $0
80105d47:	6a 00                	push   $0x0
  pushl $89
80105d49:	6a 59                	push   $0x59
  jmp alltraps
80105d4b:	e9 3d f8 ff ff       	jmp    8010558d <alltraps>

80105d50 <vector90>:
.globl vector90
vector90:
  pushl $0
80105d50:	6a 00                	push   $0x0
  pushl $90
80105d52:	6a 5a                	push   $0x5a
  jmp alltraps
80105d54:	e9 34 f8 ff ff       	jmp    8010558d <alltraps>

80105d59 <vector91>:
.globl vector91
vector91:
  pushl $0
80105d59:	6a 00                	push   $0x0
  pushl $91
80105d5b:	6a 5b                	push   $0x5b
  jmp alltraps
80105d5d:	e9 2b f8 ff ff       	jmp    8010558d <alltraps>

80105d62 <vector92>:
.globl vector92
vector92:
  pushl $0
80105d62:	6a 00                	push   $0x0
  pushl $92
80105d64:	6a 5c                	push   $0x5c
  jmp alltraps
80105d66:	e9 22 f8 ff ff       	jmp    8010558d <alltraps>

80105d6b <vector93>:
.globl vector93
vector93:
  pushl $0
80105d6b:	6a 00                	push   $0x0
  pushl $93
80105d6d:	6a 5d                	push   $0x5d
  jmp alltraps
80105d6f:	e9 19 f8 ff ff       	jmp    8010558d <alltraps>

80105d74 <vector94>:
.globl vector94
vector94:
  pushl $0
80105d74:	6a 00                	push   $0x0
  pushl $94
80105d76:	6a 5e                	push   $0x5e
  jmp alltraps
80105d78:	e9 10 f8 ff ff       	jmp    8010558d <alltraps>

80105d7d <vector95>:
.globl vector95
vector95:
  pushl $0
80105d7d:	6a 00                	push   $0x0
  pushl $95
80105d7f:	6a 5f                	push   $0x5f
  jmp alltraps
80105d81:	e9 07 f8 ff ff       	jmp    8010558d <alltraps>

80105d86 <vector96>:
.globl vector96
vector96:
  pushl $0
80105d86:	6a 00                	push   $0x0
  pushl $96
80105d88:	6a 60                	push   $0x60
  jmp alltraps
80105d8a:	e9 fe f7 ff ff       	jmp    8010558d <alltraps>

80105d8f <vector97>:
.globl vector97
vector97:
  pushl $0
80105d8f:	6a 00                	push   $0x0
  pushl $97
80105d91:	6a 61                	push   $0x61
  jmp alltraps
80105d93:	e9 f5 f7 ff ff       	jmp    8010558d <alltraps>

80105d98 <vector98>:
.globl vector98
vector98:
  pushl $0
80105d98:	6a 00                	push   $0x0
  pushl $98
80105d9a:	6a 62                	push   $0x62
  jmp alltraps
80105d9c:	e9 ec f7 ff ff       	jmp    8010558d <alltraps>

80105da1 <vector99>:
.globl vector99
vector99:
  pushl $0
80105da1:	6a 00                	push   $0x0
  pushl $99
80105da3:	6a 63                	push   $0x63
  jmp alltraps
80105da5:	e9 e3 f7 ff ff       	jmp    8010558d <alltraps>

80105daa <vector100>:
.globl vector100
vector100:
  pushl $0
80105daa:	6a 00                	push   $0x0
  pushl $100
80105dac:	6a 64                	push   $0x64
  jmp alltraps
80105dae:	e9 da f7 ff ff       	jmp    8010558d <alltraps>

80105db3 <vector101>:
.globl vector101
vector101:
  pushl $0
80105db3:	6a 00                	push   $0x0
  pushl $101
80105db5:	6a 65                	push   $0x65
  jmp alltraps
80105db7:	e9 d1 f7 ff ff       	jmp    8010558d <alltraps>

80105dbc <vector102>:
.globl vector102
vector102:
  pushl $0
80105dbc:	6a 00                	push   $0x0
  pushl $102
80105dbe:	6a 66                	push   $0x66
  jmp alltraps
80105dc0:	e9 c8 f7 ff ff       	jmp    8010558d <alltraps>

80105dc5 <vector103>:
.globl vector103
vector103:
  pushl $0
80105dc5:	6a 00                	push   $0x0
  pushl $103
80105dc7:	6a 67                	push   $0x67
  jmp alltraps
80105dc9:	e9 bf f7 ff ff       	jmp    8010558d <alltraps>

80105dce <vector104>:
.globl vector104
vector104:
  pushl $0
80105dce:	6a 00                	push   $0x0
  pushl $104
80105dd0:	6a 68                	push   $0x68
  jmp alltraps
80105dd2:	e9 b6 f7 ff ff       	jmp    8010558d <alltraps>

80105dd7 <vector105>:
.globl vector105
vector105:
  pushl $0
80105dd7:	6a 00                	push   $0x0
  pushl $105
80105dd9:	6a 69                	push   $0x69
  jmp alltraps
80105ddb:	e9 ad f7 ff ff       	jmp    8010558d <alltraps>

80105de0 <vector106>:
.globl vector106
vector106:
  pushl $0
80105de0:	6a 00                	push   $0x0
  pushl $106
80105de2:	6a 6a                	push   $0x6a
  jmp alltraps
80105de4:	e9 a4 f7 ff ff       	jmp    8010558d <alltraps>

80105de9 <vector107>:
.globl vector107
vector107:
  pushl $0
80105de9:	6a 00                	push   $0x0
  pushl $107
80105deb:	6a 6b                	push   $0x6b
  jmp alltraps
80105ded:	e9 9b f7 ff ff       	jmp    8010558d <alltraps>

80105df2 <vector108>:
.globl vector108
vector108:
  pushl $0
80105df2:	6a 00                	push   $0x0
  pushl $108
80105df4:	6a 6c                	push   $0x6c
  jmp alltraps
80105df6:	e9 92 f7 ff ff       	jmp    8010558d <alltraps>

80105dfb <vector109>:
.globl vector109
vector109:
  pushl $0
80105dfb:	6a 00                	push   $0x0
  pushl $109
80105dfd:	6a 6d                	push   $0x6d
  jmp alltraps
80105dff:	e9 89 f7 ff ff       	jmp    8010558d <alltraps>

80105e04 <vector110>:
.globl vector110
vector110:
  pushl $0
80105e04:	6a 00                	push   $0x0
  pushl $110
80105e06:	6a 6e                	push   $0x6e
  jmp alltraps
80105e08:	e9 80 f7 ff ff       	jmp    8010558d <alltraps>

80105e0d <vector111>:
.globl vector111
vector111:
  pushl $0
80105e0d:	6a 00                	push   $0x0
  pushl $111
80105e0f:	6a 6f                	push   $0x6f
  jmp alltraps
80105e11:	e9 77 f7 ff ff       	jmp    8010558d <alltraps>

80105e16 <vector112>:
.globl vector112
vector112:
  pushl $0
80105e16:	6a 00                	push   $0x0
  pushl $112
80105e18:	6a 70                	push   $0x70
  jmp alltraps
80105e1a:	e9 6e f7 ff ff       	jmp    8010558d <alltraps>

80105e1f <vector113>:
.globl vector113
vector113:
  pushl $0
80105e1f:	6a 00                	push   $0x0
  pushl $113
80105e21:	6a 71                	push   $0x71
  jmp alltraps
80105e23:	e9 65 f7 ff ff       	jmp    8010558d <alltraps>

80105e28 <vector114>:
.globl vector114
vector114:
  pushl $0
80105e28:	6a 00                	push   $0x0
  pushl $114
80105e2a:	6a 72                	push   $0x72
  jmp alltraps
80105e2c:	e9 5c f7 ff ff       	jmp    8010558d <alltraps>

80105e31 <vector115>:
.globl vector115
vector115:
  pushl $0
80105e31:	6a 00                	push   $0x0
  pushl $115
80105e33:	6a 73                	push   $0x73
  jmp alltraps
80105e35:	e9 53 f7 ff ff       	jmp    8010558d <alltraps>

80105e3a <vector116>:
.globl vector116
vector116:
  pushl $0
80105e3a:	6a 00                	push   $0x0
  pushl $116
80105e3c:	6a 74                	push   $0x74
  jmp alltraps
80105e3e:	e9 4a f7 ff ff       	jmp    8010558d <alltraps>

80105e43 <vector117>:
.globl vector117
vector117:
  pushl $0
80105e43:	6a 00                	push   $0x0
  pushl $117
80105e45:	6a 75                	push   $0x75
  jmp alltraps
80105e47:	e9 41 f7 ff ff       	jmp    8010558d <alltraps>

80105e4c <vector118>:
.globl vector118
vector118:
  pushl $0
80105e4c:	6a 00                	push   $0x0
  pushl $118
80105e4e:	6a 76                	push   $0x76
  jmp alltraps
80105e50:	e9 38 f7 ff ff       	jmp    8010558d <alltraps>

80105e55 <vector119>:
.globl vector119
vector119:
  pushl $0
80105e55:	6a 00                	push   $0x0
  pushl $119
80105e57:	6a 77                	push   $0x77
  jmp alltraps
80105e59:	e9 2f f7 ff ff       	jmp    8010558d <alltraps>

80105e5e <vector120>:
.globl vector120
vector120:
  pushl $0
80105e5e:	6a 00                	push   $0x0
  pushl $120
80105e60:	6a 78                	push   $0x78
  jmp alltraps
80105e62:	e9 26 f7 ff ff       	jmp    8010558d <alltraps>

80105e67 <vector121>:
.globl vector121
vector121:
  pushl $0
80105e67:	6a 00                	push   $0x0
  pushl $121
80105e69:	6a 79                	push   $0x79
  jmp alltraps
80105e6b:	e9 1d f7 ff ff       	jmp    8010558d <alltraps>

80105e70 <vector122>:
.globl vector122
vector122:
  pushl $0
80105e70:	6a 00                	push   $0x0
  pushl $122
80105e72:	6a 7a                	push   $0x7a
  jmp alltraps
80105e74:	e9 14 f7 ff ff       	jmp    8010558d <alltraps>

80105e79 <vector123>:
.globl vector123
vector123:
  pushl $0
80105e79:	6a 00                	push   $0x0
  pushl $123
80105e7b:	6a 7b                	push   $0x7b
  jmp alltraps
80105e7d:	e9 0b f7 ff ff       	jmp    8010558d <alltraps>

80105e82 <vector124>:
.globl vector124
vector124:
  pushl $0
80105e82:	6a 00                	push   $0x0
  pushl $124
80105e84:	6a 7c                	push   $0x7c
  jmp alltraps
80105e86:	e9 02 f7 ff ff       	jmp    8010558d <alltraps>

80105e8b <vector125>:
.globl vector125
vector125:
  pushl $0
80105e8b:	6a 00                	push   $0x0
  pushl $125
80105e8d:	6a 7d                	push   $0x7d
  jmp alltraps
80105e8f:	e9 f9 f6 ff ff       	jmp    8010558d <alltraps>

80105e94 <vector126>:
.globl vector126
vector126:
  pushl $0
80105e94:	6a 00                	push   $0x0
  pushl $126
80105e96:	6a 7e                	push   $0x7e
  jmp alltraps
80105e98:	e9 f0 f6 ff ff       	jmp    8010558d <alltraps>

80105e9d <vector127>:
.globl vector127
vector127:
  pushl $0
80105e9d:	6a 00                	push   $0x0
  pushl $127
80105e9f:	6a 7f                	push   $0x7f
  jmp alltraps
80105ea1:	e9 e7 f6 ff ff       	jmp    8010558d <alltraps>

80105ea6 <vector128>:
.globl vector128
vector128:
  pushl $0
80105ea6:	6a 00                	push   $0x0
  pushl $128
80105ea8:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80105ead:	e9 db f6 ff ff       	jmp    8010558d <alltraps>

80105eb2 <vector129>:
.globl vector129
vector129:
  pushl $0
80105eb2:	6a 00                	push   $0x0
  pushl $129
80105eb4:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80105eb9:	e9 cf f6 ff ff       	jmp    8010558d <alltraps>

80105ebe <vector130>:
.globl vector130
vector130:
  pushl $0
80105ebe:	6a 00                	push   $0x0
  pushl $130
80105ec0:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80105ec5:	e9 c3 f6 ff ff       	jmp    8010558d <alltraps>

80105eca <vector131>:
.globl vector131
vector131:
  pushl $0
80105eca:	6a 00                	push   $0x0
  pushl $131
80105ecc:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80105ed1:	e9 b7 f6 ff ff       	jmp    8010558d <alltraps>

80105ed6 <vector132>:
.globl vector132
vector132:
  pushl $0
80105ed6:	6a 00                	push   $0x0
  pushl $132
80105ed8:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80105edd:	e9 ab f6 ff ff       	jmp    8010558d <alltraps>

80105ee2 <vector133>:
.globl vector133
vector133:
  pushl $0
80105ee2:	6a 00                	push   $0x0
  pushl $133
80105ee4:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80105ee9:	e9 9f f6 ff ff       	jmp    8010558d <alltraps>

80105eee <vector134>:
.globl vector134
vector134:
  pushl $0
80105eee:	6a 00                	push   $0x0
  pushl $134
80105ef0:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80105ef5:	e9 93 f6 ff ff       	jmp    8010558d <alltraps>

80105efa <vector135>:
.globl vector135
vector135:
  pushl $0
80105efa:	6a 00                	push   $0x0
  pushl $135
80105efc:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80105f01:	e9 87 f6 ff ff       	jmp    8010558d <alltraps>

80105f06 <vector136>:
.globl vector136
vector136:
  pushl $0
80105f06:	6a 00                	push   $0x0
  pushl $136
80105f08:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80105f0d:	e9 7b f6 ff ff       	jmp    8010558d <alltraps>

80105f12 <vector137>:
.globl vector137
vector137:
  pushl $0
80105f12:	6a 00                	push   $0x0
  pushl $137
80105f14:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80105f19:	e9 6f f6 ff ff       	jmp    8010558d <alltraps>

80105f1e <vector138>:
.globl vector138
vector138:
  pushl $0
80105f1e:	6a 00                	push   $0x0
  pushl $138
80105f20:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80105f25:	e9 63 f6 ff ff       	jmp    8010558d <alltraps>

80105f2a <vector139>:
.globl vector139
vector139:
  pushl $0
80105f2a:	6a 00                	push   $0x0
  pushl $139
80105f2c:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80105f31:	e9 57 f6 ff ff       	jmp    8010558d <alltraps>

80105f36 <vector140>:
.globl vector140
vector140:
  pushl $0
80105f36:	6a 00                	push   $0x0
  pushl $140
80105f38:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80105f3d:	e9 4b f6 ff ff       	jmp    8010558d <alltraps>

80105f42 <vector141>:
.globl vector141
vector141:
  pushl $0
80105f42:	6a 00                	push   $0x0
  pushl $141
80105f44:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80105f49:	e9 3f f6 ff ff       	jmp    8010558d <alltraps>

80105f4e <vector142>:
.globl vector142
vector142:
  pushl $0
80105f4e:	6a 00                	push   $0x0
  pushl $142
80105f50:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80105f55:	e9 33 f6 ff ff       	jmp    8010558d <alltraps>

80105f5a <vector143>:
.globl vector143
vector143:
  pushl $0
80105f5a:	6a 00                	push   $0x0
  pushl $143
80105f5c:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80105f61:	e9 27 f6 ff ff       	jmp    8010558d <alltraps>

80105f66 <vector144>:
.globl vector144
vector144:
  pushl $0
80105f66:	6a 00                	push   $0x0
  pushl $144
80105f68:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80105f6d:	e9 1b f6 ff ff       	jmp    8010558d <alltraps>

80105f72 <vector145>:
.globl vector145
vector145:
  pushl $0
80105f72:	6a 00                	push   $0x0
  pushl $145
80105f74:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80105f79:	e9 0f f6 ff ff       	jmp    8010558d <alltraps>

80105f7e <vector146>:
.globl vector146
vector146:
  pushl $0
80105f7e:	6a 00                	push   $0x0
  pushl $146
80105f80:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80105f85:	e9 03 f6 ff ff       	jmp    8010558d <alltraps>

80105f8a <vector147>:
.globl vector147
vector147:
  pushl $0
80105f8a:	6a 00                	push   $0x0
  pushl $147
80105f8c:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80105f91:	e9 f7 f5 ff ff       	jmp    8010558d <alltraps>

80105f96 <vector148>:
.globl vector148
vector148:
  pushl $0
80105f96:	6a 00                	push   $0x0
  pushl $148
80105f98:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80105f9d:	e9 eb f5 ff ff       	jmp    8010558d <alltraps>

80105fa2 <vector149>:
.globl vector149
vector149:
  pushl $0
80105fa2:	6a 00                	push   $0x0
  pushl $149
80105fa4:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80105fa9:	e9 df f5 ff ff       	jmp    8010558d <alltraps>

80105fae <vector150>:
.globl vector150
vector150:
  pushl $0
80105fae:	6a 00                	push   $0x0
  pushl $150
80105fb0:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80105fb5:	e9 d3 f5 ff ff       	jmp    8010558d <alltraps>

80105fba <vector151>:
.globl vector151
vector151:
  pushl $0
80105fba:	6a 00                	push   $0x0
  pushl $151
80105fbc:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80105fc1:	e9 c7 f5 ff ff       	jmp    8010558d <alltraps>

80105fc6 <vector152>:
.globl vector152
vector152:
  pushl $0
80105fc6:	6a 00                	push   $0x0
  pushl $152
80105fc8:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80105fcd:	e9 bb f5 ff ff       	jmp    8010558d <alltraps>

80105fd2 <vector153>:
.globl vector153
vector153:
  pushl $0
80105fd2:	6a 00                	push   $0x0
  pushl $153
80105fd4:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80105fd9:	e9 af f5 ff ff       	jmp    8010558d <alltraps>

80105fde <vector154>:
.globl vector154
vector154:
  pushl $0
80105fde:	6a 00                	push   $0x0
  pushl $154
80105fe0:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80105fe5:	e9 a3 f5 ff ff       	jmp    8010558d <alltraps>

80105fea <vector155>:
.globl vector155
vector155:
  pushl $0
80105fea:	6a 00                	push   $0x0
  pushl $155
80105fec:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80105ff1:	e9 97 f5 ff ff       	jmp    8010558d <alltraps>

80105ff6 <vector156>:
.globl vector156
vector156:
  pushl $0
80105ff6:	6a 00                	push   $0x0
  pushl $156
80105ff8:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80105ffd:	e9 8b f5 ff ff       	jmp    8010558d <alltraps>

80106002 <vector157>:
.globl vector157
vector157:
  pushl $0
80106002:	6a 00                	push   $0x0
  pushl $157
80106004:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80106009:	e9 7f f5 ff ff       	jmp    8010558d <alltraps>

8010600e <vector158>:
.globl vector158
vector158:
  pushl $0
8010600e:	6a 00                	push   $0x0
  pushl $158
80106010:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106015:	e9 73 f5 ff ff       	jmp    8010558d <alltraps>

8010601a <vector159>:
.globl vector159
vector159:
  pushl $0
8010601a:	6a 00                	push   $0x0
  pushl $159
8010601c:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106021:	e9 67 f5 ff ff       	jmp    8010558d <alltraps>

80106026 <vector160>:
.globl vector160
vector160:
  pushl $0
80106026:	6a 00                	push   $0x0
  pushl $160
80106028:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010602d:	e9 5b f5 ff ff       	jmp    8010558d <alltraps>

80106032 <vector161>:
.globl vector161
vector161:
  pushl $0
80106032:	6a 00                	push   $0x0
  pushl $161
80106034:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80106039:	e9 4f f5 ff ff       	jmp    8010558d <alltraps>

8010603e <vector162>:
.globl vector162
vector162:
  pushl $0
8010603e:	6a 00                	push   $0x0
  pushl $162
80106040:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106045:	e9 43 f5 ff ff       	jmp    8010558d <alltraps>

8010604a <vector163>:
.globl vector163
vector163:
  pushl $0
8010604a:	6a 00                	push   $0x0
  pushl $163
8010604c:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106051:	e9 37 f5 ff ff       	jmp    8010558d <alltraps>

80106056 <vector164>:
.globl vector164
vector164:
  pushl $0
80106056:	6a 00                	push   $0x0
  pushl $164
80106058:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010605d:	e9 2b f5 ff ff       	jmp    8010558d <alltraps>

80106062 <vector165>:
.globl vector165
vector165:
  pushl $0
80106062:	6a 00                	push   $0x0
  pushl $165
80106064:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80106069:	e9 1f f5 ff ff       	jmp    8010558d <alltraps>

8010606e <vector166>:
.globl vector166
vector166:
  pushl $0
8010606e:	6a 00                	push   $0x0
  pushl $166
80106070:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106075:	e9 13 f5 ff ff       	jmp    8010558d <alltraps>

8010607a <vector167>:
.globl vector167
vector167:
  pushl $0
8010607a:	6a 00                	push   $0x0
  pushl $167
8010607c:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106081:	e9 07 f5 ff ff       	jmp    8010558d <alltraps>

80106086 <vector168>:
.globl vector168
vector168:
  pushl $0
80106086:	6a 00                	push   $0x0
  pushl $168
80106088:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010608d:	e9 fb f4 ff ff       	jmp    8010558d <alltraps>

80106092 <vector169>:
.globl vector169
vector169:
  pushl $0
80106092:	6a 00                	push   $0x0
  pushl $169
80106094:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80106099:	e9 ef f4 ff ff       	jmp    8010558d <alltraps>

8010609e <vector170>:
.globl vector170
vector170:
  pushl $0
8010609e:	6a 00                	push   $0x0
  pushl $170
801060a0:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
801060a5:	e9 e3 f4 ff ff       	jmp    8010558d <alltraps>

801060aa <vector171>:
.globl vector171
vector171:
  pushl $0
801060aa:	6a 00                	push   $0x0
  pushl $171
801060ac:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
801060b1:	e9 d7 f4 ff ff       	jmp    8010558d <alltraps>

801060b6 <vector172>:
.globl vector172
vector172:
  pushl $0
801060b6:	6a 00                	push   $0x0
  pushl $172
801060b8:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
801060bd:	e9 cb f4 ff ff       	jmp    8010558d <alltraps>

801060c2 <vector173>:
.globl vector173
vector173:
  pushl $0
801060c2:	6a 00                	push   $0x0
  pushl $173
801060c4:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801060c9:	e9 bf f4 ff ff       	jmp    8010558d <alltraps>

801060ce <vector174>:
.globl vector174
vector174:
  pushl $0
801060ce:	6a 00                	push   $0x0
  pushl $174
801060d0:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801060d5:	e9 b3 f4 ff ff       	jmp    8010558d <alltraps>

801060da <vector175>:
.globl vector175
vector175:
  pushl $0
801060da:	6a 00                	push   $0x0
  pushl $175
801060dc:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801060e1:	e9 a7 f4 ff ff       	jmp    8010558d <alltraps>

801060e6 <vector176>:
.globl vector176
vector176:
  pushl $0
801060e6:	6a 00                	push   $0x0
  pushl $176
801060e8:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801060ed:	e9 9b f4 ff ff       	jmp    8010558d <alltraps>

801060f2 <vector177>:
.globl vector177
vector177:
  pushl $0
801060f2:	6a 00                	push   $0x0
  pushl $177
801060f4:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801060f9:	e9 8f f4 ff ff       	jmp    8010558d <alltraps>

801060fe <vector178>:
.globl vector178
vector178:
  pushl $0
801060fe:	6a 00                	push   $0x0
  pushl $178
80106100:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106105:	e9 83 f4 ff ff       	jmp    8010558d <alltraps>

8010610a <vector179>:
.globl vector179
vector179:
  pushl $0
8010610a:	6a 00                	push   $0x0
  pushl $179
8010610c:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106111:	e9 77 f4 ff ff       	jmp    8010558d <alltraps>

80106116 <vector180>:
.globl vector180
vector180:
  pushl $0
80106116:	6a 00                	push   $0x0
  pushl $180
80106118:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010611d:	e9 6b f4 ff ff       	jmp    8010558d <alltraps>

80106122 <vector181>:
.globl vector181
vector181:
  pushl $0
80106122:	6a 00                	push   $0x0
  pushl $181
80106124:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80106129:	e9 5f f4 ff ff       	jmp    8010558d <alltraps>

8010612e <vector182>:
.globl vector182
vector182:
  pushl $0
8010612e:	6a 00                	push   $0x0
  pushl $182
80106130:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106135:	e9 53 f4 ff ff       	jmp    8010558d <alltraps>

8010613a <vector183>:
.globl vector183
vector183:
  pushl $0
8010613a:	6a 00                	push   $0x0
  pushl $183
8010613c:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106141:	e9 47 f4 ff ff       	jmp    8010558d <alltraps>

80106146 <vector184>:
.globl vector184
vector184:
  pushl $0
80106146:	6a 00                	push   $0x0
  pushl $184
80106148:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010614d:	e9 3b f4 ff ff       	jmp    8010558d <alltraps>

80106152 <vector185>:
.globl vector185
vector185:
  pushl $0
80106152:	6a 00                	push   $0x0
  pushl $185
80106154:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80106159:	e9 2f f4 ff ff       	jmp    8010558d <alltraps>

8010615e <vector186>:
.globl vector186
vector186:
  pushl $0
8010615e:	6a 00                	push   $0x0
  pushl $186
80106160:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106165:	e9 23 f4 ff ff       	jmp    8010558d <alltraps>

8010616a <vector187>:
.globl vector187
vector187:
  pushl $0
8010616a:	6a 00                	push   $0x0
  pushl $187
8010616c:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106171:	e9 17 f4 ff ff       	jmp    8010558d <alltraps>

80106176 <vector188>:
.globl vector188
vector188:
  pushl $0
80106176:	6a 00                	push   $0x0
  pushl $188
80106178:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010617d:	e9 0b f4 ff ff       	jmp    8010558d <alltraps>

80106182 <vector189>:
.globl vector189
vector189:
  pushl $0
80106182:	6a 00                	push   $0x0
  pushl $189
80106184:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80106189:	e9 ff f3 ff ff       	jmp    8010558d <alltraps>

8010618e <vector190>:
.globl vector190
vector190:
  pushl $0
8010618e:	6a 00                	push   $0x0
  pushl $190
80106190:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106195:	e9 f3 f3 ff ff       	jmp    8010558d <alltraps>

8010619a <vector191>:
.globl vector191
vector191:
  pushl $0
8010619a:	6a 00                	push   $0x0
  pushl $191
8010619c:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
801061a1:	e9 e7 f3 ff ff       	jmp    8010558d <alltraps>

801061a6 <vector192>:
.globl vector192
vector192:
  pushl $0
801061a6:	6a 00                	push   $0x0
  pushl $192
801061a8:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
801061ad:	e9 db f3 ff ff       	jmp    8010558d <alltraps>

801061b2 <vector193>:
.globl vector193
vector193:
  pushl $0
801061b2:	6a 00                	push   $0x0
  pushl $193
801061b4:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
801061b9:	e9 cf f3 ff ff       	jmp    8010558d <alltraps>

801061be <vector194>:
.globl vector194
vector194:
  pushl $0
801061be:	6a 00                	push   $0x0
  pushl $194
801061c0:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801061c5:	e9 c3 f3 ff ff       	jmp    8010558d <alltraps>

801061ca <vector195>:
.globl vector195
vector195:
  pushl $0
801061ca:	6a 00                	push   $0x0
  pushl $195
801061cc:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801061d1:	e9 b7 f3 ff ff       	jmp    8010558d <alltraps>

801061d6 <vector196>:
.globl vector196
vector196:
  pushl $0
801061d6:	6a 00                	push   $0x0
  pushl $196
801061d8:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801061dd:	e9 ab f3 ff ff       	jmp    8010558d <alltraps>

801061e2 <vector197>:
.globl vector197
vector197:
  pushl $0
801061e2:	6a 00                	push   $0x0
  pushl $197
801061e4:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801061e9:	e9 9f f3 ff ff       	jmp    8010558d <alltraps>

801061ee <vector198>:
.globl vector198
vector198:
  pushl $0
801061ee:	6a 00                	push   $0x0
  pushl $198
801061f0:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801061f5:	e9 93 f3 ff ff       	jmp    8010558d <alltraps>

801061fa <vector199>:
.globl vector199
vector199:
  pushl $0
801061fa:	6a 00                	push   $0x0
  pushl $199
801061fc:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106201:	e9 87 f3 ff ff       	jmp    8010558d <alltraps>

80106206 <vector200>:
.globl vector200
vector200:
  pushl $0
80106206:	6a 00                	push   $0x0
  pushl $200
80106208:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010620d:	e9 7b f3 ff ff       	jmp    8010558d <alltraps>

80106212 <vector201>:
.globl vector201
vector201:
  pushl $0
80106212:	6a 00                	push   $0x0
  pushl $201
80106214:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80106219:	e9 6f f3 ff ff       	jmp    8010558d <alltraps>

8010621e <vector202>:
.globl vector202
vector202:
  pushl $0
8010621e:	6a 00                	push   $0x0
  pushl $202
80106220:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106225:	e9 63 f3 ff ff       	jmp    8010558d <alltraps>

8010622a <vector203>:
.globl vector203
vector203:
  pushl $0
8010622a:	6a 00                	push   $0x0
  pushl $203
8010622c:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106231:	e9 57 f3 ff ff       	jmp    8010558d <alltraps>

80106236 <vector204>:
.globl vector204
vector204:
  pushl $0
80106236:	6a 00                	push   $0x0
  pushl $204
80106238:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010623d:	e9 4b f3 ff ff       	jmp    8010558d <alltraps>

80106242 <vector205>:
.globl vector205
vector205:
  pushl $0
80106242:	6a 00                	push   $0x0
  pushl $205
80106244:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80106249:	e9 3f f3 ff ff       	jmp    8010558d <alltraps>

8010624e <vector206>:
.globl vector206
vector206:
  pushl $0
8010624e:	6a 00                	push   $0x0
  pushl $206
80106250:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106255:	e9 33 f3 ff ff       	jmp    8010558d <alltraps>

8010625a <vector207>:
.globl vector207
vector207:
  pushl $0
8010625a:	6a 00                	push   $0x0
  pushl $207
8010625c:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106261:	e9 27 f3 ff ff       	jmp    8010558d <alltraps>

80106266 <vector208>:
.globl vector208
vector208:
  pushl $0
80106266:	6a 00                	push   $0x0
  pushl $208
80106268:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010626d:	e9 1b f3 ff ff       	jmp    8010558d <alltraps>

80106272 <vector209>:
.globl vector209
vector209:
  pushl $0
80106272:	6a 00                	push   $0x0
  pushl $209
80106274:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106279:	e9 0f f3 ff ff       	jmp    8010558d <alltraps>

8010627e <vector210>:
.globl vector210
vector210:
  pushl $0
8010627e:	6a 00                	push   $0x0
  pushl $210
80106280:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106285:	e9 03 f3 ff ff       	jmp    8010558d <alltraps>

8010628a <vector211>:
.globl vector211
vector211:
  pushl $0
8010628a:	6a 00                	push   $0x0
  pushl $211
8010628c:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106291:	e9 f7 f2 ff ff       	jmp    8010558d <alltraps>

80106296 <vector212>:
.globl vector212
vector212:
  pushl $0
80106296:	6a 00                	push   $0x0
  pushl $212
80106298:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010629d:	e9 eb f2 ff ff       	jmp    8010558d <alltraps>

801062a2 <vector213>:
.globl vector213
vector213:
  pushl $0
801062a2:	6a 00                	push   $0x0
  pushl $213
801062a4:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
801062a9:	e9 df f2 ff ff       	jmp    8010558d <alltraps>

801062ae <vector214>:
.globl vector214
vector214:
  pushl $0
801062ae:	6a 00                	push   $0x0
  pushl $214
801062b0:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
801062b5:	e9 d3 f2 ff ff       	jmp    8010558d <alltraps>

801062ba <vector215>:
.globl vector215
vector215:
  pushl $0
801062ba:	6a 00                	push   $0x0
  pushl $215
801062bc:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
801062c1:	e9 c7 f2 ff ff       	jmp    8010558d <alltraps>

801062c6 <vector216>:
.globl vector216
vector216:
  pushl $0
801062c6:	6a 00                	push   $0x0
  pushl $216
801062c8:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
801062cd:	e9 bb f2 ff ff       	jmp    8010558d <alltraps>

801062d2 <vector217>:
.globl vector217
vector217:
  pushl $0
801062d2:	6a 00                	push   $0x0
  pushl $217
801062d4:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801062d9:	e9 af f2 ff ff       	jmp    8010558d <alltraps>

801062de <vector218>:
.globl vector218
vector218:
  pushl $0
801062de:	6a 00                	push   $0x0
  pushl $218
801062e0:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801062e5:	e9 a3 f2 ff ff       	jmp    8010558d <alltraps>

801062ea <vector219>:
.globl vector219
vector219:
  pushl $0
801062ea:	6a 00                	push   $0x0
  pushl $219
801062ec:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801062f1:	e9 97 f2 ff ff       	jmp    8010558d <alltraps>

801062f6 <vector220>:
.globl vector220
vector220:
  pushl $0
801062f6:	6a 00                	push   $0x0
  pushl $220
801062f8:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801062fd:	e9 8b f2 ff ff       	jmp    8010558d <alltraps>

80106302 <vector221>:
.globl vector221
vector221:
  pushl $0
80106302:	6a 00                	push   $0x0
  pushl $221
80106304:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106309:	e9 7f f2 ff ff       	jmp    8010558d <alltraps>

8010630e <vector222>:
.globl vector222
vector222:
  pushl $0
8010630e:	6a 00                	push   $0x0
  pushl $222
80106310:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106315:	e9 73 f2 ff ff       	jmp    8010558d <alltraps>

8010631a <vector223>:
.globl vector223
vector223:
  pushl $0
8010631a:	6a 00                	push   $0x0
  pushl $223
8010631c:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106321:	e9 67 f2 ff ff       	jmp    8010558d <alltraps>

80106326 <vector224>:
.globl vector224
vector224:
  pushl $0
80106326:	6a 00                	push   $0x0
  pushl $224
80106328:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010632d:	e9 5b f2 ff ff       	jmp    8010558d <alltraps>

80106332 <vector225>:
.globl vector225
vector225:
  pushl $0
80106332:	6a 00                	push   $0x0
  pushl $225
80106334:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106339:	e9 4f f2 ff ff       	jmp    8010558d <alltraps>

8010633e <vector226>:
.globl vector226
vector226:
  pushl $0
8010633e:	6a 00                	push   $0x0
  pushl $226
80106340:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106345:	e9 43 f2 ff ff       	jmp    8010558d <alltraps>

8010634a <vector227>:
.globl vector227
vector227:
  pushl $0
8010634a:	6a 00                	push   $0x0
  pushl $227
8010634c:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106351:	e9 37 f2 ff ff       	jmp    8010558d <alltraps>

80106356 <vector228>:
.globl vector228
vector228:
  pushl $0
80106356:	6a 00                	push   $0x0
  pushl $228
80106358:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010635d:	e9 2b f2 ff ff       	jmp    8010558d <alltraps>

80106362 <vector229>:
.globl vector229
vector229:
  pushl $0
80106362:	6a 00                	push   $0x0
  pushl $229
80106364:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106369:	e9 1f f2 ff ff       	jmp    8010558d <alltraps>

8010636e <vector230>:
.globl vector230
vector230:
  pushl $0
8010636e:	6a 00                	push   $0x0
  pushl $230
80106370:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106375:	e9 13 f2 ff ff       	jmp    8010558d <alltraps>

8010637a <vector231>:
.globl vector231
vector231:
  pushl $0
8010637a:	6a 00                	push   $0x0
  pushl $231
8010637c:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106381:	e9 07 f2 ff ff       	jmp    8010558d <alltraps>

80106386 <vector232>:
.globl vector232
vector232:
  pushl $0
80106386:	6a 00                	push   $0x0
  pushl $232
80106388:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010638d:	e9 fb f1 ff ff       	jmp    8010558d <alltraps>

80106392 <vector233>:
.globl vector233
vector233:
  pushl $0
80106392:	6a 00                	push   $0x0
  pushl $233
80106394:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106399:	e9 ef f1 ff ff       	jmp    8010558d <alltraps>

8010639e <vector234>:
.globl vector234
vector234:
  pushl $0
8010639e:	6a 00                	push   $0x0
  pushl $234
801063a0:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
801063a5:	e9 e3 f1 ff ff       	jmp    8010558d <alltraps>

801063aa <vector235>:
.globl vector235
vector235:
  pushl $0
801063aa:	6a 00                	push   $0x0
  pushl $235
801063ac:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
801063b1:	e9 d7 f1 ff ff       	jmp    8010558d <alltraps>

801063b6 <vector236>:
.globl vector236
vector236:
  pushl $0
801063b6:	6a 00                	push   $0x0
  pushl $236
801063b8:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
801063bd:	e9 cb f1 ff ff       	jmp    8010558d <alltraps>

801063c2 <vector237>:
.globl vector237
vector237:
  pushl $0
801063c2:	6a 00                	push   $0x0
  pushl $237
801063c4:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
801063c9:	e9 bf f1 ff ff       	jmp    8010558d <alltraps>

801063ce <vector238>:
.globl vector238
vector238:
  pushl $0
801063ce:	6a 00                	push   $0x0
  pushl $238
801063d0:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
801063d5:	e9 b3 f1 ff ff       	jmp    8010558d <alltraps>

801063da <vector239>:
.globl vector239
vector239:
  pushl $0
801063da:	6a 00                	push   $0x0
  pushl $239
801063dc:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801063e1:	e9 a7 f1 ff ff       	jmp    8010558d <alltraps>

801063e6 <vector240>:
.globl vector240
vector240:
  pushl $0
801063e6:	6a 00                	push   $0x0
  pushl $240
801063e8:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
801063ed:	e9 9b f1 ff ff       	jmp    8010558d <alltraps>

801063f2 <vector241>:
.globl vector241
vector241:
  pushl $0
801063f2:	6a 00                	push   $0x0
  pushl $241
801063f4:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
801063f9:	e9 8f f1 ff ff       	jmp    8010558d <alltraps>

801063fe <vector242>:
.globl vector242
vector242:
  pushl $0
801063fe:	6a 00                	push   $0x0
  pushl $242
80106400:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106405:	e9 83 f1 ff ff       	jmp    8010558d <alltraps>

8010640a <vector243>:
.globl vector243
vector243:
  pushl $0
8010640a:	6a 00                	push   $0x0
  pushl $243
8010640c:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106411:	e9 77 f1 ff ff       	jmp    8010558d <alltraps>

80106416 <vector244>:
.globl vector244
vector244:
  pushl $0
80106416:	6a 00                	push   $0x0
  pushl $244
80106418:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
8010641d:	e9 6b f1 ff ff       	jmp    8010558d <alltraps>

80106422 <vector245>:
.globl vector245
vector245:
  pushl $0
80106422:	6a 00                	push   $0x0
  pushl $245
80106424:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106429:	e9 5f f1 ff ff       	jmp    8010558d <alltraps>

8010642e <vector246>:
.globl vector246
vector246:
  pushl $0
8010642e:	6a 00                	push   $0x0
  pushl $246
80106430:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106435:	e9 53 f1 ff ff       	jmp    8010558d <alltraps>

8010643a <vector247>:
.globl vector247
vector247:
  pushl $0
8010643a:	6a 00                	push   $0x0
  pushl $247
8010643c:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106441:	e9 47 f1 ff ff       	jmp    8010558d <alltraps>

80106446 <vector248>:
.globl vector248
vector248:
  pushl $0
80106446:	6a 00                	push   $0x0
  pushl $248
80106448:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010644d:	e9 3b f1 ff ff       	jmp    8010558d <alltraps>

80106452 <vector249>:
.globl vector249
vector249:
  pushl $0
80106452:	6a 00                	push   $0x0
  pushl $249
80106454:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106459:	e9 2f f1 ff ff       	jmp    8010558d <alltraps>

8010645e <vector250>:
.globl vector250
vector250:
  pushl $0
8010645e:	6a 00                	push   $0x0
  pushl $250
80106460:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106465:	e9 23 f1 ff ff       	jmp    8010558d <alltraps>

8010646a <vector251>:
.globl vector251
vector251:
  pushl $0
8010646a:	6a 00                	push   $0x0
  pushl $251
8010646c:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106471:	e9 17 f1 ff ff       	jmp    8010558d <alltraps>

80106476 <vector252>:
.globl vector252
vector252:
  pushl $0
80106476:	6a 00                	push   $0x0
  pushl $252
80106478:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010647d:	e9 0b f1 ff ff       	jmp    8010558d <alltraps>

80106482 <vector253>:
.globl vector253
vector253:
  pushl $0
80106482:	6a 00                	push   $0x0
  pushl $253
80106484:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106489:	e9 ff f0 ff ff       	jmp    8010558d <alltraps>

8010648e <vector254>:
.globl vector254
vector254:
  pushl $0
8010648e:	6a 00                	push   $0x0
  pushl $254
80106490:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106495:	e9 f3 f0 ff ff       	jmp    8010558d <alltraps>

8010649a <vector255>:
.globl vector255
vector255:
  pushl $0
8010649a:	6a 00                	push   $0x0
  pushl $255
8010649c:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
801064a1:	e9 e7 f0 ff ff       	jmp    8010558d <alltraps>
801064a6:	66 90                	xchg   %ax,%ax
801064a8:	66 90                	xchg   %ax,%ax
801064aa:	66 90                	xchg   %ax,%ax
801064ac:	66 90                	xchg   %ax,%ax
801064ae:	66 90                	xchg   %ax,%ax

801064b0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
801064b0:	55                   	push   %ebp
801064b1:	89 e5                	mov    %esp,%ebp
801064b3:	83 ec 28             	sub    $0x28,%esp
801064b6:	89 75 f8             	mov    %esi,-0x8(%ebp)
801064b9:	89 d6                	mov    %edx,%esi
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
801064bb:	c1 ea 16             	shr    $0x16,%edx
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
801064be:	89 7d fc             	mov    %edi,-0x4(%ebp)
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
801064c1:	8d 3c 90             	lea    (%eax,%edx,4),%edi
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
801064c4:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
801064c7:	8b 1f                	mov    (%edi),%ebx
801064c9:	f6 c3 01             	test   $0x1,%bl
801064cc:	74 2a                	je     801064f8 <walkpgdir+0x48>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801064ce:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801064d4:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801064da:	89 f2                	mov    %esi,%edx
}
801064dc:	8b 7d fc             	mov    -0x4(%ebp),%edi
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801064df:	c1 ea 0a             	shr    $0xa,%edx
}
801064e2:	8b 75 f8             	mov    -0x8(%ebp),%esi
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801064e5:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801064eb:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
801064ee:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801064f1:	89 ec                	mov    %ebp,%esp
801064f3:	5d                   	pop    %ebp
801064f4:	c3                   	ret    
801064f5:	8d 76 00             	lea    0x0(%esi),%esi

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801064f8:	85 c9                	test   %ecx,%ecx
801064fa:	74 34                	je     80106530 <walkpgdir+0x80>
801064fc:	e8 9f bf ff ff       	call   801024a0 <kalloc>
80106501:	85 c0                	test   %eax,%eax
80106503:	89 c3                	mov    %eax,%ebx
80106505:	74 29                	je     80106530 <walkpgdir+0x80>
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
80106507:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
8010650e:	00 
8010650f:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106516:	00 
80106517:	89 04 24             	mov    %eax,(%esp)
8010651a:	e8 d1 dd ff ff       	call   801042f0 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010651f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106525:	83 c8 07             	or     $0x7,%eax
80106528:	89 07                	mov    %eax,(%edi)
8010652a:	eb ae                	jmp    801064da <walkpgdir+0x2a>
8010652c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  return &pgtab[PTX(va)];
}
80106530:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;
80106533:	31 c0                	xor    %eax,%eax
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80106535:	8b 75 f8             	mov    -0x8(%ebp),%esi
80106538:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010653b:	89 ec                	mov    %ebp,%esp
8010653d:	5d                   	pop    %ebp
8010653e:	c3                   	ret    
8010653f:	90                   	nop

80106540 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106540:	55                   	push   %ebp
80106541:	89 e5                	mov    %esp,%ebp
80106543:	57                   	push   %edi
80106544:	56                   	push   %esi
80106545:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106546:	89 d3                	mov    %edx,%ebx
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106548:	83 ec 2c             	sub    $0x2c,%esp
8010654b:	8b 7d 08             	mov    0x8(%ebp),%edi
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
8010654e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106554:	8d 4c 0a ff          	lea    -0x1(%edx,%ecx,1),%ecx
80106558:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
8010655b:	89 45 e0             	mov    %eax,-0x20(%ebp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
8010655e:	81 65 e4 00 f0 ff ff 	andl   $0xfffff000,-0x1c(%ebp)

// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
80106565:	29 df                	sub    %ebx,%edi
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106567:	83 4d 0c 01          	orl    $0x1,0xc(%ebp)
8010656b:	eb 18                	jmp    80106585 <mappages+0x45>
8010656d:	8d 76 00             	lea    0x0(%esi),%esi
  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80106570:	f6 00 01             	testb  $0x1,(%eax)
80106573:	75 3d                	jne    801065b2 <mappages+0x72>
      panic("remap");
    *pte = pa | perm | PTE_P;
80106575:	0b 75 0c             	or     0xc(%ebp),%esi
    if(a == last)
80106578:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
8010657b:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010657d:	74 29                	je     801065a8 <mappages+0x68>
      break;
    a += PGSIZE;
8010657f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106585:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106588:	b9 01 00 00 00       	mov    $0x1,%ecx
8010658d:	89 da                	mov    %ebx,%edx

// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
8010658f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106592:	e8 19 ff ff ff       	call   801064b0 <walkpgdir>
80106597:	85 c0                	test   %eax,%eax
80106599:	75 d5                	jne    80106570 <mappages+0x30>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
8010659b:	83 c4 2c             	add    $0x2c,%esp

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
8010659e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
801065a3:	5b                   	pop    %ebx
801065a4:	5e                   	pop    %esi
801065a5:	5f                   	pop    %edi
801065a6:	5d                   	pop    %ebp
801065a7:	c3                   	ret    
801065a8:	83 c4 2c             	add    $0x2c,%esp
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
801065ab:	31 c0                	xor    %eax,%eax
}
801065ad:	5b                   	pop    %ebx
801065ae:	5e                   	pop    %esi
801065af:	5f                   	pop    %edi
801065b0:	5d                   	pop    %ebp
801065b1:	c3                   	ret    
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
801065b2:	c7 04 24 6c 76 10 80 	movl   $0x8010766c,(%esp)
801065b9:	e8 72 9d ff ff       	call   80100330 <panic>
801065be:	66 90                	xchg   %ax,%ax

801065c0 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
801065c0:	55                   	push   %ebp
801065c1:	89 e5                	mov    %esp,%ebp
801065c3:	83 ec 18             	sub    $0x18,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
801065c6:	e8 95 c1 ff ff       	call   80102760 <cpunum>
801065cb:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
801065d1:	05 c0 12 11 80       	add    $0x801112c0,%eax
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
801065d6:	8d 90 b4 00 00 00    	lea    0xb4(%eax),%edx
801065dc:	66 89 90 8a 00 00 00 	mov    %dx,0x8a(%eax)
801065e3:	89 d1                	mov    %edx,%ecx
801065e5:	c1 ea 18             	shr    $0x18,%edx
801065e8:	88 90 8f 00 00 00    	mov    %dl,0x8f(%eax)

  lgdt(c->gdt, sizeof(c->gdt));
801065ee:	8d 50 70             	lea    0x70(%eax),%edx
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801065f1:	c6 40 7d 9a          	movb   $0x9a,0x7d(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
801065f5:	c1 e9 10             	shr    $0x10,%ecx
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801065f8:	c6 40 7e cf          	movb   $0xcf,0x7e(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801065fc:	c6 80 85 00 00 00 92 	movb   $0x92,0x85(%eax)
80106603:	c6 80 86 00 00 00 cf 	movb   $0xcf,0x86(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010660a:	c6 80 95 00 00 00 fa 	movb   $0xfa,0x95(%eax)
80106611:	c6 80 96 00 00 00 cf 	movb   $0xcf,0x96(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106618:	c6 80 9d 00 00 00 f2 	movb   $0xf2,0x9d(%eax)
8010661f:	c6 80 9e 00 00 00 cf 	movb   $0xcf,0x9e(%eax)

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106626:	c6 80 8d 00 00 00 92 	movb   $0x92,0x8d(%eax)
8010662d:	c6 80 8e 00 00 00 c0 	movb   $0xc0,0x8e(%eax)
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80106634:	66 c7 45 f2 37 00    	movw   $0x37,-0xe(%ebp)
  pd[1] = (uint)p;
8010663a:	66 89 55 f4          	mov    %dx,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
8010663e:	c1 ea 10             	shr    $0x10,%edx
80106641:	66 89 55 f6          	mov    %dx,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80106645:	8d 55 f2             	lea    -0xe(%ebp),%edx
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106648:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
8010664e:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
80106654:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
80106658:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010665c:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
80106663:	ff ff 
80106665:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
8010666c:	00 00 
8010666e:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
80106675:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010667c:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
80106683:	ff ff 
80106685:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
8010668c:	00 00 
8010668e:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
80106695:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
8010669c:	66 c7 80 98 00 00 00 	movw   $0xffff,0x98(%eax)
801066a3:	ff ff 
801066a5:	66 c7 80 9a 00 00 00 	movw   $0x0,0x9a(%eax)
801066ac:	00 00 
801066ae:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
801066b5:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
801066bc:	66 c7 80 88 00 00 00 	movw   $0x0,0x88(%eax)
801066c3:	00 00 
801066c5:	88 88 8c 00 00 00    	mov    %cl,0x8c(%eax)
801066cb:	0f 01 12             	lgdtl  (%edx)
}

static inline void
loadgs(ushort v)
{
  asm volatile("movw %0, %%gs" : : "r" (v));
801066ce:	ba 18 00 00 00       	mov    $0x18,%edx
801066d3:	8e ea                	mov    %edx,%gs
  lgdt(c->gdt, sizeof(c->gdt));
  loadgs(SEG_KCPU << 3);

  // Initialize cpu-local storage.
  cpu = c;
  proc = 0;
801066d5:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
801066dc:	00 00 00 00 

  lgdt(c->gdt, sizeof(c->gdt));
  loadgs(SEG_KCPU << 3);

  // Initialize cpu-local storage.
  cpu = c;
801066e0:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
  proc = 0;
}
801066e6:	c9                   	leave  
801066e7:	c3                   	ret    
801066e8:	90                   	nop
801066e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801066f0 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
801066f0:	55                   	push   %ebp
801066f1:	89 e5                	mov    %esp,%ebp
801066f3:	56                   	push   %esi
801066f4:	53                   	push   %ebx
801066f5:	83 ec 10             	sub    $0x10,%esp
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
801066f8:	e8 a3 bd ff ff       	call   801024a0 <kalloc>
801066fd:	85 c0                	test   %eax,%eax
801066ff:	89 c6                	mov    %eax,%esi
80106701:	74 55                	je     80106758 <setupkvm+0x68>
    return 0;
  memset(pgdir, 0, PGSIZE);
80106703:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
8010670a:	00 
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
8010670b:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
80106710:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106717:	00 
80106718:	89 04 24             	mov    %eax,(%esp)
8010671b:	e8 d0 db ff ff       	call   801042f0 <memset>
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106720:	8b 53 0c             	mov    0xc(%ebx),%edx
80106723:	8b 43 04             	mov    0x4(%ebx),%eax
80106726:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106729:	89 54 24 04          	mov    %edx,0x4(%esp)
8010672d:	8b 13                	mov    (%ebx),%edx
8010672f:	89 04 24             	mov    %eax,(%esp)
80106732:	29 c1                	sub    %eax,%ecx
80106734:	89 f0                	mov    %esi,%eax
80106736:	e8 05 fe ff ff       	call   80106540 <mappages>
8010673b:	85 c0                	test   %eax,%eax
8010673d:	78 19                	js     80106758 <setupkvm+0x68>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
8010673f:	83 c3 10             	add    $0x10,%ebx
80106742:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106748:	72 d6                	jb     80106720 <setupkvm+0x30>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
}
8010674a:	83 c4 10             	add    $0x10,%esp
8010674d:	89 f0                	mov    %esi,%eax
8010674f:	5b                   	pop    %ebx
80106750:	5e                   	pop    %esi
80106751:	5d                   	pop    %ebp
80106752:	c3                   	ret    
80106753:	90                   	nop
80106754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106758:	83 c4 10             	add    $0x10,%esp
{
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
8010675b:	31 f6                	xor    %esi,%esi
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
}
8010675d:	89 f0                	mov    %esi,%eax
8010675f:	5b                   	pop    %ebx
80106760:	5e                   	pop    %esi
80106761:	5d                   	pop    %ebp
80106762:	c3                   	ret    
80106763:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106770 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80106770:	55                   	push   %ebp
80106771:	89 e5                	mov    %esp,%ebp
80106773:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106776:	e8 75 ff ff ff       	call   801066f0 <setupkvm>
8010677b:	a3 44 40 11 80       	mov    %eax,0x80114044
// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106780:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106785:	0f 22 d8             	mov    %eax,%cr3
void
kvmalloc(void)
{
  kpgdir = setupkvm();
  switchkvm();
}
80106788:	c9                   	leave  
80106789:	c3                   	ret    
8010678a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106790 <switchkvm>:
// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106790:	a1 44 40 11 80       	mov    0x80114044,%eax

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80106795:	55                   	push   %ebp
80106796:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106798:	05 00 00 00 80       	add    $0x80000000,%eax
8010679d:	0f 22 d8             	mov    %eax,%cr3
}
801067a0:	5d                   	pop    %ebp
801067a1:	c3                   	ret    
801067a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801067a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801067b0 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
801067b0:	55                   	push   %ebp
801067b1:	89 e5                	mov    %esp,%ebp
801067b3:	53                   	push   %ebx
801067b4:	83 ec 14             	sub    $0x14,%esp
801067b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
801067ba:	e8 61 da ff ff       	call   80104220 <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
801067bf:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801067c5:	8d 50 08             	lea    0x8(%eax),%edx
801067c8:	66 89 90 a2 00 00 00 	mov    %dx,0xa2(%eax)
801067cf:	89 d1                	mov    %edx,%ecx
801067d1:	c1 ea 18             	shr    $0x18,%edx
801067d4:	c6 80 a6 00 00 00 40 	movb   $0x40,0xa6(%eax)
801067db:	c1 e9 10             	shr    $0x10,%ecx
801067de:	88 90 a7 00 00 00    	mov    %dl,0xa7(%eax)
  cpu->gdt[SEG_TSS].s = 0;
801067e4:	c6 80 a5 00 00 00 89 	movb   $0x89,0xa5(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
801067eb:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  pushcli();
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
801067f2:	66 c7 80 a0 00 00 00 	movw   $0x67,0xa0(%eax)
801067f9:	67 00 
801067fb:	88 88 a4 00 00 00    	mov    %cl,0xa4(%eax)
  cpu->gdt[SEG_TSS].s = 0;
  cpu->ts.ss0 = SEG_KDATA << 3;
80106801:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80106807:	8b 52 08             	mov    0x8(%edx),%edx
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  cpu->ts.iomb = (ushort) 0xFFFF;
8010680a:	66 c7 40 6e ff ff    	movw   $0xffff,0x6e(%eax)
{
  pushcli();
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
  cpu->gdt[SEG_TSS].s = 0;
  cpu->ts.ss0 = SEG_KDATA << 3;
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80106810:	81 c2 00 10 00 00    	add    $0x1000,%edx
80106816:	89 50 0c             	mov    %edx,0xc(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
80106819:	b8 30 00 00 00       	mov    $0x30,%eax
8010681e:	0f 00 d8             	ltr    %ax
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  cpu->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  if(p->pgdir == 0)
80106821:	8b 43 04             	mov    0x4(%ebx),%eax
80106824:	85 c0                	test   %eax,%eax
80106826:	74 12                	je     8010683a <switchuvm+0x8a>
    panic("switchuvm: no pgdir");
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106828:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010682d:	0f 22 d8             	mov    %eax,%cr3
  popcli();
}
80106830:	83 c4 14             	add    $0x14,%esp
80106833:	5b                   	pop    %ebx
80106834:	5d                   	pop    %ebp
  cpu->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
80106835:	e9 16 da ff ff       	jmp    80104250 <popcli>
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  cpu->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
8010683a:	c7 04 24 72 76 10 80 	movl   $0x80107672,(%esp)
80106841:	e8 ea 9a ff ff       	call   80100330 <panic>
80106846:	8d 76 00             	lea    0x0(%esi),%esi
80106849:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106850 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106850:	55                   	push   %ebp
80106851:	89 e5                	mov    %esp,%ebp
80106853:	83 ec 38             	sub    $0x38,%esp
80106856:	89 75 f8             	mov    %esi,-0x8(%ebp)
80106859:	8b 75 10             	mov    0x10(%ebp),%esi
8010685c:	8b 45 08             	mov    0x8(%ebp),%eax
8010685f:	89 7d fc             	mov    %edi,-0x4(%ebp)
80106862:	8b 7d 0c             	mov    0xc(%ebp),%edi
80106865:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  char *mem;

  if(sz >= PGSIZE)
80106868:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
8010686e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *mem;

  if(sz >= PGSIZE)
80106871:	77 59                	ja     801068cc <inituvm+0x7c>
    panic("inituvm: more than a page");
  mem = kalloc();
80106873:	e8 28 bc ff ff       	call   801024a0 <kalloc>
  memset(mem, 0, PGSIZE);
80106878:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
8010687f:	00 
80106880:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106887:	00 
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
80106888:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
8010688a:	89 04 24             	mov    %eax,(%esp)
8010688d:	e8 5e da ff ff       	call   801042f0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106892:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106898:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010689d:	89 04 24             	mov    %eax,(%esp)
801068a0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801068a3:	31 d2                	xor    %edx,%edx
801068a5:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
801068ac:	00 
801068ad:	e8 8e fc ff ff       	call   80106540 <mappages>
  memmove(mem, init, sz);
801068b2:	89 75 10             	mov    %esi,0x10(%ebp)
}
801068b5:	8b 75 f8             	mov    -0x8(%ebp),%esi
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
801068b8:	89 7d 0c             	mov    %edi,0xc(%ebp)
}
801068bb:	8b 7d fc             	mov    -0x4(%ebp),%edi
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
801068be:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801068c1:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801068c4:	89 ec                	mov    %ebp,%esp
801068c6:	5d                   	pop    %ebp
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
801068c7:	e9 d4 da ff ff       	jmp    801043a0 <memmove>
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
801068cc:	c7 04 24 86 76 10 80 	movl   $0x80107686,(%esp)
801068d3:	e8 58 9a ff ff       	call   80100330 <panic>
801068d8:	90                   	nop
801068d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801068e0 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
801068e0:	55                   	push   %ebp
801068e1:	89 e5                	mov    %esp,%ebp
801068e3:	57                   	push   %edi
801068e4:	56                   	push   %esi
801068e5:	53                   	push   %ebx
801068e6:	83 ec 1c             	sub    $0x1c,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
801068e9:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
801068f0:	0f 85 98 00 00 00    	jne    8010698e <loaduvm+0xae>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
801068f6:	8b 75 18             	mov    0x18(%ebp),%esi
801068f9:	31 db                	xor    %ebx,%ebx
801068fb:	85 f6                	test   %esi,%esi
801068fd:	75 1a                	jne    80106919 <loaduvm+0x39>
801068ff:	eb 77                	jmp    80106978 <loaduvm+0x98>
80106901:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106908:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010690e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106914:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106917:	76 5f                	jbe    80106978 <loaduvm+0x98>
}

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
80106919:	8b 55 0c             	mov    0xc(%ebp),%edx
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
8010691c:	31 c9                	xor    %ecx,%ecx
8010691e:	8b 45 08             	mov    0x8(%ebp),%eax
}

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
80106921:	01 da                	add    %ebx,%edx
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106923:	e8 88 fb ff ff       	call   801064b0 <walkpgdir>
80106928:	85 c0                	test   %eax,%eax
8010692a:	74 56                	je     80106982 <loaduvm+0xa2>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
8010692c:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
8010692e:	bf 00 10 00 00       	mov    $0x1000,%edi
}

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
80106933:	8b 4d 14             	mov    0x14(%ebp),%ecx
  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106936:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
8010693b:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
80106941:	0f 42 fe             	cmovb  %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106944:	05 00 00 00 80       	add    $0x80000000,%eax
80106949:	89 44 24 04          	mov    %eax,0x4(%esp)
8010694d:	8b 45 10             	mov    0x10(%ebp),%eax
}

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
80106950:	01 d9                	add    %ebx,%ecx
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106952:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80106956:	89 4c 24 08          	mov    %ecx,0x8(%esp)
8010695a:	89 04 24             	mov    %eax,(%esp)
8010695d:	e8 2e b0 ff ff       	call   80101990 <readi>
80106962:	39 f8                	cmp    %edi,%eax
80106964:	74 a2                	je     80106908 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
80106966:	83 c4 1c             	add    $0x1c,%esp
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
80106969:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
8010696e:	5b                   	pop    %ebx
8010696f:	5e                   	pop    %esi
80106970:	5f                   	pop    %edi
80106971:	5d                   	pop    %ebp
80106972:	c3                   	ret    
80106973:	90                   	nop
80106974:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106978:	83 c4 1c             	add    $0x1c,%esp
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
8010697b:	31 c0                	xor    %eax,%eax
}
8010697d:	5b                   	pop    %ebx
8010697e:	5e                   	pop    %esi
8010697f:	5f                   	pop    %edi
80106980:	5d                   	pop    %ebp
80106981:	c3                   	ret    

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
80106982:	c7 04 24 a0 76 10 80 	movl   $0x801076a0,(%esp)
80106989:	e8 a2 99 ff ff       	call   80100330 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
8010698e:	c7 04 24 44 77 10 80 	movl   $0x80107744,(%esp)
80106995:	e8 96 99 ff ff       	call   80100330 <panic>
8010699a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801069a0 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
801069a0:	55                   	push   %ebp
801069a1:	89 e5                	mov    %esp,%ebp
801069a3:	57                   	push   %edi
801069a4:	56                   	push   %esi
801069a5:	53                   	push   %ebx
801069a6:	83 ec 2c             	sub    $0x2c,%esp
801069a9:	8b 75 0c             	mov    0xc(%ebp),%esi
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
801069ac:	39 75 10             	cmp    %esi,0x10(%ebp)
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
801069af:	8b 7d 08             	mov    0x8(%ebp),%edi
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;
801069b2:	89 f0                	mov    %esi,%eax
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
801069b4:	73 75                	jae    80106a2b <deallocuvm+0x8b>
    return oldsz;

  a = PGROUNDUP(newsz);
801069b6:	8b 5d 10             	mov    0x10(%ebp),%ebx
801069b9:	81 c3 ff 0f 00 00    	add    $0xfff,%ebx
801069bf:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
801069c5:	39 de                	cmp    %ebx,%esi
801069c7:	77 3a                	ja     80106a03 <deallocuvm+0x63>
801069c9:	eb 5d                	jmp    80106a28 <deallocuvm+0x88>
801069cb:	90                   	nop
801069cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a += (NPTENTRIES - 1) * PGSIZE;
    else if((*pte & PTE_P) != 0){
801069d0:	8b 10                	mov    (%eax),%edx
801069d2:	f6 c2 01             	test   $0x1,%dl
801069d5:	74 22                	je     801069f9 <deallocuvm+0x59>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
801069d7:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
801069dd:	74 54                	je     80106a33 <deallocuvm+0x93>
        panic("kfree");
      char *v = P2V(pa);
801069df:	81 c2 00 00 00 80    	add    $0x80000000,%edx
      kfree(v);
801069e5:	89 14 24             	mov    %edx,(%esp)
801069e8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801069eb:	e8 40 b9 ff ff       	call   80102330 <kfree>
      *pte = 0;
801069f0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801069f3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
801069f9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801069ff:	39 de                	cmp    %ebx,%esi
80106a01:	76 25                	jbe    80106a28 <deallocuvm+0x88>
    pte = walkpgdir(pgdir, (char*)a, 0);
80106a03:	31 c9                	xor    %ecx,%ecx
80106a05:	89 da                	mov    %ebx,%edx
80106a07:	89 f8                	mov    %edi,%eax
80106a09:	e8 a2 fa ff ff       	call   801064b0 <walkpgdir>
    if(!pte)
80106a0e:	85 c0                	test   %eax,%eax
80106a10:	75 be                	jne    801069d0 <deallocuvm+0x30>
      a += (NPTENTRIES - 1) * PGSIZE;
80106a12:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106a18:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106a1e:	39 de                	cmp    %ebx,%esi
80106a20:	77 e1                	ja     80106a03 <deallocuvm+0x63>
80106a22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      char *v = P2V(pa);
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
80106a28:	8b 45 10             	mov    0x10(%ebp),%eax
}
80106a2b:	83 c4 2c             	add    $0x2c,%esp
80106a2e:	5b                   	pop    %ebx
80106a2f:	5e                   	pop    %esi
80106a30:	5f                   	pop    %edi
80106a31:	5d                   	pop    %ebp
80106a32:	c3                   	ret    
    if(!pte)
      a += (NPTENTRIES - 1) * PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
80106a33:	c7 04 24 36 70 10 80 	movl   $0x80107036,(%esp)
80106a3a:	e8 f1 98 ff ff       	call   80100330 <panic>
80106a3f:	90                   	nop

80106a40 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106a40:	55                   	push   %ebp
80106a41:	89 e5                	mov    %esp,%ebp
80106a43:	57                   	push   %edi
80106a44:	56                   	push   %esi
80106a45:	53                   	push   %ebx
80106a46:	83 ec 2c             	sub    $0x2c,%esp
80106a49:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80106a4c:	85 ff                	test   %edi,%edi
80106a4e:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80106a51:	0f 88 c1 00 00 00    	js     80106b18 <allocuvm+0xd8>
    return 0;
  if(newsz < oldsz)
80106a57:	8b 45 0c             	mov    0xc(%ebp),%eax
80106a5a:	39 c7                	cmp    %eax,%edi
80106a5c:	0f 82 a6 00 00 00    	jb     80106b08 <allocuvm+0xc8>
    return oldsz;

  a = PGROUNDUP(oldsz);
80106a62:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80106a65:	81 c3 ff 0f 00 00    	add    $0xfff,%ebx
80106a6b:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106a71:	39 df                	cmp    %ebx,%edi
80106a73:	77 51                	ja     80106ac6 <allocuvm+0x86>
80106a75:	e9 91 00 00 00       	jmp    80106b0b <allocuvm+0xcb>
80106a7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
80106a80:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106a87:	00 
80106a88:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106a8f:	00 
80106a90:	89 04 24             	mov    %eax,(%esp)
80106a93:	e8 58 d8 ff ff       	call   801042f0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106a98:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106a9e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106aa3:	89 04 24             	mov    %eax,(%esp)
80106aa6:	8b 45 08             	mov    0x8(%ebp),%eax
80106aa9:	89 da                	mov    %ebx,%edx
80106aab:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
80106ab2:	00 
80106ab3:	e8 88 fa ff ff       	call   80106540 <mappages>
80106ab8:	85 c0                	test   %eax,%eax
80106aba:	78 74                	js     80106b30 <allocuvm+0xf0>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106abc:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106ac2:	39 df                	cmp    %ebx,%edi
80106ac4:	76 45                	jbe    80106b0b <allocuvm+0xcb>
    mem = kalloc();
80106ac6:	e8 d5 b9 ff ff       	call   801024a0 <kalloc>
    if(mem == 0){
80106acb:	85 c0                	test   %eax,%eax
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
80106acd:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106acf:	75 af                	jne    80106a80 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80106ad1:	c7 04 24 be 76 10 80 	movl   $0x801076be,(%esp)
80106ad8:	e8 23 9b ff ff       	call   80100600 <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
80106add:	8b 45 0c             	mov    0xc(%ebp),%eax
80106ae0:	89 7c 24 04          	mov    %edi,0x4(%esp)
80106ae4:	89 44 24 08          	mov    %eax,0x8(%esp)
80106ae8:	8b 45 08             	mov    0x8(%ebp),%eax
80106aeb:	89 04 24             	mov    %eax,(%esp)
80106aee:	e8 ad fe ff ff       	call   801069a0 <deallocuvm>
      return 0;
80106af3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106afa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106afd:	83 c4 2c             	add    $0x2c,%esp
80106b00:	5b                   	pop    %ebx
80106b01:	5e                   	pop    %esi
80106b02:	5f                   	pop    %edi
80106b03:	5d                   	pop    %ebp
80106b04:	c3                   	ret    
80106b05:	8d 76 00             	lea    0x0(%esi),%esi
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
    return oldsz;
80106b08:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106b0b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106b0e:	83 c4 2c             	add    $0x2c,%esp
80106b11:	5b                   	pop    %ebx
80106b12:	5e                   	pop    %esi
80106b13:	5f                   	pop    %edi
80106b14:	5d                   	pop    %ebp
80106b15:	c3                   	ret    
80106b16:	66 90                	xchg   %ax,%ax
{
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
    return 0;
80106b18:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106b1f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106b22:	83 c4 2c             	add    $0x2c,%esp
80106b25:	5b                   	pop    %ebx
80106b26:	5e                   	pop    %esi
80106b27:	5f                   	pop    %edi
80106b28:	5d                   	pop    %ebp
80106b29:	c3                   	ret    
80106b2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
80106b30:	c7 04 24 d6 76 10 80 	movl   $0x801076d6,(%esp)
80106b37:	e8 c4 9a ff ff       	call   80100600 <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
80106b3c:	8b 45 0c             	mov    0xc(%ebp),%eax
80106b3f:	89 7c 24 04          	mov    %edi,0x4(%esp)
80106b43:	89 44 24 08          	mov    %eax,0x8(%esp)
80106b47:	8b 45 08             	mov    0x8(%ebp),%eax
80106b4a:	89 04 24             	mov    %eax,(%esp)
80106b4d:	e8 4e fe ff ff       	call   801069a0 <deallocuvm>
      kfree(mem);
80106b52:	89 34 24             	mov    %esi,(%esp)
80106b55:	e8 d6 b7 ff ff       	call   80102330 <kfree>
      return 0;
80106b5a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    }
  }
  return newsz;
}
80106b61:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106b64:	83 c4 2c             	add    $0x2c,%esp
80106b67:	5b                   	pop    %ebx
80106b68:	5e                   	pop    %esi
80106b69:	5f                   	pop    %edi
80106b6a:	5d                   	pop    %ebp
80106b6b:	c3                   	ret    
80106b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106b70 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106b70:	55                   	push   %ebp
80106b71:	89 e5                	mov    %esp,%ebp
80106b73:	56                   	push   %esi
80106b74:	53                   	push   %ebx
80106b75:	83 ec 10             	sub    $0x10,%esp
80106b78:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106b7b:	85 f6                	test   %esi,%esi
80106b7d:	74 5e                	je     80106bdd <freevm+0x6d>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
80106b7f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80106b86:	00 
  for(i = 0; i < NPDENTRIES; i++){
80106b87:	31 db                	xor    %ebx,%ebx
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
80106b89:	c7 44 24 04 00 00 00 	movl   $0x80000000,0x4(%esp)
80106b90:	80 
80106b91:	89 34 24             	mov    %esi,(%esp)
80106b94:	e8 07 fe ff ff       	call   801069a0 <deallocuvm>
80106b99:	eb 10                	jmp    80106bab <freevm+0x3b>
80106b9b:	90                   	nop
80106b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < NPDENTRIES; i++){
80106ba0:	83 c3 01             	add    $0x1,%ebx
80106ba3:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
80106ba9:	74 24                	je     80106bcf <freevm+0x5f>
    if(pgdir[i] & PTE_P){
80106bab:	8b 04 9e             	mov    (%esi,%ebx,4),%eax
80106bae:	a8 01                	test   $0x1,%al
80106bb0:	74 ee                	je     80106ba0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106bb2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106bb7:	83 c3 01             	add    $0x1,%ebx
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106bba:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80106bbf:	89 04 24             	mov    %eax,(%esp)
80106bc2:	e8 69 b7 ff ff       	call   80102330 <kfree>
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106bc7:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
80106bcd:	75 dc                	jne    80106bab <freevm+0x3b>
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106bcf:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106bd2:	83 c4 10             	add    $0x10,%esp
80106bd5:	5b                   	pop    %ebx
80106bd6:	5e                   	pop    %esi
80106bd7:	5d                   	pop    %ebp
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106bd8:	e9 53 b7 ff ff       	jmp    80102330 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
80106bdd:	c7 04 24 f2 76 10 80 	movl   $0x801076f2,(%esp)
80106be4:	e8 47 97 ff ff       	call   80100330 <panic>
80106be9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106bf0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106bf0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106bf1:	31 c9                	xor    %ecx,%ecx

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106bf3:	89 e5                	mov    %esp,%ebp
80106bf5:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106bf8:	8b 55 0c             	mov    0xc(%ebp),%edx
80106bfb:	8b 45 08             	mov    0x8(%ebp),%eax
80106bfe:	e8 ad f8 ff ff       	call   801064b0 <walkpgdir>
  if(pte == 0)
80106c03:	85 c0                	test   %eax,%eax
80106c05:	74 05                	je     80106c0c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80106c07:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80106c0a:	c9                   	leave  
80106c0b:	c3                   	ret    
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80106c0c:	c7 04 24 03 77 10 80 	movl   $0x80107703,(%esp)
80106c13:	e8 18 97 ff ff       	call   80100330 <panic>
80106c18:	90                   	nop
80106c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106c20 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80106c20:	55                   	push   %ebp
80106c21:	89 e5                	mov    %esp,%ebp
80106c23:	57                   	push   %edi
80106c24:	56                   	push   %esi
80106c25:	53                   	push   %ebx
80106c26:	83 ec 2c             	sub    $0x2c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80106c29:	e8 c2 fa ff ff       	call   801066f0 <setupkvm>
80106c2e:	85 c0                	test   %eax,%eax
80106c30:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106c33:	0f 84 9f 00 00 00    	je     80106cd8 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106c39:	8b 45 0c             	mov    0xc(%ebp),%eax
80106c3c:	85 c0                	test   %eax,%eax
80106c3e:	0f 84 94 00 00 00    	je     80106cd8 <copyuvm+0xb8>
80106c44:	31 db                	xor    %ebx,%ebx
80106c46:	eb 48                	jmp    80106c90 <copyuvm+0x70>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80106c48:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80106c4e:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106c55:	00 
80106c56:	89 7c 24 04          	mov    %edi,0x4(%esp)
80106c5a:	89 04 24             	mov    %eax,(%esp)
80106c5d:	e8 3e d7 ff ff       	call   801043a0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
80106c62:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106c65:	8d 96 00 00 00 80    	lea    -0x80000000(%esi),%edx
80106c6b:	89 14 24             	mov    %edx,(%esp)
80106c6e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106c73:	89 da                	mov    %ebx,%edx
80106c75:	89 44 24 04          	mov    %eax,0x4(%esp)
80106c79:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106c7c:	e8 bf f8 ff ff       	call   80106540 <mappages>
80106c81:	85 c0                	test   %eax,%eax
80106c83:	78 41                	js     80106cc6 <copyuvm+0xa6>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106c85:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106c8b:	39 5d 0c             	cmp    %ebx,0xc(%ebp)
80106c8e:	76 48                	jbe    80106cd8 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80106c90:	8b 45 08             	mov    0x8(%ebp),%eax
80106c93:	31 c9                	xor    %ecx,%ecx
80106c95:	89 da                	mov    %ebx,%edx
80106c97:	e8 14 f8 ff ff       	call   801064b0 <walkpgdir>
80106c9c:	85 c0                	test   %eax,%eax
80106c9e:	74 43                	je     80106ce3 <copyuvm+0xc3>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
80106ca0:	8b 30                	mov    (%eax),%esi
80106ca2:	f7 c6 01 00 00 00    	test   $0x1,%esi
80106ca8:	74 45                	je     80106cef <copyuvm+0xcf>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80106caa:	89 f7                	mov    %esi,%edi
    flags = PTE_FLAGS(*pte);
80106cac:	81 e6 ff 0f 00 00    	and    $0xfff,%esi
80106cb2:	89 75 e4             	mov    %esi,-0x1c(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80106cb5:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
80106cbb:	e8 e0 b7 ff ff       	call   801024a0 <kalloc>
80106cc0:	85 c0                	test   %eax,%eax
80106cc2:	89 c6                	mov    %eax,%esi
80106cc4:	75 82                	jne    80106c48 <copyuvm+0x28>
      goto bad;
  }
  return d;

bad:
  freevm(d);
80106cc6:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106cc9:	89 04 24             	mov    %eax,(%esp)
80106ccc:	e8 9f fe ff ff       	call   80106b70 <freevm>
  return 0;
80106cd1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80106cd8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106cdb:	83 c4 2c             	add    $0x2c,%esp
80106cde:	5b                   	pop    %ebx
80106cdf:	5e                   	pop    %esi
80106ce0:	5f                   	pop    %edi
80106ce1:	5d                   	pop    %ebp
80106ce2:	c3                   	ret    

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
80106ce3:	c7 04 24 0d 77 10 80 	movl   $0x8010770d,(%esp)
80106cea:	e8 41 96 ff ff       	call   80100330 <panic>
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
80106cef:	c7 04 24 27 77 10 80 	movl   $0x80107727,(%esp)
80106cf6:	e8 35 96 ff ff       	call   80100330 <panic>
80106cfb:	90                   	nop
80106cfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106d00 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80106d00:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106d01:	31 c9                	xor    %ecx,%ecx

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80106d03:	89 e5                	mov    %esp,%ebp
80106d05:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106d08:	8b 55 0c             	mov    0xc(%ebp),%edx
80106d0b:	8b 45 08             	mov    0x8(%ebp),%eax
80106d0e:	e8 9d f7 ff ff       	call   801064b0 <walkpgdir>
  if((*pte & PTE_P) == 0)
80106d13:	8b 00                	mov    (%eax),%eax
80106d15:	a8 01                	test   $0x1,%al
80106d17:	74 17                	je     80106d30 <uva2ka+0x30>
    return 0;
  if((*pte & PTE_U) == 0)
80106d19:	a8 04                	test   $0x4,%al
80106d1b:	74 13                	je     80106d30 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80106d1d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106d22:	05 00 00 00 80       	add    $0x80000000,%eax
}
80106d27:	c9                   	leave  
80106d28:	c3                   	ret    
80106d29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
80106d30:	31 c0                	xor    %eax,%eax
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80106d32:	c9                   	leave  
80106d33:	c3                   	ret    
80106d34:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d3a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106d40 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80106d40:	55                   	push   %ebp
80106d41:	89 e5                	mov    %esp,%ebp
80106d43:	57                   	push   %edi
80106d44:	56                   	push   %esi
80106d45:	53                   	push   %ebx
80106d46:	83 ec 2c             	sub    $0x2c,%esp
80106d49:	8b 5d 14             	mov    0x14(%ebp),%ebx
80106d4c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80106d4f:	8b 7d 10             	mov    0x10(%ebp),%edi
80106d52:	85 db                	test   %ebx,%ebx
80106d54:	75 37                	jne    80106d8d <copyout+0x4d>
80106d56:	eb 68                	jmp    80106dc0 <copyout+0x80>
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80106d58:	89 f2                	mov    %esi,%edx
80106d5a:	29 ca                	sub    %ecx,%edx
80106d5c:	81 c2 00 10 00 00    	add    $0x1000,%edx
80106d62:	39 da                	cmp    %ebx,%edx
80106d64:	0f 47 d3             	cmova  %ebx,%edx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80106d67:	29 f1                	sub    %esi,%ecx
80106d69:	01 c8                	add    %ecx,%eax
80106d6b:	89 54 24 08          	mov    %edx,0x8(%esp)
80106d6f:	89 7c 24 04          	mov    %edi,0x4(%esp)
80106d73:	89 04 24             	mov    %eax,(%esp)
80106d76:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80106d79:	e8 22 d6 ff ff       	call   801043a0 <memmove>
    len -= n;
    buf += n;
80106d7e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    va = va0 + PGSIZE;
80106d81:	8d 8e 00 10 00 00    	lea    0x1000(%esi),%ecx
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
80106d87:	01 d7                	add    %edx,%edi
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80106d89:	29 d3                	sub    %edx,%ebx
80106d8b:	74 33                	je     80106dc0 <copyout+0x80>
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
80106d8d:	8b 45 08             	mov    0x8(%ebp),%eax
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
80106d90:	89 ce                	mov    %ecx,%esi
80106d92:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80106d98:	89 74 24 04          	mov    %esi,0x4(%esp)
80106d9c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80106d9f:	89 04 24             	mov    %eax,(%esp)
80106da2:	e8 59 ff ff ff       	call   80106d00 <uva2ka>
    if(pa0 == 0)
80106da7:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106daa:	85 c0                	test   %eax,%eax
80106dac:	75 aa                	jne    80106d58 <copyout+0x18>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
80106dae:	83 c4 2c             	add    $0x2c,%esp
  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
80106db1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
80106db6:	5b                   	pop    %ebx
80106db7:	5e                   	pop    %esi
80106db8:	5f                   	pop    %edi
80106db9:	5d                   	pop    %ebp
80106dba:	c3                   	ret    
80106dbb:	90                   	nop
80106dbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106dc0:	83 c4 2c             	add    $0x2c,%esp
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
80106dc3:	31 c0                	xor    %eax,%eax
}
80106dc5:	5b                   	pop    %ebx
80106dc6:	5e                   	pop    %esi
80106dc7:	5f                   	pop    %edi
80106dc8:	5d                   	pop    %ebp
80106dc9:	c3                   	ret    
