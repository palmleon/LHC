# SEMANTIC ANALYSIS

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
|                  | EXPR rem EXPR                                     | _test_expr, _test_expr3                                      |
|                  | EXPR and EXPR                                     | _test_expr, _test_expr2                                      |
|                  | EXPR or EXPR                                      | _test_expr, _test_expr3, _test_expr5                         |
|                  | EXPR releq EXPR                                   | _test_expr, _test_list_2                                     |
|                  | EXPR relnoteq EXPR                                | _test_expr3, _test_expr5                                     |
|                  | EXPR relgt EXPR                                   | _test_expr, _test_expr3                                      |
|                  | EXPR relge EXPR                                   | _test_expr, _test_expr2                                      |
|                  | EXPR rellt EXPR                                   | _test_expr, _test_funct, _test_list_2, _test_expr2           |
|                  | EXPR relle EXPR                                   | _test_expr, _test_expr5                                      |
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

#### IO_ACTIONS ::= IO_ACTIONS sep LET_BLOCK_IMPER

| Condition                | Value |
| ------------------------ | ----- |
| IO_ACTIONS compiles      | True  |
|                          | False |
| LET_BLOCK_IMPER compiles | True  |
|                          | False |

| IO_ACTIONS compiles | LET_BLOCK_IMPER compiles | Valid/Invalid | Test case                                                    | Program                            |
| ------------------- | ------------------------ | ------------- | ------------------------------------------------------------ | ---------------------------------- |
| T                   | T                        | Valid         | Any compiling program                                        | Any program in the /success folder |
| *                   | F                        | Invalid       | main = do<br />             print "Hello"<br />             let | _fail_grammar_io_actions_3         |
| F                   | *                        | Invalid       | /* cannot happen */                                          |                                    |

#### IO_ACTIONS ::= LET_BLOCK_IMPER

| Condition                | Value |
| ------------------------ | ----- |
| LET_BLOCK_IMPER compiles | True  |
|                          | False |

| LET_BLOCK_IMPER compiles | Valid/Invalid | Test case                        | Program                            |
| ------------------------ | ------------- | -------------------------------- | ---------------------------------- |
| T                        | Valid         | Any compiling program            | Any program in the /success folder |
| F                        | Invalid       | main = do<br />              let | _fail_grammar_io_actions_2         |

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

| ACTARG compiles | ACTARG is Double | ACTARG is Int | ACTARG is String | ACTARG is Bool | Valid/Invalid | Test case            | Program                    |
| --------------- | ---------------- | ------------- | ---------------- | -------------- | ------------- | -------------------- | -------------------------- |
| F               | *                | *             | *                | *              | Invalid       | main = print jkl     | _fail_grammar_imper_part_3 |
| T               | T                | F             | F                | F              | Valid         | main = print 6.0     | _succ_print_1              |
| /               | F                | T             | F                | F              | Valid         | main = print 4       | _succ_print_2              |
| /               | F                | F             | T                | F              | Valid         | main = print True    | _succ_print_3              |
| /               | F                | F             | F                | T              | Valid         | main = print "hello" | _succ_print_4              |
| /               | F                | F             | F                | F              | Invalid       | main = print 'c'     | _fail_sem_print            |

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

#### LET_BLOCK_IMPER ::= let indent LET_STMTS dedent

| Condition               | Value |
| ----------------------- | ----- |
| LET_STMTS compiles      | True  |
|                         | False |
| Indentation is followed | True  |
|                         | False |

| LET_STMTS compiles | Indentation is followed | Valid/Invalid | Test case                                                    | Program                         |
| ------------------ | ----------------------- | ------------- | ------------------------------------------------------------ | ------------------------------- |
| F                  | *                       | Invalid       | main = do <br/>       let x<br/>       print "hello"         | _fail_grammar_let_block_imper_1 |
| *                  | F                       | Invalid       | main = do<br/>       let x :: Int<br/>          x = 1<br/>       print x | _fail_grammar_let_block_imper_3 |
| T                  | T                       | Valid         | main = do<br/>       let x :: Int<br/>           x = 1<br/>       print "hello" | _succ_let_block_imper           |

#### LET_STMTS ::= LET_STMTS sep DECL_TYPE

| Condition          | Value |
| ------------------ | ----- |
| LET_STMTS compiles | True  |
|                    | False |
| DECL_TYPE compiles | True  |
|                    | False |

| LET_STMTS compiles | DECL_TYPE compiles | Valid/Invalid | Test case                                                    | Program                   |
| ------------------ | ------------------ | ------------- | ------------------------------------------------------------ | ------------------------- |
| F                  | *                  | Invalid       | main = do<br/>       let x; y :: Int<br/>       print "hello" | _fail_grammar_let_stmts_1 |
| *                  | F                  | Invalid       | main = do<br/>       let x :: Int; y :: <br/>       print "hello" | _fail_grammar_let_stmts_2 |
| T                  | T                  | Valid         | main = do<br/>       let x :: Int; y :: Int<br/>       print "hello" | _succ_let_stmts_1         |

#### LET_STMTS ::= LET_STMTS sep DECL_VALUE

| Condition           | Value |
| ------------------- | ----- |
| LET_STMTS compiles  | True  |
|                     | False |
| DECL_VALUE compiles | True  |
|                     | False |

| LET_STMTS compiles | DECL_VALUE compiles | Valid/Invalid | Test case                                                    | Program                   |
| ------------------ | ------------------- | ------------- | ------------------------------------------------------------ | ------------------------- |
| F                  | *                   | Invalid       | main = do<br/>       let x; x = 3<br/>       print "hello"   | _fail_grammar_let_stmts_3 |
| *                  | F                   | Invalid       | main = do<br/>       let x :: Int; x = lkj<br/>       print "hello" | _fail_grammar_let_stmts_4 |
| T                  | T                   | Valid         | main = do<br/>       let x :: Int; x = 3<br/>       print "hello" | _succ_let_stmts_2         |

#### LET_STMTS ::= DECL_TYPE

| Condition                                                    | Value |
| ------------------------------------------------------------ | ----- |
| DECL_TYPE compiles                                           | True  |
|                                                              | False |
| DECL_TYPE contains a Function Declaration with List Return Type | True  |
|                                                              | False |

| DECL_TYPE compiles | DECL_TYPE contains a Function Declaration with List Return Type | Valid/Invalid | Test case                                                    | Program                   |
| ------------------ | ------------------------------------------------------------ | ------------- | ------------------------------------------------------------ | ------------------------- |
| F                  | *                                                            | Invalid       | main = do<br/>       let x :: In<br/>       print "hello"    | _fail_grammar_let_stmts_5 |
| *                  | F                                                            | Invalid       | main = do<br/>       let x :: Int -> [Int]<br/>       print "hello" | _fail_sem_let_stmts_1     |
| T                  | T                                                            | Valid         | main = do<br/>       let x :: Int<br/>       print "hello"   | _succ_let_stmts_3         |

#### LET_STMTS ::= DECL_VALUE

| Condition           | Value |
| ------------------- | ----- |
| DECL_VALUE compiles | True  |
|                     | False |

| DECL_VALUE compiles | Valid/Invalid | Test case                                                    | Program                   |
| ------------------- | ------------- | ------------------------------------------------------------ | ------------------------- |
| F                   | Invalid       | main = do<br/>       let x = <br/>       print "hello"       | _fail_grammar_let_stmts_6 |
| T                   | Valid         | main = do<br/>       let x :: Int<br/>       x = 3<br/>       print "hello" | _succ_let_stmts_4         |

#### FUNCT_PART ::= /* empty */

| Condition               | Value |
| ----------------------- | ----- |
| No statement on the RHS | True  |

| No statement on the RHS | Valid/Invalid | Test case            | Program            |
| ----------------------- | ------------- | -------------------- | ------------------ |
| T                       | Valid         | main = print "hello" | _succ_funct_part_1 |

#### FUNCT_PART ::= FUNCT_PART DECL sep

| Condition           | Value |
| ------------------- | ----- |
| FUNCT_PART compiles | True  |
|                     | False |
| DECL compiles       | True  |
|                     | False |

| FUNCT_PART compiles | DECL compiles | Valid/Invalid | Test case                                 | Program                    |
| ------------------- | ------------- | ------------- | ----------------------------------------- | -------------------------- |
| F                   | *             | Invalid       | x<br/>x :: Int<br/>main = print "hello"   | _fail_grammar_funct_part_1 |
| *                   | F             | Invalid       | x :: Int<br/>x =<br/>main = print "hello" | _fail_grammar_funct_part_2 |
| T                   | T             | Valid         | x :: Int<br/>x = 3<br/>main = print x     | _succ_funct_part_2         |

#### COND ::= EXPR

| Condition            | Value |
| -------------------- | ----- |
| EXPR compiles        | True  |
|                      | False |
| EXPR is of type Bool | True  |
|                      | False |

| EXPR compiles | EXPR is of type Bool | Valid/Invalid | Test case                                                    | Program              |
| ------------- | -------------------- | ------------- | ------------------------------------------------------------ | -------------------- |
| F             | *                    | Invalid       | x :: Int<br/>x = if 'a then 1 else 2<br/>main = print "hello" | _fail_grammar_cond_1 |
| *             | F                    | Invalid       | x :: Int<br/>x = if 3 then 1 else 2<br/>main = print "hello" | _fail_sem_cond_1     |
| T             | T                    | Valid         | x :: Int<br/>x = if True then 1 else 2<br/>main = print "hello" | _succ_cond_1         |

#### DECL ::= DECL_TYPE

