import java.util.HashMap;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Iterator;
import java.util.Stack;

/* Class for the Symbol Table Stack
 * The following Class contains a Static instance of the SymTable Stack, together with methods
 * that allow to push/pop SymTables and to extract an Entry from them
 * Fields: symTableStack - the Static instance of the SymTable Stack
 */
public class SymTableStack {
	
	private static boolean debug_mode = true;
	
	/* Class for Symbol Table Entry
	 * All Entries inside any SymTable are instances of this Class
	 * Fields: Type type - type of the value/function
	 *		   boolean isAssigned - flag that checks whether the value/function has been assigned or not
	 */
	public static class SymTableEntry {
		
		private Type type;
		private boolean isAssigned;
		
		SymTableEntry(Type type) {
			this.type = type;
			this.isAssigned = false;
		}
		
		SymTableEntry(Type type, boolean isAssigned) {
			this.type = type;
			this.isAssigned = isAssigned;
		}
		
		public Type getType() {
			return this.type;
		}
			
		public boolean getIsAssigned() {
			return this.isAssigned;
		}
		
		public void setType(Type type) {
			this.type = type;
		}
		
		public void setIsAssigned(boolean isAssigned) {
			this.isAssigned = isAssigned;
		}
	}
	
	// Symbol Table Stack (there is only one global instance whose lifetime corresponds to the lifetime of the parser itself)
	private LinkedList<HashMap<String, SymTableEntry>> symTableStack = new LinkedList<>();
	
	// Data Structure that contains, for all current SymTables (i.e. for all levels) in the Stack, their Id (i.e. how many times a SymTable has been defined at that level
	// This Data Structure is used for generating unique names for variables during IR Generation
	private ArrayList<Integer> symTableStackId = new ArrayList<>();
	
	/*
	 * Update the indexes in the symTableStackId list
	 * It is called every time that a new SymTable is pushed
	 * The method increments the index corresponding to the level 
	 * of the last inserted symTable
	 * @param: nothing
	 * @return: nothing
	 */
	private void updateSymTableStackId() {
		int stackSize = symTableStack.size();
		int stackIdSize = symTableStackId.size();
		if (stackSize > stackIdSize) {
			symTableStackId.add(0);
		}
		// increment the index of the top level symTable (it's the only new one)
		int currSymTableId = symTableStackId.get(stackSize-1);
		symTableStackId.set(stackSize - 1, currSymTableId + 1);
	}
	
	/*
	 * Obtain a String as a sequence of strings in the form "${symTableId}",
	 * where symTableId is the index of the corresponding level of the SymTable
	 * @param: int valueLevel - the level where the Value/Function is declared
	 * @return: String - the sequence of "${symTableId}" strings, as a single string
	 */
	public String getSymTableIds(int valueLevel) {
		String symTableIds = new String();
		int level = 0;
		Iterator<HashMap<String, SymTableEntry>> iterator = symTableStack.descendingIterator();
		HashMap<String, SymTableEntry> symTable;
		while (iterator.hasNext() && level <= valueLevel) {
			symTable = iterator.next();
			if (level > 0) {	
				symTableIds += "$" + symTableStackId.get(level);
			}
			level++;
		}
		return symTableIds;
	}
	
	/*
	 * Create a unique Id for IR Code Generation
	 * A unique Id is composed of:
	 * - the name of the Value/Function itself
	 * - a sequence of strings in the form "${symTableId}"
	 * @param:  String id - the Value/Function name
	 * @return: String - the unique Id
	 */
	public String createUniqueId(String id) {
		return id + getSymTableIds(this.getLevel(id));
	}
	
	/* 
	 * Method that pushes a new SymTable to the Stack
	 * @param: nothing
	 * @return: nothing
	 */
	public void pushSymTable() {
		symTableStack.push(new HashMap<String, SymTableEntry>());
		updateSymTableStackId();
	}
	
	/* 
	 * Method that pops the SymTable on top of the Stack
	 * @param: nothing
	 * @return: nothing
	 */
	public void popSymTable() {
		if(debug_mode) dumpSymTableStack();
		symTableStack.pop();
	}
	
	/*
	 * Extract the SymTable on top of the Stack
	 * @param: nothing
	 * @return: the expected SymTable
	 */
	public HashMap<String, SymTableEntry> peekSymTable() {
		return symTableStack.peek();
	}
	
	/*
	 * Insert a new Entry in the SymTable on top of the Stack
	 * This method is sensitive to the context (it depends on the current position in the Parser Tree)
	 * The Parser must guarantee the correct SymTable for a given Entry
	 * @param: String id - the name of the Entry (the corresponding token)
	 * 		   SymTableEntry entry - the Entry
	 * @return: nothing
	 */
	public void putEntry(String id, SymTableEntry entry) {
		symTableStack.peek().put(id, entry);
	}
	
	/*
	 * Check whether a certain Entry is present in the whole SymTable Stack
	 * Search is applied from the top of the Stack to the bottom;
	 * the first match is considered
	 * @param: String id - the name of the Entry (the corresponding token)
	 * @return: the flag that indicates whether the Entry is present or not
	 */
	public boolean containsEntry(String id) {
		boolean entryFound = false; // flag, raised if an Entry having the same name as id is found
		Iterator<HashMap<String, SymTableEntry>> iterator = symTableStack.listIterator(0);
		while (!entryFound && iterator.hasNext()) {
			if (iterator.next().containsKey(id)) entryFound = true;
		}
		return entryFound;
	}
	
