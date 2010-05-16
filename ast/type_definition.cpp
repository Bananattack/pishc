#include <string>
#include <sstream>
#include "dump.h"

#include "type_definition.h"
#include "identifier.h"
#include "declaration.h"
#include "expression.h"
#include "literal.h"
#include "symbol.h"
#include "variable.h"
#include "operator.h"
#include "common.h"

namespace pish
{
    TypeDefinition::TypeDefinition(Identifier* identifier, unsigned int lineNumber)
    {
        category = TYPE_IDENTIFIER;
		resolvedType = category;
        size = 0;
        this->identifier = identifier;
        this->lineNumber = lineNumber;
    }
    
    TypeDefinition::TypeDefinition(TypeDefinition* type, Expression* lower, Expression* upper,
        unsigned int lineNumber)
    {
        category = TYPE_ARRAY;
		resolvedType = category;
        size = 0;
        array.type = type;
        array.lower = lower;
        array.upper = upper;
        array.lowerIndex = 0;
        array.upperIndex = -1;
        this->lineNumber = lineNumber;
    }
    
    TypeDefinition::TypeDefinition(DeclarationList* members, unsigned int lineNumber)
    {
        category = TYPE_RECORD;
		resolvedType = category;
        size = 0;
        record.members = members;
        record.symbols = NULL;
        this->lineNumber = lineNumber;
    }
    
    TypeDefinition::~TypeDefinition()
    {
        switch(category)
        {
            case TYPE_IDENTIFIER:
                delete identifier;
                break;
            case TYPE_ARRAY:
                delete array.type;
                delete array.lower;
                delete array.upper;
                break;
            case TYPE_RECORD:
                delete record.members;
                delete record.symbols;
                break;
        }
    }	
	
    void TypeDefinition::dump(FILE* f, int depth)
    {
        fprintf(f, "TypeDefinition(\n");
        depth++;
        switch(category)
        {
            case TYPE_IDENTIFIER:
                dumpFormat(f, depth, "category = TYPE_IDENTIFIER, identifier = ");
                dumpNode<Identifier>(identifier, f, depth);
                break;
            case TYPE_ARRAY:
                dumpFormat(f, depth, "category = TYPE_ARRAY, array.type = ");
                dumpNode<TypeDefinition>(array.type, f, depth);
                fprintf(f, ",\n");
                dumpFormat(f, depth, "array.lower = ");
                dumpNode<Expression>(array.lower, f, depth);
                fprintf(f, ",\n");
                dumpFormat(f, depth, "array.upper = ");
                dumpNode<Expression>(array.upper, f, depth);
                break;
            case TYPE_RECORD:
                dumpFormat(f, depth, "category = TYPE_RECORD, record.members = ");
                dumpNode<DeclarationList>(record.members, f, depth);
                break;
        }
        depth--;
        fprintf(f, ",\n");
        dumpFormat(f, depth, ")");
    }
    
    int parseArrayDimensionConstant(Expression* expression, int lineNumber)
    {
        // Constant refers to a literal.
        if(expression->category == Expression::EXPR_LITERAL)
        {
            if(expression->literal->getType() == Literal::LITERAL_INT)
            {
                return expression->literal->getIntValue();
            }
            error("error, expected an integer.", lineNumber);
        }
        // Constant refers to another constant, look it up.
        else if(expression->category == Expression::EXPR_VARIABLE)
        {
            Symbol* symbol = activeScope->get(expression->variable->identifier->name, lineNumber);
            if(!symbol)
            {
                return 0;
            }
            else
            {
                if(symbol->category != Symbol::SYM_CONSTANT_BINDING)
                {
                    error("error, expected a constant expression.", lineNumber);
                    return 0;
                }
                if(symbol->constantBinding->getType() == Literal::LITERAL_INT)
                {
                    return symbol->constantBinding->getIntValue();
                }
                error("error, expected an integer.", lineNumber);
            }
        }
        // Constant is negated.
        else if(expression->category == Expression::EXPR_OPERATOR)
        {
            // Look at operand.
            Expression* operand = expression->op->operand;
            
            // Constant refers to a literal.
            if(operand->category == Expression::EXPR_LITERAL)
            {
                if(operand->literal->getType() == Literal::LITERAL_INT)
                {
                    return -operand->literal->getIntValue();
                }
                error("error, expected an integer.", lineNumber);
            }
            // Constant refers to another constant, look it up.
            else if(operand->category == Expression::EXPR_VARIABLE)
            {
                Symbol* symbol = activeScope->get(operand->variable->identifier->name, lineNumber);
                if(!symbol)
                {
                    return 0;
                }
                else
                {
                    if(symbol->category != Symbol::SYM_CONSTANT_BINDING)
                    {
                        error("error, expected a constant expression.", lineNumber);
                        return 0;
                    }
                    if(symbol->constantBinding->getType() == Literal::LITERAL_INT)
                    {
                        return -symbol->constantBinding->getIntValue();
                    }
                    error("error, expected an integer.", lineNumber);
                }
            }
        }
        return 0;
    }
	
