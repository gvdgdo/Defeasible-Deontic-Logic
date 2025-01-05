% Copyright (c) 2022-2025 Guido Governatori.

#include "language.asp".

permission(X) :- obligation(X).
permission(X) :- opposes(X,X1), not obligation(X1).

deonticRule(R,X) :- prescriptiveRule(R,X).
deonticRule(R,X) :- permissiveRule(R,X).

obligation(X) :- prescriptiveRule(R,X), 
    applicable(R,X), not deonticOverruled(R,X).

obligation(X) :- constitutiveRule(R,X), 
    obligationApplicable(R,X), not deonticOverruled(R,X).

permission(X) :- permissiveRule(R,X), 
    applicable(R,X), not deonticOverruled(R,X).

permission(X) :- constitutiveRule(R,X), 
    permissionApplicable(R,X), not deonticOverruled(R,X).

deonticOverruled(R,X) :- prescriptiveRule(R,X), 
    deonticRule(R1,X1), opposes(X,X1),  applicable(R1,X1),
    not deonticDefeated(R1,X1).

deonticOverruled(R,X) :- permissiveRule(R,X), 
    prescriptiveRule(R1,X1), opposes(X,X1), applicable(R1,X1),
    not deonticDefeated(R1,X1).
 
deonticDefeated(R,X) :- opposes(X,X1),
    prescriptiveRule(R,X), deonticRule(R1,X1), 
    applicable(R1,X1), superior(R1,R).

deonticDefeated(R,X) :- opposes(X,X1),
    permissiveRule(R,X), prescriptiveRule(R1,X1), 
    applicable(R1,X1), superior(R1,R).

