# defines the compiler
CXX := g++
OUTPUT := sfmlgame
OS := $(shell uname)

# linux compiler/flags
ifeq ($(OS), Linux)
	CXX_FLAGS := -O3 -std=c++20 -Wno-deprecated-declarations
	INCLUDES := -I./src -I./vendor/imgui
	LDFLAGS := -O3 -lsfml-graphics -lsfml-window -lsfml-system -lsfml-audio -lGL
endif

# macos compiler/flags
ifeq ($(OS), Darwin)
	SFML_DIR := /opt/homebrew/Cellar/sfml/2.6.2
	CXX_FLAGS := -O3 -std=c++20 -Wno-deprecated-declarations
	INCLUDES := -I./src -I./vendor/imgui -I${SFML_DIR}/include
	LDFLAGS := -O3 -lsfml-graphics -lsfml-window -lsfml-system -lsfml-audio -L${SFML_DIR}/lib -framework OpenGL
endif

# the source files for the game engine and code
SRC_FILES := $(wildcard src/*.cpp vendor/imgui/*.cpp)
OBJ_FILES := $(SRC_FILES:.cpp=.o)

# Include dependency files
DEP_FILES := $(SRC_FILES:.cpp=.d) 
-include $(DEP_FILES)

# all of these targets will be made if you just type make
all: $(OUTPUT)

# define the main executable requirements / command
$(OUTPUT): $(OBJ_FILES) Makefile
	$(CXX) $(OBJ_FILES) $(LDFLAGS) -o ./bin/$@ 
	cp -R assets/ bin/

# specifies how the object files are compiled from cpp files
.cpp.o:
	$(CXX) -MMD -MP -c $(CXX_FLAGS) $(INCLUDES) $< -o $@

# typing 'make clean' will remove all intermediate build files
clean:
	rm -rf $(OBJ_FILES) $(DEP_FILES) ./bin/$(OUTPUT) bin/font bin/imgui.ini

# typing 'make run' will compile and run the program
run: $(OUTPUT)
	cd bin && ./$(OUTPUT) && cd ..