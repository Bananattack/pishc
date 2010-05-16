#include <iostream>
#include <sstream>
#include <stdio.h>
#include "expression.h"
#include "operator.h"
#include "variable.h"
#include "program.h"
#include "literal.h"
#include "type_definition.h"
#include "symbol.h"
#include "common.h"

namespace pish
{           
    Expression::Expression(Operator* op,unsigned int lineNumber)
    {
        category = EXPR_OPERATOR;
        valueType = VALUE_ERROR;
        this->op = op;
        this->lineNumber=lineNumber;
        promoteToReal = false;
        offset = -1;
        isReference = false;
    }
    
    Expression::Expression(Variable* variable, unsigned int lineNumber)
    {
        category = EXPR_VARIABLE;
        valueType = VALUE_ERROR;
        this->variable = variable;
        this->lineNumber = lineNumber;
        promoteToReal = false;
        offset = -1;
        isReference = false;
    }

    Expression::Expression(ProgramInvocation* call, unsigned int lineNumber)
    {
        category = EXPR_CALL;
        valueType = VALUE_ERROR;
        this->call = call;
        this->lineNumber = lineNumber;
        promoteToReal = false;
        offset = -1;
        isReference = false;
    }
    
    Expression::Expression(Literal* literal, unsigned int lineNumber)
    {
        category = EXPR_LITERAL;
        valueType = VALUE_ERROR;
        this->literal = literal;
        this->lineNumber = lineNumber;
        promoteToReal = false;
        offset = -1;
        isReference = false;
    }
    
    Expression::~Expression()
    {
        switch(category)
        {
            case EXPR_OPERATOR:
                delete op;
                break;
            case EXPR_VARIABLE:
                delete variable;
                break;
            case EXPR_CALL:
                delete call;
                break;
            case EXPR_LITERAL:
                delete literal;
                break;
        }
    }
    
    std::string Expression::getTypeName()
    {
        switch(valueType)
        {
            case VALUE_INTEGER:
                if(promoteToReal)
                {
                    return "type real";
                }
                return "type integer";
            case VALUE_REAL:
                return "type real";
            case VALUE_CHAR:
                if(promoteToReal)
                {
                    return "type real";
                }
                return "type char";
            case VALUE_STRING:
                return "type string literal";
            case VALUE_VARIABLE:
                return std::string("type ") + variable->typeDefinition->getSimpleName();
            default:
                return "erroneous expression";
        }
    }
    
    std::string Expression::getShortName()
    {
        switch(valueType)
        {
            case VALUE_INTEGER:
                if(promoteToReal)
                {
                    return "real";
                }
                return "integer";
            case VALUE_REAL:
                return "real";
            case VALUE_CHAR:
                if(promoteToReal)
                {
                    return "real";
                }
                return "char";
            case VALUE_STRING:
                return "array [..] of char";
            case VALUE_VARIABLE:
                return variable->typeDefinition->getSimpleName();
            default:
                return "erroneous expression";
        }
    }
    
    void Expression::dump(FILE* f, int depth)
    {
        fprintf(f, "Expression(\n");
        depth++;
        switch(category)
        {
            case EXPR_OPERATOR:
                dumpFormat(f, depth, "category = EXPR_OPERATOR, op = ");
                dumpNode<Operator>(op, f, depth);
                break;
            case EXPR_VARIABLE:
                dumpFormat(f, depth, "category = EXPR_VARIABLE, variable = ");
                dumpNode<Variable>(variable, f, depth);
                break;
            case EXPR_CALL:
                dumpFormat(f, depth, "category = EXPR_CALL, call = ");
                dumpNode<ProgramInvocation>(call, f, depth);
                break;
            case EXPR_LITERAL:
                dumpFormat(f, depth, "category = EXPR_LITERAL, literal = ");
                dumpNode<Literal>(literal, f, depth);
                break;
        }
        depth--;
        fprintf(f, "\n");
        dumpFormat(f, depth, ")");
    }
    
