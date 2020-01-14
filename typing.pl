use_module(library(assoc)).
use_module(library(plunit)).
env_add(OLDENV, NEWENV, X, T) :- put_assoc(X, OLDENV, T, NEWENV).
env_contains(ENV, X, T) :- get_assoc(X, ENV, T).
type(const(_), int, _).
type(var(X), T, ENV) :- env_contains(ENV, X, T).
type(app(F, A), T, ENV) :- type(F, [func, X, T], ENV), type(A, X, ENV).
type(lambda(X, E), T, ENV) :- env_add(ENV, NEW_ENV, X, ARGTYPE), type(E, BODYTYPE, NEW_ENV), =(T, [func, ARGTYPE, BODYTYPE]).
type(let(X, VE, BE), T, ENV) :- type(VE, VT, ENV), env_add(ENV, NEW_ENV, X, VT), type(BE, T, NEW_ENV).

:- begin_tests(typing).
test(const_type) :- type(const(2), int, _).
test(simple_var) :- list_to_assoc([ x - int ], E), type(var(x), int, E).
test(id_function) :- once(type(lambda(x, var(x)), [func, T1, T2], _)), =(T1, T2).
:- end_tests(typing).