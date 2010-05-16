#include <sstream>
#include <stdio.h>

#include "statement.h"
#include "identifier.h"
#include "type_definition.h"
#include "expression.h"
#include "variable.h"
#include "program.h"
#include "literal.h"
#include "common.h"

namespace pish
{ 
    IfStatement::IfStatement(Expression* test, Statement* trueStatement, Statement* falseStatement,
        unsigned int lineNumber)
    {
        category = Statement::STMT_IF;
        this->test = test;
        this->trueStatement = trueStatement;
        this->falseStatement = falseStatement;
        this->lineNumber = lineNumber;
    }

    IfStatement::~IfStatement()
    {
        delete test;
        delete trueStatement;
        delete falseStatement;
    }
    
    void IfStatement::dump(FILE* f, int depth)
    {
        fprintf(f, "IfStatement(\n");
        depth++;
            dumpFormat(f, depth, "test = ");
            dumpNode<Expression>(test, f, depth);
            fprintf(f, ",\n");
            dumpFormat(f, depth, "trueStatement = ");
            dumpNode<Statement>(trueStatement, f, depth);
            fprintf(f, ",\n");
            dumpFormat(f, depth, "falseStatement = ");
            dumpNode<Statement>(falseStatement, f, depth);
            fprintf(f, "\n");
        depth--;
        dumpFormat(f, depth, ")");
    }
    
    void IfStatement::inspect()
    {
        /* Inspect all elements */
        test -> inspect ();
        trueStatement -> inspect ();

        /* False statements are optional, so make sure it exists first before playing with it */
        if ( falseStatement != NULL )
        {
            falseStatement -> inspect ();
        }

        /* If statements are only allowed to be INTEGERS */
        if ( test -> valueType == Expression::VALUE_INTEGER && test -> promoteToReal == false )
        {
            return;
        }
        else
        {
            std::ostringstream message;
            message << "error, attempt to complete a comparision using an expression of " << test -> getTypeName () << " when only an integer is accepted";
            error ( message.str ().c_str (), test -> getLineNumber () );
            return;
        }
    }
    
    void IfStatement::compile(std::ostream &fp, bool isASM)
    {
        std::string elseLabel = createLabel ();
        std::string endLabel = createLabel (); 

        fp << " # Beginning of if statement" << std::endl;
        /* Compile to value */
        test -> compile ( fp, isASM );
        /* Read the data into t1 */
        test -> emitIntegerRead ( "t1", fp, isASM );
        if ( isASM )
        {
            /* Comparing to 0, so load it */
            fp << "beq $t1, $0, " << ( falseStatement ? elseLabel : endLabel ) << " # Branch if we are equal to 0 (FALSE)" << std::endl;
            fp << "# Moving into the new scope." << std::endl;
            trueStatement -> compile ( fp, isASM );

            if ( falseStatement != NULL )
            {
                fp << "j " << endLabel << "# Jump to the end of the if" << std::endl;

                /* Otherwise, else */
                fp << elseLabel << ": # Else statement " << std::endl;

                falseStatement -> compile ( fp, isASM );
            }
            fp << endLabel << ": # End of if statement" << std::endl;
        }
        /* Otherwise we aren't ASM */
        else
        {
            fp << "if t1 == 0, jump " << ( falseStatement ? elseLabel : endLabel ) << " # Branch if we are equal to 0 (FALSE)" << std::endl;
            trueStatement -> compile ( fp, isASM );

            if ( falseStatement )
            {
                fp << "jump " << endLabel << "# Jump to the end of the if" << std::endl;

                fp << elseLabel << ": # Else statement " << std::endl;
                falseStatement -> compile ( fp, isASM );
            }
            fp << endLabel << ": # End of if statement" << std::endl;
        }
    }
    
    
    WhileStatement::WhileStatement(Expression* test, Statement* statement, unsigned int lineNumber)
    {
        category = Statement::STMT_WHILE;
        this->test = test;
        this->statement = statement;
        this->lineNumber = lineNumber;
    }

