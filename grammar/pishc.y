/*
 * Course: CIS*4650
 * Authors: Andrew Crowell, Andrew Judd
 */

%{

#include <string.h>
#include <fstream>
#include <iostream>
    
#include "common.h"

%}

/* Give verbose error messages */
%error-verbose

/* Keyword Token Section */
%token KEYWORD_AND "`and`"
%token KEYWORD_BEGIN "`begin`"
%token KEYWORD_CONST "`const`"
%token KEYWORD_DIV "`div`"
%token KEYWORD_DO "`do`"
%token KEYWORD_DOWNTO "`downto`"
%token KEYWORD_ELSE "`else`"
%token KEYWORD_ARRAY "`array`"
%token KEYWORD_END "`end`"
%token KEYWORD_FOR "`for`"
%token KEYWORD_FORWARD "`forward`"
%token KEYWORD_FUNCTION "`function`"
%token KEYWORD_IF "`if`"
%token KEYWORD_MOD "`mod`"
%token KEYWORD_NOT "`not`"
%token KEYWORD_OF "`of`"
%token KEYWORD_PROGRAM "`program`"
%token KEYWORD_PROCEDURE "`procedure`"
%token KEYWORD_RECORD "`record`"
%token KEYWORD_THEN "`then`"
%token KEYWORD_TO "`to`"
%token KEYWORD_TYPE "`type`"
%token KEYWORD_VAR "`var`"
%token KEYWORD_WHILE "`while`"

/* Other Token Section */
%token IDENTIFIER "identifier"
%token STRING_LITERAL "string literal"
%token OP_ASSIGN "`:=`"

/* Number information */
%token INT "integer literal"
%token DECIMAL "real decimal literal"
%token EXP "real exp literal"

/* Operators */
%token OP_EQ "`=`"
%token OP_NEQ "`<>`"
%token OP_GE "`>=`"
%token OP_GT "`>`"
%token OP_LT "`<`"
%token OP_LE "`<=`"

%token OP_ADD "`+`"
%token OP_SUB "`-`"
%token OP_MUL "`*`"
%token OP_DIV "`/`"

%token OP_RANGE "`..`"

%token DOT "`.`"
%token COMMA "`,`"
%token SEMICOLON "`;`"
%token LPAREN "`(`"
%token RPAREN "`)`"
%token COLON "`:`"
%token LBRACKET "`[`"
%token RBRACKET "`]`"

%token END 0 "end-of-file"

%token INVALID_CHAR "invalid character"
%token UNTERMINATED_COMMENT "unterminated comment"
%token UNTERMINATED_QUOTE   "unterminated quote"

/* Non-Associative tokens */
%nonassoc LOWER_THAN_ELSE
%nonassoc KEYWORD_ELSE

/* 
    Destructor rules.
    WHY WHY WHY DO I HAVE TO DEFINE EVERY NODE OH GOD
    
    I recommend doing a Find All for ":" and then writing each nonterminal entry that way,
    better than actually scrolling around. Still godawful.
    
    I heard the new bison has default destructor rules for simple things like this,
    but we don't have that on linux.cis, so I had to resort to this hell.
 */
%destructor
{
    if(!pish::successfulParse)
    {
        delete $$;
    }
} IDENTIFIER STRING_LITERAL INT DECIMAL EXP
program program_head identifier_list compound_statement
decls decl
const_decl const_definitions const_definition
var_decl var_expressions var_expression
type_decl type_expressions type_expression
subprogram_decl subprogram subprogram_body subprogram_header parameter_list
statement_list statement if_statement while_statement for_statement
expression_list expression_list_ expression simple_expression term factor lower_factor subscripts subscripts_
type_identifier
const_expression array_dim_expression real return_type

/* Start node */
%start program

%%

/* Rules */

/**
 * The outermost unit of a Pish file.
 */
program: 
	KEYWORD_PROGRAM program_head
	decls
	compound_statement
	DOT
        {
            $$ = pish::programNode = new pish::Program(
                (pish::ProgramHead*) $2,
                new pish::ProgramBody(CONVERT(pish::DeclarationList*, $3), CONVERT(pish::StatementList*, $4), pish::lineNumber),
                pish::lineNumber
            );
            pish::successfulParse = true;
            YYACCEPT;
        }
	;

