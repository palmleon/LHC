all: clean scanner parser

	javac *.java

scanner:
	jflex scanner.jflex
	
parser:
	java java_cup.MainDrawTree -expect 4 parser.cup
	
clean:

	rm -fr parser.java scanner.java sym.java
	rm -vfr *.class
	rm -vfr *.*~
	
build:
	java Main $(FILE).sh > $(FILE).ll
	
run:
	lli $(FILE).ll 
	
buildrun: build run

