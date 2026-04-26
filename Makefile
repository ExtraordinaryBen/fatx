# FATX Build System
#
# Copyright (C) 2015  Matt Borgerson

.PHONY: all build clean install help

BUILD_DIR ?= build
CMAKE ?= cmake
CMAKE_PREFIX ?= /usr/local

all: build

build:
	$(CMAKE) -S. -B$(BUILD_DIR) -DCMAKE_INSTALL_PREFIX=$(CMAKE_PREFIX)
	$(CMAKE) --build $(BUILD_DIR)

install:
	$(CMAKE) --install $(BUILD_DIR)

clean:
	rm -rf $(BUILD_DIR)

help:
	@echo "FATX Build Targets:"
	@echo "  make build              - Build libfatx (and fatxfs if enabled)"
	@echo "  make install          - Install libraries and binaries"
	@echo "  make clean            - Remove build directory"
	@echo ""
	@echo "Variables:"
	@echo "  BUILD_DIR=<dir>       - Build directory (default: build)"
	@echo "  CMAKE_PREFIX=<path>   - Install prefix (default: /usr/local)"
	@echo ""
	@echo "Examples:"
	@echo "  make build CMAKE_PREFIX=/usr      - Install to /usr"
	@echo "  make build BUILD_DIR=mybuild     - Use custom build dir"