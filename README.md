# Type inference using Prolog

Prolog's solving system allows writing basic typecheckers with ease due to its use of unification.

`basic_hm.pl` implements a Hindley-Milner-style type system, but without let-generalization.
The expressions are modelled as nested Prolog predicates, and the "language" supports constants (booleans, integers) as well as variables, lambda functions, if-expressions and let and recursive let and can therefore be viewed as an extended lambda calculus and a base for a programming language (even if it lacks let-generalization to be useful).

`constraint_hm.pl` and `asra_letgen_constraints.pl` contain experiments with constraint-based typechecking and attempts to implement let-generalization using native Prolog features. I was unable to make them work.
