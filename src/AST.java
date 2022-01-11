import java.util.HashMap;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Stack;
import java.util.Iterator;

public class AST {

	/*
	 * Basic Node of the AST
	 */
	public abstract static class BasicNode {
		
		protected LinkedList<String> code = new LinkedList<>();
		
		protected static String basicBlock;
		
		abstract String codegen();
		
		public LinkedList<String> getCode() { 
			return this.code; 
		}
		
		protected static void setBasicBlock(String basicBlock){
			BasicNode.basicBlock = basicBlock;
		}
		
		protected static String getBasicBlock(){
			return basicBlock;
		}
		
		protected void mountCode(BasicNode otherNode) {
			this.code.addAll(otherNode.getCode());
		}
	}
	 
	public static class Program extends BasicNode {
		private FunctPart functPart;
		private ImperPart imperPart;
		
		Program(FunctPart functPart, ImperPart imperPart) {
			this.functPart = functPart;
			this.imperPart = imperPart;
		}
		
		@Override
		String codegen() {
			functPart.codegen();
			mountCode(functPart);
			imperPart.codegen();
			mountCode(imperPart);
			return null;
		}
	}
	
	public static class FunctPart extends BasicNode {
		private LinkedList<Stmt> stmts;
		
		FunctPart(){
			this.stmts = new LinkedList<Stmt>();
		}
		
		FunctPart(LinkedList<Stmt> stmts) {
			this.stmts = stmts;
		}
		
		@Override
		String codegen() {
			for (Stmt stmt: stmts) {
				stmt.codegen();
				mountCode(stmt);
			}
			return null;
		}
	}
	
	public static class ImperPart extends BasicNode {
		private IOAction ioAction;
		
		ImperPart(IOAction ioAction) {
			this.ioAction = ioAction;
		}
		
		@Override
		String codegen() { 
			LLVM.resetCounterSSA();
			LFormArg lformarg = new LFormArg(new ArrayList<String>(), new ArrayList<Type>(), null); 
			code.add(LLVM.createPrintDeclaration());
			code.addAll(LLVM.createPrintFormatStrings());
			code.add(LLVM.createMainDefinition());
			code.addAll(LLVM.openFunction());
			setBasicBlock("entry");
			if (ioAction != null) {
				ioAction.codegen();
				mountCode(ioAction);
			}
			code.add(LLVM.createReturnVoid());
			code.add(LLVM.closeFunction());
			return null;
		}
	}
	
	/* 
	 * IOAction is currently empty, but it could be extended (e.g. by including
	 * the type of the content of the last IOAction
	 */
	public abstract static class DoStmt extends BasicNode {}
	
	public abstract static class IOAction extends DoStmt {}
	
	public static class Print extends IOAction {
		private Expr actarg;
		
		Print(Expr actarg) {
			this.actarg = actarg;
		}
		
		@Override
		String codegen() { 
			String actargIndex = actarg.codegen();
			mountCode(actarg);
			String result = LLVM.createVariable(LLVM.getCounterSSA());
			code.add(LLVM.createPrintCall(result, actarg.getType(), actargIndex));
			return null;
		}
	}
	
	public static class DoBlock extends IOAction {
		private LinkedList<DoStmt> ioActions;
		
		DoBlock(LinkedList<DoStmt> ioActions) {
			this.ioActions = ioActions;
		}
		
		@Override
		String codegen() { 
			for (DoStmt ioAction: ioActions) {
				ioAction.codegen();
				mountCode(ioAction);
			}
			return null;
		}
	}
	
	public static class IfBlockImper extends IOAction{
		private Expr cond;
		private IOAction thenBody;
		private IOAction elseBody;
		
		IfBlockImper(Expr cond, IOAction thenBody, IOAction elseBody) {
			this.cond 	  = cond;
			this.thenBody = thenBody;
			this.elseBody = elseBody;
		}
		
