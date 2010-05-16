#include <iostream>
#include <sstream>

#include "dump.h"
#include "declaration.h"
#include "identifier.h"
#include "type_definition.h"
#include "expression.h"
#include "program.h"
#include "variable.h"
#include "literal.h"
#include "common.h"
#include "symbol.h"
#include "operator.h"

namespace pish
{
    VariableDeclaration::VariableDeclaration(IdentifierList* list, TypeDefinition* type,
        unsigned int lineNumber)
    {
        category = Declaration::DECL_VARIABLE;
        this->list = list;
        this->type = type;
        this->lineNumber = lineNumber;
    }

    VariableDeclaration::~VariableDeclaration()
    {
        delete list;
        delete type;
    }
    
    void VariableDeclaration::dump(FILE* f, int depth)
    {
        fprintf(f, "VariableDeclaration(\n");
        depth++;
            dumpFormat(f, depth, "list = ");
            dumpNode<IdentifierList>(list, f, depth);
            fprintf(f, ",\n");
            dumpFormat(f, depth, "type = ");
            dumpNode<TypeDefinition>(type, f, depth);
            fprintf(f, "\n");
        depth--;
        dumpFormat(f, depth, ")");
    }
    
    void VariableDeclaration::inspect()
    {
        type->inspect();
        if(type->resolvedType != TypeDefinition::TYPE_ERROR)
        {
            for(size_t i = 0; i < list->getSize(); i++)
            {
                activeScope->put(list->getItem(i)->name, new Symbol(this), lineNumber);
                // Variables increase scope offset on each binding.
                activeScope->offset += type->size;
                //fprintf(stderr, "DEBUG: <<%d>> OFFSET: %d\n", activeScope->depth, activeScope->offset);
            }
        }
    }
    
    
    
    AliasDeclaration::AliasDeclaration(Identifier* identifier, TypeDefinition* type, unsigned int lineNumber)
    {
        category = Declaration::DECL_ALIAS;
        this->identifier = identifier;
        this->type = type;
        this->lineNumber = lineNumber;
    }

    AliasDeclaration::~AliasDeclaration()
    {
        delete identifier;
        delete type;
    }
    
    void AliasDeclaration::dump(FILE* f, int depth)
    {
        fprintf(f, "AliasDeclaration(\n");
        depth++;
            dumpFormat(f, depth, "identifier = ");
            dumpNode<Identifier>(identifier, f, depth);
            fprintf(f, ",\n");
            dumpFormat(f, depth, "type = ");
            dumpNode<TypeDefinition>(type, f, depth);
            fprintf(f, "\n");
        depth--;
        dumpFormat(f, depth, ")");
    }
    
    void AliasDeclaration::inspect()
    {
        type->inspect();
        if(type->resolvedType != TypeDefinition::TYPE_ERROR)
        {
            typeScope->put(identifier->name, new Symbol(type), lineNumber);
        }
    }
    
    
    
    ConstantDeclaration::ConstantDeclaration(Identifier* identifier, Expression* expression, unsigned int lineNumber)
    {
        category = Declaration::DECL_CONSTANT;
        this->identifier = identifier;
        this->expression = expression;
        this->lineNumber = lineNumber;
    }
    
    ConstantDeclaration::~ConstantDeclaration()
    {
        delete identifier;
        delete expression;
    }
    
    void ConstantDeclaration::dump(FILE* f, int depth)
    {
        fprintf(f, "ConstantDeclaration(\n");
        depth++;
            dumpFormat(f, depth, "identifier = ");
            dumpNode<Identifier>(identifier, f, depth);
            fprintf(f, ",\n");
            dumpFormat(f, depth, "expression = ");
            dumpNode<Expression>(expression, f, depth);
            fprintf(f, "\n");
        depth--;
        dumpFormat(f, depth, ")");
    }
    
    void ConstantDeclaration::inspect()
    {
        // Constant refers to a literal.
        if(expression->category == Expression::EXPR_LITERAL)
        {
            //fprintf(stderr, "%s\n", expression->literal->getRepresentation().c_str());
            activeScope->put(identifier->name, new Symbol(new Literal(expression->literal, lineNumber)), lineNumber);
        }
        // Constant refers to another constant, look it up.
        else if(expression->category == Expression::EXPR_VARIABLE)
        {
            Symbol* symbol = activeScope->get(expression->variable->identifier->name, lineNumber);
            if(!symbol)
            {
                return;
            }
            else
            {
                if(symbol->category != Symbol::SYM_CONSTANT_BINDING)
                {
                    error("error, expected a constant expression.", lineNumber);
                    return;
                }
                activeScope->put(identifier->name, new Symbol(new Literal(symbol->constantBinding, lineNumber)), lineNumber);
            }
        }
        // Constant is negated.
        else if(expression->category == Expression::EXPR_OPERATOR)
        {
            // Look at operand.
            Expression* operand = expression->op->operand;
            
            // Constant refers to a literal.
            if(operand->category == Expression::EXPR_LITERAL)
            {
                if(operand->literal->canNegate())
                {
                    operand->literal->negate();
                    
                    // DEBUG
                    //operand->literal->dump(stderr, 0);
                }
                else
                {
                    error("error, expecting integer or real, but found string literal.", lineNumber);
                }
                activeScope->put(identifier->name, new Symbol(new Literal(operand->literal, lineNumber)), lineNumber);
            }
            // Constant refers to another constant, look it up.
            else if(operand->category == Expression::EXPR_VARIABLE)
            {
                Symbol* symbol = activeScope->get(operand->variable->identifier->name, lineNumber);
                if(!symbol)
                {
                    return;
                }
                else
                {
                    if(symbol->category != Symbol::SYM_CONSTANT_BINDING)
                    {
                        error("error, expected a constant expression.", lineNumber);
                        return;
                    }
                
                    Literal* literal = new Literal(symbol->constantBinding, lineNumber);
                    if(literal->canNegate())
                    {
                        literal->negate();
                    }
                    else
                    {
                        error("error, expecting integer or real, but found string literal.", lineNumber);
                    }
                    activeScope->put(identifier->name, new Symbol(literal), lineNumber);
                }
            }
        }
    }
    
    
    
