% Copyright (c) 2022-2026 Guido Governatori.

#include "language.asp".

file("Deontic/deontic.asp", "deontic logic", "2026-01-13").

% Deontic logic module without compensation

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
obligationRebutted(S,Y,X) :- obligationAttacking(S,Y,X),
    discarded(S,Y) : obligationAttacking(S,Y,X). 
obligationRebutted(S,Y,X) :- obligationAttacking(S,Y,X),
    obligationDefeated(S,Y,X) : obligationAttacking(S,Y,X). 

% an obligation X is refuted if all the prescriptive rules for X are either 
% discarded or attacked by an undefeated rule.
obligationRefuted(X) :- literal(X),
    mOpartial(R,X) : prescriptiveRule(R,X).

mOpartial(R,X) :- prescriptiveRule(R,X), discarded(R,X).
% a prescriptive rule R for X is attacked by an undefeated rule S for Y
% if S attacks R and S is applicable and not defeated by an applicable stronger 
% rule T for X
mOpartial(R,X) :- prescriptiveRule(R,X), applicable(R,X),
    obligationAttacking(S,Y,X), applicable(S,Y),
    discarded(T,X) : obligationRebutting(T,S,Y,X), superior(T,S). 
  
% the permission of a literal X holds if there is an applicable
% permissive rule for X and all the attacking prescriptive rules
% have been rebutted.
permission(X) :- permissiveRule(R,X), applicable(R,X),
    permissionRebutted(S,Y,X) : prescriptiveRule(S,Y), opposes(X,Y).

% a (prescriptive) rule S is rebutted for the permission of X if 1) the rule 
% is discarded; or 2) it is defeated by a stronger applicable rule for X.
permissionRebutted(S,Y,X) :- discarded(S,Y), opposes(X,Y).
permissionRebutted(S,Y,X) :-  prescriptiveRule(S,Y), opposes(X,Y),
    permissionDefeated(S,Y,X) : prescriptiveRule(S,Y), opposes(X,Y).

% a (prescriptive) rule S is defeated for X's permission if there is a
% stronger deontic rule T for X that is applicable.
permissionDefeated(S,Y,X) :- 
    prescriptiveRule(S,Y), opposes(X,Y),
    deonticRule(T,X), applicable(T,X), superior(T,S).

% a permission X is refuted if all the permissive rules for X are either
% discarded or attacked by an undefeated prescriptive rule.
permissionRefuted(X) :- literal(X),
    mPpartial(R,X) : permissiveRule(R,X).

mPpartial(R,X) :- permissiveRule(R,X), discarded(R,X).
% a permissive rule R for X is attacked by an undefeated prescriptive rule 
% S for Y when S opposes X and S is applicable and not defeated by an applicable
% stronger rule T for X
mPpartial(R,X) :- permissiveRule(R,X), applicable(R,X),
    prescriptiveRule(S,Y), opposes(X,Y), applicable(S,Y),
    discarded(T,X) : deonticRule(T,X), superior(T,S). 
