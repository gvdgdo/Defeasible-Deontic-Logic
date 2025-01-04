% copyright (c) 2022-2025 Guido Governatori

#include "../Basic/definite.asp".
% #include "defeasible-ap.asp".
#include "../Basic/defeasible-ab.asp".

atom(q).
atom(q1).
atom(q2).
atom(p).
atom(p1).
atom(p2).

rule(r1, p, (p1)).
rule(r2, non(p), (q1)).
rule(r3, p, (p2)).
rule(r4, non(p), (q2)).

superior(r1,r2).
superior(r3,r4).

%%% instantiate the rules.

rule(R,X) :- rule(R,X,_).

applicable(r1,p) :- defeasible(p1).
supported(r1) :- support(p1).
applicable(r2,non(p)) :- defeasible(p1).
supported(r2) :- support(q1).
applicable(r3,p) :- defeasible(p2).
supported(r3) :- support(p2).
applicable(r4,non(p)) :- defeasible(q2).
supported(r4) :- support(q2).

%% facts

{fact(p1;p2;q1;q2)}.


% #show defeasible/1.
#show .
% #show X : fact(X).
#show Y : defeasible(Y),not fact(Y).