    ProgramDeclaration::ProgramDeclaration(Program* program, unsigned int lineNumber)
    {
        category = Declaration::DECL_PROGRAM;
        this->program = program;
        this->lineNumber = lineNumber;
    }
    
    ProgramDeclaration::~ProgramDeclaration()
    {
        delete program;
    }
    
    void ProgramDeclaration::dump(FILE* f, int depth)
    {
        fprintf(f, "ProgramDeclaration(\n");
        depth++;
            dumpFormat(f, depth, "program = ");
            dumpNode<Program>(program, f, depth);
            fprintf(f, "\n");
        depth--;
        dumpFormat(f, depth, ")");
    }
     
    void ProgramDeclaration::inspect()
    {
        std::string name = program->head->name->name;
        
        // Try and find forward declaration in this scope (no scope inheritance)
        Symbol* old = activeScope->tryGet(name, false);
		
		// First, compile the function.
		program->inspect();
		
		// Next, check if it existed already.
        if(old)
        {
            // If old wasn't a forward declaration, we have a redefinition. Whoops.
            if(old->programBinding->body)
            {
                std::ostringstream message;
                message << "error, redefinition of function `" << name << "`, body previously defined on line " << old->programBinding->getLineNumber();
                error(message.str().c_str(), lineNumber);
            }
            // Defining the same forwarded function again. Bad.
            else if(!program->body)
            {
                std::ostringstream message;
                message << "error, redefinition of forward function `" << name << "`, previously defined on line " << old->lineNumber;
                error(message.str().c_str(), lineNumber);
            }
            // Alright, now that we've confirmed that old was forwarded, new is body, check that signatures match.
			else
			{
			    ProgramHead* head = program->head;
			    ProgramHead* oldHead = old->programBinding->head;
			    
			    bool isProcedure = !head->returnValue;
			    bool oldIsProcedure = !oldHead->returnValue;
			    bool difference = false;
			    
                std::vector<VariableDeclaration*> signature;
                std::vector<VariableDeclaration*> oldSignature;
                
                flattenVariableDeclarationList(head->parameters, signature);
                flattenVariableDeclarationList(oldHead->parameters, oldSignature);

			    // Check if defined as procedure instead of function.
				if(isProcedure && !oldIsProcedure)
				{
					difference = true;        
				}
				// Check if defined as function instead of procedure.
				else if(!isProcedure && oldIsProcedure)
				{
				    difference = true;    
				}
				// Both functions -- check return values.
				else if(!isProcedure && !oldIsProcedure && !head->returnValue->isEqualTo(oldHead->returnValue))
				{
				    difference = true;  
				}
				// Check parameter types.
				else
				{
					if(countDeclarations(signature) != countDeclarations(oldSignature))
					{
					    //fprintf(stderr, "Different arg count\n");
					    difference = true;
					}
                    for(size_t i = 0; i < signature.size(); i++)
                    {
                        if(!signature[i]->type->isEqualTo(oldSignature[i]->type))
                        {
                            //fprintf(stderr, "Different arg type\n");
                            difference = true;
                            break;
                        }
                    }
				}
                if(difference)
                {
                    std::ostringstream message;
                    bool separator;
                    message << "error, `" << name << "` is defined as ";
                    
                    separator = false;
                    message << (isProcedure ? "procedure" : "function") << " (";
                    for(size_t i = 0; i < signature.size(); i++)
                    {
                        for(size_t j = 0; j < signature[i]->list->getSize(); j++)
                        {
                            message << (separator ? ", " : "") << signature[i]->type->getSimpleName();
                            separator = true;
                        }
                    }
                    message << ")" << (isProcedure ? "" : " : ") << (isProcedure ? "" : head->returnValue->getSimpleName()) << " ";
                    message << "which does not match forward declaration of " << (oldIsProcedure ? "procedure" : "function") << " (";
                    separator = false;
                    for(size_t i = 0; i < oldSignature.size(); i++)
                    {
                        for(size_t j = 0; j < oldSignature[i]->list->getSize(); j++)
                        {
                            message << (separator ? ", " : "") << oldSignature[i]->type->getSimpleName();
                            separator = true;
                        }
                    }
                    message << ")" << (oldIsProcedure ? "" : " : ") << (oldIsProcedure ? "" : oldHead->returnValue->getSimpleName()) << " ";
                    message << "on line " << old->lineNumber;
                    error(message.str().c_str(), head->getLineNumber());        				
                }
			}
            old->programBinding->body = program->body;
            old->programBinding->patched = true;
            
            // Update symbol table entry to newest patch.
            old->programBinding = program;
        }
        else
        {
            activeScope->put(name, new Symbol(program), lineNumber);
        }
    }
    
    void ProgramDeclaration::compile(std::ostream &fp, bool isASM)
    {
        program->compile(fp, isASM);
    }
}

