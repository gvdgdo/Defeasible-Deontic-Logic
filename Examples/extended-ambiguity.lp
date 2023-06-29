
#include "defeasible-ab.asp".
% #include "defeasible-ap.asp".

atom(e1;e2;r;g;c).

rule(r1, r, (e1)).
rule(r2, non(r), (e2)).
rule(r3, g, (r)).
rule(r4, non(g), ()).
rule(r5, c, (non(g))).
rule(r6, non(c), ()).

superior(r3,r4).
superior(r5,r6).

{fact(e1;e2)}.

%%%%%%%%%%

rule(R,X) :- rule(R,X,_).

applicable(r1) :- defeasible(e1).
supported(r1) :- support(e1).
applicable(r2) :- defeasible(e2).
supported(r2) :- support(e2).
applicable(r3) :- defeasible(r).
supported(r3) :- support(r).
applicable(r4).
supported(r4).
applicable(r5) :- defeasible(non(g)).
supported(r5) :- support(non(g)).
applicable(r6).
supported(r6).

% #show supported/1.
#show defeasible/1.