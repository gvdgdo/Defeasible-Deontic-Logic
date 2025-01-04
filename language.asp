% Copyright (c) 2022-2025 Guido Governatori.

% atomic proposition have to be declared with "atom"

% the negation of non(X) is X, provided X is an atom.
negation(non(X),X) :- atom(X).

%the negation of X is non(X), provided X is an atom.
negation(X,non(X)) :- atom(X).

%% a literal is an atom or its negation
isNegation(X) :- atom(Y), negation(X,Y).
literal(X) :- isNegation(X).
literal(X) :- atom(X).

%% "conflict/2" establishes that the literal X cannot be 
%% true when literal Y is true.
%% "strongConflict/2" is the symmetric version of "conflict"
conflict(X,Y) :- strongConflict(X,Y).
conflict(Y,X) :- strongConflict(X,Y).

% atoms X and Y cannot hold together (oppose each other) if
% Y is the negation of the X, or X conflicts with Y.
opposes(X,Y) :- negation(X,Y). 
opposes(X,Y) :- conflict(X,Y).

%% superiority between two rules can be given by 
%% "superior(X,Y)" rule  X is stronger than rule Y
%% or by "inferior(X,Y)" rule Y is stronger than rule X
superior(X,Y) :- inferior(Y,X).
