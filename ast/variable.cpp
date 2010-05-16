#include <sstream>
#include <stdio.h>
#include "variable.h"
#include "expression.h"
#include "identifier.h"
#include "type_definition.h"
#include "declaration.h"
#include "program.h"
#include "symbol.h"
#include "common.h"

namespace pish
{
    Subscript::Subscript(Identifier* attribute, unsigned int lineNumber)
    {
        category = Subscript::SUB_ATTRIBUTE;
        this->attribute = attribute;
        this->lineNumber = lineNumber;
        subscriptedType = NULL;
    }
    
    Subscript::Subscript(Expression* index, unsigned int lineNumber)
    {
        category = Subscript::SUB_INDEX;
        this->index = index;
        this->lineNumber = lineNumber;
        subscriptedType = NULL;
    }
    
    Subscript::~Subscript()
    {
        switch(category)
        {
            case Subscript::SUB_ATTRIBUTE:
                delete attribute;
                break;
            case Subscript::SUB_INDEX:
                delete index;
                break;
        }
    }
    
    void Subscript::dump(FILE* f, int depth)
    {
        fprintf(f, "Subscript(\n");
        depth++;
            switch(category)
            {
                case Subscript::SUB_ATTRIBUTE:
                    dumpFormat(f, depth, "category = SUB_ATTRIBUTE, attribute = ");
                    dumpNode<Identifier>(attribute, f, depth);
                    break;
                case Subscript::SUB_INDEX:
                    dumpFormat(f, depth, "category = SUB_INDEX, index = ");
                    dumpNode<Expression>(index, f, depth);
                    break;
            }
        depth--;
        fprintf(f, "\n");
        dumpFormat(f, depth, ")");
    }



    Variable::Variable(Identifier* identifier, SubscriptList* subscripts, unsigned int lineNumber)
    {
        this->identifier = identifier;
        this->subscripts = subscripts;
        this->lineNumber = lineNumber;
        context = Variable::VAR_ERROR;
    }

    Variable::~Variable()
    {
        delete identifier;
        delete subscripts;
    }
    
    void Variable::dump(FILE* f, int depth)
    {
        fprintf(f, "Variable(\n");
        depth++;
            dumpFormat(f, depth, "identifier = ");
            dumpNode<Identifier>(identifier, f, depth);
            fprintf(f, ",\n");
            dumpFormat(f, depth, "subscripts = ");
            dumpNode<SubscriptList>(subscripts, f, depth);
            if(!subscripts)
            {
                fprintf(f, " (simple variable)");
            }
        depth--;
        fprintf(f, "\n");
        dumpFormat(f, depth, ")");
    }
    
