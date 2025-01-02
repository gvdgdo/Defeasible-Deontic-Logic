% copyright (c) 2022-2025 Guido Governatori

#include "definite.asp".

% if a conclusion X holds definitely, it also holds defeasibly
defeasible(X) :-  definite(X).

% X holds defeasibly, it there is not fact X1 opposing X, and
% there is an applicable rule R for X that is not overruled for X.
defeasible(X) :-  opposes(X,X1), not definite(X1), 
    rule(R,X), not defeater(R,X), applicable(R,X),
    not overruled(R,X).

% a rule R for X is overruled if there is an applicable  and 
% undefeated rule R1 for a literal X1 that opposes X
overruled(R,X) :- opposes(X,X1), rule(R,X), 
    rule(R1, X1), applicable(R1,X1),
    not defeated(R1,X1).

% a rule R for X is defeated if there is a stronger, undefeated 
% rule R1 for a literal X2 opposing X. 
defeated(R,X) :- opposes(X,X2),
    rule(R2,X2), superior(R2,R),
    applicable(R2,X2).

applicable(R,X) :- definiteApplicable(R,X).