| Condition                                | Value |
| ---------------------------------------- | ----- |
| DECL_TYPE compiles                       | True  |
|                                          | False |
| DECL_TYPE does not declare a Global List | True  |
|                                          | False |

| DECL_TYPE compiles | DECL_TYPE does not declare a Global List | Valid/Invalid | Test case                           | Program              |
| ------------------ | ---------------------------------------- | ------------- | ----------------------------------- | -------------------- |
| F                  | *                                        | Invalid       | x :: <br/>main = print "hello"      | _fail_grammar_decl_1 |
| *                  | F                                        | Invalid       | x :: [Int]<br/>main = print "hello" | _fail_sem_decl_1     |
| T                  | T                                        | Valid         | x :: Int<br/>main = print "hello"   | _succ_decl_1         |

#### DECL ::= DECL_VALUE

| Condition           | Value |
| ------------------- | ----- |
| DECL_VALUE compiles | True  |
|                     | False |

| DECL_VALUE compiles | Valid/Invalid | Test case                                   | Program              |
| ------------------- | ------------- | ------------------------------------------- | -------------------- |
| F                   | Invalid       | x :: Int<br/>x = <br/>main = print "hello"  | _fail_grammar_decl_2 |
| T                   | Valid         | x :: Int<br/>x = 3<br/>main = print "hello" | _succ_decl_2         |

#### DECL ::= DECL_FUNCT

| Condition           | Value |
| ------------------- | ----- |
| DECL_FUNCT compiles | True  |
|                     | False |

| DECL_FUNCT compiles | Valid/Invalid | Test case                                            | Program              |
| ------------------- | ------------- | ---------------------------------------------------- | -------------------- |
| F                   | Invalid       | x :: Int -> Int<br/>x y = print<br/>main = print x   | _fail_grammar_decl_3 |
| T                   | Valid         | x :: Int -> Int<br/>x y = y<br/>main = print "hello" | _succ_decl_3         |

#### DECL_TYPE ::= id cm DECL_TYPE

| Condition                                                    | Value |
| ------------------------------------------------------------ | ----- |
| DECL_TYPE compiles                                           | True  |
|                                                              | False |
| id is unique                                                 | True  |
|                                                              | False |
| DECL_TYPE is not a Function declaration with List as a Return Type | True  |
|                                                              | False |

| DECL_TYPE compiles | id is unique | DECL_TYPE is not a Function declaration with List as a Return Type | Valid/Invalid | Test case                                               | Program                   |
| ------------------ | ------------ | ------------------------------------------------------------ | ------------- | ------------------------------------------------------- | ------------------------- |
| F                  | *            | *                                                            | Invalid       | x, y ::<br/>main = print "hello"                        | _fail_grammar_decl_type_1 |
| *                  | F            | *                                                            | Invalid       | x, x :: Int<br/>main = print "hello"                    | _fail_sem_decl_type_1     |
| *                  | *            | F                                                            | Invalid       | x, y :: Int -> [Int]<br/>main = print "hello"           | _fail_sem_decl_type_2     |
| T                  | T            | T                                                            | Valid         | x, y :: Int -> Int<br/>x z = z<br/>main = print "hello" | _succ_decl_type_1         |

#### DECL_TYPE ::= id clns TYPE

| Condition                                                    | Value |
| ------------------------------------------------------------ | ----- |
| TYPE compiles                                                | True  |
|                                                              | False |
| id is unique                                                 | True  |
|                                                              | False |
| DECL_TYPE is not a Function declaration with List as a Return Type | True  |
|                                                              | False |

| DECL_TYPE compiles | id is unique | DECL_TYPE is not a Function declaration with List as a Return Type | Valid/Invalid | Test case                                         | Program                   |
| ------------------ | ------------ | ------------------------------------------------------------ | ------------- | ------------------------------------------------- | ------------------------- |
| F                  | *            | *                                                            | Invalid       | x ::<br/>main = print "hello"                     | _fail_grammar_decl_type_2 |
| *                  | F            | *                                                            | Invalid       | x :: Int<br/>x :: Double<br/>main = print "hello" | _fail_sem_decl_type_3     |
| *                  | *            | F                                                            | Invalid       | x :: Int -> [Int]<br/>main = print "hello"        | _fail_sem_decl_type_4     |
| T                  | T            | T                                                            | Valid         | x :: Bool<br/>main = print "hello"                | _succ_decl_type_2         |

#### DECL_VALUE ::= id eq EXPR

| Condition                             | Value |
| ------------------------------------- | ----- |
| EXPR compiles                         | True  |
|                                       | False |
| id is declared                        | True  |
|                                       | False |
| id is locally declared                | True  |
|                                       | False |
| id is not assigned                    | True  |
|                                       | False |
| EXPR is of the same type as of the id | True  |
|                                       | False |

| EXPR compiles | id is declared | id is locally declared | id is not assigned | EXPR is of the same type as of the id | Valid/Invalid | Test case                                                    | Program                    |
| ------------- | -------------- | ---------------------- | ------------------ | ------------------------------------- | ------------- | ------------------------------------------------------------ | -------------------------- |
| F             | *              | *                      | *                  | *                                     | Invalid       | x :: Int<br/>x = jal<br/>main = print "hello"                | _fail_grammar_decl_value_1 |
| T             | F              | *                      | *                  | *                                     | Invalid       | x = 3<br/>main = print "hello"                               | _fail_sem_decl_value_1     |
| T             | T              | F                      | *                  | *                                     | Invalid       | x, y :: Int<br/>y = let x = 3 in 4<br/>main = print "hello"  | _fail_sem_decl_value_2     |
| T             | T              | T                      | F                  | *                                     | Invalid       | x :: Int<br/>x = 3<br/>x = 4<br/>main = print "hello"        | _fail_sem_decl_value_3     |
| T             | T              | T                      | T                  | F                                     | Invalid       | x :: Int<br/>x = 4.5<br/>main = print "hello"                | __fail_sem_decl_value_4    |
| T             | T              | T                      | T                  | T                                     | Valid         | x :: Int<br/>x = let y :: Int; y = 3 in y<br/>main = print x | _succ_decl_value_1         |

#### DECL_FUNCT ::= id LFORMARG eq EXPR

| Condition                                            | Value |
| ---------------------------------------------------- | ----- |
| LFORMARG compiles                                    | True  |
|                                                      | False |
| EXPR compiles                                        | True  |
|                                                      | False |
| id is declared                                       | True  |
|                                                      | False |
| id is locally declared                               | True  |
|                                                      | False |
| id is a Function                                     | True  |
|                                                      | False |
| id has the same arity as the #formal arguments       | True  |
|                                                      | False |
| id is not assigned                                   | True  |
|                                                      | False |
| EXPR is of the same type as of the Return Type of id | True  |
|                                                      | False |

| LFORMARG compiles | EXPR compiles | id is declared | id is locally declared | id is a Function | id has the same arity as the #formal arguments | id is not assigned | EXPR is of the same type as of the Return Type of id | Valid/Invalid | Test case                                                    | Program                    |
| ----------------- | ------------- | -------------- | ---------------------- | ---------------- | ---------------------------------------------- | ------------------ | ---------------------------------------------------- | ------------- | ------------------------------------------------------------ | -------------------------- |
| F                 | *             | *              | *                      | *                | *                                              | *                  | *                                                    | Invalid       | x :: Int -> Int<br/>x Int = 3<br/>main = print "hello"       | _fail_grammar_decl_funct_1 |
| T                 | F             | *              | *                      | *                | *                                              | *                  | *                                                    | Invalid       | x :: Int -> Int<br/>x y = print x<br/>main = print "hello"   | _fail_grammar_decl_funct_2 |
| T                 | T             | F              | *                      | *                | *                                              | *                  | *                                                    | Invalid       | x y = y<br/>main = print "hello"                             | _fail_sem_decl_funct_1     |
| T                 | T             | T              | F                      | *                | *                                              | *                  | *                                                    | Invalid       | x :: Int -> Int<br/>y :: Int<br/>y = let x r = r in x 3<br/>main = print "hello" | _fail_sem_decl_funct_2     |
| T                 | T             | T              | T                      | F                | *                                              | *                  | *                                                    | Invalid       | x :: Int<br/>x y = 3<br/>main = print "hello"                | _fail_sem_decl_funct_3     |
| T                 | T             | T              | T                      | T                | F                                              | *                  | *                                                    | Invalid       | x' :: Int -> Int -> Int<br/>x' y = y<br/>main = print "hello" | _fail_sem_decl_funct_4     |
| T                 | T             | T              | T                      | T                | T                                              | F                  | *                                                    | Invalid       | x :: String -> Int<br/>x y = 3<br/>x z = 4<br/>main = print "hello" | _fail_sem_decl_funct_5     |
| T                 | T             | T              | T                      | T                | T                                              | T                  | F                                                    | Invalid       | x :: String -> Int<br/>x y = 'c'<br/>main = print "hello"    | _fail_sem_decl_funct_6     |
| T                 | T             | T              | T                      | T                | T                                              | T                  | T                                                    | Valid         | x :: Char -> Char -> Char<br/>x y = y<br/>main = print "hello" | _succ_decl_funct_1         |

#### LFORMARG ::= LFORMARG id

| Condition                  | Value |
| -------------------------- | ----- |
| LFORMARG compiles          | True  |
|                            | False |
| id is not locally declared | True  |
|                            | False |

