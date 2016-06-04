AS=as
LINKER=ld
OBJ=src/doublesgame.o

%.o: %.asm
	$(AS) -o $@ $<

doublesgame: $(OBJ)
	mkdir -p bin/
	$(LINKER) -o bin/$@ $^

.PHONY: clean

clean:
	rm $(OBJ)
