#include "../defeasible-ab.asp".
#include "../deontic-comp.asp".

product(p1;p2;p3).

owner(o1;o2).
user(u1;u2;o1;o2).

% predicates
% own, product, license, evaluate, authorise, publish, 
% comment, commission, remove

atom(owns(Owner,Product)) :- owner(Owner), product(Product).
atom(license(Owner,Licensee,Product)) :- owner(Owner), user(Licensee), product(Product).
atom(use(Owner,Product)) :- owner(Owner), product(Product).
atom(use(User,Product)) :- user(User), product(Product).
atom(authorise(Owner,Licensee)) :- owner(Owner), user(Licensee).
atom(remove(User,Product)) :- user(User), product(Product).
atom(evaluate(User,Product)) :- user(User), product(Product).
atom(commission(Owner,User,Product)) :- owner(Owner), user(User), product(Product).
atom(publish(User,Product)) :- user(User), product(Product).

fact(owns(o1,p1); owns(o1,p2); owns(o2,p3)).
fact(license(o1,u1,p1);commission(o1,o2,p1)).

% obligation(neg(evaluate(User,Product))) :- atom(owns(Owner,Product)), Owner != User, user(User).

% permission(evalaute(User,Product)) :- atom(license(Owner,User,Product)), atom(owns(Owner,Product)), user(User).

% r0: owns(Owner, Product), User != Owner =>_O neg(evaluate(User,Product))

prescriptiveRule(r0, non(evaluate(User,Product))) :- 
    user(User), product(Product).
applicable(r0, non(evaluate(User,Product))) :- 
    user(User), User != Owner,
    defeasible(owns(Owner,Product)).

% r1: owns(Owner, Product), license(Owner, User, Product) =>_P evalaute(User, Product)

permissiveRule(r1 ,evaluate(User,Product)) :- user(User), product(Product).
applicable(r1, evaluate(User,Product)) :-    
    defeasible(owns(Owner,Product)),
    defeasible(license(Owner,User,Product)).

superior(r1,r0).

prescriptiveRule(r2, non(publish(User,Product))) :- 
    user(User), product(Product).
applicable(r2, non(publish(User,Product))) :- 
    user(User), User != Owner,
    defeasible(owns(Owner,Product)).
compensate(r2, non(publish(User,Product)), remove(User,Product),1) :- 
    user(User), product(Product).

permissiveRule(r2e, publish(User,Product)) :-  user(User), product(Product).
applicable(r2e, publish(User,Product)) :-  owns(Owner,Product), authorise(Owner,User).

superior(r2e,r2). 

prescriptiveRule(r3, non(comment(User,Product))) :- 
    user(User), product(Product).
applicable(r3, non(comment(User,Product))) :- 
    defeasible(owns(Owner,Product)), Owner != User, user(User).

permissiveRule(r3e, comment(User,Product)) :-
    user(User), product(Product).
applicable(r3e, comment(User,Product)) :-
    permission(publish(User,Product)).

superior(r3e,r3).

prescriptiveRule(r4,publish(User,Product)) :- 
    user(User), product(Product).
applicable(r4, publish(User,Product)) :-
    defeasible(owns(Owner,Product)), defeasible(commission(Owner,User,Product)).

superior(r4,r2).

prescriptiveRule(r41,evaluate(User,Product)) :- 
    user(User), product(Product).
applicable(r41, evaluate(User,Product)) :-
    defeasible(owns(Owner,Product)), defeasible(commission(Owner,User,Product)).

superior(r41,r0).

prescriptiveRule(r5, non(evaluate(User,Product))) :-
    user(User), product(Product).
applicable(r5, non(evaluate(User,Product))) :-
    terminalViolation(_), user(User), product(Product).

superior(r5,r1).

#show atom/1.
% #show applicable/2.
% #show obligation/1.
% #show negation/2.
% #show defeasible/1.