| LFORMARG compiles | id is not locally declared | Valid/Invalid | Test case                                                    | Program                  |
| ----------------- | -------------------------- | ------------- | ------------------------------------------------------------ | ------------------------ |
| F                 | *                          | Invalid       | x :: Int -> Int<br/>x Int = 3<br/>main = print "hello"       | _fail_grammar_lformarg_1 |
| T                 | F                          | Invalid       | x :: Bool -> Bool -> Bool<br/>x y y = True<br/>main = print "hello" | _fail_sem_lformarg_1     |
| T                 | T                          | Valid         | x' :: Char -> Char -> Char -> Char<br/>x' y' z = 'a'<br/>main = print "hello" | _succ_lformarg_1         |

#### LFORMARG ::= id

| Condition                  | Value |
| -------------------------- | ----- |
| id is not locally declared | True  |

| LFORMARG compiles | Valid/Invalid | Test case                                                    | Program          |
| ----------------- | ------------- | ------------------------------------------------------------ | ---------------- |
| T                 | Valid         | f' :: String -> Char<br/>f' x = 'a'<br/>main = print "hello" | _succ_lformarg_2 |

#### EXPR ::= EXPR plus EXPR

| Condition                              | Value |
| -------------------------------------- | ----- |
| EXPR_1 compiles                        | True  |
|                                        | False |
| EXPR_2 compiles                        | True  |
|                                        | False |
| EXPR_1 is of Type Double or Int        | True  |
|                                        | False |
| EXPR_2 is of Type Double or Int        | True  |
|                                        | False |
| EXPR_1 and EXPR_2 are of the same Type | True  |
|                                        | False |

| EXPR_1 compiles | EXPR_2 compiles | EXPR_1 is of Type Double or Int | EXPR_2 is of Type Double or Int | EXPR_1 and EXPR_2 are of the same Type | Valid/Invalid | Test case                                              | Program                   |
| --------------- | --------------- | ------------------------------- | ------------------------------- | -------------------------------------- | ------------- | ------------------------------------------------------ | ------------------------- |
| F               | *               | *                               | *                               | *                                      | Invalid       | x :: Int<br/>x = jl + 4<br/>main = print "hello"       | _fail_grammar_expr_plus_1 |
| T               | F               | *                               | *                               | *                                      | Invalid       | x :: Int<br/>x = 4 + jl<br/>main = print "hello"       | _fail_grammar_expr_plus_2 |
| T               | T               | F                               | *                               | *                                      | Invalid       | x :: Int<br/>x = "hello" + 4<br/>main = print "hello"  | _fail_grammar_expr_plus_3 |
| T               | T               | T                               | F                               | *                                      | Invalid       | x :: Int<br/>x = 4 + "hello"<br/>main = print "hello"  | _fail_grammar_expr_plus_4 |
| T               | T               | T                               | T                               | F                                      | Invalid       | x :: Double<br/>x = 4 + 3.5<br/>main = print "hello"   | _fail_grammar_expr_plus_5 |
| T               | T               | T                               | T                               | T                                      | Valid         | x :: Double<br/>x = 4.0 + 3.5<br/>main = print "hello" | _succ_expr_plus_1         |

#### EXPR ::= EXPR minus EXPR

| Condition                              | Value |
| -------------------------------------- | ----- |
| EXPR_1 compiles                        | True  |
|                                        | False |
| EXPR_2 compiles                        | True  |
|                                        | False |
| EXPR_1 is of Type Double or Int        | True  |
|                                        | False |
| EXPR_2 is of Type Double or Int        | True  |
|                                        | False |
| EXPR_1 and EXPR_2 are of the same Type | True  |
|                                        | False |

| EXPR_1 compiles | EXPR_2 compiles | EXPR_1 is of Type Double or Int | EXPR_2 is of Type Double or Int | EXPR_1 and EXPR_2 are of the same Type | Valid/Invalid | Test case                                              | Program                    |
| --------------- | --------------- | ------------------------------- | ------------------------------- | -------------------------------------- | ------------- | ------------------------------------------------------ | -------------------------- |
| F               | *               | *                               | *                               | *                                      | Invalid       | x :: Int<br/>x = jl - 4<br/>main = print "hello"       | _fail_grammar_expr_minus_1 |
| T               | F               | *                               | *                               | *                                      | Invalid       | x :: Int<br/>x = 4 - jl<br/>main = print "hello"       | _fail_grammar_expr_minus_2 |
| T               | T               | F                               | *                               | *                                      | Invalid       | x :: Int<br/>x = "hello" - 4<br/>main = print "hello"  | _fail_sem_expr_minus_1     |
| T               | T               | T                               | F                               | *                                      | Invalid       | x :: Int<br/>x = 4 - "hello"<br/>main = print "hello"  | _fail_sem_expr_minus_2     |
| T               | T               | T                               | T                               | F                                      | Invalid       | x :: Double<br/>x = 4 - 3.5<br/>main = print "hello"   | _fail_sem_expr_minus_3     |
| T               | T               | T                               | T                               | T                                      | Valid         | x :: Double<br/>x = 4.0 - 3.5<br/>main = print "hello" | _succ_expr_minus_1         |

#### EXPR ::= EXPR times EXPR

| Condition                              | Value |
| -------------------------------------- | ----- |
| EXPR_1 compiles                        | True  |
|                                        | False |
| EXPR_2 compiles                        | True  |
|                                        | False |
| EXPR_1 is of Type Double or Int        | True  |
|                                        | False |
| EXPR_2 is of Type Double or Int        | True  |
|                                        | False |
| EXPR_1 and EXPR_2 are of the same Type | True  |
|                                        | False |

| EXPR_1 compiles | EXPR_2 compiles | EXPR_1 is of Type Double or Int | EXPR_2 is of Type Double or Int | EXPR_1 and EXPR_2 are of the same Type | Valid/Invalid | Test case                                              | Program                    |
| --------------- | --------------- | ------------------------------- | ------------------------------- | -------------------------------------- | ------------- | ------------------------------------------------------ | -------------------------- |
| F               | *               | *                               | *                               | *                                      | Invalid       | x :: Int<br/>x = jl * 4<br/>main = print "hello"       | _fail_grammar_expr_times_1 |
| T               | F               | *                               | *                               | *                                      | Invalid       | x :: Int<br/>x = 4 * jl<br/>main = print "hello"       | _fail_grammar_expr_times_2 |
| T               | T               | F                               | *                               | *                                      | Invalid       | x :: Int<br/>x = "hello" * 4<br/>main = print "hello"  | _fail_sem_expr_times_1     |
| T               | T               | T                               | F                               | *                                      | Invalid       | x :: Int<br/>x = 4 * "hello"<br/>main = print "hello"  | _fail_sem_expr_times_2     |
| T               | T               | T                               | T                               | F                                      | Invalid       | x :: Double<br/>x = 4 * 3.5<br/>main = print "hello"   | _fail_sem_expr_times_3     |
| T               | T               | T                               | T                               | T                                      | Valid         | x :: Double<br/>x = 4.0 * 3.5<br/>main = print "hello" | _succ_expr_times_1         |

#### EXPR ::= EXPR div EXPR

| Condition                              | Value |
| -------------------------------------- | ----- |
| EXPR_1 compiles                        | True  |
|                                        | False |
| EXPR_2 compiles                        | True  |
|                                        | False |
| EXPR_1 is of Type Double or Int        | True  |
|                                        | False |
| EXPR_2 is of Type Double or Int        | True  |
|                                        | False |
| EXPR_1 and EXPR_2 are of the same Type | True  |
|                                        | False |

| EXPR_1 compiles | EXPR_2 compiles | EXPR_1 is of Type Double or Int | EXPR_2 is of Type Double or Int | EXPR_1 and EXPR_2 are of the same Type | Valid/Invalid | Test case                                              | Program                  |
| --------------- | --------------- | ------------------------------- | ------------------------------- | -------------------------------------- | ------------- | ------------------------------------------------------ | ------------------------ |
| F               | *               | *                               | *                               | *                                      | Invalid       | x :: Int<br/>x = jl / 4<br/>main = print "hello"       | _fail_grammar_expr_div_1 |
| T               | F               | *                               | *                               | *                                      | Invalid       | x :: Int<br/>x = 4 / jl<br/>main = print "hello"       | _fail_grammar_expr_div_2 |
| T               | T               | F                               | *                               | *                                      | Invalid       | x :: Int<br/>x = "hello" / 4<br/>main = print "hello"  | _fail_sem_expr_div_1     |
| T               | T               | T                               | F                               | *                                      | Invalid       | x :: Int<br/>x = 4 / "hello"<br/>main = print "hello"  | _fail_sem_expr_div_2     |
| T               | T               | T                               | T                               | F                                      | Invalid       | x :: Double<br/>x = 4 / 3.5<br/>main = print "hello"   | _fail_sem_expr_div_3     |
| T               | T               | T                               | T                               | T                                      | Valid         | x :: Double<br/>x = 4.0 / 3.5<br/>main = print "hello" | _succ_expr_div_1         |

#### EXPR ::= EXPR intdiv EXPR

| Condition             | Value |
| --------------------- | ----- |
| EXPR_1 compiles       | True  |
|                       | False |
| EXPR_2 compiles       | True  |
|                       | False |
| EXPR_1 is of Type Int | True  |
|                       | False |
| EXPR_2 is of Type Int | True  |
|                       | False |

