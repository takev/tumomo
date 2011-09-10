#ifndef AST_COUNT_H
#define AST_COUNT_H

#include <ast.h>

extern ast_position_t previous_position;
extern ast_position_t current_position;

ast_t ast_count(char *s, size_t s_length);

#endif
