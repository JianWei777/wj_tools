CC = gcc

SFLAGS = -c
DFLAGS = fpic -shared

PLATFORM = ../../

LIBS = -L../libs
INCLUDE += -I../../


ifeq ($(debug),1)
	CFLAGS += -g -fgnu89-inline -Wno-misleding-indentation	
else ifeq ($(releas),1)
	CFLAGS += -O2 -fno-strict-aliasing -fgnu89-inline -Wno-misleding-indentation
else ifeq ($(error-check),1)
	CFLAGS += -ggdb  -g3 -gdwarf-2 -g -Wno-misleding-indentation -fgnu89-inline
endif

TARGET = mydemo
SRC = $(wildcard *.c) $(wildcard *.cpp)
OBJ = $(patsubst %.c,%.o,$(SRC))
		
%.o:%.c
	$(ECHO) $(CC) -c  $(CFLAGS) $(INCLUDE) $< -o $@

$(TARGET):$(OBJ)
	$(CC) -o $(TARGET)   $(OBJ) $(CFLAGS) $(INCLUDE) $(LIBS)

.PHONY : clean
clean:
	rm -f *.o	
	rm $(TARGET)	