    WhileStatement::~WhileStatement()
    {
        delete test;
        delete statement;
    }
    
    void WhileStatement::dump(FILE* f, int depth)
    {
        fprintf(f, "WhileStatement(\n");
        depth++;
            dumpFormat(f, depth, "test = ");
            dumpNode<Expression>(test, f, depth);
            fprintf(f, ",\n");
            dumpFormat(f, depth, "statement = ");
            dumpNode<Statement>(statement, f, depth);
            fprintf(f, "\n");
        depth--;
        dumpFormat(f, depth, ")");
    }
    
    void WhileStatement::inspect()
    {
        /* Inspect the elements */
        test -> inspect ();
        statement -> inspect ();

        /* While loops only allow INTEGERS */
        if ( test -> valueType == Expression::VALUE_INTEGER && test -> promoteToReal == false )
        {
            return;
        }
        else
        {
            std::ostringstream message;
            message << "error, attempt to use a while condition using an expression of " << test -> getTypeName () << " when only an integer is accepted";
            error ( message.str ().c_str (), test -> getLineNumber () );
            return;
        }
    }
    
    void WhileStatement::compile(std::ostream &fp, bool isASM)
    {
        std::string startLabel = createLabel ();
        std::string endLabel = createLabel (); 

        fp << startLabel << ": # Beginning of while loop" << std::endl;
        test -> compile ( fp, isASM );
        /* Read the data into t1 */
        test -> emitIntegerRead ( "t1", fp, isASM );
        if ( isASM )
        {
            /* Comparing to 0, so load it */
            fp << "beq $t1, $0, " << endLabel << " # Branch if we are equal to 0 (FALSE)" << std::endl;
            statement -> compile ( fp, isASM );
            fp << "j " << startLabel << "# Jump to the beginning of the while loop" << std::endl;
            fp << endLabel <<  ": # End of while loop" << std::endl;
        }
        /* Otherwise we aren't ASM */
        else
        {
            fp << "if t1 == 0, jump " << endLabel << " # Branch if we are equal to 0 (FALSE)" << std::endl;
            statement -> compile ( fp, isASM );
            fp << "jump " << startLabel << "# Jump to the beginning of the while loop" << std::endl;
            fp << endLabel << ": # End of while loop" << std::endl;
        }
    }
    
    
    
    ForStatement::ForStatement(Variable* variable, Expression* lower, Expression* upper, ForStatement::Direction direction, Statement* statement,
        unsigned int lineNumber)
    {
        category = Statement::STMT_FOR;
        this->variable = variable; /* Incrementer */
        this->lower = lower;
        this->upper = upper;
        this->statement = statement;
        this->lineNumber = lineNumber;
        this -> direction = direction;
    }
    
    ForStatement::~ForStatement()
    {
        delete variable;
        delete lower;
        delete upper;
        delete statement;
    }
    
    void ForStatement::dump(FILE* f, int depth)
    {
        fprintf(f, "ForStatement(\n");
        depth++;
            dumpFormat(f, depth, "variable = ");
            dumpNode<Variable>(variable, f, depth);
            fprintf(f, ",\n");
            dumpFormat(f, depth, "lower = ");
            dumpNode<Expression>(lower, f, depth);
            fprintf(f, ",\n");
            dumpFormat(f, depth, "upper = ");
            dumpNode<Expression>(lower, f, depth);
            fprintf(f, ",\n");
            dumpFormat(f, depth, ", direction = %d\n", direction);
            dumpFormat(f, depth, "statement = ");
            dumpNode<Statement>(statement, f, depth);
            fprintf(f, "\n");
        depth--;
        dumpFormat(f, depth, ")");
    }
    
