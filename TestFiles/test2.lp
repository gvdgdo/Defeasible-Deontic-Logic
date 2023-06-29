% #include "defeasible-ab.asp".
% #include "defeasible-ab.asp".
% #include "deontic.asp".

% atom(c).

% prescriptive(r1,c).
% permissiveRule(r2,non(c)).
% permissiveRule(r3,c).
% prescriptiveRule(r4,non(c)).


% applicable(r1).
% applicable(r2).
% applicable(r3).
% applicable(r4).

% superior(r2,r1).
% superior(r4,r3).
 
applicable(M,p(X)) :- provable(M,q(X)). %questa funziona

applicable(M,X) :- provable(M,p(X)), provable(s,q(X)), provable(d,r(X)).

provable(d,X) :- fact(X).
provable(s,X) :- fact(X).

fact(q(pluto)).
fact(p(pluto)).
fact(r(pluto)).

fact(4;1).

% #show permission/1.
% #show obligation/1.
% #show provable/2.
#show applicable/2.

