use_module(library(assoc)).
use_module(library(plunit)).
env_add(OLDENV, NEWENV, X, T) :- put_assoc(X, OLDENV, T, NEWENV).
env_contains(ENV, X, T) :- get_assoc(X, ENV, T).
type(bool_const(_), bool, _).
type(int_const(_), int, _).
type(var(X), T, ENV) :- env_contains(ENV, X, T).
type(app(F, A), T, ENV) :- type(F, [func, X, T], ENV), type(A, X, ENV).
type(lambda(X, E), T, ENV) :- env_add(ENV, NEW_ENV, X, ARGTYPE), type(E, BODYTYPE, NEW_ENV), =(T, [func, ARGTYPE, BODYTYPE]).
type(let(X, VE, BE), T, ENV) :- env_add(ENV, NEW_ENV, X, VT), type(VE, VT, ENV), type(BE, T, NEW_ENV).

:- begin_tests(typing).
test(const_type) :- type(int_const(2), int, _).
test(simple_var) :- list_to_assoc([ x - int ], E), type(var(x), int, E).
test(id_function) :- once(type(lambda(x, var(x)), [func, T1, T2], _)), =(T1, T2).
test(let_with_id) :- once(type(let(id, lambda(x, var(x)), app(var(id), int_const(1))), int, _)).
test(variable_shadowing) :- once(type(lambda(x, lambda(x, var(x))), T, _)), =(T, [func, _, [func, A, A]]).
test(simple_application) :- once(type(app(lambda(x, var(x)), bool_const(true)), bool, _)).
:- end_tests(typing).