#include <sstream>
#include <stdio.h>
#include <iostream>

#include "program.h"
#include "identifier.h"
#include "expression.h"
#include "declaration.h"
#include "statement.h"
#include "type_definition.h"
#include "variable.h"
#include "common.h"
#include "symbol.h"
#include "literal.h"

namespace pish
{
    // Invocation of a program.
    ProgramInvocation::ProgramInvocation(Identifier* name, ExpressionList* arguments, unsigned int lineNumber)
    {
        this->name = name;
        this->arguments = arguments;
        this->lineNumber = lineNumber;
        program = NULL;
        returnType = Expression::VALUE_ERROR;
    }
            
    ProgramInvocation::~ProgramInvocation()
    {
        delete arguments;
    }
    
    void ProgramInvocation::dump(FILE* f, int depth)
    {
        fprintf(f, "ProgramInvocation(\n");
        depth++;
            dumpFormat(f, depth, "name = ");
            dumpNode<Identifier>(name, f, depth);
            fprintf(f, ",\n");
            dumpFormat(f, depth, "arguments = ");
            dumpNode<ExpressionList>(arguments, f, depth);
        depth--;
        fprintf(f, "\n");
        dumpFormat(f, depth, ")");
    }
    
    void ProgramInvocation::inspect()
    {
        // Find variable in scope (looks at parent scopes too).
        Symbol* symbol = activeScope->get(name->name, lineNumber);
        if(!symbol)
        {
            return;
        }
        
        if(symbol->category == Symbol::SYM_PROGRAM_BINDING)
        {
            program = symbol->programBinding;
            if(program->head->returnValue)
            {
                switch(program->head->returnValue->resolveAliasCategory(lineNumber))
                {
                    case TypeDefinition::TYPE_INTEGER:
                        returnType = Expression::VALUE_INTEGER;
                        break;
                    case TypeDefinition::TYPE_REAL:
                        returnType = Expression::VALUE_REAL;
                        break;
                    case TypeDefinition::TYPE_CHAR:
                        returnType = Expression::VALUE_CHAR;
                        break;
                    default:
                        // Not a primitive. Uhhhhh.
                        returnType = Expression::VALUE_ERROR;
                }
            }
            else
            {
                returnType = Expression::VALUE_VOID;
            }
             
            std::vector<VariableDeclaration*> parameters;
            flattenVariableDeclarationList(program->head->parameters, parameters);
            size_t parameterCount = countDeclarations(parameters);

            bool fail = false;
            
            if(arguments->getSize() != parameterCount)
            {
                std::ostringstream message;
                message << "error, call to " << name->name << " expects " << parameterCount << " argument(s), but got " << arguments->getSize() << " instead";
                error(message.str().c_str(), lineNumber);
            }
            else
            {
                int argIndex = 0;
                for(size_t i = 0; i < parameters.size(); i++)
                {
                    TypeDefinition* typeDef = parameters[i]->type;
                    for(size_t j = 0; j < parameters[i]->list->getSize(); j++)
                    {
                        Expression* arg = arguments->getItem(argIndex);
                        arg->inspect();
                        
                        switch(arg->valueType)
                        {
                            // Integer value. Can be assigned to integer, or promoted and assigned to real.
                            case Expression::VALUE_INTEGER:
                                if(!typeDef->isAliasForCategory(TypeDefinition::TYPE_INTEGER, arg->getLineNumber()) && !typeDef->isAliasForCategory(TypeDefinition::TYPE_REAL, arg->getLineNumber()))
                                {
                                    fail = true;
                                }
                                if(typeDef->isAliasForCategory(TypeDefinition::TYPE_REAL, arg->getLineNumber()))
                                {
                                    arg->promoteToReal = true;
                                }
                                break;
                            // Real value. Can only be assigned to a real.
                            case Expression::VALUE_REAL:
                                if(!typeDef->isAliasForCategory(TypeDefinition::TYPE_REAL, arg->getLineNumber()))
                                {
                                    fail = true;
                                }
                                break;
                            // Character value. Can only be assigned to char.
                            case Expression::VALUE_CHAR:
                                if(!typeDef->isAliasForCategory(TypeDefinition::TYPE_CHAR, arg->getLineNumber()))
                                {
                                    fail = true;
                                }
                                break;
                            // String value. Can only be assigned to char, or array [..] of char.
                            case Expression::VALUE_STRING:
                                if(typeDef->isAliasForCategory(TypeDefinition::TYPE_CHAR, arg->getLineNumber()))
                                {
                                    const char* stringValue = NULL;
                                    if(arg->category == Expression::EXPR_VARIABLE)
                                    {
                                        stringValue = arg->variable->constant->getStringValue();
                                    }
                                    else if(arg->category == Expression::EXPR_LITERAL)
                                    {
                                        stringValue = arg->literal->getStringValue();
                                    }
                                    int length = strlen(stringValue);
                                    // Char can only be assigned a single-character literal
                                    if(length != 1)
                                    {
                                        std::ostringstream message;
                                        message << "error, found string literal of length " << length << ", but argument of type char holds exactly one character.";
                                        error(message.str().c_str(), arg->getLineNumber());
                                    }
                                }
                                else
                                {
                                    TypeDefinition* baseType = typeDef->resolveBaseType(arg->getLineNumber());
                                    
                                    // Ensure the base type of the expression is array [..] of char
                                    if(baseType->category == TypeDefinition::TYPE_ARRAY && baseType->array.type->isAliasForCategory(TypeDefinition::TYPE_CHAR, arg->getLineNumber()))
                                    {
                                        
                                        const char* stringValue = NULL;
                                        if(arg->category == Expression::EXPR_VARIABLE)
                                        {
                                            stringValue = arg->variable->constant->getStringValue();
                                        }
                                        else if(arg->category == Expression::EXPR_LITERAL)
                                        {
                                            stringValue = arg->literal->getStringValue();
                                        }
                                        int length = strlen(stringValue);
                                        // Make sure string length + 1 slots in array (1 reserved for null terminator)
                                        if(baseType->array.elementCount < length + 1)
                                        {
                                            std::ostringstream message;
                                            message << "error, found string literal of length " << length << ", which won't fit in an array of size " << baseType->array.elementCount << " (" << (length + 1) << " slots are required, when including null terminator).";
                                            error(message.str().c_str(), arg->getLineNumber());
                                        }
                                        arg->stringBlobSize = arg->stringBlobSize > baseType->array.elementCount ? arg->stringBlobSize : baseType->array.elementCount;
                                    }
                                    else
                                    {
                                        std::ostringstream message;
                                        message << "error, attempt to assign expression of " << arg->getTypeName() << " to argument of type " << typeDef->getSimpleName();
                                        error(message.str().c_str(), arg->getLineNumber());
                                    }
                                }
                                break;
                            // Other value. Check that type definitions are equal.    
                            case Expression::VALUE_VARIABLE:
                                // Compare type definitions.
                                if(!typeDef->isCompatibleWith(arg->variable->typeDefinition))
                                {
                                    fail = true;
                                }
                                break;
                        }
                        
                        // If expression is a single variable, and left-hand side type is alias,
                        // check that the type identically matches the left-hand side's resolved type.
                        if(arg->category == Expression::EXPR_VARIABLE && typeDef->resolvedType == TypeDefinition::TYPE_IDENTIFIER)
                        {
                            // Mismatched type.
                            if(arg->variable->typeDefinition->resolvedType != typeDef->resolvedType)
                            {
                                fail = true;
                            }
                        }
                        argIndex++;
                    }
                }
            }
            
            if(fail)
            {
                std::ostringstream message;
                message << "error, call to `" << name->name << "` expects argument(s) of signature (";
                
                bool separator = false;
                for(size_t i = 0; i < parameters.size(); i++)
                {
                    for(size_t j = 0; j < parameters[i]->list->getSize(); j++)
                    {
                        message << (separator ? ", " : "") << parameters[i]->type->getSimpleName();
                        separator = true;
                    }
                }
                message << ") but found argument(s) (";
                separator = false;
                for(size_t i = 0; i < arguments->getSize(); i++)
                {
                    Expression* arg = arguments->getItem(i);
                    message << (separator ? ", " : "") << arg->getShortName();
                    separator = true;
                }
                message << ") instead.";
                error(message.str().c_str(), lineNumber);
            }
        }
        else if ( symbol -> category == Symbol::SYM_WRITEINT || symbol->category == Symbol::SYM_TOREAL)
        {
            returnType = Expression::VALUE_VOID;
            if ( arguments -> getSize () != 1 )
            {
                std::ostringstream message;
                message << "error, call to " << name->name << " expects 1 argument(s), but got " << arguments->getSize () << " instead";
                error ( message.str ().c_str (), lineNumber );
            }
            else
            {
                /* Otherwise we have only 1, so grab it */
                Expression * arg = arguments -> getItem ( 0 );
                arg -> inspect ();

                if ( arg -> valueType != Expression::VALUE_INTEGER || arg -> promoteToReal == true  )
                {
                    std::ostringstream message;
                    message << "error, " << name->name << " can only be called with an integer as a parameter, not an expression of " << arg -> getTypeName ();
                    error ( message.str ().c_str (), arg->getLineNumber() );
                }
                
                if(symbol->category == Symbol::SYM_TOREAL)
                {
                    returnType = Expression::VALUE_REAL;
                }               
            }
        }
        else if ( symbol -> category == Symbol::SYM_WRITECHAR )
        {
            returnType = Expression::VALUE_VOID;
            if ( arguments -> getSize () != 1 )
            {
                std::ostringstream message;
                message << "error, call to " << name->name << " expects 1 argument(s), but got " << arguments->getSize () << " instead";
                error ( message.str ().c_str (), lineNumber );
            }
            else
            {
                /* Otherwise, we have 1 parameter, so use it */
                Expression * arg = arguments -> getItem ( 0 );
                arg -> inspect ();
                
                if(arg->valueType == Expression::VALUE_STRING)
                {   
                    const char* stringValue = NULL;
                    if(arg->category == Expression::EXPR_VARIABLE)
                    {
                        stringValue = arg->variable->constant->getStringValue();
                    }
                    else if(arg->category == Expression::EXPR_LITERAL)
                    {
                        stringValue = arg->literal->getStringValue();
                    }
                    int length = strlen(stringValue);
                    
                    // Char can only be assigned a single-character literal
                    if(length != 1)
                    {
                        std::ostringstream message;
                        message << "error, found string literal of length " << length << ", but argument of type char holds exactly one character.";
                        error(message.str().c_str(), arg->getLineNumber());
                    }
                }
                else if ( arg -> valueType != Expression::VALUE_CHAR )
                {
                    std::ostringstream message;
                    message << "error, " << name->name << " can only be called with a character as a parameter, not an expression of " << arg -> getTypeName ();
                    error ( message.str ().c_str (), arg->getLineNumber());
                }
            }
        }
        else if (symbol->category== Symbol::SYM_WRITEREAL || symbol->category == Symbol::SYM_TOINTEGER)
        {
            returnType = Expression::VALUE_VOID;
            if ( arguments -> getSize () != 1 )
            {
                std::ostringstream message;
                message << "error, call to " << name->name << " expects 1 argument(s), but got " << arguments->getSize () << " instead";
                error ( message.str ().c_str (), lineNumber );
            }
            else
            {
                /* Otherwise, we have 1 parameter, so use it */
                Expression * arg = arguments -> getItem ( 0 );
                arg -> inspect ();

                if ( arg -> valueType != Expression::VALUE_REAL && arg -> promoteToReal == false && arg -> valueType != Expression::VALUE_INTEGER )
                {
                    std::ostringstream message;
                    message << "error, " << name->name << " can only be called with a real number as a parameter, not an expression of " << arg -> getTypeName ();
                    error ( message.str ().c_str (), arg->getLineNumber() );
                }
                else
                {
                    arg -> promoteToReal = true;
                }
                if(symbol->category == Symbol::SYM_TOINTEGER)
                {
                    returnType = Expression::VALUE_INTEGER;
                }
            }
        }
        else if ( symbol -> category == Symbol::SYM_WRITESTR )
        {
            returnType = Expression::VALUE_VOID;
            if ( arguments -> getSize () != 1 )
            {
                std::ostringstream message;
                message << "error, call to " << name->name << " expects 1 argument(s), but got " << arguments->getSize () << " instead";
                error ( message.str ().c_str (), lineNumber );
            }
            else
            {
                /* Otherwise, we have 1 parameter, so use it */
                Expression * arg = arguments -> getItem ( 0 );
                arg -> inspect ();
                
                bool isString = false;
                // Trivial case: If it's a string literal or constant, it's a string (duh).
                if(arg->valueType == Expression::VALUE_STRING)
                {
                    isString = true;
                }
                // Otherwise, check the variable.
                else if(arg->category == Expression::EXPR_VARIABLE
                    && arg->variable->context == Variable::VAR_VARIABLE
                )
                {
                    // Annoying case: If it's array [..] of char, it's a string
                    TypeDefinition* baseType = arg->variable->typeDefinition->resolveBaseType(lineNumber);
                    if(baseType->category == TypeDefinition::TYPE_ARRAY && baseType->array.type->isAliasForCategory(TypeDefinition::TYPE_CHAR, lineNumber))
                    {
                        isString = true;
                    }
                }
                
                // If the argument is not a string, whine.
                if(!isString)
                {
                    
                    std::ostringstream message;
                    message << "error, " << name->name << " can only be called with a string literal or array[..] of char as a parameter, not an expression of " << arg -> getTypeName ();
                    error ( message.str ().c_str (), arg->getLineNumber());
                }
            }
        }
        else if ( symbol -> category == Symbol::SYM_RANDOM )
        {
            if ( arguments->getSize () > 0 )
            {
                std::ostringstream message;
                message << "error, call to " << name->name << " expects 0 argument(s), but got " << arguments->getSize () << " instead";
                error ( message.str ().c_str (), lineNumber );
            }
            returnType = Expression::VALUE_INTEGER;
        }
        else if ( symbol -> category == Symbol::SYM_READINT)
        {
            returnType = Expression::VALUE_VOID;
            if ( arguments -> getSize () != 1 )
            {
                std::ostringstream message;
                message << "error, call to " << name->name << " expects 1 argument(s), but got " << arguments->getSize () << " instead";
                error ( message.str ().c_str (), lineNumber );
            }
            else
            {
                /* Otherwise, we have 1 parameter, so use it */
                Expression * arg = arguments -> getItem ( 0 );
                arg -> inspect ();
                
                bool isValid = false;
                if(arg->category == Expression::EXPR_VARIABLE
                    && arg->variable->context == Variable::VAR_VARIABLE
                )
                {
                    if(arg->variable->typeDefinition->isAliasForCategory(TypeDefinition::TYPE_INTEGER, lineNumber))
                    {
                        isValid = true;
                    }
                }
                
                // If the argument is not valid, whine.
                if(!isValid)
                {
                    
                    std::ostringstream message;
                    message << "error, " << name->name << " can only be called with an integer as a parameter, not an expression of " << arg -> getTypeName ();
                    error ( message.str ().c_str (), arg->getLineNumber());
                }
            }
        }
        else if ( symbol -> category == Symbol::SYM_READCHAR)
        {
            returnType = Expression::VALUE_VOID;
            if ( arguments -> getSize () != 1 )
            {
                std::ostringstream message;
                message << "error, call to " << name->name << " expects 1 argument(s), but got " << arguments->getSize () << " instead";
                error ( message.str ().c_str (), lineNumber );
            }
            else
            {
                /* Otherwise, we have 1 parameter, so use it */
                Expression * arg = arguments -> getItem ( 0 );
                arg -> inspect ();
                
                bool isValid = false;
                if(arg->category == Expression::EXPR_VARIABLE
                    && arg->variable->context == Variable::VAR_VARIABLE
                )
                {
                    if(arg->variable->typeDefinition->isAliasForCategory(TypeDefinition::TYPE_CHAR, lineNumber))
                    {
                        isValid = true;
                    }
                }
                
                // If the argument is not valid, whine.
                if(!isValid)
                {
                    
                    std::ostringstream message;
                    message << "error, " << name->name << " can only be called with a character as a parameter, not an expression of " << arg -> getTypeName ();
                    error ( message.str ().c_str (), arg->getLineNumber());
                }
            }
        }
        else if ( symbol -> category == Symbol::SYM_READREAL)
        {
            returnType = Expression::VALUE_VOID;
            if ( arguments -> getSize () != 1 )
            {
                std::ostringstream message;
                message << "error, call to " << name->name << " expects 1 argument(s), but got " << arguments->getSize () << " instead";
                error ( message.str ().c_str (), lineNumber );
            }
            else
            {
                /* Otherwise, we have 1 parameter, so use it */
                Expression * arg = arguments -> getItem ( 0 );
                arg -> inspect ();
                
                bool isValid = false;
                if(arg->category == Expression::EXPR_VARIABLE
                    && arg->variable->context == Variable::VAR_VARIABLE
                )
                {
                    if(arg->variable->typeDefinition->isAliasForCategory(TypeDefinition::TYPE_REAL, lineNumber))
                    {
                        isValid = true;
                    }
                }
                
                // If the argument is not valid, whine.
                if(!isValid)
                {
                    
                    std::ostringstream message;
                    message << "error, " << name->name << " can only be called with a real as a parameter, not an expression of " << arg -> getTypeName ();
                    error ( message.str ().c_str (), arg->getLineNumber());
                }
            }
        }     
        else
        {
            std::ostringstream message;
            message << "error, attempt to call non-subprogram expression `" << name->name << "`";
            error(message.str().c_str(), lineNumber);
        }
    }
    
