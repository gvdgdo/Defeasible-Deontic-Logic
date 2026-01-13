% Copyright (c) 2022-2026 Guido Governatori.

#include "language.asp".

file("deontic-wf.asp").
version("deontic well-founded", "2026-01-13").

% Deontic logic module without compensation

% a literal X is permitted if it is obligatory 
permission(X) :- obligation(X).
% a literal X is (weakly) permitted if its opposite is not obligatory
weekPermission(X) :- opposes(X,Y), not obligation(Y).
% a literal X is (weakly) permitted if its negation is not obligatory
weakPermission(X) :- negation(X,Y), not obligation(Y).
weakPermission(X) :- negation(Y,X), not obligation(Y).

% a weakly permitted literal X is permitted. 
permission(X) :- weakPermission(X).

% a deontic rule is either a prescriptive rule or a permissive rule
deonticRule(R,X) :- prescriptiveRule(R,X).
deonticRule(R,X) :- permissiveRule(R,X).

% the obligation of a literal X holds if there is an applicable
% prescriptive rule for X and all the attacking obligation rules 
% have been rebutted.
obligation(X) :- prescriptiveRule(R,X), applicable(R,X),
    obligationRebutted(S,Y,X) : obligationAttacking(S,Y,X).

% a rule S attacks the obligation of X if it is a deontic rule for Y
% and X opposes Y.
obligationAttacking(S,Y,X) :- 
    opposes(X,Y), deonticRule(S,Y).

% only prescriptive rules can rebutting an attacking rule (and only for the 
% literal that the attacking rule attacks).     
obligationRebutting(T,S,Y,X) :-
    obligationAttacking(S,Y,X), prescriptiveRule(T,X).     

% a deontic rule S is defeated for the obligation of X if there is a
% stronger prescriptive rule T for X that is applicable.
obligationDefeated(S,Y,X) :- 
    obligationRebutting(T,S,Y,X),
    prescriptiveRule(T,X), applicable(T,X), superior(T,S).

% a obligation attacking rule S for Y against X is rebutted if 
% 1) it is discarded; or 2) it is defeated.
obligationRebutted(S,Y,X) :- 
    discarded(S,Y) : obligationAttacking(S,Y,X); obligationAttacking(S,Y,X).
obligationRebutted(S,Y,X) :- obligationAttacking(S,Y,X),
    obligationDefeated(S,Y,X) : obligationAttacking(S,Y,X). 

% the obligation of a literal X is rejected if the literal is not obligatory
obligationRefuted(X) :- literal(X), not obligation(X).

% the permission of a literal X holds if there is an applicable
% permissive rule for X and all the attacking prescriptive rules
% have been rebutted.
permission(X) :- permissiveRule(R,X), applicable(R,X),
    permissionRebutted(S,Y,X) : prescriptiveRule(S,Y), opposes(X,Y).

% a (prescriptive) rule S is rebutted for the permission of X if 1) the rule 
% is discarded; or 2) it is defeated by a stronger applicable rule for X.
permissionRebutted(S,Y,X) :- discarded(S,Y), opposes(X,Y).
permissionRebutted(S,Y,X) :- prescriptiveRule(S,Y), opposes(X,Y),
    permissionDefeated(S,Y,X) : prescriptiveRule(S,Y).

% a (prescriptive) rule S is defeated for X's permission if there is a
% stronger deontic rule T for X that is applicable.
permissionDefeated(S,Y,X) :- 
    prescriptiveRule(S,Y), opposes(X,Y),
    deonticRule(T,X), applicable(T,X), superior(T,S).

% the permission of a literal X is rejected if the literal is not permitted
permissionReject(X) :- literal(X), not permission(X).
