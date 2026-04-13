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
APP_NAME := "Template Game SDL"
GAME_NAME := template_game_sdl
GAME_SRC := src/template_game_sdl.cr

# Phony targets don't represent files
.PHONY: default build run packer pack build-release run-release clean release-package release-package-mac release-package-win release-package-linux

# The default target, executed when you just run `make`
default: run

build:
	@echo "Building..."
	$(MKDIR_CMD) $(BUILD_DIR)
	$(CRYSTAL_COMPILER) build $(SOURCE_DIR)/$(SOURCE_FILE).cr -o $(BUILD_DIR)/$(SOURCE_FILE)_debug --link-flags "$(LINKFLAGS)" -p
	@echo

run: build
	@echo "Running..."
	./$(BUILD_DIR)/$(SOURCE_FILE)_debug
	@echo

$(PACKER_BIN):
	@echo "Building packer tool..."
	$(MKDIR_CMD) $(BIN_DIR)
	$(CRYSTAL_COMPILER) build lib/game_sdl/src/packer.cr -o $(BIN_DIR)/gsdl-packer --release --no-debug -p
	@echo

packer: $(PACKER_BIN)

$(PACKER_FILE): $(PACKER_BIN)
	@echo "Packing assets via GameSDL packer..."
	./$(PACKER_BIN)
	@echo

pack: $(PACKER_FILE)

build-release: $(PACKER_FILE)
	@echo "Building release..."
	$(MKDIR_CMD) $(BUILD_DIR)
	$(CRYSTAL_COMPILER) build $(SOURCE_DIR)/$(SOURCE_FILE).cr -o $(BUILD_DIR)/$(SOURCE_FILE) --release --link-flags "$(LINKFLAGS)" --no-debug -p
	@echo

run-release: build-release
	@echo "Running release..."
	./$(BUILD_DIR)/$(SOURCE_FILE)
	@echo

clean:
	@echo "Executing clean..."
	$(RM_CMD) $(BIN_DIR)
	$(RM_CMD) $(BUILD_DIR)
	$(RM_CMD) $(LIB_DIR)
	@echo

release-package:
	@echo "Creating release package for $(GAME_NAME) (target: $(TARGET))..."
	mkdir -p build
	crystal run lib/game_sdl/src/gsdl/release_helper.cr -- \
		$(if $(GAME_NAME),--game=$(GAME_NAME)) \
		--src=$(if $(SRC),$(SRC),$(GAME_SRC)) \
		--target=$(TARGET) \
		--name=$(if $(APP_NAME),$(APP_NAME),$(GAME_NAME)) \
		$(if $(VERSION),--version=$(VERSION)) \
		$(if $(ICON),--icon=$(ICON)) \
		$(if $(BUNDLE_ID),--bundle-id=$(BUNDLE_ID)) \
		$(if $(OUTPUT),--output=$(OUTPUT))

release-package-mac:
	@$(MAKE) release-package TARGET=mac

release-package-win:
	@$(MAKE) release-package TARGET=win

release-package-linux:
	@$(MAKE) release-package TARGET=linux
