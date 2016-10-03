
bootblock.o:     file format elf32-i386


Disassembly of section .text:

00007c00 <start>:
# with %cs=0 %ip=7c00.

.code16                       # Assemble for 16-bit mode
.globl start
start:
  cli                         # BIOS enabled interrupts; disable
    7c00:	fa                   	cli    

  # Zero data segment registers DS, ES, and SS.
  xorw    %ax,%ax             # Set %ax to zero
    7c01:	31 c0                	xor    %eax,%eax
  movw    %ax,%ds             # -> Data Segment
    7c03:	8e d8                	mov    %eax,%ds
  movw    %ax,%es             # -> Extra Segment
    7c05:	8e c0                	mov    %eax,%es
  movw    %ax,%ss             # -> Stack Segment
    7c07:	8e d0                	mov    %eax,%ss

00007c09 <seta20.1>:

  # Physical address line A20 is tied to zero so that the first PCs 
  # with 2 MB would run software that assumed 1 MB.  Undo that.
seta20.1:
  inb     $0x64,%al               # Wait for not busy
    7c09:	e4 64                	in     $0x64,%al
  testb   $0x2,%al
    7c0b:	a8 02                	test   $0x2,%al
  jnz     seta20.1
    7c0d:	75 fa                	jne    7c09 <seta20.1>

  movb    $0xd1,%al               # 0xd1 -> port 0x64
    7c0f:	b0 d1                	mov    $0xd1,%al
  outb    %al,$0x64
    7c11:	e6 64                	out    %al,$0x64

00007c13 <seta20.2>:

seta20.2:
  inb     $0x64,%al               # Wait for not busy
    7c13:	e4 64                	in     $0x64,%al
  testb   $0x2,%al
    7c15:	a8 02                	test   $0x2,%al
  jnz     seta20.2
    7c17:	75 fa                	jne    7c13 <seta20.2>

  movb    $0xdf,%al               # 0xdf -> port 0x60
    7c19:	b0 df                	mov    $0xdf,%al
  outb    %al,$0x60
    7c1b:	e6 60                	out    %al,$0x60

  # Switch from real to protected mode.  Use a bootstrap GDT that makes
  # virtual addresses map directly to physical addresses so that the
  # effective memory map doesn't change during the transition.
  lgdt    gdtdesc
    7c1d:	0f 01 16             	lgdtl  (%esi)
    7c20:	78 7c                	js     7c9e <readsect+0xe>
  movl    %cr0, %eax
    7c22:	0f 20 c0             	mov    %cr0,%eax
  orl     $CR0_PE, %eax
    7c25:	66 83 c8 01          	or     $0x1,%ax
  movl    %eax, %cr0
    7c29:	0f 22 c0             	mov    %eax,%cr0

//PAGEBREAK!
  # Complete the transition to 32-bit protected mode by using a long jmp
  # to reload %cs and %eip.  The segment descriptors are set up with no
  # translation, so that the mapping is still the identity mapping.
  ljmp    $(SEG_KCODE<<3), $start32
    7c2c:	ea 31 7c 08 00 66 b8 	ljmp   $0xb866,$0x87c31

00007c31 <start32>:

.code32  # Tell assembler to generate 32-bit code now.
start32:
  # Set up the protected-mode data segment registers
  movw    $(SEG_KDATA<<3), %ax    # Our data segment selector
    7c31:	66 b8 10 00          	mov    $0x10,%ax
  movw    %ax, %ds                # -> DS: Data Segment
    7c35:	8e d8                	mov    %eax,%ds
  movw    %ax, %es                # -> ES: Extra Segment
    7c37:	8e c0                	mov    %eax,%es
  movw    %ax, %ss                # -> SS: Stack Segment
    7c39:	8e d0                	mov    %eax,%ss
  movw    $0, %ax                 # Zero segments not ready for use
    7c3b:	66 b8 00 00          	mov    $0x0,%ax
  movw    %ax, %fs                # -> FS
    7c3f:	8e e0                	mov    %eax,%fs
  movw    %ax, %gs                # -> GS
    7c41:	8e e8                	mov    %eax,%gs

  # Set up the stack pointer and call into C.
  movl    $start, %esp
    7c43:	bc 00 7c 00 00       	mov    $0x7c00,%esp
  call    bootmain
    7c48:	e8 e7 00 00 00       	call   7d34 <bootmain>

  # If bootmain returns (it shouldn't), trigger a Bochs
  # breakpoint if running under Bochs, then loop.
  movw    $0x8a00, %ax            # 0x8a00 -> port 0x8a00
    7c4d:	66 b8 00 8a          	mov    $0x8a00,%ax
  movw    %ax, %dx
    7c51:	66 89 c2             	mov    %ax,%dx
  outw    %ax, %dx
    7c54:	66 ef                	out    %ax,(%dx)
  movw    $0x8ae0, %ax            # 0x8ae0 -> port 0x8a00
    7c56:	66 b8 e0 8a          	mov    $0x8ae0,%ax
  outw    %ax, %dx
    7c5a:	66 ef                	out    %ax,(%dx)

