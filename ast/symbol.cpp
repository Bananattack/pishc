#include <vector>
#include <iostream>
#include <sstream>
#include <limits.h>

#include "literal.h"
#include "declaration.h"
#include "type_definition.h"
#include "program.h"
#include "symbol.h"
#include "common.h"


namespace pish
{	
	SymbolTable* activeScope = NULL;
    std::vector<SymbolTable*> scopeStack;
 
    SymbolTable* typeScope = NULL;
    std::vector<SymbolTable*> typeStack;
	
	Symbol::Symbol(SymbolCategory category)
	{
		this->category = category;
        init();
	}	
	
	Symbol::Symbol(TypeDefinition* typeBinding)
	{
        category = SYM_TYPE_BINDING;
		this->typeBinding = typeBinding;
        init();
	}	
	
	Symbol::Symbol(Literal* constantBinding)
	{
        category = SYM_CONSTANT_BINDING;
		this->constantBinding = constantBinding;
        init();
	}
	
	Symbol::Symbol(Program* programBinding)
	{
        category = SYM_PROGRAM_BINDING;
		this->programBinding = programBinding;
        init();
	}	
	
	Symbol::Symbol(VariableDeclaration* variableBinding)
	{
        category = SYM_VARIABLE_BINDING;
		this->variableBinding = variableBinding;
        init();
	}
	
	Symbol::Symbol(Expression* temporaryExpression)
	{
        category = SYM_TEMPORARY;
		this->temporaryExpression = temporaryExpression;
        init();
	}
    
    void Symbol::init()
    {
        lineNumber = depth = offset = 0;
        isScopeSelf = false;
        isReference = false;
    }
	
	Symbol::~Symbol()
	{
		switch(category)
		{
			case SYM_TYPE_BINDING:
				//delete typeBinding;
				break;
			case SYM_CONSTANT_BINDING:
				delete constantBinding;
				break;
			case SYM_PROGRAM_BINDING:
				//delete programBinding;
				break;
			case SYM_VARIABLE_BINDING:
				//delete variableBinding;
				break;
			default:
				break;
		}
	}
	
	
    bool Symbol::isBuiltin()
    {
    	return category == SYM_INTEGER
    		|| category == SYM_CHAR
    		|| category == SYM_REAL
    		|| category == SYM_WRITEINT
    		|| category == SYM_WRITECHAR
    		|| category == SYM_WRITESTR
    		|| category == SYM_WRITEREAL
    		|| category == SYM_TOINTEGER
    		|| category == SYM_TOREAL
    		|| category == SYM_RANDOM
    		|| category == SYM_READINT
    		|| category == SYM_READREAL
    		|| category == SYM_READCHAR
    		; 
    }
    
    void Symbol::dump(FILE* f, int depth)
    {
        switch(category)
        {
            case SYM_INTEGER:
                fprintf(f, "primitive type integer\n");
                break;
            case SYM_CHAR:
                fprintf(f, "primitive type char\n");
                break;
            case SYM_REAL:
                fprintf(f, "primitive type real\n");
                break;
            case SYM_TYPE_BINDING:
                fprintf(f, "alias for type %s\n", typeBinding->getSimpleName().c_str());
                break;
            case SYM_CONSTANT_BINDING:
                fprintf(f, "constant of type %s\n", constantBinding->getRepresentation().c_str());
                break;
            case SYM_WRITEINT:
            case SYM_WRITEREAL:
            case SYM_WRITECHAR:
            case SYM_WRITESTR:
            case SYM_TOINTEGER:
            case SYM_TOREAL:
            case SYM_RANDOM:
            case SYM_READINT:
            case SYM_READREAL:
            case SYM_READCHAR:
                fprintf(f, "built-in procedure or function\n");
                break;
            case SYM_PROGRAM_BINDING:
                if(isScopeSelf)
                {
                    fprintf(f, "self (used for return value assignment, and self-recursion)\n");
                }
                else
                {
                    if(programBinding->head->returnValue)
                    {
                        fprintf(f, "function with return type %s (parameters in symbol table)\n", programBinding->head->returnValue->getSimpleName().c_str());
                    }
                    else
                    {
                        fprintf(f, "procedure (parameters in symbol table)\n");
                    }

                    dumpFormat(f, depth + 1, "LOCAL SYMBOL TABLE (VARIABLES, CONSTANTS, SUBPROGRAMS):\n");
                    dumpTableData<SymbolTable>(programBinding->localSymbols, f, depth + 2);
                    dumpFormat(f, depth + 1, "LOCAL TYPE TABLE:\n");
                    dumpTableData<SymbolTable>(programBinding->localTypes, f, depth + 2);
                }
                break;
            case SYM_VARIABLE_BINDING:
                fprintf(f, "variable of type %s\n", variableBinding->type->getSimpleName().c_str());
                break;  
			case SYM_MAIN_PROGRAM_PARAMETER:
				fprintf(f, "main program parameter\n");
				break;
			case SYM_TEMPORARY:
				fprintf(f, "temporary expr (offset %d)\n", offset);
				break;
        }
    }
    
    
    
    SymbolTable::SymbolTable(SymbolTable* parent)
    {
        offset = 0;
        this->parent = parent;
        this->temporaryIndex = 0;
        if(parent)
        {
            depth = parent->depth + 1;
			contentText = parent->contentText;
        }
        else
        {
            depth = 0;
			contentText = "symbol";
        }
    }
    
    SymbolTable::~SymbolTable()
    {
        Iterator it;
        for(it = begin(); it != end(); ++it)
        {
            delete it->second;
        }
        map.clear();
    }
    
