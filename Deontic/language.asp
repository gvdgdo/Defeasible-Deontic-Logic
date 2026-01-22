% Copyright (c) 2022-2026 Guido Governatori 

version("deontic language", "2026-01-09").

#include "../language.asp".

% a rule is either  a constitutive, prescriptive, or permissive rule
rule(R,X) :- constitutiveRule(R,X).
rule(R,X) :- prescriptiveRule(R,X).
rule(R,X) :- permissiveRule(R,X).

% a deontic rule is either a prescriptive rule or a permissive rule
deonticRule(R,X) :- prescriptiveRule(R,X).
deonticRule(R,X) :- permissiveRule(R,X).

% a literal is an obligation when it is of the form obl(Z) or non(obl(Z))
% isObligation(Y) :- literal(Z), Y = obl(Z).
% isObligation(Y) :- literal(Z), Y = non(obl(Z)).

% a literal is a permission when it is of the form per(Z) or non(per(Z))
% isPermission(Y) :- literal(Z), Y = per(Z).
% isPermission(Y) :- literal(Z), Y = non(per(Z)).

% a rule is applicable plain literals hold defeasibly, 
% positive obligation and permission hold, and negative obligations and 
% permissions have been refuted
applicable(R,X) :- rule(R,X),
    defeasible(Y) : body(R,Y), literal(Y);
    obligation(Y) : body(R,X), X = obl(Y);
    obligationRefuted(Y) : body(R,X), X = non(obl(Y));
    permission(Y) : body(R,X), X = per(Y);
    permissionRefuted(Y) : body(R,X), X = non(per(Y)).

% a rule is discarded if at least one of its body plain literals 
% is refuted; or a positive obligation or permission in the body 
% does not hold; or a negative obligation or permission in the body 
% holds.
discarded(R,X) :- rule(R,X),
    body(R,Y), refuted(Y).
discarded(R,X) :- rule(R,X),
    body(R,obl(Y)), obligationRefuted(Y).
discarded(R,X) :- rule(R,X),
    body(R,non(obl(Y))), obligation(Y).
discarded(R,X) :- rule(R,X),
    body(R,per(Y)), permissionRefuted(Y).
discarded(R,X) :- rule(R,X),
    body(R,non(per(Y))), permission(Y).

% a constitutive rule can be converted into a prescriptive  rule if
% its body does not contain deontic literals; and all the literals in 
% the body are provable as obligations. 
convertObligation(R,X) :- 
    constitutiveRule(R,X), body(R,_),
    not body(R,obl(_)), not body(R,non(obl(_))),
    not body(R,per(_)), not body(R,non(per(_))),
    obligation(Y) : body(R,Y).

% a constitutive rule can be converted into a permissive rule if
% its body does not contain deontic literals; and all the literals in
% the body are provable as permissions.
convertPermission(R,X) :- 
    constitutiveRule(R,X), body(R,_),
    not body(R,obl(_)), not body(R,non(obl(_))),
    not body(R,per(_)), not body(R,non(per(_))),
    permission(Y) : body(R,Y).

% a literal X is permitted if it is obligatory 
permission(X) :- obligation(X).
% a literal X is (weakly) permitted if its opposite is not obligatory
weekPermission(X) :- opposes(X,Y), not obligation(Y).
% a literal X is (weakly) permitted if its negation is not obligatory
weakPermission(X) :- negation(X,Y), not obligation(Y).
weakPermission(X) :- negation(Y,X), not obligation(Y).

% a weakly permitted literal X is permitted. 
% permission(X) :- weakPermission(X).

% a violation occurs when an obligation holds and its opposite 
% defeasibly holds
violation(X) :- obligation(X), opposes(Y,X), defeasible(Y).

% a direct violation occurs when an obligation holds and 
% its negation defeasibly holds ()
directViolation(X) :- obligation(X), opposes(X,Y), 
    not conflict(X,Y), defeasible(Y).

% a non compliance issues occurs whan an obligation bolds
% and but the content of the obligation
notComplied(X) :- obligation(X), refuted(X).
