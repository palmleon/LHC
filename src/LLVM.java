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
	
	public static String writeAlignment(Type type) {
		String alignment = new String();
		if (type.isEquivalent("Int")) alignment += "4";
		if (type.isEquivalent("Double")) alignment += "8";
		if (type.isEquivalent("Char")) alignment += "1";
		if (type.isEquivalent("Bool")) alignment += "1";
		if (type.isSubtype("List")) alignment += "4";
		return alignment;
	}
	
	public static String createVariable(Integer varIndex) {	return "%" + varIndex; }
	public static String createVariable(String varName) { return "%" + varName; }
	public static String createPrintDeclaration() {
		return "declare i32 @printf(i8*, ...)"; 
	}
	public static LinkedList<String> createPrintFormatStrings() { 
		LinkedList<String> code = new LinkedList<>();
		code.add("@.str$Int = private constant [4 x i8] c\"%d\\0A\\00\", align 1");
		code.add("@.str$Double = private constant [4 x i8] c\"%f\\0A\\00\", align 1");
		code.add("@.str$Char = private constant [4 x i8] c\"%c\\0A\\00\", align 1");
		code.add("@.str$String = private constant [4 x i8] c\"%s\\0A\\00\", align 1");
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
	public static String createPrintCall(String result, Type argType, String actarg) { 
		String code = result + " = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str$";
		if (argType.isEquivalent("Int")) { code += "Int"; }
		else if (argType.isEquivalent("Double")) { code += "Double"; }
		else if (argType.isEquivalent("Char")) { code += "Char"; }
		else if (argType.isEquivalent("String")) { code += "String"; }
		code += ", i32 0, i32 0), " + LLVM.writeType(argType) + " " + actarg + ")";
		return code; 
	} 
	public static String createBranchCond(String condIndex, String thenLabel, String elseLabel) {
		return "br i1 " + condIndex + ", label %" + thenLabel + ", label %" + elseLabel;
	}
	public static String createBranchNotCond(String label) {
		return "br label %" + label;
	}
	public static String createLabel(String label) { return label + ":"; }
	public static String createFunctionDefinition(String id, Type type, AST.LFormArg lformarg) {
		String code;
		ArrayList<String> argNames = lformarg.getArgNames();
		ArrayList<Type> argTypes = lformarg.getArgTypes();
		code = "define " + LLVM.writeType(type) + " @" + id + "(";
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
	public static String createBitcast(String result, String input, Type resultType, Type inputType) {
		return result + " = bitcast " + LLVM.writeType(inputType) + " " + input + " to " + LLVM.writeType(resultType);
	}
	public static String createBitcastArrayToPtr(String result, String reg, Type type, Integer length) {
		return result + " = bitcast [" + length + " x " + LLVM.writeType(type.getTypeParam(0)) + "]* " + reg + " to " + LLVM.writeType(type);
	}
	public static String createAlloca(String result, Type type) {
		return result + " = alloca " + LLVM.writeType(type) + ", align " + LLVM.writeAlignment(type);
	} 
	public static String createAlloca(String result, Type type, Integer length) {
		return result + " = alloca [" + length + " x " + LLVM.writeType(type.getTypeParam(0)) + "], align " + LLVM.writeAlignment(type);
	} 
	public static String createStore(String ptr, String reg, Type type) {
		return "store " + LLVM.writeType(type) + " " + reg + ", " + LLVM.writeType(type) + "* " + ptr + ", align " + LLVM.writeAlignment(type);
	}
	public static String createStoreArray(String dest, Type type, Object value) {
		String code = new String();
		if (type.isEquivalent("String")) {
			String string = (String) value;
			code += "store [" + (string.length() + 1) + " x " + LLVM.writeType(type.getTypeParam(0)) + "] ";
			code += "c\"" + string + "\\00\", [" + (string.length() + 1) + " x " + LLVM.writeType(type.getTypeParam(0)) + "]* " + dest + ", align " + LLVM.writeAlignment(type.getTypeParam(0));
		}
		return code;
	} 
	public static String createLoad(String result, Type type, String ptr) {
		return result + " = load " + LLVM.writeType(type) + ", " + LLVM.writeType(type) + "* " + ptr + ", align " + LLVM.writeAlignment(type);
	} 
	public static String createGEP(String result, String ptr, Type ptrType, String index) {
		return result + " = getelementptr inbounds " + LLVM.writeType(ptrType.getTypeParam(0)) + ", " + LLVM.writeType(ptrType)
		              + " " + ptr + ", i32 " + index;
	}
	public static String createSItoFP(String result, String input, Type resultType, Type inputType) {
		return result + " = sitofp " + LLVM.writeType(inputType) + " " + input + " to " + LLVM.writeType(resultType);
	}
	public static String createAdd(String result, String[] intermResults, Type type) {
		String code = new String();
		code += result + " = ";
		if (type.isEquivalent("Int")) code += "add ";
		if (type.isEquivalent("Double")) code += "fadd ";
		code += LLVM.writeType(type) + " " + intermResults[0] + ", " + intermResults[1];
		return code;
	} 
	public static String createSub(String result, String[] intermResults, Type type) {
		String code = new String();
		code += result + " = ";
		if (type.isEquivalent("Int")) code += "sub ";
		if (type.isEquivalent("Double")) code += "fsub ";
		code += LLVM.writeType(type) + " " + intermResults[0] + ", " + intermResults[1];
		return code;
	}
	public static String createMult(String result, String[] intermResults, Type type) {
		String code = new String();
		code += result + " = ";
		if (type.isEquivalent("Int")) code += "mul ";
		if (type.isEquivalent("Double")) code += "fmul ";
		code += LLVM.writeType(type) + " " + intermResults[0] + ", " + intermResults[1];
		return code;
	}
	public static String createDiv(String result, String[] intermResults, Type type) {
		String code = new String();
		code += result + " = ";
		code += "fdiv ";
		code += LLVM.writeType(type) + " " + intermResults[0] + ", " + intermResults[1];
		return code;
	}
	public static String createIntDiv(String result, String[] intermResults, Type type) {
		String code = new String();
		code += result + " = ";
		code += "sdiv ";
		code += LLVM.writeType(type) + " " + intermResults[0] + ", " + intermResults[1];
		return code;
	}
	public static String createRem(String result, String[] intermResults, Type type) {
		String code = new String();
		code += result + " = ";
		code += "srem ";
		code += LLVM.writeType(type) + " " + intermResults[0] + ", " + intermResults[1];
		return code;
	}
	public static String createAnd(String result, String[] intermResults, Type type) {
		String code = new String();
		code += result + " = ";
		code += "and ";
		code += LLVM.writeType(type) + " " + intermResults[0] + ", " + intermResults[1];
		return code;
	}
	public static String createOr(String result, String[] intermResults, Type type) {
		String code = new String();
		code += result + " = ";
		code += "or ";
		code += LLVM.writeType(type) + " " + intermResults[0] + ", " + intermResults[1];
		return code;
	} 
	public static String createRelNotEQ(String result, String[] intermResults, Type argType) {
		String code = new String();
		code += result + " = ";
		if (argType.isEquivalent("Int") || argType.isEquivalent("Char")) code += "icmp ne ";
		if (argType.isEquivalent("Double")) code += "fcmp one ";
		code += LLVM.writeType(argType) + " " + intermResults[0] + ", " + intermResults[1];
		return code;
	}
	public static String createRelEQ(String result, String[] intermResults, Type argType) {
		String code = new String();
		code += result + " = ";
		if (argType.isEquivalent("Int") || argType.isEquivalent("Char")) code += "icmp eq ";
		if (argType.isEquivalent("Double")) code += "fcmp oeq ";
		code += LLVM.writeType(argType) + " " + intermResults[0] + ", " + intermResults[1];
		return code;
	}
	public static String createRelGE(String result, String[] intermResults, Type argType) {
		String code = new String();
		code += result + " = ";
		if (argType.isEquivalent("Int") || argType.isEquivalent("Char")) code += "icmp sge ";
		if (argType.isEquivalent("Double")) code += "fcmp oge ";
		code += LLVM.writeType(argType) + " " + intermResults[0] + ", " + intermResults[1];
		return code;
	}
	public static String createRelGT(String result, String[] intermResults, Type argType) {
		String code = new String();
		code += result + " = ";
		if (argType.isEquivalent("Int") || argType.isEquivalent("Char")) code += "icmp sgt ";
		if (argType.isEquivalent("Double")) code += "fcmp ogt ";
		code += LLVM.writeType(argType) + " " + intermResults[0] + ", " + intermResults[1];
		return code;
	}
	public static String createRelLE(String result, String[] intermResults, Type argType) {
		String code = new String();
		code += result + " = ";
		if (argType.isEquivalent("Int") || argType.isEquivalent("Char")) code += "icmp sle ";
		if (argType.isEquivalent("Double")) code += "fcmp ole ";
		code += LLVM.writeType(argType) + " " + intermResults[0] + ", " + intermResults[1];
		return code;
	}
	public static String createRelLT(String result, String[] intermResults, Type argType) {
		String code = new String();
		code += result + " = ";
		if (argType.isEquivalent("Int") || argType.isEquivalent("Char")) code += "icmp slt ";
		if (argType.isEquivalent("Double")) code += "fcmp olt ";
		code += LLVM.writeType(argType) + " " + intermResults[0] + ", " + intermResults[1];
		return code;
	}
	public static String createNot(String result, String[] intermResults, Type type) {
		String code = new String();
		code += result + " = ";
		code += "xor ";
		code += LLVM.writeType(type) + " " + intermResults[0] + ", true";
		return code;
	}
	public static String createUMinus(String result, String[] intermResults, Type type) {
		String code = new String();
		code += result + " = ";
		if (type.isEquivalent("Int")) code += "sub ";
		if (type.isEquivalent("Double")) code += "fsub ";
		code += LLVM.writeType(type);
		if (type.isEquivalent("Int")) code += " 0";
		if (type.isEquivalent("Double")) code += " 0.0";
		code += ", " + intermResults[0];
		return code;
	}
	public static String createPHINode(String result, Type type, String thenLabel, String thenIndex, String elseLabel, String elseIndex) {
		return result + " = phi " + LLVM.writeType(type) + " [ " + thenIndex + ", " + LLVM.createVariable(thenLabel) + " ], "
		              + "[ " + elseIndex + ", " + LLVM.createVariable(elseLabel) + " ]";
	}
	public static String createFunctionCall(String result, Type type, String id, ArrayList<String> argIds, ArrayList<Type> argTypes) {
		String code = result + " = call " + LLVM.writeType(type) + " @" + id + "(";
		for (int i = 0; i < argIds.size(); i++) {
			if (i > 0) code += ", ";
			code += LLVM.writeType(argTypes.get(i)) + " " + argIds.get(i);
		}
		code += ")";
		return code;
	}
}