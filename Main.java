import java.io.*;

public class Main {
	
    static public void main(String argv[]) {    
        try {
            /* Scanner instantiation */
            Scanner scanner = new Scanner(new FileReader(argv[0]));
            /* Parser instantiation */
            Parser parser = new Parser(scanner);
			parser.setOutputFileName(argv[1]);
            /* Run the parser */
            Object result = parser.parse();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}