		@Override
		String codegen() {
			int ifIndex;
			String condIndex, thenLabel, elseLabel, exitLabel;
			ifIndex = LLVM.getCounterIf();
			condIndex = cond.codegen();
			mountCode(cond);
			code.add(LLVM.createBranchCond(condIndex, "if.then$" + ifIndex, "if.else$" + ifIndex));
			thenLabel = "if.then$" + ifIndex;
			code.add(LLVM.createLabel(thenLabel));
			setBasicBlock(thenLabel);
			thenBody.codegen();
			mountCode(thenBody);
			code.add(LLVM.createBranchNotCond("if.exit$" + ifIndex));
			elseLabel = "if.else$" + ifIndex;
			code.add(LLVM.createLabel("if.else$" + ifIndex));
			setBasicBlock(elseLabel);
			elseBody.codegen();
			mountCode(elseBody);
			code.add(LLVM.createBranchNotCond("if.exit$" + ifIndex));
			exitLabel = "if.exit$" + ifIndex;
			code.add(LLVM.createLabel("if.exit$" + ifIndex));
			setBasicBlock(exitLabel);
			return null;
		}
	}
	
	public static class LetBlockImper extends DoStmt {
		private LinkedList<Stmt> letStmts;
		
		LetBlockImper(LinkedList<Stmt> letStmts) {
			this.letStmts = letStmts;
		}
		
		@Override
		String codegen() {
			for (Stmt letStmt: letStmts) {
				letStmt.codegen();
				mountCode(letStmt);
			}
			return null;
		}
	}
	
	public abstract static class Stmt extends BasicNode {}
		
	public static class DeclType extends Stmt {
		private Type type; // Used to propagate Type over multiple Type Declaration on the same line
		
		DeclType (Type type) {
			this.type = type;
		}
		
		public Type getType() { return this.type; }
		
		@Override
		String codegen() { return null;}
	}
	
	public static class DefValue extends Stmt {
		private String id; // must be a "unique" id
		private Expr expr;
		
		DefValue(String id, Expr expr) {
			this.id = id;
			this.expr = expr;
		}
		
		@Override
		String codegen() { 
			String exprIndex = expr.codegen();
			mountCode(expr);
			code.add(LLVM.createBitcast(LLVM.createVariable(id), exprIndex, expr.getType(), expr.getType()));
			return null;
		}
	}
	
	public static class DefFunct extends Stmt {
		private String id; // must be a "unique" id
		private LFormArg lformarg;
		private Expr expr;
		
		DefFunct(String id, LFormArg lformarg, Expr expr) {
			this.id = id;
			this.lformarg = lformarg;
			this.expr = expr;
		}
		
		@Override
		String codegen() { 
			LLVM.resetCounterSSA();
			code.add(LLVM.createFunctionDefinition(id, expr.getType(), lformarg));
			code.addAll(LLVM.openFunction());
			setBasicBlock("entry");
			String result = expr.codegen();
			mountCode(expr);
			code.add(LLVM.createReturn(result, expr.getType()));
			code.add(LLVM.closeFunction());
			return null;
		}
	}
	
	public abstract static class BasicExpr extends BasicNode {
		protected Type type;
		
		public Type getType() { return this.type; }
	}
	
	public enum ExprKind {
			PLUS, MINUS, TIMES, DIV, INTDIV, REM, AND, OR,
			RELNOTEQ, RELEQ, RELGE, RELGT, RELLE, RELLT,
			INDEX, NOT, UMINUS, LET_BLOCK_FUNC,
			IF_BLOCK_FUNC, FUNCT_CALL, VALUE, EXPR_LIST
	}
	
	public static class Expr extends BasicExpr {
		
		private ExprKind exprKind;
		private BasicExpr[] subExpressions; //the subexpressions
		
		Expr (Type type, ExprKind exprKind, BasicExpr[] subExpressions) {
			this.type = type;
			this.exprKind = exprKind;
			this.subExpressions = subExpressions;
		}
		
