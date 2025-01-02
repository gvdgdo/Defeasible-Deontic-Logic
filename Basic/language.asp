% Copyright (c) 2022-2025 Guido Governatori.

#include "language.asp".

% a rule is either a strict rule, a defeasible rule or a defeater
rule(R,X) :- strictRule(R,X).
rule(R,X) :- defeasibleRule(R,X).
rule(R,X) :- defeater(R,X).
