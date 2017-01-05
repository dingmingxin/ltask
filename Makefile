SRCS = ltask.c handlemap.c queue.c schedule.c serialize.c

OS = $(shell uname -s)
ifndef LIBFLAG
	ifeq ($(OS),Darwin)
		LIBFLAG=-bundle -undefined dynamic_lookup -all_load
	else
		LIBFLAG=--shared
	endif
endif

macos: ltask.so
linux : ltask.so
mingw : ltask.dll


ltask.so : $(SRCS)
	gcc -Wall -g ${LIBFLAG} -fpic -o$@ $^ -I/opt/local/include -lpthread

ltask.dll : $(SRCS)
	gcc -Wall -g --shared -o $@ $^ -I/usr/local/include -L/usr/local/bin -llua53

clean :
	rm -f ltask.so ltask.dll
