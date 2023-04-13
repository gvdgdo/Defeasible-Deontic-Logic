#include "language.asp".

defeasible(X) :-  fact(X).

defeasible(X) :-  opposes(X,X1), not fact(X1), 
    rule(R,X), applicable(R),
    not overruled(R,X).

overruled(R,X) :- opposes(X,X1), rule(R,X), 
    rule(R1, X1), applicable(R1),
    not defeated(R1,X1).

defeated(R,X) :- opposes(X,X2),
    rule(R2,X2), superior(R2,R),
    applicable(R2).
