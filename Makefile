AS = vasm
AS_FLAGS = -dotdir -Fbin

SRC_DIR = src
BUILD_DIR = build

all: builddir rom

builddir:
	mkdir -p $(BUILD_DIR)

rom: $(SRC_DIR)/main.s
	$(AS) $(AS_FLAGS) $(SRC_DIR)/main.s -o $(BUILD_DIR)/rom.bin

charset:
	nasm -fbin $(SRC_DIR)/charset_petscii.s -o $(BUILD_DIR)/charset_petscii.bin
