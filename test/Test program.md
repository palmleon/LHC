SEMANTIC ANALYSIS

## SymTableStack:

* Tutti i metodi :
  - public static boolean containsEntry(String id)		OK
  - public static SymTableEntry getEntry(String id)		OK
  - public static TypeTree getEntryTypeTree(String id) 		OK
  - public static Boolean getEntryAssignFlag(String id)		OK
  - public void dumpSymTableStack()				OK



- UNIT TESTING:
  - Utilizzare Equivalence Class Partitioning sulla singola Regola di Produzione
  - Se i test ottenuti non sono sufficienti, raggiungere Decision Coverage al 100% con test addizionali
- INTEGRATION TESTING:
  - Definire Programmi che lavorano con porzioni del linguaggio
- SYSTEM TESTING:
  - Definire Programmi generali che testano tutta la grammatica



## Semantic Rules:

| **Non terminal** | RHS of the Rule                                   | Programs where it is checked                                 |
| ---------------- | ------------------------------------------------- | ------------------------------------------------------------ |
| PROGRAM          | /* empty */                                       | _empty_program                                               |
|                  | indent FUNCT_PART IMPER_PART dedent               | _test_types, _test_imper_part, _test_expr, _test_funct,  _test_list, _test_list_2, _test_expr2, _test_expr3, _test_expr4, _test_list_char, _test_if_let, _test_list_types, _test_expr5 |
| IMPER_PART       | main eq IO_ACTION                                 | _test_types, _test_imper_part, _test_expr, _test_funct, _test_list, _test_list_2, _test_expr2, _test_expr3, _test_expr4, _test_list_char, _test_if_let, _test_list_types, _test_expr5 |
| IO_ACTION        | PRINT                                             | _test_types, _test_imper_part, _test_expr, _test_list, _test_list_2, _test_expr2, _test_expr3, _test_expr4, _test_list_char, _test_if_let, _test_list_types, _test_expr5 |
|                  | DO_BLOCK                                          | _test_imper_part, _test_funct, _test_list, _test_expr3, _test_if_let, _test_list_types, _test_expr5 |
|                  | IF_BLOCK_IMPER                                    | _test_imper_part, _test_expr, _test_funct, _test_expr2, _test_expr3 |
| IO_ACTIONS       | IO_ACTION                                         | _test_imper_part, _test_funct, _test_list, _test_list_2, _test_expr3, _test_if_let, _test_expr5 |
|                  | IO_ACTIONS sep IO_ACTION                          | _test_imper_part, _test_list, _test_expr5                    |
|                  | LET_BLOCK_IMPER                                   | _test_imper_part, _test_funct, _test_list, _test_expr3, _test_if_let, _test_list_types |
| PRINT            | print ACTARG                                      | _test_types, _test_imper_part, _test_expr, _test_list, _test_list_2, _test_expr2, _test_expr3, _test_expr4, _test_list_char, _test_if_let, _test_list_types, _test_expr5 |
| DO_BLOCK         | do_begin indent IO_ACTIONS dedent                 | _test_imper_part, _test_funct, _test_list, _test_expr3, _test_list_types, _test_expr5 |
| IF_BLOCK_IMPER   | if_begin COND then IO_ACTION else_begin IO_ACTION | _test_imper_part, _test_expr, _test_expr2, _test_expr3, _test_expr5 |
| LET_BLOCK_IMPER  | let indent LET_STMTS dedent IO_ACTION             | _test_imper_part, _test_funct, _test_list, _test_expr3, _test_if_let, _test_list_types, _test_list_types |
| LET_STMTS        | LET_STMTS sep DECL_TYPE                           | _test_imper_part, _test_funct, _test_expr4                   |
|                  | LET_STMTS sep DECL_VALUE                          | _test_imper_part, _test_funct, _test_list, _test_expr3, _test_expr4, _test_if_let, _test_list_types |
|                  | DECL_TYPE                                         | _test_imper_part, _test_funct, _test_list, _test_expr3, _test_expr4, _test_if_let, _test_list_types |
|                  | DECL_VALUE                                        | _test_imper_part, _test_funct, _test_expr4                   |
| FUNCT_PART       | /* empty */                                       | _test_imper_part, _test_types, _test_funct, _test_expr, _test_list, _test_list_2, _test_expr2, _test_expr3, _test_expr4, _test_list_char, _test_if_let, _test_list_types, _test_expr5 |
|                  | FUNCT_PART DECL sep                               | _test_types, _test_funct, _test_expr, _test_list, _test_list_2, _test_expr2, _test_expr3, _test_expr4, _test_list_char, _test_if_let, _test_list_types, _test_expr5 |
| COND             | EXPR                                              | _test_imper_part, _test_funct, _test_expr, _test_list_2, _test_expr2, _test_expr3, _test_if_let |
| DECL             | DECL_TYPE                                         | _test_types, _test_expr, _test_funct, _test_imper_part, _test_list, _test_list_2, _test_expr2, _test_expr3, _test_expr4, _test_list_char, _test_list_types, _test_expr5 |
|                  | DECL_VALUE                                        | _test_types, _test_imper_part, _test_expr, _test_funct, _test_list, _test_list_2, _test_expr2, _test_expr3, _test_expr4, _test_list_char, _test_if_let, _test_list_types, _test_expr5 |
|                  | DECL_FUNCT                                        | _test_funct, _test_list, _test_list_2, _test_expr2, _test_expr5 |
| DECL_TYPE        | id cm DECL_TYPE                                   | _test_types, _test_expr2, _test_expr3, _test_expr5           |
|                  | id clns TYPE                                      | _test_types, _test_imper_part, _test_expr, _test_funct, _test_list, _test_list_2, _test_expr2, _test_expr3, _test_list_char, _test_if_let, _test_list_types, _test_expr5 |
| DECL_VALUE       | id eq EXPR                                        | _test_types, _test_expr, _test_list, _test_list_2, _test_expr2, _test_expr3, _test_expr4, _test_list_char, _test_if_let, _test_list_types, _test_expr5 |
| DECL_FUNCT       | id LFORMARG eq EXPR                               | _test_funct, _test_list, _test_list_2, _test_expr2, _test_expr5 |
| LFORMARG         | LFORMARG id                                       | _test_funct, _test_list, _test_list_2                        |
|                  | id                                                | _test_funct, _test_list, _test_list_2, _test_expr2, _test_expr5 |
| EXPR             | EXPR plus EXPR                                    | _test_expr, _test_list, _test_if_let                         |
|                  | EXPR minus EXPR                                   | _test_expr, _test_expr2                                      |
|                  | EXPR times EXPR                                   | _test_expr, _test_list                                       |
|                  | EXPR div EXPR                                     | _test_expr, _test_expr2                                      |
|                  | EXPR intdiv EXPR                                  | _test_expr, _test_expr3                                      |
|                  | mod ACTARG ACTARG                                 | _test_expr, _test_expr3                                      |
|                  | EXPR and EXPR                                     | _test_expr, _test_expr2                                      |
|                  | EXPR or EXPR                                      | _test_expr, _test_expr3, _test_expr5                         |
|                  | EXPR releq EXPR                                   | _test_expr, _test_list_2                                     |
|                  | EXPR relnoteq EXPR                                | _test_expr3, _test_expr5                                     |
|                  | EXPR relgt EXPR                                   | _test_expr, _test_expr3                                      |
|                  | EXPR relge EXPR                                   | _test_expr, _test_expr2                                      |
|                  | EXPR rellt EXPR                                   | _test_expr, _test_funct, _test_list_2, _test_expr2           |
|                  | EXPR relle EXPR                                   | _test_expr, _test_expr5                                      |
|                  | elem ACTARG                                       | _test_funct, _test_list_2                                    |
|                  | EXPR index EXPR                                   | _test_funct, _test_list, _test_list_2, _test_list_char       |
|                  | ro EXPR rc                                        | _test_expr, _test_expr4, _test_expr5                         |
|                  | not EXPR                                          | _test_expr, _test_expr4, _test_expr5                         |
|                  | minus EXPR                                        | _test_expr, _test_expr4, _test_expr5                         |
|                  | LET_BLOCK_FUNC                                    | _test_funct, _test_expr4, _test_expr5                        |
|                  | IF_BLOCK_FUNC                                     | _test_expr, _test_list_2, _test_expr2, _test_expr5           |
|                  | id LACTARG                                        | _test_funct, _test_list, _test_list_2, _test_expr , _test_expr2, _test_expr3, _test_expr4, _test_expr5, _test_if_let, _test_imper_part, _test_list_char, _test_list_types, _test_types |
|                  | VALUE                                             | _test_types; _test_imper_part, _test_funct, _test_expr, _test_list, _test_list_2, _test_expr2, _test_expr4, _test_list_char, _test_list_types, _test_expr5 |
|                  | VALUE_LIST                                        | _test_list, _test_list_2, _test_list_char, _test_if_let, _test_if_let, _test_list_types |
| LET_BLOCK_FUNC   | let indent LET_STMTS indent in EXPR               | _test_funct, _test_expr4, _test_if_let, _test_expr5          |
| IF_BLOCK_FUNC    | if_begin COND then EXPR else_begin EXPR           | _test_expr, _test_funct, _test_list_2, _test_expr2, _test_if_let, _test_expr5 |
| ACTARG           | id                                                | _test_funct, _test_list, _test_list_2, _test_expr , _test_expr2, _test_expr3, _test_expr4, _test_expr5, _test_if_let, _test_imper_part, _test_list_char, _test_list_types, _test_types |
|                  | VALUE                                             | _test_funct, _test_list, _test_list_2                        |
|                  | ro EXPR rc                                        | _test_funct, _test_list                                      |
| LACTARG          | /* empty */                                       | _test_funct, _test_list, _test_list_2, _test_expr , _test_expr2, _test_expr3, _test_expr4, _test_expr5, _test_if_let, _test_imper_part, _test_list_char, _test_list_types, _test_types |
|                  | LACTARG ACTARG                                    | _test_funct, _test_list, _test_list_2, _test_expr , _test_expr2, _test_expr3, _test_expr4, _test_expr5, _test_if_let, _test_imper_part, _test_list_char, _test_list_types, _test_types |
| VALUE            | VALUE_BASIC                                       | _test_types, _test_expr, _test_funct, _test_list, _test_list_2, _test_expr2, _test_expr3, _test_expr4, _test_if_let, _test_list_types, _test_expr5 |
| VALUE_BASIC      | val_int                                           | _test_types, _test_imper_part, _test_expr, _test_funct, _test_list, _test_list_2, _test_expr3, _test_expr4, _test_list_char, _test_if_let, _test_list_types |
|                  | val_double                                        | _test_imper_part, _test_expr, _test_expr2, _test_expr3, _test_expr4, _test_list_types, _test_expr5 |
|                  | val_bool                                          | _test_imper_part, _test_list_2, _test_expr2, _test_expr3, _test_expr4, _test_list_types, _test_expr5 |
|                  | val_char                                          | _test_funct, _test_list_char, _test_list_types               |
|                  | val_string                                        | _test_funct, _test_list, _test_expr2, _test_expr3, _test_list_char, _test_list_types |
| VALUE_LIST       | bo LEXPR bc                                       | _test_list, _test_list_2, _test_if_let, _test_list_types     |
| LEXPR            | EXPR                                              | _test_list, _test_list_2, _test_if_let, _test_list_types     |
|                  | LEXPR cm EXPR                                     | _test_list, _test_list_2, _test_if_let, _test_list_types     |
| TYPE             | TYPE_VALUE                                        | _test_types, _test_imper_part, _test_funct, _test_expr, _test_list, _test_list_2, _test_expr2, _test_expr3, _test_expr4, _test_list_char, _test_if_let, _test_list_types, _test_expr5 |
|                  | TYPE_FUNC                                         | _test_types, _test_funct, _test_list, _test_list_2, _test_expr2, _test_expr5 |
| TYPE_VALUE       | TYPE_LIST                                         | _test_types, _test_funct, _test_list_2, _test_list_char, _test_if_let, _test_list_types |
|                  | TYPE_BASIC                                        | _test_types, _test_imper_part, _test_expr, _test_funct, _test_list, _test_list_2, _test_expr2, _test_expr3, _test_expr4, _test_if_let, _test_list_types, _test_expr5 |
| TYPE_BASIC       | type_int                                          | _test_types, _test_imper_part, _test_expr, _test_funct, _test_list, _test_list_2, _test_expr3, _test_expr4, _test_if_let, _test_list_types |
|                  | type_double                                       | _test_types, _test_imper_part, _test_expr2, _test_expr3, _test_expr4, _test_list_types, _test_expr5 |
|                  | type_bool                                         | _test_types, _test_funct, _test_list_2, _test_expr2, _test_expr3, _test_expr4, _test_list_char, _test_if_let, _test_list_types, _test_expr5 |
|                  | type_char                                         | _test_types, _test_funct, _test_list_char, _test_list_types  |
| TYPE_LIST        | bo TYPE_BASIC bc                                  | _test_types, _test_list, _test_list_2, _test_list_char, _test_if_let, _test_list_types |
|                  | type_string                                       | _test_types, _test_funct, _test_list, _test_list_types       |
| TYPE_FUNC        | TYPE_VALUE arrow TYPE_FUNC                        | _test_types, _test_funct, _test_list, _test_list_2, _test_expr5 |
|                  | TYPE_VALUE arrow TYPE_VALUE                       | _test_types, _test_funct, _test_list, _test_list_2, _test_expr2 |

