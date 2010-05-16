#include <iostream>
#include <sstream>
#include "dump.h"
#include "operator.h"
#include "expression.h"
#include "variable.h"
#include "common.h"
#include "literal.h"

namespace pish
{
    Operator::Operator(OperatorType type, Expression* operand, Expression* rightOperand,
        unsigned int lineNumber)
    {
        this->type = type;
        this->operand = operand;
        this->rightOperand = rightOperand;
        this->lineNumber = lineNumber;
    }
    
    Operator::~Operator()
    {
        delete operand;
        delete rightOperand;
    }
    
    std::string Operator::getOperatorName()
    {
        switch(type)
        {
            case U_NOT: return "`not` logical negation";
            case U_NEGATE: return "`-` negation";
            case B_ADD: return "`+` addition";
            case B_SUB: return "`-` subtraction";
            case B_MUL: return "`*` multiplication";
            case B_RDIV: return "`/` real division";
            case B_IDIV: return "`div` integer division";
            case B_MOD: return "`mod` integer modulo";
            case B_AND: return "`and` boolean conjunction";
            case B_EQ: return "`=` equality test";
            case B_NEQ: return "`<>` inequality test";
            case B_LT: return "`<` less-than order comparison";
            case B_LE: return "`<` less-than-or-equal order comparison";
            case B_GE: return "`<` greater-than-or-equal order comparison";
            case B_GT: return "`<` greater-than order comparison";
            default: return "UNKNOWN OPERATOR";
        }
    }
    
    void Operator::dump(FILE* f, int depth)
    {
        fprintf(f, "Operator(\n");
        depth++;
            dumpFormat(f, depth, "type = %d, operand = ", type);
            dumpNode<Expression>(operand, f, depth);
            fprintf(f, ",\n");
            dumpFormat(f, depth, "rightOperand = ");
            dumpNode<Expression>(rightOperand, f, depth);
        depth--;
        fprintf(f, "\n");
        dumpFormat(f, depth, ")");
    }
    
