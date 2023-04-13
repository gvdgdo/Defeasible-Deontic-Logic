#include "language.asp".

permission(X) :- obligation(X).
permission(X) :- opposes(X,X1), not obligation(X1).

obligation(X) :- obligation(R,X,N).

violation(R,X,N):- obligation(R,X,N), opposes(Y,X), defeasible(Y).

terminalVioaltion(X) :- obligation(R,X,N), violation(R,X,N), not compensate(R,X,_,N).

% safeness or grounding

rule(R,X) :- constitutiveRule(R,X).
rule(R,X) :- prescriptiveRule(R,X).
rule(R,X) :- permissiveRule(R,X).
rule(R,X) :- compensate(R,_,X,_).

% applicable

obligationApplicable(R,X,N) :- prescriptiveRule(R,X), applicable(R), N=1.
obligationApplicable(R,X,N) :- constitutiveRule(R,X), convertObligation(R), N=1.
obligationApplicable(R,X,N) :- compensate(R,Y,X,N-1), violation(R,Y,N-1).

permissionApplicable(R,X) :- permissiveRule(R,X), applicable(R).
permissionApplicable(R,X) :- constitutiveRule(R,X), convertPermission(R).

% attacking

obligationAttackingRule(R,X) :- prescriptiveRule(R,X), applicable(R).  
obligationAttackingRule(R,X) :- permissiveRule(R,X), applicable(R).
obligationAttackingRule(R,X) :- constitutiveRule(R,X), convertObligation(R).
obligationAttackingRule(R,X) :- constitutiveRule(R,X), convertPermission(R).
obligationAttackingRule(R,X) :- compensate(R,Y,X,N), violation(R,Y,N).

permissionAttackingRule(R,X) :- prescriptiveRule(R,X), applicable(R).  
permissionAttackingRule(R,X) :- constitutiveRule(R,X), convertObligation(R).
permissionAttackingRule(R,X) :- compensate(R,Y,X,N), violation(R,Y,N).

% rebutting
rebuttingRule(R,X) :- prescriptiveRule(R,X), applicable(R).
rebuttingRule(R,X) :- constitutiveRule(R,X), convertObligation(R).
rebuttingRule(R,X) :- compensate(R,Y,X,N), violation(R,Y,N).

% obligation

obligation(R,X,N) :-  
    obligationApplicable(R,X,N), 
    not obligationOverruled(R,X).

obligationOverruled(R,X) :- 
    opposes(X1,X), rule(R,X),
    obligationAttackingRule(R1,X1), 
    not obligationDefeated(R1,X1,X).

obligationDefeated(R,X1,X) :-
    opposes(X1,X), rule(R,X1),
    rebuttingRule(S,X),
    superior(S,R).

% permission

permission(X) :- 
    permissionApplicable(R,X),
    not permissionOverruled(R,X).

permissionOverruled(R,X) :- 
    opposes(X1,X), rule(R,X),
    permissionAttackingRule(R1,X1),
    not permissionDefeated(R1,X1,X).

permissionDefeated(R,X) :- 
    opposes(X1,X), rule(R,X1),
    rebuttingRule(S,X),
    superior(S,R).
