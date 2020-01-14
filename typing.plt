use_module(library(plunit)).
consult(typing).

:- begin_tests(typing).
test(eq) :- =(2, 2).
:- end_tests(typing).