## UNIT TESTING:

The singol Unit to be tested correspond to a Production Rule.
Unit Testing can regard either the Grammar or the Semantic of the Rule.

#### PROGRAM ::= indent FUNCT_PART IMPER_PART dedent

| Condition           | Value |
| ------------------- | ----- |
| FUNCT_PART compiles | True  |
|                     | False |
| IMPER_PART compiles | True  |
|                     | False |

| FUNCT_PART compiles | IMPER_PART compiles | Valid/Invalid | Test case                          | Program                            |
| ------------------- | ------------------- | ------------- | ---------------------------------- | ---------------------------------- |
| T                   | T                   | Valid         | Any compiling program              | Any program in the /success folder |
| F                   | *                   | Invalid       | a<br />main = print "Hello, world" | _fail_grammar_imper_part_1         |
| *                   | F                   | Invalid       | main                               | _fail_grammar_imper_part_2         |

#### IMPER_PART = main eq IO_ACTION

| Condition          | Value |
| ------------------ | ----- |
| IO_ACTION compiles | True  |
|                    | False |

| IO_ACTION compiles | Valid/Invalid | Test case             | Program                            |
| ------------------ | ------------- | --------------------- | ---------------------------------- |
| T                  | Valid         | Any compiling program | Any program in the /success folder |
| F                  | Invalid       | main = print jkl      | _fail_grammar_imper_part_3         |

