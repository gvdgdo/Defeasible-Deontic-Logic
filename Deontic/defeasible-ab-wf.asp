% copyright (c) 2022-2026 Guido Governatori

file("Deontic/defeasible-ab-wf.asp", "Deontic defeasible ambiguity propagation well founded", "2026-01-18").

#include "language.asp".

% every fact X holds defeasibly
defeasible(X) :- fact(X).

% X holds defeasibly, it there is not fact X1 opposing X, and
% there is an applicable constitutiveRule R for X that is not 
% overruled for X.
defeasible(X) :-  
    not fact(X1) : opposes(X,X1); 
    constitutiveRule(R,X), applicable(R,X),
    rebutted(S,Y) : opposes(X,Y), constitutiveRule(S,Y).

% a constitutiveRule R for X is defeated if it is attacked by a superior constitutiveRule 
defeated(R,X) :- opposes(X,X2), constitutiveRule(R,X),
    constitutiveRule(R2,X2), superior(R2,R),
    applicable(R2,X2).

% a rule R is rebutted if it is defeated or discarded
rebutted(R,X) :- constitutiveRule(R,X), defeated(R,X).
rebutted(R,X) :- constitutiveRule(R,X), discarded(R,X).

% a conclusion X is defeasibly refuted if does not hold defeasibly
refuted(X) :- literal(X), not defeasible(X).
