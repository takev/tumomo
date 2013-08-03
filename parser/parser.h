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
     T_CLASS = 258,
     T_SELF = 259,
     T_IMPORT = 260,
     T_AS = 261,
     T_SYNC = 262,
     T_IF = 263,
     T_ELSE = 264,
     T_ELSE_IF = 265,
     T_WHILE = 266,
     T_DO = 267,
     T_FOR = 268,
     T_BREAK = 269,
     T_CONTINUE = 270,
     T_RETURN = 271,
     T_RAISE = 272,
     T_TRY = 273,
     T_CASE = 274,
     T_EXCEPT = 275,
     T_FINALLY = 276,
     T_SPAWN = 277,
     T_WAIT = 278,
     T_LAMBDA = 279,
     T_NAME = 280,
     T_REAL = 281,
     T_INTEGER = 282,
     T_STRING = 283,
     T_REGEX = 284,
     T_ASSEMBLY = 285,
     T_EQ = 286,
     T_NE = 287,
     T_LE = 288,
     T_GE = 289,
     T_POW = 290,
     T_DIV_FLOOR = 291,
     T_MOD_FLOOR = 292,
     T_SHL = 293,
     T_SHR = 294,
     T_LOGICAL_AND = 295,
     T_LOGICAL_OR = 296,
     T_LOGICAL_XOR = 297,
     T_LOGICAL_NOT = 298,
     T_INPLACE_ADD = 299,
     T_INPLACE_SUB = 300,
     T_INPLACE_MUL = 301,
     T_INPLACE_DIV = 302,
     T_INPLACE_MOD = 303,
     T_INPLACE_AND = 304,
     T_INPLACE_OR = 305,
     T_INPLACE_XOR = 306,
     T_INPLACE_POW = 307,
     T_INPLACE_DIV_FLOOR = 308,
     T_INPLACE_MOD_FLOOR = 309,
     T_INPLACE_SHL = 310,
     T_INPLACE_SHR = 311,
     T_INPLACE_COPY = 312,
     T_ATTRIBUTE = 313,
     T_IN = 314,
     T_IS = 315,
     T_ISA = 316,
     T_UNKNOWN = 317,
     P_LENGTH = 318,
     P_UMINUS = 319,
     P_LAMBDA = 320,
     P_TERTARY = 321,
     P_ASSIGN = 322
   };
#endif
/* Tokens.  */
#define T_CLASS 258
#define T_SELF 259
#define T_IMPORT 260
#define T_AS 261
#define T_SYNC 262
#define T_IF 263
#define T_ELSE 264
#define T_ELSE_IF 265
#define T_WHILE 266
#define T_DO 267
#define T_FOR 268
#define T_BREAK 269
#define T_CONTINUE 270
#define T_RETURN 271
#define T_RAISE 272
#define T_TRY 273
#define T_CASE 274
#define T_EXCEPT 275
#define T_FINALLY 276
#define T_SPAWN 277
#define T_WAIT 278
#define T_LAMBDA 279
#define T_NAME 280
#define T_REAL 281
#define T_INTEGER 282
#define T_STRING 283
#define T_REGEX 284
#define T_ASSEMBLY 285
#define T_EQ 286
#define T_NE 287
#define T_LE 288
#define T_GE 289
#define T_POW 290
#define T_DIV_FLOOR 291
#define T_MOD_FLOOR 292
#define T_SHL 293
#define T_SHR 294
#define T_LOGICAL_AND 295
#define T_LOGICAL_OR 296
#define T_LOGICAL_XOR 297
#define T_LOGICAL_NOT 298
#define T_INPLACE_ADD 299
#define T_INPLACE_SUB 300
#define T_INPLACE_MUL 301
#define T_INPLACE_DIV 302
#define T_INPLACE_MOD 303
#define T_INPLACE_AND 304
#define T_INPLACE_OR 305
#define T_INPLACE_XOR 306
#define T_INPLACE_POW 307
#define T_INPLACE_DIV_FLOOR 308
#define T_INPLACE_MOD_FLOOR 309
#define T_INPLACE_SHL 310
#define T_INPLACE_SHR 311
#define T_INPLACE_COPY 312
#define T_ATTRIBUTE 313
#define T_IN 314
#define T_IS 315
#define T_ISA 316
#define T_UNKNOWN 317
#define P_LENGTH 318
#define P_UMINUS 319
#define P_LAMBDA 320
#define P_TERTARY 321
#define P_ASSIGN 322




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