    std::string TypeDefinition::getSimpleName()
    {
		switch(category)
		{
			case TYPE_IDENTIFIER:
			    return std::string(identifier->name);
			case TYPE_ARRAY:
            {
                std::ostringstream name;
                name << "array [" << array.lowerIndex << " .. " << array.upperIndex << "] of " << array.type->getSimpleName();
			    return name.str();
            }
			case TYPE_RECORD:
            {
                std::ostringstream name;
                bool separator = false;
                name << "RECORD ";
                for(SymbolTable::Iterator it = record.symbols->begin(); it != record.symbols->end(); ++it)
                {
                    name << (separator ? ", " : "") << it->first << " : " << it->second->variableBinding->type->getSimpleName();
                    separator = true;
                }
                name << " END";
                return name.str();
            }
			    
			default:
			    return "<unknown>";
		}
    }
    
	bool TypeDefinition::isEqualTo(TypeDefinition* rhs)
	{
	    //fprintf(stderr, "%s (%d) -- VS -- %s (%d)\n", getSimpleName().c_str(), resolvedType, rhs->getSimpleName().c_str(), rhs->resolvedType);
		// Trivial case - different resolved types.
		if(resolvedType != rhs->resolvedType)
		{
		    //fprintf(stderr, "trivial fail\n");
			return false;
		}
		// For equal resolved types
        switch(resolvedType)
        {
			// Type alias. Names must match.
			case TYPE_IDENTIFIER:
			    //fprintf(stderr, "identifier check\n");
				return !strcmp(identifier->name, rhs->identifier->name);
			// Array. Size of right-hand-side array must fit in this, and contained type must match.
			case TYPE_ARRAY:
                //fprintf(stderr, "array check (%d, %d, %s) vs. (%d, %d, %s)\n", array.lowerIndex, array.upperIndex, array.type->getSimpleName().c_str(),
                        //rhs->array.lowerIndex, rhs->array.upperIndex, rhs->array.type->getSimpleName().c_str());
				return array.lowerIndex == rhs->array.lowerIndex
                    && array.upperIndex == rhs->array.upperIndex
					&& array.type->isEqualTo(rhs->array.type);
			// Record. Number of fields and types of fields must match.
			case TYPE_RECORD:
			{
				if(!record.symbols || !rhs->record.symbols || record.symbols->size() != rhs->record.symbols->size())
					return false;
					
				// For each field in this, find a symbol with a matching name in the right hand side. Then compare the symbol's types.
				// This is bound to be made of godawful terrible inefficency.
				for(SymbolTable::Iterator i = record.symbols->begin(); i != record.symbols->end(); ++i)
				{
					bool found = false;
					for(SymbolTable::Iterator j = rhs->record.symbols->begin(); i != rhs->record.symbols->end(); ++i)
					{
						// Name matches.
						if(i->first == j->first)
						{
							// I assume only variable declarations can occur in records,
							// because anything else should never happen by syntax.
							
							VariableDeclaration* a = i->second->variableBinding;
							VariableDeclaration* b = j->second->variableBinding;
							// Check types.
							if(!a->type->isEqualTo(b->type))
							{
								return false;
							}
							found = true;
						}
					}
					if(!found)
					{
						return false;
					}
				}
				return true;
			}
			default:
			    //fprintf(stderr, "primitive~~!\n");
				// Primitive type.
				return true;
		}
	}
    
