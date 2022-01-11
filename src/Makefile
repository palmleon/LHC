SCANNER = "`cygpath -w "$(JFLEX)"`"

default: Scanner.java Parser.java

uninstall:
	rm -fr Parser.java Scanner.java sym.java

Scanner.java: scanner.jflex
	jflex scanner.jflex 			# Linux version
	# exec java -jar $(SCANNER) $<	# Windows version
	
Parser.java: parser.cup
	java java_cup.MainDrawTree -parser Parser $<