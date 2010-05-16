#include <iostream>
#include <sstream>

#include "compile.h"
#include "symbol.h"
#include "program.h"
#include "identifier.h"

namespace pish
{
    Program* activeProgram = NULL;
    std::vector<Program*> programStack;
    int labelNumber = 0;
    int nestIndex = 0;
    
    void enterProgramNode(Program* program)
    {
        programStack.push_back(program);
        if(program->nestIndex == -1)
        {
            program->nestIndex = nestIndex++;
        }
        
        activeScope = program->localSymbols;
        typeScope = program->localTypes;
        pushScope();
        
        activeProgram = program;
    }
    
    void exitProgramNode()
    {
        popScope();
        programStack.pop_back();
        if(programStack.empty())
        {
            activeProgram = NULL;
        }
        else
        {
            activeProgram = programStack.back();
        }
    }
    
    std::string createLabel()
    {
        std::ostringstream label;
        
        label << "L" << labelNumber++;
        
        return label.str();
    }
}