    void ProgramInvocation::compile(std::ostream &fp, bool isASM)
    {
        if(program)
        {
            std::string label = program->functionLabel;
                
            if(!program->body)
            {
                std::ostringstream message;
                message << "error, attempt to call function `" << program->head->name->name << "` which has no body";
                error(message.str().c_str(), lineNumber);
                return;
            }
            
            std::vector<VariableDeclaration*> parameters;
            flattenVariableDeclarationList(program->head->parameters, parameters);
            size_t parameterCount = countDeclarations(parameters);
            
            for(size_t i = 0; i < parameterCount; i++)
            {
                Expression* arg = arguments->getItem(i);
                arg->compile(fp, isASM);
            }
            
            fp << "# Call function " << program->head->name->name << "." << std::endl;
            if(isASM)
            {   
                fp << "sw $fp, 0($sp) # Old frame pointer" << std::endl;
                fp << "sw $sp, -4($sp) # Old stack pointer" << std::endl;
                fp << "sw $zero, -8($sp) # Return address (to be filled on function entry)" << std::endl;
                // Save the old nesting entry (t0 is ONLY used for looking up this nesting entry, cannot be used by anything else.)
                fp << "lw $t0, " << (program->nestIndex * 4) << "($gp) # Get old nesting entry." << std::endl;
                fp << "sw $t0, -12($sp) # Save old nesting entry." << std::endl;
                // Overwrite the nesting entry for this function.
                fp << "sw $sp, " << (program->nestIndex * 4) << "($gp) # Set nesting entry for this function to new activation record." << std::endl;
                // Store t1 .. t7.
                for(int i = 1; i <= 7; i++)
                {
                    fp << "sw $t" << i << ", " << (-i * 4 - 12) << "($sp) # Save t" << i << " value" << std::endl;
                }
                // Store address of each arg in newly allocated stackframe
                {
                    int argIndex = 0;
                    for(size_t i = 0; i < parameters.size(); i++)
                    {
                        for(size_t j = 0; j < parameters[i]->list->getSize(); j++)
                        {
                            Expression* arg = arguments->getItem(argIndex);
                            arg->emitAddress("t1", fp, isASM);
                            
                            // Yeah, this is lame, we need to lookup the name of the parameter we're emitting an arg for, so we can get its symbol and as a result, its offset.
                            Symbol* symbol = program->localSymbols->getLocal(std::string(parameters[i]->list->getItem(j)->name), lineNumber);
                            fp << "sw $t1, -" << symbol->offset << "($sp)" << std::endl;
                            argIndex++;
                        }
                    }
                }
                // Finish setting up frame pointer and jump
                fp << "move $fp, $sp # update frame pointer" << std::endl;
                fp << "subi $sp, $sp, " << program->frameSize << " # expand stack" << std::endl;
                fp << "la $t7, " << label << " # load function label" << std::endl;
                fp << "jalr $ra, $t7 # Save return address and jump to function label." << std::endl;
                
                // Functions, but not procedures, have return values. 
                if(program->head->returnValue)
                {
                    if(program->head->returnValue->resolveAliasCategory(lineNumber) == TypeDefinition::TYPE_REAL)
                    {
                        fp << "l.s $f4, -" << program->returnValueOffset << "($sp) # get return value of call" << std::endl;
                    }
                    else
                    {
                        fp << "lw $t1, -" << program->returnValueOffset << "($sp) # get return value of call" << std::endl;
                    }
                }
            }
            else
            {
                fp << "*(sp) = fp # Old frame pointer" << std::endl;
                fp << "*(sp - 4) = sp # Old stack pointer" << std::endl;
                fp << "*(sp - 8) = 0 # Return address (to be filled on function entry)" << std::endl;
                fp << "*(sp - 12) = nest[" << program->nestIndex << "] # Save old nesting entry. " << std::endl;
                fp << "nest[" << program->nestIndex << "] = t0 # Set nesting entry for this function to new activation record. " << std::endl;
                for(int i = 1; i <= 7; i++)
                {
                    fp << "*(sp - " << (-i * 4 - 12) << ") = t" << i << " # Save t" << i << " value" << std::endl;
                }
                // Store address of each arg in newly allocated stackframe
                {
                    int argIndex = 0;
                    for(size_t i = 0; i < parameters.size(); i++)
                    {
                        for(size_t j = 0; j < parameters[i]->list->getSize(); j++)
                        {
                            Expression* arg = arguments->getItem(argIndex);
                            arg->emitAddress("t1", fp, isASM);
                            
                            // Yeah, this is lame, we need to lookup the name of the parameter we're emitting an arg for, so we can get its symbol and as a result, its offset.
                            Symbol* symbol = program->localSymbols->getLocal(std::string(parameters[i]->list->getItem(j)->name), lineNumber);
                            fp << "*(fp - " << symbol->offset << ") = t1" << std::endl;
                            argIndex++;
                        }
                    }
                }
                fp << "fp = sp # update frame pointer" << std::endl;
                fp << "sp -= " << program->frameSize << " # expand stack" << std::endl;
                fp << "call " << label << " # Save return address and jump to function label." << std::endl;
                // Functions, but not procedures, have return values. 
                if(program->head->returnValue)
                {
                    if(program->head->returnValue->resolveAliasCategory(lineNumber) == TypeDefinition::TYPE_REAL)
                    {
                        fp << "f4 = *(sp - " << program->returnValueOffset << ") # get return value of call" << std::endl;
                    }
                    else
                    {
                        fp << "t1 = *(sp - " << program->returnValueOffset << ") # get return value of call" << std::endl;
                    }
                }
            }
        }
        else
        {
            Symbol* symbol = activeScope->get(name->name, lineNumber);
            if(!symbol)
            {
                return;
            }
            
            switch(symbol->category)
            {
                case Symbol::SYM_WRITEINT:
                {
                    Expression* arg = arguments->getItem (0);
                    arg->compile(fp, isASM);
                    arg->emitIntegerRead("t1", fp, isASM);
                    if(isASM)
                    {
                        fp << "move $a0, $t1 # Move arg into service address register" << std::endl;
                        fp << "li $v0, 1 # Service: write integer" << std::endl;
                        fp << "syscall # Call writeint" << std::endl;
                    }
                    else
                    {
                        fp << "writeint(t1)" << std::endl;
                    }
                    break;
                }
                case Symbol::SYM_WRITEREAL:
                {
                    Expression* arg = arguments->getItem (0);
                    arg->compile(fp, isASM);
                    arg->emitFloatRead("f12", "t1", fp, isASM);
                    if(isASM)
                    {
                        fp << "li $v0, 2 # Service: write float" << std::endl;
                        fp << "syscall # Call writereal" << std::endl;
                    }
                    else
                    {
                        fp << "writereal(f12)" << std::endl;
                    }
                    break;
                }
                case Symbol::SYM_WRITECHAR:
                {
                    Expression* arg = arguments->getItem (0);
                    arg->compile(fp, isASM);
                    arg->emitIntegerRead("t1", fp, isASM);
                    if(isASM)
                    {
                        fp << "move $a0, $t1 # Move arg into service address register" << std::endl;
                        fp << "li $v0, 11 # Service: write character" << std::endl;
                        fp << "syscall # Call writechar" << std::endl;
                    }
                    else
                    {
                        fp << "writechar(t1)" << std::endl;
                    }
                    break;
                }
                case Symbol::SYM_WRITESTR:
                {
                    Expression* arg = arguments->getItem (0);
                    arg->compile(fp, isASM);
                    arg->emitAddress("t1", fp, isASM);
                    if(isASM)
                    {   
                        std::string loopLabel = createLabel();
                        std::string afterWhileLabel = createLabel();
                        fp << loopLabel << ": # writestr is implemented as a loop over each character in a string." << std::endl;
                        fp << "lw $a0, 0($t1) # deref t1 to get character from string" << std::endl;
                        fp << "beq $a0, $0, " << afterWhileLabel << "# exit when the character is 0. "<< std::endl;
                        fp << "li $v0, 11 # Service: write character" << std::endl;
                        fp << "syscall # Call writechar" << std::endl;
                        fp << "addi $t1, $t1, -4 # Decrement pointer" << std::endl;
                        fp << "j " << loopLabel << "# go to top of loop" << std::endl;
                        fp << afterWhileLabel << ": # done!" << std::endl;
                    }
                    else
                    {
                        fp << "writestr(t1)" << std::endl;
                    }
                    break;
                }
                case Symbol::SYM_TOINTEGER:
                {
                    Expression* arg = arguments->getItem (0);
                    arg->compile(fp, isASM);
                    arg->emitFloatRead("f4", "t1", fp, isASM);
                    if(isASM)
                    {
                        fp << "cvt.w.s $f4, $f4 # convert to integer" << std::endl;
                        fp << "mfc1 $t1, $f4 # move into int register" << std::endl;
                    }
                    else
                    {
                        fp << "t1 = tointeger(f12)" << std::endl;
                    }
                    break;
                }
                case Symbol::SYM_TOREAL:
                {
                    Expression* arg = arguments->getItem (0);
                    arg->compile(fp, isASM);
                    arg->emitFloatRead("f12", "t1", fp, isASM);
                    break;
                }
                case Symbol::SYM_RANDOM:
                {
                    if(isASM)
                    {
                        fp << "li $a0, 0 # seed id 0" << std::endl;
                        fp << "li $v0, 41 # Service: random" << std::endl;
                        fp << "syscall" << std::endl;
                        fp << "move $t1, $a0 # load result" << std::endl;
                        fp << "andi $t1, $t1, 0x7fffffff # mask off sign bit" << std::endl;
                    }
                    else
                    {
                        fp << "t1 = random()" << std::endl;
                    }
                    break;
                }
                case Symbol::SYM_READINT:
                {
                    Expression* arg = arguments->getItem (0);
                    arg->compile(fp, isASM);
                    arg->emitAddress("t1", fp, isASM);
                    if(isASM)
                    {
                        fp << "li $v0, 5 # Service: read int" << std::endl;
                        fp << "syscall # call readint" << std::endl;
                        fp << "sw $v0, 0($t1) # store int we read at address of arg" << std::endl;
                    }
                    else
                    {
                        fp << "readint(t1)" << std::endl;
                    }
                    break;
                }
                case Symbol::SYM_READCHAR:
                {
                    Expression* arg = arguments->getItem (0);
                    arg->compile(fp, isASM);
                    arg->emitAddress("t1", fp, isASM);
                    if(isASM)
                    {
                        fp << "li $v0, 12 # Service: read char" << std::endl;
                        fp << "syscall # call readchar" << std::endl;
                        fp << "sw $v0, 0($t1) # store char we read at address of arg" << std::endl;
                    }
                    else
                    {
                        fp << "readchar(t1)" << std::endl;
                    }
                    break;
                }
                case Symbol::SYM_READREAL:
                {
                    Expression* arg = arguments->getItem (0);
                    arg->compile(fp, isASM);
                    arg->emitAddress("t1", fp, isASM);
                    if(isASM)
                    {
                        fp << "li $v0, 6 # Service: read float" << std::endl;
                        fp << "syscall # call readreal" << std::endl;
                        fp << "s.s $f0, 0($t1) # store real we read at address of arg" << std::endl;
                    }
                    else
                    {
                        fp << "readreal(t1)" << std::endl;
                    }
                    break;
                }
            }
        }
    }
    
    
    