program_head:
	IDENTIFIER LPAREN identifier_list RPAREN SEMICOLON
		{
			$$ = new pish::ProgramHead(CONVERT(pish::Identifier*, $1), CONVERT(pish::IdentifierList*, $3), pish::lineNumber);
		}

/**
 *  A list of plain identifier tokens, used by variable declarations and stuff
 */
identifier_list:
	identifier_list COMMA IDENTIFIER
        {
            $$ = $1;
            CONVERT(pish::IdentifierList*, $1)->add(CONVERT(pish::Identifier*, $3));
        }
	| IDENTIFIER
        {
            pish::IdentifierList* list = new pish::IdentifierList(pish::lineNumber);
            list->add(CONVERT(pish::Identifier*, $1));
            
            $$ = list;
        }
	;

/**
 * A collection of statements, enclosed by a begin / end block
 */
compound_statement:
	KEYWORD_BEGIN statement_list
        {
            $$ = $2;
        }
	;

/**
 * A collection of declarations that a program needs, which can appear in any order
 */
decls:
	decls decl
        {
            $$ = $1;
            CONVERT(pish::DeclarationList*, $1)->add(CONVERT(pish::Declaration*, $2));
        }
	|
        {
            $$ = new pish::DeclarationList(pish::lineNumber);
        }
	;

/**
 * A declaration of some sort of global value used by the program.
 */
decl:
	var_decl { $$ = $1; }
	| const_decl { $$ = $1; }
	| type_decl { $$ = $1; }
	| subprogram_decl { $$ = $1; }
    | error SEMICOLON
        {
            pish::debugMessage("DEBUG: Error production in global section, skipping.\n");
            $$ = NULL;
            yyerrok;
        }
	;

/**
 * A collection of all of the constant variables to be created.
 */
const_decl:
	KEYWORD_CONST const_definitions
        {
            $$ = $2;
        }
	;

/**
 *  Allow for the recursion to allow for multiple expressions
 */
const_definitions:
	const_definitions const_definition
        {
            if($1)
            {
                $$ = $1;
                CONVERT(pish::DeclarationList*, $1)->add(CONVERT(pish::Declaration*, $2));
            }
            /* We need a way out if there was an error in one of the earlier declarations. */
            else
            {
                pish::DeclarationList* list = new pish::DeclarationList(pish::lineNumber);
                list->add(CONVERT(pish::Declaration*, $2));
                
                $$ = list;
            }
        }
	| const_definition
        {
            pish::DeclarationList* list = new pish::DeclarationList(pish::lineNumber);
            list->add(CONVERT(pish::Declaration*, $1));
            
            $$ = list;
        }
    | const_definitions error SEMICOLON
        {
            pish::debugMessage("DEBUG: Error production mid-list, skipping.\n");
            $$ = $1;
            yyerrok;
        }
    | error SEMICOLON
        {
            pish::debugMessage("DEBUG: Error production start-of-list, skipping.\n");
            $$ = NULL;
            yyerrok;
        }
	;

/**
 * Define the identifier expression details
 */
const_definition:
	IDENTIFIER OP_EQ const_expression SEMICOLON
        {
            $$  = new pish::ConstantDeclaration(CONVERT(pish::Identifier*, $1), CONVERT(pish::Expression*, $3), pish::lineNumber);
        }
	;

/**
 * A variable declaration, which adds a new variable that can be read / written to / from in executable code.
 */
var_decl:
	KEYWORD_VAR var_expressions_semi
        {
            $$ = $2;
        }
	;

/**
 * Recursion to allow for multiple variable declarations separated by semi-colons.
 */
var_expressions_semi:
	var_expressions_semi var_expressions SEMICOLON
        {
            if($1)
            {
                $$ = $1;
                CONVERT(pish::DeclarationList*, $1)->add(CONVERT(pish::Declaration*, $2));
            }
            /* We need a way out if there was an error in one of the earlier declarations. */
            else
            {
                pish::DeclarationList* list = new pish::DeclarationList(pish::lineNumber);
                list->add(CONVERT(pish::Declaration*, $2));
                
                $$ = list;
            }
        }
	| var_expressions SEMICOLON
        {
            pish::DeclarationList* list = new pish::DeclarationList(pish::lineNumber);
            list->add(CONVERT(pish::Declaration*, $1));
            
            $$ = list;
        }
    | var_expressions_semi error SEMICOLON
        {
            pish::debugMessage("DEBUG: Error production mid-list, skipping.\n");
            $$ = $1;
            yyerrok;
        }
    | error SEMICOLON
        {
            pish::debugMessage("DEBUG: Error production start-of-list, skipping.\n");
            $$ = NULL;
            yyerrok;
        }
	;

