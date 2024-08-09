% Copyright (c) 2022-2024 Guido Governatori.

#include "definite.asp".

support(X) :- definite(X).

support(X) :- rule(R,X), not defeater(R,X),
    supported(R,X), not beaten(R,X).

beaten(R,X) :- rule(R,X), opposes(X,X1), fact(X1).

beaten(R,X) :- rule(R,X), opposes(X,X1), 
    rule(R1,X1), supported(R1,X1), superior(R1,R).

defeasible(X) :-  definite(X).

defeasible(X) :-  opposes(X,X1), not definite(X1), 
    rule(R,X), not defeater(R,X), applicable(R,X),
    not overruled(R,X).

overruled(R,X) :- opposes(X,X1), rule(R,X), 
    rule(R1, X1), supported(R1,X1),
    not defeated(R1,X1).

defeated(R,X) :- opposes(X,X2),
    rule(R2,X2), superior(R2,R),
    applicable(R2,X2).

support(X) :- defeasible(X).
supported(R,X) :- applicable(R,X).
applicable(R,X) :- definiteApplicable(R,X).
