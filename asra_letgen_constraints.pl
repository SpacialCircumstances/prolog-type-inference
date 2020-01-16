[constraint_hm].

res(T9) :-
    eq(T4, T3),
    eq_gen(T5, [func, T3, T4], []),
    eq_gen(T7, [func, T3, T4], []),
    eq(T5, [func, int, T6]),
    eq_gen(T9, T6, []),
    eq(T7, [func, string, T8]).