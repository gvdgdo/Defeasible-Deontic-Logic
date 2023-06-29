% #include "../defeasible-ab.asp".
defeasible(X) :- fact(X).

#include "../deontic-comp.asp".

% product(p1;p2;p3).
% owner(o1;o2).
% user(u1;u2;o1;o2).

% caseId(c1;c2).

% caseId(Id) :- case(Id,Owner,User,Product).

% license(Id) :- case(Id,Owner,User,Product), 
%     owns(Owner,Product), licenses(Owner,User,Product).
% own(Id) :-  case(Id,Owner,User,Product), owns(Owner,Product).
% commission(Id) :- case(Id,Owner,User,Product), 
%     commissions(Owner,User,Product), Owner != User.
% authorise(Id) :- case(Id,Owner,User,Product), 
%     authorises(Owner,User,Product), Owner != User.
% evaluate(Id) :- case(Id,Owner,User,Product), 
%     evaluates(User,Product).
% publish(Id) :- case(Id,Owner,User,Product),
%     publishes(User,Product).
% comment(Id) :- case(Id,Owner,User,Product),
%     comments(User,Product).
% remove(Id) :- case(Id,Owner,User,Product),
%     removes(User,Product).
            
% predicates
% own, product, license, evaluate, authorise, publish, 
% comment, commission, remove

atom(own(Id)) :- caseId(Id).
atom(license(Id)) :- caseId(Id).
atom(authorise(Id)) :- caseId(Id).
atom(remove(Id)):- caseId(Id).
atom(evaluate(Id)) :- caseId(Id).
atom(commission(Id)) :- caseId(Id).
atom(publish(Id)) :- caseId(Id).
atom(comment(Id)) :- caseId(Id).

% fact(evaluate(c1)).

% r0: owns(Owner, Product), User != Owner =>_O neg(evaluate(Id))

prescriptiveRule(r0(Id), non(evaluate(Id))) :- 
    caseId(Id).
applicable(r0(Id), non(evaluate(Id))) :- 
    caseId(Id).

% r1: owns(Owner, Product), license(Owner, User, Product) =>_P evalaute(User, Product)

permissiveRule(r1(Id) ,evaluate(Id)) :- caseId(Id).
applicable(r1(Id), evaluate(Id)) :-    
    defeasible(license(Id)).

superior(r1(Id),r0(Id)) :- caseId(Id).

prescriptiveRule(r2(Id), non(publish(Id))) :- 
    caseId(Id).
applicable(r2(Id), non(publish(Id))) :- 
    caseId(Id).
compensate(r2(Id), non(publish(Id)), remove(Id),1) :- 
    caseId(Id).

permissiveRule(r2e(Id), publish(Id)) :-  caseId(Id).
applicable(r2e(Id), publish(Id)) :-  defeasible(authorise(Id)).

superior(r2e(Id),r2(Id)) :- caseId(Id). 

prescriptiveRule(r3(Id), non(comment(Id))) :- 
    caseId(Id).
applicable(r3(Id), non(comment(Id))) :- 
    caseId(Id).

permissiveRule(r3e(Id), comment(Id)) :-
    caseId(Id).
applicable(r3e(Id), comment(Id)) :-
    permission(publish(Id)).

superior(r3e(Id),r3(Id)) :- caseId(Id).

prescriptiveRule(r4(Id),publish(Id)) :- 
    caseId(Id).
applicable(r4(Id), publish(Id)) :-
    % defeasible(owns(Id)), 
    defeasible(commission(Id)).

superior(r4(Id),r2(Id)) :- caseId(Id).

prescriptiveRule(r41(Id),evaluate(Id)) :- 
    caseId(Id).
applicable(r41(Id), evaluate(Id)) :-
    % defeasible(owns(Id)), 
    defeasible(commission(Id)).

superior(r41(Id),r0(Id)) :- caseId(Id).

prescriptiveRule(r5(Id), non(evaluate(Id))) :-
    caseId(Id).
applicable(r5(Id), non(evaluate(Id))) :-
    terminate(Id).

% terminate(Id) :-  prescriptiveRule(R,X), terminalViolation(R), caseId(Id). 

% terminate(Id) :- 1{ terminalViolation(r0(Id); r2(Id); r3(Id); r4(Id); r41(Id)) }, caseId(Id).

terminate(Id) :- terminalViolation(_), caseId(Id).

superior(r5(Id),r1(Id)) :- caseId(Id).

% #show atom/1.
% #show applicable/2.
% #show obligation/1.
% #show prescriptiveRule/2.
% #show terminate/1.
#show terminalViolation/1.
% #show negation/2.
% #show defeasible/1.