| EXPR_1 compiles | EXPR_2 compiles | EXPR_1 is of Type Int | EXPR_2 is of Type Int | Valid/Invalid | Test case                                               | Program                     |
| --------------- | --------------- | --------------------- | --------------------- | ------------- | ------------------------------------------------------- | --------------------------- |
| F               | *               | *                     | *                     | Invalid       | x :: Int<br/>x = jl div 4<br/>main = print "hello"      | _fail_grammar_expr_intdiv_1 |
| T               | F               | *                     | *                     | Invalid       | x :: Int<br/>x = 4 div jl<br/>main = print "hello"      | _fail_grammar_expr_intdiv_2 |
| T               | T               | F                     | *                     | Invalid       | x :: Int<br/>x = "hello" div 4<br/>main = print "hello" | _fail_sem_expr_intdiv_1     |
| T               | T               | T                     | F                     | Invalid       | x :: Int<br/>x = 4 div "hello"<br/>main = print "hello" | _fail_sem_expr_intdiv_2     |
| T               | T               | T                     | T                     | Valid         | x :: Int <br/>x = 4 div 3<br/>main = print "hello"      | _succ_expr_intdiv_1         |

#### EXPR ::= EXPR rem EXPR

| Condition             | Value |
| --------------------- | ----- |
| EXPR_1 compiles       | True  |
|                       | False |
| EXPR_2 compiles       | True  |
|                       | False |
| EXPR_1 is of Type Int | True  |
|                       | False |
| EXPR_2 is of Type Int | True  |
|                       | False |

| EXPR_1 compiles | EXPR_2 compiles | EXPR_1 is of Type Int | EXPR_2 is of Type Int | Valid/Invalid | Test case                                               | Program                  |
| --------------- | --------------- | --------------------- | --------------------- | ------------- | ------------------------------------------------------- | ------------------------ |
| F               | *               | *                     | *                     | Invalid       | x :: Int<br/>x = jl rem 4<br/>main = print "hello"      | _fail_grammar_expr_rem_1 |
| T               | F               | *                     | *                     | Invalid       | x :: Int<br/>x = 4 rem jl<br/>main = print "hello"      | _fail_grammar_expr_rem_2 |
| T               | T               | F                     | *                     | Invalid       | x :: Int<br/>x = "hello" rem 4<br/>main = print "hello" | _fail_sem_expr_rem_1     |
| T               | T               | T                     | F                     | Invalid       | x :: Int<br/>x = 4 rem "hello"<br/>main = print "hello" | _fail_sem_expr_rem_2     |
| T               | T               | T                     | T                     | Valid         | x :: Int <br/>x =4 rem 3<br/>main = print "hello"       | _succ_expr_rem_1         |

#### EXPR ::= EXPR and EXPR

| Condition              | Value |
| ---------------------- | ----- |
| EXPR_1 compiles        | True  |
|                        | False |
| EXPR_2 compiles        | True  |
|                        | False |
| EXPR_1 is of Type Bool | True  |
|                        | False |
| EXPR_2 is of Type Bool | True  |
|                        | False |

| EXPR_1 compiles | EXPR_2 compiles | EXPR_1 is of Type Bool | EXPR_2 is of Type Bool | Valid/Invalid | Test case                                                | Program                  |
| --------------- | --------------- | ---------------------- | ---------------------- | ------------- | -------------------------------------------------------- | ------------------------ |
| F               | *               | *                      | *                      | Invalid       | x :: Bool<br/>x = jl && True<br/>main = print "hello"    | _fail_grammar_expr_and_1 |
| T               | F               | *                      | *                      | Invalid       | x :: Bool<br/>x = True && jl<br/>main = print "hello"    | _fail_grammar_expr_and_2 |
| T               | T               | F                      | *                      | Invalid       | x :: Bool<br/>x = 4 && True<br/>main = print "hello"     | _fail_sem_expr_and_1     |
| T               | T               | T                      | F                      | Invalid       | x :: Bool<br/>x = True && 4<br/>main = print "hello"     | _fail_sem_expr_and_2     |
| T               | T               | T                      | T                      | Valid         | x :: Bool<br/>x = True && False<br/>main = print "hello" | _succ_expr_and_1         |

#### EXPR ::= EXPR or EXPR

| Condition              | Value |
| ---------------------- | ----- |
| EXPR_1 compiles        | True  |
|                        | False |
| EXPR_2 compiles        | True  |
|                        | False |
| EXPR_1 is of Type Bool | True  |
|                        | False |
| EXPR_2 is of Type Bool | True  |
|                        | False |

| EXPR_1 compiles | EXPR_2 compiles | EXPR_1 is of Type Bool | EXPR_2 is of Type Bool | Valid/Invalid | Test case                                                  | Program                 |
| --------------- | --------------- | ---------------------- | ---------------------- | ------------- | ---------------------------------------------------------- | ----------------------- |
| F               | *               | *                      | *                      | Invalid       | x :: Bool<br/>x = jl \|\| True<br/>main = print "hello"    | _fail_grammar_expr_or_1 |
| T               | F               | *                      | *                      | Invalid       | x :: Bool<br/>x = True \|\| jl<br/>main = print "hello"    | _fail_grammar_expr_or_2 |
| T               | T               | F                      | *                      | Invalid       | x :: Bool<br/>x = 4 \|\| True<br/>main = print "hello"     | _fail_sem_expr_or_1     |
| T               | T               | T                      | F                      | Invalid       | x :: Bool<br/>x = True \|\| 4<br/>main = print "hello"     | _fail_sem_expr_or_2     |
| T               | T               | T                      | T                      | Valid         | x :: Bool<br/>x = True \|\| False<br/>main = print "hello" | _succ_expr_or_1         |

#### EXPR ::= EXPR relnoteq EXPR

| Condition                              | Value |
| -------------------------------------- | ----- |
| EXPR_1 compiles                        | True  |
|                                        | False |
| EXPR_2 compiles                        | True  |
|                                        | False |
| EXPR_1 is of Type Double, Int or Char  | True  |
|                                        | False |
| EXPR_2 is of Type Double, Int or Char  | True  |
|                                        | False |
| EXPR_1 and EXPR_2 are of the same Type | True  |
|                                        | False |

| EXPR_1 compiles | EXPR_2 compiles | EXPR_1 is of Type Double, Int or Char | EXPR_2 is of Type Double, Int or Char | EXPR_1 and EXPR_2 are of the same Type | Valid/Invalid | Test case                                               | Program                       |
| --------------- | --------------- | ------------------------------------- | ------------------------------------- | -------------------------------------- | ------------- | ------------------------------------------------------- | ----------------------------- |
| F               | *               | *                                     | *                                     | *                                      | Invalid       | x :: Bool<br/>x = jl /= 3<br/>main = print "hello"      | _fail_grammar_expr_relnoteq_1 |
| T               | F               | *                                     | *                                     | *                                      | Invalid       | x :: Bool<br/>x = 3 /= jl<br/>main = print "hello"      | _fail_grammar_expr_relnoteq_2 |
| T               | T               | F                                     | *                                     | *                                      | Invalid       | x :: Bool<br/>x = "hello" /= 3<br/>main = print "hello" | _fail_sem_expr_relnoteq_1     |
| T               | T               | T                                     | F                                     | *                                      | Invalid       | x :: Bool<br/>x = 3 /= "hello"<br/>main = print "hello" | _fail_sem_expr_relnoteq_2     |
| T               | T               | T                                     | T                                     | F                                      | Invalid       | x :: Bool<br/>x = 3 /= 'c'<br/>main = print "hello"     | _fail_sem_expr_relnoteq_3     |
| T               | T               | T                                     | T                                     | T                                      | Valid         | x :: Bool<br/>x = 3 /= 4<br/>main = print "hello"       | _succ_expr_relnoteq_1         |
| T               | T               | T                                     | T                                     | T                                      | Valid         | x :: Bool<br/>x = 3.0 /= 4.0<br/>main = print "hello"   | _succ_expr_relnoteq_2         |
| T               | T               | T                                     | T                                     | T                                      | Valid         | x :: Bool<br/>x = 3 /= 4<br/>main = print "hello"   | _succ_expr_relnoteq_3         |

#### EXPR ::= EXPR releq EXPR

| Condition                              | Value |
| -------------------------------------- | ----- |
| EXPR_1 compiles                        | True  |
|                                        | False |
| EXPR_2 compiles                        | True  |
|                                        | False |
| EXPR_1 is of Type Double, Int or Char  | True  |
|                                        | False |
| EXPR_2 is of Type Double, Int or Char  | True  |
|                                        | False |
| EXPR_1 and EXPR_2 are of the same Type | True  |
|                                        | False |

| EXPR_1 compiles | EXPR_2 compiles | EXPR_1 is of Type Double, Int or Char | EXPR_2 is of Type Double, Int or Char | EXPR_1 and EXPR_2 are of the same Type | Valid/Invalid | Test case                                               | Program                    |
| --------------- | --------------- | ------------------------------------- | ------------------------------------- | -------------------------------------- | ------------- | ------------------------------------------------------- | -------------------------- |
| F               | *               | *                                     | *                                     | *                                      | Invalid       | x :: Bool<br/>x = jl == 3<br/>main = print "hello"      | _fail_grammar_expr_releq_1 |
| T               | F               | *                                     | *                                     | *                                      | Invalid       | x :: Bool<br/>x = 3 == jl<br/>main = print "hello"      | _fail_grammar_expr_releq_2 |
| T               | T               | F                                     | *                                     | *                                      | Invalid       | x :: Bool<br/>x = "hello" == 3<br/>main = print "hello" | _fail_sem_expr_releq_1     |
| T               | T               | T                                     | F                                     | *                                      | Invalid       | x :: Bool<br/>x = 3 == "hello"<br/>main = print "hello" | _fail_sem_expr_releq_2     |
| T               | T               | T                                     | T                                     | F                                      | Invalid       | x :: Bool<br/>x = 3 == 'c'<br/>main = print "hello"     | _fail_sem_expr_releq_3     |
| T               | T               | T                                     | T                                     | T                                      | Valid         | x :: Bool<br/>x = 3 == 4<br/>main = print "hello"       | _succ_expr_releq_1         |
| T               | T               | T                                     | T                                     | T                                      | Valid         | x :: Bool<br/>x = 3.0 == 4.0<br/>main = print "hello"   | _succ_expr_releq_2         |
| T               | T               | T                                     | T                                     | T                                      | Valid         | x :: Bool<br/>x = 3 == 4<br/>main = print "hello"   | _succ_expr_releq_3         |

