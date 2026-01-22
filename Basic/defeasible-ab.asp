% copyright (c) 2022-2026 Guido Governatori

#include "definite.asp".

file("Basic/defeasible-ab.asp", "defeasible ambiguity blocking", "2026-01-09").

% if a conclusion X holds definitely, it also holds defeasibly
defeasible(X) :- definite(X).

% X holds defeasibly, it there is not fact X1 opposing X, and
% there is an applicable and all rules for opposite literals 
% have been rebutted
defeasible(X) :-  
    definiteRefuted(X1) : opposes(X,X1); 
    rule(R,X), not defeater(R,X), applicable(R,X),
    rebutted(S,Y) : opposes(X,Y), rule(S,Y). 

% a rule R for X is defeated if it is attacked by a superior rule 
defeated(R,X) :- opposes(X,X2), rule(R,X),
    rule(R2,X2), superior(R2,R),
    applicable(R2,X2).
    
% a rule R is rebutted if it is defeated or discarded
rebutted(R,X) :- rule(R,X), defeated(R,X).
rebutted(R,X) :- rule(R,X), discarded(R,X).

% a rules is applicable if it is definitely applicable
applicable(R,X) :- definiteApplicable(R,X).

% a conclusion X is defeasibly refuted if the opposite X1 holds definitely
refuted(X) :- opposes(X,X1), definite(X1).

% or if every rule for X (that is not a defeater) is either discarded 
% or attacked by an undefeated rule
refuted(X) :- literal(X), not definite(X),
    mpartial(R,X) : rule(R,X).

mpartial(R,X) :- rule(R,X), discarded(R,X) : rule(R,X), not defeater(R,X).
mpartial(R,X) :- rule(R,X), rule(S,Y), opposes(X,Y), applicable(S,Y),
     discarded(T,X) : rule(T,X), superior(T,S).
     