    ProgramBody::ProgramBody(DeclarationList* locals, StatementList* statements, unsigned int lineNumber)
    {
        this->locals = locals;
        this->statements = statements;
        this->lineNumber = lineNumber;
    }
    
    ProgramBody::~ProgramBody()
    {
        delete locals;
        delete statements;
    }
    
    void ProgramBody::dump(FILE* f, int depth)
    {
        fprintf(f, "ProgramBody(\n");
        depth++;
            dumpFormat(f, depth, "locals = ");
            dumpNode<DeclarationList>(locals, f, depth);
            fprintf(f, ",\n");
            dumpFormat(f, depth, "statements = ");
            dumpNode<StatementList>(statements, f, depth);
        depth--;
        fprintf(f, "\n");
        dumpFormat(f, depth, ")");
    }
    
    void ProgramBody::inspect()
    {
        locals->inspect();
        statements->inspect();
    }
    
    void ProgramBody::compile(std::ostream &fp, bool isASM)
    {
        locals->compile(fp, isASM);
        fp << statementLabel << ":" << std::endl;
        statements->compile(fp, isASM);
    }
    
    
    
    ProgramHead::ProgramHead(Identifier* name, TypeDefinition* returnValue, DeclarationList* parameters, unsigned int lineNumber)
    {
        type = ProgramHead::HEAD_SUB;
        this->name = name;
        this->returnValue = returnValue;
        this->parameters = parameters;
        this->lineNumber = lineNumber;
    }
    
