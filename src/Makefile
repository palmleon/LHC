SCANNER = "`cygpath -w "$(JFLEX)"`"

default: Scanner.java Parser.java

clean:
	rm -fr parser.java scanner.java sym.java

Scanner.java: scanner.jflex
	# jflex scanner.jflex -- to be inserted in the final version
	exec java -jar $(SCANNER) $<
	
Parser.java: parser.cup
	java java_cup.MainDrawTree -parser Parser $<