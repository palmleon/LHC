# INTERMEDIATE CODE GENERATION

## PRINCIPI:

- Il codice viene generato solo se non ci sono Compile Errors
- Ogni nodo dell'AST ha due elementi principali: un blocco di codice (Lista di Stringhe) e un metodo codegen()
- In generale, il metodo codegen() chiamerà ricorsivamente il metodo codegen() dei blocchi sottostanti per generare il loro codice. Inoltre:
	- il metodo ritorna la stringa contenete il valore o il registro ritornato dal blocco (se il metodo non ritorna valori, ritorna null)
	- il metodo deve tenere traccia dell'indice incrementale delle variabili senza nome
	- il metodo scrive su un blocco di stringhe su cui scrivere il codice

## WORKFLOW:
Per ogni insieme di istruzioni LLVM che vogliamo tradurre:
- Testare che l'istruzione sia compatibile con LLVM
- Implementare la costruzione dell'istruzione nel compilatore
- Usare del (semplice) codice di prova per verificare che la compilazione sia corretta

## CODEGEN E AST:

| Nodo             | Sottonodi                                                | codegen() - Pseudocodice                                     |
| ---------------- | -------------------------------------------------------- | ------------------------------------------------------------ |
| ProgramAST       | FunctPartAST functPart, ImperPartAST imperPart           | functPart.codegen()<br />imperPart.codegen()<br />mountCode(code, functPart.code)<br />mountCode(code, imperPart.code) |
| FunctPartAST     | LinkedList<StmtAST> stmts                                | foreach stmt in stmts:<br />stmt.codegen()<br />mountCode(code, stmt.code) |
| ImperPartAST     | IOActionAST ioAction                                     | createPrintfDeclaration<br />createMain("main", void)<br />openFunction()<br />ioAction.codegen()<br />mountCode(code, ioAction.code)<br />closeFunction() |
| PrintAST         | ExprAST actarg                                           | actargVar = actarg.codegen()<br />mountCode(code, actarg)<br />callPrintf(actarg.type, actargVar) |
| DoBlockAST       | LinkedList<DoStmtAST> ioActions                          | foreach ioAction in ioActions:<br />ioAction.codegen()<br />mountCode(code, ioAction) |
| IfBlockImperAST  | ExprAST cond, IOActionAST thenBody, IOActionAST elseBody | condIndex = cond.codegen(minIndex)<br />mountCode(code,cond.code)<br />createCondBranch(then_label, else_label)<br />createLabel(then_label)<br />thenBody.codegen()<br />mountCode(code,thenBody.code)<br />createBranch(exit_label)<br />createLabel(else_label)<br />elseBody.codegen()<br />mountCode(elseBody.code)<br />createBranch(exit_label)<br /> |
| LetBlockImperAST | LinkedList<StmtAST> letStmts                             | foreach stmt in letStmts:<br />stmt.codegen()<br />mountCode(code, stmt) |
| DeclTypeAST      |                                                          |                                                              |
| DefValueAST      | String id, ExprAST expr                                  | exprIndex = expr.codegen()<br />  mountCode(code, expr.code)<br />  idIndex = createAlloca(id, expr.type, expr.subexpressions.size)<br />  createStore(expr.type, idIndex, exprIndex) |
| DefFunctAST      | String id, LFormArgAST lformarg, ExprAST expr            | createFunctionDefinition(id, expr.type)<br /><br />lformarg.codegen()<br />mountCode(code, lformarg)<br />openFunction()<br />exprIndex = expr.codegen()<br />mountCode(code, expr)<br />createReturn(exprIndex, expr.type)<br />closeFunction() |
| ExprAST          | ExprKind exprKind, BasicExprAST[] subExprs               | switch (exprKind):<br />  PLUS: exprIndex = createAdd(expr.type, subExprs[0], subExprs[1])<br />  MINUS: exprIndex = createSub(expr.type, subExprs[0], subExprs[1])<br />  TIMES: exprIndex = createMul(expr.type, subExprs[0], subExprs[1])= <br />  DIV: exprIndex = createDiv(expr.type, subExprs[0], subExprs[1])<br />  INTDIV: exprIndex = createIntDiv(expr.type, subExprs[0], subExprs[1])<br />  MOD: exprIndex = createMod(expr.type, subExprs[0], subExprs[1])<br />  AND: exprIndex = createAnd(expr.type, subExprs[0], subExprs[1])<br />  OR:  exprIndex = createOr(expr.type, subExprs[0], subExprs[1])<br />  RELNOTEQ:  exprIndex = createRelNotEq(expr.type, subExprs[0], subExprs[1])<br />  RELEQ: exprIndex = createRelEq(expr.type, subExprs[0], subExprs[1])<br />  RELGE: exprIndex = createRelGe(expr.type, subExprs[0], subExprs[1])<br />  RELGT: exprIndex = createRelGt(expr.type, subExprs[0], subExprs[1])<br />  RELLE:  exprIndex = createRelLe(expr.type, subExprs[0], subExprs[1])<br />  RELLT: exprIndex = createRelLt(expr.type, subExprs[0], subExprs[1])<br />  LENGTH:  exprIndex = createLength(expr.type, subExprs[0])<br />  INDEX:  exprIndex = createIndex(expr.type, subExprs[0], subExprs[1])<br />  NOT:  exprIndex = createNot(expr.type, subExprs[0])<br />  UMINUS:  exprIndex = createUnaryMinus(expr.type, subExprs[0])<br />  LET_BLOCK_FUNC: exprIndex = subExprs[0].codegen()<br />  mountCode(code, subExprs[0].code)<br />  IF_BLOCK_FUNC: exprIndex = subExprs[0].codegen()<br />  mountCode(code, subExprs[0].code)<br />  FUNCT_CALL: exprIndex = subExprs[0].codegen()<br />  mountCode(code, subExprs[0].code)<br />  VALUE: exprIndex = subExprs[0].codegen()<br />  mountCode(code, subExprs[0].code)<br />  EXPR_LIST: exprIndex = subExprs[0].codegen()<br />  mountCode(code, subExprs[0].code)<br />return exprIndex |
| LetBlockFuncAST  | LinkedList<StmtAST> letStmts, ExprAST expr               | foreach stmt in letStmts:<br />  stmt.codegen()<br />  mountCode(code, stmt)<br />exprIndex = expr.codegen()<br />mountCode(code, expr)<br />return exprIndex |
| IfBlockFuncAST   | ExprAST cond, thenBody, elseBody                         | condIndex = cond.codegen(minIndex)<br />mountCode(code,cond.code)<br />createCondBranch(then_label, else_label)<br />createLabel(then_label)<br />thenIndex = thenBody.codegen()<br />mountCode(code,thenBody.code)<br />createBranch(exit_label)<br />createLabel(else_label)<br />elseIndex = elseBody.codegen()<br />mountCode(elseBody.code)<br />createBranch(exit_label)<br />resIndex = createPHInode(then_label, thenIndex, else_label, elseIndex)<br />return resIndex |
| FunctCallAST     | String id, LinkedList<ExprAST> actArgs                   | foreach actArg in actArgs:<br />  actargIndex = actArg.codegen()<br /><br />  actArgIndexList.add(actargIndex)<br /><br />  actArgTypeList.add(actArg.type)<br />  mountCode(code, actArg.code)<br />resIndex = createFunctionCall(id, this.type, actargIndexList, actargTypeList)<br />return resIndex |
| ValueAST         | Object value                                             | valueIndex = createValue(Type this.type, Object value)<br />return valueIndex |
| ExprListAST      | ArrayList<ExprAST> exprArray                             | foreach expr in exprArray:<br />  exprIndex = expr.codegen()<br />  mountCode(code, expr.code)<br />  indexList.add(exprIndex)<br />listIndex = createList(indexList, this.type)<br />return listIndex |
| LFormArgAST      | ArrayList<String> argList, ArrayList<Type> typeList      | foreach arg in argList:<br />  createFormArg(arg, arg.type)  |



## PROBLEMI:

#### IR-Language Independent

- Trasformare le Definizioni di Valore globali in Definizioni di Funzione per semplificare l'IR code generation OK

#### IR-Language Dependent

Gestire le Forward References 

- i Label devono essere stringhe di testo: assicurarsi che i label siano unici per ogni if-then-else: usare un ifCounter che viene incrementato ogni volta che un If-then-else deve essere generato

#### Altro:

- Come implementare le liste e le loro funzioni in LLVM?

  - Al momento, le liste possono essere trattate solo localmente, sono implementate come Vettori e non è possibile definire Funzioni che le ritornino
  - Implementare funzioni head, tail, size (per Liste), extract (per Tuple) nella symTable
