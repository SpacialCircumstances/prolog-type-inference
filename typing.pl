library(assoc).
env_add(OLDENV, NEWENV, X, T) :- put_assoc(X, OLDENV, T, NEWENV).
env_contains(ENV, X, T) :- get_assoc(X, ENV, T).
type(const(_), int, _, _).
type(var(X), T, ENV, _) :- env_contains(ENV, X, T).
type(app(F, A), T, ENV, NE) :- type(F, [func, X, T], ENV, NE1), type(A, X, NE1, NE).
type(lambda(X, E), T, ENV, _) :- env_add(ENV, NE1, X, ARGTYPE), type(E, BODYTYPE, NE1, _), =(T, [func, ARGTYPE, BODYTYPE]).