    void Operator::inspect()
    {
        operand->inspect();
        // Unary operators don't have a right operand
        if(rightOperand)
        {
            rightOperand->inspect();
        }
        // Return out if there are errors on either side.
        if(operand->valueType == Expression::VALUE_ERROR || (rightOperand && rightOperand->valueType == Expression::VALUE_ERROR))
        {
            return;
        }
        // Now, check type compatibility.
        switch(type)
        {
            // Mixed arithmetic operators
            // -a : integer/real -> integer/real
            case U_NEGATE:
                if(operand->valueType != Expression::VALUE_INTEGER && operand->valueType != Expression::VALUE_REAL)
                {
                    std::ostringstream message;
                    message << "error, attempt to perform " << getOperatorName() << " on " << operand->getTypeName();
                    error(message.str().c_str(), lineNumber);
                }
                break;
            // a + b : integer/real, integer/real -> integer/real
            // a - b : integer/real, integer/real -> integer/real
            // a * b : integer/real, integer/real -> integer/real
            // a / b : integer/real, integer/real -> real
            case B_ADD:
            case B_SUB:
            case B_MUL:
            case B_RDIV:
                if((operand->valueType != Expression::VALUE_INTEGER && operand->valueType != Expression::VALUE_REAL)
                    || (rightOperand->valueType != Expression::VALUE_INTEGER && rightOperand->valueType != Expression::VALUE_REAL))
                {
                    std::ostringstream message;
                    message << "error, attempt to perform " << getOperatorName() << " between " << operand->getTypeName() << " and " << rightOperand->getTypeName();
                    error(message.str().c_str(), lineNumber);
                }
                // Promote if same type. Or in the case of real division, ALWAYS promote.
                else if(type == B_RDIV || operand->valueType != rightOperand->valueType)
                {
                    operand->promoteToReal = true;
                    rightOperand->promoteToReal = true;
                }
                break;
            // Integer-specific arithmetic operators
            // not a : integer -> integer
            case U_NOT:
                if(operand->valueType != Expression::VALUE_INTEGER)
                {
                    std::ostringstream message;
                    message << "error, attempt to perform " << getOperatorName() << " on " << operand->getTypeName();
                    error(message.str().c_str(), lineNumber);
                }
                break;
            // a div b : integer, integer -> integer
            // a mod b : integer, integer -> integer
            // a and b : integer, integer -> integer
            case B_IDIV:
            case B_MOD:
            case B_AND:
                if(operand->valueType != Expression::VALUE_INTEGER || rightOperand->valueType != Expression::VALUE_INTEGER)
                {
                    std::ostringstream message;
                    message << "error, attempt to perform " << getOperatorName() << " between " << operand->getTypeName() << " and " << rightOperand->getTypeName();
                    error(message.str().c_str(), lineNumber);
                }
                break;
            // Comparison operators
            // a = b : integer/real/char, integer/real/char -> int
            // a <> b : integer/real/char, integer/real/char -> int
            // a < b : integer/real/char, integer/real/char -> int
            // a <= b : integer/real/char, integer/real/char -> int
            // a >= b : integer/real/char, integer/real/char -> int
            // a > b : integer/real/char, integer/real/char -> int
            case B_EQ:
            case B_NEQ:            
            case B_LT:
            case B_LE:   
            case B_GE:
            case B_GT:
                if(operand->valueType == Expression::VALUE_STRING)
                {
                    Expression* value = operand;
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
                    
                    if(length != 1)
                    {
                        std::ostringstream message;
                        message << "error, left operand is a string literal that is invalid length to be character constant (only integers, reals, and chars, not strings can be compared)";
                        error(message.str().c_str(), lineNumber);
                    }
                    else
                    {
                        value->valueType = Expression::VALUE_CHAR;
                    }
                }
                if(rightOperand->valueType == Expression::VALUE_STRING)
                {
                    Expression* value = rightOperand;
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
                    
                    if(length != 1)
                    {
                        std::ostringstream message;
                        message << "error, right operand is a string literal that is invalid length to be character constant (only integers, reals, and chars, not strings can be compared)";
                        error(message.str().c_str(), lineNumber);
                    }
                    else
                    {
                        value->valueType = Expression::VALUE_CHAR;
                    }
                }
                if((operand->valueType != Expression::VALUE_INTEGER && operand->valueType != Expression::VALUE_REAL && operand->valueType != Expression::VALUE_CHAR)
                    || (rightOperand->valueType != Expression::VALUE_INTEGER && rightOperand->valueType != Expression::VALUE_REAL && rightOperand->valueType != Expression::VALUE_CHAR))
                {
                    std::ostringstream message;
                    message << "error, attempt to perform " << getOperatorName() << " between " << operand->getTypeName() << " and " << rightOperand->getTypeName();
                    error(message.str().c_str(), lineNumber);                
                }
                if(operand->valueType == Expression::VALUE_REAL || rightOperand->valueType == Expression::VALUE_REAL)
                {
                    operand->promoteToReal = true;
                    rightOperand->promoteToReal = true;
                }
                break;
        }
    }
    
    static void emitFloatComparison(std::string destRegister, bool targetFlagValue, std::ostream &fp, bool isASM)
    {
        // Comparisons
        std::string endIfLabel = createLabel();
        if(isASM)
        {
            // flag = false;
            fp << "li $" << destRegister << ", 0" << std::endl;
            // if(fp_cond == true)
            // {
                if(targetFlagValue)
                {
                    fp << "bc1f " << endIfLabel << std::endl;
                }
                else
                {
                    fp << "bc1t " << endIfLabel << std::endl;
                }
                // flag = true;
                fp << "li $" << destRegister << ", 1" << std::endl;
            // }
            fp << endIfLabel << ":";
        }
        // Assume intermediate representation shows as simple compare instruction instead.
    }
    
