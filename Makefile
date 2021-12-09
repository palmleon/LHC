SCANNER = "`cygpath -w "$(JFLEX)"`"
TEST_DIR = "test"
PROGRAM_DIR = "programs"
BIN_DIR = "bin"
OUTPUT_DIR = "output"
SRC_DIR = "src"
TEST_DIR = "test"

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
	
test: 
	cd $(BIN_DIR)/ ; java Main ../$(TEST_DIR)/*.hs *.ll
	
run: build
	lli $(FILE).ll 
	

