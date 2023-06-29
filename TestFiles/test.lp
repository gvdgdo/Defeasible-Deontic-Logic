% comp(R, X1, X2, N).

violation(X) :- obligation(X), non(X).

obligation(X2) :- comp(R, X1, X2, N), 
    violation(X1), applicable(R, N-1).

applicable(R) :- comp(R, X1, X2, N), 
    violation(X1), applicable(R, N-1).

applicable(R,0) :- rule(R).

comp(r, a, b, 1).
comp(r, b, c, 2).

% rule(r).

obligation(a).
non(a).

terminalVioaltion :- violation(_).

applilcable(R,X) :- rule(R,X,B), defeasible(B).

% rule(r, p, (q1,q2)).

applicable(R) :- rule(R,_,F,O,P), defeasible(B), obligation(O), permission(P).
supported(R) :- rule(R,_,F,_,_), support(F).


% p([X,Y]) :- &head([X,Y];X), p(X), p(Y), rule(_,_,[X,Y]).
% p([X,Y]) :- &last([X,Y];Y), p(X), p(Y), rule(_,_,[X,Y]).
% p([X,Y]) :- &tail([X,Y];Y), p(X), p(Y), rule(_,_,[X,Y]).

rule(r,c,(a,b,c)).
rule(s,non(c),()).

% &subList(L1,L2;)

l(a).
l(b).
l(c).

p(a).
p(b).
p(c).

defeasible(X) :- p(X).
defeasible(X) :- rule(R,X,B), cazzo(R).


% applicable(R,Y) :-  Y =  #count{X :  p(X), &member(X,B;) }, rule(R,_,B).
% size(R,Z):- Z = #count{X : l(X), &member(X,B;)}, rule(R,_,B). 

% sapplicable(R,Y,Z) :-  Y =  #count{X :  p(X), &member(X,B;) }, Z = #count{X : l(X), &member(X,B;)}, rule(R,_,B). 

% cazzo(R) :- Y = Z, Y =  #count{X :  defeasible(X), &member(X,B;) }, Z = #count{X : l(X), &member(X,B;)}, rule(R,_,B).

% #show cazzo/1.
% #show defeasible/1.

empty(R) :- rule(R,_,B), B = ().

not_cazzo(X) :- not cazzo(X), rule(X,_,_). 

yes(X) :- rule(X,Y,_).


% pippo(X) :- 1{ pluto(pp(X);qq(X);ss(X))}.

pippo(X) :- 1{pluto(pp(X);qq(X);ss(X))}, gg(X).

pluto(pp(1)).
gg(1).

#show yes/1.
 