    void Expression::inspect()
    {
        offset = activeScope->createTemporary(this);
        switch(category)
        {
            case EXPR_OPERATOR:
                op->inspect();
                switch(op->type)
                {
                    case Operator::U_NOT:
                    case Operator::B_IDIV:
                    case Operator::B_MOD:
                    case Operator::B_AND:
                    case Operator::B_EQ:
                    case Operator::B_NEQ:
                    case Operator::B_LT:
                    case Operator::B_LE:
                    case Operator::B_GE:
                    case Operator::B_GT:
                        valueType = VALUE_INTEGER;
                        break;
                    case Operator::B_RDIV:
                        valueType = VALUE_REAL;
                        break;
                    case Operator::U_NEGATE:
                        valueType = op->operand->valueType;
                        break;
                    case Operator::B_ADD:
                    case Operator::B_SUB:
                    case Operator::B_MUL:
                        valueType = op->operand->promoteToReal ? VALUE_REAL : op->operand->valueType;
                        break;
                }
                break;
            case EXPR_VARIABLE:
                variable->inspect();

                if(variable->context == Variable::VAR_CONSTANT)
                {
                    switch(variable->constant->getType())
                    {
                        case Literal::LITERAL_INT:
                            valueType = VALUE_INTEGER;
                            break;
                        case Literal::LITERAL_REAL:
                            valueType = VALUE_REAL;
                            break;
                        case Literal::LITERAL_STRING:
                            valueType = VALUE_STRING;
                            stringBlobSize = strlen(variable->constant->getStringValue()) + 1;
                            break;
                    }
                }
                else if(variable->context == Variable::VAR_RETURN_VALUE)
                {
                    valueType = VALUE_ERROR;
                    std::ostringstream message;
                    message << "error, cannot use a scope's return value as an expression. did you forget the parentheses () to make a proper subprogram call?";
                    error(message.str().c_str(), lineNumber);
                }                
                else if(variable->context == Variable::VAR_VARIABLE)
                {
                    switch(variable->typeDefinition->resolveAliasCategory(lineNumber))
                    {
                        case TypeDefinition::TYPE_INTEGER:
                            valueType = VALUE_INTEGER;
                            break;
                        case TypeDefinition::TYPE_REAL:
                            valueType = VALUE_REAL;
                            break;
                        case TypeDefinition::TYPE_CHAR:
                            valueType = VALUE_CHAR;
                            break;
                        default:
                            // Not a primitive. Need to lookup variable type later.
                            valueType = VALUE_VARIABLE;
                    }
                }
                break;
            case EXPR_CALL:
                call->inspect();
                if(call->program)
                {
                    valueType = call->returnType;
                }
                else
                {
                    // Built-in? If it doesn't exist, or it doesn't return anything, VALUE_ERROR.
                    valueType = call->returnType; //VALUE_ERROR;
                }
                if(valueType == VALUE_VOID)
                {
                    valueType = VALUE_ERROR;
                    std::ostringstream message;
                    message << "error, procedure call not permissible as expression.";
                    error(message.str().c_str(), lineNumber);
                }
                break;
            case EXPR_LITERAL:
                switch(literal->getType())
                {
                    case Literal::LITERAL_INT:
                        valueType = VALUE_INTEGER;
                        break;
                    case Literal::LITERAL_REAL:
                        valueType = VALUE_REAL;
                        break;
                    case Literal::LITERAL_STRING:
                        valueType = VALUE_STRING;
                        stringBlobSize = strlen(literal->getStringValue()) + 1;
                        break;
                }
                break;
        }
    }
    
