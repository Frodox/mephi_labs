CFLAGS	=	-Wall -Wextra -std=c99 -D_XOPEN_SOURCE=600
CC	=	gcc

all: millioner_server  millioner_client

millioner_server: helper.o
	${CC} ${CFLAGS} helper.o millioner-server.c -o millioner-server 

millioner_client: helper.o
	${CC} ${CFLAGS} helper.o millioner-client.c -o millioner-client

helper.o: helper.c helper.h
	${CC} ${CFLAGS} -c helper.c

clean:
	rm -rf *.o
