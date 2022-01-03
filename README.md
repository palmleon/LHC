# LHC
<p align="center">
<a href="https://imgbb.com/"><img src="https://i.ibb.co/Ny6wg11/polito-logo-new.png"></a>
</p>  
<p align="center">
 <img alt="Languages" src="https://img.shields.io/badge/Language-Java-orange">
 <img alt="development" src="https://img.shields.io/badge/development-suspended-orange"/>   
 <img alt="version" src="https://img.shields.io/badge/version-1.0.0-brightgreen"/>
</p>


A Little Haskell Compiler, 
born as an Assignment for the *"Formal Languages and Compilers"* course (A.Y. 2020/2021). 

## Introduction

LHC (Little Haskell Compiler) is a small compiler, able to recognize a strict subset of the Haskell Programming Language, build it and produce LLVM code as output.

#### The High-end language

[Haskell](https://www.haskell.org/) is an Advanced, Purely Functional Programming Language. Born in 1990, it has become one of the most popular Functional Programming Languages; it is increasingly used in the industrial domain and not only in the academic context. 

As a Pure Functional Language, it has many interesting properties:

- Referential Transparency
- Single Assignment
- Non Strictness
- Type Inference
- Functions are 1st order entities
- Lexical Scoping
- ...

LHC tries to follow in the footsteps of this Language by implementing some of its peculiar features (Referential Transparency, Single Assignment, Lexical Scoping).

#### The Core

LHC is based on:

- a Scanner, built using a Scanner Generator: [JFlex](https://www.jflex.de/)

- an LALR(1) Parser, designed using a Parser Generator: [Cup](http://www2.cs.tum.edu/projects/cup/)

- additional classes for Semantic Analysis and IR Generation, written in Java

#### The Target Language

The Target Language of LHC is [LLVM](https://llvm.org/), a Programming Language specially used for Intermediate Code Representation. 

Born as a research project at the University of Illinois, it has developed into an umbrella project consisting of several subprojects, including the LLVM Language itself and a C++ API to build and optimize LLVM code at a higher level of abstraction.

This project had to be designed in Java; for this reason, it was not possible to directly use this API. However, unofficial Java translations of the API exist and may be considered for future development.

## Features

Currently, LHC supports the following subset of Haskell:

* Supported Types:
  - Basic Types: Int, Double, Char, Bool  
  - Aggregate Types: Lists (not Recursive), Strings
  - Other Types: Functions (not as 1st order entities)
* Supported operations:
  - Addition (+)
  - Subtraction (-)
  - Multiplication (\*)
  - Division (/)
  - Integer Division (div)
  - Remainder (rem)
  - Logical operators:
    - Logical and (&&)
    - Logical or (||)
    - Logical not (not)
  - Relational operators:
    - Greater than (>)
    - Greater or equal to (>=)
    - Less than (<)
    - Less or equal to (<=)
    - Equal to (==)
    - Not equal to (/=)
  - Element extraction from List/String (!!)
  - Function call
* Constructs:
  - If-Then-Else
  - Let Bindings (both in the Functional and Imperative Part)
  - Do Block
* I/O:
  - Print Function (accepts Int, Double, Char, String)
* Language Properties:
  - Indentation-based Parsing
  - Referential Transparency
  - Single Assignment ("Everything is a constant")
  - Lexical Scoping

## How to use LHC

LHC is compatible with:

* Ubuntu 20.04 LTS (but it should work with less recent versions or other Linux distributions, too).

#### Prerequisites

* JDK (Java Development Kit) - Version 16 or above (successfully tested with JDK 16, but may work with less recent releases, too)
* [JFlex](https://www.jflex.de/)
* [Cup](https://www.skenz.it/compilers/install_linux_bash) - This is NOT the original implementation of Cup, but an enhanced one that implements a graphical representation of the Parse Tree (it will be removed in the future); follow the instruction in the *"Download CUP"* paragraph to install the tool 
* LLVM (use  `sudo apt install llvm` to install the package) - Version 10 or above (less recent may work, too)

#### Installation and usage

After cloning the Project and entering into the main folder, you can use the following commands to play with the compiler:

- **make install**: Install everything
- **make uninstall**: uninstall everything
- **make %.ll**: build the corresponding %.hs file and produce the resulting LLVM code 
- **lli %.ll**: run the output code

In the ***/programs*** folder, you can already find some examples.

## Future Development

Possible coming features to implement (in order of possible development):

- Extend support to Aggregate Types (Tuples, Recursive Data Structures)
- Allow Function Definitions inside Let Bindings
- Guards
- Where Bindings
- Type Inference
- Infix/Prefix Binary Functions
- Case Expressions
- Pattern Matching -> VERY HARD
- Custom Types/Typeclasses -> VERY HARD
