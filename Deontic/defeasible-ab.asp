% copyright (c) 2022-2026 Guido Governatori

file("Deontic/defeasible-ab.asp", "Deontic defeasible ambiguity blocking", "2026-05-16").

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
defeated(R,X) :- opposes(X,Y), constitutiveRule(R,X),
    constitutiveRule(S,Y), superior(S,R),
    applicable(S,Y).

% a rule R is rebutted if it is defeated or discarded
rebutted(R,X) :- constitutiveRule(R,X), defeated(R,X).
rebutted(R,X) :- constitutiveRule(R,X), discarded(R,X).

% a conclusion X is defeasibly refuted if the opposite X1 holds definitely
refuted(X) :- opposes(X,X1), fact(X1).

% or if every rule for X (that is not a defeater) is either discarded 
% or attacked by an undefeated rule
refuted(X) :- literal(X), not fact(X), 
    discardedOrRebutted(R,X) : constitutiveRule(R,X).

discardedOrRebutted(R,X) :- constitutiveRule(R,X), discarded(R,X).
discardedOrRebutted(R,X) :- constitutiveRule(R,X), overruled(R,X).

% we use the term overruled to capture the idea that a rule R for X is attacked % by an undefeated rule S for Y, where Y opposes X, and there is no superior 
% rule T for X that is not discarded
overruled(R,X) :- constitutiveRule(R,X),  
    constitutiveRule(S,Y), opposes(X,Y), applicable(S,Y),
    discardedOrNotSuperior(T,X) : constitutiveRule(T,X).

discardedOrNotSuperior(T,X) :- constitutiveRule(T,X), discarded(T,X).
discardedOrNotSuperior(T,X) :- constitutiveRule(T,X), opposes(X,Y),
    constitutiveRule(S,Y), applicable(S,Y), not superior(T,S).
