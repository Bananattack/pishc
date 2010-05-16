#pragma once

#include "abstract_node.h"
#include "compile.h"

namespace pish
{
    class Expression;
    
    class Operator : public AbstractNode, public Inspectable
    {
        public:
            enum OperatorType
            {
                // Unary operators.
                // Unary plus is not an operator at this point, because it will not affect any expression.
                U_NOT,      // not a
                U_NEGATE,   // -a
                
                // Binary operators.
                B_ADD,      // a + b
                B_SUB,      // a - b
                B_MUL,      // a * b
                B_RDIV,     // a / b (real division)
                B_IDIV,     // a div b (int division)
                B_MOD,      // a mod b
                B_AND,      // a and b
                B_EQ,       // a = b
                B_NEQ,      // a <> b
                B_LT,       // a < b
                B_LE,       // a <= b
                B_GE,       // a >= b
                B_GT,       // a > b
            };
            
            OperatorType type;
            Expression* operand;
            Expression* rightOperand;
            
            Operator(OperatorType type, Expression* operand, Expression* rightOperand, unsigned int lineNumber);
            virtual ~Operator();
            
            std::string getOperatorName();
            
            virtual void dump(FILE* f, int depth);
            virtual void inspect();
            virtual void compile(std::ostream &fp, bool isASM);
    };
}