    ProgramHead::ProgramHead(Identifier* name, IdentifierList* list, unsigned int lineNumber)
    {
        type = ProgramHead::HEAD_MAIN;
        this->name = name;
        this->returnValue = NULL;
        this->identifierList = list;
        this->lineNumber = lineNumber;
    }

    ProgramHead::~ProgramHead()
    {
        delete name;
        delete returnValue;
        switch(type)
        {
            case ProgramHead::HEAD_SUB:
                delete parameters;
                break;
            case ProgramHead::HEAD_MAIN:
                delete identifierList;
                break;
        }
    }
    
    void ProgramHead::dump(FILE* f, int depth)
    {
        fprintf(f, "ProgramHead(\n");
        depth++;
            switch(type)
            {
                case ProgramHead::HEAD_SUB: 
                    dumpFormat(f, depth, "type = HEAD_SUB, name = ");
                    dumpNode<Identifier>(name, f, depth);
                    fprintf(f, ",\n");
                    dumpFormat(f, depth, "returnValue = ");
                    dumpNode<TypeDefinition>(returnValue, f, depth);
                    if(!returnValue)
                    {
                        fprintf(f, " (procedure)");
                    }
                    fprintf(f, ",\n");
                    dumpFormat(f, depth, "parameters = ");
                    dumpNode<DeclarationList>(parameters, f, depth);
                    break;
                case ProgramHead::HEAD_MAIN: 
                    dumpFormat(f, depth, "type = HEAD_MAIN, name = ");
                    dumpNode<Identifier>(name, f, depth + 1);
                    fprintf(f, ",\n");
                    dumpFormat(f, depth, "identifierList = ");
                    dumpNode<IdentifierList>(identifierList, f, depth);
                    break;               
            }
        depth--;
        fprintf(f, "\n");
        dumpFormat(f, depth, ")");
    }
    