		@Override
		String codegen() {	// TO BE COMPLETED
			String[] subExpResults = new String[subExpressions.length];
			String result = null; 
			for (int i = 0; i < subExpressions.length; i++) {
				subExpResults[i] = subExpressions[i].codegen();
				mountCode(subExpressions[i]);
			}
			switch (exprKind) {
				case PLUS: 
					result = LLVM.createVariable(LLVM.getCounterSSA());
					code.add(LLVM.createAdd(result, subExpResults, subExpressions[0].getType()));
					break;
				case MINUS: 
					result = LLVM.createVariable(LLVM.getCounterSSA());
					code.add(LLVM.createSub(result, subExpResults, subExpressions[0].getType()));
					break;
				case TIMES: 
					result = LLVM.createVariable(LLVM.getCounterSSA());
					code.add(LLVM.createMult(result, subExpResults, subExpressions[0].getType()));
					break;
				case DIV: 
					String[] oldExpResults = new String[subExpressions.length];
					for (int i = 0; i < subExpressions.length; i++) {
						oldExpResults[i] = subExpResults[i];
						if (subExpressions[i].getType().isEquivalent("Int")) {
							subExpResults[i] = LLVM.createVariable(LLVM.getCounterSSA());
							code.add(LLVM.createSItoFP(subExpResults[i], oldExpResults[i], type, subExpressions[i].getType()));
						}
					}
					result = LLVM.createVariable(LLVM.getCounterSSA());
					code.add(LLVM.createDiv(result, subExpResults, type));
					break;
				case INTDIV: 
					result = LLVM.createVariable(LLVM.getCounterSSA());
					code.add(LLVM.createIntDiv(result, subExpResults, subExpressions[0].getType()));
					break;
				case REM: 
					result = LLVM.createVariable(LLVM.getCounterSSA());
					code.add(LLVM.createRem(result, subExpResults, subExpressions[0].getType()));
					break;
				case AND: 
					result = LLVM.createVariable(LLVM.getCounterSSA());
					code.add(LLVM.createAnd(result, subExpResults, subExpressions[0].getType()));
					break;
				case OR: 
					result = LLVM.createVariable(LLVM.getCounterSSA());
					code.add(LLVM.createOr(result, subExpResults, subExpressions[0].getType()));
					break;
				case RELNOTEQ: 
					result = LLVM.createVariable(LLVM.getCounterSSA());
					code.add(LLVM.createRelNotEQ(result, subExpResults, subExpressions[0].getType()));
					break;
				case RELEQ: 
					result = LLVM.createVariable(LLVM.getCounterSSA());
					code.add(LLVM.createRelEQ(result, subExpResults, subExpressions[0].getType()));
					break;
				case RELGE: 
					result = LLVM.createVariable(LLVM.getCounterSSA());
					code.add(LLVM.createRelGE(result, subExpResults, subExpressions[0].getType()));
					break;
				case RELGT: 
					result = LLVM.createVariable(LLVM.getCounterSSA());
					code.add(LLVM.createRelGT(result, subExpResults, subExpressions[0].getType()));
					break;
				case RELLE: 
					result = LLVM.createVariable(LLVM.getCounterSSA());
					code.add(LLVM.createRelLE(result, subExpResults, subExpressions[0].getType()));
					break;
				case RELLT: 
					result = LLVM.createVariable(LLVM.getCounterSSA());
					code.add(LLVM.createRelLT(result, subExpResults, subExpressions[0].getType()));
					break;
				case INDEX: 
					String elemPtr = LLVM.createVariable(LLVM.getCounterSSA());
					code.add(LLVM.createGEP(elemPtr, subExpResults[0], subExpressions[0].getType(), subExpResults[1]));
					result = LLVM.createVariable(LLVM.getCounterSSA());
					code.add(LLVM.createLoad(result, type, elemPtr));
					break;
				case NOT: 
					result = LLVM.createVariable(LLVM.getCounterSSA());
					code.add(LLVM.createNot(result, subExpResults, subExpressions[0].getType()));
					break;
				case UMINUS: 
					result = LLVM.createVariable(LLVM.getCounterSSA());
					code.add(LLVM.createUMinus(result, subExpResults, subExpressions[0].getType()));
					break;
				case LET_BLOCK_FUNC: 
					result = subExpResults[0];
					break;
				case IF_BLOCK_FUNC: 
					result = subExpResults[0];
					break;
				case FUNCT_CALL: 
					result = subExpResults[0];
					break;
				case VALUE: 
					result = subExpResults[0];
					break;
				case EXPR_LIST: 
					result = subExpResults[0];
					break;
			}
			return result;
		}
	}
	
