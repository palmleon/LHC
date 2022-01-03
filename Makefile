SCANNER = "`cygpath -w "$(JFLEX)"`"
BIN_DIR = "bin"
SRC_DIR = "src"

.PHONY: install uninstall 

install:
	cd $(SRC_DIR)/ && $(MAKE)
	javac -d $(BIN_DIR)/ $(SRC_DIR)/*.java
	
uninstall: 
	cd $(SRC_DIR) && make uninstall
	rm -vfr $(BIN_DIR)/*.class
	rm -vfr $(SRC_DIR)/*.*~
	rm -fr $(BIN_DIR)
	
%.ll: %.hs
	cd $(BIN_DIR)/ ; java Main ../$< ../$@
	

