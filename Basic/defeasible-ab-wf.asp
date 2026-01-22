% copyright (c) 2022-2026 Guido Governatori

#include "definite.asp".

file("Basic/defeasible-ab-wf.asp", "defeasible ambiguity blocking well-founded", "2026-01-09").

% if a conclusion X holds definitely, it also holds defeasibly
defeasible(X) :-  definite(X).

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

% a conclusion is defeasibly refuted if it is not defeasible provable
refuted(X) :- literal(X), not defeasible(X).
