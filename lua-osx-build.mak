BUILD_DIR := bin
OBJ_DIR := obj

ASSEMBLY := lua
EXTENSION := .a
COMPILER_FLAGS := -std=gnu99 -O2 -Wall -Wextra -DLUA_COMPAT_5_3
INCLUDE_FLAGS :=
LINKER_FLAGS :=
DEFINES :=

SRC_FILES := $(shell find externals/$(ASSEMBLY) -name *.c)	# .c files
DIRECTORIES := $(shell find externals/$(ASSEMBLY) -type d)		# directories with .h files
OBJ_FILES := $(SRC_FILES:%=$(OBJ_DIR)/%.o)	

all: scaffold compile archive

.PHONY: scaffold
scaffold: # create build directory
	@echo Scaffolding folder structure...
	@mkdir -p $(addprefix $(OBJ_DIR)/,$(DIRECTORIES))
	@echo Done.

.PHONY: compile
compile: #compile .c files
	@echo Compiling...
-include $(OBJ_FILES:.o=.d)

.PHONY: archive
archive: scaffold $(OBJ_FILES) # archive
	@echo Archiving $(ASSEMBLY)...
	@mkdir -p $(BUILD_DIR)
	@ar -rcu $(BUILD_DIR)/$(ASSEMBLY)$(EXTENSION) $(OBJ_FILES)
	@echo Complete

.PHONY: clean
clean: # clean build directory
	rm -Rf $(BUILD_DIR)/lib$(ASSEMBLY)$(EXTENSION)
	rm -Rf $(OBJ_DIR)/$(ASSEMBLY)

$(OBJ_DIR)/%.c.o: %.c # compile .c to .o object
	@echo   $<...
	@clang $< $(COMPILER_FLAGS) -c -o $@ $(DEFINES) $(INCLUDE_FLAGS)

-include $(OBJ_FILES:.o=.d)