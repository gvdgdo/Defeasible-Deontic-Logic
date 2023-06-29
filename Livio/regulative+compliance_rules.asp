
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 1. The Licensor grants the Licensee a licence to evaluate the Product.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited(Ev):- evaluate(Ev), hasAgent(Ev,X), licensee(X), hasTheme(Ev,P), product(P), not exceptionArt1b(Ev). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_1(Ev):- evaluate(Ev), hasAgent(Ev,X), licensee(X), hasTheme(Ev,P), product(P), isLicenceOf(L,P), licence(L), hasTheme(Eg,L), hasAgent(Eg,Y), licensor(Y), grant(Eg), rexist(Eg), hasReceiver(Eg,X).

exceptionArt1b(Ev):- condition_1(Ev).

permitted(Ev):- condition_1(Ev).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 2. The Licensee must not publish the results of the evaluation of the Product without the approval of the Licensor.
%           If the Licensee publishes results of the evaluation of the Product without approval from the Licensor, 
%           the material must be removed.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2a and Article 2c %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_2(Ep,X,R):- publish(Ep), hasAgent(Ep,X), licensee(X), hasTheme(Ep,R), result(R), hasResult(Ev,R), evaluate(Ev), rexist(Ev), not exceptionArt2b(Ep), not exceptionArt4a(Ep).

prohibited(Ep):- condition_2(Ep,X,R).

obligatory(ca(Ep,X,R)) :- rexist(Ep),condition_2(Ep,X,R).

remove(ca(Ep,X,R)) :- rexist(Ep),condition_2(Ep,X,R).

hasTheme(ca(Ep,X,R),R) :- rexist(Ep),condition_2(Ep,X,R).

hasAgent(ca(Ep,X,R),X) :- rexist(Ep),condition_2(Ep,X,R).

compensate(ca(Ep,X,R),Ep):- rexist(Ep),condition_2(Ep,X,R).
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_3(Ep):- publish(Ep), hasAgent(Ep,X), licensee(X), hasTheme(Ep,R), result(R), hasResult(Ev,R), evaluate(Ev), rexist(Ev), hasTheme(Ea,Ep), approve(Ea), rexist(Ea), hasAgent(Ea,Y), licensor(Y).

exceptionArt2b(Ep):- condition_3(Ep).

permitted(Ep):- condition_3(Ep).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 3. The Licensee must not publish comments on the evaluation of the Product,
%            unless the Licensee is permitted to publish the results of the evaluation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited(Ep):- publish(Ep), hasAgent(Ep,X), licensee(X), hasTheme(Ep,C), comment(C), isCommentOf(C,Ev), evaluate(Ev), rexist(Ev), not exceptionArt3b(Ep).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_4(Ep):- publish(Ep), hasAgent(Ep,X), licensee(X), hasTheme(Ep,C), comment(C), isCommentOf(C,Ev), evaluate(Ev), rexist(Ev), hasResult(Ev,R), hasTheme(Epr,R), hasAgent(Epr,X), publish(Epr), permitted(Epr).

exceptionArt3b(Ep):- condition_4(Ep).

permitted(Ep):- condition_4(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 4. If the Licensee is commissioned to perform an independent evaluation of the Product,then the Licensee has the obligation to publish the evaluation results.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 4a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_5(Ep):- publish(Ep), hasAgent(Ep,X), licensee(X), hasTheme(Ep,R), result(R), hasResult(Ev,R), evaluate(Ev), rexist(Ev), hasTheme(Ec,Ev), commission(Ec), rexist(Ec).

exceptionArt4a(Ep):- condition_5(Ep).

obligatory(Ep):- condition_5(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPLIANCE CHECKING RULES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%(1) if there is some action x obligatory at time t and, at the same time, x does not really exist => violation; 
%(2) if there is some action x prohibited at time t and, at the same time, x really exists => violation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rexist(ca(Ep,X,R)) :- remove(ca(Ep,X,R)), hasTheme(ca(Ep,X,R),R), hasAgent(ca(Ep,X,R),X), rexist(Er), remove(Er), hasTheme(Er,R),hasAgent(Er,X).

compensated(X):- compensate(Y,X), rexist(Y).

violation(viol(X)) :- obligatory(X), not rexist(X), not compensated(X).
violation(viol(X)) :- prohibited(X), rexist(X), not compensated(X).

referTo(viol(X),X) :- violation(viol(X)).

%%%%%%%%%%%%