    void ForStatement::inspect()
    {
        variable -> inspect ();
        lower -> inspect ();
        upper -> inspect ();

        if ( variable -> context == Variable::VAR_CONSTANT )
        {
            std::ostringstream message;
            message << "error, `" << variable -> identifier -> name << "` is a constant value and cannot be re-assigned";
            error ( message.str ().c_str (), variable -> getLineNumber () );
        }
        else if ( variable -> context == Variable::VAR_ERROR )
        {
            fprintf ( stderr, "DEBUG: error node\n" );
        }
        else if ( variable -> context == Variable::VAR_RETURN_VALUE )
        {
            std::ostringstream message;
            message << "error, cannot assign the iterator of a for loop to the return value of a function";
            error ( message.str ().c_str (), variable -> getLineNumber () );
        }
        else
        {
            TypeDefinition * typeDef = variable -> typeDefinition;

            if ( typeDef -> isAliasForCategory ( TypeDefinition::TYPE_INTEGER, variable -> getLineNumber () ) == false )
            {
                std::ostringstream message;
                message << "error, iterator for a for loop is of " << typeDef -> getSimpleName () << ", but expecting integer value";
                error ( message.str ().c_str (), variable -> getLineNumber () );
            }
        }

        if ( lower -> valueType != Expression::VALUE_INTEGER || lower -> promoteToReal == true )
        {
            std::ostringstream message;
            message << "error, invalid start index provided for the for loop, an expression of " << lower -> getTypeName () << " was provided when only an integer is accepted";
            error ( message.str ().c_str (), lower -> getLineNumber () );
        }

        if ( upper -> valueType != Expression::VALUE_INTEGER || upper -> promoteToReal == true )
        {
            std::ostringstream message;
            message << "error, invalid end index provided for the for loop, an expression of " << upper -> getTypeName () << " was provided when only an integer is accepted";
            error ( message.str ().c_str (), upper -> getLineNumber () );
        }

        statement -> inspect ();
    }
    
    void ForStatement::compile(std::ostream &fp, bool isASM)
    {
        std::string startLabel = createLabel ();
        std::string endLabel = createLabel ();

        /* Compile the ranges */
        fp << "# Beginning of for loop" << std::endl;
        lower -> compile ( fp, isASM );
        upper -> compile ( fp, isASM );
        variable -> compile ( fp, isASM );
        
        /* Grab the starting point */
        lower -> emitIntegerRead ( "t2", fp, isASM );
        
        if ( isASM )
        {        
            /* Set the variable to it */
            fp << "sw $t2, 0($t1) # Store the starting value" << std::endl;
            fp << startLabel << ": # Start the for loop" << std::endl;

            upper -> emitIntegerRead ( "t2", fp, isASM );
            variable -> compile ( fp, isASM );

            fp << "lw $t1, 0($t1) # Load the number into the register" << std::endl;

            /* Based on the type of loop we are, complete a different action */
            if ( direction == FOR_TO )
            {
                    /* Increasing, so go until the end */
                    fp << "blt $t2, $t1, " << endLabel << " # Jump to the end if we are done, increasing" << std::endl;
            }
            else
            {
                    /* Decreasing, so search the opposite way */
                    fp << "blt $t1, $t2, " << endLabel << " # Jump to the end if we are done, decreasing" << std::endl;
            }
            
            /* Compile all of the statements */
            statement -> compile ( fp, isASM );

            /* Compile and then load the variable */
            variable -> compile ( fp, isASM );
            fp << "lw $t2, 0($t1) # Load into memory" << std::endl;

            /* Decide which way we are travelling (i.e. TO or DOWNTO */
            if ( direction == FOR_TO )
            {
                    /* Increasing, so increase the counter */
                    fp << "addi $t2, $t2, 1 # Increment by 1" << std::endl;
            }
            else
            {
                    /* Decreasing, so decrease the counter */
                    fp << "addi $t2, $t2, -1 # Decrement by 1" << std::endl;
            }

            fp << "sw $t2, 0($t1) # Save the value " << std::endl;

            fp << "j " << startLabel << " # Return to the start label" << std::endl;
        }
        /* Otherwise, we are doing intermediate code */
        else
        {
            fp << "*(t1) = t2 # Store the starting value" << std::endl;
            fp << startLabel << ": # Start the for loop" << std::endl;

            upper -> emitIntegerRead ( "t2", fp, isASM );
            if ( direction == FOR_TO )
            {
                fp << "if t2 < *(t1)," << endLabel << "# Jump to the end if we are done, increasing" << std::endl;
            }
            else
            {
                fp << "if *(t1) < t2, " << endLabel << "# Jump to the end if we are done, decreasing" << std::endl;
            }

            statement -> compile ( fp, isASM );
            variable -> compile ( fp, isASM );

            if ( direction == FOR_TO )
            {
                fp << "*(t1) += 1 # Increment by 1" << std::endl;
            }
            else
            {
                fp << "*(t1) -= 1 # Decrement by 1" << std::endl;
            }
            fp << "jump " << startLabel << " # Return to the start label" << std::endl;
        }
        fp << endLabel << ": # End of for loop" << std::endl;
    }
    
    
    
