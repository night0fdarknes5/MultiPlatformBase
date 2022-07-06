BUILD_DIR := bin
OBJ_DIR := obj

ASSEMBLY := lua
EXTENSION := .a
COMPILER_FLAGS := -std=gnu99 -O2 -Wall -Wextra -DLUA_COMPAT_5_3
INCLUDE_FLAGS :=
LINKER_FLAGS :=
DEFINES :=

# Make does not offer a recursive wildcard function, so here's one:
rwildcard=$(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))

SRC_FILES := $(call rwildcard,externals/$(ASSEMBLY)/,*.c) # Get all .cpp files
#DIRECTORIES := \$(ASSEMBLY) $(subst $(DIR),,$(shell dir externals/$(ASSEMBLY) /S /AD /B | findstr /i src)) # Get all directories under src.
OBJ_FILES := $(SRC_FILES:%=$(OBJ_DIR)/%.o) # Get all compiled .c.o objects for engine

# SRC_FILES := $(shell find externals/$(ASSEMBLY) -name *.c)	# .c files
# DIRECTORIES := $(shell find externals/$(ASSEMBLY) -type d)		# directories with .h files
# OBJ_FILES := $(SRC_FILES:%=$(OBJ_DIR)/%.o)	

all: scaffold compile archive

.PHONY: scaffold
scaffold: # create build directory
	@echo Scaffolding folder structure...
	-@setlocal enableextensions enabledelayedexpansion && mkdir "$(OBJ_DIR)/externals/lua" 2>NUL || cd .
	@echo Done.

.PHONY: compile
compile: #compile .c files
	@echo Compiling...
-include $(OBJ_FILES:.o=.d)

.PHONY: archive
archive: scaffold $(OBJ_FILES) # archive
	@echo Archiving $(ASSEMBLY)...
	-@setlocal enableextensions enabledelayedexpansion && mkdir $(BUILD_DIR)  2>NUL || cd .
	@llvm-ar -rcu $(BUILD_DIR)/$(ASSEMBLY)$(EXTENSION) $(OBJ_FILES)
	@echo Complete

.PHONY: clean
clean: # clean build directory
	del $(BUILD_DIR)\$(ASSEMBLY)$(EXTENSION)
	rmdir /s /q $(OBJ_DIR)\externals\$(ASSEMBLY)

$(OBJ_DIR)/%.c.o: %.c # compile .c to .o object
	@echo   $<...
	@clang $< $(COMPILER_FLAGS) -c -o $@ $(DEFINES) $(INCLUDE_FLAGS)

-include $(OBJ_FILES:.o=.d)