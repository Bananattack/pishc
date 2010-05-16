#include "dump.h"

namespace pish
{
    void dumpFormat(FILE* f, int depth, const char* format, ...)
    {
        va_list args;
        va_start (args, format);
        for(int i = 0; i < depth; i++)
        {
            fprintf(f, "    ");
        }
        vfprintf(f, format, args);
        va_end (args);
    }
}

