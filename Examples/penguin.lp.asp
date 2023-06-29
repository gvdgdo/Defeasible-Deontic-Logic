#include "defeasible-ab.asp".

variable(pepe;tweety;clay;dove;pappa;gallo;meg;pie).
atom(penguin(X);bird(X);superpenguin(X);flies(X)) :- variable(X).

rule(r1,flies(X)) :- variable(X).
applicable(r1,flies(X)) :- defeasible(bird(X)).

rule(r2,non(flies(X))) :- variable(X).
applicable(r2,non(flies(X))) :- defeasible(penguin(X)).

superior(r2,r1).

rule(r3,bird(X)) :- variable(X).
applicable(r3,bird(X)) :- defeasible(penguin(X)).

rule(r4,flies(X)) :- variable(X).
applicable(r4,flies(X)) :- defeasible(superpenguin(X)).

superior(r4,r2).

rule(r5,penguin(X)) :- variable(X).
applicable(r5,penguin(X)) :- defeasible(superpenguin(X)).

fact(bird(pepe)).
fact(penguin(tweety)).
fact(superpenguin(clay)).
fact(bird(dove)).
fact(bird(pappa)).
fact(bird(gallo)).
fact(bird(meg)).
fact(bird(pie)).

flies(X) :- defeasible(flies(X)).

% #show defeasible/1.
#show flies/1.
% #show atom/1.
% #show opposes/2.