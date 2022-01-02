SCANNER = "`cygpath -w "$(JFLEX)"`"

default: Scanner.java Parser.java

clean:
	rm -fr parser.java scanner.java sym.java

Scanner.java: scanner.jflex
	jflex scanner.jflex 			# Linux version
	# exec java -jar $(SCANNER) $<	# Windows version
	
Parser.java: parser.cup
	java java_cup.MainDrawTree -parser Parser $<