#### EXPR ::= EXPR relgt EXPR

| Condition                              | Value |
| -------------------------------------- | ----- |
| EXPR_1 compiles                        | True  |
|                                        | False |
| EXPR_2 compiles                        | True  |
|                                        | False |
| EXPR_1 is of Type Double, Int or Char  | True  |
|                                        | False |
| EXPR_2 is of Type Double, Int or Char  | True  |
|                                        | False |
| EXPR_1 and EXPR_2 are of the same Type | True  |
|                                        | False |

| EXPR_1 compiles | EXPR_2 compiles | EXPR_1 is of Type Double, Int or Char | EXPR_2 is of Type Double, Int or Char | EXPR_1 and EXPR_2 are of the same Type | Valid/Invalid | Test case                                              | Program                    |
| --------------- | --------------- | ------------------------------------- | ------------------------------------- | -------------------------------------- | ------------- | ------------------------------------------------------ | -------------------------- |
| F               | *               | *                                     | *                                     | *                                      | Invalid       | x :: Bool<br/>x = jl > 3<br/>main = print "hello"      | _fail_grammar_expr_relgt_1 |
| T               | F               | *                                     | *                                     | *                                      | Invalid       | x :: Bool<br/>x = 3 > jl<br/>main = print "hello"      | _fail_grammar_expr_relgt_2 |
| T               | T               | F                                     | *                                     | *                                      | Invalid       | x :: Bool<br/>x = "hello" > 3<br/>main = print "hello" | _fail_sem_expr_relgt_1     |
| T               | T               | T                                     | F                                     | *                                      | Invalid       | x :: Bool<br/>x = 3 > "hello"<br/>main = print "hello" | _fail_sem_expr_relgt_2     |
| T               | T               | T                                     | T                                     | F                                      | Invalid       | x :: Bool<br/>x = 3 >  'c'<br/>main = print "hello"    | _fail_sem_expr_relgt_3     |
| T               | T               | T                                     | T                                     | T                                      | Valid         | x :: Bool<br/>x = 3  > 4<br/>main = print "hello"      | _succ_expr_relgt_1         |
| T               | T               | T                                     | T                                     | T                                      | Valid         | x :: Bool<br/>x = 3.0 > 4.0<br/>main = print "hello"   | _succ_expr_relgt_2         |
| T               | T               | T                                     | T                                     | T                                      | Valid         | x :: Bool<br/>x = 3 > 4<br/>main = print "hello"   | _succ_expr_relgt_3         |

#### EXPR ::= EXPR relge EXPR

| Condition                              | Value |
| -------------------------------------- | ----- |
| EXPR_1 compiles                        | True  |
|                                        | False |
| EXPR_2 compiles                        | True  |
|                                        | False |
| EXPR_1 is of Type Double, Int or Char  | True  |
|                                        | False |
| EXPR_2 is of Type Double, Int or Char  | True  |
|                                        | False |
| EXPR_1 and EXPR_2 are of the same Type | True  |
|                                        | False |

| EXPR_1 compiles | EXPR_2 compiles | EXPR_1 is of Type Double, Int or Char | EXPR_2 is of Type Double, Int or Char | EXPR_1 and EXPR_2 are of the same Type | Valid/Invalid | Test case                                               | Program                    |
| --------------- | --------------- | ------------------------------------- | ------------------------------------- | -------------------------------------- | ------------- | ------------------------------------------------------- | -------------------------- |
| F               | *               | *                                     | *                                     | *                                      | Invalid       | x :: Bool<br/>x = jl >= 3<br/>main = print "hello"      | _fail_grammar_expr_relge_1 |
| T               | F               | *                                     | *                                     | *                                      | Invalid       | x :: Bool<br/>x = 3 >= jl<br/>main = print "hello"      | _fail_grammar_expr_relge_2 |
| T               | T               | F                                     | *                                     | *                                      | Invalid       | x :: Bool<br/>x = "hello" >= 3<br/>main = print "hello" | _fail_sem_expr_relge_1     |
| T               | T               | T                                     | F                                     | *                                      | Invalid       | x :: Bool<br/>x = 3 >= "hello"<br/>main = print "hello" | _fail_sem_expr_relge_2     |
| T               | T               | T                                     | T                                     | F                                      | Invalid       | x :: Bool<br/>x = 3 >=  'c'<br/>main = print "hello"    | _fail_sem_expr_relge_3     |
| T               | T               | T                                     | T                                     | T                                      | Valid         | x :: Bool<br/>x = 3  >= 4<br/>main = print "hello"      | _succ_expr_relge_1         |
| T               | T               | T                                     | T                                     | T                                      | Valid         | x :: Bool<br/>x = 3.0 >= 4.0<br/>main = print "hello"   | _succ_expr_relge_2         |
| T               | T               | T                                     | T                                     | T                                      | Valid         | x :: Bool<br/>x = 3 >= 4<br/>main = print "hello"   | _succ_expr_relge_3         |

#### EXPR ::= EXPR rellt EXPR

| Condition                              | Value |
| -------------------------------------- | ----- |
| EXPR_1 compiles                        | True  |
|                                        | False |
| EXPR_2 compiles                        | True  |
|                                        | False |
| EXPR_1 is of Type Double, Int or Char  | True  |
|                                        | False |
| EXPR_2 is of Type Double, Int or Char  | True  |
|                                        | False |
| EXPR_1 and EXPR_2 are of the same Type | True  |
|                                        | False |

| EXPR_1 compiles | EXPR_2 compiles | EXPR_1 is of Type Double, Int or Char | EXPR_2 is of Type Double, Int or Char | EXPR_1 and EXPR_2 are of the same Type | Valid/Invalid | Test case                                              | Program                    |
| --------------- | --------------- | ------------------------------------- | ------------------------------------- | -------------------------------------- | ------------- | ------------------------------------------------------ | -------------------------- |
| F               | *               | *                                     | *                                     | *                                      | Invalid       | x :: Bool<br/>x = jl < 3<br/>main = print "hello"      | _fail_grammar_expr_rellt_1 |
| T               | F               | *                                     | *                                     | *                                      | Invalid       | x :: Bool<br/>x = 3 < jl<br/>main = print "hello"      | _fail_grammar_expr_rellt_2 |
| T               | T               | F                                     | *                                     | *                                      | Invalid       | x :: Bool<br/>x = "hello" < 3<br/>main = print "hello" | _fail_sem_expr_rellt_1     |
| T               | T               | T                                     | F                                     | *                                      | Invalid       | x :: Bool<br/>x = 3 < "hello"<br/>main = print "hello" | _fail_sem_expr_rellt_2     |
| T               | T               | T                                     | T                                     | F                                      | Invalid       | x :: Bool<br/>x = 3 <  'c'<br/>main = print "hello"    | _fail_sem_expr_rellt_3     |
| T               | T               | T                                     | T                                     | T                                      | Valid         | x :: Bool<br/>x = 3  < 4<br/>main = print "hello"      | _succ_expr_rellt_1         |
| T               | T               | T                                     | T                                     | T                                      | Valid         | x :: Bool<br/>x = 3.0 < 4.0<br/>main = print "hello"   | _succ_expr_rellt_2         |
| T               | T               | T                                     | T                                     | T                                      | Valid         | x :: Bool<br/>x = 3 < 4<br/>main = print "hello"   | _succ_expr_rellt_3         |

#### EXPR ::= EXPR relle EXPR

| Condition                              | Value |
| -------------------------------------- | ----- |
| EXPR_1 compiles                        | True  |
|                                        | False |
| EXPR_2 compiles                        | True  |
|                                        | False |
| EXPR_1 is of Type Double, Int or Char  | True  |
|                                        | False |
| EXPR_2 is of Type Double, Int or Char  | True  |
|                                        | False |
| EXPR_1 and EXPR_2 are of the same Type | True  |
|                                        | False |

| EXPR_1 compiles | EXPR_2 compiles | EXPR_1 is of Type Double, Int or Char | EXPR_2 is of Type Double, Int or Char | EXPR_1 and EXPR_2 are of the same Type | Valid/Invalid | Test case                                               | Program                    |
| --------------- | --------------- | ------------------------------------- | ------------------------------------- | -------------------------------------- | ------------- | ------------------------------------------------------- | -------------------------- |
| F               | *               | *                                     | *                                     | *                                      | Invalid       | x :: Bool<br/>x = jl <= 3<br/>main = print "hello"      | _fail_grammar_expr_relle_1 |
| T               | F               | *                                     | *                                     | *                                      | Invalid       | x :: Bool<br/>x = 3 <= jl<br/>main = print "hello"      | _fail_grammar_expr_relle_2 |
| T               | T               | F                                     | *                                     | *                                      | Invalid       | x :: Bool<br/>x = "hello" <= 3<br/>main = print "hello" | _fail_sem_expr_relle_1     |
| T               | T               | T                                     | F                                     | *                                      | Invalid       | x :: Bool<br/>x = 3 <= "hello"<br/>main = print "hello" | _fail_sem_expr_relle_2     |
| T               | T               | T                                     | T                                     | F                                      | Invalid       | x :: Bool<br/>x = 3 <=  'c'<br/>main = print "hello"    | _fail_sem_expr_relle_3     |
| T               | T               | T                                     | T                                     | T                                      | Valid         | x :: Bool<br/>x = 3  <= 4<br/>main = print "hello"      | _succ_expr_relle_1         |
| T               | T               | T                                     | T                                     | T                                      | Valid         | x :: Bool<br/>x = 3.0 <= 4.0<br/>main = print "hello"   | _succ_expr_relle_2         |
| T               | T               | T                                     | T                                     | T                                      | Valid         | x :: Bool<br/>x = 3 <= 4<br/>main = print "hello"   | _succ_expr_relle_3         |

