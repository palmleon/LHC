SCANNER = "`cygpath -w "$(JFLEX)"`"
TEST_DIR = "test"
PROGRAM_DIR = "programs"
BIN_DIR = "bin"
OUTPUT_DIR = "output"
SRC_DIR = "src"
TEST_DIR = "test"
#TEST_SRC = $(wildcard $(TEST_DIR)/$(KIND)/$(LEVEL)/*.hs)
TEST_SRC := $(shell find $(TEST_DIR)/$(KIND)/$(LEVEL)/ -name '*.hs')
TEST_OUT := $(patsubst %.hs,%.ll,$(TEST_SRC))
JAVA = "java"

all: clean scanner parser
	
	javac -d $(BIN_DIR)/ $(SRC_DIR)/*.java

scanner: 
	# jflex scanner.jflex -- to be inserted in the final version
	exec java -jar $(SCANNER) $(SRC_DIR)/scanner.jflex
	
parser:
	java java_cup.MainDrawTree -parser Parser $(SRC_DIR)/parser.cup
	mv *.java $(SRC_DIR)/
	
clean:
	rm -fr $(SRC_DIR)/parser.java $(SRC_DIR)/scanner.java $(SRC_DIR)/sym.java
	rm -vfr $(BIN_DIR)/*.class
	rm -vfr $(SRC_DIR)/*.*~
	
build:
	cd $(BIN_DIR)/ ; java Main ../$(PROGRAM_DIR)/$(FILE).hs $(FILE).ll
	
.PHONY: test
test: $(TEST_OUT)
	
%.ll: %.hs
	cd $(BIN_DIR)/ ; java Main ../$< ../$@
	
run: build
	lli $(FILE).ll 
	

