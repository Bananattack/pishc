#pragma once

#include <stdio.h>

namespace pish
{
    class AbstractNode
    {
        protected:
            unsigned int lineNumber;

        public:
            // Necessary to let subclasses have their destructors called.
            virtual ~AbstractNode()
            { 
            }
            

            // Get the line of code where this node was defined.
            unsigned int getLineNumber()
            {
                return lineNumber;
            }
            
            // Abstract. Dump a representation of this node to a file.
            virtual void dump(FILE* f, int depth) = 0;
    };
    
    // An interface obeyed by nodes that can be inspected semantically (first pass).
    class Inspectable 
    {
        public:
            virtual void inspect() = 0;
    };
    

}

