import java.util.LinkedList;
import java.util.ArrayList;

public class LLVM {
	private static Integer counterIf = 0;
	private static Integer counterSSA = 0;
	
	public static void resetCounterSSA() { counterSSA = 0; }
	public static Integer getCounterSSA() { return counterSSA++; }
	public static Integer getCounterIf() { return counterIf++; }
	
	public static String writeType(Type type) {
		String llvmType = new String();
		if (type.isEquivalent("Int") || type.isSubtype("List") && type.getTypeParam(0).isEquivalent("Int")) 
			llvmType += "i32";
		else if (type.isEquivalent("Double") || type.isSubtype("List") && type.getTypeParam(0).isEquivalent("Double")) 
			llvmType += "double";
		else if (type.isEquivalent("Char") || type.isSubtype("List") && type.getTypeParam(0).isEquivalent("Char")) 
			llvmType += "i8";
		else if (type.isEquivalent("Bool") || type.isSubtype("List") && type.getTypeParam(0).isEquivalent("Bool")) 
			llvmType += "i1";
		if (type.isSubtype("List")) 
			llvmType += "*";
		return llvmType;
	}
	
	public static String createVariable(Integer varIndex) {
		return "%" + varIndex;
	}
	public static String createPrintDeclaration() {
		return "declare i32 @printf(i8*, ...)"; 
	}
	public static LinkedList<String> createPrintFormatStrings() { 
		LinkedList<String> code = new LinkedList<>();
		code.add("@.str$Int = private constant [4 x i8] c\"%d\0A\00\", align 1");
		code.add("@.str$Double = private constant [4 x i8] c\"%f\0A\00\", align 1");
		code.add("@.str$Char = private constant [4 x i8] c\"%c\0A\00\", align 1");
		code.add("@.str$String = private constant [4 x i8] c\"%s\0A\00\", align 1");
		return code; 
	}
	public static String createMainDefinition() { 
		return "define void @main()"; 
	}
	public static LinkedList<String> openFunction() { 
		LinkedList<String> code = new LinkedList<>();
		code.add("{");
		code.add(LLVM.createLabel("entry"));
		return code; 
	} 
	public static String closeFunction() { return "}"; } 
	public static String createReturnVoid() { return "ret void"; } 
	public static String createPrintCall(String result, Type argType, String actargIndex) { 
		String code = result + " = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x 18], [4 x i8]* @.str$";
		if (argType.isEquivalent("Int")) { code += "Int"; }
		else if (argType.isEquivalent("Double")) { code += "Double"; }
		else if (argType.isEquivalent("Char")) { code += "Char"; }
		else if (argType.isEquivalent("String")) { code += "String"; }
		code += ", i32 0, i32 0), " + LLVM.writeType(argType) + " " + actargIndex + ")";
		return code; 
	} 
	public static String createBranchCond(String condIndex, String thenLabel, String elseLabel) {
		return "br i1 " + condIndex + ", label %" + thenLabel + ", label %" + elseLabel;
	}
	public static String createBranchNotCond(String label) {
		return "br label %" + label;
	}
	public static String createLabel(String label) { return label + ":"; }
	public static String createAlloca(String id, Type type) {
		return null;
	} // TODO
	public static String createAlloca(String id, Type type, Integer length) {
		return null;
	} // TODO
	public static String createStore(String id, String result, Type type) {
		return null;
	} // TODO
	public static LinkedList<String> createStoreArrayElement(String reg, Type type, String subExp, Integer i) {
		return null;
	} // TODO
	public static String createStoreConstant(String result, Type type, Object value) {
		return null;
	} // TODO
	public static String createFunctionDefinition(String id, Type type, AST.LFormArg lformarg) {
		String code;
		ArrayList<String> argNames = lformarg.getArgNames();
		ArrayList<Type> argTypes = lformarg.getArgTypes();
		code = "define " + LLVM.writeType(type) + "@" + id + "(";
		for (int i = 0; i < argNames.size(); i++) {
			if (i > 0) code += ", "; 
			code += LLVM.writeType(argTypes.get(i)) + " %" + argNames.get(i);
		}
		code += ")";
		return code;
	}
	public static String createReturn(String result, Type type) {
		return "ret " + LLVM.writeType(type) + " " + result;
	}
	// TODO ADD ALL METHODS	BELOW
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