#### EXPR ::= elem ACTARG

| Condition              | Value |
| ---------------------- | ----- |
| ACTARG compiles        | True  |
|                        | False |
| ACTARG is of List Type | True  |
|                        | False |

| ACTARG compiles | ACTARG is of List Type | Valid/Invalid | Test case                                              | Program                   |
| --------------- | ---------------------- | ------------- | ------------------------------------------------------ | ------------------------- |
| F               | *                      | Invalid       | x :: Int<br/>x = elem []<br/>main = print "hello"      | _fail_grammar_expr_elem_1 |
| T               | F                      | Invalid       | x :: Int<br/>x = elem 3<br/>main = print "hello"       | _fail_sem_expr_elem_1     |
| T               | T                      | Valid         | x :: Int<br/>x = elem [1,2,3]<br/>main = print "hello" | _succ_expr_elem_1         |

#### EXPR ::= EXPR index EXPR

| Condition              | Value |
| ---------------------- | ----- |
| EXPR_1 compiles        | True  |
|                        | False |
| EXPR_2 compiles        | True  |
|                        | False |
| EXPR_1 is of Type List | True  |
|                        | False |
| EXPR_2 is of Type Int  | True  |
|                        | False |

| EXPR_1 compiles | EXPR_2 compiles | EXPR_1 is of Type List | EXPR_2 is of Type Int | Valid/Invalid | Test case                                               | Program                    |
| --------------- | --------------- | ---------------------- | --------------------- | ------------- | ------------------------------------------------------- | -------------------------- |
| F               | *               | *                      | *                     | Invalid       | x :: Int<br/>x = [] !! 3<br/>main = print "hello"       | _fail_grammar_expr_index_1 |
| T               | F               | *                      | *                     | Invalid       | x :: Int<br/>x = [1,2,3] !! jl<br/>main = print "hello" | _fail_grammar_expr_index_2 |
| T               | T               | F                      | *                     | Invalid       | x :: Int<br/>x = 3 !! 3<br/>main = print "hello"        | _fail_sem_expr_index_1     |
| T               | T               | T                      | F                     | Invalid       | x :: Int<br/>x = [1] !! 'c'<br/>main = print "hello"    | _fail_sem_expr_index_2     |
| T               | T               | T                      | T                     | Valid         | x :: Char<br/>x = "hello" !! 1<br/>main = print "hello" | _succ_expr_index_1         |

#### EXPR ::= ro EXPR rc

| Condition     | Value |
| ------------- | ----- |
| EXPR compiles | True  |
|               | False |

| ACTARG compiles | Valid/Invalid | Test case                                      | Program                          |
| --------------- | ------------- | ---------------------------------------------- | -------------------------------- |
| F               | Invalid       | x :: Int<br/>x = (jl)<br/>main = print "hello" | _fail_grammar_expr_parentheses_1 |
| T               | Valid         | x :: Int<br/>x = (3)<br/>main = print "hello"  | _succ_expr_parentheses_1         |

#### EXPR ::= not EXPR

| Condition            | Value |
| -------------------- | ----- |
| EXPR compiles        | True  |
|                      | False |
| EXPR is of Type Bool | True  |
|                      | False |

| EXPR compiles | EXPR is of Type Bool | Valid/Invalid | Test case                                           | Program                  |
| ------------- | -------------------- | ------------- | --------------------------------------------------- | ------------------------ |
| F             | *                    | Invalid       | x :: Bool<br/>x = not jl<br/>main = print "hello"   | _fail_grammar_expr_not_1 |
| T             | F                    | Invalid       | x :: Bool<br/>x = not 3<br/>main = print "hello"    | _fail_sem_expr_not_1     |
| T             | T                    | Valid         | x :: Bool<br/>x = not True<br/>main = print "hello" | _succ_expr_not_1         |

#### EXPR ::= minus EXPR

| Condition              | Value |
| ---------------------- | ----- |
| EXPR compiles          | True  |
|                        | False |
| EXPR is of Type Double | True  |
|                        | False |

| EXPR compiles | EXPR is of Type Double | Valid/Invalid | Test case                                      | Program                     |
| ------------- | ---------------------- | ------------- | ---------------------------------------------- | --------------------------- |
| F             | *                      | Invalid       | x :: Int<br/>x = -jl<br/>main = print "hello"  | _fail_grammar_expr_uminus_1 |
| T             | F                      | Invalid       | x :: Int<br/>x = -'c'<br/>main = print "hello" | _fail_sem_expr_uminus_1     |
| T             | T                      | Valid         | x :: Int<br/>x = -4 <br/>main = print "hello"  | _succ_expr_not_1            |

#### EXPR ::= LET_BLOCK_FUNC

| Condition               | Value |
| ----------------------- | ----- |
| LET_BLOCK_FUNC compiles | True  |
|                         | False |

| LET_BLOCK_FUNC compiles | Valid/Invalid | Test case                                                    | Program                  |
| ----------------------- | ------------- | ------------------------------------------------------------ | ------------------------ |
| F                       | Invalid       | x :: Int<br/>x = let in 3<br/>main = print "hello"           | _fail_grammar_expr_let_1 |
| T                       | Valid         | x :: Int<br/>x = let y :: Int; y = 3 in y<br/>main = print "hello" | _succ_expr_let_1         |

#### EXPR ::= IF_BLOCK_FUNC

| Condition              | Value |
| ---------------------- | ----- |
| IF_BLOCK_FUNC compiles | True  |
|                        | False |

| IF_BLOCK_FUNC compiles | Valid/Invalid | Test case                                                  | Program                 |
| ---------------------- | ------------- | ---------------------------------------------------------- | ----------------------- |
| F                      | Invalid       | x :: Int<br/>x = if then 3 else 4<br/>main = print "hello" | _fail_grammar_expr_if_1 |
| T                      | Valid         | x :: Int<br/>x = if True then 3 else 4<br/>main = print x  | _succ_expr_if_1         |

#### EXPR ::= id LACTARG

| Condition                                           | Value |
| --------------------------------------------------- | ----- |
| LACTARG compiles                                    | True  |
|                                                     | False |
| id is declared                                      | True  |
|                                                     | False |
| id is assigned                                      | True  |
|                                                     | False |
| LACTARG size > 0                                    | True  |
|                                                     | False |
| id is a Function                                    | True  |
|                                                     | False |
| id arity == LACTARG size                            | True  |
|                                                     | False |
| Actual arguments' Type match Formal arguments' Type | True  |
|                                                     | False |

| LACTARG compiles | id is declared | id is assigned | LACTARG size > 0 | id is a Function | id arity == LACTARG size | Actual arguments' Type match Formal arguments' Type | Valid/Invalid | Test case                                                    | Program                         |
| ---------------- | -------------- | -------------- | ---------------- | ---------------- | ------------------------ | --------------------------------------------------- | ------------- | ------------------------------------------------------------ | ------------------------------- |
| F                | *              | *              | *                | *                | *                        | *                                                   | Invalid       | x :: [Int] -> Int<br/>x y = y !! 0<br/>y :: Int<br/>y = x alj lsk<br/>main = print "hello" | _fail_grammar_expr_funct_call_1 |
| T                | F              | *              | *                | *                | *                        | *                                                   | Invalid       | y :: Int<br/>y = x [1,2,3]<br/>main = print "hello"          | _fail_sem_expr_funct_call_1     |
| T                | T              | F              | *                | *                | *                        | *                                                   | Invalid       | x :: [Int] -> Int<br/>y :: Int<br/>y = x [1,2,3]<br/>main = print "hello" | _fail_sem_expr_funct_call_2     |
| T                | T              | T              | F                | F                | T                        | T                                                   | Valid         | x :: Int<br/>x = 3<br/>y :: Int<br/>y = x<br/>main = print "hello" | _succ_expr_funct_call_1         |
| T                | T              | T              | F                | T                | *                        | *                                                   | Invalid       | x :: [Int] -> Int<br/>x y = y !! 0<br/>z :: Int<br/>z = x<br/>main = print "hello" | _fail_sem_expr_funct_call_3     |
| T                | T              | T              | T                | F                | *                        | *                                                   | Invalid       | x :: Int<br/>x = 3<br/>y :: Int<br/>y = x 3<br/>main = print "hello" | _fail_sem_expr_funct_call_4     |
| T                | T              | T              | T                | T                | F                        | *                                                   | Invalid       | x :: Int -> Int -> Int<br/>x y z = y + z<br/>y :: Int<br/>y = x 3<br/>main = print "hello" | _fail_sem_expr_funct_call_5     |
| T                | T              | T              | T                | T                | T                        | F                                                   | Invalid       | x :: Int -> Int<br/>x y = y<br/>y :: Int<br/>y = x True<br/>main = print "hello" | _fail_sem_expr_funct_call_6     |
| T                | T              | T              | T                | T                | T                        | T                                                   | Valid         |                                                              | _succ_expr_funct_call_2         |

#### EXPR ::= VALUE

| Condition      | Value |
| -------------- | ----- |
| VALUE compiles | True  |
|                | False |