    AssignmentStatement::AssignmentStatement(Variable* variable, Expression* value, unsigned int lineNumber)
    {
        category = Statement::STMT_ASSIGN;
        this->variable = variable;
        this->value = value;
        this->lineNumber = lineNumber;
    }

    AssignmentStatement::~AssignmentStatement()
    {
        delete variable;
        delete value;
    }    
    
    void AssignmentStatement::dump(FILE* f, int depth)
    {
        fprintf(f, "AssignmentStatement(\n");
        depth++;
            dumpFormat(f, depth, "variable = ");
            dumpNode<Variable>(variable, f, depth);
            fprintf(f, ",\n");
            dumpFormat(f, depth, "value = ");
            dumpNode<Expression>(value, f, depth);
            fprintf(f, "\n");
        depth--;
        dumpFormat(f, depth, ")");
    }
    
    void AssignmentStatement::inspect()
    {
        variable->inspect();
        value->inspect();
        if(variable->context == Variable::VAR_CONSTANT)
        {
            std::ostringstream message;
            message << "error, `" << variable->identifier->name << "` is a constant value and cannot be re-assigned.";
            error(message.str().c_str(), lineNumber);
        }
        else if(variable->context == Variable::VAR_ERROR)
        {
            //fprintf(stderr, "DEBUG: error node\n");
            return;
        }
        else if(variable->context == Variable::VAR_RETURN_VALUE)
        {
            if(value->valueType == Expression::VALUE_ERROR)
            {
                return;
            }
            
            TypeDefinition* typeDef = variable->program->head->returnValue;
            
            if(!typeDef)
            {
                std::ostringstream message;
                message << "error, attempt to assign expression of " << value->getTypeName() << " to return value, but the current subprogram is a procedure, not a function.";
                error(message.str().c_str(), lineNumber);
                return;
            }
            
            //fprintf(stderr, "DEBUG: '%s' on line %d: %s vs %s\n", variable->identifier->name, variable->getLineNumber(), typeDef->getSimpleName().c_str(), value->getTypeName().c_str());
            
            switch(value->valueType)
            {
                // Integer value. Can be assigned to integer, or promoted and assigned to real.
                case Expression::VALUE_INTEGER:
                    if(!typeDef->isAliasForCategory(TypeDefinition::TYPE_INTEGER, lineNumber) && !typeDef->isAliasForCategory(TypeDefinition::TYPE_REAL, lineNumber))
                    {
                        std::ostringstream message;
                        message << "error, attempt to assign expression of " << value->getTypeName() << " to return value of type " << typeDef->getSimpleName();
                        error(message.str().c_str(), lineNumber);
                    }
                    if(typeDef->isAliasForCategory(TypeDefinition::TYPE_REAL, lineNumber))
                    {
                        value->promoteToReal = true;
                    }
                    break;
                // Real value. Can only be assigned to a real.
                case Expression::VALUE_REAL:
                    if(!typeDef->isAliasForCategory(TypeDefinition::TYPE_REAL, lineNumber))
                    {
                        std::ostringstream message;
                        message << "error, attempt to assign expression of " << value->getTypeName() << " to return value of type " << typeDef->getSimpleName();
                        error(message.str().c_str(), lineNumber);
                    }
                    break;
                // Character value. Can only be assigned to char.
                case Expression::VALUE_CHAR:
                    if(!typeDef->isAliasForCategory(TypeDefinition::TYPE_CHAR, lineNumber))
                    {
                        std::ostringstream message;
                        message << "error, attempt to assign expression of " << value->getTypeName() << " to return value of type " << typeDef->getSimpleName();
                        error(message.str().c_str(), lineNumber);
                    }
                    break;
                // Strings and other non-primitive types are invalid return values.
                case Expression::VALUE_STRING:
                    if(typeDef->isAliasForCategory(TypeDefinition::TYPE_CHAR, lineNumber))
                    {
                        const char* stringValue = NULL;
                        if(value->category == Expression::EXPR_VARIABLE)
                        {
                            stringValue = value->variable->constant->getStringValue();
                        }
                        else if(value->category == Expression::EXPR_LITERAL)
                        {
                            stringValue = value->literal->getStringValue();
                        }
                        int length = strlen(stringValue);
                        
                        // Char can only be assigned a single-character literal
                        if(length != 1)
                        {
                            std::ostringstream message;
                            message << "error, found string literal of length " << length << ", but return value of type char holds exactly one character.";
                            error(message.str().c_str(), lineNumber);
                        }
                    }
                    else
                    {
                        std::ostringstream message;
                        message << "error, attempt to assign expression of " << value->getTypeName() << " to return value of type " << typeDef->getSimpleName();
                        error(message.str().c_str(), lineNumber);
                    }
                    break;
                case Expression::VALUE_VARIABLE:
                    {
                        std::ostringstream message;
                        message << "error, attempt to assign expression of " << value->getTypeName() << " to return value of type " << typeDef->getSimpleName();
                        error(message.str().c_str(), lineNumber);
                    }
                    break;
            }
            return;
        }
        else
        {
            if(value->valueType == Expression::VALUE_ERROR)
            {
                return;
            }
            else
            {
                TypeDefinition* typeDef = variable->typeDefinition;
                if(!typeDef)
                {
                    return;
                }
                
                switch(value->valueType)
                {
                    // Integer value. Can be assigned to integer, or promoted and assigned to real.
                    case Expression::VALUE_INTEGER:
                        if(!typeDef->isAliasForCategory(TypeDefinition::TYPE_INTEGER, lineNumber) && !typeDef->isAliasForCategory(TypeDefinition::TYPE_REAL, lineNumber))
                        {
                            std::ostringstream message;
                            message << "error, attempt to assign expression of " << value->getTypeName() << " to variable of type " << typeDef->getSimpleName();
                            error(message.str().c_str(), lineNumber);
                        }
                        if(typeDef->isAliasForCategory(TypeDefinition::TYPE_REAL, lineNumber))
                        {
                            value->promoteToReal = true;
                        }
                        break;
                    // Real value. Can only be assigned to a real.
                    case Expression::VALUE_REAL:
                        if(!typeDef->isAliasForCategory(TypeDefinition::TYPE_REAL, lineNumber))
                        {
                            std::ostringstream message;
                            message << "error, attempt to assign expression of " << value->getTypeName() << " to variable of type " << typeDef->getSimpleName();
                            error(message.str().c_str(), lineNumber);
                        }
                        break;
                    // Character value. Can only be assigned to char.
                    case Expression::VALUE_CHAR:
                        if(!typeDef->isAliasForCategory(TypeDefinition::TYPE_CHAR, lineNumber))
                        {
                            std::ostringstream message;
                            message << "error, attempt to assign expression of " << value->getTypeName() << " to variable of type " << typeDef->getSimpleName();
                            error(message.str().c_str(), lineNumber);
                        }
                        break;
                    // String value. Can only be assigned to char, or array [..] of char.
                    case Expression::VALUE_STRING:
                        if(typeDef->isAliasForCategory(TypeDefinition::TYPE_CHAR, lineNumber))
                        {
                            const char* stringValue = NULL;
                            if(value->category == Expression::EXPR_VARIABLE)
                            {
                                stringValue = value->variable->constant->getStringValue();
                            }
                            else if(value->category == Expression::EXPR_LITERAL)
                            {
                                stringValue = value->literal->getStringValue();
                            }
                            int length = strlen(stringValue);
                            
                            // Char can only be assigned a single-character literal
                            if(length != 1)
                            {
                                std::ostringstream message;
                                message << "error, found string literal of length " << length << ", but variable of type char holds exactly one character.";
                                error(message.str().c_str(), lineNumber);
                            }
                        }
                        else
                        {
                            TypeDefinition* baseType = typeDef->resolveBaseType(lineNumber);
                            
                            // Ensure the base type of the expression is array [..] of char
                            if(baseType->category == TypeDefinition::TYPE_ARRAY && baseType->array.type->isAliasForCategory(TypeDefinition::TYPE_CHAR, lineNumber))
                            {
                                const char* stringValue = NULL;
                                if(value->category == Expression::EXPR_VARIABLE)
                                {
                                    stringValue = value->variable->constant->getStringValue();
                                }
                                else if(value->category == Expression::EXPR_LITERAL)
                                {
                                    stringValue = value->literal->getStringValue();
                                }
                                int length = strlen(stringValue);
                                
                                // Make sure string length + 1 slots in array (1 reserved for null terminator)
                                if(baseType->array.elementCount < length + 1)
                                {
                                    std::ostringstream message;
                                    message << "error, found string literal of length " << length << ", which won't fit in an array of size " << baseType->array.elementCount << " (" << (length + 1) << " slots are required, when including null terminator).";
                                    error(message.str().c_str(), lineNumber);                                    
                                }
                                value->stringBlobSize = value->stringBlobSize > baseType->array.elementCount ? value->stringBlobSize : baseType->array.elementCount;
                            }
                            else
                            {
                                std::ostringstream message;
                                message << "error, attempt to assign expression of " << value->getTypeName() << " to variable of type " << typeDef->getSimpleName();
                                error(message.str().c_str(), lineNumber);
                            }
                        }
                        break;
                    // Other value. Check that type definitions are equal.    
                    case Expression::VALUE_VARIABLE:
                        // Compare type definitions.
                        if(!typeDef->isCompatibleWith(value->variable->typeDefinition))
                        {
                            std::ostringstream message;
                            message << "error, attempt to assign expression of " << value->getTypeName() << " to variable of type " << typeDef->getSimpleName();
                            error(message.str().c_str(), lineNumber);
                        }
                        break;
                }
                
                // If expression is a single variable, and left-hand side type is alias,
                // check that the type identically matches the left-hand side's resolved type.
                if(value->category == Expression::EXPR_VARIABLE && typeDef->resolvedType == TypeDefinition::TYPE_IDENTIFIER)
                {
                    // Mismatched type.
                    if(value->variable->typeDefinition->resolvedType != typeDef->resolvedType)
                    {
                        std::ostringstream message;
                        message << "error, attempt to assign expression of type " << value->variable->typeDefinition->getSimpleName() << " to variable of type " << typeDef->getSimpleName();
                        error(message.str().c_str(), lineNumber);
                    }
                }
            }
        }
    }
    