/**
 * Recursion to allow for multiple variable declarations separated by commas.
 */
var_expressions:
	var_expressions COMMA var_expression
        {
            $$ = $1;
            CONVERT(pish::DeclarationList*, $1)->add(CONVERT(pish::Declaration*, $3));
        }
	| var_expression
        {
            pish::DeclarationList* list = new pish::DeclarationList(pish::lineNumber);
            list->add(CONVERT(pish::Declaration*, $1));
            
            $$ = list;
        }
	;

/**
 * Define the variable identifier expression details
 */
var_expression:
	identifier_list COLON type_identifier
        {
            $$ = new pish::VariableDeclaration(CONVERT(pish::IdentifierList*, $1), CONVERT(pish::TypeDefinition*, $3), pish::lineNumber);
        }
	;

/**
 * A strong type alias.  Defines a type in terms of another type, defined previously.
 */
type_decl:
	KEYWORD_TYPE type_expressions
        {
            $$ = $2;
        }
	;

/**
 * Allow for the recursion to allow for mutliple expressions
 */
type_expressions:
	type_expressions type_expression
        {
            if($1)
            {
                $$ = $1;
                CONVERT(pish::DeclarationList*, $1)->add(CONVERT(pish::Declaration*, $2));
            }
            /* We need a way out if there was an error in one of the earlier declarations. */
            else
            {
                pish::DeclarationList* list = new pish::DeclarationList(pish::lineNumber);
                list->add(CONVERT(pish::Declaration*, $2));
                
                $$ = list;
            }
        }
	| type_expression
        {
            pish::DeclarationList* list = new pish::DeclarationList(pish::lineNumber);
            list->add(CONVERT(pish::Declaration*, $1));
            
            $$ = list;
        }
    | type_expressions error SEMICOLON
        {
            pish::debugMessage("DEBUG: Error production mid-list, skipping.\n");
            $$ = $1;
            yyerrok;
        }
    | error SEMICOLON
        {
            pish::debugMessage("DEBUG: Error production start-of-list, skipping.\n");
            $$ = NULL;
            yyerrok;
        }
	;

/**
 * Define the variable identifier type expression.
 */
type_expression:
	IDENTIFIER OP_EQ type_identifier SEMICOLON
        {
            $$ = new pish::AliasDeclaration(CONVERT(pish::Identifier*, $1), CONVERT(pish::TypeDefinition*, $3), pish::lineNumber);
        }
	;

/**
 * A subprogram definition
 */
subprogram_decl:
	subprogram
        {
            $$ = new pish::ProgramDeclaration(CONVERT(pish::Program*, $1), pish::lineNumber);
        }
	;

/**
 * A subprogram definition.
 * Consists of a head, followed by a body.
 */
subprogram:
	subprogram_header subprogram_body
        {
            $$ = new pish::Program(CONVERT(pish::ProgramHead*, $1), CONVERT(pish::ProgramBody*, $2), pish::lineNumber);
        }
	;

/**
 * Subprogram definition, which can be a procedure or function.
 * Describes the parameters and (if a function) the return type associated with this subprogram
 */
subprogram_header:
	KEYWORD_FUNCTION IDENTIFIER LPAREN parameter_list RPAREN COLON return_type SEMICOLON
        {
            $$ = new pish::ProgramHead(CONVERT(pish::Identifier*, $2), CONVERT(pish::TypeDefinition*, $7), CONVERT(pish::DeclarationList*, $4), pish::lineNumber);
        }
	| KEYWORD_PROCEDURE IDENTIFIER LPAREN parameter_list RPAREN SEMICOLON
        {
            $$ = new pish::ProgramHead(CONVERT(pish::Identifier*, $2), NULL, CONVERT(pish::DeclarationList*, $4), pish::lineNumber);
        }
    | KEYWORD_FUNCTION error SEMICOLON 
        {
            pish::debugMessage("DEBUG: failed function header.\n");
            $$ = NULL;
            yyerrok;
        }
    | KEYWORD_PROCEDURE error SEMICOLON 
        {
            pish::debugMessage("DEBUG: failed procedure header.\n");
            $$ = NULL;
            yyerrok;
        }
	;
    
