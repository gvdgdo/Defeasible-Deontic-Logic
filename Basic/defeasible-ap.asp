% Copyright (c) 2022-2026 Guido Governatori.

#include "definite.asp".

% identifier
file("Basic/defeasible-ap.asp", "defeasible ambiguity propagation", "2026-01-09").

% if a conclusion X holds definitely, it is also supported
supported(X) :- definite(X).

% a literal X is supported if any literal opposing it is 
% definitely refuted and there is a rule R for X that is supported
% and  
supported(X) :- 
    definiteRefuted(X1) : opposes(X,X1);
    rule(R,X), not defeater(R,X), support(R,X), 
    discarded(S,Y) : opposes(X,Y), rule(S,Y), superior(S,R).

% a literal X is unsupported if the opposite is definitely true
unsupported(X) :- opposes(X,Y), definite(Y).
% a literal X is unsupported if all rules for X do not support the 
% literal
unsupported(X) :-literal(X), not definite(X), 
    msigma(R,X) : rule(R,X).

% a rule R does not support X if at least one member of the body is
% unsupported or if there is an applicable superior rule for an opposing
% literal
msigma(R,X) :- rule(R,X), body(R,Y), unsupported(Y).
msigma(R,X) :- rule(R,X), rule(X,Y), opposes(X,Y), 
    applicable(Y), superior(S,R).

% a literal X is defeasibly provable if any literal opposing it is
% definitely refuted and there is a rule R (not a defeater) for X that 
% is applicable and all rules S for opposing literals Y are rebutted
defeasible(X) :- 
    definiteRefuted(X1) : opposes(X,X1); 
    rule(R,X), not defeater(R,X), applicable(R,X),
    rebutted(S,Y) : opposes(X,Y), rule(S,Y). 

% a rule R is rebutted if it is either unsupported or defeated
rebutted(R,X) :- unsupport(R,X).
rebutted(R,X) :- defeated(R,X).

% a rule R is defeated it there is a supported superior rule S
% for and opposing literal X2
defeated(R,X) :- opposes(X,X2), rule(R,X),
    rule(R2,X2), support(R2,X2), superior(R2,R).

% a literal X is refuted if the opposite X1 holds definitely
refuted(X) :- opposes(X,X1), definite(X1).
% a literal X is refuted if it is not defeasibly provable
% and all rules for it are either discarded or attacked
refuted(X) :- literal(X), not definite(X), 
    refutedOrAttacked(R,X) : rule(R,X).

% a rule R is either discarded or attacked
refutedOrAttacked(R,X) :- discarded(R,X).
refutedOrAttacked(R,X) :- attacked(R,X).

% a rule R is attacked if there is a supported rule for an opposing literal
attacked(R,X) :- rule(R,X), opposes(X,X2),
    rule(R2,X2), support(R2,X2).

% inheritances
defeasible(X) :- definite(X).
support(X) :- defeasible(X).
supported(R,X) :- applicable(R,X).
applicable(R,X) :- definiteApplicable(R,X).
