#pragma once

#include "abstract_node.h"
#include "compile.h"
#include "expression.h"

namespace pish
{
    class Identifier;
    class IdentifierList;
    class ExpressionList;
    class DeclarationList;
    class StatementList;
    class TypeDefinition;
    class Program;
    class SymbolTable;
    
    // Invocation of a program.
    class ProgramInvocation : public AbstractNode, public Inspectable, public Compilable
    {
        public:
            Identifier* name;
            ExpressionList* arguments;
            
            // Semantically validated.
            Program* program;
            // Return value for a built-in type, defaults to error.
            Expression::ExpressionValueType returnType;
            
            ProgramInvocation(Identifier* name, ExpressionList* arguments, unsigned int lineNumber);
            virtual ~ProgramInvocation();
            
            virtual void dump(FILE* f, int depth);
            virtual void inspect();
            virtual void compile(std::ostream &fp, bool isASM);
    };
    
    // Actual body of a program.
    // Defines variables the program needs and then lists a bunch of statements.
    class ProgramBody : public AbstractNode, public Inspectable, public Compilable
    {
        public:
            // Local variables and functions.
            DeclarationList* locals;
            // List of statements, in the order they appear.
            StatementList* statements;
            
            
            std::string statementLabel;
            
            ProgramBody(DeclarationList* locals, StatementList* statements, unsigned int lineNumber);
            virtual ~ProgramBody();
            
            virtual void dump(FILE* f, int depth);
            virtual void inspect();
            virtual void compile(std::ostream &fp, bool isASM);
    };

    // Program head.
    class ProgramHead : public AbstractNode, public Inspectable
    {
        public:
            enum HeadType
            {
                HEAD_MAIN,  // Main programs have lists of identifiers.
                HEAD_SUB,   // Subprograms have lists of parameters.
            };
        
            HeadType type;
            
            Identifier* name;
            
            // The type which is returned for this function.
            // NULL for procedures.
            TypeDefinition* returnValue; 
            union
            {
                // Identifier list (used by main programs.)
                // Should be (input, output) normally.
                IdentifierList* identifierList;
                
                // Parameters accepted by this function.
                DeclarationList* parameters;
            };
            
            ProgramHead(Identifier* name, TypeDefinition* returnValue, DeclarationList* parameters, unsigned int lineNumber);
            ProgramHead(Identifier* name, IdentifierList* list, unsigned int lineNumber);
            virtual ~ProgramHead();
            
            virtual void dump(FILE* f, int depth);
            virtual void inspect();
    };
    
    class Program : public AbstractNode, public Inspectable, public Compilable
    {
        public:
            // Head.
            ProgramHead* head;
            // Body.
            // NULL for forward declarations.
            ProgramBody* body;
            
            bool patched;
		
		
            
            int frameSize;
            int nestIndex;
            int returnValueOffset;
            
            // This (sub)program's scope for variables, functions, and constants.
            SymbolTable* localSymbols;
            // The (sub)program's scope for type declarations.
            SymbolTable* localTypes;
			
            // Old frame pointer, old stack pointer, return address, old nesting entry, t1-t7
			static const int EXTRA_STACK_ITEMS = 4 + 7;
			
			std::string functionLabel;
		            
            Program(ProgramHead* head, ProgramBody* body, unsigned int lineNumber);
            virtual ~Program();
            
            virtual void dump(FILE* f, int depth);
            virtual void inspect();
            virtual void compile(std::ostream &fp, bool isASM);
    };
}
