#ifndef AST_H
#define AST_H

#include <stddef.h>
#include <stdlib.h>
#include <stdint.h>

typedef struct {
    int32_t         position;
    int32_t         line;
    int32_t         column;
} ast_position_t;

typedef struct {
    uint32_t        size;
    uint32_t        type;
    ast_position_t  start;
    ast_position_t  end;
    uint32_t        data[0];
} ast_node_t;

typedef struct {
    ast_position_t  start;
    ast_position_t  end;
    ast_node_t      *node;
} ast_t;

#endif
