#include "../defeasible-ab.asp".
#include "../deontic-comp.asp".

atom(own_0(Id)) :- caseId_0(Id).
atom(license_0(Id)) :- caseId_0(Id).
atom(authorise_0(Id)) :- caseId_0(Id).
atom(remove_0(Id)):- caseId_0(Id).
atom(evaluate_0(Id)) :- caseId_0(Id).
atom(commission_0(Id)) :- caseId_0(Id).
atom(publish_0(Id)) :- caseId_0(Id).
atom(comment_0(Id)) :- caseId_0(Id).

atom(own_1(Id)) :- caseId_1(Id).
atom(license_1(Id)) :- caseId_1(Id).
atom(authorise_1(Id)) :- caseId_1(Id).
atom(remove_1(Id)):- caseId_1(Id).
atom(evaluate_1(Id)) :- caseId_1(Id).
atom(commission_1(Id)) :- caseId_1(Id).
atom(publish_1(Id)) :- caseId_1(Id).
atom(comment_1(Id)) :- caseId_1(Id).

% fact(evaluate(c1)).

% r0: owns(Owner, Product), User != Owner =>_O neg(evaluate(Id))

prescriptiveRule(r0_0(Id), non(evaluate_0(Id))) :- 
    caseId_0(Id).
applicable(r0_0(Id), non(evaluate_0(Id))) :- 
    caseId_0(Id).

% r1: owns(Owner, Product), license(Owner, User, Product) =>_P evalaute(User, Product)

permissiveRule(r1_0(Id) ,evaluate_0(Id)) :- caseId_0(Id).
applicable(r1_0(Id), evaluate_0(Id)) :-    
    defeasible(license_0(Id)).

superior(r1_0(Id),r0_0(Id)) :- caseId_0(Id).

prescriptiveRule(r2_0(Id), non(publish_0(Id))) :- 
    caseId_0(Id).
applicable(r2_0(Id), non(publish_0(Id))) :- 
    caseId_0(Id).
compensate(r2_0(Id), non(publish_0(Id)), remove_0(Id),1) :- 
    caseId_0(Id).

permissiveRule(r2e_0(Id), publish_0(Id)) :-  caseId_0(Id).
applicable(r2e_0(Id), publish_0(Id)) :-  defeasible(authorise_0(Id)).

superior(r2e_0(Id),r2_0(Id)) :- caseId_0(Id). 

prescriptiveRule(r3_0(Id), non(comment_0(Id))) :- 
    caseId_0(Id).
applicable(r3_0(Id), non(comment_0(Id))) :- 
    caseId_0(Id).

permissiveRule(r3e_0(Id), comment_0(Id)) :-
    caseId_0(Id).
applicable(r3e_0(Id), comment_0(Id)) :-
    permission(publish_0(Id)).

superior(r3e_0(Id),r3_0(Id)) :- caseId_0(Id).

prescriptiveRule(r4_0(Id),publish_0(Id)) :- 
    caseId_0(Id).
applicable(r4_0(Id), publish_0(Id)) :-
    defeasible(owns_0(Id)), defeasible(commission_0(Id)).

superior(r4_0(Id),r2_0(Id)) :- caseId_0(Id).

prescriptiveRule(r41_0(Id),evaluate_0(Id)) :- 
    caseId_0(Id).
applicable(r41_0(Id), evaluate_0(Id)) :-
    defeasible(owns_0(Id)), defeasible(commission_0(Id)).

superior(r41_0(Id),r0_0(Id)) :- caseId_0(Id).

% prescriptiveRule(r5(Id), non(evaluate(Id))) :-
%     caseId(Id).
% applicable(r5(Id), non(evaluate(Id))) :-
%     terminate(Id).

% terminate(Id) :-  prescriptiveRule(R,X), terminalViolation(R), caseId(Id). 

% terminate(Id) :- 1{ terminalViolation(r0(Id); r2(Id); r3(Id); r4(Id); r41(Id)) }, caseId(Id).

% terminate(Id) :- 1{ terminalViolation(r0(Id); r2(Id); r3(Id); r4(Id); r41(Id)) }, caseId(Id).

terminate_0(Id) :- terminalViolation_0(_), caseId_0(Id).

superior(r5_0(Id),r1_0(Id)) :- caseId_0(Id).

prescriptiveRule(r0_1(Id), non(evaluate_1(Id))) :- 
    caseId_1(Id).
applicable(r0_1(Id), non(evaluate_1(Id))) :- 
    caseId_1(Id).

% r1: owns(Owner, Product), license(Owner, User, Product) =>_P evalaute(User, Product)

permissiveRule(r1_1(Id) ,evaluate_1(Id)) :- caseId_1(Id).
applicable(r1_1(Id), evaluate_1(Id)) :-    
    defeasible(license_1(Id)).

superior(r1_1(Id),r0_1(Id)) :- caseId_1(Id).

prescriptiveRule(r2_1(Id), non(publish_1(Id))) :- 
    caseId_1(Id).
applicable(r2_1(Id), non(publish_1(Id))) :- 
    caseId_1(Id).
compensate(r2_1(Id), non(publish_1(Id)), remove_1(Id),1) :- 
    caseId_1(Id).

permissiveRule(r2e_1(Id), publish_1(Id)) :-  caseId_1(Id).
applicable(r2e_1(Id), publish_1(Id)) :-  defeasible(authorise_1(Id)).

superior(r2e_1(Id),r2_1(Id)) :- caseId_1(Id). 

prescriptiveRule(r3_1(Id), non(comment_1(Id))) :- 
    caseId_1(Id).
applicable(r3_1(Id), non(comment_1(Id))) :- 
    caseId_1(Id).

permissiveRule(r3e_1(Id), comment_1(Id)) :-
    caseId_1(Id).
applicable(r3e_1(Id), comment_1(Id)) :-
    permission(publish_1(Id)).

superior(r3e_1(Id),r3_1(Id)) :- caseId_1(Id).

prescriptiveRule(r4_1(Id),publish_1(Id)) :- 
    caseId_1(Id).
applicable(r4_1(Id), publish_1(Id)) :-
    defeasible(owns_1(Id)), defeasible(commission_1(Id)).

superior(r4_1(Id),r2_1(Id)) :- caseId_1(Id).

prescriptiveRule(r41_1(Id),evaluate_1(Id)) :- 
    caseId_1(Id).
applicable(r41_1(Id), evaluate_1(Id)) :-
    defeasible(owns_1(Id)), defeasible(commission_1(Id)).

superior(r41_1(Id),r0_1(Id)) :- caseId_1(Id).

% prescriptiveRule(r5(Id), non(evaluate(Id))) :-
%     caseId(Id).
% applicable(r5(Id), non(evaluate(Id))) :-
%     terminate(Id).

% terminate(Id) :-  prescriptiveRule(R,X), terminalViolation(R), caseId(Id). 

% terminate(Id) :- 1{ terminalViolation(r0(Id); r2(Id); r3(Id); r4(Id); r41(Id)) }, caseId(Id).

terminate_1(Id) :- terminalViolation_1(_), caseId_1(Id).

superior(r5_1(Id),r1_1(Id)) :- caseId_1(Id).
