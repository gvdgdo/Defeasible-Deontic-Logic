% Copyright (c) 2022-2026 Guido Governatori.

file("Basic/definite.asp", "definite", "2026-01-09").

#include "language.asp".

% a fact X holds definitely
definite(X) :- fact(X).

% a conclusion X holds definitely, if there is a definitely applicable strict 
% rule for the fact
definite(X) :- strictRule(R,X), definiteApplicable(R,X).

% a strict rule R is definitely applicable if all the elements of the body 
% are definitely provable 
definiteApplicable(R,X) :- 
    strictRule(R,X), definite(Y) : body(R,Y).

% a conclusion X is definitely refuted if it is not a fact, and all rules for 
% it are definitely discarded
definiteRefuted(X) :- literal(X), not fact(X), 
    definiteDiscarded(R,X) : strictRule(R,X).

% a strict rule R is definitely discarded if at least one element of the
% body is definitely refuted
definiteDiscarded(R,X) :- strictRule(R,X), 
     body(R,Y), definiteRefuted(Y).
