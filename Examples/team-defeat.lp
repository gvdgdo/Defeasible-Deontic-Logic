% #include "defeasible-ap.asp".
#include "defeasible-ab.asp".

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

applicable(r1) :- defeasible(p1).
supported(r1) :- support(p1).
applicable(r2) :- defeasible(p1).
supported(r2) :- support(q1).
applicable(r3) :- defeasible(p2).
supported(r3) :- support(p2).
applicable(r4) :- defeasible(q2).
supported(r4) :- support(q2).

%% facts

{fact(p1;p2;q1;q2)}.

#show defeasible/1.
