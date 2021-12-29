import java.io.*;
import java.util.LinkedList;

public class Main {
	
    static public void main(String argv[]) {    
        try {
            /* Scanner instantiation */
            Scanner scanner = new Scanner(new FileReader(argv[0]));
            /* Parser instantiation */
            Parser parser = new Parser(scanner);
			//parser.setOutputFileName(argv[1]);
            /* Run the parser */
            Object result = parser.parse();
			/* Copy the code into the output file */
			if (parser.compileSuccess()) {
				PrintWriter writer = new PrintWriter(new FileWriter(argv[1]));
				for (String line: parser.getCode()) { writer.println(line); }
				writer.close();
			}
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}


