SM64API ?= .

CC = clang
LD = ld.lld

CFLAGS += -I${SM64API}/sm64
CFLAGS += -I${SM64API}/sm64/libc

CLFAGS += -DVERSION_US
CLFAGS += -DF3D_OLD
CFLAGS += -DBINARY
CFLAGS += -DTARGET_N64

CFLAGS += -Wall
CFLAGS += -Wdouble-promotion

CFLAGS += -Os
CFLAGS += -G0

CFLAGS += -mfix4300
CFLAGS += -march=mips2
CFLAGS += -mfpxx
CFLAGS += -mno-check-zero-division
CFLAGS += -mno-abicalls

CFLAGS += -flto
CFLAGS += -fomit-frame-pointer
CFLAGS += -fno-exceptions
CFLAGS += -fno-builtin
CFLAGS += -fno-rtti
CFLAGS += -fno-common

CFLAGS += --target=mips-img-elf

BIN=$(patsubst %.c,%.bin,$(wildcard *.c))

all: ${BIN}

clean:
	del *.o *.bin

%.bin: %.o
	$(LD) -o $@ -L ${SM64API}/ld --oformat binary -T ldscript $^