#### IO_ACTION ::= PRINT

| Condition      | Value |
| -------------- | ----- |
| PRINT compiles | True  |
|                | False |

| PRINT compiles | Valid/Invalid | Test case             | Program                            |
| -------------- | ------------- | --------------------- | ---------------------------------- |
| T              | Valid         | Any compiling program | Any program in the /success folder |
| F              | Invalid       | main = print jkl      | _fail_grammar_imper_part_3         |

#### IO_ACTION ::= DO_BLOCK

| Condition         | Value |
| ----------------- | ----- |
| DO_BLOCK compiles | True  |
|                   | False |

| DO_BLOCK compiles | Valid/Invalid | Test case             | Program                            |
| ----------------- | ------------- | --------------------- | ---------------------------------- |
| T                 | Valid         | Any compiling program | Any program in the /success folder |
| F                 | Invalid       | main = do             | _fail_grammar_imper_part_4         |

#### IO_ACTION ::= IF_BLOCK_IMPER

| Condition               | Value |
| ----------------------- | ----- |
| IF_BLOCK_IMPER compiles | True  |
|                         | False |

| IF_BLOCK_IMPER compiles | Valid/Invalid | Test case             | Program                            |
| ----------------------- | ------------- | --------------------- | ---------------------------------- |
| T                       | Valid         | Any compiling program | Any program in the /success folder |
| F                       | Invalid       | main = if             | _fail_grammar_imper_part_5         |

