% copyright (c) 2022-2025 Guido Governatori

#include "../Basic/defeasible-ab.asp".
%% to compute the extension using ambiguity blocking

% #include "../Basic/defeasible-ap.asp".
%% to compute the extension using ambiguity propagation


%%%% basic ambiguity 
%% r1: r =>p
%% r2: s => ~p
%% r3: p => q
%% r4: => ~q
%%
%% r3 > r4

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

applicable(r1,p) :- defeasible(r). 
applicable(r2,non(p)) :- defeasible(s).
applicable(r3,q) :- defeasible(p).
applicable(r4,non(q)).

supported(r1,p) :- support(r). 
supported(r2,non(p)) :- support(s).
supported(r3,q) :- support(p).
supported(r4,non(q)).

{fact(r;s)}.

% #show defeasible/1.
#show X: defeasible(X).
