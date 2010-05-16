/*
 * Course: CIS*4650
 * Authors: Andrew Crowell, Andrew Judd
 */

%{

#include <sstream>

#include "common.h"
#include "y.tab.hpp"

%}

ALPHA   [a-zA-Z]
ALNUM   [a-zA-Z0-9]
NUM     [0-9]+
SIGN    [\+\-]

%%

    /* Keyword tokens */
[aA][nN][dD]                            return KEYWORD_AND;
[cC][oO][nN][sS][tT]                    return KEYWORD_CONST;
[dD][iI][vV]                            return KEYWORD_DIV;
[dD][oO]                                return KEYWORD_DO;
[dD][oO][wW][nN][tT][oO]                return KEYWORD_DOWNTO;
[eE][lL][sS][eE]                        return KEYWORD_ELSE;
[aA][rR][rR][aA][yY]                    return KEYWORD_ARRAY;
[bB][eE][gG][iI][nN]                    return KEYWORD_BEGIN;
[eE][nN][dD]                            return KEYWORD_END;
[fF][oO][rR]                            return KEYWORD_FOR;
[fF][oO][rR][wW][aA][rR][dD]            return KEYWORD_FORWARD;
[fF][uU][nN][cC][tT][iI][oO][nN]        return KEYWORD_FUNCTION;
[iI][fF]                                return KEYWORD_IF;
[mM][oO][dD]                            return KEYWORD_MOD;
[nN][oO][tT]                            return KEYWORD_NOT;
[oO][fF]                                return KEYWORD_OF;            
[pP][rR][oO][cC][eE][dD][uU][rR][eE]    return KEYWORD_PROCEDURE;
[pP][rR][oO][gG][rR][aA][mM]            return KEYWORD_PROGRAM;
[rR][eE][cC][oO][rR][dD]                return KEYWORD_RECORD;
[tT][hH][eE][nN]                        return KEYWORD_THEN;
[tT][oO]                                return KEYWORD_TO;
[tT][yY][pP][eE]                        return KEYWORD_TYPE;
[vV][aA][rR]                            return KEYWORD_VAR;
[wW][hH][iI][lL][eE]                    return KEYWORD_WHILE;

    /**
        A valid token allowed for naming a variable, constant, type, or (sub)program.
    */ 
[a-zA-Z_][a-zA-Z0-9_]*                  {
                                            pish::toLowercase(yytext);
                                            yylval = new pish::Identifier(yytext, pish::lineNumber);
                                            return IDENTIFIER;
                                        }
{NUM}                                   { yylval = new pish::Literal(atoi(yytext), pish::lineNumber); return INT; }
{NUM}\.({NUM})?                          { yylval = new pish::Literal(atof(yytext), pish::lineNumber); return DECIMAL; }
({NUM})?\.{NUM}                          { yylval = new pish::Literal(atof(yytext), pish::lineNumber); return DECIMAL; }
{NUM}(\.?)({NUM})?[eE]({SIGN})?{NUM}    { yylval = new pish::Literal(atof(yytext),pish::lineNumber); return EXP; }
\:\=                                    return OP_ASSIGN;
\.\.                                    return OP_RANGE;

    /* Whitespace tokens. */
\n                                         pish::lineNumber++; /* Increase line count, emit nothing. */
[\r\t ]+                                /* ignore whitespace */;
    /* Strings. */
'|\"                   {
                        bool result;
                        yylval = new pish::Literal(pish::handleQuotes ( yytext [ 0 ], &result ).c_str (),pish::lineNumber);

                        if ( result == false )
                        {
                                char msg [ 128 ];
                                sprintf ( msg, "error, unterminated single quote before end-of-file." );
                                yyerror ( msg );
                                return ( UNTERMINATED_QUOTE );
                        }
                        
                        return STRING_LITERAL;
                    }


    /* Comments. */
