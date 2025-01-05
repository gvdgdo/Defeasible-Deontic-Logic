% Copyright (c) 2022-2025 Guido Governatori.

#include "language.asp".

% a fact X holds definitely
definite(X) :- fact(X).

% a conclusion X holds definitely, if there is a definitely applicable strict 
% rule for the fact
definite(X) :- strictRule(R,X), definiteApplicable(R,X).

% an element Y of the body the strict rule X is not definitely provable
existNotBody(R,X) :- 
    strictRule(R,X), body(R,Y), not definite(Y).

% a strict rule R is definitely applicable if all the elements of the body 
% are definitely provable 
definiteApplicable(R,X) :- 
    strictRule(R,X), not existNotBody(R,X).
    