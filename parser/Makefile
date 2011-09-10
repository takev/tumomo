
CFLAGS=-Wall -pedantic

all:: ast.o ast_count.o

.c.o:
	gcc $(CFLAGS) -c $<

ast.o: ast.c ast.h
ast_count.o: ast_count.c ast_count.h ast.h

