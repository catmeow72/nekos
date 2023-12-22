AS = vasm
AS_FLAGS = -dotdir -Fbin -c02

TEST_FLAGS = -C cx16-asm.cfg -t cx16 -u __EXEHDR__

SRC_DIR = src
BUILD_DIR = build
BANKS := 
define add_bank
BANKS += $(BUILD_DIR)/$(1).bin
.PHONY: $(BUILD_DIR)/$(1).bin
$(BUILD_DIR)/$(1).bin: $(wildcard $$(SRC_DIR)/$(1)/*.s)
	$$(AS) $$(AS_FLAGS) $$(SRC_DIR)/$(1)/main.s -L $$(BUILD_DIR)/$(1).bin.lst -o $$(BUILD_DIR)/$(1).bin.fullram
	./scripts/fixrom.py $$(BUILD_DIR)/$(1).bin.fullram $$(BUILD_DIR)/$(1).bin
endef
all: builddir rom

builddir:
	mkdir -p $(BUILD_DIR)



$(eval $(call add_bank,main_bank))
rom: $(BANKS)
	cat $^ > $(BUILD_DIR)/rom.bin
charset:
	nasm -fbin $(SRC_DIR)/charset_petscii.s -o $(BUILD_DIR)/charset_petscii.bin

test: tests/test.s
	cl65 $(TEST_FLAGS) tests/test.s -o $(BUILD_DIR)/TEST.PRG