    void SymbolTable::put(std::string key, Symbol* value, int currentLine)
    {
        // Perform search without inheritance to only whine if the symbol was already declared in this scope.
        // This way functions can have locals that use the same name as somewhere in the parent, without problems.
        // (get always looks at current scope and works up, there is no ambiguity)
        Symbol* symbol = tryGet(key, false);
        
        //fprintf(stderr, "DEBUG: <<%d>> ADDING '%s' on line %d at offset %d\n", depth, key.c_str(), currentLine, offset);
        if(symbol)
        {
            std::ostringstream message;

            message << "error, redefinition of ";
            if(symbol->isBuiltin() || symbol->lineNumber == 0)
            {
                message << "built-in symbol `" << key << "`";
            }
            else
            {
                message << "symbol `" << key << "`, previously defined on line " << symbol->lineNumber;
            }
            error(message.str().c_str(), currentLine);
        }
        
        value->lineNumber = currentLine;
        value->offset = offset;
        value->depth = depth;
        map[key] = value;
    }
    
    Symbol* SymbolTable::get(std::string key, int currentLine)
    {
        Symbol* symbol = tryGet(key, true);
        
        if(!symbol)
        {
            std::ostringstream message;
            message << "error, reference to undefined " << contentText << " `" << key << "`";
            error(message.str().c_str(), currentLine);
            return NULL;
        }
        return symbol;
    }
    
    Symbol* SymbolTable::getLocal(std::string key, int currentLine)
    {
        Symbol* symbol = tryGet(key, false);
        
        if(!symbol)
        {
            std::ostringstream message;
            message << "error, reference to undefined " << contentText << " `" << key << "`";
            error(message.str().c_str(), currentLine);
            return NULL;
        }
        return symbol;
    }
    
    Symbol* SymbolTable::tryGet(std::string key, bool useInheritance)
    {
        Iterator it = map.find(key);
        if(it == end())
        {
            if(useInheritance && parent)
            {
                return parent->tryGet(key, useInheritance);
            }
            return NULL;
        }
        return it->second;
    }
    
    void SymbolTable::dump(FILE* f, int d)
    {
        Iterator it;
		if(map.empty())
		{
			dumpFormat(f, d, "(empty table)\n");
			return;
		}
        for(it = begin(); it != end(); ++it)
        {
            dumpFormat(f, d, "%s : ", it->first.c_str());
            dumpTableData<Symbol>(it->second, f, d);   
        }
    }
    
    int SymbolTable::createTemporary(Expression* expr)
    {
        std::ostringstream stream;
        stream << "temp #" << temporaryIndex;
        
        Symbol* sym = new Symbol(expr);
        temporaryIndex++;
        offset += 4;
        
        put(stream.str(), sym, expr->getLineNumber());
        //std::cerr << "Debug: " << stream.str() << " : " << offset << std::endl;
        return offset - 4;
    }
    
    
    void enterScope()
    {
        // First time, populate type scope with new values.
        if(!typeScope)
        {
            typeScope = new SymbolTable(NULL);
			typeScope->contentText = "type";
            typeScope->put("integer", new Symbol::Symbol(Symbol::SYM_INTEGER), 0);
            typeScope->put("char", new Symbol::Symbol(Symbol::SYM_CHAR), 0);
            typeScope->put("real", new Symbol::Symbol(Symbol::SYM_REAL), 0);
        }
        // First time, populate active scope with new values.
        if(!activeScope)
        {
            activeScope = new SymbolTable(NULL);
            activeScope->put("true", new Symbol::Symbol(new Literal(1, 0)), 0);
            activeScope->put("false", new Symbol::Symbol(new Literal(0, 0)), 0);
            activeScope->put("maxint", new Symbol::Symbol(new Literal(INT_MAX, 0)), 0);
            activeScope->put("writeint", new Symbol::Symbol(Symbol::SYM_WRITEINT), 0);
            activeScope->put("writechar", new Symbol::Symbol(Symbol::SYM_WRITECHAR), 0);
            activeScope->put("writereal", new Symbol::Symbol(Symbol::SYM_WRITEREAL), 0);
            activeScope->put("writestr", new Symbol::Symbol(Symbol::SYM_WRITESTR), 0);
            activeScope->put("tointeger", new Symbol::Symbol(Symbol::SYM_TOINTEGER), 0);
            activeScope->put("toreal", new Symbol::Symbol(Symbol::SYM_TOREAL), 0);
            activeScope->put("random", new Symbol::Symbol(Symbol::SYM_RANDOM), 0);            
            activeScope->put("readint", new Symbol::Symbol(Symbol::SYM_READINT), 0);
            activeScope->put("readreal", new Symbol::Symbol(Symbol::SYM_READREAL), 0);
            activeScope->put("readchar", new Symbol::Symbol(Symbol::SYM_READCHAR), 0);
        }
        // Otherwise, set previous scope as parent.
        else
        {
            activeScope = new SymbolTable(activeScope);
            typeScope = new SymbolTable(typeScope);
        }
        
        pushScope();
        //fprintf(stderr, "DEBUG: Entering new scope at depth %d (%d)\n", activeScope->depth, (unsigned int) scopeStack.size());
    }
    
    void exitScope()
    {
        popScope();
    }
    
    void pushScope()
    {
        scopeStack.push_back(activeScope);
        typeStack.push_back(typeScope);
    }
    
    void popScope()
    {
        //fprintf(stderr, "DEBUG: Exiting scope with %d entries at depth %d (%d)\n", (unsigned int) activeScope->size(), activeScope->depth, (unsigned int) scopeStack.size());
        scopeStack.pop_back();
        typeStack.pop_back();
        // Pop off active scope and return to parent scope.
        activeScope = activeScope->parent;
        typeScope = typeScope->parent;
    }
}    
