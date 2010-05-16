#pragma once

#include <map>
#include <vector>

#include "expression.h"

namespace pish
{
    class TypeDefinition;
    class Literal;
    class Program;
    class VariableDeclaration;
	struct Symbol
	{
		enum SymbolCategory
		{
			// Constants.
			// Primitive constants
			SYM_INTEGER,
			SYM_CHAR,
			SYM_REAL,
			// Type binding.
			SYM_TYPE_BINDING,
			// Const binding.
			SYM_CONSTANT_BINDING,
			
			// Variable and program table stuff.
			// Built-in procedures.
			SYM_WRITEINT,
			SYM_WRITEREAL,
			SYM_WRITECHAR,
			SYM_WRITESTR,
			SYM_TOINTEGER,
			SYM_TOREAL,
			SYM_RANDOM,
			SYM_READINT,
			SYM_READREAL,
			SYM_READCHAR,
			// Program binding.
			SYM_PROGRAM_BINDING,
			// Variable binding.
			SYM_VARIABLE_BINDING,
            // Main program parameters that seem to be pointless but might take up namespace.
            SYM_MAIN_PROGRAM_PARAMETER,
            // Temporary used by an expression.
            SYM_TEMPORARY,
		};
		
		SymbolCategory category;
		
		union
		{    	
			// Type definition.
			TypeDefinition* typeBinding;
			// Constant - needs to be bound to a literal.
			Literal* constantBinding;
			// Program binding.
			Program* programBinding;
			// Variable declaration.
			VariableDeclaration* variableBinding;
			// Expression type of the temporary variable.
			Expression* temporaryExpression;
		};
		
		unsigned int lineNumber;
        int depth;
        int offset;
        // Whether or not this symbol refers to the name of the scope.
        // Used by function names, because they need both provide return value assignment and recursive calling.
        bool isScopeSelf;
        // Whether or not the variable can be directly read from the stack, or if you need to dereference the object on the stack to get the value.
        bool isReference;
		
		// For builtins types.
		Symbol(SymbolCategory category);
		Symbol(TypeDefinition* typeBinding);
		Symbol(Literal* constantBinding);
		Symbol(Program* programBinding);
		Symbol(VariableDeclaration* variableBinding);
		Symbol(Expression* temporaryExpression);
		
		~Symbol();
		
		bool isBuiltin();
		
		void dump(FILE* f, int depth);
        
        private:
            void init();
	};
		
	class SymbolTable
	{
		public:
			typedef std::map<std::string, Symbol*> Map;
			typedef Map::iterator Iterator;
			
			// The outer scope containing this scope. NULL if it does not apply.
			SymbolTable* parent;
			// The symbol table
			Map map;
            // Offset relative to scope.
            int offset;
            // Depth of scope relative to other scopes.
            int depth;
            
            // Used for allocating temporaries.
            int temporaryIndex;
			
			std::string contentText;
		
			SymbolTable(SymbolTable* parent);
			~SymbolTable();
			
			Iterator begin()
			{
				return map.begin();
			}
			
			Iterator end()
			{
				return map.end();
			}
			
    
            size_t size()
            {
                return map.size();
            }
			
			// Insert symbol into the local scope.
			void put(std::string key, Symbol* value, int currentLine);
			// Perform search with inheritance setting to see if this binding exists at this or an earlier scope.
			Symbol* get(std::string key, int currentLine);
			// Perform search without inheritance setting to see if this binding is local. (used for record lookups)
			Symbol* getLocal(std::string key, int currentLine);
			// Attempts to get a variable (using inheritance setting provided). Returns NULL on failure.
            Symbol* tryGet(std::string key, bool useInheritance);
            // Add an expression temporary, and return its name.
            int createTemporary(Expression* expr);
            
            void dump(FILE* f, int d);
	};
	
	// Scope used for constants, variables and program declarations. The top of the scopeStack.
	extern SymbolTable* activeScope;
    // A stack of all depths of active scopes.
    // Necessary for checking when a variable is declared outside of the current scope (but contained by an outer scope the inner scope can reference).
    extern std::vector<SymbolTable*> scopeStack;
    
    // Scope used for all type declarations. 
	extern SymbolTable* typeScope;
    // Like scopeStack, but for types.
    extern std::vector<SymbolTable*> typeStack;
    
    void enterScope();
    void exitScope();
    void pushScope();
    void popScope();
}

