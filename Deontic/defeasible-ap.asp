% Copyright (c) 2022-2025 Guido Governatori.

#include "language.asp".

support(X) :- fact(X).

support(X) :- constitutiveRule(R,X),
    supported(R,X), not beaten(R,X).

beaten(R,X) :- constitutiveRule(R,X), opposes(X,X1), fact(X1).

beaten(R,X) :- constitutiveRule(R,X), opposes(X,X1), 
    constitutiveRule(R1,X1), supported(R1,X1), superior(R1,R).

defeasible(X) :-  fact(X).

defeasible(X) :-  opposes(X,X1), not fact(X1), 
    constitutiveRule(R,X), applicable(R,X),
    not overruled(R,X).

overruled(R,X) :- opposes(X,X1), constitutiveRule(R,X), 
    constitutiveRule(R1, X1), supported(R1,X1),
    not defeated(R1,X1).

defeated(R,X) :- opposes(X,X2),
    constitutiveRule(R2,X2), superior(R2,R),
    applicable(R2,X2).

support(X) :- defeasible(X).
supported(R,X) :- applicable(R,X).