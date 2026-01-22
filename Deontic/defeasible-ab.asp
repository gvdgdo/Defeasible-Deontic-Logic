% copyright (c) 2022-2026 Guido Governatori

file("Deontic/defeasible-ab.asp", "Deontic defeasible ambiguity blocking", "2026-01-09").

#include "language.asp".

% every fact X holds defeasibly
defeasible(X) :-  fact(X).

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

% a conclusion X is defeasibly refuted if the opposite X1 holds definitely
refuted(X) :- opposes(X,X1), fact(X1).

% or if every rule for X (that is not a defeater) is either discarded 
% or attacked by an undefeated rule
refuted(X) :- literal(X), not fact(X),
    mpartial(R,X) : constitutiveRule(R,X).

mpartial(R,X) :- constitutiveRule(R,X), discarded(R,X) : constitutiveRule(R,X).
mpartial(R,X) :- constitutiveRule(R,X),  
    constitutiveRule(S,Y), opposes(X,Y), applicable(S,Y),
    discarded(T,X) : constitutiveRule(T,X), superior(T,S).
    