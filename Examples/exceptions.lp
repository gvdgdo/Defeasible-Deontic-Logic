% copyright (c) 2022-2025 Guido Governatori

#include "../Basic/defeasible-ab.asp".
%% to compute the extension using ambiguity blocking

% #include "../Basic/defeasible-ap.asp".
%% to compute the extension using ambiguity propagation

atom(p). atom(a1). atom(a2). atom(a3).

%% r1: a1 =>p
rule(r1, p).
applicable(r1,p) :- defeasible(a1).
supported(r1,p) :- support(a1).

%% r2: a2 => ~p
rule(r2, non(p)).
applicable(r2,non(p)) :- defeasible(a2).
supported(r2,non(p)) :- support(a2).

%% r3: a3 => p
rule(r3, p).
applicable(r3,p) :- defeasible(a3).
supported(r3,non(p)) :- support(a3).

%% r3 > r2
%% r2 > r1
superior(r3,r2). superior(r2,r1).


{ fact(a1;a2;a3) }.

#show defeasible/1.
#show applicable/1.
