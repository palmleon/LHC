SCANNER = "`cygpath -w "$(JFLEX)"`"
TEST_DIR = "test"
PROGRAM_DIR = "programs"
BIN_DIR = "bin"
OUTPUT_DIR = "output"
SRC_DIR = "src"
TEST_DIR = "test"
TEST_SRC := $(shell find $(TEST_DIR)/$(KIND)/$(LEVEL)/ -name '*.hs')
TEST_OUT := $(patsubst %.hs,%.ll,$(TEST_SRC))
JAVA = "java"

.PHONY: install clean build cleantest test run

install:
	cd $(SRC_DIR)/ && $(MAKE)
	javac -d $(BIN_DIR)/ $(SRC_DIR)/*.java
	
uninstall: clean

clean:
	cd $(SRC_DIR) && make clean
	rm -vfr $(BIN_DIR)/*.class
	rm -vfr $(SRC_DIR)/*.*~
	rm -fr $(BIN_DIR)

cleantest:
	rm -f $(TEST_OUT)
	
test: cleantest $(TEST_OUT)
	
%.ll: %.hs
	cd $(BIN_DIR)/ ; java Main ../$< ../$@
	

