#include "ast.h"

namespace pish
{
	unsigned int lineNumber;
    AbstractNode* programNode = NULL;
    bool successfulParse = false;
	std::string parseFilename = "";
	unsigned int errorCount = 0;
	
	void error(const char* message, int currentLine)
	{
		fprintf(stderr, "  %s:%d: %s\n", getActiveFile(), currentLine, message);
		errorCount++;
		if(errorCount == 15)
		{
			fprintf(stderr, "  %s: too many errors. exit.\n", getActiveFile());
			exit(-1);
		}
	}
	
	const char* getActiveFile()
	{
		return parseFilename.c_str();
	}
    
    void toLowercase(char* s)
    {
        while(*s)
        {
            *s = tolower(*s);
            s++;
        }
    }
    
    size_t countDeclarations(const std::vector<VariableDeclaration*>& signature)
    {
        size_t count = 0;
        for(size_t i = 0; i < signature.size(); i++)
        {
            count += signature[i]->list->getSize();
        }
        return count;
    }
    
    void flattenVariableDeclarationList(DeclarationList* list, std::vector<VariableDeclaration*>& result)
    {
        for(size_t i = 0; i < list->getSize(); i++)
        {
            Declaration* decl = list->getItem(i);
            if(decl->category == Declaration::DECL_LIST)
            {
                flattenVariableDeclarationList(CONVERT(DeclarationList*, decl), result); 
            }
            else if(decl->category == Declaration::DECL_VARIABLE)
            {
                result.push_back(CONVERT(VariableDeclaration*, decl));
            }						
        }
    }
}
