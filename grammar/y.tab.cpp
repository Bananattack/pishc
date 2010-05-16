/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton implementation for Bison's Yacc-like parsers in C

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

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "2.3"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Using locations.  */
#define YYLSP_NEEDED 0



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




/* Copy the first part of user declarations.  */
#line 6 "grammar/pishc.y"


#include <string.h>
#include <fstream>
#include <iostream>
    
#include "common.h"



/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 1
#endif

/* Enabling the token table.  */
#ifndef YYTOKEN_TABLE
# define YYTOKEN_TABLE 0
#endif

#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif



/* Copy the second part of user declarations.  */


/* Line 216 of yacc.c.  */
#line 228 "grammar/y.tab.cpp"

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#elif (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
typedef signed char yytype_int8;
#else
typedef short int yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(msgid) dgettext ("bison-runtime", msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(msgid) msgid
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(e) ((void) (e))
#else
# define YYUSE(e) /* empty */
#endif

/* Identity function, used to suppress warnings about constant conditions.  */
#ifndef lint
# define YYID(n) (n)
#else
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static int
YYID (int i)
#else
static int
YYID (i)
    int i;
#endif
{
  return i;
}
#endif

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#     ifndef _STDLIB_H
#      define _STDLIB_H 1
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's `empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (YYID (0))
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined _STDLIB_H \
       && ! ((defined YYMALLOC || defined malloc) \
	     && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef _STDLIB_H
#    define _STDLIB_H 1
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
	 || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss;
  YYSTYPE yyvs;
  };

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

/* Copy COUNT objects from FROM to TO.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(To, From, Count) \
      __builtin_memcpy (To, From, (Count) * sizeof (*(From)))
#  else
#   define YYCOPY(To, From, Count)		\
      do					\
	{					\
	  YYSIZE_T yyi;				\
	  for (yyi = 0; yyi < (Count); yyi++)	\
	    (To)[yyi] = (From)[yyi];		\
	}					\
      while (YYID (0))
#  endif
# endif

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack)					\
    do									\
      {									\
	YYSIZE_T yynewbytes;						\
	YYCOPY (&yyptr->Stack, Stack, yysize);				\
	Stack = &yyptr->Stack;						\
	yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
	yyptr += yynewbytes / sizeof (*yyptr);				\
      }									\
    while (YYID (0))

#endif

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  5
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   291

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  56
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  42
/* YYNRULES -- Number of rules.  */
#define YYNRULES  114
/* YYNRULES -- Number of states.  */
#define YYNSTATES  229

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   310

#define YYTRANSLATE(YYX)						\
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46,    47,    48,    49,    50,    51,    52,    53,    54,
      55
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const yytype_uint16 yyprhs[] =
{
       0,     0,     3,     9,    15,    19,    21,    24,    27,    28,
      30,    32,    34,    36,    39,    42,    45,    47,    51,    54,
      59,    62,    66,    69,    73,    76,    80,    82,    86,    89,
      92,    94,    98,   101,   106,   108,   111,   120,   127,   131,
     135,   139,   142,   145,   147,   148,   152,   155,   158,   160,
     164,   167,   171,   174,   179,   184,   186,   188,   190,   192,
     197,   204,   209,   219,   229,   231,   232,   236,   238,   242,
     246,   250,   254,   258,   262,   264,   268,   272,   274,   278,
     282,   286,   290,   294,   296,   299,   302,   305,   307,   310,
     315,   317,   319,   323,   325,   326,   331,   335,   339,   342,
     344,   353,   357,   359,   361,   363,   366,   369,   371,   373,
     376,   379,   381,   383,   385
};

/* YYRHS -- A `-1'-separated list of the rules' RHS.  */
static const yytype_int8 yyrhs[] =
{
      57,     0,    -1,    19,    58,    61,    60,    44,    -1,    27,
      47,    59,    48,    46,    -1,    59,    45,    27,    -1,    27,
      -1,     4,    78,    -1,    61,    62,    -1,    -1,    66,    -1,
      63,    -1,    70,    -1,    73,    -1,     1,    46,    -1,     5,
      64,    -1,    64,    65,    -1,    65,    -1,    64,     1,    46,
      -1,     1,    46,    -1,    27,    33,    94,    46,    -1,    25,
      67,    -1,    67,    68,    46,    -1,    68,    46,    -1,    67,
       1,    46,    -1,     1,    46,    -1,    68,    45,    69,    -1,
      69,    -1,    59,    49,    93,    -1,    24,    71,    -1,    71,
      72,    -1,    72,    -1,    71,     1,    46,    -1,     1,    46,
      -1,    27,    33,    93,    46,    -1,    74,    -1,    75,    76,
      -1,    14,    27,    47,    77,    48,    49,    97,    46,    -1,
      20,    27,    47,    77,    48,    46,    -1,    14,     1,    46,
      -1,    20,     1,    46,    -1,    61,    60,    46,    -1,    13,
      46,    -1,     1,    46,    -1,    68,    -1,    -1,    79,    80,
      11,    -1,    80,    11,    -1,     1,    11,    -1,    11,    -1,
      79,    80,    46,    -1,    80,    46,    -1,    79,     1,    46,
      -1,     1,    46,    -1,    27,    91,    29,    86,    -1,    27,
      47,    84,    48,    -1,    81,    -1,    60,    -1,    82,    -1,
      83,    -1,    15,    86,    22,    80,    -1,    15,    86,    22,
      80,     9,    80,    -1,    26,    86,     7,    80,    -1,    12,
      27,    91,    29,    86,    23,    86,     7,    80,    -1,    12,
      27,    91,    29,    86,     8,    86,     7,    80,    -1,    85,
      -1,    -1,    85,    45,    86,    -1,    86,    -1,    86,    33,
      87,    -1,    86,    34,    87,    -1,    86,    35,    87,    -1,
      86,    36,    87,    -1,    86,    38,    87,    -1,    86,    37,
      87,    -1,    87,    -1,    87,    39,    88,    -1,    87,    40,
      88,    -1,    88,    -1,    88,    41,    89,    -1,    88,    42,
      89,    -1,    88,     6,    89,    -1,    88,    16,    89,    -1,
      88,     3,    89,    -1,    89,    -1,    39,    89,    -1,    40,
      89,    -1,    17,    89,    -1,    90,    -1,    27,    91,    -1,
      27,    47,    84,    48,    -1,    96,    -1,    28,    -1,    47,
      86,    48,    -1,    92,    -1,    -1,    92,    50,    86,    51,
      -1,    92,    44,    27,    -1,    50,    86,    51,    -1,    44,
      27,    -1,    27,    -1,    10,    50,    95,    43,    95,    51,
      18,    93,    -1,    21,    67,    11,    -1,    96,    -1,    27,
      -1,    28,    -1,    40,    96,    -1,    40,    27,    -1,    30,
      -1,    27,    -1,    40,    30,    -1,    40,    27,    -1,    30,
      -1,    31,    -1,    32,    -1,    27,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,   128,   128,   144,   153,   158,   171,   181,   187,   196,
     197,   198,   199,   200,   212,   222,   238,   245,   251,   263,
     273,   283,   299,   306,   312,   324,   329,   342,   352,   362,
     378,   385,   391,   403,   413,   424,   435,   439,   443,   449,
     463,   467,   472,   485,   490,   499,   512,   518,   524,   533,
     546,   553,   559,   571,   575,   579,   580,   581,   582,   591,
     595,   605,   614,   627,   646,   651,   660,   665,   679,   683,
     687,   691,   695,   699,   703,   713,   717,   721,   728,   732,
     736,   740,   744,   748,   758,   762,   766,   770,   780,   784,
     788,   792,   796,   806,   811,   819,   824,   829,   835,   847,
     851,   855,   865,   869,   873,   877,   881,   891,   895,   899,
     903,   913,   914,   915,   922
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || YYTOKEN_TABLE
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "\"end-of-file\"", "error", "$undefined", "\"`and`\"", "\"`begin`\"",
  "\"`const`\"", "\"`div`\"", "\"`do`\"", "\"`downto`\"", "\"`else`\"",
  "\"`array`\"", "\"`end`\"", "\"`for`\"", "\"`forward`\"",
  "\"`function`\"", "\"`if`\"", "\"`mod`\"", "\"`not`\"", "\"`of`\"",
  "\"`program`\"", "\"`procedure`\"", "\"`record`\"", "\"`then`\"",
  "\"`to`\"", "\"`type`\"", "\"`var`\"", "\"`while`\"", "\"identifier\"",
  "\"string literal\"", "\"`:=`\"", "\"integer literal\"",
  "\"real decimal literal\"", "\"real exp literal\"", "\"`=`\"",
  "\"`<>`\"", "\"`>=`\"", "\"`>`\"", "\"`<`\"", "\"`<=`\"", "\"`+`\"",
  "\"`-`\"", "\"`*`\"", "\"`/`\"", "\"`..`\"", "\"`.`\"", "\"`,`\"",
  "\"`;`\"", "\"`(`\"", "\"`)`\"", "\"`:`\"", "\"`[`\"", "\"`]`\"",
  "\"invalid character\"", "\"unterminated comment\"",
  "\"unterminated quote\"", "LOWER_THAN_ELSE", "$accept", "program",
  "program_head", "identifier_list", "compound_statement", "decls", "decl",
  "const_decl", "const_definitions", "const_definition", "var_decl",
  "var_expressions_semi", "var_expressions", "var_expression", "type_decl",
  "type_expressions", "type_expression", "subprogram_decl", "subprogram",
  "subprogram_header", "subprogram_body", "parameter_list",
  "statement_list", "statement_list_", "statement", "if_statement",
  "while_statement", "for_statement", "expression_list",
  "expression_list_", "expression", "simple_expression", "term", "factor",
  "lower_factor", "subscripts", "subscripts_", "type_identifier",
  "const_expression", "array_dim_expression", "real", "return_type", 0
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
   token YYLEX-NUM.  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299,   300,   301,   302,   303,   304,
     305,   306,   307,   308,   309,   310
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    56,    57,    58,    59,    59,    60,    61,    61,    62,
      62,    62,    62,    62,    63,    64,    64,    64,    64,    65,
      66,    67,    67,    67,    67,    68,    68,    69,    70,    71,
      71,    71,    71,    72,    73,    74,    75,    75,    75,    75,
      76,    76,    76,    77,    77,    78,    78,    78,    78,    79,
      79,    79,    79,    80,    80,    80,    80,    80,    80,    81,
      81,    82,    83,    83,    84,    84,    85,    85,    86,    86,
      86,    86,    86,    86,    86,    87,    87,    87,    88,    88,
      88,    88,    88,    88,    89,    89,    89,    89,    90,    90,
      90,    90,    90,    91,    91,    92,    92,    92,    92,    93,
      93,    93,    94,    94,    94,    94,    94,    95,    95,    95,
      95,    96,    96,    96,    97
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     5,     5,     3,     1,     2,     2,     0,     1,
       1,     1,     1,     2,     2,     2,     1,     3,     2,     4,
       2,     3,     2,     3,     2,     3,     1,     3,     2,     2,
       1,     3,     2,     4,     1,     2,     8,     6,     3,     3,
       3,     2,     2,     1,     0,     3,     2,     2,     1,     3,
       2,     3,     2,     4,     4,     1,     1,     1,     1,     4,
       6,     4,     9,     9,     1,     0,     3,     1,     3,     3,
       3,     3,     3,     3,     1,     3,     3,     1,     3,     3,
       3,     3,     3,     1,     2,     2,     2,     1,     2,     4,
       1,     1,     3,     1,     0,     4,     3,     3,     2,     1,
       8,     3,     1,     1,     1,     2,     2,     1,     1,     2,
       2,     1,     1,     1,     1
};

/* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
   STATE-NUM when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,     0,     0,     0,     8,     1,     0,     0,     5,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     7,    10,
       9,    11,    12,    34,     0,     0,     0,    13,     0,    48,
       0,     0,     0,    94,    56,     6,     0,     0,    55,    57,
      58,     0,     0,     0,    16,     0,     0,     0,     0,     0,
       0,     0,    30,     0,     0,     0,     0,    26,     2,     0,
       0,     0,    35,     4,     3,    47,    52,    94,     0,    94,
      91,   111,   112,   113,     0,     0,     0,     0,    74,    77,
      83,    87,    90,     0,     0,    65,     0,     0,    93,     0,
       0,    46,    50,    18,     0,     0,    15,    38,    44,    39,
      44,    32,     0,     0,    29,    24,     0,     0,     0,     0,
      22,    42,    41,     0,     0,    86,    65,    88,    84,    85,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,    98,     0,    64,    67,
       0,     0,     0,     0,    51,    45,    49,   103,   104,     0,
       0,   102,    17,    43,     0,     0,     0,     0,    99,     0,
      31,    27,    23,    21,    25,    40,     0,     0,    92,    59,
      68,    69,    70,    71,    73,    72,    75,    76,    82,    80,
      81,    78,    79,    61,    54,     0,    97,    53,    96,     0,
     106,   105,    19,     0,     0,     0,     0,    33,     0,    89,
       0,    66,    95,     0,    37,   108,   107,     0,     0,   101,
       0,     0,    60,   114,     0,   110,   109,     0,     0,     0,
      36,     0,     0,     0,     0,    63,    62,     0,   100
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,     2,     4,    54,    34,     7,    18,    19,    43,    44,
      20,    55,    56,    57,    21,    51,    52,    22,    23,    24,
      62,   154,    35,    36,    37,    38,    39,    40,   137,   138,
     139,    78,    79,    80,    81,    87,    88,   159,   150,   208,
      82,   214
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -104
static const yytype_int16 yypact[] =
{
      34,     7,    80,    56,  -104,  -104,    16,   212,  -104,   -25,
      70,   181,    23,    27,    28,    30,    31,    79,  -104,  -104,
    -104,  -104,  -104,  -104,   198,    73,    89,  -104,    -4,  -104,
      98,    87,    87,    58,  -104,  -104,   194,    -2,  -104,  -104,
    -104,    92,   127,    13,  -104,   121,   128,   144,   154,   158,
     141,   152,  -104,   159,   -10,   164,   -24,  -104,  -104,   168,
     169,   212,  -104,  -104,  -104,  -104,  -104,    15,    87,   150,
    -104,  -104,  -104,  -104,    87,    87,    87,   211,    24,    10,
    -104,  -104,  -104,    41,   183,    87,    87,   190,    57,   179,
      -1,  -104,  -104,  -104,   131,   184,  -104,  -104,    16,  -104,
      16,  -104,     9,   185,  -104,  -104,     9,   188,    37,    16,
    -104,  -104,  -104,   189,   234,  -104,    87,  -104,  -104,  -104,
     106,    94,    87,    87,    87,    87,    87,    87,    87,    87,
      87,    87,    87,    87,    87,    94,  -104,   216,   220,   217,
      95,    87,   239,    87,  -104,  -104,  -104,  -104,  -104,   197,
     221,  -104,  -104,   223,   222,   224,   219,    31,  -104,   225,
    -104,  -104,  -104,  -104,  -104,  -104,    87,   226,  -104,   264,
      24,    24,    24,    24,    24,    24,    10,    10,  -104,  -104,
    -104,  -104,  -104,  -104,  -104,    87,  -104,   217,  -104,   205,
    -104,  -104,  -104,   227,   229,   143,    14,  -104,   114,  -104,
      94,   217,  -104,   250,  -104,  -104,  -104,    54,   235,  -104,
      87,    87,  -104,  -104,   233,  -104,  -104,   143,    53,    59,
    -104,   230,    94,    94,   262,  -104,  -104,     9,  -104
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -104,  -104,  -104,   276,     1,   259,  -104,  -104,  -104,   241,
    -104,   129,   -51,   176,  -104,  -104,   236,  -104,  -104,  -104,
    -104,   191,  -104,  -104,   -36,  -104,  -104,  -104,   172,  -104,
     -30,   135,   -56,   -63,  -104,    43,  -104,  -103,  -104,    72,
     -88,  -104
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If zero, do what YYDEFACT says.
   If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -29
static const yytype_int16 yytable[] =
{
      90,    77,    83,   161,   108,   115,   151,    65,    17,    91,
     145,   118,   119,   130,    95,   107,   131,   -14,   -14,   156,
      25,   109,   110,    26,    41,   209,   132,   -14,    45,    47,
     157,    49,    53,   -14,     3,    25,   158,   -14,   -14,   106,
      42,     8,    66,     8,    92,   146,   120,   153,   135,   153,
      42,   133,   134,     1,    46,    48,   140,    50,     8,    84,
     222,   191,   113,   128,   129,    86,   223,   178,   179,   180,
     181,   182,   176,   177,   122,   123,   124,   125,   126,   127,
       5,   215,   109,   163,   216,   169,   122,   123,   124,   125,
     126,   127,   122,   123,   124,   125,   126,   127,    11,   183,
      63,   142,    84,     6,    68,    85,    30,   143,    86,    31,
     114,   187,   117,   189,    69,    70,    27,    71,    72,    73,
      32,    33,   210,    58,   228,    67,    74,    75,   122,   123,
     124,   125,   126,   127,    76,    64,   198,   211,    93,   122,
     123,   124,   125,   126,   127,   108,   186,   122,   123,   124,
     125,   126,   127,   103,   168,   201,   -28,   -28,   147,   148,
      94,    71,    72,    73,   212,   107,   -28,    97,   -20,   -20,
     205,   149,   -28,   206,   102,    98,   -28,   -28,   -20,    50,
     218,   219,    28,   207,   -20,    11,   225,   226,   -20,   -20,
      99,     8,    29,    30,    84,    89,    31,   116,    11,    59,
      86,   100,    -8,    -8,   101,   105,    30,    32,    33,    31,
     136,    60,    -8,    10,   111,   112,    11,    12,    -8,   141,
      32,    33,    -8,    -8,   190,   144,    13,    71,    72,    73,
     152,   160,    14,   121,   162,   165,    15,    16,   122,   123,
     124,   125,   126,   127,   122,   123,   124,   125,   126,   127,
     122,   123,   124,   125,   126,   127,   202,   170,   171,   172,
     173,   174,   175,   166,   184,   185,   188,   192,   109,   195,
     193,   197,   194,   200,   199,   204,   203,   213,   217,   220,
     227,   224,     9,    61,    96,   164,   196,   104,   167,   221,
       0,   155
};

static const yytype_int16 yycheck[] =
{
      36,    31,    32,   106,    55,    68,    94,    11,     7,    11,
      11,    74,    75,     3,     1,     1,     6,     4,     5,    10,
      45,    45,    46,    48,     1,    11,    16,    14,     1,     1,
      21,     1,     1,    20,    27,    45,    27,    24,    25,    49,
      27,    27,    46,    27,    46,    46,    76,    98,     7,   100,
      27,    41,    42,    19,    27,    27,    86,    27,    27,    44,
       7,   149,    61,    39,    40,    50,     7,   130,   131,   132,
     133,   134,   128,   129,    33,    34,    35,    36,    37,    38,
       0,    27,    45,    46,    30,   121,    33,    34,    35,    36,
      37,    38,    33,    34,    35,    36,    37,    38,     4,   135,
      27,    44,    44,    47,    17,    47,    12,    50,    50,    15,
      67,   141,    69,   143,    27,    28,    46,    30,    31,    32,
      26,    27,     8,    44,   227,    27,    39,    40,    33,    34,
      35,    36,    37,    38,    47,    46,   166,    23,    46,    33,
      34,    35,    36,    37,    38,   196,    51,    33,    34,    35,
      36,    37,    38,     1,    48,   185,     4,     5,    27,    28,
      33,    30,    31,    32,   200,     1,    14,    46,     4,     5,
      27,    40,    20,    30,    33,    47,    24,    25,    14,    27,
     210,   211,     1,    40,    20,     4,   222,   223,    24,    25,
      46,    27,    11,    12,    44,     1,    15,    47,     4,     1,
      50,    47,     4,     5,    46,    46,    12,    26,    27,    15,
      27,    13,    14,     1,    46,    46,     4,     5,    20,    29,
      26,    27,    24,    25,    27,    46,    14,    30,    31,    32,
      46,    46,    20,    22,    46,    46,    24,    25,    33,    34,
      35,    36,    37,    38,    33,    34,    35,    36,    37,    38,
      33,    34,    35,    36,    37,    38,    51,   122,   123,   124,
     125,   126,   127,    29,    48,    45,    27,    46,    45,    50,
      48,    46,    48,     9,    48,    46,    49,    27,    43,    46,
      18,    51,     6,    24,    43,   109,   157,    51,   116,   217,
      -1,   100
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,    19,    57,    27,    58,     0,    47,    61,    27,    59,
       1,     4,     5,    14,    20,    24,    25,    60,    62,    63,
      66,    70,    73,    74,    75,    45,    48,    46,     1,    11,
      12,    15,    26,    27,    60,    78,    79,    80,    81,    82,
      83,     1,    27,    64,    65,     1,    27,     1,    27,     1,
      27,    71,    72,     1,    59,    67,    68,    69,    44,     1,
      13,    61,    76,    27,    46,    11,    46,    27,    17,    27,
      28,    30,    31,    32,    39,    40,    47,    86,    87,    88,
      89,    90,    96,    86,    44,    47,    50,    91,    92,     1,
      80,    11,    46,    46,    33,     1,    65,    46,    47,    46,
      47,    46,    33,     1,    72,    46,    49,     1,    68,    45,
      46,    46,    46,    60,    91,    89,    47,    91,    89,    89,
      86,    22,    33,    34,    35,    36,    37,    38,    39,    40,
       3,     6,    16,    41,    42,     7,    27,    84,    85,    86,
      86,    29,    44,    50,    46,    11,    46,    27,    28,    40,
      94,    96,    46,    68,    77,    77,    10,    21,    27,    93,
      46,    93,    46,    46,    69,    46,    29,    84,    48,    80,
      87,    87,    87,    87,    87,    87,    88,    88,    89,    89,
      89,    89,    89,    80,    48,    45,    51,    86,    27,    86,
      27,    96,    46,    48,    48,    50,    67,    46,    86,    48,
       9,    86,    51,    49,    46,    27,    30,    40,    95,    11,
       8,    23,    80,    27,    97,    27,    30,    43,    86,    86,
      46,    95,     7,     7,    51,    80,    80,    18,    93
};

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		(-2)
#define YYEOF		0

#define YYACCEPT	goto yyacceptlab
#define YYABORT		goto yyabortlab
#define YYERROR		goto yyerrorlab


/* Like YYERROR except do call yyerror.  This remains here temporarily
   to ease the transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  */

#define YYFAIL		goto yyerrlab

#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)					\
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    {								\
      yychar = (Token);						\
      yylval = (Value);						\
      yytoken = YYTRANSLATE (yychar);				\
      YYPOPSTACK (1);						\
      goto yybackup;						\
    }								\
  else								\
    {								\
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;							\
    }								\
while (YYID (0))


#define YYTERROR	1
#define YYERRCODE	256


/* YYLLOC_DEFAULT -- Set CURRENT to span from RHS[1] to RHS[N].
   If N is 0, then set CURRENT to the empty location which ends
   the previous symbol: RHS[0] (always defined).  */

#define YYRHSLOC(Rhs, K) ((Rhs)[K])
#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)				\
    do									\
      if (YYID (N))                                                    \
	{								\
	  (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;	\
	  (Current).first_column = YYRHSLOC (Rhs, 1).first_column;	\
	  (Current).last_line    = YYRHSLOC (Rhs, N).last_line;		\
	  (Current).last_column  = YYRHSLOC (Rhs, N).last_column;	\
	}								\
      else								\
	{								\
	  (Current).first_line   = (Current).last_line   =		\
	    YYRHSLOC (Rhs, 0).last_line;				\
	  (Current).first_column = (Current).last_column =		\
	    YYRHSLOC (Rhs, 0).last_column;				\
	}								\
    while (YYID (0))
#endif


/* YY_LOCATION_PRINT -- Print the location on the stream.
   This macro was not mandated originally: define only if we know
   we won't break user code: when these are the locations we know.  */

#ifndef YY_LOCATION_PRINT
# if YYLTYPE_IS_TRIVIAL
#  define YY_LOCATION_PRINT(File, Loc)			\
     fprintf (File, "%d.%d-%d.%d",			\
	      (Loc).first_line, (Loc).first_column,	\
	      (Loc).last_line,  (Loc).last_column)
# else
#  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
# endif
#endif


/* YYLEX -- calling `yylex' with the right arguments.  */

#ifdef YYLEX_PARAM
# define YYLEX yylex (YYLEX_PARAM)
#else
# define YYLEX yylex ()
#endif

/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)			\
do {						\
  if (yydebug)					\
    YYFPRINTF Args;				\
} while (YYID (0))

# define YY_SYMBOL_PRINT(Title, Type, Value, Location)			  \
do {									  \
  if (yydebug)								  \
    {									  \
      YYFPRINTF (stderr, "%s ", Title);					  \
      yy_symbol_print (stderr,						  \
		  Type, Value); \
      YYFPRINTF (stderr, "\n");						  \
    }									  \
} while (YYID (0))


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_value_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# else
  YYUSE (yyoutput);
# endif
  switch (yytype)
    {
      default:
	break;
    }
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (yytype < YYNTOKENS)
    YYFPRINTF (yyoutput, "token %s (", yytname[yytype]);
  else
    YYFPRINTF (yyoutput, "nterm %s (", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_stack_print (yytype_int16 *bottom, yytype_int16 *top)
#else
static void
yy_stack_print (bottom, top)
    yytype_int16 *bottom;
    yytype_int16 *top;
#endif
{
  YYFPRINTF (stderr, "Stack now");
  for (; bottom <= top; ++bottom)
    YYFPRINTF (stderr, " %d", *bottom);
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)				\
do {								\
  if (yydebug)							\
    yy_stack_print ((Bottom), (Top));				\
} while (YYID (0))


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_reduce_print (YYSTYPE *yyvsp, int yyrule)
#else
static void
yy_reduce_print (yyvsp, yyrule)
    YYSTYPE *yyvsp;
    int yyrule;
#endif
{
  int yynrhs = yyr2[yyrule];
  int yyi;
  unsigned long int yylno = yyrline[yyrule];
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
	     yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      fprintf (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr, yyrhs[yyprhs[yyrule] + yyi],
		       &(yyvsp[(yyi + 1) - (yynrhs)])
		       		       );
      fprintf (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)		\
do {					\
  if (yydebug)				\
    yy_reduce_print (yyvsp, Rule); \
} while (YYID (0))

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef	YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif



#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static YYSIZE_T
yystrlen (const char *yystr)
#else
static YYSIZE_T
yystrlen (yystr)
    const char *yystr;
#endif
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static char *
yystpcpy (char *yydest, const char *yysrc)
#else
static char *
yystpcpy (yydest, yysrc)
    char *yydest;
    const char *yysrc;
#endif
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
	switch (*++yyp)
	  {
	  case '\'':
	  case ',':
	    goto do_not_strip_quotes;

	  case '\\':
	    if (*++yyp != '\\')
	      goto do_not_strip_quotes;
	    /* Fall through.  */
	  default:
	    if (yyres)
	      yyres[yyn] = *yyp;
	    yyn++;
	    break;

	  case '"':
	    if (yyres)
	      yyres[yyn] = '\0';
	    return yyn;
	  }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into YYRESULT an error message about the unexpected token
   YYCHAR while in state YYSTATE.  Return the number of bytes copied,
   including the terminating null byte.  If YYRESULT is null, do not
   copy anything; just return the number of bytes that would be
   copied.  As a special case, return 0 if an ordinary "syntax error"
   message will do.  Return YYSIZE_MAXIMUM if overflow occurs during
   size calculation.  */
static YYSIZE_T
yysyntax_error (char *yyresult, int yystate, int yychar)
{
  int yyn = yypact[yystate];

  if (! (YYPACT_NINF < yyn && yyn <= YYLAST))
    return 0;
  else
    {
      int yytype = YYTRANSLATE (yychar);
      YYSIZE_T yysize0 = yytnamerr (0, yytname[yytype]);
      YYSIZE_T yysize = yysize0;
      YYSIZE_T yysize1;
      int yysize_overflow = 0;
      enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
      char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
      int yyx;

# if 0
      /* This is so xgettext sees the translatable formats that are
	 constructed on the fly.  */
      YY_("syntax error, unexpected %s");
      YY_("syntax error, unexpected %s, expecting %s");
      YY_("syntax error, unexpected %s, expecting %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s");
# endif
      char *yyfmt;
      char const *yyf;
      static char const yyunexpected[] = "syntax error, unexpected %s";
      static char const yyexpecting[] = ", expecting %s";
      static char const yyor[] = " or %s";
      char yyformat[sizeof yyunexpected
		    + sizeof yyexpecting - 1
		    + ((YYERROR_VERBOSE_ARGS_MAXIMUM - 2)
		       * (sizeof yyor - 1))];
      char const *yyprefix = yyexpecting;

      /* Start YYX at -YYN if negative to avoid negative indexes in
	 YYCHECK.  */
      int yyxbegin = yyn < 0 ? -yyn : 0;

      /* Stay within bounds of both yycheck and yytname.  */
      int yychecklim = YYLAST - yyn + 1;
      int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
      int yycount = 1;

      yyarg[0] = yytname[yytype];
      yyfmt = yystpcpy (yyformat, yyunexpected);

      for (yyx = yyxbegin; yyx < yyxend; ++yyx)
	if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR)
	  {
	    if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
	      {
		yycount = 1;
		yysize = yysize0;
		yyformat[sizeof yyunexpected - 1] = '\0';
		break;
	      }
	    yyarg[yycount++] = yytname[yyx];
	    yysize1 = yysize + yytnamerr (0, yytname[yyx]);
	    yysize_overflow |= (yysize1 < yysize);
	    yysize = yysize1;
	    yyfmt = yystpcpy (yyfmt, yyprefix);
	    yyprefix = yyor;
	  }

      yyf = YY_(yyformat);
      yysize1 = yysize + yystrlen (yyf);
      yysize_overflow |= (yysize1 < yysize);
      yysize = yysize1;

      if (yysize_overflow)
	return YYSIZE_MAXIMUM;

      if (yyresult)
	{
	  /* Avoid sprintf, as that infringes on the user's name space.
	     Don't have undefined behavior even if the translation
	     produced a string with the wrong number of "%s"s.  */
	  char *yyp = yyresult;
	  int yyi = 0;
	  while ((*yyp = *yyf) != '\0')
	    {
	      if (*yyp == '%' && yyf[1] == 's' && yyi < yycount)
		{
		  yyp += yytnamerr (yyp, yyarg[yyi++]);
		  yyf += 2;
		}
	      else
		{
		  yyp++;
		  yyf++;
		}
	    }
	}
      return yysize;
    }
}
#endif /* YYERROR_VERBOSE */


/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
#else
static void
yydestruct (yymsg, yytype, yyvaluep)
    const char *yymsg;
    int yytype;
    YYSTYPE *yyvaluep;
#endif
{
  YYUSE (yyvaluep);

  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  switch (yytype)
    {
      case 27: /* "\"identifier\"" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1353 "grammar/y.tab.cpp"
	break;
      case 28: /* "\"string literal\"" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1363 "grammar/y.tab.cpp"
	break;
      case 30: /* "\"integer literal\"" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1373 "grammar/y.tab.cpp"
	break;
      case 31: /* "\"real decimal literal\"" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1383 "grammar/y.tab.cpp"
	break;
      case 32: /* "\"real exp literal\"" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1393 "grammar/y.tab.cpp"
	break;
      case 57: /* "program" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1403 "grammar/y.tab.cpp"
	break;
      case 58: /* "program_head" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1413 "grammar/y.tab.cpp"
	break;
      case 59: /* "identifier_list" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1423 "grammar/y.tab.cpp"
	break;
      case 60: /* "compound_statement" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1433 "grammar/y.tab.cpp"
	break;
      case 61: /* "decls" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1443 "grammar/y.tab.cpp"
	break;
      case 62: /* "decl" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1453 "grammar/y.tab.cpp"
	break;
      case 63: /* "const_decl" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1463 "grammar/y.tab.cpp"
	break;
      case 64: /* "const_definitions" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1473 "grammar/y.tab.cpp"
	break;
      case 65: /* "const_definition" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1483 "grammar/y.tab.cpp"
	break;
      case 66: /* "var_decl" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1493 "grammar/y.tab.cpp"
	break;
      case 68: /* "var_expressions" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1503 "grammar/y.tab.cpp"
	break;
      case 69: /* "var_expression" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1513 "grammar/y.tab.cpp"
	break;
      case 70: /* "type_decl" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1523 "grammar/y.tab.cpp"
	break;
      case 71: /* "type_expressions" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1533 "grammar/y.tab.cpp"
	break;
      case 72: /* "type_expression" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1543 "grammar/y.tab.cpp"
	break;
      case 73: /* "subprogram_decl" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1553 "grammar/y.tab.cpp"
	break;
      case 74: /* "subprogram" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1563 "grammar/y.tab.cpp"
	break;
      case 75: /* "subprogram_header" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1573 "grammar/y.tab.cpp"
	break;
      case 76: /* "subprogram_body" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1583 "grammar/y.tab.cpp"
	break;
      case 77: /* "parameter_list" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1593 "grammar/y.tab.cpp"
	break;
      case 78: /* "statement_list" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1603 "grammar/y.tab.cpp"
	break;
      case 80: /* "statement" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1613 "grammar/y.tab.cpp"
	break;
      case 81: /* "if_statement" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1623 "grammar/y.tab.cpp"
	break;
      case 82: /* "while_statement" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1633 "grammar/y.tab.cpp"
	break;
      case 83: /* "for_statement" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1643 "grammar/y.tab.cpp"
	break;
      case 84: /* "expression_list" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1653 "grammar/y.tab.cpp"
	break;
      case 85: /* "expression_list_" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1663 "grammar/y.tab.cpp"
	break;
      case 86: /* "expression" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1673 "grammar/y.tab.cpp"
	break;
      case 87: /* "simple_expression" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1683 "grammar/y.tab.cpp"
	break;
      case 88: /* "term" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1693 "grammar/y.tab.cpp"
	break;
      case 89: /* "factor" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1703 "grammar/y.tab.cpp"
	break;
      case 90: /* "lower_factor" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1713 "grammar/y.tab.cpp"
	break;
      case 91: /* "subscripts" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1723 "grammar/y.tab.cpp"
	break;
      case 92: /* "subscripts_" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1733 "grammar/y.tab.cpp"
	break;
      case 93: /* "type_identifier" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1743 "grammar/y.tab.cpp"
	break;
      case 94: /* "const_expression" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1753 "grammar/y.tab.cpp"
	break;
      case 95: /* "array_dim_expression" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1763 "grammar/y.tab.cpp"
	break;
      case 96: /* "real" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1773 "grammar/y.tab.cpp"
	break;
      case 97: /* "return_type" */
#line 100 "grammar/pishc.y"
	{
    if(!pish::successfulParse)
    {
        delete (*yyvaluep);
    }
};
#line 1783 "grammar/y.tab.cpp"
	break;

      default:
	break;
    }
}


/* Prevent warnings from -Wmissing-prototypes.  */

#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */



/* The look-ahead symbol.  */
int yychar;

/* The semantic value of the look-ahead symbol.  */
YYSTYPE yylval;

/* Number of syntax errors so far.  */
int yynerrs;



/*----------.
| yyparse.  |
`----------*/

#ifdef YYPARSE_PARAM
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void *YYPARSE_PARAM)
#else
int
yyparse (YYPARSE_PARAM)
    void *YYPARSE_PARAM;
#endif
#else /* ! YYPARSE_PARAM */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void)
#else
int
yyparse ()

#endif
#endif
{
  
  int yystate;
  int yyn;
  int yyresult;
  /* Number of tokens to shift before error messages enabled.  */
  int yyerrstatus;
  /* Look-ahead token as an internal (translated) token number.  */
  int yytoken = 0;
#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

  /* Three stacks and their tools:
     `yyss': related to states,
     `yyvs': related to semantic values,
     `yyls': related to locations.

     Refer to the stacks thru separate pointers, to allow yyoverflow
     to reallocate them elsewhere.  */

  /* The state stack.  */
  yytype_int16 yyssa[YYINITDEPTH];
  yytype_int16 *yyss = yyssa;
  yytype_int16 *yyssp;

  /* The semantic value stack.  */
  YYSTYPE yyvsa[YYINITDEPTH];
  YYSTYPE *yyvs = yyvsa;
  YYSTYPE *yyvsp;



#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  YYSIZE_T yystacksize = YYINITDEPTH;

  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;


  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY;		/* Cause a token to be read.  */

  /* Initialize stack pointers.
     Waste one element of value and location stack
     so that they stay on the same level as the state stack.
     The wasted elements are never initialized.  */

  yyssp = yyss;
  yyvsp = yyvs;

  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
	/* Give user a chance to reallocate the stack.  Use copies of
	   these so that the &'s don't force the real ones into
	   memory.  */
	YYSTYPE *yyvs1 = yyvs;
	yytype_int16 *yyss1 = yyss;


	/* Each stack pointer address is followed by the size of the
	   data in use in that stack, in bytes.  This used to be a
	   conditional around just the two extra args, but that might
	   be undefined if yyoverflow is a macro.  */
	yyoverflow (YY_("memory exhausted"),
		    &yyss1, yysize * sizeof (*yyssp),
		    &yyvs1, yysize * sizeof (*yyvsp),

		    &yystacksize);

	yyss = yyss1;
	yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
	goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
	yystacksize = YYMAXDEPTH;

      {
	yytype_int16 *yyss1 = yyss;
	union yyalloc *yyptr =
	  (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
	if (! yyptr)
	  goto yyexhaustedlab;
	YYSTACK_RELOCATE (yyss);
	YYSTACK_RELOCATE (yyvs);

#  undef YYSTACK_RELOCATE
	if (yyss1 != yyssa)
	  YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;


      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
		  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
	YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     look-ahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to look-ahead token.  */
  yyn = yypact[yystate];
  if (yyn == YYPACT_NINF)
    goto yydefault;

  /* Not known => get a look-ahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid look-ahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = YYLEX;
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yyn == 0 || yyn == YYTABLE_NINF)
	goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the look-ahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token unless it is eof.  */
  if (yychar != YYEOF)
    yychar = YYEMPTY;

  yystate = yyn;
  *++yyvsp = yylval;

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     `$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:
#line 132 "grammar/pishc.y"
    {
            (yyval) = pish::programNode = new pish::Program(
                (pish::ProgramHead*) (yyvsp[(2) - (5)]),
                new pish::ProgramBody(CONVERT(pish::DeclarationList*, (yyvsp[(3) - (5)])), CONVERT(pish::StatementList*, (yyvsp[(4) - (5)])), pish::lineNumber),
                pish::lineNumber
            );
            pish::successfulParse = true;
            YYACCEPT;
        }
    break;

  case 3:
#line 145 "grammar/pishc.y"
    {
			(yyval) = new pish::ProgramHead(CONVERT(pish::Identifier*, (yyvsp[(1) - (5)])), CONVERT(pish::IdentifierList*, (yyvsp[(3) - (5)])), pish::lineNumber);
		}
    break;

  case 4:
#line 154 "grammar/pishc.y"
    {
            (yyval) = (yyvsp[(1) - (3)]);
            CONVERT(pish::IdentifierList*, (yyvsp[(1) - (3)]))->add(CONVERT(pish::Identifier*, (yyvsp[(3) - (3)])));
        }
    break;

  case 5:
#line 159 "grammar/pishc.y"
    {
            pish::IdentifierList* list = new pish::IdentifierList(pish::lineNumber);
            list->add(CONVERT(pish::Identifier*, (yyvsp[(1) - (1)])));
            
            (yyval) = list;
        }
    break;

  case 6:
#line 172 "grammar/pishc.y"
    {
            (yyval) = (yyvsp[(2) - (2)]);
        }
    break;

  case 7:
#line 182 "grammar/pishc.y"
    {
            (yyval) = (yyvsp[(1) - (2)]);
            CONVERT(pish::DeclarationList*, (yyvsp[(1) - (2)]))->add(CONVERT(pish::Declaration*, (yyvsp[(2) - (2)])));
        }
    break;

  case 8:
#line 187 "grammar/pishc.y"
    {
            (yyval) = new pish::DeclarationList(pish::lineNumber);
        }
    break;

  case 9:
#line 196 "grammar/pishc.y"
    { (yyval) = (yyvsp[(1) - (1)]); }
    break;

  case 10:
#line 197 "grammar/pishc.y"
    { (yyval) = (yyvsp[(1) - (1)]); }
    break;

  case 11:
#line 198 "grammar/pishc.y"
    { (yyval) = (yyvsp[(1) - (1)]); }
    break;

  case 12:
#line 199 "grammar/pishc.y"
    { (yyval) = (yyvsp[(1) - (1)]); }
    break;

  case 13:
#line 201 "grammar/pishc.y"
    {
            pish::debugMessage("DEBUG: Error production in global section, skipping.\n");
            (yyval) = NULL;
            yyerrok;
        }
    break;

  case 14:
#line 213 "grammar/pishc.y"
    {
            (yyval) = (yyvsp[(2) - (2)]);
        }
    break;

  case 15:
#line 223 "grammar/pishc.y"
    {
            if((yyvsp[(1) - (2)]))
            {
                (yyval) = (yyvsp[(1) - (2)]);
                CONVERT(pish::DeclarationList*, (yyvsp[(1) - (2)]))->add(CONVERT(pish::Declaration*, (yyvsp[(2) - (2)])));
            }
            /* We need a way out if there was an error in one of the earlier declarations. */
            else
            {
                pish::DeclarationList* list = new pish::DeclarationList(pish::lineNumber);
                list->add(CONVERT(pish::Declaration*, (yyvsp[(2) - (2)])));
                
                (yyval) = list;
            }
        }
    break;

  case 16:
#line 239 "grammar/pishc.y"
    {
            pish::DeclarationList* list = new pish::DeclarationList(pish::lineNumber);
            list->add(CONVERT(pish::Declaration*, (yyvsp[(1) - (1)])));
            
            (yyval) = list;
        }
    break;

  case 17:
#line 246 "grammar/pishc.y"
    {
            pish::debugMessage("DEBUG: Error production mid-list, skipping.\n");
            (yyval) = (yyvsp[(1) - (3)]);
            yyerrok;
        }
    break;

  case 18:
#line 252 "grammar/pishc.y"
    {
            pish::debugMessage("DEBUG: Error production start-of-list, skipping.\n");
            (yyval) = NULL;
            yyerrok;
        }
    break;

  case 19:
#line 264 "grammar/pishc.y"
    {
            (yyval)  = new pish::ConstantDeclaration(CONVERT(pish::Identifier*, (yyvsp[(1) - (4)])), CONVERT(pish::Expression*, (yyvsp[(3) - (4)])), pish::lineNumber);
        }
    break;

  case 20:
#line 274 "grammar/pishc.y"
    {
            (yyval) = (yyvsp[(2) - (2)]);
        }
    break;

  case 21:
#line 284 "grammar/pishc.y"
    {
            if((yyvsp[(1) - (3)]))
            {
                (yyval) = (yyvsp[(1) - (3)]);
                CONVERT(pish::DeclarationList*, (yyvsp[(1) - (3)]))->add(CONVERT(pish::Declaration*, (yyvsp[(2) - (3)])));
            }
            /* We need a way out if there was an error in one of the earlier declarations. */
            else
            {
                pish::DeclarationList* list = new pish::DeclarationList(pish::lineNumber);
                list->add(CONVERT(pish::Declaration*, (yyvsp[(2) - (3)])));
                
                (yyval) = list;
            }
        }
    break;

  case 22:
#line 300 "grammar/pishc.y"
    {
            pish::DeclarationList* list = new pish::DeclarationList(pish::lineNumber);
            list->add(CONVERT(pish::Declaration*, (yyvsp[(1) - (2)])));
            
            (yyval) = list;
        }
    break;

  case 23:
#line 307 "grammar/pishc.y"
    {
            pish::debugMessage("DEBUG: Error production mid-list, skipping.\n");
            (yyval) = (yyvsp[(1) - (3)]);
            yyerrok;
        }
    break;

  case 24:
#line 313 "grammar/pishc.y"
    {
            pish::debugMessage("DEBUG: Error production start-of-list, skipping.\n");
            (yyval) = NULL;
            yyerrok;
        }
    break;

  case 25:
#line 325 "grammar/pishc.y"
    {
            (yyval) = (yyvsp[(1) - (3)]);
            CONVERT(pish::DeclarationList*, (yyvsp[(1) - (3)]))->add(CONVERT(pish::Declaration*, (yyvsp[(3) - (3)])));
        }
    break;

  case 26:
#line 330 "grammar/pishc.y"
    {
            pish::DeclarationList* list = new pish::DeclarationList(pish::lineNumber);
            list->add(CONVERT(pish::Declaration*, (yyvsp[(1) - (1)])));
            
            (yyval) = list;
        }
    break;

  case 27:
#line 343 "grammar/pishc.y"
    {
            (yyval) = new pish::VariableDeclaration(CONVERT(pish::IdentifierList*, (yyvsp[(1) - (3)])), CONVERT(pish::TypeDefinition*, (yyvsp[(3) - (3)])), pish::lineNumber);
        }
    break;

  case 28:
#line 353 "grammar/pishc.y"
    {
            (yyval) = (yyvsp[(2) - (2)]);
        }
    break;

  case 29:
#line 363 "grammar/pishc.y"
    {
            if((yyvsp[(1) - (2)]))
            {
                (yyval) = (yyvsp[(1) - (2)]);
                CONVERT(pish::DeclarationList*, (yyvsp[(1) - (2)]))->add(CONVERT(pish::Declaration*, (yyvsp[(2) - (2)])));
            }
            /* We need a way out if there was an error in one of the earlier declarations. */
            else
            {
                pish::DeclarationList* list = new pish::DeclarationList(pish::lineNumber);
                list->add(CONVERT(pish::Declaration*, (yyvsp[(2) - (2)])));
                
                (yyval) = list;
            }
        }
    break;

  case 30:
#line 379 "grammar/pishc.y"
    {
            pish::DeclarationList* list = new pish::DeclarationList(pish::lineNumber);
            list->add(CONVERT(pish::Declaration*, (yyvsp[(1) - (1)])));
            
            (yyval) = list;
        }
    break;

  case 31:
#line 386 "grammar/pishc.y"
    {
            pish::debugMessage("DEBUG: Error production mid-list, skipping.\n");
            (yyval) = (yyvsp[(1) - (3)]);
            yyerrok;
        }
    break;

  case 32:
#line 392 "grammar/pishc.y"
    {
            pish::debugMessage("DEBUG: Error production start-of-list, skipping.\n");
            (yyval) = NULL;
            yyerrok;
        }
    break;

  case 33:
#line 404 "grammar/pishc.y"
    {
            (yyval) = new pish::AliasDeclaration(CONVERT(pish::Identifier*, (yyvsp[(1) - (4)])), CONVERT(pish::TypeDefinition*, (yyvsp[(3) - (4)])), pish::lineNumber);
        }
    break;

  case 34:
#line 414 "grammar/pishc.y"
    {
            (yyval) = new pish::ProgramDeclaration(CONVERT(pish::Program*, (yyvsp[(1) - (1)])), pish::lineNumber);
        }
    break;

  case 35:
#line 425 "grammar/pishc.y"
    {
            (yyval) = new pish::Program(CONVERT(pish::ProgramHead*, (yyvsp[(1) - (2)])), CONVERT(pish::ProgramBody*, (yyvsp[(2) - (2)])), pish::lineNumber);
        }
    break;

  case 36:
#line 436 "grammar/pishc.y"
    {
            (yyval) = new pish::ProgramHead(CONVERT(pish::Identifier*, (yyvsp[(2) - (8)])), CONVERT(pish::TypeDefinition*, (yyvsp[(7) - (8)])), CONVERT(pish::DeclarationList*, (yyvsp[(4) - (8)])), pish::lineNumber);
        }
    break;

  case 37:
#line 440 "grammar/pishc.y"
    {
            (yyval) = new pish::ProgramHead(CONVERT(pish::Identifier*, (yyvsp[(2) - (6)])), NULL, CONVERT(pish::DeclarationList*, (yyvsp[(4) - (6)])), pish::lineNumber);
        }
    break;

  case 38:
#line 444 "grammar/pishc.y"
    {
            pish::debugMessage("DEBUG: failed function header.\n");
            (yyval) = NULL;
            yyerrok;
        }
    break;

  case 39:
#line 450 "grammar/pishc.y"
    {
            pish::debugMessage("DEBUG: failed procedure header.\n");
            (yyval) = NULL;
            yyerrok;
        }
    break;

  case 40:
#line 464 "grammar/pishc.y"
    {
            (yyval) = new pish::ProgramBody(CONVERT(pish::DeclarationList*, (yyvsp[(1) - (3)])), CONVERT(pish::StatementList*, (yyvsp[(2) - (3)])), pish::lineNumber);
        }
    break;

  case 41:
#line 468 "grammar/pishc.y"
    {
            /* No body declared here (forward declaration). */
            (yyval) = NULL;
        }
    break;

  case 42:
#line 473 "grammar/pishc.y"
    {
            /* Error. */
            pish::debugMessage("DEBUG: failed subprogram body.\n");
            (yyval) = NULL;
        }
    break;

  case 43:
#line 486 "grammar/pishc.y"
    {
            (yyval) = (yyvsp[(1) - (1)]);
        }
    break;

  case 44:
#line 490 "grammar/pishc.y"
    {
            (yyval) = new pish::DeclarationList(pish::lineNumber);
        }
    break;

  case 45:
#line 500 "grammar/pishc.y"
    {
            if((yyvsp[(1) - (3)]))
            {
                (yyval) = (yyvsp[(1) - (3)]);
                CONVERT(pish::StatementList*, (yyvsp[(1) - (3)]))->add(CONVERT(pish::Statement*, (yyvsp[(2) - (3)])));
            }
            /* We need a way out if there was an error in one of the earlier declarations. */
            else
            {
                (yyval) = NULL;
            }
        }
    break;

  case 46:
#line 513 "grammar/pishc.y"
    {
            pish::StatementList* list = new pish::StatementList(pish::lineNumber);
            list->add(CONVERT(pish::Statement*, (yyvsp[(1) - (2)])));
            (yyval) = list;
        }
    break;

  case 47:
#line 519 "grammar/pishc.y"
    {
            pish::debugMessage("DEBUG: ERROR BEFORE END\n");
            (yyval) = NULL;
            yyerrok;
        }
    break;

  case 48:
#line 525 "grammar/pishc.y"
    {
            (yyval) = new pish::StatementList(pish::lineNumber);
        }
    break;

  case 49:
#line 534 "grammar/pishc.y"
    {
            if((yyvsp[(1) - (3)]))
            {
                (yyval) = (yyvsp[(1) - (3)]);
                CONVERT(pish::StatementList*, (yyvsp[(1) - (3)]))->add(CONVERT(pish::Statement*, (yyvsp[(2) - (3)])));
            }
            /* We need a way out if there was an error in one of the earlier declarations. */
            else
            {
                (yyval) = NULL;
            }
        }
    break;

  case 50:
#line 547 "grammar/pishc.y"
    {
            pish::StatementList* list = new pish::StatementList(pish::lineNumber);
            list->add(CONVERT(pish::Statement*, (yyvsp[(1) - (2)])));
            
            (yyval) = list;
        }
    break;

  case 51:
#line 554 "grammar/pishc.y"
    {
            pish::debugMessage("DEBUG: Error production mid-stmt list, skipping.\n");
            (yyval) = (yyvsp[(1) - (3)]);
            yyerrok;
        }
    break;

  case 52:
#line 560 "grammar/pishc.y"
    {
            pish::debugMessage("DEBUG: Error production start-of-stmt list, skipping.\n");
            (yyval) = NULL;
            yyerrok;
        }
    break;

  case 53:
#line 572 "grammar/pishc.y"
    {
            (yyval) = new pish::AssignmentStatement(new pish::Variable(CONVERT(pish::Identifier*, (yyvsp[(1) - (4)])), CONVERT(pish::SubscriptList*, (yyvsp[(2) - (4)])), pish::lineNumber), CONVERT(pish::Expression*, (yyvsp[(4) - (4)])), pish::lineNumber);
        }
    break;

  case 54:
#line 576 "grammar/pishc.y"
    {
            (yyval) = new pish::CallStatement(new pish::ProgramInvocation(CONVERT(pish::Identifier*, (yyvsp[(1) - (4)])), CONVERT(pish::ExpressionList*, (yyvsp[(3) - (4)])), pish::lineNumber), pish::lineNumber);
        }
    break;

  case 55:
#line 579 "grammar/pishc.y"
    { (yyval) = (yyvsp[(1) - (1)]); }
    break;

  case 56:
#line 580 "grammar/pishc.y"
    { (yyval) = (yyvsp[(1) - (1)]); }
    break;

  case 57:
#line 581 "grammar/pishc.y"
    { (yyval) = (yyvsp[(1) - (1)]); }
    break;

  case 58:
#line 582 "grammar/pishc.y"
    { (yyval) = (yyvsp[(1) - (1)]); }
    break;

  case 59:
#line 592 "grammar/pishc.y"
    {
            (yyval) = new pish::IfStatement(CONVERT(pish::Expression*, (yyvsp[(2) - (4)])), CONVERT(pish::Statement*, (yyvsp[(4) - (4)])), NULL, pish::lineNumber);
        }
    break;

  case 60:
#line 596 "grammar/pishc.y"
    {
            (yyval) = new pish::IfStatement(CONVERT(pish::Expression*, (yyvsp[(2) - (6)])), CONVERT(pish::Statement*, (yyvsp[(4) - (6)])), CONVERT(pish::Statement*, (yyvsp[(6) - (6)])), pish::lineNumber);
        }
    break;

  case 61:
#line 606 "grammar/pishc.y"
    {
            (yyval) = new pish::WhileStatement(CONVERT(pish::Expression*, (yyvsp[(2) - (4)])), CONVERT(pish::Statement*, (yyvsp[(4) - (4)])), pish::lineNumber);
        }
    break;

  case 62:
#line 615 "grammar/pishc.y"
    {
            (yyval) = new pish::ForStatement(
                new pish::Variable(
                    CONVERT(pish::Identifier*, (yyvsp[(2) - (9)])), CONVERT(pish::SubscriptList*, (yyvsp[(3) - (9)])), pish::lineNumber
                ),
                CONVERT(pish::Expression*, (yyvsp[(5) - (9)])),
                CONVERT(pish::Expression*, (yyvsp[(7) - (9)])),
                pish::ForStatement::FOR_TO,
                CONVERT(pish::Statement*, (yyvsp[(9) - (9)])),
                pish::lineNumber
            );
        }
    break;

  case 63:
#line 628 "grammar/pishc.y"
    {
            (yyval) = new pish::ForStatement(
                new pish::Variable(
                    CONVERT(pish::Identifier*, (yyvsp[(2) - (9)])), CONVERT(pish::SubscriptList*, (yyvsp[(3) - (9)])), pish::lineNumber
                ),
                CONVERT(pish::Expression*, (yyvsp[(5) - (9)])),
                CONVERT(pish::Expression*, (yyvsp[(7) - (9)])),
                pish::ForStatement::FOR_DOWNTO,
                CONVERT(pish::Statement*, (yyvsp[(9) - (9)])),
                pish::lineNumber
            );
        }
    break;

  case 64:
#line 647 "grammar/pishc.y"
    {
            (yyval) = (yyvsp[(1) - (1)]);
        }
    break;

  case 65:
#line 651 "grammar/pishc.y"
    {
            (yyval) = new pish::ExpressionList(pish::lineNumber);
        }
    break;

  case 66:
#line 661 "grammar/pishc.y"
    {
            (yyval) = (yyvsp[(1) - (3)]);
            CONVERT(pish::ExpressionList*, (yyvsp[(1) - (3)]))->add(CONVERT(pish::Expression*, (yyvsp[(3) - (3)])));
        }
    break;

  case 67:
#line 666 "grammar/pishc.y"
    {
            pish::ExpressionList* list = new pish::ExpressionList(pish::lineNumber);
            list->add(CONVERT(pish::Expression*, (yyvsp[(1) - (1)])));
            
            (yyval) = list;
        }
    break;

  case 68:
#line 680 "grammar/pishc.y"
    {
            (yyval) = new pish::Expression(new pish::Operator(pish::Operator::B_EQ, CONVERT(pish::Expression*, (yyvsp[(1) - (3)])), CONVERT(pish::Expression*, (yyvsp[(3) - (3)])), pish::lineNumber), pish::lineNumber); 
        }
    break;

  case 69:
#line 684 "grammar/pishc.y"
    {
            (yyval) = new pish::Expression(new pish::Operator(pish::Operator::B_NEQ, CONVERT(pish::Expression*, (yyvsp[(1) - (3)])), CONVERT(pish::Expression*, (yyvsp[(3) - (3)])), pish::lineNumber), pish::lineNumber); 
        }
    break;

  case 70:
#line 688 "grammar/pishc.y"
    {
            (yyval) = new pish::Expression(new pish::Operator(pish::Operator::B_GE, CONVERT(pish::Expression*, (yyvsp[(1) - (3)])), CONVERT(pish::Expression*, (yyvsp[(3) - (3)])), pish::lineNumber), pish::lineNumber); 
        }
    break;

  case 71:
#line 692 "grammar/pishc.y"
    {
            (yyval) = new pish::Expression(new pish::Operator(pish::Operator::B_GT, CONVERT(pish::Expression*, (yyvsp[(1) - (3)])), CONVERT(pish::Expression*, (yyvsp[(3) - (3)])), pish::lineNumber), pish::lineNumber); 
        }
    break;

  case 72:
#line 696 "grammar/pishc.y"
    {
            (yyval) = new pish::Expression(new pish::Operator(pish::Operator::B_LE, CONVERT(pish::Expression*, (yyvsp[(1) - (3)])), CONVERT(pish::Expression*, (yyvsp[(3) - (3)])), pish::lineNumber), pish::lineNumber); 
        }
    break;

  case 73:
#line 700 "grammar/pishc.y"
    {
            (yyval) = new pish::Expression(new pish::Operator(pish::Operator::B_LT, CONVERT(pish::Expression*, (yyvsp[(1) - (3)])), CONVERT(pish::Expression*, (yyvsp[(3) - (3)])), pish::lineNumber), pish::lineNumber); 
        }
    break;

  case 74:
#line 704 "grammar/pishc.y"
    {
            (yyval) = (yyvsp[(1) - (1)]);
        }
    break;

  case 75:
#line 714 "grammar/pishc.y"
    {
            (yyval) = new pish::Expression(new pish::Operator(pish::Operator::B_ADD, CONVERT(pish::Expression*, (yyvsp[(1) - (3)])), CONVERT(pish::Expression*, (yyvsp[(3) - (3)])), pish::lineNumber), pish::lineNumber); 
        }
    break;

  case 76:
#line 718 "grammar/pishc.y"
    {
            (yyval) = new pish::Expression(new pish::Operator(pish::Operator::B_SUB, CONVERT(pish::Expression*, (yyvsp[(1) - (3)])), CONVERT(pish::Expression*, (yyvsp[(3) - (3)])), pish::lineNumber), pish::lineNumber); 
        }
    break;

  case 77:
#line 721 "grammar/pishc.y"
    { (yyval) = (yyvsp[(1) - (1)]); }
    break;

  case 78:
#line 729 "grammar/pishc.y"
    {
            (yyval) = new pish::Expression(new pish::Operator(pish::Operator::B_MUL, CONVERT(pish::Expression*, (yyvsp[(1) - (3)])), CONVERT(pish::Expression*, (yyvsp[(3) - (3)])), pish::lineNumber), pish::lineNumber); 
        }
    break;

  case 79:
#line 733 "grammar/pishc.y"
    {
            (yyval) = new pish::Expression(new pish::Operator(pish::Operator::B_RDIV, CONVERT(pish::Expression*, (yyvsp[(1) - (3)])), CONVERT(pish::Expression*, (yyvsp[(3) - (3)])), pish::lineNumber), pish::lineNumber); 
        }
    break;

  case 80:
#line 737 "grammar/pishc.y"
    {
            (yyval) = new pish::Expression(new pish::Operator(pish::Operator::B_IDIV, CONVERT(pish::Expression*, (yyvsp[(1) - (3)])), CONVERT(pish::Expression*, (yyvsp[(3) - (3)])), pish::lineNumber), pish::lineNumber); 
        }
    break;

  case 81:
#line 741 "grammar/pishc.y"
    {
            (yyval) = new pish::Expression(new pish::Operator(pish::Operator::B_MOD, CONVERT(pish::Expression*, (yyvsp[(1) - (3)])), CONVERT(pish::Expression*, (yyvsp[(3) - (3)])), pish::lineNumber), pish::lineNumber); 
        }
    break;

  case 82:
#line 745 "grammar/pishc.y"
    {
            (yyval) = new pish::Expression(new pish::Operator(pish::Operator::B_AND, CONVERT(pish::Expression*, (yyvsp[(1) - (3)])), CONVERT(pish::Expression*, (yyvsp[(3) - (3)])), pish::lineNumber), pish::lineNumber); 
        }
    break;

  case 83:
#line 749 "grammar/pishc.y"
    {
            (yyval) = (yyvsp[(1) - (1)]);
        }
    break;

  case 84:
#line 759 "grammar/pishc.y"
    {
            (yyval) = (yyvsp[(2) - (2)]);
        }
    break;

  case 85:
#line 763 "grammar/pishc.y"
    {
            (yyval) = new pish::Expression(new pish::Operator(pish::Operator::U_NEGATE, CONVERT(pish::Expression*, (yyvsp[(2) - (2)])), NULL, pish::lineNumber), pish::lineNumber); 
        }
    break;

  case 86:
#line 767 "grammar/pishc.y"
    {
            (yyval) = new pish::Expression(new pish::Operator(pish::Operator::U_NOT, CONVERT(pish::Expression*, (yyvsp[(2) - (2)])), NULL, pish::lineNumber), pish::lineNumber); 
        }
    break;

  case 87:
#line 771 "grammar/pishc.y"
    {
            (yyval) = (yyvsp[(1) - (1)]);
        }
    break;

  case 88:
#line 781 "grammar/pishc.y"
    {
            (yyval) = new pish::Expression(new pish::Variable(CONVERT(pish::Identifier*, (yyvsp[(1) - (2)])), CONVERT(pish::SubscriptList*, (yyvsp[(2) - (2)])), pish::lineNumber), pish::lineNumber);
        }
    break;

  case 89:
#line 785 "grammar/pishc.y"
    {
            (yyval) = new pish::Expression(new pish::ProgramInvocation(CONVERT(pish::Identifier*, (yyvsp[(1) - (4)])), CONVERT(pish::ExpressionList*, (yyvsp[(3) - (4)])), pish::lineNumber), pish::lineNumber);
        }
    break;

  case 90:
#line 789 "grammar/pishc.y"
    {
            (yyval) = new pish::Expression(CONVERT(pish::Literal*, (yyvsp[(1) - (1)])), pish::lineNumber);
        }
    break;

  case 91:
#line 793 "grammar/pishc.y"
    {
            (yyval) = new pish::Expression(CONVERT(pish::Literal*, (yyvsp[(1) - (1)])), pish::lineNumber);
        }
    break;

  case 92:
#line 797 "grammar/pishc.y"
    {
            (yyval) = (yyvsp[(2) - (3)]);
        }
    break;

  case 93:
#line 807 "grammar/pishc.y"
    {
            (yyval) = (yyvsp[(1) - (1)]);
        }
    break;

  case 94:
#line 811 "grammar/pishc.y"
    {
            (yyval) = NULL;
        }
    break;

  case 95:
#line 820 "grammar/pishc.y"
    {
            CONVERT(pish::SubscriptList*, (yyvsp[(1) - (4)]))->add(new pish::Subscript(CONVERT(pish::Expression*, (yyvsp[(3) - (4)])), pish::lineNumber));
            (yyval) = (yyvsp[(1) - (4)]);
        }
    break;

  case 96:
#line 825 "grammar/pishc.y"
    {
            CONVERT(pish::SubscriptList*, (yyvsp[(1) - (3)]))->add(new pish::Subscript(CONVERT(pish::Identifier*, (yyvsp[(3) - (3)])), pish::lineNumber));
            (yyval) = (yyvsp[(1) - (3)]);
        }
    break;

  case 97:
#line 830 "grammar/pishc.y"
    {
            pish::SubscriptList* list = new pish::SubscriptList(pish::lineNumber);
            list->add(new pish::Subscript(CONVERT(pish::Expression*, (yyvsp[(2) - (3)])), pish::lineNumber));
            (yyval) = list;
        }
    break;

  case 98:
#line 836 "grammar/pishc.y"
    {
            pish::SubscriptList* list = new pish::SubscriptList(pish::lineNumber);
            list->add(new pish::Subscript(CONVERT(pish::Identifier*, (yyvsp[(2) - (2)])), pish::lineNumber));
            (yyval) = list;
        }
    break;

  case 99:
#line 848 "grammar/pishc.y"
    {
            (yyval) = new pish::TypeDefinition(CONVERT(pish::Identifier*, (yyvsp[(1) - (1)])), pish::lineNumber);
        }
    break;

  case 100:
#line 852 "grammar/pishc.y"
    {
            (yyval) = new pish::TypeDefinition(CONVERT(pish::TypeDefinition*, (yyvsp[(8) - (8)])), CONVERT(pish::Expression*, (yyvsp[(3) - (8)])), CONVERT(pish::Expression*, (yyvsp[(5) - (8)])), pish::lineNumber);
        }
    break;

  case 101:
#line 856 "grammar/pishc.y"
    {
            (yyval) = new pish::TypeDefinition(CONVERT(pish::DeclarationList*, (yyvsp[(2) - (3)])), pish::lineNumber);
        }
    break;

  case 102:
#line 866 "grammar/pishc.y"
    {
            (yyval) = new pish::Expression(CONVERT(pish::Literal*, (yyvsp[(1) - (1)])), pish::lineNumber);
        }
    break;

  case 103:
#line 870 "grammar/pishc.y"
    {
            (yyval) = new pish::Expression(new pish::Variable(CONVERT(pish::Identifier*, (yyvsp[(1) - (1)])), NULL, pish::lineNumber), pish::lineNumber);
        }
    break;

  case 104:
#line 874 "grammar/pishc.y"
    {
            (yyval) = new pish::Expression(CONVERT(pish::Literal*, (yyvsp[(1) - (1)])), pish::lineNumber);
        }
    break;

  case 105:
#line 878 "grammar/pishc.y"
    {
            (yyval) = new pish::Expression(new pish::Operator(pish::Operator::U_NEGATE, new pish::Expression(CONVERT(pish::Literal*, (yyvsp[(2) - (2)])), pish::lineNumber), NULL, pish::lineNumber), pish::lineNumber);
        }
    break;

  case 106:
#line 882 "grammar/pishc.y"
    {
            (yyval) = new pish::Expression(new pish::Operator(pish::Operator::U_NEGATE, new pish::Expression(new pish::Variable(CONVERT(pish::Identifier*, (yyvsp[(2) - (2)])), NULL, pish::lineNumber), pish::lineNumber), NULL, pish::lineNumber), pish::lineNumber);
        }
    break;

  case 107:
#line 892 "grammar/pishc.y"
    {
            (yyval) = new pish::Expression(CONVERT(pish::Literal*, (yyvsp[(1) - (1)])), pish::lineNumber);
        }
    break;

  case 108:
#line 896 "grammar/pishc.y"
    {
            (yyval) = new pish::Expression(new pish::Variable(CONVERT(pish::Identifier*, (yyvsp[(1) - (1)])), NULL, pish::lineNumber), pish::lineNumber);
        }
    break;

  case 109:
#line 900 "grammar/pishc.y"
    {
            (yyval) = new pish::Expression(new pish::Operator(pish::Operator::U_NEGATE, new pish::Expression(CONVERT(pish::Literal*, (yyvsp[(2) - (2)])), pish::lineNumber), NULL, pish::lineNumber), pish::lineNumber);
        }
    break;

  case 110:
#line 904 "grammar/pishc.y"
    {
            (yyval) = new pish::Expression(new pish::Operator(pish::Operator::U_NEGATE, new pish::Expression(new pish::Variable(CONVERT(pish::Identifier*, (yyvsp[(2) - (2)])), NULL, pish::lineNumber), pish::lineNumber), NULL, pish::lineNumber), pish::lineNumber);
        }
    break;

  case 111:
#line 913 "grammar/pishc.y"
    { (yyval) = (yyvsp[(1) - (1)]); }
    break;

  case 112:
#line 914 "grammar/pishc.y"
    { (yyval) = (yyvsp[(1) - (1)]); }
    break;

  case 113:
#line 915 "grammar/pishc.y"
    { (yyval) = (yyvsp[(1) - (1)]); }
    break;

  case 114:
#line 922 "grammar/pishc.y"
    { (yyval) = new pish::TypeDefinition(CONVERT(pish::Identifier*, (yyvsp[(1) - (1)])), pish::lineNumber); }
    break;


/* Line 1267 of yacc.c.  */
#line 2996 "grammar/y.tab.cpp"
      default: break;
    }
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;


  /* Now `shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*------------------------------------.
| yyerrlab -- here on detecting error |
`------------------------------------*/
yyerrlab:
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
      {
	YYSIZE_T yysize = yysyntax_error (0, yystate, yychar);
	if (yymsg_alloc < yysize && yymsg_alloc < YYSTACK_ALLOC_MAXIMUM)
	  {
	    YYSIZE_T yyalloc = 2 * yysize;
	    if (! (yysize <= yyalloc && yyalloc <= YYSTACK_ALLOC_MAXIMUM))
	      yyalloc = YYSTACK_ALLOC_MAXIMUM;
	    if (yymsg != yymsgbuf)
	      YYSTACK_FREE (yymsg);
	    yymsg = (char *) YYSTACK_ALLOC (yyalloc);
	    if (yymsg)
	      yymsg_alloc = yyalloc;
	    else
	      {
		yymsg = yymsgbuf;
		yymsg_alloc = sizeof yymsgbuf;
	      }
	  }

	if (0 < yysize && yysize <= yymsg_alloc)
	  {
	    (void) yysyntax_error (yymsg, yystate, yychar);
	    yyerror (yymsg);
	  }
	else
	  {
	    yyerror (YY_("syntax error"));
	    if (yysize != 0)
	      goto yyexhaustedlab;
	  }
      }
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse look-ahead token after an
	 error, discard it.  */

      if (yychar <= YYEOF)
	{
	  /* Return failure if at end of input.  */
	  if (yychar == YYEOF)
	    YYABORT;
	}
      else
	{
	  yydestruct ("Error: discarding",
		      yytoken, &yylval);
	  yychar = YYEMPTY;
	}
    }

  /* Else will try to reuse look-ahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule which action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;	/* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (yyn != YYPACT_NINF)
	{
	  yyn += YYTERROR;
	  if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
	    {
	      yyn = yytable[yyn];
	      if (0 < yyn)
		break;
	    }
	}

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
	YYABORT;


      yydestruct ("Error: popping",
		  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  *++yyvsp = yylval;


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#ifndef yyoverflow
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEOF && yychar != YYEMPTY)
     yydestruct ("Cleanup: discarding lookahead",
		 yytoken, &yylval);
  /* Do not reclaim the symbols of the rule which action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
		  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  /* Make sure YYID is used.  */
  return YYID (yyresult);
}


#line 926 "grammar/pishc.y"


/* User Code */
enum CompileMode
{
    COMPILE_ABSTRACT,
    COMPILE_SYMBOL,
    COMPILE_INTERMEDIATE,
    COMPILE_ASSEMBLY,
    COMPILE_FULL,
};

const char* getModeText(CompileMode mode)
{
    switch(mode)
    {
        case COMPILE_ABSTRACT:
            return " (-a flag; up to abstract syntax)";
        case COMPILE_SYMBOL:
            return " (-s flag; up to symbol tables)";
        case COMPILE_INTERMEDIATE:
            return " (-i flag; up to intermediate code)";
        case COMPILE_ASSEMBLY:
            return " (-c flag; up to assembly code)";
        default:
            return "";
    }
}

const char* const PROGRAM_NAME = "pishc";

std::vector<std::string> files;


std::string replaceExtension(const std::string& s, const std::string& extension)
{
    std::string::size_type pos = s.rfind('.');
    if (pos == std::string::npos)
    {
        return s + "." + extension;
    }
    else
    {
        return s.substr(0, pos + 1) + extension;
    }
}

void yyerror(const char* message)
{
	pish::error(message, pish::lineNumber);
}

int yywrap()
{
	return 1;
}

pish::AbstractNode* buildAST(FILE* f, const std::string& filename)
{
    pish::successfulParse = false;
    
    yyin = f;
    // Needed to clear lexer state when switching files.
    pish::flushBuffer();
    
    pish::parseFilename = filename;
    pish::lineNumber = 1;
    if(!f)
    {
        fprintf(stderr, "  failed: error, could not open file `%s`.\n", pish::getActiveFile());
        pish::errorCount++;
        return NULL;
    }
    
    try
    {
        int result = yyparse();
        if(!result && !pish::errorCount)
        {
            return pish::programNode;
        }
    }
    catch(std::bad_cast& e)
    {
        fprintf(stderr, "*** internal compiler error! %s.  exit. ***", e.what());
        exit(-1);
    }
    return NULL;
}

int compile(CompileMode mode, FILE* f, const std::string& filename)
{
    // No errors yet.
    pish::errorCount = 0;
    
    printf("  compiling `%s`...\n", filename.c_str());
    // Build AST....
    pish::AbstractNode* node = buildAST(f, filename);

    // Syntax analysis failed.
    if(!node)
    {
        return pish::errorCount;
    }
    else
    {
        // Finished abstract tree.
        if(mode == COMPILE_ABSTRACT)
        {
    
            std::string outname = replaceExtension(filename, "abs");
            FILE* out = NULL;
            if(f == stdin)
            {
                out = stdout;
            }
            else
            {
                out = fopen(outname.c_str(), "wb");
            }
            if(!out)
            {
                fprintf(stderr, "*** could not open `%s` for writing. exit. ***", outname.c_str());
                delete node;
                exit(-1);
            }
        
			pish::dumpNode<pish::AbstractNode>(node, out, 0);
            fputs("\n", out);
        
            delete node;
            fclose(out);
        
            fprintf(stderr, "  wrote AST to `%s`.\n", outname.c_str());
        
            return pish::errorCount;
        }
    }
    
    // Begin semantic analysis
    CONVERT(pish::Inspectable*, node)->inspect(); 
    
    if(pish::errorCount)
    {
        return pish::errorCount;
    }
    else
    {
        // Finished abstract tree.
        if(mode == COMPILE_SYMBOL)
        {
            std::string outname = replaceExtension(filename, "sym");
            FILE * out = NULL;
    
            if ( f == stdin )
            {
                out = stdout;
            }
            else
            {
                out = fopen ( outname.c_str (), "wb" );
            }
    
            if ( !out )
            {
                fprintf ( stderr, "*** could not open `%s` for writing. exit ***", outname.c_str () );
                exit ( -1 );
            }
    
            pish::Program* prog = CONVERT(pish::Program*, node);
    
            fprintf(out, "GLOBAL SYMBOL TABLE (VARIABLES, CONSTANTS, SUBPROGRAMS):\n");
            pish::dumpTableData<pish::SymbolTable>(prog->localSymbols, out, 1);
            fprintf(out, "\n\nGLOBAL TYPE TABLE:\n");
            pish::dumpTableData<pish::SymbolTable>(prog->localTypes, out, 1);
    
                    fclose ( out );
    
            fprintf ( stderr, "  wrote Symbol Table to `%s`\n", outname.c_str () );
                
            delete node;
                
            return pish::errorCount;
        }
    }

    if ( pish::errorCount )
    {
        return ( pish::errorCount );
    }
    else
    {
        bool isASM = ( mode == COMPILE_ASSEMBLY ) || ( mode == COMPILE_FULL );

        std::string outname;

        if ( !isASM )
        {
                outname = replaceExtension ( filename, "inr" );
        }
        else
        {
                outname = replaceExtension ( filename, "asm" );
        }
        
        

        if ( f == stdin )
        {
            CONVERT(pish::Compilable *, node) -> compile ( std::cout, isASM );
        }
        else
        {
            std::ofstream fileStream;
            fileStream.open ( outname.c_str (), std::ios_base::out );
            CONVERT(pish::Compilable *, node) -> compile ( fileStream, isASM );
        }



    }

    // Other steps go here.
    
    // Finished completely!
    return pish::errorCount;
}

void usage(int argc, char** argv)
{
    fprintf(stderr, "Usage: %s [-flag] [... filename]\n", argv[0]);
    fprintf(stderr, "    flags:\n");
    fprintf(stderr, "        Mode (only one may be used):\n");
    fprintf(stderr, "        -a : perform syntax analysis and output abstract syntax (.abs)\n");
    fprintf(stderr, "        -s : perform type checking and output symbol table (.sym)\n");
    fprintf(stderr, "        -i : analyze semantically and output intermediate code (.inr)\n");
    fprintf(stderr, "        -c : compile and output MIPS R2000 assembler (.asm)\n\n");
    fprintf(stderr, "        Other:\n");
    fprintf(stderr, "        -N : interactive (read from stdin, write to stdout)\n");
}

int main(int argc, char** argv)
{
    unsigned int successes = 0;
    CompileMode mode = COMPILE_FULL;
    bool interactive = false;
    
    for(int i = 1; i < argc; i++)
    {
        if(argv[i][0] == '-')
        {
            if(strlen(argv[i]) > 2)
            {
                fprintf(stderr, "* %s: invalid compiler option `%s`.\n  type `%s` with no arguments to see usage.\n", PROGRAM_NAME, argv[i], argv[0]);
                return -1;
            }
            switch(argv[i][1])
            {
                case 'a':
                    if(mode != COMPILE_FULL)
                    {
                        fprintf(stderr, "* %s: warning: mode flag already passed. ignored compiler option `%s`.\n", PROGRAM_NAME, argv[i]);
                    }
                    else
                    {
                        mode = COMPILE_ABSTRACT;
                    }
                    break;
                case 's':
                    if(mode != COMPILE_FULL)
                    {
                        fprintf(stderr, "* %s: warning: mode flag already passed. ignored compiler option `%s`.\n", PROGRAM_NAME, argv[i]);
                    }
                    else
                    {
                        mode = COMPILE_SYMBOL;
                    }
                    break;
                case 'i':
                    if(mode != COMPILE_FULL)
                    {
                        fprintf(stderr, "* %s: warning: mode flag already passed. ignored compiler option `%s`.\n", PROGRAM_NAME, argv[i]);
                    }
                    else
                    {
                        mode = COMPILE_INTERMEDIATE;
                    }
                    break;
                case 'c':
                    if(mode != COMPILE_FULL)
                    {
                        fprintf(stderr, "* %s: warning: mode flag already passed. ignored compiler option `%s`.\n", PROGRAM_NAME, argv[i]);
                    }
                    else
                    {
                        mode = COMPILE_ASSEMBLY;
                    }
                    break;
                case 'N':
                    interactive = true;
                    break;
                default:
                    fprintf(stderr, "* %s: invalid compiler option `%s`.\n  type `%s` with no arguments to see usage.\n", PROGRAM_NAME, argv[i], argv[0]);
                    return -1;
            }
        }
        // Assume it's a filename.
        else
        {
            files.push_back(argv[i]);
        }
    }
    
    if(!files.size() && !interactive)
    {
        fprintf(stderr, "* %s: no input files specified.\n\n", PROGRAM_NAME);
        usage(argc, argv);
        return -1;
    }
    
    fprintf(stderr, "* %s: compiling %u input file(s)%s...\n", PROGRAM_NAME, (unsigned int) files.size(), getModeText(mode));
    for(size_t i = 0; i < files.size(); i++)
    {
        FILE* f = fopen(files[i].c_str(), "rb");
        if(!compile(mode, f, files[i]))
        {
            printf("* %s: successfully compiled `%s`\n", PROGRAM_NAME, files[i].c_str());
            successes++;
        }
        else
        {
            fprintf(stderr, "* %s: failed on `%s` with %d error(s).\n", PROGRAM_NAME, files[i].c_str(), pish::errorCount);
        }
        if(f)
        {
            fclose(f);
        }
    }
    if(interactive)
    {
        if(!compile(mode, stdin, "[stdin]"))
        {
            printf("* %s: successfully compiled [stdin]\n", PROGRAM_NAME);
            successes++;
        }
        else
        {
            fprintf(stderr, "* %s: failed on [stdin] with %d error(s).\n", PROGRAM_NAME, pish::errorCount);
            return EXIT_FAILURE;
        }
    }
    fprintf(stderr, "* %s: compiled %u file(s) out of %u total%s\n", PROGRAM_NAME, successes, (unsigned int) files.size(), getModeText(mode));
    if(successes != files.size())
    {
        return EXIT_FAILURE;
    }
	return 0;
}

