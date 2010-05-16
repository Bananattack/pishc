#pragma once

#include <vector>
#include "dump.h"

#include "abstract_node.h"
#include "compile.h"

namespace pish
{
    class Identifier;
    class IdentifierList;
    class TypeDefinition;
    class Expression;
    class Program;

    class Declaration : public AbstractNode, public Inspectable, public Compilable
    {
        public:
            enum DeclarationCategory
            {
                // A variable of a given type.
                DECL_VARIABLE,
                // An alias of another type.
                DECL_ALIAS,
                // A constant value.
                DECL_CONSTANT,
                // A subprogram, which can can only be declared locally to an outer program.
                // ie. Ensure no records/arrays of function declarations. That doesn't make sense for this language.
                DECL_PROGRAM,
                // A list of multiple declarations.
                DECL_LIST,
            };
        
            DeclarationCategory category;
            
            virtual ~Declaration()
            {
            }
            virtual void dump(FILE* f, int depth) = 0;
            virtual void inspect() = 0;
            
            virtual void compile(std::ostream &fp, bool isASM)
            {
            }
    };
    
    class VariableDeclaration : public Declaration
    {
        public:
            // Names of variables.
            IdentifierList* list;
            // Variable type.
            TypeDefinition* type;
            
            VariableDeclaration(IdentifierList* list, TypeDefinition* type, unsigned int lineNumber);
            virtual ~VariableDeclaration();
            virtual void dump(FILE* f, int depth);
            virtual void inspect();
    };
    
    class AliasDeclaration : public Declaration
    {
        public:
            // Name of this alias.
            Identifier* identifier;
            // Type to alias.
            TypeDefinition* type;
            
            AliasDeclaration(Identifier* identifier, TypeDefinition* type, unsigned int lineNumber);
            virtual ~AliasDeclaration();
            virtual void dump(FILE* f, int depth);
            virtual void inspect();
    };
    
    class ConstantDeclaration : public Declaration
    {
        public:
            // Name of this constant.
            Identifier* identifier;
            // Expression consisting of a literal or single constant, possibly negated (if numeric).
            Expression* expression;
            
            ConstantDeclaration(Identifier* identifier, Expression* expression, unsigned int lineNumber);
            virtual ~ConstantDeclaration();
            virtual void dump(FILE* f, int depth);
            virtual void inspect();
    };
    
    class ProgramDeclaration : public Declaration
    {
        public:
            Program* program;
            
            ProgramDeclaration(Program* program, unsigned int lineNumber);
            virtual ~ProgramDeclaration();
            virtual void dump(FILE* f, int depth);
            virtual void inspect();
            virtual void compile(std::ostream &fp, bool isASM);
    };
    
    class DeclarationList : public Declaration
    {
        public:
            std::vector<Declaration*> list;
            
            DeclarationList(unsigned int lineNumber)
            {
                category = Declaration::DECL_LIST;
                this->lineNumber = lineNumber;
            }
            
            ~DeclarationList()
            {
                for(size_t i = 0; i < list.size(); i++)
                {
                      //fprintf ( stderr, "DELETING %d (line %d)\n\n", (unsigned int) i, list[i]->getLineNumber() );
                     delete list[i];
                }
            }
			
            void add(Declaration* expr) 
            {
                list.push_back(expr);
            }
            
            Declaration* getItem(int i)
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
                fprintf(f, "DeclarationList(");
                depth++;
                    for(i = 0; i < list.size(); i++)
                    {
                        if(i) fprintf(f, ",\n");
                        else fprintf(f, "\n");
                        dumpFormat(f, depth, "");
                        dumpNode<Declaration>(list[i], f, depth);
                    }
                    if(i) fprintf(f, "\n");
                depth--;
                if(i) dumpFormat(f, depth, ")");
                else fprintf(f, ")");
            }
            
            virtual void inspect()
            {
                for(size_t i = 0; i < list.size(); i++)
                {
                    list[i]->inspect();
                }
            }
            
            virtual void compile(std::ostream &fp, bool isASM)
            {
                for(size_t i = 0; i < list.size(); i++)
                {
                    list[i]->compile(fp, isASM);
                }
            }
    };
}

