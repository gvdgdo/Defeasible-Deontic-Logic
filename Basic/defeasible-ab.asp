% copyright (c) 2022-2026 Guido Governatori

#include "definite.asp".

file("Basic/defeasible-ab.asp", "defeasible ambiguity blocking", "2026-05-16").

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
defeated(R,X) :- opposes(X,Y), rule(R,X),
    rule(S,Y), superior(S,R),
    applicable(S,Y).
    
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
    discardedOrRebutted(R,X) : rule(R,X), not defeater(R,X).

discardedOrRebutted(R,X) :- rule(R,X), not defeater(R,X), discarded(R,X).
discardedOrRebutted(R,X) :- rule(R,X), not defeater(R,X), overruled(R,X).
    
% we use the term overruled to capture the idea that a rule R for X is attacked % by an undefeated rule S for Y, where Y opposes X, and there is no superior 
% rule T for X that is not discarded
overruled(R,X) :- rule(R,X), rule(S,Y), opposes(X,Y), applicable(S,Y),
    discardedOrNotSuperior(T,X) : rule(T,X).

discardedOrNotSuperior(T,X) :- rule(T,X), discarded(T,X).
discardedOrNotSuperior(T,X) :- rule(T,X), opposes(X,Y), rule(S,Y), 
    applicable(S,Y), not superior(T,S).