#### IO_ACTIONS ::= IO_ACTION

| Condition          | Value |
| ------------------ | ----- |
| IO_ACTION compiles | True  |
|                    | False |

| IO_ACTION compiles | Valid/Invalid | Test case                       | Program                            |
| ------------------ | ------------- | ------------------------------- | ---------------------------------- |
| T                  | Valid         | Any compiling program           | Any program in the /success folder |
| F                  | Invalid       | main = do<br />              if | _fail_grammar_io_actions           |

#### IO_ACTIONS ::= IO_ACTIONS sep IO_ACTION

| Condition           | Value |
| ------------------- | ----- |
| IO_ACTIONS compiles | True  |
|                     | False |
| IO_ACTION compiles  | True  |
|                     | False |

| IO_ACTIONS compiles | IO_ACTION compiles | Valid/Invalid | Test case                                                    | Program                            |
| ------------------- | ------------------ | ------------- | ------------------------------------------------------------ | ---------------------------------- |
| T                   | T                  | Valid         | Any compiling program                                        | Any program in the /success folder |
| *                   | F                  | Invalid       | main = do<br />             print "Hello"<br />             if | _fail_grammar_io_actions_2         |
| F                   | *                  | Invalid       | /* cannot happen */                                          |                                    |

#### IO_ACTIONS ::= LET_BLOCK_IMPER

| Condition                | Value |
| ------------------------ | ----- |
| LET_BLOCK_IMPER compiles | True  |
|                          | False |

| LET_BLOCK_IMPER compiles | Valid/Invalid | Test case                        | Program                            |
| ------------------------ | ------------- | -------------------------------- | ---------------------------------- |
| T                        | Valid         | Any compiling program            | Any program in the /success folder |
| F                        | Invalid       | main = do<br />              let | _fail_grammar_io_actions_3         |

#### PRINT ::= print ACTARG