    void ProgramHead::inspect()
    {
        if(type == HEAD_SUB)
        {
            // Add parameter definitions to scope
            parameters->inspect();
            
            // Return value needs to be type-checked.
            if(returnValue)
            {
                returnValue->inspect();
				// Ensure return type is a primitive or we error.
				returnValue->checkAliasForPrimitive(lineNumber);
            }
            SymbolTable::Iterator it;
            for(it = activeScope->begin(); it != activeScope->end(); ++it)
            {
                // Arguments are pass-by-reference.
                if(it->second->category == Symbol::SYM_VARIABLE_BINDING)
                {
                    it->second->isReference = true;
                }
            }
        }
        else
        {
            // Pointless parameters that serve no purpose other than to eat symbol table.
            for(size_t i = 0; i < identifierList->getSize(); i++)
            {
                activeScope->put(identifierList->getItem(i)->name, new Symbol(Symbol::SYM_MAIN_PROGRAM_PARAMETER), lineNumber);
            }
        }
    }
    
    
    
    Program::Program(ProgramHead* head, ProgramBody* body, unsigned int lineNumber)
    {
        this->head = head;
        this->body = body;
        this->lineNumber=lineNumber;
        localSymbols = NULL;
        localTypes = NULL;
        patched = false;
        nestIndex = -1;
        returnValueOffset = -1;
    }
    
