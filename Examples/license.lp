#include "defeasible-ab.asp".
#include "deontic-comp.asp".

atom(use;license;publish;authorization;post;remove;commision).
atom(keep).

strongConflict(remove,keep).

prescriptiveRule(r1,non(use)).
applicable(r1).

permissiveRule(r2,use).
applicable(r2) :- defeasible(license).
superior(r2,r1).
inferior(r2,r8).

prescriptiveRule(r3,non(publish)).
applicable(r3).
compensate(r3,non(publish),remove,1).

permissiveRule(r4,publish).
applicable(r4) :- defeasible(authorization).
superior(r4,r3).

prescriptiveRule(r5,non(post)).
applicable(r5).

permissiveRule(r6,post).
applicable(r6) :- permission(publish).
superior(r6,r5). 

prescriptiveRule(r7,publish).
applicable(r7) :- defeasible(commission).

prescriptiveRule(r8,non(use)).
applicable(r8) :- terminalViolation(_).

fact(authorization).
fact(license).
fact(publish).
fact(keep).
fact(post).

#show obligation/1.
% #show obligation/3.
% #show permission/1.
#show violation/3.
#show terminalViolation/1.


