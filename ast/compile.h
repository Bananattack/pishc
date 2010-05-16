#pragma once

#include <vector>
#include <string>

namespace pish
{
    class Program;
    // An interface obeyed by nodes that can be compiled into intermediate code (second pass).
    class Compilable
    {
        public:
            // Abstract. Compile this node into intermediate code and dump to file.
            virtual void compile(std::ostream &fp, bool isASM) = 0;
    };

    // For telling what stack frame variables to use.
    extern Program* activeProgram;
    extern std::vector<Program*> programStack;

    void enterProgramNode(Program* program);
    void exitProgramNode();

    extern int labelNumber;
    std::string createLabel();
}

