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
     END = 0,
     KEYWORD_AND = 258,
     KEYWORD_BEGIN = 259,
     KEYWORD_CONST = 260,
     KEYWORD_DIV = 261,
     KEYWORD_DO = 262,
     KEYWORD_DOWNTO = 263,
     KEYWORD_ELSE = 264,
     KEYWORD_ARRAY = 265,
     KEYWORD_END = 266,
     KEYWORD_FOR = 267,
     KEYWORD_FORWARD = 268,
     KEYWORD_FUNCTION = 269,
     KEYWORD_IF = 270,
     KEYWORD_MOD = 271,
     KEYWORD_NOT = 272,
     KEYWORD_OF = 273,
     KEYWORD_PROGRAM = 274,
     KEYWORD_PROCEDURE = 275,
     KEYWORD_RECORD = 276,
     KEYWORD_THEN = 277,
     KEYWORD_TO = 278,
     KEYWORD_TYPE = 279,
     KEYWORD_VAR = 280,
     KEYWORD_WHILE = 281,
     IDENTIFIER = 282,
     STRING_LITERAL = 283,
     OP_ASSIGN = 284,
     INT = 285,
     DECIMAL = 286,
     EXP = 287,
     OP_EQ = 288,
     OP_NEQ = 289,
     OP_GE = 290,
     OP_GT = 291,
     OP_LT = 292,
     OP_LE = 293,
     OP_ADD = 294,
     OP_SUB = 295,
     OP_MUL = 296,
     OP_DIV = 297,
     OP_RANGE = 298,
     DOT = 299,
     COMMA = 300,
     SEMICOLON = 301,
     LPAREN = 302,
     RPAREN = 303,
     COLON = 304,
     LBRACKET = 305,
     RBRACKET = 306,
     INVALID_CHAR = 307,
     UNTERMINATED_COMMENT = 308,
     UNTERMINATED_QUOTE = 309,
     LOWER_THAN_ELSE = 310
   };
#endif
/* Tokens.  */
#define END 0
#define KEYWORD_AND 258
#define KEYWORD_BEGIN 259
#define KEYWORD_CONST 260
#define KEYWORD_DIV 261
#define KEYWORD_DO 262
#define KEYWORD_DOWNTO 263
#define KEYWORD_ELSE 264
#define KEYWORD_ARRAY 265
#define KEYWORD_END 266
#define KEYWORD_FOR 267
#define KEYWORD_FORWARD 268
#define KEYWORD_FUNCTION 269
#define KEYWORD_IF 270
#define KEYWORD_MOD 271
#define KEYWORD_NOT 272
#define KEYWORD_OF 273
#define KEYWORD_PROGRAM 274
#define KEYWORD_PROCEDURE 275
#define KEYWORD_RECORD 276
#define KEYWORD_THEN 277
#define KEYWORD_TO 278
#define KEYWORD_TYPE 279
#define KEYWORD_VAR 280
#define KEYWORD_WHILE 281
#define IDENTIFIER 282
#define STRING_LITERAL 283
#define OP_ASSIGN 284
#define INT 285
#define DECIMAL 286
#define EXP 287
#define OP_EQ 288
#define OP_NEQ 289
#define OP_GE 290
#define OP_GT 291
#define OP_LT 292
#define OP_LE 293
#define OP_ADD 294
#define OP_SUB 295
#define OP_MUL 296
#define OP_DIV 297
#define OP_RANGE 298
#define DOT 299
#define COMMA 300
#define SEMICOLON 301
#define LPAREN 302
#define RPAREN 303
#define COLON 304
#define LBRACKET 305
#define RBRACKET 306
#define INVALID_CHAR 307
#define UNTERMINATED_COMMENT 308
#define UNTERMINATED_QUOTE 309
#define LOWER_THAN_ELSE 310




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