	bool TypeDefinition::isCompatibleWith(TypeDefinition* rhs)
	{
		// Trivial case - different resolved types.
		if(resolvedType != rhs->resolvedType)
		{
			return false;
		}
		// For equal resolved types
        switch(resolvedType)
        {
			// Type alias. Names must match.
			case TYPE_IDENTIFIER:
				return !strcmp(identifier->name, rhs->identifier->name);
			// Array. Size of right-hand-side array must fit in this, and contained type must match.
			case TYPE_ARRAY:
				return array.elementCount == rhs->array.elementCount
					&& array.type->isCompatibleWith(rhs->array.type);
			// Record. Number of fields and types of fields must match.
			case TYPE_RECORD:
			{
				if(!record.symbols || !rhs->record.symbols || record.symbols->size() != rhs->record.symbols->size())
					return false;
					
				// For each field in this, find a symbol with a matching name in the right hand side. Then compare the symbol's types.
				// This is bound to be made of godawful terrible inefficency.
				for(SymbolTable::Iterator i = record.symbols->begin(); i != record.symbols->end(); ++i)
				{
					bool found = false;
					for(SymbolTable::Iterator j = rhs->record.symbols->begin(); i != rhs->record.symbols->end(); ++i)
					{
						// Name matches.
						if(i->first == j->first)
						{
							// I assume only variable declarations can occur in records,
							// because anything else should never happen by syntax.
							
							VariableDeclaration* a = i->second->variableBinding;
							VariableDeclaration* b = j->second->variableBinding;
							// Check types.
							if(!a->type->isCompatibleWith(b->type))
							{
								return false;
							}
							found = true;
						}
					}
					if(!found)
					{
						return false;
					}
				}
				return true;
			}
			default:
				// Primitive type.
				return true;
		}
	}
    
    // Keep going until we retreive the lowest possible type definition that has information.
    TypeDefinition* TypeDefinition::resolveBaseType(unsigned int lineNumber)
	{
        TypeDefinition* td = this;
        
        // Type identifier, might be type or alias for type.
		while(td->category == TYPE_IDENTIFIER)
		{            
            // Lookup name in symbol table.
            Symbol* symbol = typeScope->get(td->identifier->name, lineNumber);
            if(!symbol)
            {
                // We failed, and could only resolve to an identifier, not array/record.
                return td;
            }
            switch(symbol->category)
            {
                // We could only resolve to a primitive, not array/record, so there is no base type definition.
                case Symbol::SYM_INTEGER:
                case Symbol::SYM_CHAR:
                case Symbol::SYM_REAL:
                    return td;
                case Symbol::SYM_TYPE_BINDING:
                    // Resolve alias.
                    td = symbol->typeBinding;
                    break;
            }
		}
        return td;
	}
    
    TypeDefinition::TypeCategory TypeDefinition::resolveAliasCategory(unsigned int lineNumber)
	{
        // Type identifier, might be type or alias for type.
		if(category == TYPE_IDENTIFIER)
		{            
            // Lookup name in symbol table.
            Symbol* symbol = typeScope->get(identifier->name, lineNumber);
            if(!symbol)
            {
                // We failed, and could only resolve to an identifier, not array/record/primitive.
                return TYPE_IDENTIFIER;
            }
            switch(symbol->category)
            {
                case Symbol::SYM_INTEGER:
                    return TYPE_INTEGER;
                case Symbol::SYM_CHAR:
                    return TYPE_CHAR;
                case Symbol::SYM_REAL:
                    return TYPE_REAL;
                case Symbol::SYM_TYPE_BINDING:
                // Resolve alias.
                return symbol->typeBinding->resolveAliasCategory(lineNumber);
            }
		}
        // Otherwise, it is not a primitive.
		return category;
	}
    
    bool TypeDefinition::isPrimitive(unsigned int lineNumber)
	{
        TypeCategory cat = resolveAliasCategory(lineNumber);
        return cat == TYPE_INTEGER || cat == TYPE_REAL || cat == TYPE_CHAR;
	}
    
    bool TypeDefinition::isAliasForCategory(TypeCategory c, unsigned int lineNumber)
	{
        return resolveAliasCategory(lineNumber) == c;
	}

    bool TypeDefinition::isArray(unsigned int lineNumber)
    {
        return isAliasForCategory(TYPE_ARRAY, lineNumber);
    }

    bool TypeDefinition::isRecord(unsigned int lineNumber)
    {
        return isAliasForCategory(TYPE_RECORD, lineNumber);
    }

	// Used for checking if a type is an alias for a primitive type.
	// Useful for return-value validation.
	void TypeDefinition::checkAliasForPrimitive(unsigned int lineNumber)
	{
		if(!isPrimitive(lineNumber))
        {
            std::ostringstream message;
            message << "error, expecting real, integer or char but found " << getSimpleName();
            error(message.str().c_str(), lineNumber);
        }
	}

    TypeDefinition* TypeDefinition::getArraySubtype()
    {
        // Type identifier, might be array or alias for array.
		if(category == TYPE_IDENTIFIER)
		{            
            // Lookup name in symbol table.
            Symbol* symbol = typeScope->get(identifier->name, lineNumber);
            if(!symbol)
            {
                return false;
            }
            else if(symbol->category == Symbol::SYM_TYPE_BINDING)
            {
                // Resolve alias.
                return symbol->typeBinding->getArraySubtype();
            }
		}
        // Array type found
        else if(category == TYPE_ARRAY)
        {
            return array.type;
        }
        // Otherwise, it is not an array, whoops.
		return NULL;
    }
    
