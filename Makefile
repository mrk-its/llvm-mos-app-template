TARGET = a800xl
EXT = xex
CLANG = mos-$(TARGET)-clang
CFLAGS = -O2 -DTARGET=$(TARGET)
ELF = -Wl,--oformat=elf

SRCS = $(wildcard *.c)

a800xl:
	mkdir -p target/$@
	make -C target/$@ -f ../../Makefile TARGET=a800xl EXT=xex $(SRCS:.c=.xex)

sim:
	mkdir -p target/$@
	make -C target/$@ -f ../../Makefile TARGET=sim EXT=sim $(SRCS:.c=.sim)

%.$(EXT): ../../%.c
	$(CLANG) $< -o $(basename $@).elf $(CFLAGS) $(ELF)
	../../tools/labels.sh $(basename $@).elf > $(basename $@).lab
	llvm-objdump -d $(basename $@).elf > $(basename $@).asm
	$(CLANG) $< -o $@ $(CFLAGS)

clean:
	rm -fr target

