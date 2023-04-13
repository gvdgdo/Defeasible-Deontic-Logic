% atomic proposition have to be declared with "atom"
%% "atom" will establish that X and non(X) are the 
%% negation of each other

% proposition(X) :- atom(X).
% proposition(non(X)) :- atom(X).

negation(non(X),X) :- atom(X).
negation(X,non(X)) :- atom(X).

%% "conflict/2" establishes that the literal X cannot be 
%% true when literal Y is true.

%% "strongConflcit/2" is the symetric version of "conflict"

conflict(X,Y) :- strongConflict(X,Y).
conflict(Y,X) :- strongConflict(X,Y).

opposes(X,Y) :- negation(X,Y). 
opposes(X,Y) :- conflict(X,Y).

%% superiority between two rules can be given by 
%% "superior(X,Y)" rule  X is stronger than rule Y
%% or by "inferior(X,Y)" rule Y is stronger than rule X

superior(X,Y) :- inferior(Y,X).

% sizeRule(R,Y) :- Y = #count{ X : proposition(X), &member(X,B;) }, rule(R,_,B).
% sizeDefeasible(R,Y) :- Y =  #count{ X :  defeasible(X), &member(X,B;) }, rule(R,_,B). 
% sizeSupport(R,Y) :- Y = #count{ X : support(X), &member(X,B;) }, rule(R,_,B).

% a rule is applicable iff all the members of its body are defeasibly 
% provable.  Thus is DLV given the list of elements in the body, we count
% the number of elements, and we count all the elements that are 
% defeasibly provable. If if it is the same number the rule is applicable.  
% Also, it works when the body is the empty list. We need `proposition`
% to ensure that the grounding is safe. 

% applicable(R) :- rule(R,_,_), sizeDefeasible(R,Y), sizeRule(R,Y).

% supported(R) :-  rule(R,_,_), sizeSupport(R,Y), sizeRule(R,Y).

% same as applicable, but instead of defeasible, the elements should be 
% provable as support.

% applicable(R) :- rule(R,_,F,O,P), defeasible(B), obligation(O), permission(P).
% supported(R) :- rule(R,_,F,_,_), support(F).
