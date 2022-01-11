import java.util.HashMap;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.Stack;
import java.util.Iterator;

/* 
 * Class for the Type Tree
 * The following Class defines the Type structure
 */
	 
public class Type {
		
	/* unique name for the Type */
	private String typeName;
	/* list containing all the subtypes for an instance of a compound type 
	 *				(useful for functions, lists and any additional compound type) 
	 * better than an ArrayList because its size it's fixed */
	private Type[] typeParams;
	
	// Static TypeMap that contains all the declared Types (allows to define custom Data Types)
	private static HashMap<String, Type> typeMap = new HashMap<>();
		
	
	/* Basic Copy Constructor */
	Type(String typeName, Type[] typeParams) {
		this.typeName = typeName;
		this.typeParams = typeParams; // most types should have up to 2 type params
	}
	
	/* (Recursive) Copy Constructor */
	Type(Type type) {			
		int length = type.getTypeParams().length;
		this.typeName = type.getTypeName();
		this.typeParams = new Type[length];
		for (int i = 0; i < length; i++) {
			this.typeParams[i] = new Type(type.getTypeParams()[i]);
		}
	}
	
	/* Setter method for typeName */
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	
	/* Setter method for typeParams */
	public void setTypeParams(Type[] typeParams){
		this.typeParams = typeParams;
	}
	
	/* Setter method for the single child */
	public void setTypeParam(int pos, Type child) {
		this.typeParams[pos] = child;
	}
	
	/* Getter method for typeName */
	public String getTypeName(){
		return this.typeName;
	}
	
	/* Getter method for typeParams */
	public Type[] getTypeParams(){
		return this.typeParams;
	}
	
	/* Getter method for the single child */
	public Type getTypeParam(int pos) {
		return this.typeParams[pos];
	}

	/* 
	 * Method for Type Widening
	 * This Method is asymmetric: it takes the first type and tries to upcast it into the second one
	 * @param: String typeName1, typeName2 - the types to be compared
	 * Returns: The resulting widened type (null if widening is not possible) //TODO
	 */
	public static String widen(String typeName1, String typeName2) {
		String res = null;
		if (typeName1.equals(typeName2)) res = typeName1;
		else if (typeName1.equals("Int") && typeName2.equals("Double")) res = "Double";
		return res;
	}
	
	/* Method that checks Subtyping
	 * In Haskell, Type Hierarchy is not defined; instead, Hierarchy is represented by Typeclasses
	 * and their relationship.
	 * In this version of the Language, Typeclasses are not supported, so it is defined a simple
	 * Type Hierarchy where:
	 * - Any represents Type Variables (i.e. Java Generics)
	 * - Int is a subtype of Double
	 * The widen Method checks Subtyping for the single TreeNode
	 * @param: String other - the type to be compared with the calling one
	 * Returns: Boolean - true if other is Parent of this, false otherwise
	 */
	public boolean isSubtype(String other) {
		boolean isSubtype = true;
		if (other.equals("error")) return false;
		if (other.equals("Any")) return true;
		Type type = Type.getType(other);
		if (type == null) return false;
		if (Type.widen(this.getTypeName(), type.getTypeName()) == null) return false;
		if (this.getTypeParams().length != type.getTypeParams().length) return false;
		for (int i = 0; i < this.getTypeParams().length; i++) {
			isSubtype = isSubtype && this.getTypeParam(i).isSubtype(type.getTypeParam(i).getTypeName());
		}
		return isSubtype;
	}
	
	/* 
	 * Method for Type Equivalence Checking
	 * The isSubtype relationship is a Partial Ordering Relation, 
	 * Type Equivalence is equivalent to checking that 
	 * the first type is a subtype of the second one and viceversa.
	 * @param: String other - the type to compare with the calling one
	 * Returns: Boolean - true if the Trees are equivalent, false otherwise
	 */
	 
	public boolean isEquivalent(String other) {
		Type otherTree = Type.getType(other);
		if (otherTree == null) return false;
		return this.isSubtype(other) && otherTree.isSubtype(this.getTypeName());
	}
	
	/* 
	 * Additional Method for Type Equivalence Checking
	 * @param: Type other - the tree of the type to compare with the calling one
	 * Returns: Boolean - true if the Trees are equivalent, false otherwise
	 */
	public boolean isEquivalent(Type other) {
		return this.isEquivalent(other.getTypeName());
	}
		