    void Expression::compile(std::ostream &fp, bool isASM)
    {
        bool useFloatRegister = false;
        switch(category)
        {
            case EXPR_OPERATOR:
                // Load operands into registers and perform operator:
                // binary t1 := t2 OP t3, (float f4 := f6 OP f8)
                // or unary t1 := OP t2, (float f4 := OP f6)
                op->compile(fp, isASM);
                // If it's a real-valued thing, store in a float register.
                useFloatRegister = (valueType == VALUE_REAL);
                break;
            case EXPR_VARIABLE:
                if(variable->context == Variable::VAR_CONSTANT)
                {
                    switch(variable->constant->getType())
                    {
                        case Literal::LITERAL_INT:
                            if(isASM)
                            {
                                fp << "li $t1, " << variable->constant->getIntValue() << std::endl;
                            }
                            else
                            {
                                fp << "t1 = " << variable->constant->getIntValue() << std::endl;
                            }
                            break;
                        case Literal::LITERAL_REAL:
                            useFloatRegister = true;
                            if(isASM)
                            {
                                std::string label = createLabel();
                                fp << ".data" << std::endl;
                                fp << label << ": .float "<< variable->constant->getRealValue() << std::endl;
                                fp << ".text" << std::endl;
                                fp << "l.s $f4, " << label << std::endl;
                            }
                            else
                            {
                                fp << "f4 = " << variable->constant->getRealValue() << std::endl;
                            }
                            break;
                        case Literal::LITERAL_STRING:
                        {
                            std::string stringLabel = createLabel();
                            std::string stringValue = variable->constant->getStringValue();
                            if(isASM)
                            {
                                fp << ".data # String literal as words (written in reverse)." << std::endl;
                                fp << ".word ";
                                int i;
                                int len = stringValue.size();
                                bool separator = false;
                                // Write string in reverse so it can be addressed the same as the stack frame.
                                for(i = stringBlobSize - 1; i > 0; i--)
                                {
                                    if(separator)
                                    {
                                        fp << ", ";
                                    }
                                    if(i < len)
                                    {
                                        fp << int(stringValue[i]);
                                    }
                                    // Extra characters are always \0.
                                    else
                                    {
                                        fp << 0;
                                    }
                                    separator = true;
                                }
                                fp << std::endl;
                                // Label the first character
                                fp << stringLabel << ": .word ";
                                if(i < len)
                                {
                                    fp << int(stringValue[i]);
                                }
                                // Extra characters are always \0.
                                else
                                {
                                    fp << 0;
                                }
                                fp << std::endl;
                                fp << ".text" << std::endl;
                                fp << "la $t1, " << stringLabel << std::endl;
                            }
                            else
                            {
                                fp << "t1 = \"" << stringValue << "\"" << std::endl;
                            }
                            break;
                        }
                    }
                }
                else if(variable->context == Variable::VAR_RETURN_VALUE)
                {
                    // Calculate offset to return value slot and indirectly reference return value.
                    std::cerr << "TODO: RETURN VALUE" << std::endl;
                    return;
                }
                else if(variable->context == Variable::VAR_VARIABLE)
                {
                    // Calculate variable offset by compiling var.
                    // This node needs to be dereferenced by higher level nodes. (So any later reads)
                    // We have to stop at the address resolution for the var, so that an arg is pass-by-reference.
                    // Variables are ALWAYS stored into int registers, because addresses are ints.
                    variable->compile(fp, isASM);
                }
                break;
            case EXPR_CALL:
                useFloatRegister = valueType == VALUE_REAL;
                call->compile(fp, isASM);
                break;
            case EXPR_LITERAL:
                switch(literal->getType())
                {
                    case Literal::LITERAL_INT:
                        if(isASM)
                        {
                            fp << "li $t1, " << literal->getIntValue() << std::endl;
                        }
                        else
                        {
                            fp << "t1 = " << literal->getIntValue() << std::endl;
                        }
                        break;
                    case Literal::LITERAL_REAL:
                        useFloatRegister = true;
                        if(isASM)
                        {
                            std::string label = createLabel();
                            fp << ".data" << std::endl;
                            fp << label << ": .float "<< literal->getRealValue() << std::endl;
                            fp << ".text" << std::endl;
                            fp << "l.s $f4, " << label << std::endl;
                        }
                        else
                        {
                            fp << "f4 = " << literal->getRealValue() << std::endl;
                        }
                        break;
                    case Literal::LITERAL_STRING:
                    {
                        std::string stringLabel = createLabel();
                        std::string stringValue = literal->getStringValue();
                        if(isASM)
                        {
                            fp << ".data # String literal as words (written in reverse)." << std::endl;
                            fp << ".word ";
                            int i;
                            int len = stringValue.size();
                            bool separator = false;
                            // Write string in reverse so it can be addressed the same as the stack frame.
                            for(i = stringBlobSize - 1; i > 0; i--)
                            {
                                if(separator)
                                {
                                    fp << ", ";
                                }
                                if(i < len)
                                {
                                    fp << int(stringValue[i]);
                                }
                                // Extra characters are always \0.
                                else
                                {
                                    fp << 0;
                                }
                                separator = true;
                            }
                            fp << std::endl;
                            // Label the first character
                            fp << stringLabel << ": .word ";
                            if(i < len)
                            {
                                fp << int(stringValue[i]);
                            }
                            // Extra characters are always \0.
                            else
                            {
                                fp << 0;
                            }
                            fp << std::endl;
                            fp << ".text" << std::endl;
                            fp << "la $t1, " << stringLabel << std::endl;
                        }
                        else
                        {
                            fp << "t1 = \"" << stringValue << "\"" << std::endl;
                        }
                        break;
                    }
                }
                break;
        }
        
        
        // Store the result we found into a temp.
        if(isASM)
        {   
            if(useFloatRegister)
            {
                fp << "swc1 $f4, -" << offset << "($fp) # Store temp" << std::endl;
            }
            else
            {
                fp << "sw $t1, -" << offset << "($fp) # Store temp" << std::endl;
            }
        }
        else
        {
            if(useFloatRegister)
            {
                fp << "*(fp - " << offset << ") = f4 # Store temp" << std::endl;   
            }
            else
            {
                fp << "*(fp - " << offset << ") = t1 # Store temp" << std::endl;
            }
        }
    }
   