    void Variable::inspect()
    {
        // Find variable in scope (looks at parent scopes too).
        Symbol* symbol = activeScope->get(identifier->name, lineNumber);
        if(!symbol)
        {
            return;
        }
        
        if(symbol->category == Symbol::SYM_CONSTANT_BINDING)
        {
            //fprintf(stderr, "DEBUG: Constant %s found\n", identifier->name);
            context = Variable::VAR_CONSTANT;
            constant = symbol->constantBinding;
            if(subscripts)
            {
                context = Variable::VAR_ERROR;
                std::ostringstream message;
                message << "error, attempt to subscript constant `" << identifier->name << "`";
                error(message.str().c_str(), lineNumber);
            }
        }
        else if(symbol->category == Symbol::SYM_PROGRAM_BINDING)
        {
            //fprintf(stderr, "DEBUG: Program %s found\n", identifier->name);
            if(!symbol->isScopeSelf)
            {
                context = Variable::VAR_ERROR;
                std::ostringstream message;
                message << "error, attempt to access return value of `" << identifier->name << "` inside of an entirely different subprogram. either someone forgot the parentheses () to make a subprogram call, or a return value is being attempted to be accessed illegally.";
                error(message.str().c_str(), lineNumber);
                return;
            }
            else
            {
                context = Variable::VAR_RETURN_VALUE;
                program = symbol->programBinding;
                //fprintf(stderr, "DEBUG: RETURN VALUE 0x%x\n", program);
                if(subscripts)
                {
                    context = Variable::VAR_ERROR;
                    std::ostringstream message;
                    message << "error, attempt to subscript function return value `" << identifier->name << "`";
                    error(message.str().c_str(), lineNumber);
                }
            }
        }
        else if(symbol->category == Symbol::SYM_VARIABLE_BINDING)
        {
            //fprintf(stderr, "DEBUG: Variable %s found\n", identifier->name);
            context = Variable::VAR_VARIABLE;
            VariableDeclaration* varDecl = symbol->variableBinding;
            
            typeDefinition = varDecl->type;
            
            // Subscripting operations, if any.
            if(subscripts)
            {
                for(size_t i = 0; i < subscripts->getSize(); i++)
                {
                    if(context == Variable::VAR_ERROR)
                    {
                        break;
                    }
                    Subscript* subscript = subscripts->getItem(i);
                    // The type of the thing being subscripted needs to be stored, so things can be calculated during code gen pass.
                    // And this needs to be resolved to the actual damn type. 
                    subscript->subscriptedType = typeDefinition->resolveBaseType(lineNumber);
                    switch(subscript->category)
                    {
                        // a[i]
                        case Subscript::SUB_INDEX:
                        {
                            //fprintf(stderr, "DEBUG: -> ARRAY SUBSCRIPT (%s)\n", typeDefinition->getSimpleName().c_str());
                            if(!typeDefinition->isArray(lineNumber))
                            {
                                std::ostringstream message;
                                message << "error, attempt to perform `[...]` indexing on non-array type " << typeDefinition->getSimpleName() << "";
                                error(message.str().c_str(), lineNumber);
                                
                                context = Variable::VAR_ERROR;
                            }
                            else
                            {
                                // TODO: base offset within scope.
                                // TODO: fudge expressions into some sort of magic runtime offset from base. THIS MAY REQUIRE SEMANTIC INFO ON SUBSCRIPT.
                                
                                // Compile index.
                                subscript->index->inspect();
                                /* Subscripts only allow INTEGERS */
                                if (subscript->index->valueType != Expression::VALUE_INTEGER || subscript->index->promoteToReal)
                                {
                                    std::ostringstream message;
                                    message << "error, attempt to perform `[...]` indexing with expression of non-integer " << subscript->index->getTypeName ();
                                    error ( message.str ().c_str (), subscript->index->getLineNumber () );
                                }
                                
                                // Subscripting is now on subtype specified here.
                                typeDefinition = typeDefinition->getArraySubtype();
                            }
                        }
                        break;
                        // a.b
                        case Subscript::SUB_ATTRIBUTE:
                        {
                            //fprintf(stderr, "DEBUG: -> ATTRIBUTE `%s` (%s)\n", subscript->attribute->name, typeDefinition->getSimpleName().c_str());
                            // Only records have attribute access.
                            if(!typeDefinition->isRecord(lineNumber))
                            {
                                std::ostringstream message;
                                message << "error, attempt to perform `.` attribute access on non-record type " << typeDefinition->getSimpleName() << "";
                                error(message.str().c_str(), lineNumber);
                                
                                context = Variable::VAR_ERROR;
                            }
                            else
                            {
                                // TODO: base offset within scope.
                            
                                // Subscripting is now on field specified here.
                                typeDefinition = typeDefinition->getRecordFieldType(subscript->attribute->name, lineNumber);
                                
                                // Failed to find record member.
                                if(!typeDefinition)
                                {
                                    context = Variable::VAR_ERROR;
                                }
                                else
                                {
                                }
                            }
                        }
                        break;
                    }
                }
            }
            //fprintf(stderr, "DEBUG: -> VARIABLE END\n");
        }
        else
        {
            context = Variable::VAR_ERROR;
            error("error, expecting variable or constant", lineNumber);
        }
    }
    