/**
 * The body of a subprogram.
 * Can be a bunch of local declarations followed by a compound statement block,
 * or a forward declaration of a function defined later.
 */
subprogram_body:
	decls compound_statement SEMICOLON
        {
            $$ = new pish::ProgramBody(CONVERT(pish::DeclarationList*, $1), CONVERT(pish::StatementList*, $2), pish::lineNumber);
        }
	| KEYWORD_FORWARD SEMICOLON
        {
            /* No body declared here (forward declaration). */
            $$ = NULL;
        }
	| error SEMICOLON
        {
            /* Error. */
            pish::debugMessage("DEBUG: failed subprogram body.\n");
            $$ = NULL;
        }
	;


/**
 * A formal parameter list describing the values that must be passed to the subprogram.
 */
parameter_list:
	var_expressions
        {
            $$ = $1;
        }
	|
        {
            $$ = new pish::DeclarationList(pish::lineNumber);
        }
	;
 
/**
 * A list of statements, a single statement or an empty list.
 */
statement_list:
    statement_list_ statement KEYWORD_END
        {
            if($1)
            {
                $$ = $1;
                CONVERT(pish::StatementList*, $1)->add(CONVERT(pish::Statement*, $2));
            }
            /* We need a way out if there was an error in one of the earlier declarations. */
            else
            {
                $$ = NULL;
            }
        }
    | statement KEYWORD_END
        {
            pish::StatementList* list = new pish::StatementList(pish::lineNumber);
            list->add(CONVERT(pish::Statement*, $1));
            $$ = list;
        }
    | error KEYWORD_END
        {
            pish::debugMessage("DEBUG: ERROR BEFORE END\n");
            $$ = NULL;
            yyerrok;
        }
    | KEYWORD_END
        {
            $$ = new pish::StatementList(pish::lineNumber);
        }
 
/**
 * A list of statements, separated (not terminated) by semi-colons.
 */
statement_list_:
	statement_list_ statement SEMICOLON
        {
            if($1)
            {
                $$ = $1;
                CONVERT(pish::StatementList*, $1)->add(CONVERT(pish::Statement*, $2));
            }
            /* We need a way out if there was an error in one of the earlier declarations. */
            else
            {
                $$ = NULL;
            }
        }
	| statement SEMICOLON
        {
            pish::StatementList* list = new pish::StatementList(pish::lineNumber);
            list->add(CONVERT(pish::Statement*, $1));
            
            $$ = list;
        }
    | statement_list_ error SEMICOLON
        {
            pish::debugMessage("DEBUG: Error production mid-stmt list, skipping.\n");
            $$ = $1;
            yyerrok;
        }
    | error SEMICOLON
        {
            pish::debugMessage("DEBUG: Error production start-of-stmt list, skipping.\n");
            $$ = NULL;
            yyerrok;
        }
	;
    
/**
 * An executable code statement.
 */
statement:
	IDENTIFIER subscripts OP_ASSIGN expression
        {
            $$ = new pish::AssignmentStatement(new pish::Variable(CONVERT(pish::Identifier*, $1), CONVERT(pish::SubscriptList*, $2), pish::lineNumber), CONVERT(pish::Expression*, $4), pish::lineNumber);
        }
    | IDENTIFIER LPAREN expression_list RPAREN
        {
            $$ = new pish::CallStatement(new pish::ProgramInvocation(CONVERT(pish::Identifier*, $1), CONVERT(pish::ExpressionList*, $3), pish::lineNumber), pish::lineNumber);
        }
	| if_statement { $$ = $1; }
	| compound_statement { $$ = $1; }
	| while_statement { $$ = $1; }
	| for_statement { $$ = $1; }
	;

/**
 * An if statement (with optional else clause), which executes its statement
 * when its conditional expression is true.
 * Otherwise, the else statement (when one is provided) is executed.
 */
if_statement:
	KEYWORD_IF expression KEYWORD_THEN statement %prec LOWER_THAN_ELSE
        {
            $$ = new pish::IfStatement(CONVERT(pish::Expression*, $2), CONVERT(pish::Statement*, $4), NULL, pish::lineNumber);
        }
	| KEYWORD_IF expression KEYWORD_THEN statement KEYWORD_ELSE statement
        {
            $$ = new pish::IfStatement(CONVERT(pish::Expression*, $2), CONVERT(pish::Statement*, $4), CONVERT(pish::Statement*, $6), pish::lineNumber);
        }
	;

