#pragma once

#include <typeinfo>
#include <string>
#include <vector>
#include <stdexcept>

#include <stdio.h>
#include <stdarg.h>

#define YYSTYPE pish::AbstractNode*
//#define DEBUG
#ifdef DEBUG
#undef DEBUG
#endif

extern "C"
{
    int yylex();
    void yyerror (const char *);
    int yywrap ();
}
extern FILE* yyin;

namespace pish
{
    extern unsigned int lineNumber;
    extern AbstractNode* programNode;
    extern bool successfulParse;
    extern std::string parseFilename;
    extern unsigned int errorCount;
    
    enum CommentType
    {
    	COMMENT_BRACE,
    	COMMENT_PAREN,
    };
    
    bool handleComment(CommentType type);
    std::string handleQuotes ( char curr, bool * result );
    void flushBuffer();

    void error(const char* str);
    void error(const char* message, int currentLine);
    const char* getActiveFile();
    void toLowercase(char* s);
    
    template <typename T>
    T _convert(AbstractNode* node, const char* file, int line)
    {
        if(node == NULL) return NULL;
        else
        {
            T result = dynamic_cast<T>(node);
            if(!result)
            {
                char message[4096];
                sprintf(message, "Failed to cast '%s' node to '%s' in %s at line %d.", typeid(*node).name(), typeid(T).name(), file, line);
                throw std::runtime_error(message); 
            }
            else
            {
                return result;
            }
        }
    }

    inline void debugMessage(const char* format, ...)
    {
        va_list args;
        va_start (args, format);
#ifdef DEBUG
        vfprintf(stderr, format, args);
#endif
        va_end (args);
    }
    
    class VariableDeclaration;
    class DeclarationList;
    size_t countDeclarations(const std::vector<VariableDeclaration*>& signature);
    void flattenVariableDeclarationList(DeclarationList* list, std::vector<VariableDeclaration*>& result);
}

#define CONVERT(T, e) pish::_convert<T>((e), __FILE__, __LINE__)
