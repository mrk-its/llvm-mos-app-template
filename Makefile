CLANG = mos-a800xl-clang
CFLAGS = -O2
ELF = -Wl,--oformat=elf

hello.xex: hello.c

%.xex: %.c
	mos-a800xl-clang $< -o $@ $(CFLAGS)
	mos-a800xl-clang $< -o $@.elf $(CFLAGS) $(ELF)
	./tools/labels.sh $@.elf > $(basename $@).lab

clean:
	rm -f *.xex *.lab *.elf