    void Variable::compile(std::ostream &fp, bool isASM)
    {   
        // ONLY actual variables should be compiled here at this point.
        if(context == VAR_CONSTANT)
        {
            return;
        }
        
        // Start with outermost offset.
        Symbol* symbol = activeScope->get(identifier->name, lineNumber);
        
        // Subscripting operations, if any, need to be precalculated into temps.
        // This way the temps are free to be used by this function after this point.
        if(context == VAR_VARIABLE && subscripts)
        {
            for(size_t i = 0; i < subscripts->getSize(); i++)
            {
                Subscript* subscript = subscripts->getItem(i);
                if(subscript->category == Subscript::SUB_INDEX)
                {
                    fp << "# Array index (subscript #" << i << " - part one)" << std::endl;
                    // Compile indexing calculation.
                    subscript->index->compile(fp, isASM);
                }
            }
        }
        
        // Get (sub)program associated with this symbol.
        Program* program = programStack[symbol->depth];
        // Load entry from nesting table into t1. Entry index is determined by what scope of program we're examining.
        // t1 can now be used to point to the correct frame pointer where this variable definition is found.
        if(isASM)
        {
            fp << "lw $t1, " << (program->nestIndex * 4) << "($gp) # Get stackframe for " << program->head->name->name << std::endl;
        }
        else
        {
            fp << "t1 = nest[" << (program->nestIndex * 4) << "] # Get stackframe for " << program->head->name->name << std::endl;
        }
        
        // Function arguments are pass-by-reference, and thus, special.
        if(symbol->isReference)
        {
            // Reference the dereferenced variable.
            // &*a == a (the pointer value itself)
            if(isASM)
            {
                fp << "lw $t1, -" << symbol->offset << "($t1) # Argument: &*" << identifier->name << std::endl;
            }
            else
            {
                fp << "t1 = *(t1 - " << symbol->offset << ") # Argument: &*" << identifier->name << std::endl;
            }
        }
        // Otherwise, a regular var.
        else
        {
            // Reference the variable.
            // &a (the address of the variable)
            if(isASM)
            {
                fp << "addi $t1, $t1, -" << symbol->offset << " # Local: &" << identifier->name << std::endl;
            }
            else
            {
                fp << "t1 = t1 - " << symbol->offset << " # Local: &" << identifier->name << std::endl;
            }
        }
        
        if(context == VAR_RETURN_VALUE)
        {
            return;
        }

        // Subscripting operations, if any.
        if(subscripts)
        {
            for(size_t i = 0; i < subscripts->getSize(); i++)
            {
                Subscript* subscript = subscripts->getItem(i);
                switch(subscript->category)
                {
                    case Subscript::SUB_INDEX:
                    {
                        // load offset of index into t2
                        fp << "# Array index (subscript #" << i << " - part two)" << std::endl;
                        subscript->index->emitIntegerRead("t2", fp, isASM);
                        if(isASM)
                        {
                            fp << "li $t3, " << subscript->subscriptedType->array.lowerIndex << " # lower bound " << std::endl;
                            fp << "li $t4, " << subscript->subscriptedType->array.upperIndex << " # upper bound" << std::endl;
                            fp << "blt $t2, $t3, IndexOutOfBounds # i < lower? error." << std::endl;
                            fp << "bgt $t2, $t4, IndexOutOfBounds # i > upper? error." << std::endl;
                            fp << "addi $t2, $t2, " << -subscript->subscriptedType->array.lowerIndex << " # We need to reposition relative to the actual memory location." << std::endl;
                            fp << "li $t3, " << subscript->subscriptedType->array.type->size << " # t3 = sizeof(array subtype)." << std::endl;
                            fp << "mul $t2, $t2, $t3 # t2 = t2 * sizeof(array subtype)." << std::endl;
                            fp << "sub $t1, $t1, $t2 # base -= t2" << std::endl;
                        }
                        else
                        {
                            fp << "t3 = " << subscript->subscriptedType->array.lowerIndex << " # lower bound " << std::endl;
                            fp << "t4 = " << subscript->subscriptedType->array.upperIndex << " # upper bound" << std::endl;
                            fp << "if (t2 < t3) jmp IndexOutOfBounds # i < 0? error." << std::endl;
                            fp << "if (t2 > t4) jmp IndexOutOfBounds # i >= len? error." << std::endl;
                            fp << "t2 += " << -subscript->subscriptedType->array.lowerIndex << " # We need to reposition relative to the actual memory location." << std::endl;
                            fp << "t3 = " << subscript->subscriptedType->array.type->size << " # t3 = sizeof(array subtype)." << std::endl;
                            fp << "t2 *= t3 # t2 = t2 * sizeof(array subtype)." << std::endl;
                            fp << "t1 += t2 # base += t2" << std::endl;
                        }
                        break;
                    }
                    case Subscript::SUB_ATTRIBUTE:
                    {
                        Symbol* attr = subscript->subscriptedType->record.symbols->get(subscript->attribute->name, lineNumber);
                        if(isASM)
                        {
                            fp << "addi $t1, $t1, -" << attr->offset << " # Get attribute " << subscript->attribute->name << std::endl;
                        }
                        else
                        {
                            fp << "t1 -= " << attr->offset << " # Get attribute " << subscript->attribute->name << std::endl;
                        }
                        break;
                    }
                }
            }
        }
        
        // Finally, we've figured it out! The address in t1 needs to be dereferenced later when you want to read the value out of memory.
        // So you'll have fun.
    }
}

