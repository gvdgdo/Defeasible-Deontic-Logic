% copyright (c) 2022-2025 Guido Governatori

#include "../Basic/defeasible-ab.asp".
%% to compute the extension using ambiguity blocking

% #include "../Basic/defeasible-ap.asp".
%% to compute the extension using ambiguity propagation


atom(e1;e2;r;g;c).

rule(r1, r).
rule(r2, non(r)).
rule(r3, g).
rule(r4, non(g)).
rule(r5, c).
rule(r6, non(c)).

superior(r3,r4).
superior(r5,r6).

{fact(e1;e2)}.

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