\{                  { /* Brace comment. */ 
                        bool result = pish::handleComment ( pish::COMMENT_BRACE );

                        if (result == false)
                        {
                            char msg[128];
                            sprintf(msg, "error, brace comment not terminated before end-of-file.");
                            yyerror(msg);
                            return UNTERMINATED_COMMENT;
                        }
                    }
\(\*                { /* Paren-star comment. */
                        bool result = pish::handleComment( pish::COMMENT_PAREN ); 

                        if (result == false)
                        {
                            char msg[128];
                            sprintf(msg, "error, parenthesis star comment not terminated before end-of-file.");
                            yyerror(msg);
                            return UNTERMINATED_COMMENT;
                        }
                    }

    /* Relational Operators. */
\<                                      return OP_LT;
\>                                      return OP_GT;
=                                       return OP_EQ;
\<\>                                    return OP_NEQ;
\<=                                     return OP_LE;
\>=                                     return OP_GE;
    /* Arithmetic Operators. */
\+                                      return OP_ADD;
\-                                      return OP_SUB;
\*                                      return OP_MUL;
\/                                      return OP_DIV;

    /* Punctuation. */
\,                                      { return COMMA; }
\(                                      { return LPAREN; }
\)                                      { return RPAREN; }
\;                                      { return SEMICOLON; }
\.                                      { return DOT; }
\:                                      { return COLON; }
\[                                      { return LBRACKET; }
\]                                      { return RBRACKET; }

    /* Invalid character. */
.                                       { char msg[128]; sprintf(msg, "error, invalid character `%c` found.", yytext[0]); yyerror(msg); return INVALID_CHAR; }

%%

namespace pish
{
	bool handleComment(CommentType type)
	{
		/* Next Characters */
		char c, c2;

		while ( 1 )
		{
			/* Read in the first character */
			c = yyinput();

			switch (c)
			{
				/* These two cases need additional lookahead */
				case '(':
				case '*':
					/* If we need to have another lookahead, read it in */
					c2 = yyinput();

					/* Check to see if the second will satisfy us */
					switch (c2)
					{
						case '*':
							/* Check if we are opening a new paren-star comment */
							if(c == '(')
							{
								if(!handleComment(COMMENT_PAREN))
								{
									return false;
								}
							}
							break;
						case ')':
							/* Check if we are terminated a comment */
							if(c == '*' && type == COMMENT_PAREN)
							{
								return true;
							}
							break;
						default:
							/* Replace the value */
							unput(c2);
					}
					break;
				case '{': 
					/* Nested comment */
					if(!handleComment(COMMENT_BRACE))
					{
						/* Propagate the failure through */
						return false;
					}
					break;
				case '}': 
					/* No more comments */
					if(type == COMMENT_BRACE)
					{
						return true;
					}
					/* Otherwise, keep looking */
					break;
				case '\n':
					lineNumber++;
					break;
				case EOF:
					return false;
				default:
					/* Do nothing */
					break;
			}
		}
	}

        std::string handleQuotes ( char current, bool * complete )
        {
                std::ostringstream buffer;
                char curr = '\0', prev = '\0';
                bool running = true;

                /* Write the opening quote to the buffer */
                buffer << current;

                while ( running == true )
                {
                        /* Copy the previous data over */
                        prev = curr;
                        curr = yyinput ();

                        /*
                         * If we have an escaped slash, we can't use it for
                         * escaping other things so just add it to the buffer
                         * and then ignore it
                         */
                        if ( prev == '\\' )
                        {
                                /* Already have a slash, now what to do */
                                switch ( curr )
                                {
                                        case '\\':
                                                buffer << '\\';
                                                break;
                                        case '\'':
                                                buffer << curr;
                                                break;
                                        case '\"':
                                                buffer << '\"';
                                                break;
                                        case 't':
                                                buffer << '\t';
                                                break;
                                        case 'n':
                                                buffer << '\n';
                                                break;
                                        case 'r':
                                                buffer << '\r';
                                                break;
                                        case 'v':
                                                buffer << '\v';
                                                break;
                                        case 'b':
                                                buffer << '\b';
                                                break;
                                        case 'a':
                                                buffer << '\a';
                                                break;
                                        case 'f':
                                                buffer << '\f';
                                                break;
                                        case '0':
                                                buffer << '\0';
                                                break;
                                        default:
                                                buffer << '\\' << curr;

                                }
                               curr = '\0';
                        }
                        /* Make sure we aren't escaped */
                        else if ( prev != '\\' && curr == current )
                        {
                                buffer << ( char )  curr;
                                *complete = true;

                                /* Not escaped? then we are at the end of the string */
                                break;
                        }
                        /* Make sure we don't hit the end of the file */
                        else if ( curr == EOF || curr == '\0' )
                        {
                                /* Mark the flag for error */
                                *complete = false;
                                running = false;
                        }
                        /* If our last character was a  */
                        else if ( curr == '\\' )
                        {
                                /* Do nothing (we'll process next time) */
                        }
                        /* Otherwise, we just need to copy it over */
                        else
                        {
                                buffer << curr;
                        }
                }

                return ( buffer.str () );
        }

    void flushBuffer()
    {
        YY_FLUSH_BUFFER;
    }
}

