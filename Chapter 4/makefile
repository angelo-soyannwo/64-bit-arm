OBJS = printword.o
FLOOP = for_loop.o
CASE = case.o
DO = do_while.o
OBJS2 = printwordW32.o

LDFLAGS = -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -arch arm64

%.o: %.s
	as $(DEBUGFLAGS) $< -o $@

all: for_loop printword case do_while printwordW32

printword: $(OBJS)
	ld -o printdword $(LDFLAGS) $(OBJS)

for_loop: $(FLOOP)
	ld -o for_loop $(LDFLAGS) $(FLOOP)

case: $(CASE)
	ld -o case $(LDFLAGS) $(CASE)

do_while: $(DO)
	ld -o do_while $(LDFLAGS) $(DO)

printwordW32: $(OBJS2)
	ld -o printwordW32 $(LDFLAGS) $(OBJS2)

clean:
	rm *.o printdword

