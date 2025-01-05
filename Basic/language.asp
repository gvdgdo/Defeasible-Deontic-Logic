% Copyright (c) 2022-2025 Guido Governatori.

#include "../language.asp".

% a rule is either a strict rule, a defeasible rule or a defeater
rule(R,X) :- strictRule(R,X).
rule(R,X) :- defeasibleRule(R,X).
rule(R,X) :- defeater(R,X).

% a rule R for X has at least one member of the body that is not 
% defeasibly provable. 
bodyNotDefeasible(R,X) :- rule(R,X),
    body(R,Y), not defeasible(Y).

% a rule R is applicable if all the members of the body are 
% defeasibly provable (negation of bodyNotDefeasible)
applicable(R,X) :- rule(R,X),
    not bodyNotDefeasible(R,X).

% a rule R for X has at least one member of the body that is not 
% supported. 
bodyNotSupport(R,X) :- rule(R,X),
    body(R,Y), not support(Y).

% a rule R is supported if all the members of the body are 
% defeasibly supported (negation of bodyNotSupport)
supported(R,X) :-  rule(R,X),
    not bodyNotSupport(R,X).