| VALUE compiles | Valid/Invalid | Test case                                    | Program               |
| -------------- | ------------- | -------------------------------------------- | --------------------- |
| F              | Invalid       | x :: Int<br/>x = jl<br/>main = print "hello" | _fail_grammar_value_1 |
| T              | Valid         | x :: Int<br/>x = 3<br/>main = print "hello"  | _succ_expr_value_1    |

#### EXPR ::= VALUE_LIST

| Condition           | Value |
| ------------------- | ----- |
| VALUE_LIST compiles | True  |
|                     | False |

| VALUE_LIST compiles | Valid/Invalid | Test case                                                    | Program                    |
| ------------------- | ------------- | ------------------------------------------------------------ | -------------------------- |
| F                   | Invalid       | main = do<br/>       let x :: [Int]; x = []<br/>       print (x !! 0) | _fail_grammar_value_list_1 |
| T                   | Valid         | main = do<br/>       let x :: [Int]; x = [1,2,3]<br/>       print (x !! 0) | _succ_expr_value_list_1    |

#### LET_BLOCK_FUNC ::= let indent LET_STMTS indent in EXPR

| Condition               | Value |
| ----------------------- | ----- |
| LET_STMTS compiles      | True  |
|                         | False |
| EXPR compiles           | True  |
|                         | False |
| Indentation is followed | True  |
|                         | False |

| LET_STMTS compiles | EXPR compiles | Indentation is followed | Valid/Invalid | Test case                                                    | Program                        |
| ------------------ | ------------- | ----------------------- | ------------- | ------------------------------------------------------------ | ------------------------------ |
| F                  | *             | *                       | Invalid       | x :: Int<br/>x = let y in 3<br/>main = print "hello"         | _fail_grammar_let_block_func_1 |
| T                  | F             | *                       | Invalid       | x :: Int<br/>x = let y :: Int; y = 3 in jl<br/>main = print "hello" | _fail_grammar_let_block_func_2 |
| T                  | T             | F                       | Invalid       | x :: Int<br/>x = let y :: Int<br/>       y = 3 <br/>	in jl<br/>main = print "hello" | _fail_grammar_let_block_func_3 |
| T                  | T             | T                       | Valid         | x :: Int<br/>x = let y :: Int; y = 3 in y<br/>main = print "hello" | _succ_let_block_func_1         |

#### IF_BLOCK_FUNC ::= if_begin COND then EXPR else_begin EXPR  

| Condition                  | Value |
| -------------------------- | ----- |
| COND compiles              | True  |
|                            | False |
| EXPR_1 compiles            | True  |
|                            | False |
| EXPR_2 compiles            | True  |
|                            | False |
| EXPR_1.type == EXPR_2.type | True  |
|                            | False |

| COND compiles | EXPR_1 compiles | EXPR_2 compiles | EXPR_1.type == EXPR_2.type | Valid/Invalid | Test case                                                    | Program                       |
| ------------- | --------------- | --------------- | -------------------------- | ------------- | ------------------------------------------------------------ | ----------------------------- |
| F             | *               | *               | *                          | Invalid       | x :: Int<br/>x = if jl then 3 else 4<br/>main = print "hello" | _fail_grammar_if_block_func_1 |
| T             | F               | *               | *                          | Invalid       | x :: Int<br/>x = if True then jl else 4<br/>main = print "hello" | _fail_grammar_if_block_func_2 |
| T             | T               | F               | *                          | Invalid       | x :: Int<br/>x = if True then 4 else jl<br/>main = print "hello" | _fail_grammar_if_block_func_3 |
| T             | T               | T               | F                          | Invalid       | x :: Int<br/>x = if True then 4 else "hello"<br/>main = print "hello" | _fail_sem_if_block_func_1     |
| T             | T               | T               | T                          | Valid         | x :: Int<br/>x = if True then 4 else 3<br/>main = print "hello" | _succ_if_block_func_1         |

#### ACTARG ::= id

| Condition           | Value |
| ------------------- | ----- |
| id is declared      | True  |
|                     | False |
| id is assigned      | True  |
|                     | False |
| id.type == arg.type | True  |
|                     | False |

| id is declared | id is assigned | id.type == arg.type | Valid/Invalid | Test case                                                    | Program            |
| -------------- | -------------- | ------------------- | ------------- | ------------------------------------------------------------ | ------------------ |
| F              | *              | *                   | Invalid       | main = print x                                               | _fail_sem_actarg_1 |
| T              | F              | *                   | Invalid       | x :: Int -> Int<br/>x y = y<br/>z :: Int<br/>z = x w<br/>main = print "hello" | _fail_sem_actarg_2 |
| T              | T              | F                   | Invalid       | x :: Int -> Int<br/>x y = y<br/>w :: Bool<br/>w = True<br/>z :: Int<br/>z = x w<br/>main = print "hello" | _fail_sem_actarg_3 |
| T              | T              | T                   | Valid         | x :: Int -> Int<br/>x y = y<br/>y, z :: Int<br/>y = 3<br/>z = x y<br/>main = print "hello" | _succ_actarg_1     |

#### ACTARG ::= VALUE

| Condition      | Value |
| -------------- | ----- |
| VALUE compiles | True  |
|                | False |

| VALUE compiles | Valid/Invalid | Test case                                                    | Program                |
| -------------- | ------------- | ------------------------------------------------------------ | ---------------------- |
| F              | Invalid       | x :: Int -> Int<br/>x y = y<br/>z :: Int<br/>z = x 't45<br/>main = print "hello" | _fail_grammar_actarg_1 |
| T              | Valid         | x :: Int -> Int<br/>x y = y<br/>y' :: Int<br/>y' = x 3<br/>main = print "hello" | _succ_actarg_2         |

#### ACTARG ::= ro EXPR rc

| Condition     | Value |
| ------------- | ----- |
| EXPR compiles | True  |
|               | False |

| EXPR compiles | Valid/Invalid | Test case          | Program                |
| ------------- | ------------- | ------------------ | ---------------------- |
| F             | Invalid       | main = print ()    | _fail_grammar_actarg_2 |
| T             | Valid         | main = print (3+4) | _succ_actarg_2         |

#### LACTARG ::= /* empty */

| Condition    | Value |
| ------------ | ----- |
| RHS compiles | True  |

| RHS compiles | Valid/Invalid | Test case                                                    | Program         |
| ------------ | ------------- | ------------------------------------------------------------ | --------------- |
| T            | Valid         | x :: Int<br/>x = 3 <br />y :: Int<br/>y = x<br/>main = print "hello" | _succ_lactarg_1 |

#### xLACTARG ::= LACTARG ACTARG

| Condition        | Value |
| ---------------- | ----- |
| LACTARG compiles | True  |
|                  | False |
| ACTARG compiles  | True  |
|                  | False |

| LACTARG compiles | ACTARG compiles | Valid/Invalid | Test case                                                    | Program                 |
| ---------------- | --------------- | ------------- | ------------------------------------------------------------ | ----------------------- |
| F                | *               | Invalid       | x :: Int -> Int -> Int<br/>x y z = y + z<br/>y :: Int<br/>y = x t 3<br/>main = print "hello" | _fail_grammar_lactarg_1 |
| T                | F               | Invalid       | x :: Int -> Int -> Int<br/>x y z = y + z<br/>y :: Int<br/>y = x 3 t<br/>main = print "hello" | _fail_grammar_lactarg_2 |
| T                | T               | Valid         | x :: Int -> Int -> Int<br/>x y z = y + z<br/>w :: Int<br/>w = 3<br/>y :: Int<br/>y = x w 4<br/>main = print "hello" | _succ_lactarg_2         |

#### VALUE ::= VALUE_BASIC

| Condition            | Value |
| -------------------- | ----- |
| VALUE_BASIC compiles | True  |
|                      | False |

| VALUE_BASIC compiles | Valid/Invalid | Test case                                     | Program               |
| -------------------- | ------------- | --------------------------------------------- | --------------------- |
| F                    | Invalid       | x :: Int<br/>x = 3t4<br/>main = print "hello" | _fail_grammar_value_1 |
| T                    | Valid         | x :: Int<br/>x = 3<br/>main = print x         | _succ_value_1         |

#### VALUE_BASIC ::= val_int

| Condition             | Value |
| --------------------- | ----- |
| val_int is recognized | True  |

| val_int is recognized | Valid/Invalid | Test case                                   | Program             |
| --------------------- | ------------- | ------------------------------------------- | ------------------- |
| T                     | Valid         | x :: Int<br/>x = 3<br/>main = print "hello" | _succ_value_basic_1 |

#### VALUE_BASIC ::= val_double

| Condition                | Value |
| ------------------------ | ----- |
| val_double is recognized | True  |

| val_double is recognized | Valid/Invalid | Test case                                        | Program             |
| ------------------------ | ------------- | ------------------------------------------------ | ------------------- |
| T                        | Valid         | x :: Double<br/>x = 3.0<br/>main = print "hello" | _succ_value_basic_2 |

#### VALUE_BASIC ::= val_bool

| Condition              | Value |
| ---------------------- | ----- |
| val_bool is recognized | True  |

| val_bool is recognized | Valid/Invalid | Test case                                       | Program             |
| ---------------------- | ------------- | ----------------------------------------------- | ------------------- |
| T                      | Valid         | x :: Bool<br/>x = True<br/>main = print "hello" | _succ_value_basic_3 |

#### VALUE_BASIC ::= val_char

| Condition              | Value |
| ---------------------- | ----- |
| val_char is recognized | True  |

