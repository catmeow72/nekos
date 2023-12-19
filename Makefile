AS = cl65
AS_FLAGS = -C cx16-asm.cfg -t cx16

SRC_DIR = src
BUILD_DIR = build

all: builddir rom

builddir:
	mkdir -p $(BUILD_DIR)

rom: $(SRC_DIR)/main.s
	$(AS) $(AS_FLAGS) $(SRC_DIR)/main.s -o $(BUILD_DIR)/rom.bin
