

MEOBJS = mov_example_1.o
ADD1OBJS = add_example_1.o
ADD2OBJS = add_example_1.o


AS = as

ifdef DEBUG
DEBUGFLGS =-g
else
DEBUGFLGS =
endif

LDFLAGS = -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -arch arm64

%.o : %.s
	$(AS) $(DEBUGFLGS) -o $@ $<

all: mov_example_1 add_example_1 add_example_2

mov_example_1: $(MEOBJS)
	ld -o mov_example_1 $(LDFLAGS) $(MEOBJS)

add_example_1: $(add_example_1)
	ld -o add_example_1 $(LDFLAGS) $(ADD1OBJS)

add_example_2: $(add_example_2)
	ld -o add_example_2 $(LDFLAGS) $(ADD2OBJS)
clean:
	rm *.o mov_example_1
