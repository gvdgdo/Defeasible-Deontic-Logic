% Copyright (c) 2022-2024 Guido Governatori.

#include "language.asp".

% a fact X holds definitely
definite(X) :- fact(X).

% a conclusion X holds definitely, if there is a definitly applicable strict 
% rule for the fact

definite(X) :- strictRule(R,X), definiteApplicable(R,X).