/**
 * A while loop, which repeats as long as its conditional expression is true.
 */
while_statement:
	KEYWORD_WHILE expression KEYWORD_DO statement
        {
            $$ = new pish::WhileStatement(CONVERT(pish::Expression*, $2), CONVERT(pish::Statement*, $4), pish::lineNumber);
        }
	;
/**
 * A counting for loop which defines an integer sequence to iterate over.
 */
for_statement:
	KEYWORD_FOR IDENTIFIER subscripts OP_ASSIGN expression KEYWORD_TO expression KEYWORD_DO statement
        {
            $$ = new pish::ForStatement(
                new pish::Variable(
                    CONVERT(pish::Identifier*, $2), CONVERT(pish::SubscriptList*, $3), pish::lineNumber
                ),
                CONVERT(pish::Expression*, $5),
                CONVERT(pish::Expression*, $7),
                pish::ForStatement::FOR_TO,
                CONVERT(pish::Statement*, $9),
                pish::lineNumber
            );
        }
    | KEYWORD_FOR IDENTIFIER subscripts OP_ASSIGN expression KEYWORD_DOWNTO expression KEYWORD_DO statement
        {
            $$ = new pish::ForStatement(
                new pish::Variable(
                    CONVERT(pish::Identifier*, $2), CONVERT(pish::SubscriptList*, $3), pish::lineNumber
                ),
                CONVERT(pish::Expression*, $5),
                CONVERT(pish::Expression*, $7),
                pish::ForStatement::FOR_DOWNTO,
                CONVERT(pish::Statement*, $9),
                pish::lineNumber
            );
        }
	;

/**
 * An optional list of comma separated expressions.
 */
expression_list:
	expression_list_
        {
            $$ = $1;
        }
	|
        {
            $$ = new pish::ExpressionList(pish::lineNumber);
        }
	;
    
/**
 * A list of one or more expressions, separated by commas.
 */
expression_list_:
	expression_list_ COMMA expression
        {
            $$ = $1;
            CONVERT(pish::ExpressionList*, $1)->add(CONVERT(pish::Expression*, $3));
        }
	| expression
        {
            pish::ExpressionList* list = new pish::ExpressionList(pish::lineNumber);
            list->add(CONVERT(pish::Expression*, $1));
            
            $$ = list;
        }
	;
    
/**
 * A base expression.
 * Relational operators are lowest precedence.
 */    
expression:
	expression OP_EQ simple_expression
        {
            $$ = new pish::Expression(new pish::Operator(pish::Operator::B_EQ, CONVERT(pish::Expression*, $1), CONVERT(pish::Expression*, $3), pish::lineNumber), pish::lineNumber); 
        }
	| expression OP_NEQ simple_expression
        {
            $$ = new pish::Expression(new pish::Operator(pish::Operator::B_NEQ, CONVERT(pish::Expression*, $1), CONVERT(pish::Expression*, $3), pish::lineNumber), pish::lineNumber); 
        }
	| expression OP_GE simple_expression
        {
            $$ = new pish::Expression(new pish::Operator(pish::Operator::B_GE, CONVERT(pish::Expression*, $1), CONVERT(pish::Expression*, $3), pish::lineNumber), pish::lineNumber); 
        }
	| expression OP_GT simple_expression
        {
            $$ = new pish::Expression(new pish::Operator(pish::Operator::B_GT, CONVERT(pish::Expression*, $1), CONVERT(pish::Expression*, $3), pish::lineNumber), pish::lineNumber); 
        }
	| expression OP_LE simple_expression
        {
            $$ = new pish::Expression(new pish::Operator(pish::Operator::B_LE, CONVERT(pish::Expression*, $1), CONVERT(pish::Expression*, $3), pish::lineNumber), pish::lineNumber); 
        }
	| expression OP_LT simple_expression
        {
            $$ = new pish::Expression(new pish::Operator(pish::Operator::B_LT, CONVERT(pish::Expression*, $1), CONVERT(pish::Expression*, $3), pish::lineNumber), pish::lineNumber); 
        }
	| simple_expression
        {
            $$ = $1;
        }
	;

