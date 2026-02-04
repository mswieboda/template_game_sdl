CRYSTAL_COMPILER := crystal
SOURCE_FILE := src/template_game_sdl.cr
BUILD_DIR := build
BINARY_NAME := template_game_sdl

ifeq ($(OS),Windows_NT)
	SDL_LIB_PATH = "D:/code/SDL2/lib/x64"
	# Windows-specific link flags pointing to your SDL2/lib/x64 folder
	LINK_FLAGS = --link-flags="/LIBPATH:$(SDL_LIB_PATH)"
	OUTPUT_EXT = .exe
else
	# Mac/Linux flags (Homebrew handles these automatically usually)
	LINK_FLAGS =
	OUTPUT_EXT =
endif

TARGET_FILE := $(BUILD_DIR)/$(BINARY_NAME)
CRYSTAL_FLAGS := --error-trace
RM_CMD := rm -rf
MKDIR_CMD := mkdir -p

# Phony targets don't represent files
.PHONY: all mkdir test release clean

# The default target, executed when you just run `make`
all: test

mkdir:
	@$(MKDIR_CMD) $(BUILD_DIR)

copy_dlls:
ifeq ($(OS),Windows_NT)
	cp $(SDL_LIB_PATH)/*.dll build/
endif

$(TARGET_FILE)_test$(OUTPUT_EXT): mkdir
	@echo "Building $(SOURCE_FILE) -> $(TARGET_FILE)_test$(OUTPUT_EXT) ..."
	$(CRYSTAL_COMPILER) build $(SOURCE_FILE) -o $(TARGET_FILE)_test$(OUTPUT_EXT) $(LINK_FLAGS) --error-trace

test: $(TARGET_FILE)_test$(OUTPUT_EXT) copy_dlls
	./$(TARGET_FILE)_test$(OUTPUT_EXT)

$(TARGET_FILE)$(OUTPUT_EXT): mkdir
	@echo "Building release $(SOURCE_FILE) -> $(TARGET_FILE)$(OUTPUT_EXT) ..."
	$(CRYSTAL_COMPILER) build $(SOURCE_FILE) -o $(TARGET_FILE) $(LINK_FLAGS) --release --no-debug

release: $(TARGET_FILE)$(OUTPUT_EXT) copy_dlls
	./$(TARGET_FILE)$(OUTPUT_EXT)

clean:
	@echo "Executing clean..."
	$(RM_CMD) $(BUILD_DIR)
