AS=as
LINKER=ld
OBJ=src/doublesgame.o

%.o: %.asm
	$(AS) -g -o $@ $<

doublesgame: $(OBJ)
	mkdir -p bin/
	$(LINKER) -dynamic-linker /lib64/ld-linux-x86-64.so.2 \
		-o bin/$@ $^ \
		-lc

.PHONY: clean install

clean:
	rm $(OBJ)

install:
	install bin/doublesgame /usr/bin/
