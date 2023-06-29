#include "defeasible-ab.asp".
#include "deontic-comp.asp".

atom(a;b;c).
fact(b).
fact(a).

prescriptiveRule(1,non(a)).
applicable(1) :- defeasible(b), permission(non(c)).
constitutiveRule(2,c).
applicable(2) :- terminalVioaltion(1).

#show defeasible/1.
#show obligation/1.
#show permission/1.
#show terminalVioaltion/1.

