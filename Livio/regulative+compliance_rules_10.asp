
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 1. The Licensor grant_0s the Licensee a licence_0 to evaluate_0 the Product.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_0(Ev):- evaluate_0(Ev), hasAgent_0(Ev,X), licensee_0(X), hasTheme_0(Ev,P), product_0(P), not exceptionArt1b_0(Ev). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_1_0(Ev):- evaluate_0(Ev), hasAgent_0(Ev,X), licensee_0(X), hasTheme_0(Ev,P), product_0(P), isLicenceOf_0(L,P), licence_0(L), hasTheme_0(Eg,L), hasAgent_0(Eg,Y), licensor_0(Y), grant_0(Eg), rexist_0(Eg), hasReceiver_0(Eg,X).

exceptionArt1b_0(Ev):- condition_1_0(Ev).

permitted_0(Ev):- condition_1_0(Ev).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 2. The Licensee must not publish_0 the result_0s of the evaluation of the Product without the approval of the Licensor.
%           If the Licensee publish_0es result_0s of the evaluation of the Product without approval from the Licensor, 
%           the material must be remove_0d.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2a and Article 2c %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_2_0(Ep,X,R):- publish_0(Ep), hasAgent_0(Ep,X), licensee_0(X), hasTheme_0(Ep,R), result_0(R), hasResult_0(Ev,R), evaluate_0(Ev), rexist_0(Ev), not exceptionArt2b_0(Ep), not exceptionArt4a_0(Ep).

prohibited_0(Ep):- condition_2_0(Ep,X,R).

obligatory_0(ca(Ep,X,R)) :- rexist_0(Ep),condition_2_0(Ep,X,R).

remove_0(ca(Ep,X,R)) :- rexist_0(Ep),condition_2_0(Ep,X,R).

hasTheme_0(ca(Ep,X,R),R) :- rexist_0(Ep),condition_2_0(Ep,X,R).

hasAgent_0(ca(Ep,X,R),X) :- rexist_0(Ep),condition_2_0(Ep,X,R).

compensate_0(ca(Ep,X,R),Ep):- rexist_0(Ep),condition_2_0(Ep,X,R).
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_3_0(Ep):- publish_0(Ep), hasAgent_0(Ep,X), licensee_0(X), hasTheme_0(Ep,R), result_0(R), hasResult_0(Ev,R), evaluate_0(Ev), rexist_0(Ev), hasTheme_0(Ea,Ep), approve_0(Ea), rexist_0(Ea), hasAgent_0(Ea,Y), licensor_0(Y).

exceptionArt2b_0(Ep):- condition_3_0(Ep).

permitted_0(Ep):- condition_3_0(Ep).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 3. The Licensee must not publish_0 comment_0s on the evaluation of the Product,
%            unless the Licensee is permitted_0 to publish_0 the result_0s of the evaluation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_0(Ep):- publish_0(Ep), hasAgent_0(Ep,X), licensee_0(X), hasTheme_0(Ep,C), comment_0(C), isCommentOf_0(C,Ev), evaluate_0(Ev), rexist_0(Ev), not exceptionArt3b_0(Ep).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_4_0(Ep):- publish_0(Ep), hasAgent_0(Ep,X), licensee_0(X), hasTheme_0(Ep,C), comment_0(C), isCommentOf_0(C,Ev), evaluate_0(Ev), rexist_0(Ev), hasResult_0(Ev,R), hasTheme_0(Epr,R), hasAgent_0(Epr,X), publish_0(Epr), permitted_0(Epr).

exceptionArt3b_0(Ep):- condition_4_0(Ep).

