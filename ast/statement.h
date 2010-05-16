#pragma once

#include <vector>

#include "abstract_node.h"
#include "compile.h"

namespace pish
{
    class Expression;
    class Variable;
    class ProgramInvocation;

    class Statement : public AbstractNode, public Inspectable, public Compilable
    {
        public:
            enum StatementCategory
            {
                STMT_IF,        // if a then Statement [else Statement]
                STMT_WHILE,     // while a do Statement
                STMT_FOR,       // for i := a {to|downto} b do Statement
                STMT_ASSIGN,    // a := b
                STMT_CALL,      // a([arg, ...])
                STMT_LIST,      // begin [Statement; ...] end
            };
        
            StatementCategory category;
            
            virtual ~Statement()
            {
            }
            virtual void dump(FILE* f, int depth) = 0;
            virtual void inspect() = 0;
            virtual void compile(std::ostream &fp, bool isASM) = 0;
    };
    
    class IfStatement : public Statement
    {
        public:
            // Value to test.
            Expression* test;
            // Statement to execute when test is true.
            Statement* trueStatement;
            // Optional else clause. NULL when omitted.
            Statement* falseStatement;
            
            IfStatement(Expression* test, Statement* trueStatement, Statement* falseStatement, unsigned int lineNumber);
            virtual ~IfStatement();
            virtual void dump(FILE* f, int depth);
            virtual void inspect();
            virtual void compile(std::ostream &fp, bool isASM);
    };
    
    class WhileStatement : public Statement
    {
        public:
            // Value to test.
            Expression* test;
            // Statement to execute when test is true.
            Statement* statement;
            
            WhileStatement(Expression* test, Statement* statement, unsigned int lineNumber);
            virtual ~WhileStatement();
            virtual void dump(FILE* f, int depth);
            virtual void inspect();
            virtual void compile(std::ostream &fp, bool isASM);
    };
    
    class ForStatement : public Statement
    {
        public:
            enum Direction
            {
                FOR_TO,
                FOR_DOWNTO
            };
        
            // Variable to iterate with.
            Variable* variable;
            // Start of range.
            Expression* lower;
            // End of range.
            Expression* upper;
            // Direction to iterate in.
            Direction direction;
            // Statement to execute while iterating.
            Statement* statement;
            
            ForStatement(Variable* variable, Expression* lower, Expression* upper, Direction direction, Statement* statement,
            unsigned int lineNumber);
            virtual ~ForStatement();
            virtual void dump(FILE* f, int depth);
            virtual void inspect();
            virtual void compile(std::ostream &fp, bool isASM);
    };
    
    class AssignmentStatement : public Statement
    {
        public:
            // Variable to use.
            Variable* variable;
            // Expression to assign to value.
            Expression* value;
        
            AssignmentStatement(Variable* variable, Expression* value, unsigned int lineNumber);
            virtual ~AssignmentStatement();
            virtual void dump(FILE* f, int depth);
            virtual void inspect();
            virtual void compile(std::ostream &fp, bool isASM);
    };
    
    class CallStatement : public Statement
    {
        public:
            ProgramInvocation* invocation;
            
            CallStatement(ProgramInvocation* invocation, unsigned int lineNumber);
            virtual ~CallStatement();
            virtual void dump(FILE* f, int depth);
            virtual void inspect();
            virtual void compile(std::ostream &fp, bool isASM);
    };
    
    class StatementList : public Statement
    {
        public:
            std::vector<Statement*> list;
            
            StatementList(unsigned int lineNumber);
            virtual ~StatementList();
            
            void add(Statement* expr);
            virtual void dump(FILE* f, int depth);
            virtual void inspect();
            virtual void compile(std::ostream &fp, bool isASM);
    };
}

