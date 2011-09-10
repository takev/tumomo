
#include <stdlib.h>
#include <inttypes.h>
#include <stdint.h>
#include <math.h>
#include <limits.h>
#include <errno.h>
#include <unistd.h>
#include <string.h>
#include <stdarg.h>
#include <ast_token.h>

typedef union {
    double      d;
    uint64_t    u;
    int64_t     i;
} translate_t;

ast_t ast_token(uint32_t type, void *buf, size_t buf_size)
{
    ast_t r;

    r.node = malloc(AST_LEAF_SIZE + align_size(buf_size));
    r.start = r.node->leaf.start = previous_position;
    r.end = r.node->leaf.end = current_position;
    self->size = buf_size;
    self->type = type;
    memcpy(self->leaf.data, buf, AST_LEAF_SIZE + buf_size);
    return r;
}

ast_t ast_real(char *buf, size_t buf_size)
{
    translate_t t;
    char        *endptr;

    t.d = strtold(buf, &endptr);
    if (buf == endptr) {
        ast_error("Could not convert real value '%s'", buf);
        abort();
    }

    if ((t.d == HUGE_VALL || t.d == -HUGE_VALL) && errno == ERANGE) {
        ast_error("Could not convert real value '%s', overflow", buf);
        abort();
    }

    if ((t.d == 0.0 || t.d == -0.0) && errno == ERANGE) {
        ast_error("Could not convert real value '%s', underflow", buf);
        abort();
    }

    return ast_token('real', &t.u, sizeof (t.u));
}

ast_t ast_int(char *buf, size_t buf_size)
{
    int         i = 0;
    int         negative = 0;
    int         base = 10;
    char        *endptr;
    translate_t t;

    switch (buf[i]) {
    case '-': i++; negative = 1; break;
    case '+': i++; negative = 0; break;
    }

    if (buf[i] == '0') {
        i++;
        base = 8;
        switch (buf[i]) {
        case 'x': case 'X': i++; base = 16; break;
        case 'd': case 'D': i++; base = 10; break;
        case 'o': case 'O': i++; base =  8; break;
        case 'b': case 'B': i++; base =  2; break;
        }
    }

    t.u = strtoull(&buf[i], &endptr, base);
    if (&buf[i] == endptr) {
        ast_error("Could not convert int value '%s'", buf);
        abort();
    }
    if (t.u == ULLONG_MAX && errno == ERANGE) {
        ast_error("Could not convert int value '%s', overflow", buf);
        abort();
    }

    if (negative) {
        if (t.u > INT64_MAX) {
            ast_error("Could not convert int value '%s', overflow", buf);
            abort();
        }
        t.i = -t.u;
    }

    return ast_token(negative ? 'int ' : 'uint', &t.u, sizeof (t.u));
}

static ast_t ast_generic_string(char *buf, size_t buf_size, uint32_t type, int raw)
{
    ast_t       r;
    uint32_t    *string = malloc(buf_size * sizeof (uint32_t));
    size_t      string_size = utf8_to_ucs4(buf, buf_size, string);

    string_size = escape_string(string, string_size, raw);
    r = ast_token(type, string, string_size * sizeof (uint32_t));
    free(string);

    return r;
}

ast_t ast_string(char *buf, size_t buf_size)
{
    return ast_generic_string(buf, buf_size, 'str ', 0);
}

ast_t ast_raw_string(char *buf, size_t buf_size)
{
    return ast_generic_string(buf, buf_size, 'str ', 1);
}

ast_t ast_regex(char *buf, size_t buf_size)
{
    return ast_generic_string(buf, buf_size, 'regx', 2);
}

ast_t ast_name(char *buf, size_t buf_size)
{
    return ast_generic_string(buf, buf_size, 'name', 1);
}

ast_t ast_assembly(char *buf, size_t buf_size)
{
    return ast_generic_string(buf, buf_size, 'asm ', 1);
}

