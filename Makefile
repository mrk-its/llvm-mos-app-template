CLANG = mos-$(TARGET)-clang
CFLAGS = -O3 -Dmos_$(TARGET)

SRCS = $(wildcard *.c)

atari8:
	mkdir -p target/$@
	make -C target/$@ -f ../../Makefile TARGET=atari8 EXT=xex $(SRCS:.c=.xex)

sim:
	mkdir -p target/$@
	make -C target/$@ -f ../../Makefile TARGET=sim EXT=sim $(SRCS:.c=.sim)

%.$(EXT): ../../%.c
	$(CLANG) $< -o $@ $(CFLAGS)
	../../tools/labels.sh $@.elf > $(basename $@).lab
	llvm-objdump -d $@.elf --print-imm-hex > $(basename $@).asm

clean:
	rm -fr target