	public static class LetBlockFunc extends BasicExpr {
		private LinkedList<Stmt> letStmts;
		private Expr expr;
		
		LetBlockFunc(Type type, LinkedList<Stmt> letStmts, Expr expr) {
			this.type = type;
			this.letStmts = letStmts;
			this.expr = expr;
		}
		
		@Override
		String codegen() { 
			for (Stmt letStmt: letStmts) {
				letStmt.codegen();
				mountCode(letStmt);
			}
			String result = expr.codegen();
			mountCode(expr);
			return result;
		}
	}
	
	public static class IfBlockFunc extends BasicExpr {
		private Expr cond, thenBody, elseBody;
		
		IfBlockFunc(Type type, Expr cond, Expr thenBody, Expr elseBody) {
			this.type = type;
			this.cond = cond;
			this.thenBody = thenBody;
			this.elseBody = elseBody;
		}
		
		@Override
		String codegen() { 
			final int ifIndex;
			String condIndex, thenIndex, elseIndex, thenLabel, elseLabel, exitLabel, thenBB, elseBB, result;
			ifIndex = LLVM.getCounterIf();
			condIndex = cond.codegen();
			mountCode(cond);
			code.add(LLVM.createBranchCond(condIndex, "if.then$" + ifIndex, "if.else$" + ifIndex));
			thenLabel = "if.then$" + ifIndex;
			code.add(LLVM.createLabel("if.then$" + ifIndex));
			setBasicBlock(thenLabel);
			thenIndex = thenBody.codegen();
			mountCode(thenBody);
			thenBB = getBasicBlock();
			code.add(LLVM.createBranchNotCond("if.exit$" + ifIndex));
			elseLabel = "if.else$" + ifIndex;
			code.add(LLVM.createLabel("if.else$" + ifIndex));
			setBasicBlock(elseLabel);
			elseIndex = elseBody.codegen();
			mountCode(elseBody);
			elseBB = getBasicBlock();
			code.add(LLVM.createBranchNotCond("if.exit$" + ifIndex));
			exitLabel = "if.exit$" + ifIndex;
			code.add(LLVM.createLabel("if.exit$" + ifIndex));
			setBasicBlock(exitLabel);
			result = LLVM.createVariable(LLVM.getCounterSSA());
			code.add(LLVM.createPHINode(result, this.type, thenBB, thenIndex, elseBB, elseIndex));
			return result;
		}
	}
	
	/*
	 * Includes both global variables and functions
	 */
	public static class FunctCall extends BasicExpr {
		private String id; // must be a unique id
		private LinkedList<Expr> actargs;
		
		FunctCall(Type type, String id, LinkedList<Expr> actargs) {
			this.type = type;
			this.id = id;
			this.actargs = actargs;
			//System.out.println("DEBUG: FUNCTION CALL ON " + this.id); 
		}
		
