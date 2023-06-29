% #include "defeasible-ab.asp".
#include "defeasible-ap.asp".

atom(p). atom(a1). atom(a2). atom(a3).

rule(r1, p, (a1)).
rule(r2, non(p), (a2)).
rule(r3, p, (a3)).

superior(r3,r2). superior(r2,r1).

%% instantiate the rules

rule(R,X) :- rule(R,X,_).

applicable(r1) :- defeasible(a1).
supported(r1) :- support(a1).
applicable(r2) :- defeasible(a2).
supported(r2) :- support(a2).
applicable(r3) :- defeasible(a3).
supported(r3) :- support(a3).

{ fact(a1;a2;a3) }.

#show defeasible/1.
#show applicable/1.