    Program::~Program()
    {
        delete head;
        if(!patched)
        {
            delete body;
        }
        delete localSymbols;
        delete localTypes;
    }
    
    void Program::dump(FILE* f, int depth)
    {
        fprintf(f, "Program(\n");
        depth++;
            dumpFormat(f, depth, "head = ");
            dumpNode<ProgramHead>(head, f, depth);
            fprintf(f, ",\n");
            dumpFormat(f, depth, "body = ");
            dumpNode<ProgramBody>(body, f, depth);
            if(!body)
            {
                fprintf(f, " (forward declaration)");
            }
        depth--;
        fprintf(f, "\n");
        dumpFormat(f, depth, ")");
    }
    
    void Program::inspect()
    {
        // Enter a new scope for declarations.
        enterScope();
        
        // Reserve the space for extra stack things early.
        // These things don't actually have entries in the symbol table, but they consume space.
        activeScope->offset += 4 * EXTRA_STACK_ITEMS;
        
        localSymbols = activeScope;
        localTypes = typeScope;
        
        // Add this function name to its own symbol table.
        Symbol* symbol = new Symbol(Symbol::SYM_PROGRAM_BINDING);
        symbol->isScopeSelf = true;
        symbol->programBinding = this;
        activeScope->put(head->name->name, symbol, lineNumber);
        activeScope->offset += 4; // Return value may only be int, char, or real. These are all 4 bytes.
        returnValueOffset = symbol->offset;
        
        head->inspect(); 
        // Parse the body (types, constants, locals and statement lists)
        if(body)
        {
            body->inspect();
        }
        
        exitScope();
        
        frameSize = localSymbols->offset;
    }