	/*
	 * Method that returns the Return Type of a Function
	 * Checking that this Type is actually a Funcion is up to other Semantic Rules
	 * @param: nothing
	 * @return: Type - the Type of the @return Type
	 */
	public Type returnType() {
		Type rightTypeParam = this.getTypeParam(1);
		while(rightTypeParam.isSubtype("Function")) {
			rightTypeParam = rightTypeParam.getTypeParam(1);
		}
		return rightTypeParam;
	}
	
	/*
	 * Method that implements Arity check, i.e. verifies whether the function has the same arity of its actual arguments
	 * No check is performed on whether this type object actually holds a Function Type
	 * The method traverses the Function Tree, following the Function nodes until only Non-Function nodes are found
	 * @param:  int arity - the expected Arity of the function
	 * @return: boolean - true if the function has the same Arity, false otherwise
	 */
	public boolean hasArity(int arity) {
		int count = 1;
		Type rightTypeParam = this.getTypeParam(1);
		while(rightTypeParam.isSubtype("Function")) {
			count++;
			rightTypeParam = rightTypeParam.getTypeParam(1);
		}
		return count == arity;
	}
	
	/*
	 * Create TypeMap with the predefined available Types
	 * @param: nothing
	 * @return: nothing
	 */
	public static void createTypeMap() {
		// childType is used only for making the code slightly more readable
		Type type = new Type("Int", new Type[0]);
		Type.addType(type.getTypeName(), type);
		type = new Type("Double", new Type[0]);
		Type.addType(type.getTypeName(), type);
		type = new Type("Bool", new Type[0]);
		Type.addType(type.getTypeName(), type);
		type = new Type("Char", new Type[0]);
		Type.addType(type.getTypeName(), type);
		Type[] typeArray = { new Type(type) };
		type = new Type("List", typeArray);
		Type.addType("String", type);
		Type anyType = new Type("Any", new Type[0]); 
		typeArray = new Type[]{ new Type(anyType) };
		type = new Type("List", typeArray);
		Type.addType(type.getTypeName(), type);
		typeArray = new Type[]{ new Type(anyType), new Type(anyType) };
		type = new Type("Function", typeArray);
		Type.addType(type.getTypeName(), type);
		// special error type for propagating type checking errors
		type = new Type("error", new Type[0]);
		Type.addType(type.getTypeName(), type);
	}
	
	/* 
	 * Insert a new Type inside the typeMap (if already present, the new one is discarded and a Semantic Error should arise)
	* @param: String typeName - the name of the new Type
	 * 		   Type type - the corresponding type 
	 * @return: boolean - true if no error occured, false otherwise
	 */
	public static boolean addType(String typeName, Type type) {
	if (typeMap.containsKey(typeName)) return false;
		typeMap.put(typeName, type);
		return true;
	}
	
	/* 
	 * Check whether a certain type has been defined or not
	 * @param: String typeName - the type to look for
	 * @return: boolean - true if the type exists, false otherwise
	 */
	public static boolean typeExists(String typeName) {
		return typeMap.containsKey(typeName);
	}
	
	/* 
	 * Retrieve a clone of the Type of a specific type from the typeMap, if present
	 * @param: String typeName - the name of the Type
	 * @return: the corresponding typeTree if the Type exists, null otherwise
	 */
	public static Type getType(String typeName) {
		if (typeMap.containsKey(typeName))
			return new Type(typeMap.get(typeName));
		else return null;
	}
		
	/*
	 * Debugging method for dumping the whole TypeMap TODO
	 * @param: nothing
	 * Returns: nothing
	 */
	public static void dumpTypeMap(){
		System.out.println("DEBUG: PRINTING TYPEMAP!");
		typeMap.forEach
			( (k, v) -> {
				System.out.println("TopTypeName: " + k);
				v.dumpType(0);
			} );
	}
	
	/*
	 * Debugging method for dumping a single Type TODO
	 * @param: int level - defines the level inside the Type, used for hierarchical printing of the Tree
	 * Returns: nothing
	 */
	public void dumpType(int level){
		for (int i = 0; i < level; i++)
			System.out.print("\t");
		System.out.println("-> " + this.getTypeName());
		for (int i = 0; i < this.getTypeParams().length; i++) {
			this.getTypeParam(i).dumpType(level+1);
		}
	}

}