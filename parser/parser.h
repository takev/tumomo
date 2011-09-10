/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     T_DEF = 258,
     T_CLASS = 259,
     T_PACKAGE = 260,
     T_IMPORT = 261,
     T_AS = 262,
     T_FROM = 263,
     T_SYNC = 264,
     T_READ_ONLY = 265,
     T_THREAD_SAFE = 266,
     T_IF = 267,
     T_ELSE = 268,
     T_ELSE_IF = 269,
     T_WHILE = 270,
     T_DO = 271,
     T_FOR = 272,
     T_BREAK = 273,
     T_CONTINUE = 274,
     T_RETURN = 275,
     T_RAISE = 276,
     T_TRY = 277,
     T_CASE = 278,
     T_EXCEPT = 279,
     T_FINALLY = 280,
     T_SPAWN = 281,
     T_WAIT = 282,
     T_LAMBDA = 283,
     T_NAME = 284,
     T_LITERAL = 285,
     T_ASSEMBLY = 286,
     T_INCREMENT = 287,
     T_DECREMENT = 288,
     T_EQ = 289,
     T_NE = 290,
     T_LE = 291,
     T_GE = 292,
     T_POW = 293,
     T_DIV_FLOOR = 294,
     T_MOD_FLOOR = 295,
     T_SHL = 296,
     T_SHR = 297,
     T_LOGICAL_AND = 298,
     T_LOGICAL_OR = 299,
     T_LOGICAL_XOR = 300,
     T_LOGICAL_NOT = 301,
     T_INPLACE_ADD = 302,
     T_INPLACE_SUB = 303,
     T_INPLACE_MUL = 304,
     T_INPLACE_DIV = 305,
     T_INPLACE_MOD = 306,
     T_INPLACE_AND = 307,
     T_INPLACE_OR = 308,
     T_INPLACE_XOR = 309,
     T_INPLACE_POW = 310,
     T_INPLACE_DIV_FLOOR = 311,
     T_INPLACE_MOD_FLOOR = 312,
     T_INPLACE_SHL = 313,
     T_INPLACE_SHR = 314,
     T_INPLACE_COPY = 315,
     T_IN = 316,
     T_IS = 317,
     T_ISA = 318,
     T_UNKNOWN = 319,
     LENGTH = 320,
     UMINUS = 321,
     LAMBDA = 322,
     TERTARY = 323
   };
#endif
/* Tokens.  */
#define T_DEF 258
#define T_CLASS 259
#define T_PACKAGE 260
#define T_IMPORT 261
#define T_AS 262
#define T_FROM 263
#define T_SYNC 264
#define T_READ_ONLY 265
#define T_THREAD_SAFE 266
#define T_IF 267
#define T_ELSE 268
#define T_ELSE_IF 269
#define T_WHILE 270
#define T_DO 271
#define T_FOR 272
#define T_BREAK 273
#define T_CONTINUE 274
#define T_RETURN 275
#define T_RAISE 276
#define T_TRY 277
#define T_CASE 278
#define T_EXCEPT 279
#define T_FINALLY 280
#define T_SPAWN 281
#define T_WAIT 282
#define T_LAMBDA 283
#define T_NAME 284
#define T_LITERAL 285
#define T_ASSEMBLY 286
#define T_INCREMENT 287
#define T_DECREMENT 288
#define T_EQ 289
#define T_NE 290
#define T_LE 291
#define T_GE 292
#define T_POW 293
#define T_DIV_FLOOR 294
#define T_MOD_FLOOR 295
#define T_SHL 296
#define T_SHR 297
#define T_LOGICAL_AND 298
#define T_LOGICAL_OR 299
#define T_LOGICAL_XOR 300
#define T_LOGICAL_NOT 301
#define T_INPLACE_ADD 302
#define T_INPLACE_SUB 303
#define T_INPLACE_MUL 304
#define T_INPLACE_DIV 305
#define T_INPLACE_MOD 306
#define T_INPLACE_AND 307
#define T_INPLACE_OR 308
#define T_INPLACE_XOR 309
#define T_INPLACE_POW 310
#define T_INPLACE_DIV_FLOOR 311
#define T_INPLACE_MOD_FLOOR 312
#define T_INPLACE_SHL 313
#define T_INPLACE_SHR 314
#define T_INPLACE_COPY 315
#define T_IN 316
#define T_IS 317
#define T_ISA 318
#define T_UNKNOWN 319
#define LENGTH 320
#define UMINUS 321
#define LAMBDA 322
#define TERTARY 323




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 72 "parser.yxx"
{
    tonu::ASTName                *name;
    tonu::ASTNameList            *name_list;
    tonu::ASTFQName              *fqname;
    tonu::ASTFQNameList          *fqname_list;
    tonu::ASTLiteral             *literal;
    tonu::ASTStringLiteral       *string_literal;
    tonu::ASTItem                *item;
    tonu::ASTItemList            *item_list;
    tonu::ASTExpression          *expression;
    tonu::ASTStatementList       *statement_list;
    tonu::ASTStatement           *statement;
    tonu::ASTIfStatement         *if_statement;
    tonu::ASTExceptionStatement  *exception_statement;

    tonu::AST                    *ast;
}
/* Line 1529 of yacc.c.  */
#line 203 "parser.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif



#if ! defined YYLTYPE && ! defined YYLTYPE_IS_DECLARED
typedef struct YYLTYPE
{
  int first_line;
  int first_column;
  int last_line;
  int last_column;
} YYLTYPE;
# define yyltype YYLTYPE /* obsolescent; will be withdrawn */
# define YYLTYPE_IS_DECLARED 1
# define YYLTYPE_IS_TRIVIAL 1
#endif


