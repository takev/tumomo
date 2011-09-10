#ifndef LEXERPARSER_H
#define LEXERPARSER_H

extern "C" {
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>
#include <string.h>
}
#include <string>

typedef struct tonu_context_s {
    void                    *yyscanner;            // Pointer to flex state.

    std::string             filename;              // File where the buffer comes from.
    const char              *buffer;               // Pointer to text
    size_t                  buffer_length;         // Size of text in bytes.
    off_t                   buffer_position;       // Current buffer position.
    tonu::ast_location_t    location;              // Location where the token is found in the text.
    tonu::ASTStatementList  *statements;           // Return value after yyparse.
    bool                    error;                 // If there was an error.
    std::string             error_message;         // The error message.
} tonu_context_t;

#endif
