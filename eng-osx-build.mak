BUILD_DIR := bin
OBJ_DIR := obj

ASSEMBLY := engine
EXTENSION := .so
COMPILER_FLAGS := -g -Wall -Werror -fdeclspec -fPIC 
INCLUDE_FLAGS := -Iengine/src -Iexternals/lua -Iexternals
LINKER_FLAGS := -g -shared $(BUILD_DIR)/lua.a -lobjc -framework AppKit -framework QuartzCore -install_name @rpath/libengine.so
DEFINES := -DDEBUG -DDLLEXPORT

SRC_FILES := $(shell find $(ASSEMBLY) -type f \( -name "*.cpp" -o -name "*.mm" \))	# .cpp and .mm files
DIRECTORIES := $(shell find $(ASSEMBLY) -type d)									# directories with .h files
OBJ_FILES := $(SRC_FILES:%=$(OBJ_DIR)/%.o)	

all: scaffold compile link post

.PHONY: scaffold
scaffold: # create build directory
	@echo Scaffolding folder structure...
	@mkdir -p $(addprefix $(OBJ_DIR)/,$(DIRECTORIES))

.PHONY: link
link: scaffold $(OBJ_FILES) # link
	@echo Linking $(ASSEMBLY)...
	@mkdir -p $(BUILD_DIR)
	@clang++ $(OBJ_FILES) -o $(BUILD_DIR)/lib$(ASSEMBLY)$(EXTENSION) $(LINKER_FLAGS)

.PHONY: compile
compile: #compile .cpp and .mm files
	@echo Compiling...
-include $(OBJ_FILES:.o=.d)

.PHONY: post
post: #post build step, copy script files to bin
	@echo Performing post build steps...
	@mkdir -p $(BUILD_DIR)/scripts
	@cp scripts/* $(BUILD_DIR)/scripts 
	@echo Done

.PHONY: clean
clean: # clean build directory
	rm -Rf $(BUILD_DIR)/lib$(ASSEMBLY)$(EXTENSION)
	rm -Rf $(OBJ_DIR)/$(ASSEMBLY)

$(OBJ_DIR)/%.cpp.o: %.cpp # compile .cpp to .o object
	@echo   $<...
	@clang++ $< $(COMPILER_FLAGS) -c -o $@ $(DEFINES) $(INCLUDE_FLAGS) -std=c++17

$(OBJ_DIR)/%.mm.o: %.mm # compile .mm to .o object
	@echo   $<...
	@clang++ $< $(COMPILER_FLAGS) -c -o $@ $(DEFINES) $(INCLUDE_FLAGS) -ObjC++ -std=c++17

-include $(OBJ_FILES:.o=.d)