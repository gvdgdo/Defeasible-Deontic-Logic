% copyright (c) 2022-2025 Guido Governatori

#include "language.asp".

% every fact X holds defeasibly
defeasible(X) :-  fact(X).

% X holds defeasibly, it there is not fact X1 opposing X, and
% there is an applicable constitutive rule R for X that is not overruled for X.
defeasible(X) :-  opposes(X,X1), not fact(X1), 
    constitutiveRule(R,X), applicable(R,X),
    not overruled(R,X).

% a constitutive rule R for X is overruled if there is an applicable  and 
% undefeated constitutive rule R1 for a literal X1 that opposes X
overruled(R,X) :- opposes(X,X1), constitutiveRule(R,X), 
    constitutiveRule(R1, X1), applicable(R1,X1),
    not defeated(R1,X1).

% a constitutive rule R for X is defeated if there is a stronger, undefeated 
% constitutive rule R1 for a literal X2 opposing X. 
defeated(R,X) :- opposes(X,X2),
    constitutiveRule(R2,X2), superior(R2,R),
    applicable(R2,X2).
