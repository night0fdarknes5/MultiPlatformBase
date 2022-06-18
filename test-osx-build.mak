BUILD_DIR := bin
OBJ_DIR := obj

ASSEMBLY := testapp
EXTENSION := 
COMPILER_FLAGS := -g -fdeclspec -fPIC 
INCLUDE_FLAGS := -Iengine/src -Itestapp/src
LINKER_FLAGS := -L./$(BUILD_DIR)/ -lengine -Wl,-rpath,. -rpath @executable_path
DEFINES := -DDEBUG -DDLLIMPORT

SRC_FILES := $(shell find $(ASSEMBLY) -name *.cpp)		# .cpp files
DIRECTORIES := $(shell find $(ASSEMBLY) -type d)		# directories with .h files
OBJ_FILES := $(SRC_FILES:%=$(OBJ_DIR)/%.o)				# compiled .o objects

all: scaffold compile link

.PHONY: scaffold
scaffold: # create build directory
	@echo Scaffolding folder structure...
	@mkdir -p $(addprefix $(OBJ_DIR)/,$(DIRECTORIES))
	@echo Done.

.PHONY: link
link: scaffold $(OBJ_FILES) # link
	@echo Linking $(ASSEMBLY)...
	clang++ $(OBJ_FILES) -o $(BUILD_DIR)/$(ASSEMBLY)$(EXTENSION) $(LINKER_FLAGS)

.PHONY: compile
compile: # compile .cpp files
	@echo Compiling...

.PHONY: clean
clean: # clean build directory
	rm -Rf $(BUILD_DIR)/$(ASSEMBLY)
	rm -Rf $(OBJ_DIR)/$(ASSEMBLY)

$(OBJ_DIR)/%.cpp.o: %.cpp # compile .cpp to .o object
	@echo   $<...
	@clang++ $< $(COMPILER_FLAGS) -c -o $@ $(DEFINES) $(INCLUDE_FLAGS)  -std=c++17

-include $(OBJ_FILES:.o=.d)