    void Program::compile(std::ostream &fp, bool isASM)
    {
        // Prototypes are ignored.
        if(patched || !body)
        {
            return;
        }
        
        enterProgramNode(this);
        
        functionLabel = createLabel();
        body->statementLabel = createLabel();
        
        fp << functionLabel << ":" << std::endl;
        
        if (head->type == ProgramHead::HEAD_MAIN)
        {
            fp << "# Initialize main frame pointer." << std::endl;
            if (isASM)
            {
                fp << "subi $fp, $sp, -" << frameSize << std::endl;
                fp << "# Return address info is always generated, but has no purpose in main." << std::endl;
                fp << "sw $0, 0($fp)" << std::endl;
                fp << "sw $0, -4($fp)" << std::endl;
                fp << "sw $0, -8($fp)" << std::endl;
                fp << "sw $0, -12($fp) # There is no old nesting entry for the main function (since it cannot call itself recursively)." << std::endl;
                fp << "sw $fp, " << (nestIndex * 4) << "($gp) # Set nesting entry for this function to new activation record." << std::endl;
                for(int i = 1; i <= 7; i++)
                {
                    fp << "sw $0, " << (-i * 4 - 12) << "($fp) # No t" << i << " value worth caring about yet." << std::endl;
                }
            }
            else
            {
                fp << "fp = sp - " << frameSize << std::endl;
                fp << "# Return address info is always generated, but has no purpose in main." << std::endl;
                fp << "*(fp) = 0" << std::endl;
                fp << "*(fp - 4) = 0" << std::endl;
                fp << "*(fp - 8) = 0" << std::endl;
                fp << "*(fp - 12) = 0 # There is no old nesting entry for the main function (since it cannot call itself recursively)." << std::endl;
                fp << "nest[" << nestIndex << "] = fp # Set nesting entry for this function to new activation record." << std::endl; 
                for(int i = 1; i <= 7; i++)
                {
                    fp << "*(fp - " << (-i * 4 - 12) << ") = 0 # No t" << i << " value worth caring about yet." << std::endl;
                }
            }
        }
        // Subprogram.
        else
        {
            fp << "# Function " << head->name->name << std::endl;
            // Assembly code.
            if (isASM)
            {
                fp << "sw $ra, -8($fp) # Save the caller return address RIGHT NOW." << std::endl;
            }
            // Intermediate code.
            else
            {
                fp << "*(fp - 8) = ra # Save the caller return address RIGHT NOW." << std::endl;
            }   
        }
        
        
        fp << "j " << body->statementLabel << std::endl;
        if (head->type == ProgramHead::HEAD_MAIN)
        {
            fp << "# Error handler for out-of-bounds array access" << std::endl;
            fp << "IndexOutOfBounds:" << std::endl;
            if (isASM)
            {
                fp << ".data" << std::endl;
                fp << "IOOB1: .asciiz \"Index \"" << std::endl;
                fp << "IOOB2: .asciiz \" is outside of array bounds \"" << std::endl;
                fp << "IOOB3: .asciiz \" .. \"" << std::endl;
                fp << "IOOB4: .asciiz \". Abort.\"" << std::endl;
                fp << ".text" << std::endl;
                fp << "la $a0, IOOB1" << std::endl;
                fp << "li $v0, 4" << std::endl;
                fp << "syscall" << std::endl;
                fp << "move $a0, $t2" << std::endl;
                fp << "li $v0, 1" << std::endl;
                fp << "syscall" << std::endl;
                fp << "la $a0, IOOB2" << std::endl;
                fp << "li $v0, 4" << std::endl;
                fp << "syscall" << std::endl;  
                fp << "move $a0, $t3" << std::endl;
                fp << "li $v0, 1" << std::endl;
                fp << "syscall" << std::endl;
                fp << "la $a0, IOOB3" << std::endl;
                fp << "li $v0, 4" << std::endl;
                fp << "syscall" << std::endl;
                fp << "move $a0, $t4" << std::endl;
                fp << "li $v0, 1" << std::endl;
                fp << "syscall" << std::endl;                
                fp << "la $a0, IOOB4" << std::endl;
                fp << "li $v0, 4" << std::endl;
                fp << "syscall" << std::endl;                
                fp << "li $v0, 10" << std::endl;
                fp << "syscall" << std::endl;
            }
            else
            {
                fp << "print \"Index $t2 is outside of array bounds $t3 .. $t4. Abort.\"" << std::endl;
            }
        }
        
        body->compile(fp, isASM);
        
        // Main program.
        if (head->type == ProgramHead::HEAD_MAIN)
        {
            fp << "# Exit the program." << std::endl;
            if (isASM)
            {
                fp << "li $v0, 10" << std::endl;
                fp << "syscall" << std::endl;                
            }
            else
            {
                fp << "exit";
            }
            fp << std::endl;
        }
        // Subprogram.
        else
        {
            fp << "# Return from function, and restore old calling stack." << std::endl;
            if (isASM)
            {
                // Restore registers.
                for(int i = 1; i <= 7; i++)
                {
                    fp << "lw $t" << i << ", " << (-i * 4 - 12) << "($fp) # Restore t" << i << " value" << std::endl;
                }
                // Restore the old nesting entry
                fp << "lw $t1 -12($fp)" << std::endl;
                fp << "sw $t1, " << (nestIndex * 4) << "($gp) # restore nesting entry" << std::endl;
                // Restore stack.
                fp << "lw $ra, -8($fp) # load return address" << std::endl;
                fp << "lw $sp, -4($fp) # shrink stack" << std::endl;
                fp << "lw $fp, 0($fp) # restore frame pointer" << std::endl;
                fp << "jr $ra # return" << std::endl;
            }
            else
            {
                // Restore registers.
                for(int i = 1; i <= 7; i++)
                {
                    fp << "t" << i << " = *(fp - " << (-i * 4 - 12) << ") # Restore t" << i << "." << std::endl;
                }
                // Restore the old nesting entry
                fp << "nest[" << nestIndex << "] = *(fp - 12) # restore nesting entry" << std::endl;
                // Restore stack.
                fp << "ra = *(fp - 8) # load return address" << std::endl;
                fp << "sp = *(fp - 4) # shrink stack" << std::endl;
                fp << "sp = *(fp) # restore frame pointer" << std::endl;
                fp << "return" << std::endl;
            }
            fp << std::endl;
        }
        
        exitProgramNode();
    }
}

