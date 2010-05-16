#pragma once

#include <stdio.h>
#include <vector>
#include "abstract_node.h"
#include "compile.h"
#include "dump.h"

namespace pish
{
    class Expression;
    class Identifier;
    class Variable;
    class Literal;
    class TypeDefinition;
    class Program;

    class Subscript : public AbstractNode
    {
        public:
            enum SubscriptCategory
            {
                SUB_ATTRIBUTE,      // a.b
                SUB_INDEX,          // a[i]
            };
            
            SubscriptCategory category;
            
            union
            {
                // V.attribute...
                Identifier* attribute;
                // V[index]...
                Expression* index;
            };
            
            // The type of the variable which is being subscripted.
            TypeDefinition* subscriptedType; 
                        
            Subscript(Identifier* attribute, unsigned int lineNumber);
            Subscript(Expression* index, unsigned int lineNumber);
            virtual ~Subscript();
            virtual void dump(FILE* f, int depth);
    };
    
    class SubscriptList : public AbstractNode
    {
        public:
            std::vector<Subscript*> list;
            
            SubscriptList(unsigned int lineNumber)
            {
                this->lineNumber = lineNumber;
            }
            
            ~SubscriptList()
            {
                for(size_t i = 0; i < list.size(); i++)
                {
                    delete list[i];
                }
            }
            
            void add(Subscript* expr)
            {
                list.push_back(expr);
            }
            
            Subscript* getItem(int i)
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
                fprintf(f, "SubscriptList(");
                depth++;
                    for(i = 0; i < list.size(); i++)
                    {
                        if(i) fprintf(f, ",\n");
                        else fprintf(f, "\n"); 
                        dumpFormat(f, depth, "");
                        dumpNode<Subscript>(list[i], f, depth);
                    }
                    if(i) fprintf(f, "\n");
                depth--;
                if(i) dumpFormat(f, depth, ")");
                else fprintf(f, ")");
            }
    };

    class Variable : public AbstractNode, public Inspectable, public Compilable
    {
        public:
            // Starting variable.
            Identifier* identifier;
            SubscriptList* subscripts;

            // Semantic information about a variable.
            enum VariableContext
            {
                VAR_CONSTANT,       // Constant. Can never have subscripts. Associated with a constant literal.
                VAR_VARIABLE,       // Variable. Any amount of subscripting. Associated with a type definition, and offset info.
                VAR_RETURN_VALUE,   // Return value. Can never have subscripts. Associated with a program.
                VAR_ERROR,          // Error. Invalid anywhere.
            };
        
            VariableContext context;
            

            // Context-sensitive union fun.
            union
            {
                // Used by VAR_CONSTANT.
                Literal* constant;
                // Used by VAR_RETURN_VALUE            
                Program* program;
                // Definition of the variable's type, derived from semantic check. NULL for simple primitives.
                TypeDefinition* typeDefinition;
            };
           
            Variable(Identifier* identifier, SubscriptList* subscripts, unsigned int lineNumber);
            virtual ~Variable();
            virtual void dump(FILE* f, int depth);
            virtual void inspect();
            virtual void compile(std::ostream &fp, bool isASM);
    };
}

