# CIS*4650
# Compilers
# Authors: Andrew Crowell, Andrew Judd

# Specify each of the different compilers to use
CC = g++
LEX = lex 
YACC = yacc 

# Specify the flags which will be added / used
CC_FLAGS = -g -Wall -Wno-switch
LD_FLAGS = -g -Wall -Wno-switch
CXX_FLAGS = -g -Wall -Wno-switch
LEX_FLAGS =  
YACC_FLAGS = -d --debug --verbose

# Information specific to the lex file
LEX_FILES = grammar/pishc.l 
LEX_OUTPUT = grammar/lex.yy.cpp

# Information specific to the yacc file
YACC_FILES = grammar/pishc.y
YACC_OUTPUT = grammar/y.tab.cpp

# Information common to both lex and yacc.
COMMON_HEADER = grammar/common.h
# Information specific to AST source code.
AST_FOLDER = ast
AST_HEADERS = $(AST_FOLDER)/*.h
AST_OBJS = \
	$(AST_FOLDER)/dump.o \
	$(AST_FOLDER)/declaration.o \
	$(AST_FOLDER)/expression.o \
	$(AST_FOLDER)/literal.o \
	$(AST_FOLDER)/operator.o \
	$(AST_FOLDER)/program.o \
	$(AST_FOLDER)/statement.o \
	$(AST_FOLDER)/type_definition.o \
	$(AST_FOLDER)/variable.o \
	$(AST_FOLDER)/symbol.o \
	$(AST_FOLDER)/common.o \
        $(AST_FOLDER)/compile.o

# Extra files which get created during the process
EXTRA_FILES = grammar/y.tab.hpp grammar/y.output

# What the final application should be called
PARSER_OUTPUT = pishc

# Makes sure all of the options are created
all: $(PARSER_OUTPUT)

%.o:%.cpp
	$(CC) $(CXX_FLAGS) $< -c -o $@

$(LEX_OUTPUT): $(LEX_FILES) $(AST_HEADERS) $(COMMON_HEADER) $(AST_OBJS)
	$(LEX) -o $(LEX_OUTPUT) $(LEX_FLAGS) $(LEX_FILES)

$(YACC_OUTPUT): $(YACC_FILES) $(AST_HEADERS) $(COMMON_HEADER) $(AST_OBJS)
	$(YACC) $(YACC_FLAGS) -o $(YACC_OUTPUT) $(YACC_FILES)

$(PARSER_OUTPUT): $(LEX_OUTPUT) $(YACC_OUTPUT) $(AST_OBJS)
	$(CC) $(LEX_OUTPUT) $(YACC_OUTPUT) $(AST_OBJS) $(CC_FLAGS) -lfl -o $(PARSER_OUTPUT) -Wno-sign-compare

# Clean up the directory
clean:
	rm -rf $(LEX_OUTPUT) $(YACC_OUTPUT) $(PARSER_OUTPUT) $(AST_OBJS) $(EXTRA_FILES)
