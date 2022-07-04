BUILD_DIR := bin
OBJ_DIR := obj

ASSEMBLY := engine
EXTENSION := .so
COMPILER_FLAGS := -g -Wall -Werror -fdeclspec -fPIC
INCLUDE_FLAGS := -Iengine/src
LINKER_FLAGS := -g -shared -lxcb -lX11 -lX11-xcb -lxkbcommon -L/usr/X11R6/lib
DEFINES := -DDEBUG -DDLLEXPORT

SRC_FILES := $(shell find $(ASSEMBLY) -name *.cpp)		# .cpp files
DIRECTORIES := $(shell find $(ASSEMBLY) -type d)		# directories with .h files
OBJ_FILES := $(SRC_FILES:%=$(OBJ_DIR)/%.o)		# compiled .o objects

all: scaffold compile link

.PHONY: scaffold
scaffold: # create build directory
	@echo Scaffolding folder structure...
	@mkdir -p bin
	@mkdir -p $(addprefix $(OBJ_DIR)/,$(DIRECTORIES))
	@echo Done.

.PHONY: link
link: scaffold $(OBJ_FILES) # link
	@echo Linking $(ASSEMBLY)...
	@clang++ $(OBJ_FILES) -o $(BUILD_DIR)/lib$(ASSEMBLY)$(EXTENSION) $(LINKER_FLAGS)

.PHONY: compile
compile: #compile .cpp files
	@echo Compiling...
-include $(OBJ_FILES:.o=.d)

.PHONY: clean
clean: # clean build directory
	rm -rf $(BUILD_DIR)/lib$(ASSEMBLY)$(EXTENSION)
	rm -rf $(OBJ_DIR)/$(ASSEMBLY)

$(OBJ_DIR)/%.cpp.o: %.cpp # compile .cpp to .o object
	@echo   $<...
	@clang++ $< $(COMPILER_FLAGS) -c -o $@ $(DEFINES) $(INCLUDE_FLAGS)

-include $(OBJ_FILES:.o=.d)