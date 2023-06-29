#include "defeasible-ap.asp".

predicate(price;size).
constant(pippo;pluto).

atom(price(Y)) :- constant(Y).

price(10).
price(11).

strongConflict(price(X),price(Y)) :- price(X), price(Y), X != Y. 


#show strongConflict/2.
