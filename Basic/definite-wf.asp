% Copyright (c) 2022-2026 Guido Governatori.

version("definite well-founded", "2026-01-09").

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

% a literal X is definitely refuted if it is not definitely provable
definiteRefuted(X) :- literal(X), not definite(X).

% a strict rule R is definitely discarded if at least one element of the
% body is definitely refuted
definiteDiscarded(R,X) :- strictRule(R,X), 
     body(R,Y), definiteRefuted(Y).
