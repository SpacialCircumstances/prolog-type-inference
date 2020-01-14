get_env(ENV, X) :- set_env(ENV, X, _).
type(var(X), T, ENV) :- =(T, get_env(ENV, X)).
type(app(F, A), T, ENV) :- type(F, [func, X, T], ENV), type(A, X, ENV).
type(lambda(X, E), T, ENV) :- =(T, [func, A, B]), type(E, A, ENV), set_env(ENV, X, B).