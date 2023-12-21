AS = vasm
AS_FLAGS = -dotdir -Fbin

TEST_FLAGS = -C cx16-asm.cfg -t cx16 -u __EXEHDR__

SRC_DIR = src
BUILD_DIR = build

all: builddir rom

builddir:
	mkdir -p $(BUILD_DIR)

rom: $(SRC_DIR)/main.s
	$(AS) $(AS_FLAGS) $(SRC_DIR)/main.s -o $(BUILD_DIR)/rom.bin

charset:
	nasm -fbin $(SRC_DIR)/charset_petscii.s -o $(BUILD_DIR)/charset_petscii.bin

test: tests/test.s
	cl65 $(TEST_FLAGS) tests/test.s -o $(BUILD_DIR)/TEST.PRG
