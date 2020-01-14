library(assoc).
env_add(OLDENV, NEWENV, X, T) :- put_assoc(X, OLDENV, T, NEWENV).
env_contains(ENV, X, T) :- get_assoc(X, ENV, T).
type(var(X), T, ENV, _) :- env_contains(ENV, X, T).
type(app(F, A), T, ENV, NE) :- type(F, [func, X, T], ENV, NE1), type(A, X, NE1, NE).
type(lambda(X, E), T, ENV, NE) :- =(T, [func, A, B]), type(E, A, ENV, NE1), env_add(NE1, NE, X, B).