00007c5c <spin>:
spin:
  jmp     spin
    7c5c:	eb fe                	jmp    7c5c <spin>
    7c5e:	66 90                	xchg   %ax,%ax

00007c60 <gdt>:
	...
    7c68:	ff                   	(bad)  
    7c69:	ff 00                	incl   (%eax)
    7c6b:	00 00                	add    %al,(%eax)
    7c6d:	9a cf 00 ff ff 00 00 	lcall  $0x0,$0xffff00cf
    7c74:	00 92 cf 00 17 00    	add    %dl,0x1700cf(%edx)

00007c78 <gdtdesc>:
    7c78:	17                   	pop    %ss
    7c79:	00 60 7c             	add    %ah,0x7c(%eax)
	...

00007c7e <waitdisk>:
  entry();
}

void
waitdisk(void)
{
    7c7e:	55                   	push   %ebp
    7c7f:	89 e5                	mov    %esp,%ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
    7c81:	ba f7 01 00 00       	mov    $0x1f7,%edx
    7c86:	ec                   	in     (%dx),%al
  // Wait for disk ready.
  while((inb(0x1F7) & 0xC0) != 0x40)
    7c87:	83 e0 c0             	and    $0xffffffc0,%eax
    7c8a:	3c 40                	cmp    $0x40,%al
    7c8c:	75 f8                	jne    7c86 <waitdisk+0x8>
    ;
}
    7c8e:	5d                   	pop    %ebp
    7c8f:	c3                   	ret    

00007c90 <readsect>:

// Read a single sector at offset into dst.
void
readsect(void *dst, uint offset)
{
    7c90:	55                   	push   %ebp
    7c91:	89 e5                	mov    %esp,%ebp
    7c93:	57                   	push   %edi
    7c94:	53                   	push   %ebx
    7c95:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  // Issue command.
  waitdisk();
    7c98:	e8 e1 ff ff ff       	call   7c7e <waitdisk>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
    7c9d:	ba f2 01 00 00       	mov    $0x1f2,%edx
    7ca2:	b8 01 00 00 00       	mov    $0x1,%eax
    7ca7:	ee                   	out    %al,(%dx)
  // If this is too slow, we could read lots of sectors at a time.
  // We'd write more to memory than asked, but it doesn't matter --
  // we load in increasing order.
  for(; pa < epa; pa += SECTSIZE, offset++)
    readsect(pa, offset);
}
    7ca8:	0f b6 c3             	movzbl %bl,%eax
    7cab:	b2 f3                	mov    $0xf3,%dl
    7cad:	ee                   	out    %al,(%dx)
    7cae:	0f b6 c7             	movzbl %bh,%eax
    7cb1:	b2 f4                	mov    $0xf4,%dl
    7cb3:	ee                   	out    %al,(%dx)
  // Issue command.
  waitdisk();
  outb(0x1F2, 1);   // count = 1
  outb(0x1F3, offset);
  outb(0x1F4, offset >> 8);
  outb(0x1F5, offset >> 16);
    7cb4:	89 d8                	mov    %ebx,%eax
    7cb6:	c1 e8 10             	shr    $0x10,%eax
  // If this is too slow, we could read lots of sectors at a time.
  // We'd write more to memory than asked, but it doesn't matter --
  // we load in increasing order.
  for(; pa < epa; pa += SECTSIZE, offset++)
    readsect(pa, offset);
}
    7cb9:	25 ff 00 00 00       	and    $0xff,%eax
    7cbe:	b2 f5                	mov    $0xf5,%dl
    7cc0:	ee                   	out    %al,(%dx)
    7cc1:	c1 eb 18             	shr    $0x18,%ebx
    7cc4:	89 d8                	mov    %ebx,%eax
    7cc6:	0c e0                	or     $0xe0,%al
    7cc8:	b2 f6                	mov    $0xf6,%dl
    7cca:	ee                   	out    %al,(%dx)
    7ccb:	b2 f7                	mov    $0xf7,%dl
    7ccd:	b8 20 00 00 00       	mov    $0x20,%eax
    7cd2:	ee                   	out    %al,(%dx)
  outb(0x1F5, offset >> 16);
  outb(0x1F6, (offset >> 24) | 0xE0);
  outb(0x1F7, 0x20);  // cmd 0x20 - read sectors

  // Read data.
  waitdisk();
    7cd3:	e8 a6 ff ff ff       	call   7c7e <waitdisk>
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld; rep insl" :
    7cd8:	8b 7d 08             	mov    0x8(%ebp),%edi
    7cdb:	b9 80 00 00 00       	mov    $0x80,%ecx
    7ce0:	ba f0 01 00 00       	mov    $0x1f0,%edx
    7ce5:	fc                   	cld    
    7ce6:	f3 6d                	rep insl (%dx),%es:(%edi)
  insl(0x1F0, dst, SECTSIZE/4);
}
    7ce8:	5b                   	pop    %ebx
    7ce9:	5f                   	pop    %edi
    7cea:	5d                   	pop    %ebp
    7ceb:	c3                   	ret    

