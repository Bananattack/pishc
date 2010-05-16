#pragma once

#include "abstract_node.h"
#include <string>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

namespace pish
{
    // An immuatable class representing a literal value.
    class Literal : public AbstractNode
    {
        public:
            // An enumeration that contains the values which can be used for a token.
            enum LiteralType
            {
                LITERAL_INT,    // For integer and character literals.
                LITERAL_REAL,   // For real-valued tokens.
                LITERAL_STRING, // For string literals.
            };
        private:
            union
            {
                int intValue;
                double realValue;
                char* stringValue;
            };
            
            LiteralType type;
        public:
            Literal(int value,unsigned int lineNumber);
            Literal(double value, unsigned int lineNumber);
            Literal(const char* value, unsigned int lineNumber);
            Literal(Literal* literal, unsigned int lineNumber);
            virtual ~Literal();
        
            int getType();
            int getIntValue();
            double getRealValue();
            const char* getStringValue();
            
            bool canNegate();
            void negate();
            
            std::string getRepresentation();
            
            virtual void dump(FILE* f, int depth);
    };
}

