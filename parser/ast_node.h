#ifndef AST_NODE_H
#define AST_NODE_H

#include <ast.h>

/** Create an empty node.
 * It denotes an empty node.
 *
 * @returns     A new AST PASS.
 */
ast_t ast_pass(void);

/** Create an end node.
 * This is a sentinal which should be passed as the last parameter of
 * ast_node() or ast_list()
 *
 * @returns     A new AST PASS.
 */
ast_t ast_end(void);

/** Create an ast node.
 * Create a node from subnodes.
 * This also free memory used by the subnodes.
 *
 * @param type  fourcc code for the ast node
 *              When type is '----' the header is not preserved when used as subnode.
 * @param ...   The subnodes, ending with NULL
 * @returns     A new AST NODE.
 */
ast_t ast_node(ast_t start, ast_t end, uint32_t type, ...);

/** Create an ast node.
 * Create a list of subnodes, when included in a list or node, it expands as if the contents
 * was passed as seperate items.
 * This also free memory used by the subnodes.
 *
 * @param ...   The subnodes, ending with NULL
 * @returns     A new AST NODE.
 */
ast_t ast_list(ast_t start, ast_t end, ...);

/** Count characters.
 * This functions keeps track of byte position, line and column.
 * The byte, line and columns are zero index.
 * This function works with UTF-8.
 *
 * @param s         The string to analyze
 * @param s_length  The length of the string in bytes.
 * @returns         An initialized ast structure without a node.
 */
ast_t ast_count(char *s, size_t s_length);

#define PASS                            ast_pass()
#define END                             ast_end()
#define NODE(first, last, type, ...)    ast_node(first, last, type, ##__VA_ARGS__, END)
#define LIST(first, last, ...)          ast_list(first, last, ##__VA_ARGS__, END)

#endif
