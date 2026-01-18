% copyright (c) 2022-2026 Guido Governatori

#include "language.asp".

file("Deontic/deontic-comp-wf.asp", "2026-01-17").

obligation(X) :- obligation(R,X,N).

violation(R,X,N) :- obligation(R,X,N), opposes(Y,X), defeasible(Y).
weakViolation(R,X,N) :- obligation(R,X,N), refuted(X).

violation(X) :- obligation(X), opposes(Y,X), defeasible(Y).
weakViolation(X) :- obligation(X), refuted(X).

terminalViolation(R) :- 
    obligation(R,X,N), violation(R,X,N), not compensate(R,X,_,N).

terminalViolation(R) :-
    obligation(R,X,N), violation(R,X,N), obligationRefuted(R,X,N+1).

weakViolatedRule(R) :- violation(R,_,_).
violatedRule(R) :- terminalViolation(R).

% safeness or grounding

rule(R,X) :- compensate(R,_,X,_).

% obligation and permission applicable

obligationApplicable(R,X,N) :- prescriptiveRule(R,X), applicable(R,X), N=1.
obligationApplicable(R,X,N) :- constitutiveRule(R,X), convertObligation(R,X), N=1.
obligationApplicable(R,X,N) :- compensate(R,Y,X,N-1), violation(R,Y,N-1).

permissionApplicable(R,X) :- permissiveRule(R,X), applicable(R,X).
permissionApplicable(R,X) :- constitutiveRule(R,X), convertPermission(R,X).

obligationDiscarded(R,X,1) :- prescriptiveRule(R,X), discarded(R,X).
obligationDiscarded(R,X,1) :- constitutiveRule(R,X), not convertObligation(R,X).
% obligationDiscarded(R,X,N) :- obligationDiscarded(R,X,N-1).
obligationDiscarded(R,X,N) :- compensate(R,Y,X,N-1), not violation(R,Y,N-1).

permissionDiscarded(R,X) :- permissiveRule(R,X), discarded(R,X).
permissionDiscarded(R,X) :- constitutiveRule(R,X), not convertPermission(R,X).
% attacking

obligationAttackingRule(S,Y,X) :- 
    prescriptiveRule(S,Y), applicable(S,Y), opposes(X,Y).  
obligationAttackingRule(S,Y,X) :- 
    permissiveRule(S,Y), applicable(S,Y), opposes(X,Y).
obligationAttackingRule(S,Y,X) :- 
    constitutiveRule(S,Y), convertObligation(S,Y), opposes(X,Y).
obligationAttackingRule(S,Y,X) :- 
    constitutiveRule(S,Y), convertPermission(S,Y), opposes(X,Y).
obligationAttackingRule(S,Y,X) :- 
    compensate(S,Z,Y,N), violation(S,Z,N), opposes(X,Y).

permissionAttackingRule(S,Y,X) :- 
    prescriptiveRule(S,Y), applicable(S,Y), opposes(X,Y).  
permissionAttackingRule(S,Y,X) :-
    constitutiveRule(S,Y), convertObligation(S,Y), opposes(X,Y).
permissionAttackingRule(S,Y,X) :- 
    compensate(S,Z,Y,N), violation(S,Z,N), opposes(X,Y).

% rebutting
rebuttingRule(T,X,S,Y) :- prescriptiveRule(T,X), applicable(T,X), 
    1 {obligationAttackingRule(S,Y,X); permissionAttackingRule(S,Y,X) }, rule(S,Y).
rebuttingRule(T,X,S,Y) :- constitutiveRule(T,X), convertObligation(T,X),
    1 {obligationAttackingRule(S,Y,X); permissionAttackingRule(S,Y,X) }, rule(S,Y).
rebuttingRule(T,X,S,Y) :- compensate(T,Z,X,N), violation(T,Z,N),
    1 {obligationAttackingRule(S,Y,X); permissionAttackingRule(S,Y,X) }, rule(S,Y).
rebuttingRule(T,X,S,Y) :- permissiveRule(T,X), applicable(T,X),
    permissionAttackingRule(S,Y,X).
rebuttingRule(T,X,S,Y) :- constitutiveRule(T,X), convertPermission(T,X),
    permissionAttackingRule(S,Y,X).

% obligation

obligation(R,X,N) :-  
    obligationApplicable(R,X,N), literal(X),
    obligationRebutted(S,Y,X) : obligationAttackingRule(S,Y,X).

obligationRebutted(S,Y,X) :- obligationAttackingRule(S,Y,X),
    obligationDiscarded(S,Y,N).
obligationRebutted(S,Y,X) :- obligationAttackingRule(S,Y,X),
    rebuttingRule(T,X,S,Y), superior(T,S).

obligationRefuted(X) :- literal(X), not obligation(X).

permission(X) :- 
    permissionApplicable(R,X), literal(X),
    permissionRebutted(S,Y,X) : permissionAttackingRule(S,Y,X).

permissionRebutted(S,Y,X) :- permissionAttackingRule(S,Y,X),
    permissionDiscarded(S,Y).
permissionRebutted(S,Y,X) :- permissionAttackingRule(S,Y,X),
    rebuttingRule(T,X,S,Y), superior(T,S).

permissionRefuted(X) :- literal(X), not permission(X).

