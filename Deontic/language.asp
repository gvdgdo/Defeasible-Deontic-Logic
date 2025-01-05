% Copyright (c) 2022-2025 Guido Governatori 

#include "../language.asp".

rule(R,X) :- constitutiveRule(R,X).
rule(R,X) :- prescriptiveRule(R,X).
rule(R,X) :- permissiveRule(R,X).

bodyNotDefeasible(R,X) :- rule(R,X), 
    literal(Y), body(R,Y), not defeasible(Y).

bodyNotSupport(R,X) :- rule(R,X), 
    literal(Y), body(R,Y), not supported(Y).

bodyNotObligationP(R,X) :- rule(R,X),
    body(R,obl(Y)), not obligation(Y).

bodyNotObligationN(R,X) :- rule(R,X),
    body(R,non(obl(Y))), obligation(Y).

bodyNotPermissionP(R,X) :- rule(R,X),
    body(R,per(Y)), not permission(Y).

bodyNotPermissionN(R,X) :- rule(R,X),
    body(R,non(per(Y))), permission(Y).

applicable(R,X) :- rule(R,X),
    not bodyNotDefeasible(R,X),
    not bodyNotObligationP(R,X),
    not bodyNotObligationN(R,X),
    not bodyNotPermissionP(R,X),
    not bodyNotPermissionN(R,X).

supported(R,X) :- rule(R,X),
    not bodyNotSupport(R,X),
    not bodyNotObligationP(R,X),
    not bodyNotObligationN(R,X),
    not bodyNotPermissionP(R,X),
    not bodyNotPermissionN(R,X).

bodyNotDefeasibleObligation(R,X) :- rule(R,X),
    body(R,Y), literal(Y), not obligation(Y).

convertObligation(R,X) :- 
    constitutiveRule(R,X),
    not body(R,obl(_)), not body(R,non(obl(_))),
    not body(R,per(_)), not body(R,non(per(_))),
    body(R,_), not bodyNotDefeasibleObligation(R,X).

bodyNotDefeasiblePermission(R,X) :- rule(R,X),
    body(R,Y), literal(Y), not permission(Y).

convertPermission(R,X) :- 
    constitutiveRule(R,X),
    not body(R,obl(_)), not body(R,non(obl(_))),
    not body(R,per(_)), not body(R,non(per(_))),
    body(R,_), not bodyNotDefeasiblePermission(R,X).