| Condition                | Value |
| ------------------------ | ----- |
| ACTARG compiles          | True  |
|                          | False |
| ACTARG is of Type Double | True  |
|                          | False |
| ACTARG is of Type Int    | True  |
|                          | False |
| ACTARG is of Type String | True  |
|                          | False |
| ACTARG is of Type Bool   | True  |
|                          | False |

| ACTARG compiles | ACTARG is Double | ACTARG is Int | ACTARG is String | ACTARG is Bool | Valid/Invalid | Test case                  | Program                    |
| --------------- | ---------------- | ------------- | ---------------- | -------------- | ------------- | -------------------------- | -------------------------- |
| F               | *                | *             | *                | *              | Invalid       | main = print jkl           | _fail_grammar_imper_part_3 |
| T               | T                | F             | F                | F              | Valid         | main = [...] print 6.0     | _test_imper_part           |
| /               | F                | T             | F                | F              | Valid         | main = [...] print 4       | _test_imper_part           |
| /               | F                | F             | T                | F              | Valid         | main = [...] print True    | _test_imper_part           |
| /               | F                | F             | F                | T              | Valid         | main = [...] print "hello" | _test_imper_part           |
| /               | F                | F             | F                | F              | Invalid       | main = print 'c'           | _fail_sem_print            |

#### DO_BLOCK ::= do_begin indent IO_ACTIONS dedent

| Condition               | Value |
| ----------------------- | ----- |
| IO_ACTIONS compiles     | True  |
|                         | False |
| Indentation is followed | True  |
|                         | False |

| IO_ACTIONS compiles | Indentation is followed | Valid/Invalid | Test case                                       | Program                                            |
| ------------------- | ----------------------- | ------------- | ----------------------------------------------- | -------------------------------------------------- |
| T                   | T                       | Valid         | Any compiling program                           | Any program in the /success folder with a do block |
| F                   | *                       | Invalid       | main = do<br />              let                | _fail_grammar_io_actions_3                         |
| *                   | F                       | Invalid       | main = do<br />print "hello"<br />print "hello" | _fail_grammar_do_block                             |

#### IF_BLOCK_IMPER ::= if_begin COND then IO_ACTION else_begin IO_ACTION

| Condition            | Value |
| -------------------- | ----- |
| COND compiles        | True  |
|                      | False |
| IO_ACTION_1 compiles | True  |
|                      | False |
| IO_ACTION_2 compiles | True  |
|                      | False |
| COND is boolean      | True  |
|                      | False |

| COND compiles | IO_ACTION_1 compiles | IO_ACTION_2 compiles | COND is Bool | Valid/Invalid | Test case                                            | Program                        |
| ------------- | -------------------- | -------------------- | ------------ | ------------- | ---------------------------------------------------- | ------------------------------ |
| F             | *                    | *                    | *            | Invalid       | main = if true then print "hello" else print "hello" | _fail_grammar_if_block_imper_1 |
| *             | F                    | *                    | *            | Invalid       | main = if True then print jil else print "hello"     | _fail_grammar_if_block_imper_2 |
| *             | *                    | F                    | *            | Invalid       | main = if True then print "hello" else print jil     | _fail_grammar_if_block_imper_3 |
| *             | *                    | *                    | F            | Invalid       | main = if 1 then print "hello" else print "hello"    | _fail_grammar_if_block_imper_4 |
| T             | T                    | T                    | T            | Valid         | main = if True then print "hello" else print "hello" | _succ_if_block_imper           |

#### LET_BLOCK_IMPER ::= let indent LET_STMTS dedent IO_ACTION

| Condition               | Value |
| ----------------------- | ----- |
| LET_STMTS compiles      | True  |
|                         | False |
| IO_ACTION compiles      | True  |
|                         | False |
| Indentation is followed | True  |
|                         | False |

| LET_STMTS compiles | IO_ACTION compiles | Indentation is followed | Valid/Invalid | Test case                                                    | Program                         |
| ------------------ | ------------------ | ----------------------- | ------------- | ------------------------------------------------------------ | ------------------------------- |
| F                  | *                  | *                       | Invalid       | main = do <br/>       let x<br/>       print "hello"         | _fail_grammar_let_block_imper_1 |
| *                  | F                  | *                       | Invalid       | main = do<br/>       let x :: Int<br/>       print jkl       | _fail_grammar_let_block_imper_2 |
| *                  | *                  | F                       | Invalid       | main = do<br/>       let x :: Int<br/>          x = 1<br/>       print x | _fail_grammar_let_block_imper_2 |
| T                  | T                  | T                       | Valid         | main = do<br/>       let x :: Int<br/>           x = 1<br/>       print "hello" | _succ_let_block_imper           |