    void Expression::emitAddress(std::string destRegister, std::ostream &fp, bool isASM)
    {
        if(isASM)
        {
            // R = *(fp - ofs)
            fp << "addi $" << destRegister << ", $fp, -" << offset << " # get address of temp" << std::endl;
            // Vars are references, so we need to deref their temp.
            // R = *R
            switch(category)
            {
                case EXPR_VARIABLE:
                    switch(variable->context)
                    {
                        case Variable::VAR_CONSTANT:
                            if(variable->constant->getType() == Literal::LITERAL_STRING)
                            {
                                fp << "lw $" << destRegister << ", 0($" << destRegister << ") # deref it to get address of string" << std::endl;
                            }
                            break;
                        case Variable::VAR_VARIABLE:
                            fp << "lw $" << destRegister << ", 0($" << destRegister << ") # deref it to get address of variable" << std::endl;    
                            break;
                    }
                    break;
                case EXPR_LITERAL:
                    if(literal->getType() == Literal::LITERAL_STRING)
                    {
                        fp << "lw $" << destRegister << ", 0($" << destRegister << ") # deref it to get address of string" << std::endl;
                    }
                    break;
            }
            
        }
        else
        {
            fp << destRegister << " = fp - " << offset << std::endl;
            // Vars are references, so we need to deref their temp.
            // R = *R
            if(category == Expression::EXPR_VARIABLE && variable->context == Variable::VAR_VARIABLE)
            {
                fp << destRegister << " = *(" << destRegister << ")" << std::endl;    
            }
        }
    }
    
    void Expression::emitIntegerRead(std::string destRegister, std::ostream &fp, bool isASM)
    {
        if(isASM)
        {
            // R = *(fp - ofs)
            fp << "lw $" << destRegister << ", -" << offset << "($fp) # get temp" << std::endl;
            // Vars are references, so we need to deref their temp.
            // R = *R
            switch(category)
            {
                case EXPR_VARIABLE:
                    switch(variable->context)
                    {
                        case Variable::VAR_CONSTANT:
                            if(variable->constant->getType() == Literal::LITERAL_STRING)
                            {
                                fp << "lw $" << destRegister << ", 0($" << destRegister << ") # deref temp to get string" << std::endl;
                            }
                            break;
                        case Variable::VAR_VARIABLE:
                            fp << "lw $" << destRegister << ", 0($" << destRegister << ") # deref temp to get variable" << std::endl;    
                            break;
                    }
                    break;
                case EXPR_LITERAL:
                    if(literal->getType() == Literal::LITERAL_STRING)
                    {
                        fp << "lw $" << destRegister << ", 0($" << destRegister << ") # deref temp to get string" << std::endl;
                    }
                    break;
            }
            
        }
        else
        {
            fp << destRegister << " = *(fp - " << offset << ")" << std::endl;
            // Vars are references, so we need to deref their temp.
            // R = *R
            if(category == Expression::EXPR_VARIABLE && variable->context == Variable::VAR_VARIABLE)
            {
                fp << destRegister << " = *(" << destRegister << ")" << std::endl;    
            }
        }
    }
    