    void Operator::compile(std::ostream &fp, bool isASM)
    {
        bool useFloatRegister = false;
        operand->compile(fp, isASM);
        if(rightOperand)
        {
            rightOperand->compile(fp, isASM);
        }
        
        // load operand->offset into t2/f6
        if(operand->valueType == Expression::VALUE_REAL || operand->promoteToReal)
        {
            operand->emitFloatRead("f6", "t2", fp, isASM);
            useFloatRegister = true;
        }
        else
        {
            operand->emitIntegerRead("t2", fp, isASM);
        }
        // if binary: load rightOperand->offset into t3/f8
        if(rightOperand)
        {   
            // Assume if left-hand side is real, right-hand side must necessarily be promoted to real.
            if(useFloatRegister || rightOperand->valueType == Expression::VALUE_REAL || rightOperand->promoteToReal)
            {
                rightOperand->emitFloatRead("f8", "t3", fp, isASM);
            }
            else
            {
                rightOperand->emitIntegerRead("t3", fp, isASM);
            }
        }
        // perform operation, and put into t1/f4
        switch(type)
        {
            case U_NOT:
                if(isASM)
                {
                    // Trick: !t2 is equivalent to UNSIGNED t2 < 1
                    // Useful since MIPS doesn't have logical not.
                    fp << "sltiu $t1, $t2, 1" << std::endl;
                }
                else
                {
                    fp << "t1 = not t1" << std::endl;
                }
                break;
            case U_NEGATE:
                if(isASM)
                {
                    if(useFloatRegister)
                    {
                        fp << "neg.s $f4, $f6" << std::endl;
                    }
                    else
                    {
                        fp << "sub $t1, $0, $t2" << std::endl;
                    }
                }
                else
                {
                    if(useFloatRegister)
                    {
                        fp << "t1 = -t2" << std::endl;
                    }
                    else
                    {
                        fp << "f4 = -f6" << std::endl;
                    }
                }
                break;
            case B_ADD:
                if(isASM)
                {
                    if(useFloatRegister)
                    {
                        fp << "add.s $f4, $f6, $f8" << std::endl;
                    }
                    else
                    {
                        fp << "add $t1, $t2, $t3" << std::endl;
                    }
                }
                else
                {
                    if(useFloatRegister)
                    {
                        fp << "t1 = t2 + t3" << std::endl;
                    }
                    else
                    {
                        fp << "f4 = f6 + f8" << std::endl;
                    }
                }
                break;
            case B_SUB:
                if(isASM)
                {
                    if(useFloatRegister)
                    {
                        fp << "sub.s $f4, $f6, $f8" << std::endl;
                    }
                    else
                    {
                        fp << "sub $t1, $t2, $t3" << std::endl;
                    }
                }
                else
                {
                    if(useFloatRegister)
                    {
                        fp << "t1 = t2 - t3" << std::endl;
                    }
                    else
                    {
                        fp << "f4 = f6 - f8" << std::endl;
                    }
                }
                break;
            case B_MUL:
                if(isASM)
                {
                    if(useFloatRegister)
                    {
                        fp << "mul.s $f4, $f6, $f8" << std::endl;
                    }
                    else
                    {
                        fp << "mul $t1, $t2, $t3" << std::endl;
                    }
                }
                else
                {
                    if(useFloatRegister)
                    {
                        fp << "t1 = t2 * t3" << std::endl;
                    }
                    else
                    {
                        fp << "f4 = f6 * f8" << std::endl;
                    }
                }
                break;
            case B_RDIV:
                if(isASM)
                {
                    fp << "div.s $f4, $f6, $f8" << std::endl;
                }
                else
                {
                    fp << "f4 = f6 / f8" << std::endl;
                }
                break;
            case B_IDIV:
                if(isASM)
                {
                    fp << "div $t2, $t3" << std::endl;
                    fp << "mflo $t1" << std::endl;
                }
                else
                {
                    fp << "t1 = t2 / t3" << std::endl;
                }
                break;
            case B_MOD:
                if(isASM)
                {
                    fp << "div $t2, $t3" << std::endl;
                    fp << "mfhi $t1" << std::endl;
                }
                else
                {
                    fp << "t1 = t2 / t3" << std::endl;
                }
                break;
            case B_AND:
                if(isASM)
                {
                    // Compare the numbers. If they're equal, t1 == 0.
                    fp << "and $t1, $t2, $t3" << std::endl;
                }
                else
                {
                    fp << "t1 = t1 and t2" << std::endl;
                }
                break;
            case B_EQ:
                if(isASM)
                {
                    if(useFloatRegister)
                    {
                        fp << "c.eq.s $f6, $f8" << std::endl;
                        emitFloatComparison("t1", true, fp, isASM);
                    }
                    else
                    {
                        // Compare the numbers. If they're equal, t1 == 0.
                        fp << "xor $t1, $t2, $t3" << std::endl;
                        // Trick: check if t1 is zero. Equivalent to UNSIGNED t1 < 1
                        fp << "sltiu $t1, $t1, 1" << std::endl;
                    }
                }
                else
                {
                    if(useFloatRegister)
                    {
                        fp << "t1 = f6 == f8" << std::endl;
                    }
                    else
                    {
                        fp << "t1 = t2 == t3" << std::endl;
                    }
                }
                break;
            case B_NEQ:
                if(isASM)
                {
                    if(useFloatRegister)
                    {
                        fp << "c.eq.s $f6, $f8" << std::endl;
                        emitFloatComparison("t1", false, fp, isASM);
                    }
                    else
                    {
                        // Compare the numbers. If they're equal, t1 == 0.
                        fp << "xor $t1, $t2, $t3" << std::endl;
                        // Trick: check if t1 is non-zero. Same as 0 < UNSIGNED t1
                        fp << "sltu $t1, $0, $t1" << std::endl;
                    }
                }
                else
                {
                    if(useFloatRegister)
                    {
                        fp << "t1 = f6 != f8" << std::endl;
                    }
                    else
                    {
                        fp << "t1 = t2 != t3" << std::endl;
                    }
                }
                break;
            case B_LT:
                if(isASM)
                {
                    if(useFloatRegister)
                    {
                        fp << "c.lt.s $f6, $f8" << std::endl;
                        emitFloatComparison("t1", true, fp, isASM);
                    }
                    else
                    {
                        fp << "slt $t1, $t2, $t3" << std::endl;
                    }
                }
                else
                {
                    if(useFloatRegister)
                    {
                        fp << "t1 = f6 < f8" << std::endl;
                    }
                    else
                    {
                        fp << "t1 = t2 < t3" << std::endl;
                    }
                }
                break;
            case B_LE:
                if(isASM)
                {
                    if(useFloatRegister)
                    {
                        fp << "c.le.s $f6, $f8" << std::endl;
                        emitFloatComparison("t1", true, fp, isASM);
                    }
                    else
                    {
                        // t3 < t2
                        fp << "slt $t1, $t3, $t2" << std::endl;
                        // Logically negate the term to get (t3 >= t2) or (t2 <= t3)
                        fp << "sltiu $t1, $t1, 1" << std::endl;
                    }
                }
                else
                {
                    if(useFloatRegister)
                    {
                        fp << "t1 = f6 <= f8" << std::endl;
                    }
                    else
                    {
                        fp << "t1 = t2 <= t3 # = not (t3 < t2) = not (t3 > t2)" << std::endl;
                    }
                }
                break;
            case B_GE:
                if(isASM)
                {
                    if(useFloatRegister)
                    {
                        fp << "c.le.s $f8, $f6" << std::endl;
                        emitFloatComparison("t1", true, fp, isASM);
                    }
                    else
                    {
                        // t2 < t3
                        fp << "slt $t1, $t2, $t3" << std::endl;
                        // Logically negate the term to get (t2 >= t3)
                        fp << "sltiu $t1, $t1, 1" << std::endl;
                    }
                }
                else
                {
                    if(useFloatRegister)
                    {
                        fp << "t1 = f6 >= f8" << std::endl;
                    }
                    else
                    {
                        fp << "t1 = t2 >= t3 # = not (t2 < t3)" << std::endl;
                    }
                }
                break;
            case B_GT:
                if(isASM)
                {
                    if(useFloatRegister)
                    {
                        fp << "c.lt.s $f8, $f6" << std::endl;
                        emitFloatComparison("t1", true, fp, isASM);
                    }
                    else
                    {
                        fp << "slt $t1, $t3, $t2" << std::endl;
                    }
                }
                else
                {
                    if(useFloatRegister)
                    {
                        fp << "t1 = f6 > f8" << std::endl;
                    }
                    else
                    {
                        fp << "t1 = t2 > t3 # = t3 < t2" << std::endl;
                    }
                }
                break;
        }
    }
}