00007cec <readseg>:

// Read 'count' bytes at 'offset' from kernel into physical address 'pa'.
// Might copy more than asked.
void
readseg(uchar* pa, uint count, uint offset)
{
    7cec:	55                   	push   %ebp
    7ced:	89 e5                	mov    %esp,%ebp
    7cef:	57                   	push   %edi
    7cf0:	56                   	push   %esi
    7cf1:	53                   	push   %ebx
    7cf2:	83 ec 08             	sub    $0x8,%esp
    7cf5:	8b 5d 08             	mov    0x8(%ebp),%ebx
    7cf8:	8b 75 10             	mov    0x10(%ebp),%esi
  uchar* epa;

  epa = pa + count;
    7cfb:	89 df                	mov    %ebx,%edi
    7cfd:	03 7d 0c             	add    0xc(%ebp),%edi

  // Round down to sector boundary.
  pa -= offset % SECTSIZE;
    7d00:	89 f0                	mov    %esi,%eax
    7d02:	25 ff 01 00 00       	and    $0x1ff,%eax
    7d07:	29 c3                	sub    %eax,%ebx

  // Translate from bytes to sectors; kernel starts at sector 1.
  offset = (offset / SECTSIZE) + 1;
    7d09:	c1 ee 09             	shr    $0x9,%esi
    7d0c:	83 c6 01             	add    $0x1,%esi

  // If this is too slow, we could read lots of sectors at a time.
  // We'd write more to memory than asked, but it doesn't matter --
  // we load in increasing order.
  for(; pa < epa; pa += SECTSIZE, offset++)
    7d0f:	39 df                	cmp    %ebx,%edi
    7d11:	76 19                	jbe    7d2c <readseg+0x40>
    readsect(pa, offset);
    7d13:	89 74 24 04          	mov    %esi,0x4(%esp)
    7d17:	89 1c 24             	mov    %ebx,(%esp)
    7d1a:	e8 71 ff ff ff       	call   7c90 <readsect>
  offset = (offset / SECTSIZE) + 1;

  // If this is too slow, we could read lots of sectors at a time.
  // We'd write more to memory than asked, but it doesn't matter --
  // we load in increasing order.
  for(; pa < epa; pa += SECTSIZE, offset++)
    7d1f:	81 c3 00 02 00 00    	add    $0x200,%ebx
    7d25:	83 c6 01             	add    $0x1,%esi
    7d28:	39 df                	cmp    %ebx,%edi
    7d2a:	77 e7                	ja     7d13 <readseg+0x27>
    readsect(pa, offset);
}
    7d2c:	83 c4 08             	add    $0x8,%esp
    7d2f:	5b                   	pop    %ebx
    7d30:	5e                   	pop    %esi
    7d31:	5f                   	pop    %edi
    7d32:	5d                   	pop    %ebp
    7d33:	c3                   	ret    