/**
 * A simple add/subtract expression.
 */
simple_expression:
	simple_expression OP_ADD term
        {
            $$ = new pish::Expression(new pish::Operator(pish::Operator::B_ADD, CONVERT(pish::Expression*, $1), CONVERT(pish::Expression*, $3), pish::lineNumber), pish::lineNumber); 
        }
    | simple_expression OP_SUB term
        {
            $$ = new pish::Expression(new pish::Operator(pish::Operator::B_SUB, CONVERT(pish::Expression*, $1), CONVERT(pish::Expression*, $3), pish::lineNumber), pish::lineNumber); 
        }
	| term { $$ = $1; }
	;
    
/**
 * An expression term consisting of multiplicative operations.
 */
term:
	term OP_MUL factor
        {
            $$ = new pish::Expression(new pish::Operator(pish::Operator::B_MUL, CONVERT(pish::Expression*, $1), CONVERT(pish::Expression*, $3), pish::lineNumber), pish::lineNumber); 
        }
	| term OP_DIV factor
        {
            $$ = new pish::Expression(new pish::Operator(pish::Operator::B_RDIV, CONVERT(pish::Expression*, $1), CONVERT(pish::Expression*, $3), pish::lineNumber), pish::lineNumber); 
        }
    | term KEYWORD_DIV factor
        {
            $$ = new pish::Expression(new pish::Operator(pish::Operator::B_IDIV, CONVERT(pish::Expression*, $1), CONVERT(pish::Expression*, $3), pish::lineNumber), pish::lineNumber); 
        }
    | term KEYWORD_MOD factor
        {
            $$ = new pish::Expression(new pish::Operator(pish::Operator::B_MOD, CONVERT(pish::Expression*, $1), CONVERT(pish::Expression*, $3), pish::lineNumber), pish::lineNumber); 
        }
    | term KEYWORD_AND factor
        {
            $$ = new pish::Expression(new pish::Operator(pish::Operator::B_AND, CONVERT(pish::Expression*, $1), CONVERT(pish::Expression*, $3), pish::lineNumber), pish::lineNumber); 
        }
	| factor
        {
            $$ = $1;
        }
	;
    
/**
 * An expression factor which can optionally be preceded by a sign.
 */
factor:
	OP_ADD factor
        {
            $$ = $2;
        }
    | OP_SUB factor
        {
            $$ = new pish::Expression(new pish::Operator(pish::Operator::U_NEGATE, CONVERT(pish::Expression*, $2), NULL, pish::lineNumber), pish::lineNumber); 
        }
    | KEYWORD_NOT factor
        {
            $$ = new pish::Expression(new pish::Operator(pish::Operator::U_NOT, CONVERT(pish::Expression*, $2), NULL, pish::lineNumber), pish::lineNumber); 
        }    
	| lower_factor
        {
            $$ = $1;
        }
	;

/**
 * A literal, variable, or function call.
 */
lower_factor:
	IDENTIFIER subscripts
        {
            $$ = new pish::Expression(new pish::Variable(CONVERT(pish::Identifier*, $1), CONVERT(pish::SubscriptList*, $2), pish::lineNumber), pish::lineNumber);
        }
	| IDENTIFIER LPAREN expression_list RPAREN
        {
            $$ = new pish::Expression(new pish::ProgramInvocation(CONVERT(pish::Identifier*, $1), CONVERT(pish::ExpressionList*, $3), pish::lineNumber), pish::lineNumber);
        }
	| real
        {
            $$ = new pish::Expression(CONVERT(pish::Literal*, $1), pish::lineNumber);
        }
	| STRING_LITERAL
        {
            $$ = new pish::Expression(CONVERT(pish::Literal*, $1), pish::lineNumber);
        }
	| LPAREN expression RPAREN
        {
            $$ = $2;
        }
	;

/**
 * Indexing of variable (if any), for array and record types.
 */
subscripts:
    subscripts_
        {
            $$ = $1;
        }
    |
        {
            $$ = NULL;
        }

/**
 * Indexing of variable, for array and record types.
 */
