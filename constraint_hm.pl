eq(A, A).
inst(var(X), G) :- dif(X, G).
inst(A, A).
generalized(is_list(A), GEN) :- maplist(inst, A, GEN).
generalized(X, X).
eq_gen(A, B, _) :- generalized(B, GENERALIZED), display(GENERALIZED), eq(A, GENERALIZED).