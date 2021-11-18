scanner = "`cygpath -w "$(JFLEX)"`"

all: clean scanner parser

	javac *.java

scanner: scanner.jflex
	# jflex scanner.jflex -- to be inserted in the final version
	exec java -jar $(scanner) scanner.jflex
	
	
parser: parser.cup
	java java_cup.MainDrawTree -parser Parser -expect 1 parser.cup
	
clean:
	rm -fr parser.java scanner.java sym.java
	rm -vfr *.class
	rm -vfr *.*~
	
build:
	java Main $(FILE).hs $(FILE).ll
	
run: build
	lli $(FILE).ll 
	

