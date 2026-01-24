% copyright (c) 2022-2026 Guido Governatori

#include "language.asp".

file("Deontic/deontic-comp.asp", "deontic logic with compensation and conversion", "2026-01-20").

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

% it is not possible to use sequences in ASP. Thus, for compensatory 
% obligations we need to introduce the compensate/4 predicate, where
% the first argument is the rule name, the second argument is the violated 
% obligation literal, the third argument is the compensating obligation literal,
% and the fourth argument is the level of compensation (1 for first 
% compensation, 2 for second compensation, etc).  However, they are part of 
% the same rule; so, X is one of the possible conclusion of rule R.  
rule(R,X) :- compensate(R,_,X,_).

% an obligation rule (a rule able to derive an obligation) is 
% either a prescriptive rule, a constitutive rule that converts to an
% obligation, or a compensatory rule where the obligation is derived
% as compensation for the violation of another obligation.
obligationRule(R,X) :- prescriptiveRule(R,X).
obligationRule(R,X) :- 
    constitutiveRule(R,X), convertObligation(R,X).
obligationRule(R,X) :-
    compensate(R,Y,X,N), violation(R,Y,N).

% a permission rule (a rule able to derive a permission) is
% either a permissive rule, or a constitutive rule that converts to a
% permission.
permissionRule(R,X) :- permissiveRule(R,X).
permissionRule(R,X) :- 
    constitutiveRule(R,X), convertPermission(R,X).

% a deontic rule is either an obligation rule or a permission rule
deonticRule(R,X) :- obligationRule(R,X).
deonticRule(R,X) :- permissionRule(R,X).

% a rule R is obligation applicable for X at index N, if is it 
% a prescriptive rule applicable for X (at index 1), or a 
% constitutive rule converting to obligation for X, or it is a 
% compensatory obligation for X at index N, where the  
% compensated obligation Y at index N-1 has been violated.
obligationApplicable(R,X,N) :- prescriptiveRule(R,X), applicable(R,X), N=1.
obligationApplicable(R,X,N) :- constitutiveRule(R,X), convertObligation(R,X), N=1.
obligationApplicable(R,X,N) :- compensate(R,Y,X,N-1), violation(R,Y,N-1).

% a rule R is permission applicable for X, if is it an applicable permissive
% rule for X, or a constitutive rule converting to permission for X.
permissionApplicable(R,X) :- permissiveRule(R,X), applicable(R,X).
permissionApplicable(R,X) :- constitutiveRule(R,X), convertPermission(R,X).

% a rule R for X is deontic applicable if it is either obligation applicable
% or permission applicable.
deonticApplicable(R,X) :- obligationApplicable(R,X,_).
deonticApplicable(R,X) :- permissionApplicable(R,X).

% a rule R for X is obligation discarded at index N, if it is
% a prescriptive rule discarded for X, or a constitutive rule that does not 
% convert to obligation, or a compensatory obligation for X at index N,
% where the compensated obligation Y at index N-1 has not been violated.
obligationDiscarded(R,X,1) :- prescriptiveRule(R,X), discarded(R,X).
obligationDiscarded(R,X,1) :- constitutiveRule(R,X), not convertObligation(R,X).
obligationDiscarded(R,X,N) :- compensate(R,Y,X,N-1), not violation(R,Y,N-1).

% a rule R for X is permission discarded if it is a permissive rule
% discarded for X, or a constitutive rule that does not convert to permission.
permissionDiscarded(R,X) :- permissiveRule(R,X), discarded(R,X).
permissionDiscarded(R,X) :- constitutiveRule(R,X), not convertPermission(R,X).

% a rule S for Y attacks an obligation rule for X, if S is a deontic rule for
% Y and Y opposes X.
obligationAttacking(S,Y,X) :- 
    deonticRule(S,Y), opposes(X,Y).

% however only obligation rules for Y can attack an obligation for X when
% Y opposes X. 
permissionAttacking(S,Y,X) :- 
    obligationRule(S,Y), opposes(X,Y).

% only an obligation rule T for X can rebut a rule S for Y attacking an 
% obligation for X.
obligationRebutting(T,S,Y,X) :- 
    obligationRule(T,X), obligationAttacking(S,Y,X).

% a rule S for Y attacking an obligation for X is defeated if there
% an obligation rule T for X that is applicable and superior to S. 
obligationDefeated(S,Y,X) :- obligationRebutting(T,S,Y,X),
    obligationApplicable(T,X,N), superior(T,S).

% a rule S for Y attacking an obligation for X is rebutted if
% 1) S for Y is discarded, or 2) it is defeated 
obligationRebutted(S,Y,X) :- obligationAttacking(S,Y,X),
    obligationDiscarded(S,Y,N).
obligationRebutted(S,Y,X) :- obligationAttacking(S,Y,X),
    obligationDefeated(S,Y,X).

% an obligation for X derived from rule R at index N holds if
% rule R is an obligation rule for X, it is applicable at index N,
% and all the rules S for Y attacking it are rebutted.
obligation(R,X,N) :- obligationRule(R,X), obligationApplicable(R,X,N),
    obligationRebutted(S,Y,X) : obligationAttacking(S,Y,X).

% an obligation for X is refuted if every obligation rule R for X
%  discarded or it is attacked by a rule S for Y that is not rebutted.
obligationRefuted(X) :- literal(X),
    mOpartial(R,X) : obligationRule(R,X).

mOpartial(R,X) :- 
    obligationRule(R,X), obligationDiscarded(R,X,N).

mOpartial(R,X) :- 
    obligationRule(R,X), obligationApplicable(R,X,_), obligationAttacking(S,Y,X),
    obligationDiscarded(T,X,N) : obligationRebutting(T,X,S,Y), superior(T,S), deonticApplicable(S,Y).

% a permission for X holds if there is a permission applicable permission 
% rule R for X, and  all the attacking obligation rules S for Y are 
% rebutted     
permission(X) :- permissionRule(R,X), permissionApplicable(R,X),
    permissionRebutted(S,Y,X) : obligationRule(S,Y), opposes(X,Y).

% a rule S for Y is rebutted for a permission for X if 1) the rule S for Y
% is discarded, 2) or it is defeated by a deontic rule T for X that is
% stronger and applicable
permissionRebutted(S,Y,X) :- obligationDiscarded(S,Y,N), opposes(X,Y).
permissionRebutted(S,Y,X) :- obligationRule(S,Y), opposes(X,Y),
    permissionDefeated(S,Y,X).

permissionDefeated(S,Y,X) :- 
    obligationRule(S,Y), opposes(X,Y),
    deonticRule(T,X), deonticApplicable(T,X), superior(T,S).

% a permission for X is refuted if every permission rule R for X
% is discarded or it is attacked by an obligation rule S for Y
permissionRefuted(X) :- literal(X),
    mPpartial(R,X) : permissionRule(R,X).

mPpartial(R,X) :- permissionRule(R,X), permissionDiscarded(R,X).
mPpartial(R,X) :- permissionRule(R,X), permissionApplicable(R,X),
    obligationRule(S,Y), opposes(X,Y), 
    obligationDiscarded(T,X) : obligationRule(T,X), superior(T,S),obligationApplicable(S,Y,_);
    permissionDiscarded(T,X) : permissionRule(T,X), superior(T,S),obligationApplicable(S,Y,_).