		@Override
		String codegen() {
			ArrayList<String> argIds = new ArrayList<>(); // list containing all the input argument id for the function
			ArrayList<Type> argTypes = new ArrayList<>();
			String result;
			for (Expr actarg: actargs) {
				argIds.add(actarg.codegen());
				argTypes.add(actarg.type);
				mountCode(actarg);
			}
			if (id.contains("$")) { // only local values have a '$' appended to their name
				result = LLVM.createVariable(id);
			}
			else {
				result = LLVM.createVariable(LLVM.getCounterSSA());
				code.add(LLVM.createFunctionCall(result, this.type, id, argIds, argTypes));
			}
			return result;
		}
	}
	
	/* Value is:
	 *	- Basic type for basic types (Int, Double, Char, String, Bool)
	 */
	public static class Value extends BasicExpr{
		private Object value;
		
		Value (Type type, Object value) {
			this.type = type;
			this.value = value;
		}
		
		@Override
		String codegen() { 
			String result = null;
			// trivial constants are just reported as they are and directly put
			// onto the code
			if (type.isEquivalent("Int")) {
				result = ((Integer) value).toString();
			}
			else if (type.isEquivalent("Double")) {
				result = ((Double) value).toString();
			}
			else if (type.isEquivalent("Char")) {
				// chars are converted into their corresponding ASCII code
				result = Integer.toString((int) ((Character) value).charValue());
			}
			else if (type.isEquivalent("Bool")) {
				result = ((Boolean) value).toString();
			}
			// strings need a special treatment to become usable, 
			// so they actually define some code
			else if (type.isEquivalent("String")) {
				String reg = LLVM.createVariable(LLVM.getCounterSSA());
				code.add(LLVM.createAlloca(reg, type, ((String) value).length()+1));
				code.add(LLVM.createStoreArray(reg, type, (String) value));
				result = LLVM.createVariable(LLVM.getCounterSSA());
				code.add(LLVM.createBitcastArrayToPtr(result, reg, type, ((String) value).length() + 1));
			}
			return result;
		}
	}	
	
	public static class ExprList extends BasicExpr{
		private ArrayList<Expr> exprArray;
		
		ExprList (ArrayList<Expr> exprArray, Type type) {
			this.exprArray = exprArray;
			this.type = type;
		}
		
		public ArrayList<Expr> getExprArray() { return this.exprArray; }
		
		@Override
		String codegen() { 
			LinkedList<String> subExpResults = new LinkedList<>();
			String subExpResult, elemPtr;
			for (Expr expr: exprArray) {
				subExpResult = expr.codegen();
				subExpResults.add(subExpResult);
				mountCode(expr);
			}
			String reg = LLVM.createVariable(LLVM.getCounterSSA());
			code.add(LLVM.createAlloca(reg, type, exprArray.size()));
			String result = LLVM.createVariable(LLVM.getCounterSSA());
			code.add(LLVM.createBitcastArrayToPtr(result, reg, type, exprArray.size()));
			int i = 0;
			for (String subExp: subExpResults) {
				elemPtr = LLVM.createVariable(LLVM.getCounterSSA());
				code.add(LLVM.createGEP(elemPtr, result, type, Integer.toString(i)));
				code.add(LLVM.createStore(elemPtr, subExp, type.getTypeParam(0)));
				i++;
			}
			return result;
		}
	}
	
	public static class LFormArg extends BasicNode{
		private Type propType; // used for propagating type over the arguments
		private ArrayList<String> argNames; // must be unique ids
		private ArrayList<Type> argTypes;
		
		LFormArg (ArrayList<String> argNames, ArrayList<Type> argTypes, Type propType) {
			this.argNames = argNames;
			this.argTypes = argTypes;
			this.propType = propType;
		}
		
		public Type getPropType() { return this.propType; }
		public ArrayList<String> getArgNames() { return this.argNames; }
		public ArrayList<Type> getArgTypes() { return this.argTypes; }
		
		@Override
		String codegen() { return null; } //Formal Argument Code is generated when generating code for Function Definition
	}	

}