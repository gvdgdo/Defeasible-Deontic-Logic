% Copyright (c) 2022-2026 Guido Governatori.

file("Basic/language.asp", "basic language", "2026-01-09").

#include "../language.asp".

% a rule is either a strict rule, a defeasible rule or a defeater
rule(R,X) :- strictRule(R,X).
rule(R,X) :- defeasibleRule(R,X).
rule(R,X) :- defeater(R,X).

% a rule R is applicable if all the members of the body are 
% defeasibly provable
applicable(R,X) :- rule(R,X),
    defeasible(Y) : body(R,Y).

% a rule R is discarded if at least one member of the body is
% defeasibly refuted
discarded(R,X) :- rule(R,X),
    body(R,Y), refuted(Y).

% a rule R is supported if all the members of the body are 
% defeasibly supported
support(R,X) :-  rule(R,X),
    supported(Y) : body(R,Y).

% a rule R is unsupported if at least one member of the body is
% defeasibly not supported
unsupport(R,X) :- rule(R,X),
    unsupported(Y), body(R,Y).
