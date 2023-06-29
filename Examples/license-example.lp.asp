#include "defeasible-ab.asp".
#include "deontic-comp.asp".

% language
atom(use(P)) :- variables(P).
atom(license).
atom(publish).
atom(authorisation).
atom(remove).
atom(social_media).

%% rules
prescriptiveRule(1,non(use(P))) :- variables(P). 
applicable(1).

permissiveRule(2,use(P)) :- variables(P).
applicable(2) :- defeasible(license).

superior(2,1).

prescriptiveRule(3,non(publish)).
applicable(3).

permissiveRule(4,publish).
applicable(4) :- defeasible(authorisation).

compensate(3,non(publish),remove,1).

prescriptiveRule(5,non(social_media)).
applicable(5).

permissiveRule(6,social_media).
applicable(6) :- permission(publish).

superior(6,5).

prescriptiveRule(7,non(use(P))) :- variables(P).
applicable(7) :- terminalViolation(_).

superior(7,2).

%%%% facts
variables(word;excell). 
fact(use(word)).
fact(social_media).
fact(license).
% fact(authorisation).
fact(publish).
fact(non(remove)).

#show obligation/1.
% % #show permission/1.
% #show violation/3.
% #show terminalViolation/1.
