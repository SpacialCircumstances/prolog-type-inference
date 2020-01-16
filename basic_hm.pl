%A typechecker for a STLC-based language
%Based on HM, but without let-generalization.
%Expressions are defined as Prolog-predicates.

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
type(let_rec(X, VE, BE), T, ENV) :- env_add(ENV, NEW_ENV, X, VT), type(VE, VT, NEW_ENV), type(BE, T, NEW_ENV).
type(if(COND, IF, ELSE), T, ENV) :- type(COND, bool, ENV), type(IF, T, ENV), type(ELSE, T, ENV).

:- begin_tests(typing).
test(const_type) :- type(int_const(2), int, _).
test(simple_var) :- list_to_assoc([ x - int ], E), type(var(x), int, E).
test(id_function) :- once(type(lambda(x, var(x)), [func, T1, T2], _)), =(T1, T2).
test(let_with_id) :- once(type(let(id, lambda(x, var(x)), app(var(id), int_const(1))), int, _)).
test(variable_shadowing) :- once(type(lambda(x, lambda(x, var(x))), T, _)), =(T, [func, _, [func, A, A]]).
test(simple_application) :- once(type(app(lambda(x, var(x)), bool_const(true)), bool, _)).
test(basic_if) :- once(type(if(bool_const(true), int_const(1), int_const(2)), int, _)).
test(factorial) :- list_to_assoc([eq - [func, A, [func, A, bool]], minus - [func, int, [func, int, int]], mul - [func, int, [func, int, int]]], E),
                    once(type(let_rec(fac,
                        lambda(n, if(app(app(var(eq), var(n)), int_const(1)),
                            int_const(1),
                            app(var(fac), app(app(var(mul), var(n)), app(app(var(minus), var(n)), int_const(1)))))), app(var(fac), int_const(2))), int, E)).
:- end_tests(typing).