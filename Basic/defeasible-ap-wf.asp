% Copyright (c) 2022-2026 Guido Governatori.

#include "definite.asp".

% identifier
version("ambiguity propagation well-founded", "2026-01-09").

% if a conclusion X holds definitely, it is also supported
supported(X) :- definite(X).

% a literal X is supported if any literal opposing it is 
% definitely refuted and there is a rule R for X that is supported
% and  
supported(X) :- 
    definiteRefuted(X1) : opposes(X,X1);
    rule(R,X), not defeater(R,X), support(R,X), 
    discarded(S,Y) : opposes(X,Y), rule(S,Y), superior(S,R).

% a literal X is unsupported if it is not supported
unsupported(X) :- literal(X), not supported(X).

% a literal X is defeasibly provable if any literal opposing it is
% definitely refuted and there is a rule R for X that is applicable
% and all rules S for opposing literals Y are rebutted
defeasible(X) :- 
    definiteRefuted(X1) : opposes(X,X1); 
    rule(R,X), not defeater(R,X), applicable(R,X),
    rebutted(S,Y) : opposes(X,Y), rule(S,Y). 

% a rule R is rebutted if it is either unsupported or defeated
rebutted(R,X) :- unsupport(R,X).
rebutted(R,X) :- defeated(R,X).

% a rule R is defeated it there is a supported superior rule S for and
% opposing literal X2
defeated(R,X) :- opposes(X,X2), rule(R,X),
    rule(R2,X2), support(R2,X2), superior(R2,R).

% a literal X is refuted if it is not defeasibly provable 
refuted(X) :- literal(X), not defeasible(X).

% inheritances
defeasible(X) :- definite(X).
support(X) :- defeasible(X).
supported(R,X) :- applicable(R,X).
applicable(R,X) :- definiteApplicable(R,X).