    TypeDefinition* TypeDefinition::getRecordFieldType(const std::string& key, unsigned int lineNumber, const char* recordName)
    {
        // Type identifier, might be record or alias for record.
		if(category == TYPE_IDENTIFIER)
		{            
            // Lookup name in symbol table.
            Symbol* symbol = typeScope->get(identifier->name, lineNumber);
            if(!symbol)
            {
                return false;
            }
            else if(symbol->category == Symbol::SYM_TYPE_BINDING)
            {
                // Resolve alias.
                return symbol->typeBinding->getRecordFieldType(key, lineNumber, identifier->name);
            }
		}
        // Record type found
        else if(category == TYPE_RECORD)
        {
            // Look up field locally (record lookups do not inherit scope).
            Symbol* symbol = record.symbols->tryGet(key, false);
            if(!symbol)
            {
                std::ostringstream message;
                
                message << "error, record ";
                if(recordName)
                {
                    message << "`" << recordName << "`";
                }
                else
                {
                    message << getSimpleName();
                }
                message << " has no field named `" << key << "`.";
                error(message.str().c_str(), lineNumber);
                return NULL;
            }
            // Found the field we wanted type info about.
            // Assumption: Records may only store variable declarations.
            else
            {
                return symbol->variableBinding->type;
            }
        }
        // Otherwise, it is not an record, whoops.
		return NULL;
    }
            
    void TypeDefinition::inspect()
    {
        resolvedType = TYPE_ERROR;
        
        // Validate type information and calculate data size.
        switch(category)
        {
            case TYPE_IDENTIFIER:
            {
                Symbol* symbol = typeScope->get(identifier->name, lineNumber);
                if(!symbol)
                {
                    return;
                }
                else
                {
                    switch(symbol->category)
                    {
                        case Symbol::SYM_INTEGER:
							resolvedType = TYPE_INTEGER;
                            size = 4;
                            break;
                        case Symbol::SYM_CHAR:
							resolvedType = TYPE_CHAR;
                            size = 4;
                            break;
                        case Symbol::SYM_REAL:
							resolvedType = TYPE_REAL;
                            size = 4;
                            break;
                        case Symbol::SYM_TYPE_BINDING:
							// Aliases should be treated as distinct types from their original, so this is as far as we simplify.
							resolvedType = category;
							// Use the resolved type's size.
                            size = symbol->typeBinding->size;
                            break;
                    }
                }
                //fprintf(stderr, "DEBUG: Identifer for type '%s' of %d bytes\n", identifier->name, size);
                break;
            }
            case TYPE_ARRAY:
            {
				// An array cannot be simplified further (but its contained type might be).
				resolvedType = category;
				
				//fprintf(stderr, "Lower\n");
                array.lowerIndex = parseArrayDimensionConstant(array.lower, array.lower->getLineNumber());
                //fprintf(stderr, "Upper\n");
                array.upperIndex = parseArrayDimensionConstant(array.upper, array.upper->getLineNumber());
                //fprintf(stderr, "Checking subtype\n");
                array.type->inspect();
                if(array.type->size <= 0)
                {
                    error("error, invalid type used with array.", lineNumber);
                    return;
                }
                
                array.elementCount = (array.upperIndex - array.lowerIndex + 1);
                size = array.elementCount * array.type->size;
                //fprintf(stderr, "DEBUG: Array on line %d [%d .. %d] (%d elements, %d bytes)\n", lineNumber, array.lowerIndex, array.upperIndex, array.elementCount, size);
                if(size <= 0)
                {
                    size = 4;
                    error("error, array must have a lower index <= its upper index.", lineNumber);
                }
                break;
            }
            case TYPE_RECORD:
            {
				// An record cannot be simplified further (but its fields might be).
				resolvedType = category;
				
                // Start compiling all member definitions.
                // Do not inherit parent scope here.
                enterScope();
                record.symbols = activeScope;
                // Compile member definitions.
                record.members->inspect();
                // End the record scope.
                exitScope();
                
                // The exact size equals the current offset in the symbol table used by the record.
                size = record.symbols->offset;
                
                //fprintf(stderr, "DEBUG: Record on line %d (%d fields, %d bytes)\n", lineNumber, (unsigned int) record.symbols->size(), size);
                
                break;
            }
        }
    }
}

