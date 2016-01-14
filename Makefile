BUILD_DIR=./.build/debug

.PHONY: all clean lib

all: lib
	$(BUILD_DIR)/jarvis badges

clean:
	swift build --clean

lib:
	swift build
