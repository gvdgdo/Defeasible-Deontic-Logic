% #include "defeasible-ab.asp".
#include "defeasible-ap.asp".

%%%% basic ambiguity 

atom(p;q;s;r).

rule(r1,p).
rule(r2,non(p)).
rule(r3,q).
rule(r4,non(q)).

superior(r3,r4).

% {superior(r1,r2); superior(r2,r1)}.

%% uncomment the previous line, to get an inconsistency due
%% to a cycle in the superiority relation

%%%% rules instantiation

applicable(r1) :- defeasible(r). 
applicable(r2) :- defeasible(s).
applicable(r3) :- defeasible(p).
applicable(r4).

supported(r1) :- support(r). 
supported(r2) :- support(s).
supported(r3) :- support(p).
supported(r4).

pippo(r1) :- atom(p;q).
pluto(r1) :- atom(p), atom(q).

{fact(r;s)}.


#show pippo/1.
#show pluto/1.
% #show defeasible/1.