	/*
	 * Check whether a certain Entry is present in the whole SymTable Stack and return it
	 * Search is applied from the top of the Stack to the bottom;
	 * the first match is considered
	 * @param: String id - the name of the Entry (the corresponding token)
	 * @return: the Entry itself, if found (null otherwise)
	 */
	public SymTableEntry getEntry(String id) {
		Iterator<HashMap<String, SymTableEntry>> iterator = symTableStack.listIterator(0);
		while (iterator.hasNext()) {
			HashMap<String, SymTableEntry> currentSymTable = iterator.next();
			if (currentSymTable.containsKey(id)) return currentSymTable.get(id);
		}
		return null;
	}
	
	/*
	 * Get level of the argument Id in the SymTable Stack
	 * @param: String id - the argument Id
	 * @return: int - the level in the SymTable Stack
	 */
	public int getLevel(String id) {
		Iterator<HashMap<String, SymTableEntry>> iterator = symTableStack.listIterator(0);
		int entryLevel = -1, level = symTableStack.size()-1;
		while (iterator.hasNext()) {
			HashMap<String, SymTableEntry> currentSymTable = iterator.next();
			if (currentSymTable.containsKey(id)) entryLevel = level;
			level--;
		}
		return entryLevel;
	}
		
	/*
	 * Check whether a value/function is global or not
	 * @param: String id - the value/function name
	 * @return: boolean - the boolean result
	 */
	public boolean isGlobal(String id) {
		if(!isDeclared(id)) return false;
		return getLevel(id) == 0;
	}
		
	/*
	 * Method that implements Uniqueness check, i.e. verifies whether a variable has already been declared in
	 * currentSymTable or not
	 * @param: String entryName - the name of the value whose uniqueness needs to be checked
	 * @return: boolean - true if the value is unique, false otherwise
	 */
	public boolean isLocallyDeclared(String entryName) {
		return this.peekSymTable().containsKey(entryName);
	}
	
	/*
	 * Method that implements Assignment Uniqueness check, i.e. verifies whether a variable has already been assigned
	 * @param: String entryName - the name of the value whose assignment uniqueness needs to be checked
	 * @return: boolean - true if the value has not been assigned yet, false otherwise
	 */
	public boolean isAssigned(String entryName) {
		return this.getEntry(entryName).getIsAssigned();
	}
	
	// Type funcType = SymTableStack.getEntry(funcName).getType();
		
	/* 
	 * Method that implements Declaration check, i.e. verifies whether a variable has been declared in the whole program,
	 * since LHC supports Static Lexical Scoping
	 * @param: String entryName - the name of the value whose declaration needs to be checked
	 * @return: boolean - true if the value has been already declared, false otherwise
	 */
	public boolean isDeclared(String entryName) {
		return this.containsEntry(entryName);
	}
		
	/*
	 * Debugging method that prints out the content of the whole symTableStack 
	 * @param: nothing
	 * @return: nothing
	 */
	public void dumpSymTableStack(){
		int level = symTableStack.size()-1;
		Iterator<HashMap<String, SymTableEntry>> iterator = symTableStack.listIterator(0);
		System.out.println("DEBUG: PRINTING SYMTABLESTACK!");
		while (iterator.hasNext()){
			System.out.println("Level " + level);
			iterator.next().forEach
				( (k, v) -> { 
					System.out.print("->");
					System.out.println(" Name: " + k + ", isAssigned: " + v.getIsAssigned());
					v.getType().dumpType(1);
				});
			level--;
		}
	}
		
	/* 
	 * Being the project not originally developed using an IDE, using JUnit is not the best option
	 * It would be ideal to move testing there (TODO)
	 */
	public void testSymTableStack() {
		SymTableStack symTableStack = new SymTableStack();
		symTableStack.pushSymTable();
		Type type = Type.getType("Int");
		symTableStack.putEntry("x", new SymTableEntry(type));
		symTableStack.putEntry("y", new SymTableEntry(type));
		if (symTableStack.containsEntry("x")) 
			System.out.println ("TEST SYMTABLE STACK 1: PASSED");
		else
			System.out.println ("TEST SYMTABLE STACK 1: FAILED");
		if (!symTableStack.containsEntry("xx")) 
			System.out.println ("TEST SYMTABLE STACK 2: PASSED");
		else
			System.out.println ("TEST SYMTABLE STACK 2: FAILED");
		if (symTableStack.getEntry("x") != null)
			System.out.println ("TEST SYMTABLE STACK 3: PASSED");
		else
			System.out.println ("TEST SYMTABLE STACK 3: FAILED");
		if (symTableStack.getEntry("xx") == null) 
			System.out.println ("TEST SYMTABLE STACK 4: PASSED");
		else
			System.out.println ("TEST SYMTABLE STACK 4: FAILED");
		boolean isPresent = symTableStack.getEntry("x").getIsAssigned();
		if (!isPresent)
			System.out.println ("TEST SYMTABLE STACK 5: PASSED");
		else
			System.out.println ("TEST SYMTABLE STACK 5: FAILED");
		symTableStack.pushSymTable();
		Type xTree = Type.getType("Double");
		symTableStack.putEntry("x", new SymTableEntry(xTree));
		SymTableEntry entry = symTableStack.getEntry("x");
		if (entry != null && entry.getType().isEquivalent("Double"))
			System.out.println ("TEST SYMTABLE STACK 6: PASSED");
		else
			System.out.println ("TEST SYMTABLE STACK 6: FAILED");
 		symTableStack.popSymTable();
	}

}