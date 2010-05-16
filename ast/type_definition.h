#pragma once

#include <string>
#include "dump.h"
#include "abstract_node.h"

namespace pish
{
    class DeclarationList;
    class Identifier;
    class Expression;
    class SymbolTable;
    
    class TypeDefinition : public AbstractNode, public Inspectable
    {
        public:
            // The category of type being stored.
            enum TypeCategory
            {
                TYPE_IDENTIFIER,    // Primitive type or type alias.
                TYPE_ARRAY,         // Array type.
                TYPE_RECORD,        // Record type.
				TYPE_INTEGER,		// Integer or alias for integer.
				TYPE_CHAR,			// Character or alias for char.
				TYPE_REAL,			// Real or alias for real.
				TYPE_ERROR,         // FAILURE.
            };
        
			// Type category resolved at the time AST is first built during syntax validation
			// Determines which union to use. SHOULD NOT CHANGE AFTER CREATION.
            TypeCategory category;
			// A more specific type-category, resolved during semantic checking.
			// This one may change (in order to make later type-checking possibly require less indirection)
			TypeCategory resolvedType;
			
            union
            {
                // Name of an array.
                Identifier* identifier;
                
                // Array.
                struct
                {
                    // Type held by this array.
                    TypeDefinition* type;
                    // Boundaries. Must be constant integer expressions.
                    Expression* lower;
                    Expression* upper;
                    
                    // Boundaries resolved to their actual integers in code.
                    int lowerIndex;
                    int upperIndex;
                    int elementCount;
                } array;
                
                // Record.
                struct
                {
                    // List of all member declarations. (must be variables)
                    DeclarationList* members;
                    
                    // Symbol table built and used for look-up during semantic analysis.
                    SymbolTable* symbols;
                } record;
            };
            
            // The full size of this type.
            int size;
            
            TypeDefinition(Identifier* identifier, unsigned int lineNumber);
            TypeDefinition(TypeDefinition* type, Expression* lower, Expression* upper, unsigned int lineNumber);
            TypeDefinition(DeclarationList* members, unsigned int lineNumber);
            virtual ~TypeDefinition();
			
            std::string getSimpleName();
            bool isEqualTo(TypeDefinition* rhs);
			bool isCompatibleWith(TypeDefinition* rhs);
            TypeDefinition* resolveBaseType(unsigned int lineNumber);
            TypeCategory resolveAliasCategory(unsigned int lineNumber);
            bool isPrimitive(unsigned int lineNumber);
            bool isAliasForCategory(TypeCategory c, unsigned int lineNumber);
            bool isArray(unsigned int lineNumber);
            bool isRecord(unsigned int lineNumber);
			void checkAliasForPrimitive(unsigned int lineNumber);
            TypeDefinition* getArraySubtype();
            TypeDefinition* getRecordFieldType(const std::string& key, unsigned int lineNumber, const char* recordName = NULL);
			
            virtual void dump(FILE* f, int depth);
            virtual void inspect();
    };
}

