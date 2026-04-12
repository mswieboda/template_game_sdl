CRYSTAL_COMPILER := crystal
SOURCE_DIR := src
SOURCE_FILE := template_game_sdl
BUILD_DIR := build
BIN_DIR := bin
LIB_DIR := lib
SDL3_MIXER_LIB_DIR := /usr/local/lib
LINKFLAGS := -L$(SDL3_MIXER_LIB_DIR) -Wl,-rpath,$(SDL3_MIXER_LIB_DIR)
RM_CMD := rm -rf
MKDIR_CMD := mkdir -p
PACKER_FILE := build/assets.pack
PACKER_BIN := bin/gsdl-packer

# Phony targets don't represent files
.PHONY: default build run packer pack release clean

# The default target, executed when you just run `make`
default: run

build:
	@echo "Building..."
	$(MKDIR_CMD) $(BUILD_DIR)
	$(CRYSTAL_COMPILER) build $(SOURCE_DIR)/$(SOURCE_FILE).cr -o $(BUILD_DIR)/$(SOURCE_FILE)_debug --link-flags "$(LINKFLAGS)" -p

run: build
	@echo "Running..."
	./$(BUILD_DIR)/$(SOURCE_FILE)_debug

$(PACKER_BIN):
	@echo "Building packer tool..."
	$(MKDIR_CMD) $(BIN_DIR)
	$(CRYSTAL_COMPILER) build lib/game_sdl/src/packer.cr -o $(BIN_DIR)/gsdl-packer --release --no-debug -p

packer: $(PACKER_BIN)

$(PACKER_FILE): $(PACKER_BIN)
	@echo "Packing assets via GameSDL packer..."
	./$(PACKER_BIN)

pack: $(PACKER_FILE)

release: $(PACKER_FILE)
	@echo "Building release..."
	$(MKDIR_CMD) $(BUILD_DIR)
	$(CRYSTAL_COMPILER) build $(SOURCE_DIR)/$(SOURCE_FILE).cr -o $(BUILD_DIR)/$(SOURCE_FILE) --release --link-flags "$(LINKFLAGS)" --no-debug -p
	@echo "Running release..."
	./$(BUILD_DIR)/$(SOURCE_FILE)

clean:
	@echo "Executing clean..."
	$(RM_CMD) $(BUILD_DIR)
	$(RM_CMD) $(LIB_DIR)
