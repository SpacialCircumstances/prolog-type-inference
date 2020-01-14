use_module(library(assoc)).
use_module(library(plunit)).
env_add(OLDENV, NEWENV, X, T) :- put_assoc(X, OLDENV, T, NEWENV).
env_contains(ENV, X, T) :- get_assoc(X, ENV, T).
type(const(_), int, _, _).
type(var(X), T, ENV, _) :- env_contains(ENV, X, T).
type(app(F, A), T, ENV, NE) :- type(F, [func, X, T], ENV, NE1), type(A, X, NE1, NE).
type(lambda(X, E), T, ENV, _) :- env_add(ENV, NE1, X, ARGTYPE), type(E, BODYTYPE, NE1, _), =(T, [func, ARGTYPE, BODYTYPE]).
type(let(X, VE, BE), T, ENV, _) :- type(VE, VT, ENV, _), env_add(ENV, NE1, X, VT), type(BE, T, NE1, _).

:- begin_tests(typing).
test(const_type) :- type(const(2), int, _, _).
test(simple_var) :- list_to_assoc([ x - int ], E), type(var(x), int, E, _).
test(id_function) :- once(type(lambda(x, var(x)), [func, T1, T2], _, _)), =(T1, T2).
:- end_tests(typing).