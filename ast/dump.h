#pragma once

#include <stdio.h>
#include <stdarg.h>

namespace pish
{
    void dumpFormat(FILE* f, int depth, const char* format, ...);
    
    template <typename T>
    void dumpNode(T* node, FILE* f, int depth)
    {
        if(node != NULL)
        {
            fprintf (f, "%d: ", node->getLineNumber () );
            node->dump(f, depth);
        }
        else
        {
            fputs("null", f);
        }
    }
    
    template <typename T>
    void dumpTableData(T* node, FILE* f, int depth)
    {
        if(node != NULL)
        {
            node->dump(f, depth);
        }
        else
        {
            fputs("null", f);
        }
    }
}

