eq(A, A).
inst(var(X), G) :- dif(X, G).
inst(A, A).
generalized(A, GEN) :- maplist(inst, A, GEN).
eq_gen(A, B, _) :- generalized(B, GENERALIZED), display(GENERALIZED), eq(A, GENERALIZED).