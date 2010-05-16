#pragma once

#include <vector>
#include <string>

#include "abstract_node.h"
#include "compile.h"
#include "dump.h"

namespace pish
{
    class Operator;
    class Variable;
    class ProgramInvocation;
    class Literal;
    class TypeDefinition;
    class Symbol;

    class Expression : public AbstractNode, public Inspectable, public Compilable
    {
        public:
            // Broad categories of expressions figured out during syntactic parsing.
            enum ExpressionCategory
            {
                EXPR_OPERATOR,  // Operator.
                EXPR_VARIABLE,  // Variable
                EXPR_CALL,      // Program call.
                EXPR_LITERAL,   // Literal value.
            };
            
            // Types of values an expression can be deduced to have during semantic checks.
            enum ExpressionValueType
            {
                VALUE_INTEGER,      // Integer epxression.
                VALUE_REAL,         // Real expression
                VALUE_CHAR,         // Character expression
                VALUE_STRING,       // String literal.
                VALUE_VARIABLE,     // Other. Look at variable's definition to figure out.
                VALUE_ERROR,        // Error value. Invalid anywhere.
                VALUE_VOID,         // Void value. Invalid anywhere.
            };
            
            ExpressionCategory category; 
            union
            {
                Operator* op;
                Variable* variable;
                ProgramInvocation* call;
                Literal* literal;
            };
            
            // Value of the expression.
            // Initialized to VALUE_ERROR until compileIntermediate takes place.
            ExpressionValueType valueType;
            // Whether to promote this expression when comparing values.
            bool promoteToReal;
            // The size of string to emit, if expression is a string (pads for arguments)
            int stringBlobSize;
            
            // The offset of the temporary or variable that this expression yields.
            int offset;
            bool isReference;
            
            Expression(Operator* op, unsigned int lineNumber);
            Expression(Variable* variable, unsigned int lineNumber);
            Expression(ProgramInvocation* call, unsigned int lineNumber);
            Expression(Literal* literal, unsigned int lineNumber);
            
            std::string getTypeName();
            std::string getShortName();
            
            virtual ~Expression();
            virtual void dump(FILE* f, int depth);
            virtual void inspect();
            virtual void compile(std::ostream &fp, bool isASM);
            void emitAddress(std::string destRegister, std::ostream &fp, bool isASM);
            void emitIntegerRead(std::string destRegister, std::ostream &fp, bool isASM);
            void emitFloatRead(std::string destRegister, std::string tempRegister, std::ostream &fp, bool isASM);
            void emitDataBlockCopy(std::string destRegister, std::string srcRegister, std::string tempRegister, std::ostream &fp, bool isASM);
    };
    
    class ExpressionList : public AbstractNode
    {
        public:
            std::vector<Expression*> list;
            
            ExpressionList(unsigned int lineNumber)
            {
                this->lineNumber = lineNumber;
            }
            
            ~ExpressionList()
            {
                for(size_t i = 0; i < list.size(); i++)
                {
                    delete list[i];
                }
            }
            
            void add(Expression* expr)
            {
                list.push_back(expr);
            }
            
            Expression* getItem(int i)
            {
                return list[i];
            }
            
            size_t getSize()
            {
                return list.size();
            }
            
            virtual void dump(FILE* f, int depth)
            {
                size_t i;
                fprintf(f, "ExpressionList(");
                depth++;
                    for(i = 0; i < list.size(); i++)
                    {
                        if(i) fprintf(f, ",\n");
                        else fprintf(f, "\n"); 
                        dumpFormat(f, depth, "");
                        dumpNode<Expression>(list[i], f, depth);
                    }
                    if(i) fprintf(f, "\n");
                depth--;
                if(i) dumpFormat(f, depth, ")");
                else fprintf(f, ")");
            } 
    };
}