    void AssignmentStatement::compile(std::ostream &fp, bool isASM)
    {
        // First evaluate the tough thing, the value (which can recurse into further values)
        value->compile(fp, isASM);
        // Then load the var into t1.
        variable->compile(fp, isASM);

        TypeDefinition* typeDef = NULL;
        bool isReturnValue = false;
        if(variable->context == Variable::VAR_VARIABLE)
        {        
            typeDef = variable->typeDefinition;
        }
        else if(variable->context == Variable::VAR_RETURN_VALUE)
        {
            typeDef = variable->program->head->returnValue;
            isReturnValue = true;
        }
        else
        {
            return;
        }
        
        // Records and arrays - block copy.
        if(typeDef->isArray(lineNumber) || typeDef->isRecord(lineNumber))
        {
            // Copy blob of memory into dest t1 from src t2.
            // CAREFUL: After this, t1 is invalidated -- it points at the location after the last item of data.
            value->emitDataBlockCopy("t1", "t2", "t3", fp, isASM);
        }
        // Real - read expression into floating point register and store the variable.
        else if(typeDef->isAliasForCategory(TypeDefinition::TYPE_REAL, lineNumber))
        {
            // Emit a read of the value (which gets stored in f4, and uses t2 as a temp for converted ints)
            value->emitFloatRead("f4", "t2", fp, isASM);
            // Deref t1 and store f4 into its address.
            if(isASM)
            {
                fp << "swc1 $f4, 0($t1) # Store value into " << (isReturnValue ? "the function return value" : "a variable") << std::endl;
            }
            else
            {
                fp << "*(t1) = f4 # Store value into " << (isReturnValue ? "the function return value" : "a variable") << std::endl;
            }
        }
        // Integer or character - read expression into integer register and store the variable.
        else
        {
            // Emit a read of the value (which gets stored in t2)
            value->emitIntegerRead("t2", fp, isASM);
            // Deref t1 and store t2 into its address.
            if(isASM)
            {
                fp << "sw $t2, 0($t1) # Store value into " << (isReturnValue ? "the function return value" : "a variable") << std::endl;
            }
            else
            {
                fp << "*(t1) = t2 # Store value into " << (isReturnValue ? "the function return value" : "a variable") << std::endl;
            }
        }

    }
    
