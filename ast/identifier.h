#pragma once

#include <vector>
#include <string.h>
#include <stdlib.h>

#include "abstract_node.h"
#include "dump.h"

namespace pish
{
    class Identifier : public AbstractNode
    {
        public:
            char* name;
            Identifier(const char* name, unsigned int lineNumber)
            {
                this->name = strdup(name);
                this->lineNumber = lineNumber;
            }
            
            virtual ~Identifier()
            {
                free(name);
            }
            
            virtual void dump(FILE* f, int depth)
            {
                fprintf(f, "Identifier(name = %s)", name);
            }
    };
    
    class IdentifierList : public AbstractNode
    {
        public:
            std::vector<Identifier*> list;
            IdentifierList(unsigned int lineNumber)
            {
                this->lineNumber = lineNumber;
            }
        
            virtual ~IdentifierList()
            {
                for(size_t i = 0; i < list.size(); i++)
                {
                    //fprintf ( stderr, "IDENTIFIER %d %s (line %d)\n\n", (unsigned int) i, list[i]->name, list[i]->getLineNumber() );
                    delete list[i];
                }
            }
            
            void add(Identifier* ident)
            {
                list.push_back(ident);
            }
            
            Identifier* getItem(int i)
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
                fprintf(f, "IdentifierList(");
                depth++;
                    for(i = 0; i < list.size(); i++)
                    {
                        if(i) fprintf(f, ",\n");
                        else fprintf(f, "\n");
                        dumpFormat(f, depth, "");
                        dumpNode<Identifier>(list[i], f, depth);
                    }
                    if(i) fprintf(f, "\n");
                depth--;
                if(i) dumpFormat(f, depth, ")");
                else fprintf(f, ")");
            }
    };
}