| val_char is recognized | Valid/Invalid | Test case                                      | Program             |
| ---------------------- | ------------- | ---------------------------------------------- | ------------------- |
| T                      | Valid         | x :: Char<br/>x = 'a'<br/>main = print "hello" | _succ_value_basic_4 |

#### VALUE_BASIC ::= val_string

| Condition                | Value |
| ------------------------ | ----- |
| val_string is recognized | True  |

| val_string is recognized | Valid/Invalid | Test case                                                    | Program             |
| ------------------------ | ------------- | ------------------------------------------------------------ | ------------------- |
| T                        | Valid         | main = do<br/>       let x :: String<br/>           x = "hello"<br/>       print x | _succ_value_basic_5 |

#### VALUE_LIST ::= bo LEXPR bc

| Condition      | Value |
| -------------- | ----- |
| LEXPR compiles | True  |
|                | False |

| LEXPR compiles | Valid/Invalid | Test case                                                    | Program                    |
| -------------- | ------------- | ------------------------------------------------------------ | -------------------------- |
| F              | Invalid       | main = do<br/>       let x :: [Int]; x = []<br/>       print "hello" | _fail_grammar_expr_value_list_1 |
| T              | Valid         | main = do<br/>       let x :: [Int]; x = [1,2]<br/>       print "hello" | _succ_value_list_1         |

#### LEXPR ::= EXPR

| Condition     | Value |
| ------------- | ----- |
| EXPR compiles | True  |
|               | False |

| EXPR compiles | Valid/Invalid | Test case                                                    | Program               |
| ------------- | ------------- | ------------------------------------------------------------ | --------------------- |
| F             | Invalid       | main = do<br/>       let x :: [Int]; x = [jl, 2]<br/>       print "hello" | _fail_grammar_lexpr_1 |
| T             | Valid         | main = do<br/>       let y :: Int; y = 3; x :: [Int]; x = [1,2]<br/>       print "hello" | _succ_lexpr_1         |

#### LEXPR ::= LEXPR cm EXPR

| Condition               | Value |
| ----------------------- | ----- |
| EXPR compiles           | True  |
|                         | False |
| LEXPR compiles          | True  |
|                         | False |
| LEXPR.type == EXPR.type | True  |
|                         | False |

| LEXPR compiles | EXPR compiles | LEXPR.type == EXPR.type | Valid/Invalid | Test case                                                    | Program               |
| -------------- | ------------- | ----------------------- | ------------- | ------------------------------------------------------------ | --------------------- |
| F              | *             | *                       | Invalid       | main = do<br/>       let x :: [Int]; x = [jl, 2]<br/>       print "hello" | _fail_grammar_lexpr_1 |
| T              | F             | *                       | Invalid       | main = do<br/>       let x :: [Int]; x = [2, jl]<br/>       print "hello" | _fail_grammar_lexpr_2 |
| T              | T             | F                       | Invalid       | main = do<br/>       let y :: Int; y = 3; x :: [Int]; x = [1,'c']<br/>       print "hello" | _fail_sem_lexpr_1     |
| T              | T             | T                       | Valid         | main = do<br/>       let y :: Int; y = 3; x :: [Int]; x = [1,y]<br/>       print "hello" | _succ_lexpr_2         |

#### TYPE ::= TYPE_VALUE

| Condition           | Value |
| ------------------- | ----- |
| TYPE_VALUE compiles | True  |
|                     | False |

| TYPE_VALUE compiles | Valid/Invalid | Test case                         | Program              |
| ------------------- | ------------- | --------------------------------- | -------------------- |
| F                   | Invalid       | x :: int<br/>main = print "hello" | _fail_grammar_type_1 |
| T                   | Valid         | x :: Int<br/>main = print "hello" | _succ_type_1         |

#### TYPE ::= TYPE_FUNC

| Condition          | Value |
| ------------------ | ----- |
| TYPE_FUNC compiles | True  |
|                    | False |

| TYPE_FUNC compiles | Valid/Invalid | Test case                                | Program              |
| ------------------ | ------------- | ---------------------------------------- | -------------------- |
| F                  | Invalid       | x :: Int -> int<br/>main = print "hello" | _fail_grammar_type_2 |
| T                  | Valid         | x :: Int -> Int<br/>main = print "hello" | _succ_type_2         |

#### TYPE_VALUE ::= TYPE_LIST

| Condition          | Value |
| ------------------ | ----- |
| TYPE_LIST compiles | True  |
|                    | False |

| TYPE_LIST compiles | Valid/Invalid | Test case                                                    | Program                    |
| ------------------ | ------------- | ------------------------------------------------------------ | -------------------------- |
| F                  | Invalid       | main = do<br/>       let x :: [int]<br/>       print "hello" | _fail_grammar_type_value_1 |
| T                  | Valid         | main = do<br/>       let x :: [Int]<br/>       print "hello" | _succ_type_value_1         |

#### TYPE_VALUE ::= TYPE_BASIC

| Condition           | Value |
| ------------------- | ----- |
| TYPE_BASIC compiles | True  |
|                     | False |

| TYPE_BASIC compiles | Valid/Invalid | Test case                         | Program              |
| ------------------- | ------------- | --------------------------------- | -------------------- |
| F                   | Invalid       | x :: int<br/>main = print "hello" | _fail_grammar_type_1 |
| T                   | Valid         | x :: Int<br/>main = print "hello" | _succ_type_1         |

#### TYPE_BASIC ::= type_int

| Condition              | Value |
| ---------------------- | ----- |
| type_int is recognized | True  |
|                        | False |

| type_int is recognized | Valid/Invalid | Test case                         | Program      |
| ---------------------- | ------------- | --------------------------------- | ------------ |
| T                      | Valid         | x :: Int<br/>main = print "hello" | _succ_type_1 |

#### TYPE_BASIC ::= type_double

| Condition                 | Value |
| ------------------------- | ----- |
| type_double is recognized | True  |
|                           | False |

| type_double is recognized | Valid/Invalid | Test case                            | Program            |
| ------------------------- | ------------- | ------------------------------------ | ------------------ |
| T                         | Valid         | x :: Double<br/>main = print "hello" | _succ_type_basic_1 |

#### TYPE_BASIC ::= type_bool

| Condition               | Value |
| ----------------------- | ----- |
| type_bool is recognized | True  |
|                         | False |

| type_bool is recognized | Valid/Invalid | Test case                           | Program            |
| ----------------------- | ------------- | ----------------------------------- | ------------------ |
| T                       | Valid         | x :: Bool <br/>main = print "hello" | _succ_type_basic_2 |

#### TYPE_BASIC ::= type_char

| Condition               | Value |
| ----------------------- | ----- |
| type_char is recognized | True  |
|                         | False |

| type_char is recognized | Valid/Invalid | Test case                          | Program            |
| ----------------------- | ------------- | ---------------------------------- | ------------------ |
| T                       | Valid         | x :: Char<br/>main = print "hello" | _succ_type_basic_3 |

#### TYPE_LIST ::= type_string

| Condition                 | Value |
| ------------------------- | ----- |
| type_string is recognized | True  |
|                           | False |

| type_string is recognized | Valid/Invalid | Test case                                                    | Program            |
| ------------------------- | ------------- | ------------------------------------------------------------ | ------------------ |
| T                         | Valid         | main = do<br/>       let x :: String<br/>       print "hello" | _succ_type_basic_4 |

#### TYPE_LIST ::= bo TYPE_BASIC bc

| Condition           | Value |
| ------------------- | ----- |
| TYPE_BASIC compiles | True  |
|                     | False |

| type_string is recognized | Valid/Invalid | Test case                                                    | Program                   |
| ------------------------- | ------------- | ------------------------------------------------------------ | ------------------------- |
| F                         | Invalid       | main = do<br/>       let x :: [bool]<br/>       print "hello" | _fail_grammar_type_list_1 |
| T                         | Valid         | main = do<br/>       let x :: [Int]<br/>       print "hello" | _succ_type_list_1         |

#### TYPE_FUNC ::= TYPE_VALUE arrow TYPE_FUNC

| Condition           | Value |
| ------------------- | ----- |
| TYPE_VALUE compiles | True  |
|                     | False |
| TYPE_FUNC compiles  | True  |
|                     | False |

| TYPE_VALUE compiles | TYPE_FUNC compiles | Valid/Invalid | Test case                                        | Program                   |
| ------------------- | ------------------ | ------------- | ------------------------------------------------ | ------------------------- |
| F                   | *                  | Invalid       | x :: int -> Int -> Bool<br/>main = print "hello" | _fail_grammar_type_func_1 |
| T                   | F                  | Invalid       | x :: Int -> int -> Bool<br/>main = print "hello" | _fail_grammar_type_func_2 |
| T                   | T                  | Valid         | x :: Int -> Int -> Bool<br/>main = print "hello" | _succ_type_func_1         |

#### TYPE_FUNC ::= TYPE_VALUE arrow TYPE_VALUE

| Condition             | Value |
| --------------------- | ----- |
| TYPE_VALUE_1 compiles | True  |
|                       | False |
| TYPE_VALUE_2 compiles | True  |
|                       | False |

| TYPE_VALUE_1 compiles | TYPE_VALUE_2 compiles | Valid/Invalid | Test case                                | Program                   |
| --------------------- | --------------------- | ------------- | ---------------------------------------- | ------------------------- |
| F                     | *                     | Invalid       | x :: int -> Int<br/>main = print "hello" | _fail_grammar_type_func_3 |
| T                     | F                     | Invalid       | x :: Int -> int<br/>main = print "hello" | _fail_grammar_type_func_4 |
| T                     | T                     | Valid         | x :: Int -> Int<br/>main = print "hello" | _succ_type_func_2         |