    CallStatement::CallStatement(ProgramInvocation* invocation, unsigned int lineNumber)
    {
        category = Statement::STMT_CALL;
        this->invocation = invocation;
        this->lineNumber = lineNumber;
    }
    
    CallStatement::~CallStatement()
    {
        delete invocation;
    }
    
    void CallStatement::dump(FILE* f, int depth)
    {
        fprintf(f, "CallStatement(\n");
        depth++;
            dumpFormat(f, depth, "invocation = ");
            dumpNode<ProgramInvocation>(invocation, f, depth);
            fprintf(f, "\n");
        depth--;
        dumpFormat(f, depth, ")");
    }
    
    void CallStatement::inspect()
    {
        invocation->inspect();
    }
    
    void CallStatement::compile(std::ostream &fp, bool isASM)
    {
        invocation->compile(fp, isASM);
    }
    
    
    
    StatementList::StatementList(unsigned int lineNumber)
    {
        category = Statement::STMT_LIST;
        this->lineNumber = lineNumber;
    }
    
    StatementList::~StatementList()
    {
        for(size_t i = 0; i < list.size(); i++)
        {
            delete list[i];
        }
    }
    
    void StatementList::add(Statement* expr)
    {
        list.push_back(expr);
    }
    
    void StatementList::dump(FILE* f, int depth)
    {
        size_t i;
        fprintf(f, "StatementList(");
        depth++;
            for(i = 0; i < list.size(); i++)
            {
                if(i) fprintf(f, ",\n");
                else fprintf(f, "\n");
                dumpFormat(f, depth, "");
                dumpNode<Statement>(list[i], f, depth);
            }
            if(i) fprintf(f, "\n");
        depth--;
        if(i) dumpFormat(f, depth, ")");
        else fprintf(f, ")");
    }
    
    void StatementList::inspect()
    {
        for(size_t i = 0; i < list.size(); i++)
        {
            list[i]->inspect();
        }
    }
    
    
    void StatementList::compile(std::ostream &fp, bool isASM)
    {
        for(size_t i = 0; i < list.size(); i++)
        {
            list[i]->compile(fp, isASM);
        }
    }
}

