CRYSTAL_COMPILER := crystal
SOURCE_FILE := src/template_game_sdl.cr
BUILD_DIR := build
OUTPUT_NAME := template_game_sdl
TARGET_FILE := $(BUILD_DIR)/$(OUTPUT_NAME)
CRYSTAL_FLAGS := --error-trace
RM_CMD := rm -rf
MKDIR_CMD := mkdir -p

# Phony targets don't represent files
.PHONY: all mkdir test release clean

# The default target, executed when you just run `make`
all: test

mkdir:
	@$(MKDIR_CMD) $(BUILD_DIR)

${TARGET_FILE}_test.o: mkdir
	@echo "Building $(SOURCE_FILE) -> $(TARGET_FILE)_test.o ..."
	$(CRYSTAL_COMPILER) build $(SOURCE_FILE) -o $(TARGET_FILE)_test.o --error-trace

test: ${TARGET_FILE}_test.o
	./${TARGET_FILE}_test.o

${TARGET_FILE}.o: mkdir
	@echo "Building release $(SOURCE_FILE) -> $(TARGET_FILE) ..."
	$(CRYSTAL_COMPILER) build $(SOURCE_FILE) -o $(TARGET_FILE).o --release --no-debug

release: ${TARGET_FILE}.o
	./${TARGET_FILE}.o

clean:
	@echo "Executing clean..."
	$(RM_CMD) $(BUILD_DIR)
