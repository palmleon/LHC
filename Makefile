scanner = "`cygpath -w "$(JFLEX)"`"

all: clean scanner parser

	javac *.java

scanner:
	# jflex scanner.jflex -- to be inserted in the final version
	exec java -jar $(scanner) scanner.jflex
	
	
parser:
	java java_cup.MainDrawTree -parser Parser -expect 4 parser.cup
	
clean:

	rm -fr parser.java scanner.java sym.java
	rm -vfr *.class
	rm -vfr *.*~
	
build:
	java Main $(FILE).hs $(FILE).ll
	
run:
	lli $(FILE).ll 
	
buildrun: build run
	