00007d34 <bootmain>:

void readseg(uchar*, uint, uint);

void
bootmain(void)
{
    7d34:	55                   	push   %ebp
    7d35:	89 e5                	mov    %esp,%ebp
    7d37:	57                   	push   %edi
    7d38:	56                   	push   %esi
    7d39:	53                   	push   %ebx
    7d3a:	83 ec 1c             	sub    $0x1c,%esp
  uchar* pa;

  elf = (struct elfhdr*)0x10000;  // scratch space

  // Read 1st page off disk
  readseg((uchar*)elf, 4096, 0);
    7d3d:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
    7d44:	00 
    7d45:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    7d4c:	00 
    7d4d:	c7 04 24 00 00 01 00 	movl   $0x10000,(%esp)
    7d54:	e8 93 ff ff ff       	call   7cec <readseg>

  // Is this an ELF executable?
  if(elf->magic != ELF_MAGIC)
    7d59:	81 3d 00 00 01 00 7f 	cmpl   $0x464c457f,0x10000
    7d60:	45 4c 46 
    7d63:	75 58                	jne    7dbd <bootmain+0x89>
    return;  // let bootasm.S handle error

  // Load each program segment (ignores ph flags).
  ph = (struct proghdr*)((uchar*)elf + elf->phoff);
    7d65:	8b 1d 1c 00 01 00    	mov    0x1001c,%ebx
    7d6b:	81 c3 00 00 01 00    	add    $0x10000,%ebx
  eph = ph + elf->phnum;
    7d71:	0f b7 35 2c 00 01 00 	movzwl 0x1002c,%esi
    7d78:	c1 e6 05             	shl    $0x5,%esi
    7d7b:	01 de                	add    %ebx,%esi
  for(; ph < eph; ph++){
    7d7d:	39 f3                	cmp    %esi,%ebx
    7d7f:	73 36                	jae    7db7 <bootmain+0x83>
    pa = (uchar*)ph->paddr;
    7d81:	8b 7b 0c             	mov    0xc(%ebx),%edi
    readseg(pa, ph->filesz, ph->off);
    7d84:	8b 43 04             	mov    0x4(%ebx),%eax
    7d87:	89 44 24 08          	mov    %eax,0x8(%esp)
    7d8b:	8b 43 10             	mov    0x10(%ebx),%eax
    7d8e:	89 44 24 04          	mov    %eax,0x4(%esp)
    7d92:	89 3c 24             	mov    %edi,(%esp)
    7d95:	e8 52 ff ff ff       	call   7cec <readseg>
    if(ph->memsz > ph->filesz)
    7d9a:	8b 4b 14             	mov    0x14(%ebx),%ecx
    7d9d:	8b 43 10             	mov    0x10(%ebx),%eax
    7da0:	39 c1                	cmp    %eax,%ecx
    7da2:	76 0c                	jbe    7db0 <bootmain+0x7c>
      stosb(pa + ph->filesz, 0, ph->memsz - ph->filesz);
    7da4:	01 c7                	add    %eax,%edi
    7da6:	29 c1                	sub    %eax,%ecx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    7da8:	b8 00 00 00 00       	mov    $0x0,%eax
    7dad:	fc                   	cld    
    7dae:	f3 aa                	rep stos %al,%es:(%edi)
    return;  // let bootasm.S handle error

  // Load each program segment (ignores ph flags).
  ph = (struct proghdr*)((uchar*)elf + elf->phoff);
  eph = ph + elf->phnum;
  for(; ph < eph; ph++){
    7db0:	83 c3 20             	add    $0x20,%ebx
    7db3:	39 de                	cmp    %ebx,%esi
    7db5:	77 ca                	ja     7d81 <bootmain+0x4d>
  }

  // Call the entry point from the ELF header.
  // Does not return!
  entry = (void(*)(void))(elf->entry);
  entry();
    7db7:	ff 15 18 00 01 00    	call   *0x10018
}
    7dbd:	83 c4 1c             	add    $0x1c,%esp
    7dc0:	5b                   	pop    %ebx
    7dc1:	5e                   	pop    %esi
    7dc2:	5f                   	pop    %edi
    7dc3:	5d                   	pop    %ebp
    7dc4:	c3                   	ret    
