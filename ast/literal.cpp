#include <sstream>
#include <string.h>
#include "dump.h"
#include "literal.h"

namespace pish
{
    Literal::Literal(int value, unsigned int lineNumber)
    {
        type = Literal::LITERAL_INT;
        intValue = value;
        this->lineNumber = lineNumber;
    }
    
    Literal::Literal(double value, unsigned int lineNumber)
    {
        type = Literal::LITERAL_REAL;
        realValue = value;
        this->lineNumber = lineNumber;
    }
    
    Literal::Literal(const char* value, unsigned int lineNumber)
    {
        type = Literal::LITERAL_STRING;
        
        int bufferLength = strlen(value) - 2;
        stringValue = new char[bufferLength + 1];
        memcpy(stringValue, value + 1, bufferLength);
        stringValue[bufferLength] = '\0';
        
        this->lineNumber = lineNumber;
    }
    
    Literal::Literal(Literal* literal, unsigned int lineNumber)
    {
        type = literal->type;
        intValue = literal->intValue;
        realValue = literal->realValue;
        if(type == Literal::LITERAL_STRING)
        {
            stringValue = new char[strlen(literal->stringValue) + 1];
            memcpy(stringValue, literal->stringValue, strlen(literal->stringValue) + 1);
        }
        
        this->lineNumber = lineNumber;
    }
    
    Literal::~Literal()
    {
        //fprintf(stderr, "LITERAL\n");
        //fprintf(stderr, "\t%s\n", getRepresentation().c_str());
        if(type == Literal::LITERAL_STRING)
        {
            delete [] stringValue;
        }
        //fprintf(stderr, "DONE LITERAL\n");
    }

    // Should ALWAYS be checked before using a token's value.
    int Literal::getType()
    {
        return type;
    }

    int Literal::getIntValue()
    {
        if(type != Literal::LITERAL_INT)
        {
            return 0;
        }
        return intValue;
    }
    
    double Literal::getRealValue()
    {
        if(type != Literal::LITERAL_REAL)
        {
            return 0;
        }
        return realValue;
    }

    const char* Literal::getStringValue()
    {
        if(type != Literal::LITERAL_STRING)
        {
            return NULL;
        }
        return stringValue;
    }
    
    void Literal::dump(FILE* f, int depth)
    {
        fprintf(f, "Literal(");
        switch(type)
        {
            case Literal::LITERAL_INT:
                fprintf(f, "type = LITERAL_INT, intValue = %d)", intValue);
                break;
            case Literal::LITERAL_REAL:
                fprintf(f, "type = LITERAL_REAL, realValue = %lf)", realValue);
                break;
            case Literal::LITERAL_STRING:
                fprintf(f, "type = LITERAL_STRING, stringValue = %s)", stringValue);
                break;
        }
    }
    
    
    bool Literal::canNegate()
    {
        return type != Literal::LITERAL_STRING; 
    }
    
    void Literal::negate()
    {
        if(type == Literal::LITERAL_REAL)
        {
            realValue *= -1;
        }
        else if(type == Literal::LITERAL_INT)
        {
            intValue *= -1;
        }
    }
    
    std::string Literal::getRepresentation()
    {
        std::ostringstream result;
        switch(type)
        {
            case Literal::LITERAL_INT:
                result << "INTEGER (" << intValue << ")";
                return result.str();
                break;
            case Literal::LITERAL_REAL:
                result << "REAL (" << realValue << ")";
                return result.str();
            case Literal::LITERAL_STRING:
                result << "STRING (\"" << stringValue << "\")";
                return result.str();
            default:
                break;
        }
        return "(wtf)";
    }
}