permitted_0(Ep):- condition_4_0(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 4. If the Licensee is commission_0ed to perform an independent evaluation of the Product,then the Licensee has the obligation to publish_0 the evaluation result_0s.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 4a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_5_0(Ep):- publish_0(Ep), hasAgent_0(Ep,X), licensee_0(X), hasTheme_0(Ep,R), result_0(R), hasResult_0(Ev,R), evaluate_0(Ev), rexist_0(Ev), hasTheme_0(Ec,Ev), commission_0(Ec), rexist_0(Ec).

exceptionArt4a_0(Ep):- condition_5_0(Ep).

obligatory_0(Ep):- condition_5_0(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPLIANCE CHECKING RULES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%(1) if there is some action x obligatory_0 at time t and, at the same time, x does not really exist => violation_0; 
%(2) if there is some action x prohibited_0 at time t and, at the same time, x really exists => violation_0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rexist_0(ca(Ep,X,R)) :- remove_0(ca(Ep,X,R)), hasTheme_0(ca(Ep,X,R),R), hasAgent_0(ca(Ep,X,R),X), rexist_0(Er), remove_0(Er), hasTheme_0(Er,R),hasAgent_0(Er,X).

compensate_0d(X):- compensate_0(Y,X), rexist_0(Y).

violation_0(viol(X)) :- obligatory_0(X), not rexist_0(X), not compensate_0d(X).
violation_0(viol(X)) :- prohibited_0(X), rexist_0(X), not compensate_0d(X).

referTo_0(viol(X),X) :- violation_0(viol(X)).

%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 1. The Licensor grant_1s the Licensee a licence_1 to evaluate_1 the Product.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_1(Ev):- evaluate_1(Ev), hasAgent_1(Ev,X), licensee_1(X), hasTheme_1(Ev,P), product_1(P), not exceptionArt1b_1(Ev). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_1_1(Ev):- evaluate_1(Ev), hasAgent_1(Ev,X), licensee_1(X), hasTheme_1(Ev,P), product_1(P), isLicenceOf_1(L,P), licence_1(L), hasTheme_1(Eg,L), hasAgent_1(Eg,Y), licensor_1(Y), grant_1(Eg), rexist_1(Eg), hasReceiver_1(Eg,X).

exceptionArt1b_1(Ev):- condition_1_1(Ev).

permitted_1(Ev):- condition_1_1(Ev).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 2. The Licensee must not publish_1 the result_1s of the evaluation of the Product without the approval of the Licensor.
%           If the Licensee publish_1es result_1s of the evaluation of the Product without approval from the Licensor, 
%           the material must be remove_1d.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2a and Article 2c %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_2_1(Ep,X,R):- publish_1(Ep), hasAgent_1(Ep,X), licensee_1(X), hasTheme_1(Ep,R), result_1(R), hasResult_1(Ev,R), evaluate_1(Ev), rexist_1(Ev), not exceptionArt2b_1(Ep), not exceptionArt4a_1(Ep).

prohibited_1(Ep):- condition_2_1(Ep,X,R).

obligatory_1(ca(Ep,X,R)) :- rexist_1(Ep),condition_2_1(Ep,X,R).

remove_1(ca(Ep,X,R)) :- rexist_1(Ep),condition_2_1(Ep,X,R).

hasTheme_1(ca(Ep,X,R),R) :- rexist_1(Ep),condition_2_1(Ep,X,R).

hasAgent_1(ca(Ep,X,R),X) :- rexist_1(Ep),condition_2_1(Ep,X,R).

compensate_1(ca(Ep,X,R),Ep):- rexist_1(Ep),condition_2_1(Ep,X,R).
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_3_1(Ep):- publish_1(Ep), hasAgent_1(Ep,X), licensee_1(X), hasTheme_1(Ep,R), result_1(R), hasResult_1(Ev,R), evaluate_1(Ev), rexist_1(Ev), hasTheme_1(Ea,Ep), approve_1(Ea), rexist_1(Ea), hasAgent_1(Ea,Y), licensor_1(Y).

exceptionArt2b_1(Ep):- condition_3_1(Ep).

permitted_1(Ep):- condition_3_1(Ep).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 3. The Licensee must not publish_1 comment_1s on the evaluation of the Product,
%            unless the Licensee is permitted_1 to publish_1 the result_1s of the evaluation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_1(Ep):- publish_1(Ep), hasAgent_1(Ep,X), licensee_1(X), hasTheme_1(Ep,C), comment_1(C), isCommentOf_1(C,Ev), evaluate_1(Ev), rexist_1(Ev), not exceptionArt3b_1(Ep).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_4_1(Ep):- publish_1(Ep), hasAgent_1(Ep,X), licensee_1(X), hasTheme_1(Ep,C), comment_1(C), isCommentOf_1(C,Ev), evaluate_1(Ev), rexist_1(Ev), hasResult_1(Ev,R), hasTheme_1(Epr,R), hasAgent_1(Epr,X), publish_1(Epr), permitted_1(Epr).

exceptionArt3b_1(Ep):- condition_4_1(Ep).

permitted_1(Ep):- condition_4_1(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 4. If the Licensee is commission_1ed to perform an independent evaluation of the Product,then the Licensee has the obligation to publish_1 the evaluation result_1s.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 4a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_5_1(Ep):- publish_1(Ep), hasAgent_1(Ep,X), licensee_1(X), hasTheme_1(Ep,R), result_1(R), hasResult_1(Ev,R), evaluate_1(Ev), rexist_1(Ev), hasTheme_1(Ec,Ev), commission_1(Ec), rexist_1(Ec).

exceptionArt4a_1(Ep):- condition_5_1(Ep).

obligatory_1(Ep):- condition_5_1(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPLIANCE CHECKING RULES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%(1) if there is some action x obligatory_1 at time t and, at the same time, x does not really exist => violation_1; 
%(2) if there is some action x prohibited_1 at time t and, at the same time, x really exists => violation_1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rexist_1(ca(Ep,X,R)) :- remove_1(ca(Ep,X,R)), hasTheme_1(ca(Ep,X,R),R), hasAgent_1(ca(Ep,X,R),X), rexist_1(Er), remove_1(Er), hasTheme_1(Er,R),hasAgent_1(Er,X).

compensate_1d(X):- compensate_1(Y,X), rexist_1(Y).

violation_1(viol(X)) :- obligatory_1(X), not rexist_1(X), not compensate_1d(X).
violation_1(viol(X)) :- prohibited_1(X), rexist_1(X), not compensate_1d(X).

referTo_1(viol(X),X) :- violation_1(viol(X)).

%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 1. The Licensor grant_2s the Licensee a licence_2 to evaluate_2 the Product.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_2(Ev):- evaluate_2(Ev), hasAgent_2(Ev,X), licensee_2(X), hasTheme_2(Ev,P), product_2(P), not exceptionArt1b_2(Ev). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_1_2(Ev):- evaluate_2(Ev), hasAgent_2(Ev,X), licensee_2(X), hasTheme_2(Ev,P), product_2(P), isLicenceOf_2(L,P), licence_2(L), hasTheme_2(Eg,L), hasAgent_2(Eg,Y), licensor_2(Y), grant_2(Eg), rexist_2(Eg), hasReceiver_2(Eg,X).

exceptionArt1b_2(Ev):- condition_1_2(Ev).

permitted_2(Ev):- condition_1_2(Ev).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 2. The Licensee must not publish_2 the result_2s of the evaluation of the Product without the approval of the Licensor.
%           If the Licensee publish_2es result_2s of the evaluation of the Product without approval from the Licensor, 
%           the material must be remove_2d.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2a and Article 2c %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_2_2(Ep,X,R):- publish_2(Ep), hasAgent_2(Ep,X), licensee_2(X), hasTheme_2(Ep,R), result_2(R), hasResult_2(Ev,R), evaluate_2(Ev), rexist_2(Ev), not exceptionArt2b_2(Ep), not exceptionArt4a_2(Ep).

prohibited_2(Ep):- condition_2_2(Ep,X,R).

obligatory_2(ca(Ep,X,R)) :- rexist_2(Ep),condition_2_2(Ep,X,R).

remove_2(ca(Ep,X,R)) :- rexist_2(Ep),condition_2_2(Ep,X,R).

hasTheme_2(ca(Ep,X,R),R) :- rexist_2(Ep),condition_2_2(Ep,X,R).

hasAgent_2(ca(Ep,X,R),X) :- rexist_2(Ep),condition_2_2(Ep,X,R).

compensate_2(ca(Ep,X,R),Ep):- rexist_2(Ep),condition_2_2(Ep,X,R).
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_3_2(Ep):- publish_2(Ep), hasAgent_2(Ep,X), licensee_2(X), hasTheme_2(Ep,R), result_2(R), hasResult_2(Ev,R), evaluate_2(Ev), rexist_2(Ev), hasTheme_2(Ea,Ep), approve_2(Ea), rexist_2(Ea), hasAgent_2(Ea,Y), licensor_2(Y).

exceptionArt2b_2(Ep):- condition_3_2(Ep).

permitted_2(Ep):- condition_3_2(Ep).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 3. The Licensee must not publish_2 comment_2s on the evaluation of the Product,
%            unless the Licensee is permitted_2 to publish_2 the result_2s of the evaluation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_2(Ep):- publish_2(Ep), hasAgent_2(Ep,X), licensee_2(X), hasTheme_2(Ep,C), comment_2(C), isCommentOf_2(C,Ev), evaluate_2(Ev), rexist_2(Ev), not exceptionArt3b_2(Ep).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_4_2(Ep):- publish_2(Ep), hasAgent_2(Ep,X), licensee_2(X), hasTheme_2(Ep,C), comment_2(C), isCommentOf_2(C,Ev), evaluate_2(Ev), rexist_2(Ev), hasResult_2(Ev,R), hasTheme_2(Epr,R), hasAgent_2(Epr,X), publish_2(Epr), permitted_2(Epr).

exceptionArt3b_2(Ep):- condition_4_2(Ep).

permitted_2(Ep):- condition_4_2(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 4. If the Licensee is commission_2ed to perform an independent evaluation of the Product,then the Licensee has the obligation to publish_2 the evaluation result_2s.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 4a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_5_2(Ep):- publish_2(Ep), hasAgent_2(Ep,X), licensee_2(X), hasTheme_2(Ep,R), result_2(R), hasResult_2(Ev,R), evaluate_2(Ev), rexist_2(Ev), hasTheme_2(Ec,Ev), commission_2(Ec), rexist_2(Ec).

exceptionArt4a_2(Ep):- condition_5_2(Ep).

obligatory_2(Ep):- condition_5_2(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPLIANCE CHECKING RULES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%(1) if there is some action x obligatory_2 at time t and, at the same time, x does not really exist => violation_2; 
%(2) if there is some action x prohibited_2 at time t and, at the same time, x really exists => violation_2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rexist_2(ca(Ep,X,R)) :- remove_2(ca(Ep,X,R)), hasTheme_2(ca(Ep,X,R),R), hasAgent_2(ca(Ep,X,R),X), rexist_2(Er), remove_2(Er), hasTheme_2(Er,R),hasAgent_2(Er,X).

compensate_2d(X):- compensate_2(Y,X), rexist_2(Y).

violation_2(viol(X)) :- obligatory_2(X), not rexist_2(X), not compensate_2d(X).
violation_2(viol(X)) :- prohibited_2(X), rexist_2(X), not compensate_2d(X).

referTo_2(viol(X),X) :- violation_2(viol(X)).

%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 1. The Licensor grant_3s the Licensee a licence_3 to evaluate_3 the Product.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_3(Ev):- evaluate_3(Ev), hasAgent_3(Ev,X), licensee_3(X), hasTheme_3(Ev,P), product_3(P), not exceptionArt1b_3(Ev). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_1_3(Ev):- evaluate_3(Ev), hasAgent_3(Ev,X), licensee_3(X), hasTheme_3(Ev,P), product_3(P), isLicenceOf_3(L,P), licence_3(L), hasTheme_3(Eg,L), hasAgent_3(Eg,Y), licensor_3(Y), grant_3(Eg), rexist_3(Eg), hasReceiver_3(Eg,X).

exceptionArt1b_3(Ev):- condition_1_3(Ev).

permitted_3(Ev):- condition_1_3(Ev).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 2. The Licensee must not publish_3 the result_3s of the evaluation of the Product without the approval of the Licensor.
%           If the Licensee publish_3es result_3s of the evaluation of the Product without approval from the Licensor, 
%           the material must be remove_3d.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2a and Article 2c %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_2_3(Ep,X,R):- publish_3(Ep), hasAgent_3(Ep,X), licensee_3(X), hasTheme_3(Ep,R), result_3(R), hasResult_3(Ev,R), evaluate_3(Ev), rexist_3(Ev), not exceptionArt2b_3(Ep), not exceptionArt4a_3(Ep).

prohibited_3(Ep):- condition_2_3(Ep,X,R).

obligatory_3(ca(Ep,X,R)) :- rexist_3(Ep),condition_2_3(Ep,X,R).

remove_3(ca(Ep,X,R)) :- rexist_3(Ep),condition_2_3(Ep,X,R).

hasTheme_3(ca(Ep,X,R),R) :- rexist_3(Ep),condition_2_3(Ep,X,R).

hasAgent_3(ca(Ep,X,R),X) :- rexist_3(Ep),condition_2_3(Ep,X,R).

compensate_3(ca(Ep,X,R),Ep):- rexist_3(Ep),condition_2_3(Ep,X,R).
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_3_3(Ep):- publish_3(Ep), hasAgent_3(Ep,X), licensee_3(X), hasTheme_3(Ep,R), result_3(R), hasResult_3(Ev,R), evaluate_3(Ev), rexist_3(Ev), hasTheme_3(Ea,Ep), approve_3(Ea), rexist_3(Ea), hasAgent_3(Ea,Y), licensor_3(Y).

exceptionArt2b_3(Ep):- condition_3_3(Ep).

permitted_3(Ep):- condition_3_3(Ep).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 3. The Licensee must not publish_3 comment_3s on the evaluation of the Product,
%            unless the Licensee is permitted_3 to publish_3 the result_3s of the evaluation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_3(Ep):- publish_3(Ep), hasAgent_3(Ep,X), licensee_3(X), hasTheme_3(Ep,C), comment_3(C), isCommentOf_3(C,Ev), evaluate_3(Ev), rexist_3(Ev), not exceptionArt3b_3(Ep).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_4_3(Ep):- publish_3(Ep), hasAgent_3(Ep,X), licensee_3(X), hasTheme_3(Ep,C), comment_3(C), isCommentOf_3(C,Ev), evaluate_3(Ev), rexist_3(Ev), hasResult_3(Ev,R), hasTheme_3(Epr,R), hasAgent_3(Epr,X), publish_3(Epr), permitted_3(Epr).

exceptionArt3b_3(Ep):- condition_4_3(Ep).

permitted_3(Ep):- condition_4_3(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 4. If the Licensee is commission_3ed to perform an independent evaluation of the Product,then the Licensee has the obligation to publish_3 the evaluation result_3s.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 4a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_5_3(Ep):- publish_3(Ep), hasAgent_3(Ep,X), licensee_3(X), hasTheme_3(Ep,R), result_3(R), hasResult_3(Ev,R), evaluate_3(Ev), rexist_3(Ev), hasTheme_3(Ec,Ev), commission_3(Ec), rexist_3(Ec).

exceptionArt4a_3(Ep):- condition_5_3(Ep).

obligatory_3(Ep):- condition_5_3(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPLIANCE CHECKING RULES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%(1) if there is some action x obligatory_3 at time t and, at the same time, x does not really exist => violation_3; 
%(2) if there is some action x prohibited_3 at time t and, at the same time, x really exists => violation_3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rexist_3(ca(Ep,X,R)) :- remove_3(ca(Ep,X,R)), hasTheme_3(ca(Ep,X,R),R), hasAgent_3(ca(Ep,X,R),X), rexist_3(Er), remove_3(Er), hasTheme_3(Er,R),hasAgent_3(Er,X).

compensate_3d(X):- compensate_3(Y,X), rexist_3(Y).

violation_3(viol(X)) :- obligatory_3(X), not rexist_3(X), not compensate_3d(X).
violation_3(viol(X)) :- prohibited_3(X), rexist_3(X), not compensate_3d(X).

referTo_3(viol(X),X) :- violation_3(viol(X)).

%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 1. The Licensor grant_4s the Licensee a licence_4 to evaluate_4 the Product.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_4(Ev):- evaluate_4(Ev), hasAgent_4(Ev,X), licensee_4(X), hasTheme_4(Ev,P), product_4(P), not exceptionArt1b_4(Ev). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_1_4(Ev):- evaluate_4(Ev), hasAgent_4(Ev,X), licensee_4(X), hasTheme_4(Ev,P), product_4(P), isLicenceOf_4(L,P), licence_4(L), hasTheme_4(Eg,L), hasAgent_4(Eg,Y), licensor_4(Y), grant_4(Eg), rexist_4(Eg), hasReceiver_4(Eg,X).

exceptionArt1b_4(Ev):- condition_1_4(Ev).

permitted_4(Ev):- condition_1_4(Ev).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 2. The Licensee must not publish_4 the result_4s of the evaluation of the Product without the approval of the Licensor.
%           If the Licensee publish_4es result_4s of the evaluation of the Product without approval from the Licensor, 
%           the material must be remove_4d.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2a and Article 2c %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_2_4(Ep,X,R):- publish_4(Ep), hasAgent_4(Ep,X), licensee_4(X), hasTheme_4(Ep,R), result_4(R), hasResult_4(Ev,R), evaluate_4(Ev), rexist_4(Ev), not exceptionArt2b_4(Ep), not exceptionArt4a_4(Ep).

prohibited_4(Ep):- condition_2_4(Ep,X,R).

obligatory_4(ca(Ep,X,R)) :- rexist_4(Ep),condition_2_4(Ep,X,R).

remove_4(ca(Ep,X,R)) :- rexist_4(Ep),condition_2_4(Ep,X,R).

hasTheme_4(ca(Ep,X,R),R) :- rexist_4(Ep),condition_2_4(Ep,X,R).

hasAgent_4(ca(Ep,X,R),X) :- rexist_4(Ep),condition_2_4(Ep,X,R).

compensate_4(ca(Ep,X,R),Ep):- rexist_4(Ep),condition_2_4(Ep,X,R).
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_3_4(Ep):- publish_4(Ep), hasAgent_4(Ep,X), licensee_4(X), hasTheme_4(Ep,R), result_4(R), hasResult_4(Ev,R), evaluate_4(Ev), rexist_4(Ev), hasTheme_4(Ea,Ep), approve_4(Ea), rexist_4(Ea), hasAgent_4(Ea,Y), licensor_4(Y).

exceptionArt2b_4(Ep):- condition_3_4(Ep).

permitted_4(Ep):- condition_3_4(Ep).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 3. The Licensee must not publish_4 comment_4s on the evaluation of the Product,
%            unless the Licensee is permitted_4 to publish_4 the result_4s of the evaluation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_4(Ep):- publish_4(Ep), hasAgent_4(Ep,X), licensee_4(X), hasTheme_4(Ep,C), comment_4(C), isCommentOf_4(C,Ev), evaluate_4(Ev), rexist_4(Ev), not exceptionArt3b_4(Ep).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_4_4(Ep):- publish_4(Ep), hasAgent_4(Ep,X), licensee_4(X), hasTheme_4(Ep,C), comment_4(C), isCommentOf_4(C,Ev), evaluate_4(Ev), rexist_4(Ev), hasResult_4(Ev,R), hasTheme_4(Epr,R), hasAgent_4(Epr,X), publish_4(Epr), permitted_4(Epr).

exceptionArt3b_4(Ep):- condition_4_4(Ep).

permitted_4(Ep):- condition_4_4(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 4. If the Licensee is commission_4ed to perform an independent evaluation of the Product,then the Licensee has the obligation to publish_4 the evaluation result_4s.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 4a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_5_4(Ep):- publish_4(Ep), hasAgent_4(Ep,X), licensee_4(X), hasTheme_4(Ep,R), result_4(R), hasResult_4(Ev,R), evaluate_4(Ev), rexist_4(Ev), hasTheme_4(Ec,Ev), commission_4(Ec), rexist_4(Ec).

exceptionArt4a_4(Ep):- condition_5_4(Ep).

obligatory_4(Ep):- condition_5_4(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPLIANCE CHECKING RULES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%(1) if there is some action x obligatory_4 at time t and, at the same time, x does not really exist => violation_4; 
%(2) if there is some action x prohibited_4 at time t and, at the same time, x really exists => violation_4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rexist_4(ca(Ep,X,R)) :- remove_4(ca(Ep,X,R)), hasTheme_4(ca(Ep,X,R),R), hasAgent_4(ca(Ep,X,R),X), rexist_4(Er), remove_4(Er), hasTheme_4(Er,R),hasAgent_4(Er,X).

compensate_4d(X):- compensate_4(Y,X), rexist_4(Y).

violation_4(viol(X)) :- obligatory_4(X), not rexist_4(X), not compensate_4d(X).
violation_4(viol(X)) :- prohibited_4(X), rexist_4(X), not compensate_4d(X).

referTo_4(viol(X),X) :- violation_4(viol(X)).

%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 1. The Licensor grant_5s the Licensee a licence_5 to evaluate_5 the Product.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_5(Ev):- evaluate_5(Ev), hasAgent_5(Ev,X), licensee_5(X), hasTheme_5(Ev,P), product_5(P), not exceptionArt1b_5(Ev). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_1_5(Ev):- evaluate_5(Ev), hasAgent_5(Ev,X), licensee_5(X), hasTheme_5(Ev,P), product_5(P), isLicenceOf_5(L,P), licence_5(L), hasTheme_5(Eg,L), hasAgent_5(Eg,Y), licensor_5(Y), grant_5(Eg), rexist_5(Eg), hasReceiver_5(Eg,X).

exceptionArt1b_5(Ev):- condition_1_5(Ev).

permitted_5(Ev):- condition_1_5(Ev).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 2. The Licensee must not publish_5 the result_5s of the evaluation of the Product without the approval of the Licensor.
%           If the Licensee publish_5es result_5s of the evaluation of the Product without approval from the Licensor, 
%           the material must be remove_5d.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2a and Article 2c %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_2_5(Ep,X,R):- publish_5(Ep), hasAgent_5(Ep,X), licensee_5(X), hasTheme_5(Ep,R), result_5(R), hasResult_5(Ev,R), evaluate_5(Ev), rexist_5(Ev), not exceptionArt2b_5(Ep), not exceptionArt4a_5(Ep).

prohibited_5(Ep):- condition_2_5(Ep,X,R).

obligatory_5(ca(Ep,X,R)) :- rexist_5(Ep),condition_2_5(Ep,X,R).

remove_5(ca(Ep,X,R)) :- rexist_5(Ep),condition_2_5(Ep,X,R).

hasTheme_5(ca(Ep,X,R),R) :- rexist_5(Ep),condition_2_5(Ep,X,R).

hasAgent_5(ca(Ep,X,R),X) :- rexist_5(Ep),condition_2_5(Ep,X,R).

compensate_5(ca(Ep,X,R),Ep):- rexist_5(Ep),condition_2_5(Ep,X,R).
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_3_5(Ep):- publish_5(Ep), hasAgent_5(Ep,X), licensee_5(X), hasTheme_5(Ep,R), result_5(R), hasResult_5(Ev,R), evaluate_5(Ev), rexist_5(Ev), hasTheme_5(Ea,Ep), approve_5(Ea), rexist_5(Ea), hasAgent_5(Ea,Y), licensor_5(Y).

exceptionArt2b_5(Ep):- condition_3_5(Ep).

permitted_5(Ep):- condition_3_5(Ep).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 3. The Licensee must not publish_5 comment_5s on the evaluation of the Product,
%            unless the Licensee is permitted_5 to publish_5 the result_5s of the evaluation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_5(Ep):- publish_5(Ep), hasAgent_5(Ep,X), licensee_5(X), hasTheme_5(Ep,C), comment_5(C), isCommentOf_5(C,Ev), evaluate_5(Ev), rexist_5(Ev), not exceptionArt3b_5(Ep).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_4_5(Ep):- publish_5(Ep), hasAgent_5(Ep,X), licensee_5(X), hasTheme_5(Ep,C), comment_5(C), isCommentOf_5(C,Ev), evaluate_5(Ev), rexist_5(Ev), hasResult_5(Ev,R), hasTheme_5(Epr,R), hasAgent_5(Epr,X), publish_5(Epr), permitted_5(Epr).

exceptionArt3b_5(Ep):- condition_4_5(Ep).

permitted_5(Ep):- condition_4_5(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 4. If the Licensee is commission_5ed to perform an independent evaluation of the Product,then the Licensee has the obligation to publish_5 the evaluation result_5s.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 4a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_5_5(Ep):- publish_5(Ep), hasAgent_5(Ep,X), licensee_5(X), hasTheme_5(Ep,R), result_5(R), hasResult_5(Ev,R), evaluate_5(Ev), rexist_5(Ev), hasTheme_5(Ec,Ev), commission_5(Ec), rexist_5(Ec).

exceptionArt4a_5(Ep):- condition_5_5(Ep).

obligatory_5(Ep):- condition_5_5(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPLIANCE CHECKING RULES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%(1) if there is some action x obligatory_5 at time t and, at the same time, x does not really exist => violation_5; 
%(2) if there is some action x prohibited_5 at time t and, at the same time, x really exists => violation_5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rexist_5(ca(Ep,X,R)) :- remove_5(ca(Ep,X,R)), hasTheme_5(ca(Ep,X,R),R), hasAgent_5(ca(Ep,X,R),X), rexist_5(Er), remove_5(Er), hasTheme_5(Er,R),hasAgent_5(Er,X).

compensate_5d(X):- compensate_5(Y,X), rexist_5(Y).

violation_5(viol(X)) :- obligatory_5(X), not rexist_5(X), not compensate_5d(X).
violation_5(viol(X)) :- prohibited_5(X), rexist_5(X), not compensate_5d(X).

referTo_5(viol(X),X) :- violation_5(viol(X)).

%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 1. The Licensor grant_6s the Licensee a licence_6 to evaluate_6 the Product.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_6(Ev):- evaluate_6(Ev), hasAgent_6(Ev,X), licensee_6(X), hasTheme_6(Ev,P), product_6(P), not exceptionArt1b_6(Ev). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_1_6(Ev):- evaluate_6(Ev), hasAgent_6(Ev,X), licensee_6(X), hasTheme_6(Ev,P), product_6(P), isLicenceOf_6(L,P), licence_6(L), hasTheme_6(Eg,L), hasAgent_6(Eg,Y), licensor_6(Y), grant_6(Eg), rexist_6(Eg), hasReceiver_6(Eg,X).

exceptionArt1b_6(Ev):- condition_1_6(Ev).

permitted_6(Ev):- condition_1_6(Ev).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 2. The Licensee must not publish_6 the result_6s of the evaluation of the Product without the approval of the Licensor.
%           If the Licensee publish_6es result_6s of the evaluation of the Product without approval from the Licensor, 
%           the material must be remove_6d.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2a and Article 2c %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_2_6(Ep,X,R):- publish_6(Ep), hasAgent_6(Ep,X), licensee_6(X), hasTheme_6(Ep,R), result_6(R), hasResult_6(Ev,R), evaluate_6(Ev), rexist_6(Ev), not exceptionArt2b_6(Ep), not exceptionArt4a_6(Ep).

prohibited_6(Ep):- condition_2_6(Ep,X,R).

obligatory_6(ca(Ep,X,R)) :- rexist_6(Ep),condition_2_6(Ep,X,R).

remove_6(ca(Ep,X,R)) :- rexist_6(Ep),condition_2_6(Ep,X,R).

hasTheme_6(ca(Ep,X,R),R) :- rexist_6(Ep),condition_2_6(Ep,X,R).

hasAgent_6(ca(Ep,X,R),X) :- rexist_6(Ep),condition_2_6(Ep,X,R).

compensate_6(ca(Ep,X,R),Ep):- rexist_6(Ep),condition_2_6(Ep,X,R).
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_3_6(Ep):- publish_6(Ep), hasAgent_6(Ep,X), licensee_6(X), hasTheme_6(Ep,R), result_6(R), hasResult_6(Ev,R), evaluate_6(Ev), rexist_6(Ev), hasTheme_6(Ea,Ep), approve_6(Ea), rexist_6(Ea), hasAgent_6(Ea,Y), licensor_6(Y).

exceptionArt2b_6(Ep):- condition_3_6(Ep).

permitted_6(Ep):- condition_3_6(Ep).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 3. The Licensee must not publish_6 comment_6s on the evaluation of the Product,
%            unless the Licensee is permitted_6 to publish_6 the result_6s of the evaluation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_6(Ep):- publish_6(Ep), hasAgent_6(Ep,X), licensee_6(X), hasTheme_6(Ep,C), comment_6(C), isCommentOf_6(C,Ev), evaluate_6(Ev), rexist_6(Ev), not exceptionArt3b_6(Ep).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_4_6(Ep):- publish_6(Ep), hasAgent_6(Ep,X), licensee_6(X), hasTheme_6(Ep,C), comment_6(C), isCommentOf_6(C,Ev), evaluate_6(Ev), rexist_6(Ev), hasResult_6(Ev,R), hasTheme_6(Epr,R), hasAgent_6(Epr,X), publish_6(Epr), permitted_6(Epr).

exceptionArt3b_6(Ep):- condition_4_6(Ep).

permitted_6(Ep):- condition_4_6(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 4. If the Licensee is commission_6ed to perform an independent evaluation of the Product,then the Licensee has the obligation to publish_6 the evaluation result_6s.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 4a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_5_6(Ep):- publish_6(Ep), hasAgent_6(Ep,X), licensee_6(X), hasTheme_6(Ep,R), result_6(R), hasResult_6(Ev,R), evaluate_6(Ev), rexist_6(Ev), hasTheme_6(Ec,Ev), commission_6(Ec), rexist_6(Ec).

exceptionArt4a_6(Ep):- condition_5_6(Ep).

obligatory_6(Ep):- condition_5_6(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPLIANCE CHECKING RULES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%(1) if there is some action x obligatory_6 at time t and, at the same time, x does not really exist => violation_6; 
%(2) if there is some action x prohibited_6 at time t and, at the same time, x really exists => violation_6
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rexist_6(ca(Ep,X,R)) :- remove_6(ca(Ep,X,R)), hasTheme_6(ca(Ep,X,R),R), hasAgent_6(ca(Ep,X,R),X), rexist_6(Er), remove_6(Er), hasTheme_6(Er,R),hasAgent_6(Er,X).

compensate_6d(X):- compensate_6(Y,X), rexist_6(Y).

violation_6(viol(X)) :- obligatory_6(X), not rexist_6(X), not compensate_6d(X).
violation_6(viol(X)) :- prohibited_6(X), rexist_6(X), not compensate_6d(X).

referTo_6(viol(X),X) :- violation_6(viol(X)).

%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 1. The Licensor grant_7s the Licensee a licence_7 to evaluate_7 the Product.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_7(Ev):- evaluate_7(Ev), hasAgent_7(Ev,X), licensee_7(X), hasTheme_7(Ev,P), product_7(P), not exceptionArt1b_7(Ev). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_1_7(Ev):- evaluate_7(Ev), hasAgent_7(Ev,X), licensee_7(X), hasTheme_7(Ev,P), product_7(P), isLicenceOf_7(L,P), licence_7(L), hasTheme_7(Eg,L), hasAgent_7(Eg,Y), licensor_7(Y), grant_7(Eg), rexist_7(Eg), hasReceiver_7(Eg,X).

exceptionArt1b_7(Ev):- condition_1_7(Ev).

permitted_7(Ev):- condition_1_7(Ev).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 2. The Licensee must not publish_7 the result_7s of the evaluation of the Product without the approval of the Licensor.
%           If the Licensee publish_7es result_7s of the evaluation of the Product without approval from the Licensor, 
%           the material must be remove_7d.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2a and Article 2c %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_2_7(Ep,X,R):- publish_7(Ep), hasAgent_7(Ep,X), licensee_7(X), hasTheme_7(Ep,R), result_7(R), hasResult_7(Ev,R), evaluate_7(Ev), rexist_7(Ev), not exceptionArt2b_7(Ep), not exceptionArt4a_7(Ep).

prohibited_7(Ep):- condition_2_7(Ep,X,R).

obligatory_7(ca(Ep,X,R)) :- rexist_7(Ep),condition_2_7(Ep,X,R).

remove_7(ca(Ep,X,R)) :- rexist_7(Ep),condition_2_7(Ep,X,R).

hasTheme_7(ca(Ep,X,R),R) :- rexist_7(Ep),condition_2_7(Ep,X,R).

hasAgent_7(ca(Ep,X,R),X) :- rexist_7(Ep),condition_2_7(Ep,X,R).

compensate_7(ca(Ep,X,R),Ep):- rexist_7(Ep),condition_2_7(Ep,X,R).
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_3_7(Ep):- publish_7(Ep), hasAgent_7(Ep,X), licensee_7(X), hasTheme_7(Ep,R), result_7(R), hasResult_7(Ev,R), evaluate_7(Ev), rexist_7(Ev), hasTheme_7(Ea,Ep), approve_7(Ea), rexist_7(Ea), hasAgent_7(Ea,Y), licensor_7(Y).

exceptionArt2b_7(Ep):- condition_3_7(Ep).

permitted_7(Ep):- condition_3_7(Ep).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 3. The Licensee must not publish_7 comment_7s on the evaluation of the Product,
%            unless the Licensee is permitted_7 to publish_7 the result_7s of the evaluation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_7(Ep):- publish_7(Ep), hasAgent_7(Ep,X), licensee_7(X), hasTheme_7(Ep,C), comment_7(C), isCommentOf_7(C,Ev), evaluate_7(Ev), rexist_7(Ev), not exceptionArt3b_7(Ep).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_4_7(Ep):- publish_7(Ep), hasAgent_7(Ep,X), licensee_7(X), hasTheme_7(Ep,C), comment_7(C), isCommentOf_7(C,Ev), evaluate_7(Ev), rexist_7(Ev), hasResult_7(Ev,R), hasTheme_7(Epr,R), hasAgent_7(Epr,X), publish_7(Epr), permitted_7(Epr).

exceptionArt3b_7(Ep):- condition_4_7(Ep).

permitted_7(Ep):- condition_4_7(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 4. If the Licensee is commission_7ed to perform an independent evaluation of the Product,then the Licensee has the obligation to publish_7 the evaluation result_7s.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 4a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_5_7(Ep):- publish_7(Ep), hasAgent_7(Ep,X), licensee_7(X), hasTheme_7(Ep,R), result_7(R), hasResult_7(Ev,R), evaluate_7(Ev), rexist_7(Ev), hasTheme_7(Ec,Ev), commission_7(Ec), rexist_7(Ec).

exceptionArt4a_7(Ep):- condition_5_7(Ep).

obligatory_7(Ep):- condition_5_7(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPLIANCE CHECKING RULES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%(1) if there is some action x obligatory_7 at time t and, at the same time, x does not really exist => violation_7; 
%(2) if there is some action x prohibited_7 at time t and, at the same time, x really exists => violation_7
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rexist_7(ca(Ep,X,R)) :- remove_7(ca(Ep,X,R)), hasTheme_7(ca(Ep,X,R),R), hasAgent_7(ca(Ep,X,R),X), rexist_7(Er), remove_7(Er), hasTheme_7(Er,R),hasAgent_7(Er,X).

compensate_7d(X):- compensate_7(Y,X), rexist_7(Y).

violation_7(viol(X)) :- obligatory_7(X), not rexist_7(X), not compensate_7d(X).
violation_7(viol(X)) :- prohibited_7(X), rexist_7(X), not compensate_7d(X).

referTo_7(viol(X),X) :- violation_7(viol(X)).

%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 1. The Licensor grant_8s the Licensee a licence_8 to evaluate_8 the Product.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_8(Ev):- evaluate_8(Ev), hasAgent_8(Ev,X), licensee_8(X), hasTheme_8(Ev,P), product_8(P), not exceptionArt1b_8(Ev). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_1_8(Ev):- evaluate_8(Ev), hasAgent_8(Ev,X), licensee_8(X), hasTheme_8(Ev,P), product_8(P), isLicenceOf_8(L,P), licence_8(L), hasTheme_8(Eg,L), hasAgent_8(Eg,Y), licensor_8(Y), grant_8(Eg), rexist_8(Eg), hasReceiver_8(Eg,X).

exceptionArt1b_8(Ev):- condition_1_8(Ev).

permitted_8(Ev):- condition_1_8(Ev).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 2. The Licensee must not publish_8 the result_8s of the evaluation of the Product without the approval of the Licensor.
%           If the Licensee publish_8es result_8s of the evaluation of the Product without approval from the Licensor, 
%           the material must be remove_8d.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2a and Article 2c %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_2_8(Ep,X,R):- publish_8(Ep), hasAgent_8(Ep,X), licensee_8(X), hasTheme_8(Ep,R), result_8(R), hasResult_8(Ev,R), evaluate_8(Ev), rexist_8(Ev), not exceptionArt2b_8(Ep), not exceptionArt4a_8(Ep).

prohibited_8(Ep):- condition_2_8(Ep,X,R).

obligatory_8(ca(Ep,X,R)) :- rexist_8(Ep),condition_2_8(Ep,X,R).

remove_8(ca(Ep,X,R)) :- rexist_8(Ep),condition_2_8(Ep,X,R).

hasTheme_8(ca(Ep,X,R),R) :- rexist_8(Ep),condition_2_8(Ep,X,R).

hasAgent_8(ca(Ep,X,R),X) :- rexist_8(Ep),condition_2_8(Ep,X,R).

compensate_8(ca(Ep,X,R),Ep):- rexist_8(Ep),condition_2_8(Ep,X,R).
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_3_8(Ep):- publish_8(Ep), hasAgent_8(Ep,X), licensee_8(X), hasTheme_8(Ep,R), result_8(R), hasResult_8(Ev,R), evaluate_8(Ev), rexist_8(Ev), hasTheme_8(Ea,Ep), approve_8(Ea), rexist_8(Ea), hasAgent_8(Ea,Y), licensor_8(Y).

exceptionArt2b_8(Ep):- condition_3_8(Ep).

permitted_8(Ep):- condition_3_8(Ep).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 3. The Licensee must not publish_8 comment_8s on the evaluation of the Product,
%            unless the Licensee is permitted_8 to publish_8 the result_8s of the evaluation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_8(Ep):- publish_8(Ep), hasAgent_8(Ep,X), licensee_8(X), hasTheme_8(Ep,C), comment_8(C), isCommentOf_8(C,Ev), evaluate_8(Ev), rexist_8(Ev), not exceptionArt3b_8(Ep).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_4_8(Ep):- publish_8(Ep), hasAgent_8(Ep,X), licensee_8(X), hasTheme_8(Ep,C), comment_8(C), isCommentOf_8(C,Ev), evaluate_8(Ev), rexist_8(Ev), hasResult_8(Ev,R), hasTheme_8(Epr,R), hasAgent_8(Epr,X), publish_8(Epr), permitted_8(Epr).

exceptionArt3b_8(Ep):- condition_4_8(Ep).

permitted_8(Ep):- condition_4_8(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 4. If the Licensee is commission_8ed to perform an independent evaluation of the Product,then the Licensee has the obligation to publish_8 the evaluation result_8s.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 4a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_5_8(Ep):- publish_8(Ep), hasAgent_8(Ep,X), licensee_8(X), hasTheme_8(Ep,R), result_8(R), hasResult_8(Ev,R), evaluate_8(Ev), rexist_8(Ev), hasTheme_8(Ec,Ev), commission_8(Ec), rexist_8(Ec).

exceptionArt4a_8(Ep):- condition_5_8(Ep).

obligatory_8(Ep):- condition_5_8(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPLIANCE CHECKING RULES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%(1) if there is some action x obligatory_8 at time t and, at the same time, x does not really exist => violation_8; 
%(2) if there is some action x prohibited_8 at time t and, at the same time, x really exists => violation_8
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rexist_8(ca(Ep,X,R)) :- remove_8(ca(Ep,X,R)), hasTheme_8(ca(Ep,X,R),R), hasAgent_8(ca(Ep,X,R),X), rexist_8(Er), remove_8(Er), hasTheme_8(Er,R),hasAgent_8(Er,X).

compensate_8d(X):- compensate_8(Y,X), rexist_8(Y).

violation_8(viol(X)) :- obligatory_8(X), not rexist_8(X), not compensate_8d(X).
violation_8(viol(X)) :- prohibited_8(X), rexist_8(X), not compensate_8d(X).

referTo_8(viol(X),X) :- violation_8(viol(X)).

%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 1. The Licensor grant_9s the Licensee a licence_9 to evaluate_9 the Product.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_9(Ev):- evaluate_9(Ev), hasAgent_9(Ev,X), licensee_9(X), hasTheme_9(Ev,P), product_9(P), not exceptionArt1b_9(Ev). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_1_9(Ev):- evaluate_9(Ev), hasAgent_9(Ev,X), licensee_9(X), hasTheme_9(Ev,P), product_9(P), isLicenceOf_9(L,P), licence_9(L), hasTheme_9(Eg,L), hasAgent_9(Eg,Y), licensor_9(Y), grant_9(Eg), rexist_9(Eg), hasReceiver_9(Eg,X).

exceptionArt1b_9(Ev):- condition_1_9(Ev).

permitted_9(Ev):- condition_1_9(Ev).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 2. The Licensee must not publish_9 the result_9s of the evaluation of the Product without the approval of the Licensor.
%           If the Licensee publish_9es result_9s of the evaluation of the Product without approval from the Licensor, 
%           the material must be remove_9d.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2a and Article 2c %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_2_9(Ep,X,R):- publish_9(Ep), hasAgent_9(Ep,X), licensee_9(X), hasTheme_9(Ep,R), result_9(R), hasResult_9(Ev,R), evaluate_9(Ev), rexist_9(Ev), not exceptionArt2b_9(Ep), not exceptionArt4a_9(Ep).

prohibited_9(Ep):- condition_2_9(Ep,X,R).

obligatory_9(ca(Ep,X,R)) :- rexist_9(Ep),condition_2_9(Ep,X,R).

remove_9(ca(Ep,X,R)) :- rexist_9(Ep),condition_2_9(Ep,X,R).

hasTheme_9(ca(Ep,X,R),R) :- rexist_9(Ep),condition_2_9(Ep,X,R).

hasAgent_9(ca(Ep,X,R),X) :- rexist_9(Ep),condition_2_9(Ep,X,R).

compensate_9(ca(Ep,X,R),Ep):- rexist_9(Ep),condition_2_9(Ep,X,R).
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_3_9(Ep):- publish_9(Ep), hasAgent_9(Ep,X), licensee_9(X), hasTheme_9(Ep,R), result_9(R), hasResult_9(Ev,R), evaluate_9(Ev), rexist_9(Ev), hasTheme_9(Ea,Ep), approve_9(Ea), rexist_9(Ea), hasAgent_9(Ea,Y), licensor_9(Y).

exceptionArt2b_9(Ep):- condition_3_9(Ep).

permitted_9(Ep):- condition_3_9(Ep).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 3. The Licensee must not publish_9 comment_9s on the evaluation of the Product,
%            unless the Licensee is permitted_9 to publish_9 the result_9s of the evaluation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_9(Ep):- publish_9(Ep), hasAgent_9(Ep,X), licensee_9(X), hasTheme_9(Ep,C), comment_9(C), isCommentOf_9(C,Ev), evaluate_9(Ev), rexist_9(Ev), not exceptionArt3b_9(Ep).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_4_9(Ep):- publish_9(Ep), hasAgent_9(Ep,X), licensee_9(X), hasTheme_9(Ep,C), comment_9(C), isCommentOf_9(C,Ev), evaluate_9(Ev), rexist_9(Ev), hasResult_9(Ev,R), hasTheme_9(Epr,R), hasAgent_9(Epr,X), publish_9(Epr), permitted_9(Epr).

exceptionArt3b_9(Ep):- condition_4_9(Ep).

permitted_9(Ep):- condition_4_9(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 4. If the Licensee is commission_9ed to perform an independent evaluation of the Product,then the Licensee has the obligation to publish_9 the evaluation result_9s.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 4a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_5_9(Ep):- publish_9(Ep), hasAgent_9(Ep,X), licensee_9(X), hasTheme_9(Ep,R), result_9(R), hasResult_9(Ev,R), evaluate_9(Ev), rexist_9(Ev), hasTheme_9(Ec,Ev), commission_9(Ec), rexist_9(Ec).

exceptionArt4a_9(Ep):- condition_5_9(Ep).

obligatory_9(Ep):- condition_5_9(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPLIANCE CHECKING RULES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%(1) if there is some action x obligatory_9 at time t and, at the same time, x does not really exist => violation_9; 
%(2) if there is some action x prohibited_9 at time t and, at the same time, x really exists => violation_9
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rexist_9(ca(Ep,X,R)) :- remove_9(ca(Ep,X,R)), hasTheme_9(ca(Ep,X,R),R), hasAgent_9(ca(Ep,X,R),X), rexist_9(Er), remove_9(Er), hasTheme_9(Er,R),hasAgent_9(Er,X).

compensate_9d(X):- compensate_9(Y,X), rexist_9(Y).

violation_9(viol(X)) :- obligatory_9(X), not rexist_9(X), not compensate_9d(X).
violation_9(viol(X)) :- prohibited_9(X), rexist_9(X), not compensate_9d(X).

referTo_9(viol(X),X) :- violation_9(viol(X)).

%%%%%%%%%%%%

test(livio).

#include "asp10_10.asp".

#show test/1.
