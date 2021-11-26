SCANNER = "`cygpath -w "$(JFLEX)"`"
TEST_DIR = "test"
PROGRAM_DIR = "programs"
OUTPUT_DIR = "bin"
SRC_DIR = "src"

all: clean scanner parser
	
	javac -d $(OUTPUT_DIR)/ $(SRC_DIR)/*.java

scanner: 
	# jflex scanner.jflex -- to be inserted in the final version
	exec java -jar $(SCANNER) $(SRC_DIR)/scanner.jflex
	
parser:
	java java_cup.MainDrawTree -parser Parser $(SRC_DIR)/parser.cup
	mv *.java $(SRC_DIR)/
	
clean:
	rm -fr $(SRC_DIR)/parser.java $(SRC_DIR)/scanner.java $(SRC_DIR)/sym.java
	rm -vfr $(OUTPUT_DIR)//*.class
	rm -vfr $(SRC_DIR)/*.*~
build:
	cd $(OUTPUT_DIR)/ ; java Main ../$(PROGRAM_DIR)/$(FILE).hs $(FILE).ll
	
run: build
	lli $(FILE).ll 
	

