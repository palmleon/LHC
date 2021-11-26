SCANNER = "`cygpath -w "$(JFLEX)"`"
TEST_DIR = "test"
PROGRAM_DIR = "programs"

all: clean scanner parser
	
	javac -d bin/ src/*.java

scanner: 
	# jflex scanner.jflex -- to be inserted in the final version
	exec java -jar $(SCANNER) src/scanner.jflex
	mv src/Scanner.java .
	
parser:
	java java_cup.MainDrawTree -parser Parser src/parser.cup
	mv *.java src/
	
clean:
	rm -fr src/parser.java src/scanner.java src/sym.java
	rm -vfr src/*.class
	rm -vfr src/*.*~

test: clean scanner parser
	cd test ; exec java -jar $(SCANNER) TestTree.java
	
build:
	cd bin ; java Main ../$(PROGRAM_DIR)/$(FILE).hs $(FILE).ll
	
run: build
	lli $(FILE).ll 
	

