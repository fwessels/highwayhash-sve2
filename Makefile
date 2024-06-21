
include ../../config.mk

EXE = highwayhash

SRCDIR = ./src
BUILDDIR = ./build

CFLAGS = $(CFLAGS_OPT) $(CFLAGS_SVE2)

SRC_C := $(wildcard $(SRCDIR)/*.c)
SRC_ASM := $(wildcard $(SRCDIR)/*.S)

OBJ_C := $(patsubst $(SRCDIR)/%.c, $(BUILDDIR)/%.s, $(SRC_C))

.PHONY: all
all: build_directory executable

DEPS := $(OBJ_C:%.s=%.d)

-include $(DEPS)

$(BUILDDIR)/%.s: $(SRCDIR)/%.c
	$(CC) $(CFLAGS) $< -S -o $@

.PHONY: build_directory
build_directory:
	@mkdir -pv $(BUILDDIR)

.PHONY: executable
executable: $(OBJ_C) $(SRC_ASM)
	$(CC) $(CFLAGS) $^ -o $(BUILDDIR)/$(EXE)

.PHONY: clean
clean:
	rm -fv $(BUILDDIR)/*.d $(BUILDDIR)/*.s $(BUILDDIR)/$(EXE)

.PHONY: run
run: all
	$(ARMIE) -- $(BUILDDIR)/$(EXE)
