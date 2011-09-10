#ifndef AST_TOKEN_H
#define AST_TOKEN_H

#include <ast.h>


/** Create an integer ast leaf.
 *
 * @param type      fourcc code for the ast leaf
 * @param buf       The memory which needs to be copied.
 * @param buf_size  The amount of memory to be copied.
 */
ast_node_t *ast_leaf(uint32_t type, void *buf, size_t buf_size);

ast_t ast_real(char *buf, size_t buf_size);
ast_t ast_int(char *buf, size_t buf_size);
ast_t ast_string(char *buf, size_t buf_size);
ast_t ast_raw_string(char *buf, size_t buf_size);
ast_t ast_regex(char *buf, size_t buf_size);
ast_t ast_name(char *buf, size_t buf_size);
ast_t ast_assembly(char *buf, size_t buf_size);

#endif