    void Expression::emitFloatRead(std::string destRegister, std::string tempRegister, std::ostream &fp, bool isASM)
    {
        // Special case: int/char to real.
        // Assume if this is being called, we want promotion (even if for some reason it wasn't flagged earlier).
        if(valueType != VALUE_REAL)
        {
            // Temp is an integer register, so it can handle this int.
            emitIntegerRead(tempRegister, fp, isASM);
            
            if(isASM)
            {
                fp << "mtc1 $" << tempRegister << ", $" << destRegister << " # move value into float register" << std::endl;
                fp << "cvt.s.w $" << destRegister << ", $" << destRegister << " # convert to real" << std::endl;
            }
            else
            {
                fp << destRegister << " = real(" << tempRegister << ")" << std::endl;
            }
            return;
        }
        if(isASM)
        {
            // Usual case: temp = (fp - ofs) (temp may be modified after this for special cases)
            fp << "addi $" << tempRegister << ", $fp, -" << offset << std::endl;
            switch(category)
            {
                case EXPR_VARIABLE:
                    // Vars are references, so we need to deref their temp.
                    // temp = *(fp - ofs)
                    if(variable->context == Variable::VAR_VARIABLE)
                    {
                        fp << "lw $" << tempRegister << ", -" << offset << "($fp)" << std::endl;
                    }
                    break;
                default:
                    break;
            }
            // R = *temp
            fp << "l.s $" << destRegister << ", 0($" << tempRegister << ")" << std::endl;    
        }
        // As far as intermediate representation goes, we can pretend ints and floats reside in the same registers.
        else
        {
            fp << tempRegister << " = fp - " << offset << std::endl;
            // Vars are references, so we need to deref their temp.
            // temp = *(fp - ofs)
            if(category == Expression::EXPR_VARIABLE && variable->context == Variable::VAR_VARIABLE)
            {
                fp << tempRegister << " = *(fp - " << offset << ")" << std::endl;    
            }
            // R = *temp
            fp << destRegister << " = *(" << tempRegister << ")" << std::endl;    
        }
    }
    
    // Load this expression into the source register, and then copy its elements into the array pointed at by the destination register.
    // At the end, the dest register equals the end of the array.
    void Expression::emitDataBlockCopy(std::string destRegister, std::string srcRegister, std::string tempRegister, std::ostream &fp, bool isASM)
    {
        // R = *(fp - ofs)
        if(isASM)
        {
            fp << "lw $" << srcRegister << ", -" << offset << "($fp)" << std::endl;
        }
        else
        {
            fp << srcRegister << " = *(fp - " << offset << ")" << std::endl;
        }
        
        int len = 0;
        switch(category)
        {
            case EXPR_LITERAL:
                if(literal->getType() == Literal::LITERAL_STRING)
                {
                    // Characters plus null shoved in words.
                    len = (strlen(literal->getStringValue()) + 1) * 4;
                }
                break;
            case EXPR_VARIABLE:
                switch(variable->context)
                {
                    // Constant.
                    case Variable::VAR_CONSTANT:
                        if(variable->constant->getType() == Literal::LITERAL_STRING)
                        {
                            // Characters plus null shoved in words.
                            len = (strlen(variable->constant->getStringValue()) + 1) * 4;
                        }
                        break;
                    case Variable::VAR_VARIABLE:
                        // Length is equal to size of variable's resolved type.
                        len = variable->typeDefinition->size;
                        break;
                }
                break;
            default:
                break;
        }

        // Copy elements!
        fp << "# Copy " << len << " words into " << destRegister << " from " << srcRegister << std::endl;
        if(isASM)
        {
            for(int i = 0; i < len; i += 4)
            {
                // Copy into dest..
                fp << "lw $" << tempRegister << ", " << -i << "($" << srcRegister << ") # Read" << std::endl;
                fp << "sw $" << tempRegister << ", " << -i << "($" << destRegister << ") # Copy" << std::endl;
            }
        }
        else
        {
            for(int i = 0; i < len; i += 4)
            {
                // Copy into dest..
                fp << tempRegister << " = *(" << srcRegister << "-" << -i << ") # Read" << std::endl;
                // Move to next dest.
                fp << tempRegister << " = *(" << destRegister << "-" << -i << ") # Copy" << std::endl;
            }
        }
    }
}

