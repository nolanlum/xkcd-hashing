CC=gcc
LD=gcc
CFLAGS=-O3 -march=native -std=c99 -ggdb
LDFLAGS=
OUTFILE=xkcd

%.o: %.c
	$(CC) -c $(CFLAGS) -o $@ $<
%.o: %.s
	$(CC) -c $(CFLAGS) -o $@ $<

all: skein/skein.o skein/skein_block.o xkcd.o
	$(LD) $(LDFLAGS) -o $(OUTFILE) $^

profile : CFLAGS=-O3 -march=native -std=c99 -ggdb -pg
profile : LDFLAGS=-pg
profile : clean all

win32 : CC=x86_64-w64-mingw32-gcc
win32 : LD=x86_64-w64-mingw32-ld
win32 : OUTFILE=xkcd.exe
win32 : clean all

clean:
	-rm xkcd xkcd.exe *.o skein/*.o
