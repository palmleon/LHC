import java.util.LinkedList;
import java.util.ArrayList;

public class LLVM {
	private static Integer counterIf = 0;
	private static Integer counterSSA = 0;
	
	public static Integer getCounterIf() { return counterIf; }
	public static void updateCounterIf() { counterIf++; }
	public static void resetCounterSSA() { counterSSA = 0; }
	public static Integer getCounterSSA() { return counterSSA; }
	public static void updateCounterSSA() { counterSSA++; }
	
	// TODO ADD ALL METHODS	
	public static String createPrintDeclaration() { return null; } //TODO
	public static LinkedList<String> createPrintFormatStrings() { return null; } //TODO
	public static String createMainDefinition() { return null; } //TODO
	public static LinkedList<String> openFunction() { return null; } //TODO
	public static String closeFunction() { return null; } //TODO
	public static String createReturnVoid() { return null; } //TODO
	public static LinkedList<String> createPrintCall(String result, Type argType) { return null; } //TODO
	public static String createBranchCond(String condIndex, String thenBranch, String elseBranch) {return null;} // TODO
	public static String createBranchNotCond(String label) {return null;} //TODO
	public static String createLabel(String label) { return null; } // TODO
	public static String createAlloca(String id, Type type) {return null;} // TODO
	public static String createAlloca(String id, Type type, Integer length) {return null;} //TODO
	public static String createStore(String id, String result, Type type) {return null;} // TODO
	public static LinkedList<String> createStoreArrayElement(String reg, Type type, String subExp, Integer i) {return null;} //TODO
	public static String createStoreConstant(String result, Type type, Object value) {return null;}
	public static String createFunctionDefinition(String id, Type type, AST.LFormArg lformarg) {return null;} // TODO
	public static String createReturn(String result, Type type) {return null;} //TODO
	public static String createAdd(String result, String[] intermResults, Type type) {return null;} //TODO
	public static String createSub(String result, String[] intermResults, Type type) {return null;} //TODO
	public static String createMult(String result, String[] intermResults, Type type) {return null;} //TODO
	public static String createDiv(String result, String[] intermResults, Type type) {return null;} //TODO
	public static String createIntDiv(String result, String[] intermResults, Type type) {return null;} //TODO
	public static String createMod(String result, String[] intermResults, Type type) {return null;} //TODO
	public static String createAnd(String result, String[] intermResults, Type type) {return null;} //TODO
	public static String createOr(String result, String[] intermResults, Type type) {return null;} //TODO
	public static String createRelNotEQ(String result, String[] intermResults, Type type) {return null;} //TODO
	public static String createRelEQ(String result, String[] intermResults, Type type) {return null;} //TODO
	public static String createRelGE(String result, String[] intermResults, Type type) {return null;} //TODO
	public static String createRelGT(String result, String[] intermResults, Type type) {return null;} //TODO
	public static String createRelLE(String result, String[] intermResults, Type type) {return null;} //TODO
	public static String createRelLT(String result, String[] intermResults, Type type) {return null;} //TODO
	public static String createLength(String result, String[] intermResults, Type type) {return null;} //TODO
	public static String createIndex(String result, String[] intermResults, Type type) {return null;} //TODO
	public static String createNot(String result, String[] intermResults, Type type) {return null;} //TODO
	public static String createUMinus(String result, String[] intermResults, Type type) {return null;} //TODO
	public static String createPHINode(String result, Type type, String thenLabel, String thenIndex, String elseLabel, String elseIndex) {return null;} //TODO
	public static String createLoad(String result, Type type, String pointer) {return null;} //TODO
	public static String createFunctionCall(String result, Type type, String id, ArrayList<String> argIds, ArrayList<Type> argTypes) {return null;} //TODO
	public static LinkedList<String> createArrayToPtrConversion(String result, Type type, String reg, Integer length) {return null;} //TODO
}