subscripts_:
    subscripts_ LBRACKET expression RBRACKET
        {
            CONVERT(pish::SubscriptList*, $1)->add(new pish::Subscript(CONVERT(pish::Expression*, $3), pish::lineNumber));
            $$ = $1;
        }
    | subscripts_ DOT IDENTIFIER
        {
            CONVERT(pish::SubscriptList*, $1)->add(new pish::Subscript(CONVERT(pish::Identifier*, $3), pish::lineNumber));
            $$ = $1;
        }
    | LBRACKET expression RBRACKET
        {
            pish::SubscriptList* list = new pish::SubscriptList(pish::lineNumber);
            list->add(new pish::Subscript(CONVERT(pish::Expression*, $2), pish::lineNumber));
            $$ = list;
        }
    | DOT IDENTIFIER
        {
            pish::SubscriptList* list = new pish::SubscriptList(pish::lineNumber);
            list->add(new pish::Subscript(CONVERT(pish::Identifier*, $2), pish::lineNumber));
            $$ = list;
        }
    ;
    
/**
 * An expression that can appear anywhere a type is expected.
 */    
type_identifier:
	IDENTIFIER
        {
            $$ = new pish::TypeDefinition(CONVERT(pish::Identifier*, $1), pish::lineNumber);
        }
	| KEYWORD_ARRAY LBRACKET array_dim_expression OP_RANGE array_dim_expression RBRACKET KEYWORD_OF type_identifier
        {
            $$ = new pish::TypeDefinition(CONVERT(pish::TypeDefinition*, $8), CONVERT(pish::Expression*, $3), CONVERT(pish::Expression*, $5), pish::lineNumber);
        }
	| KEYWORD_RECORD var_expressions_semi KEYWORD_END
        {
            $$ = new pish::TypeDefinition(CONVERT(pish::DeclarationList*, $2), pish::lineNumber);
        }
	;

/**
 * An expression that can appear in const declaration.
 */
const_expression:
	real
        {
            $$ = new pish::Expression(CONVERT(pish::Literal*, $1), pish::lineNumber);
        }
	| IDENTIFIER
        {
            $$ = new pish::Expression(new pish::Variable(CONVERT(pish::Identifier*, $1), NULL, pish::lineNumber), pish::lineNumber);
        }
	| STRING_LITERAL
        {
            $$ = new pish::Expression(CONVERT(pish::Literal*, $1), pish::lineNumber);
        }
	| OP_SUB real
        {
            $$ = new pish::Expression(new pish::Operator(pish::Operator::U_NEGATE, new pish::Expression(CONVERT(pish::Literal*, $2), pish::lineNumber), NULL, pish::lineNumber), pish::lineNumber);
        }
	| OP_SUB IDENTIFIER
        {
            $$ = new pish::Expression(new pish::Operator(pish::Operator::U_NEGATE, new pish::Expression(new pish::Variable(CONVERT(pish::Identifier*, $2), NULL, pish::lineNumber), pish::lineNumber), NULL, pish::lineNumber), pish::lineNumber);
        }
	;

/**
 * An expression that can appear in the dimension array declaration. Must be an integer.
 */
array_dim_expression:
	INT
        {
            $$ = new pish::Expression(CONVERT(pish::Literal*, $1), pish::lineNumber);
        }
	| IDENTIFIER
        {
            $$ = new pish::Expression(new pish::Variable(CONVERT(pish::Identifier*, $1), NULL, pish::lineNumber), pish::lineNumber);
        }
	| OP_SUB INT
        {
            $$ = new pish::Expression(new pish::Operator(pish::Operator::U_NEGATE, new pish::Expression(CONVERT(pish::Literal*, $2), pish::lineNumber), NULL, pish::lineNumber), pish::lineNumber);
        }
	| OP_SUB IDENTIFIER
        {
            $$ = new pish::Expression(new pish::Operator(pish::Operator::U_NEGATE, new pish::Expression(new pish::Variable(CONVERT(pish::Identifier*, $2), NULL, pish::lineNumber), pish::lineNumber), NULL, pish::lineNumber), pish::lineNumber);
        }
	;

/**
 * A value acceptable for a real number.
 */
real:
	INT { $$ = $1; }
	| DECIMAL { $$ = $1; }
	| EXP { $$ = $1; }
	;

/**
 * A valid value for a return type. Must be a simple primitive type or a type alias for one.
 */
return_type:
	IDENTIFIER { $$ = new pish::TypeDefinition(CONVERT(pish::Identifier*, $1), pish::lineNumber); }
	;


%%

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
