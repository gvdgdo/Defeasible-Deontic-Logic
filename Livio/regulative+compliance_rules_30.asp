
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



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 1. The Licensor grant_10s the Licensee a licence_10 to evaluate_10 the Product.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_10(Ev):- evaluate_10(Ev), hasAgent_10(Ev,X), licensee_10(X), hasTheme_10(Ev,P), product_10(P), not exceptionArt1b_10(Ev). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_1_10(Ev):- evaluate_10(Ev), hasAgent_10(Ev,X), licensee_10(X), hasTheme_10(Ev,P), product_10(P), isLicenceOf_10(L,P), licence_10(L), hasTheme_10(Eg,L), hasAgent_10(Eg,Y), licensor_10(Y), grant_10(Eg), rexist_10(Eg), hasReceiver_10(Eg,X).

exceptionArt1b_10(Ev):- condition_1_10(Ev).

permitted_10(Ev):- condition_1_10(Ev).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 2. The Licensee must not publish_10 the result_10s of the evaluation of the Product without the approval of the Licensor.
%           If the Licensee publish_10es result_10s of the evaluation of the Product without approval from the Licensor, 
%           the material must be remove_10d.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2a and Article 2c %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_2_10(Ep,X,R):- publish_10(Ep), hasAgent_10(Ep,X), licensee_10(X), hasTheme_10(Ep,R), result_10(R), hasResult_10(Ev,R), evaluate_10(Ev), rexist_10(Ev), not exceptionArt2b_10(Ep), not exceptionArt4a_10(Ep).

prohibited_10(Ep):- condition_2_10(Ep,X,R).

obligatory_10(ca(Ep,X,R)) :- rexist_10(Ep),condition_2_10(Ep,X,R).

remove_10(ca(Ep,X,R)) :- rexist_10(Ep),condition_2_10(Ep,X,R).

hasTheme_10(ca(Ep,X,R),R) :- rexist_10(Ep),condition_2_10(Ep,X,R).

hasAgent_10(ca(Ep,X,R),X) :- rexist_10(Ep),condition_2_10(Ep,X,R).

compensate_10(ca(Ep,X,R),Ep):- rexist_10(Ep),condition_2_10(Ep,X,R).
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_3_10(Ep):- publish_10(Ep), hasAgent_10(Ep,X), licensee_10(X), hasTheme_10(Ep,R), result_10(R), hasResult_10(Ev,R), evaluate_10(Ev), rexist_10(Ev), hasTheme_10(Ea,Ep), approve_10(Ea), rexist_10(Ea), hasAgent_10(Ea,Y), licensor_10(Y).

exceptionArt2b_10(Ep):- condition_3_10(Ep).

permitted_10(Ep):- condition_3_10(Ep).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 3. The Licensee must not publish_10 comment_10s on the evaluation of the Product,
%            unless the Licensee is permitted_10 to publish_10 the result_10s of the evaluation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_10(Ep):- publish_10(Ep), hasAgent_10(Ep,X), licensee_10(X), hasTheme_10(Ep,C), comment_10(C), isCommentOf_10(C,Ev), evaluate_10(Ev), rexist_10(Ev), not exceptionArt3b_10(Ep).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_4_10(Ep):- publish_10(Ep), hasAgent_10(Ep,X), licensee_10(X), hasTheme_10(Ep,C), comment_10(C), isCommentOf_10(C,Ev), evaluate_10(Ev), rexist_10(Ev), hasResult_10(Ev,R), hasTheme_10(Epr,R), hasAgent_10(Epr,X), publish_10(Epr), permitted_10(Epr).

exceptionArt3b_10(Ep):- condition_4_10(Ep).

permitted_10(Ep):- condition_4_10(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 4. If the Licensee is commission_10ed to perform an independent evaluation of the Product,then the Licensee has the obligation to publish_10 the evaluation result_10s.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 4a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_5_10(Ep):- publish_10(Ep), hasAgent_10(Ep,X), licensee_10(X), hasTheme_10(Ep,R), result_10(R), hasResult_10(Ev,R), evaluate_10(Ev), rexist_10(Ev), hasTheme_10(Ec,Ev), commission_10(Ec), rexist_10(Ec).

exceptionArt4a_10(Ep):- condition_5_10(Ep).

obligatory_10(Ep):- condition_5_10(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPLIANCE CHECKING RULES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%(1) if there is some action x obligatory_10 at time t and, at the same time, x does not really exist => violation_10; 
%(2) if there is some action x prohibited_10 at time t and, at the same time, x really exists => violation_10
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rexist_10(ca(Ep,X,R)) :- remove_10(ca(Ep,X,R)), hasTheme_10(ca(Ep,X,R),R), hasAgent_10(ca(Ep,X,R),X), rexist_10(Er), remove_10(Er), hasTheme_10(Er,R),hasAgent_10(Er,X).

compensate_10d(X):- compensate_10(Y,X), rexist_10(Y).

violation_10(viol(X)) :- obligatory_10(X), not rexist_10(X), not compensate_10d(X).
violation_10(viol(X)) :- prohibited_10(X), rexist_10(X), not compensate_10d(X).

referTo_10(viol(X),X) :- violation_10(viol(X)).

%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 1. The Licensor grant_11s the Licensee a licence_11 to evaluate_11 the Product.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_11(Ev):- evaluate_11(Ev), hasAgent_11(Ev,X), licensee_11(X), hasTheme_11(Ev,P), product_11(P), not exceptionArt1b_11(Ev). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_1_11(Ev):- evaluate_11(Ev), hasAgent_11(Ev,X), licensee_11(X), hasTheme_11(Ev,P), product_11(P), isLicenceOf_11(L,P), licence_11(L), hasTheme_11(Eg,L), hasAgent_11(Eg,Y), licensor_11(Y), grant_11(Eg), rexist_11(Eg), hasReceiver_11(Eg,X).

exceptionArt1b_11(Ev):- condition_1_11(Ev).

permitted_11(Ev):- condition_1_11(Ev).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 2. The Licensee must not publish_11 the result_11s of the evaluation of the Product without the approval of the Licensor.
%           If the Licensee publish_11es result_11s of the evaluation of the Product without approval from the Licensor, 
%           the material must be remove_11d.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2a and Article 2c %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_2_11(Ep,X,R):- publish_11(Ep), hasAgent_11(Ep,X), licensee_11(X), hasTheme_11(Ep,R), result_11(R), hasResult_11(Ev,R), evaluate_11(Ev), rexist_11(Ev), not exceptionArt2b_11(Ep), not exceptionArt4a_11(Ep).

prohibited_11(Ep):- condition_2_11(Ep,X,R).

obligatory_11(ca(Ep,X,R)) :- rexist_11(Ep),condition_2_11(Ep,X,R).

remove_11(ca(Ep,X,R)) :- rexist_11(Ep),condition_2_11(Ep,X,R).

hasTheme_11(ca(Ep,X,R),R) :- rexist_11(Ep),condition_2_11(Ep,X,R).

hasAgent_11(ca(Ep,X,R),X) :- rexist_11(Ep),condition_2_11(Ep,X,R).

compensate_11(ca(Ep,X,R),Ep):- rexist_11(Ep),condition_2_11(Ep,X,R).
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_3_11(Ep):- publish_11(Ep), hasAgent_11(Ep,X), licensee_11(X), hasTheme_11(Ep,R), result_11(R), hasResult_11(Ev,R), evaluate_11(Ev), rexist_11(Ev), hasTheme_11(Ea,Ep), approve_11(Ea), rexist_11(Ea), hasAgent_11(Ea,Y), licensor_11(Y).

exceptionArt2b_11(Ep):- condition_3_11(Ep).

permitted_11(Ep):- condition_3_11(Ep).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 3. The Licensee must not publish_11 comment_11s on the evaluation of the Product,
%            unless the Licensee is permitted_11 to publish_11 the result_11s of the evaluation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_11(Ep):- publish_11(Ep), hasAgent_11(Ep,X), licensee_11(X), hasTheme_11(Ep,C), comment_11(C), isCommentOf_11(C,Ev), evaluate_11(Ev), rexist_11(Ev), not exceptionArt3b_11(Ep).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_4_11(Ep):- publish_11(Ep), hasAgent_11(Ep,X), licensee_11(X), hasTheme_11(Ep,C), comment_11(C), isCommentOf_11(C,Ev), evaluate_11(Ev), rexist_11(Ev), hasResult_11(Ev,R), hasTheme_11(Epr,R), hasAgent_11(Epr,X), publish_11(Epr), permitted_11(Epr).

exceptionArt3b_11(Ep):- condition_4_11(Ep).

permitted_11(Ep):- condition_4_11(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 4. If the Licensee is commission_11ed to perform an independent evaluation of the Product,then the Licensee has the obligation to publish_11 the evaluation result_11s.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 4a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_5_11(Ep):- publish_11(Ep), hasAgent_11(Ep,X), licensee_11(X), hasTheme_11(Ep,R), result_11(R), hasResult_11(Ev,R), evaluate_11(Ev), rexist_11(Ev), hasTheme_11(Ec,Ev), commission_11(Ec), rexist_11(Ec).

exceptionArt4a_11(Ep):- condition_5_11(Ep).

obligatory_11(Ep):- condition_5_11(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPLIANCE CHECKING RULES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%(1) if there is some action x obligatory_11 at time t and, at the same time, x does not really exist => violation_11; 
%(2) if there is some action x prohibited_11 at time t and, at the same time, x really exists => violation_11
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rexist_11(ca(Ep,X,R)) :- remove_11(ca(Ep,X,R)), hasTheme_11(ca(Ep,X,R),R), hasAgent_11(ca(Ep,X,R),X), rexist_11(Er), remove_11(Er), hasTheme_11(Er,R),hasAgent_11(Er,X).

compensate_11d(X):- compensate_11(Y,X), rexist_11(Y).

violation_11(viol(X)) :- obligatory_11(X), not rexist_11(X), not compensate_11d(X).
violation_11(viol(X)) :- prohibited_11(X), rexist_11(X), not compensate_11d(X).

referTo_11(viol(X),X) :- violation_11(viol(X)).

%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 1. The Licensor grant_12s the Licensee a licence_12 to evaluate_12 the Product.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_12(Ev):- evaluate_12(Ev), hasAgent_12(Ev,X), licensee_12(X), hasTheme_12(Ev,P), product_12(P), not exceptionArt1b_12(Ev). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_1_12(Ev):- evaluate_12(Ev), hasAgent_12(Ev,X), licensee_12(X), hasTheme_12(Ev,P), product_12(P), isLicenceOf_12(L,P), licence_12(L), hasTheme_12(Eg,L), hasAgent_12(Eg,Y), licensor_12(Y), grant_12(Eg), rexist_12(Eg), hasReceiver_12(Eg,X).

exceptionArt1b_12(Ev):- condition_1_12(Ev).

permitted_12(Ev):- condition_1_12(Ev).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 2. The Licensee must not publish_12 the result_12s of the evaluation of the Product without the approval of the Licensor.
%           If the Licensee publish_12es result_12s of the evaluation of the Product without approval from the Licensor, 
%           the material must be remove_12d.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2a and Article 2c %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_2_12(Ep,X,R):- publish_12(Ep), hasAgent_12(Ep,X), licensee_12(X), hasTheme_12(Ep,R), result_12(R), hasResult_12(Ev,R), evaluate_12(Ev), rexist_12(Ev), not exceptionArt2b_12(Ep), not exceptionArt4a_12(Ep).

prohibited_12(Ep):- condition_2_12(Ep,X,R).

obligatory_12(ca(Ep,X,R)) :- rexist_12(Ep),condition_2_12(Ep,X,R).

remove_12(ca(Ep,X,R)) :- rexist_12(Ep),condition_2_12(Ep,X,R).

hasTheme_12(ca(Ep,X,R),R) :- rexist_12(Ep),condition_2_12(Ep,X,R).

hasAgent_12(ca(Ep,X,R),X) :- rexist_12(Ep),condition_2_12(Ep,X,R).

compensate_12(ca(Ep,X,R),Ep):- rexist_12(Ep),condition_2_12(Ep,X,R).
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_3_12(Ep):- publish_12(Ep), hasAgent_12(Ep,X), licensee_12(X), hasTheme_12(Ep,R), result_12(R), hasResult_12(Ev,R), evaluate_12(Ev), rexist_12(Ev), hasTheme_12(Ea,Ep), approve_12(Ea), rexist_12(Ea), hasAgent_12(Ea,Y), licensor_12(Y).

exceptionArt2b_12(Ep):- condition_3_12(Ep).

permitted_12(Ep):- condition_3_12(Ep).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 3. The Licensee must not publish_12 comment_12s on the evaluation of the Product,
%            unless the Licensee is permitted_12 to publish_12 the result_12s of the evaluation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_12(Ep):- publish_12(Ep), hasAgent_12(Ep,X), licensee_12(X), hasTheme_12(Ep,C), comment_12(C), isCommentOf_12(C,Ev), evaluate_12(Ev), rexist_12(Ev), not exceptionArt3b_12(Ep).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_4_12(Ep):- publish_12(Ep), hasAgent_12(Ep,X), licensee_12(X), hasTheme_12(Ep,C), comment_12(C), isCommentOf_12(C,Ev), evaluate_12(Ev), rexist_12(Ev), hasResult_12(Ev,R), hasTheme_12(Epr,R), hasAgent_12(Epr,X), publish_12(Epr), permitted_12(Epr).

exceptionArt3b_12(Ep):- condition_4_12(Ep).

permitted_12(Ep):- condition_4_12(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 4. If the Licensee is commission_12ed to perform an independent evaluation of the Product,then the Licensee has the obligation to publish_12 the evaluation result_12s.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 4a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_5_12(Ep):- publish_12(Ep), hasAgent_12(Ep,X), licensee_12(X), hasTheme_12(Ep,R), result_12(R), hasResult_12(Ev,R), evaluate_12(Ev), rexist_12(Ev), hasTheme_12(Ec,Ev), commission_12(Ec), rexist_12(Ec).

exceptionArt4a_12(Ep):- condition_5_12(Ep).

obligatory_12(Ep):- condition_5_12(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPLIANCE CHECKING RULES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%(1) if there is some action x obligatory_12 at time t and, at the same time, x does not really exist => violation_12; 
%(2) if there is some action x prohibited_12 at time t and, at the same time, x really exists => violation_12
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rexist_12(ca(Ep,X,R)) :- remove_12(ca(Ep,X,R)), hasTheme_12(ca(Ep,X,R),R), hasAgent_12(ca(Ep,X,R),X), rexist_12(Er), remove_12(Er), hasTheme_12(Er,R),hasAgent_12(Er,X).

compensate_12d(X):- compensate_12(Y,X), rexist_12(Y).

violation_12(viol(X)) :- obligatory_12(X), not rexist_12(X), not compensate_12d(X).
violation_12(viol(X)) :- prohibited_12(X), rexist_12(X), not compensate_12d(X).

referTo_12(viol(X),X) :- violation_12(viol(X)).

%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 1. The Licensor grant_13s the Licensee a licence_13 to evaluate_13 the Product.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_13(Ev):- evaluate_13(Ev), hasAgent_13(Ev,X), licensee_13(X), hasTheme_13(Ev,P), product_13(P), not exceptionArt1b_13(Ev). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_1_13(Ev):- evaluate_13(Ev), hasAgent_13(Ev,X), licensee_13(X), hasTheme_13(Ev,P), product_13(P), isLicenceOf_13(L,P), licence_13(L), hasTheme_13(Eg,L), hasAgent_13(Eg,Y), licensor_13(Y), grant_13(Eg), rexist_13(Eg), hasReceiver_13(Eg,X).

exceptionArt1b_13(Ev):- condition_1_13(Ev).

permitted_13(Ev):- condition_1_13(Ev).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 2. The Licensee must not publish_13 the result_13s of the evaluation of the Product without the approval of the Licensor.
%           If the Licensee publish_13es result_13s of the evaluation of the Product without approval from the Licensor, 
%           the material must be remove_13d.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2a and Article 2c %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_2_13(Ep,X,R):- publish_13(Ep), hasAgent_13(Ep,X), licensee_13(X), hasTheme_13(Ep,R), result_13(R), hasResult_13(Ev,R), evaluate_13(Ev), rexist_13(Ev), not exceptionArt2b_13(Ep), not exceptionArt4a_13(Ep).

prohibited_13(Ep):- condition_2_13(Ep,X,R).

obligatory_13(ca(Ep,X,R)) :- rexist_13(Ep),condition_2_13(Ep,X,R).

remove_13(ca(Ep,X,R)) :- rexist_13(Ep),condition_2_13(Ep,X,R).

hasTheme_13(ca(Ep,X,R),R) :- rexist_13(Ep),condition_2_13(Ep,X,R).

hasAgent_13(ca(Ep,X,R),X) :- rexist_13(Ep),condition_2_13(Ep,X,R).

compensate_13(ca(Ep,X,R),Ep):- rexist_13(Ep),condition_2_13(Ep,X,R).
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_3_13(Ep):- publish_13(Ep), hasAgent_13(Ep,X), licensee_13(X), hasTheme_13(Ep,R), result_13(R), hasResult_13(Ev,R), evaluate_13(Ev), rexist_13(Ev), hasTheme_13(Ea,Ep), approve_13(Ea), rexist_13(Ea), hasAgent_13(Ea,Y), licensor_13(Y).

exceptionArt2b_13(Ep):- condition_3_13(Ep).

permitted_13(Ep):- condition_3_13(Ep).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 3. The Licensee must not publish_13 comment_13s on the evaluation of the Product,
%            unless the Licensee is permitted_13 to publish_13 the result_13s of the evaluation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_13(Ep):- publish_13(Ep), hasAgent_13(Ep,X), licensee_13(X), hasTheme_13(Ep,C), comment_13(C), isCommentOf_13(C,Ev), evaluate_13(Ev), rexist_13(Ev), not exceptionArt3b_13(Ep).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_4_13(Ep):- publish_13(Ep), hasAgent_13(Ep,X), licensee_13(X), hasTheme_13(Ep,C), comment_13(C), isCommentOf_13(C,Ev), evaluate_13(Ev), rexist_13(Ev), hasResult_13(Ev,R), hasTheme_13(Epr,R), hasAgent_13(Epr,X), publish_13(Epr), permitted_13(Epr).

exceptionArt3b_13(Ep):- condition_4_13(Ep).

permitted_13(Ep):- condition_4_13(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 4. If the Licensee is commission_13ed to perform an independent evaluation of the Product,then the Licensee has the obligation to publish_13 the evaluation result_13s.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 4a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_5_13(Ep):- publish_13(Ep), hasAgent_13(Ep,X), licensee_13(X), hasTheme_13(Ep,R), result_13(R), hasResult_13(Ev,R), evaluate_13(Ev), rexist_13(Ev), hasTheme_13(Ec,Ev), commission_13(Ec), rexist_13(Ec).

exceptionArt4a_13(Ep):- condition_5_13(Ep).

obligatory_13(Ep):- condition_5_13(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPLIANCE CHECKING RULES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%(1) if there is some action x obligatory_13 at time t and, at the same time, x does not really exist => violation_13; 
%(2) if there is some action x prohibited_13 at time t and, at the same time, x really exists => violation_13
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rexist_13(ca(Ep,X,R)) :- remove_13(ca(Ep,X,R)), hasTheme_13(ca(Ep,X,R),R), hasAgent_13(ca(Ep,X,R),X), rexist_13(Er), remove_13(Er), hasTheme_13(Er,R),hasAgent_13(Er,X).

compensate_13d(X):- compensate_13(Y,X), rexist_13(Y).

violation_13(viol(X)) :- obligatory_13(X), not rexist_13(X), not compensate_13d(X).
violation_13(viol(X)) :- prohibited_13(X), rexist_13(X), not compensate_13d(X).

referTo_13(viol(X),X) :- violation_13(viol(X)).

%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 1. The Licensor grant_14s the Licensee a licence_14 to evaluate_14 the Product.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_14(Ev):- evaluate_14(Ev), hasAgent_14(Ev,X), licensee_14(X), hasTheme_14(Ev,P), product_14(P), not exceptionArt1b_14(Ev). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_1_14(Ev):- evaluate_14(Ev), hasAgent_14(Ev,X), licensee_14(X), hasTheme_14(Ev,P), product_14(P), isLicenceOf_14(L,P), licence_14(L), hasTheme_14(Eg,L), hasAgent_14(Eg,Y), licensor_14(Y), grant_14(Eg), rexist_14(Eg), hasReceiver_14(Eg,X).

exceptionArt1b_14(Ev):- condition_1_14(Ev).

permitted_14(Ev):- condition_1_14(Ev).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 2. The Licensee must not publish_14 the result_14s of the evaluation of the Product without the approval of the Licensor.
%           If the Licensee publish_14es result_14s of the evaluation of the Product without approval from the Licensor, 
%           the material must be remove_14d.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2a and Article 2c %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_2_14(Ep,X,R):- publish_14(Ep), hasAgent_14(Ep,X), licensee_14(X), hasTheme_14(Ep,R), result_14(R), hasResult_14(Ev,R), evaluate_14(Ev), rexist_14(Ev), not exceptionArt2b_14(Ep), not exceptionArt4a_14(Ep).

prohibited_14(Ep):- condition_2_14(Ep,X,R).

obligatory_14(ca(Ep,X,R)) :- rexist_14(Ep),condition_2_14(Ep,X,R).

remove_14(ca(Ep,X,R)) :- rexist_14(Ep),condition_2_14(Ep,X,R).

hasTheme_14(ca(Ep,X,R),R) :- rexist_14(Ep),condition_2_14(Ep,X,R).

hasAgent_14(ca(Ep,X,R),X) :- rexist_14(Ep),condition_2_14(Ep,X,R).

compensate_14(ca(Ep,X,R),Ep):- rexist_14(Ep),condition_2_14(Ep,X,R).
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_3_14(Ep):- publish_14(Ep), hasAgent_14(Ep,X), licensee_14(X), hasTheme_14(Ep,R), result_14(R), hasResult_14(Ev,R), evaluate_14(Ev), rexist_14(Ev), hasTheme_14(Ea,Ep), approve_14(Ea), rexist_14(Ea), hasAgent_14(Ea,Y), licensor_14(Y).

exceptionArt2b_14(Ep):- condition_3_14(Ep).

permitted_14(Ep):- condition_3_14(Ep).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 3. The Licensee must not publish_14 comment_14s on the evaluation of the Product,
%            unless the Licensee is permitted_14 to publish_14 the result_14s of the evaluation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_14(Ep):- publish_14(Ep), hasAgent_14(Ep,X), licensee_14(X), hasTheme_14(Ep,C), comment_14(C), isCommentOf_14(C,Ev), evaluate_14(Ev), rexist_14(Ev), not exceptionArt3b_14(Ep).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_4_14(Ep):- publish_14(Ep), hasAgent_14(Ep,X), licensee_14(X), hasTheme_14(Ep,C), comment_14(C), isCommentOf_14(C,Ev), evaluate_14(Ev), rexist_14(Ev), hasResult_14(Ev,R), hasTheme_14(Epr,R), hasAgent_14(Epr,X), publish_14(Epr), permitted_14(Epr).

exceptionArt3b_14(Ep):- condition_4_14(Ep).

permitted_14(Ep):- condition_4_14(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 4. If the Licensee is commission_14ed to perform an independent evaluation of the Product,then the Licensee has the obligation to publish_14 the evaluation result_14s.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 4a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_5_14(Ep):- publish_14(Ep), hasAgent_14(Ep,X), licensee_14(X), hasTheme_14(Ep,R), result_14(R), hasResult_14(Ev,R), evaluate_14(Ev), rexist_14(Ev), hasTheme_14(Ec,Ev), commission_14(Ec), rexist_14(Ec).

exceptionArt4a_14(Ep):- condition_5_14(Ep).

obligatory_14(Ep):- condition_5_14(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPLIANCE CHECKING RULES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%(1) if there is some action x obligatory_14 at time t and, at the same time, x does not really exist => violation_14; 
%(2) if there is some action x prohibited_14 at time t and, at the same time, x really exists => violation_14
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rexist_14(ca(Ep,X,R)) :- remove_14(ca(Ep,X,R)), hasTheme_14(ca(Ep,X,R),R), hasAgent_14(ca(Ep,X,R),X), rexist_14(Er), remove_14(Er), hasTheme_14(Er,R),hasAgent_14(Er,X).

compensate_14d(X):- compensate_14(Y,X), rexist_14(Y).

violation_14(viol(X)) :- obligatory_14(X), not rexist_14(X), not compensate_14d(X).
violation_14(viol(X)) :- prohibited_14(X), rexist_14(X), not compensate_14d(X).

referTo_14(viol(X),X) :- violation_14(viol(X)).

%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 1. The Licensor grant_15s the Licensee a licence_15 to evaluate_15 the Product.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_15(Ev):- evaluate_15(Ev), hasAgent_15(Ev,X), licensee_15(X), hasTheme_15(Ev,P), product_15(P), not exceptionArt1b_15(Ev). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_1_15(Ev):- evaluate_15(Ev), hasAgent_15(Ev,X), licensee_15(X), hasTheme_15(Ev,P), product_15(P), isLicenceOf_15(L,P), licence_15(L), hasTheme_15(Eg,L), hasAgent_15(Eg,Y), licensor_15(Y), grant_15(Eg), rexist_15(Eg), hasReceiver_15(Eg,X).

exceptionArt1b_15(Ev):- condition_1_15(Ev).

permitted_15(Ev):- condition_1_15(Ev).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 2. The Licensee must not publish_15 the result_15s of the evaluation of the Product without the approval of the Licensor.
%           If the Licensee publish_15es result_15s of the evaluation of the Product without approval from the Licensor, 
%           the material must be remove_15d.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2a and Article 2c %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_2_15(Ep,X,R):- publish_15(Ep), hasAgent_15(Ep,X), licensee_15(X), hasTheme_15(Ep,R), result_15(R), hasResult_15(Ev,R), evaluate_15(Ev), rexist_15(Ev), not exceptionArt2b_15(Ep), not exceptionArt4a_15(Ep).

prohibited_15(Ep):- condition_2_15(Ep,X,R).

obligatory_15(ca(Ep,X,R)) :- rexist_15(Ep),condition_2_15(Ep,X,R).

remove_15(ca(Ep,X,R)) :- rexist_15(Ep),condition_2_15(Ep,X,R).

hasTheme_15(ca(Ep,X,R),R) :- rexist_15(Ep),condition_2_15(Ep,X,R).

hasAgent_15(ca(Ep,X,R),X) :- rexist_15(Ep),condition_2_15(Ep,X,R).

compensate_15(ca(Ep,X,R),Ep):- rexist_15(Ep),condition_2_15(Ep,X,R).
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_3_15(Ep):- publish_15(Ep), hasAgent_15(Ep,X), licensee_15(X), hasTheme_15(Ep,R), result_15(R), hasResult_15(Ev,R), evaluate_15(Ev), rexist_15(Ev), hasTheme_15(Ea,Ep), approve_15(Ea), rexist_15(Ea), hasAgent_15(Ea,Y), licensor_15(Y).

exceptionArt2b_15(Ep):- condition_3_15(Ep).

permitted_15(Ep):- condition_3_15(Ep).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 3. The Licensee must not publish_15 comment_15s on the evaluation of the Product,
%            unless the Licensee is permitted_15 to publish_15 the result_15s of the evaluation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_15(Ep):- publish_15(Ep), hasAgent_15(Ep,X), licensee_15(X), hasTheme_15(Ep,C), comment_15(C), isCommentOf_15(C,Ev), evaluate_15(Ev), rexist_15(Ev), not exceptionArt3b_15(Ep).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_4_15(Ep):- publish_15(Ep), hasAgent_15(Ep,X), licensee_15(X), hasTheme_15(Ep,C), comment_15(C), isCommentOf_15(C,Ev), evaluate_15(Ev), rexist_15(Ev), hasResult_15(Ev,R), hasTheme_15(Epr,R), hasAgent_15(Epr,X), publish_15(Epr), permitted_15(Epr).

exceptionArt3b_15(Ep):- condition_4_15(Ep).

permitted_15(Ep):- condition_4_15(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 4. If the Licensee is commission_15ed to perform an independent evaluation of the Product,then the Licensee has the obligation to publish_15 the evaluation result_15s.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 4a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_5_15(Ep):- publish_15(Ep), hasAgent_15(Ep,X), licensee_15(X), hasTheme_15(Ep,R), result_15(R), hasResult_15(Ev,R), evaluate_15(Ev), rexist_15(Ev), hasTheme_15(Ec,Ev), commission_15(Ec), rexist_15(Ec).

exceptionArt4a_15(Ep):- condition_5_15(Ep).

obligatory_15(Ep):- condition_5_15(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPLIANCE CHECKING RULES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%(1) if there is some action x obligatory_15 at time t and, at the same time, x does not really exist => violation_15; 
%(2) if there is some action x prohibited_15 at time t and, at the same time, x really exists => violation_15
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rexist_15(ca(Ep,X,R)) :- remove_15(ca(Ep,X,R)), hasTheme_15(ca(Ep,X,R),R), hasAgent_15(ca(Ep,X,R),X), rexist_15(Er), remove_15(Er), hasTheme_15(Er,R),hasAgent_15(Er,X).

compensate_15d(X):- compensate_15(Y,X), rexist_15(Y).

violation_15(viol(X)) :- obligatory_15(X), not rexist_15(X), not compensate_15d(X).
violation_15(viol(X)) :- prohibited_15(X), rexist_15(X), not compensate_15d(X).

referTo_15(viol(X),X) :- violation_15(viol(X)).

%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 1. The Licensor grant_16s the Licensee a licence_16 to evaluate_16 the Product.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_16(Ev):- evaluate_16(Ev), hasAgent_16(Ev,X), licensee_16(X), hasTheme_16(Ev,P), product_16(P), not exceptionArt1b_16(Ev). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_1_16(Ev):- evaluate_16(Ev), hasAgent_16(Ev,X), licensee_16(X), hasTheme_16(Ev,P), product_16(P), isLicenceOf_16(L,P), licence_16(L), hasTheme_16(Eg,L), hasAgent_16(Eg,Y), licensor_16(Y), grant_16(Eg), rexist_16(Eg), hasReceiver_16(Eg,X).

exceptionArt1b_16(Ev):- condition_1_16(Ev).

permitted_16(Ev):- condition_1_16(Ev).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 2. The Licensee must not publish_16 the result_16s of the evaluation of the Product without the approval of the Licensor.
%           If the Licensee publish_16es result_16s of the evaluation of the Product without approval from the Licensor, 
%           the material must be remove_16d.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2a and Article 2c %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_2_16(Ep,X,R):- publish_16(Ep), hasAgent_16(Ep,X), licensee_16(X), hasTheme_16(Ep,R), result_16(R), hasResult_16(Ev,R), evaluate_16(Ev), rexist_16(Ev), not exceptionArt2b_16(Ep), not exceptionArt4a_16(Ep).

prohibited_16(Ep):- condition_2_16(Ep,X,R).

obligatory_16(ca(Ep,X,R)) :- rexist_16(Ep),condition_2_16(Ep,X,R).

remove_16(ca(Ep,X,R)) :- rexist_16(Ep),condition_2_16(Ep,X,R).

hasTheme_16(ca(Ep,X,R),R) :- rexist_16(Ep),condition_2_16(Ep,X,R).

hasAgent_16(ca(Ep,X,R),X) :- rexist_16(Ep),condition_2_16(Ep,X,R).

compensate_16(ca(Ep,X,R),Ep):- rexist_16(Ep),condition_2_16(Ep,X,R).
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_3_16(Ep):- publish_16(Ep), hasAgent_16(Ep,X), licensee_16(X), hasTheme_16(Ep,R), result_16(R), hasResult_16(Ev,R), evaluate_16(Ev), rexist_16(Ev), hasTheme_16(Ea,Ep), approve_16(Ea), rexist_16(Ea), hasAgent_16(Ea,Y), licensor_16(Y).

exceptionArt2b_16(Ep):- condition_3_16(Ep).

permitted_16(Ep):- condition_3_16(Ep).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 3. The Licensee must not publish_16 comment_16s on the evaluation of the Product,
%            unless the Licensee is permitted_16 to publish_16 the result_16s of the evaluation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_16(Ep):- publish_16(Ep), hasAgent_16(Ep,X), licensee_16(X), hasTheme_16(Ep,C), comment_16(C), isCommentOf_16(C,Ev), evaluate_16(Ev), rexist_16(Ev), not exceptionArt3b_16(Ep).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_4_16(Ep):- publish_16(Ep), hasAgent_16(Ep,X), licensee_16(X), hasTheme_16(Ep,C), comment_16(C), isCommentOf_16(C,Ev), evaluate_16(Ev), rexist_16(Ev), hasResult_16(Ev,R), hasTheme_16(Epr,R), hasAgent_16(Epr,X), publish_16(Epr), permitted_16(Epr).

exceptionArt3b_16(Ep):- condition_4_16(Ep).

permitted_16(Ep):- condition_4_16(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 4. If the Licensee is commission_16ed to perform an independent evaluation of the Product,then the Licensee has the obligation to publish_16 the evaluation result_16s.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 4a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_5_16(Ep):- publish_16(Ep), hasAgent_16(Ep,X), licensee_16(X), hasTheme_16(Ep,R), result_16(R), hasResult_16(Ev,R), evaluate_16(Ev), rexist_16(Ev), hasTheme_16(Ec,Ev), commission_16(Ec), rexist_16(Ec).

exceptionArt4a_16(Ep):- condition_5_16(Ep).

obligatory_16(Ep):- condition_5_16(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPLIANCE CHECKING RULES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%(1) if there is some action x obligatory_16 at time t and, at the same time, x does not really exist => violation_16; 
%(2) if there is some action x prohibited_16 at time t and, at the same time, x really exists => violation_16
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rexist_16(ca(Ep,X,R)) :- remove_16(ca(Ep,X,R)), hasTheme_16(ca(Ep,X,R),R), hasAgent_16(ca(Ep,X,R),X), rexist_16(Er), remove_16(Er), hasTheme_16(Er,R),hasAgent_16(Er,X).

compensate_16d(X):- compensate_16(Y,X), rexist_16(Y).

violation_16(viol(X)) :- obligatory_16(X), not rexist_16(X), not compensate_16d(X).
violation_16(viol(X)) :- prohibited_16(X), rexist_16(X), not compensate_16d(X).

referTo_16(viol(X),X) :- violation_16(viol(X)).

%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 1. The Licensor grant_17s the Licensee a licence_17 to evaluate_17 the Product.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_17(Ev):- evaluate_17(Ev), hasAgent_17(Ev,X), licensee_17(X), hasTheme_17(Ev,P), product_17(P), not exceptionArt1b_17(Ev). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_1_17(Ev):- evaluate_17(Ev), hasAgent_17(Ev,X), licensee_17(X), hasTheme_17(Ev,P), product_17(P), isLicenceOf_17(L,P), licence_17(L), hasTheme_17(Eg,L), hasAgent_17(Eg,Y), licensor_17(Y), grant_17(Eg), rexist_17(Eg), hasReceiver_17(Eg,X).

exceptionArt1b_17(Ev):- condition_1_17(Ev).

permitted_17(Ev):- condition_1_17(Ev).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 2. The Licensee must not publish_17 the result_17s of the evaluation of the Product without the approval of the Licensor.
%           If the Licensee publish_17es result_17s of the evaluation of the Product without approval from the Licensor, 
%           the material must be remove_17d.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2a and Article 2c %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_2_17(Ep,X,R):- publish_17(Ep), hasAgent_17(Ep,X), licensee_17(X), hasTheme_17(Ep,R), result_17(R), hasResult_17(Ev,R), evaluate_17(Ev), rexist_17(Ev), not exceptionArt2b_17(Ep), not exceptionArt4a_17(Ep).

prohibited_17(Ep):- condition_2_17(Ep,X,R).

obligatory_17(ca(Ep,X,R)) :- rexist_17(Ep),condition_2_17(Ep,X,R).

remove_17(ca(Ep,X,R)) :- rexist_17(Ep),condition_2_17(Ep,X,R).

hasTheme_17(ca(Ep,X,R),R) :- rexist_17(Ep),condition_2_17(Ep,X,R).

hasAgent_17(ca(Ep,X,R),X) :- rexist_17(Ep),condition_2_17(Ep,X,R).

compensate_17(ca(Ep,X,R),Ep):- rexist_17(Ep),condition_2_17(Ep,X,R).
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_3_17(Ep):- publish_17(Ep), hasAgent_17(Ep,X), licensee_17(X), hasTheme_17(Ep,R), result_17(R), hasResult_17(Ev,R), evaluate_17(Ev), rexist_17(Ev), hasTheme_17(Ea,Ep), approve_17(Ea), rexist_17(Ea), hasAgent_17(Ea,Y), licensor_17(Y).

exceptionArt2b_17(Ep):- condition_3_17(Ep).

permitted_17(Ep):- condition_3_17(Ep).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 3. The Licensee must not publish_17 comment_17s on the evaluation of the Product,
%            unless the Licensee is permitted_17 to publish_17 the result_17s of the evaluation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_17(Ep):- publish_17(Ep), hasAgent_17(Ep,X), licensee_17(X), hasTheme_17(Ep,C), comment_17(C), isCommentOf_17(C,Ev), evaluate_17(Ev), rexist_17(Ev), not exceptionArt3b_17(Ep).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_4_17(Ep):- publish_17(Ep), hasAgent_17(Ep,X), licensee_17(X), hasTheme_17(Ep,C), comment_17(C), isCommentOf_17(C,Ev), evaluate_17(Ev), rexist_17(Ev), hasResult_17(Ev,R), hasTheme_17(Epr,R), hasAgent_17(Epr,X), publish_17(Epr), permitted_17(Epr).

exceptionArt3b_17(Ep):- condition_4_17(Ep).

permitted_17(Ep):- condition_4_17(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 4. If the Licensee is commission_17ed to perform an independent evaluation of the Product,then the Licensee has the obligation to publish_17 the evaluation result_17s.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 4a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_5_17(Ep):- publish_17(Ep), hasAgent_17(Ep,X), licensee_17(X), hasTheme_17(Ep,R), result_17(R), hasResult_17(Ev,R), evaluate_17(Ev), rexist_17(Ev), hasTheme_17(Ec,Ev), commission_17(Ec), rexist_17(Ec).

exceptionArt4a_17(Ep):- condition_5_17(Ep).

obligatory_17(Ep):- condition_5_17(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPLIANCE CHECKING RULES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%(1) if there is some action x obligatory_17 at time t and, at the same time, x does not really exist => violation_17; 
%(2) if there is some action x prohibited_17 at time t and, at the same time, x really exists => violation_17
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rexist_17(ca(Ep,X,R)) :- remove_17(ca(Ep,X,R)), hasTheme_17(ca(Ep,X,R),R), hasAgent_17(ca(Ep,X,R),X), rexist_17(Er), remove_17(Er), hasTheme_17(Er,R),hasAgent_17(Er,X).

compensate_17d(X):- compensate_17(Y,X), rexist_17(Y).

violation_17(viol(X)) :- obligatory_17(X), not rexist_17(X), not compensate_17d(X).
violation_17(viol(X)) :- prohibited_17(X), rexist_17(X), not compensate_17d(X).

referTo_17(viol(X),X) :- violation_17(viol(X)).

%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 1. The Licensor grant_18s the Licensee a licence_18 to evaluate_18 the Product.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_18(Ev):- evaluate_18(Ev), hasAgent_18(Ev,X), licensee_18(X), hasTheme_18(Ev,P), product_18(P), not exceptionArt1b_18(Ev). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_1_18(Ev):- evaluate_18(Ev), hasAgent_18(Ev,X), licensee_18(X), hasTheme_18(Ev,P), product_18(P), isLicenceOf_18(L,P), licence_18(L), hasTheme_18(Eg,L), hasAgent_18(Eg,Y), licensor_18(Y), grant_18(Eg), rexist_18(Eg), hasReceiver_18(Eg,X).

exceptionArt1b_18(Ev):- condition_1_18(Ev).

permitted_18(Ev):- condition_1_18(Ev).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 2. The Licensee must not publish_18 the result_18s of the evaluation of the Product without the approval of the Licensor.
%           If the Licensee publish_18es result_18s of the evaluation of the Product without approval from the Licensor, 
%           the material must be remove_18d.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2a and Article 2c %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_2_18(Ep,X,R):- publish_18(Ep), hasAgent_18(Ep,X), licensee_18(X), hasTheme_18(Ep,R), result_18(R), hasResult_18(Ev,R), evaluate_18(Ev), rexist_18(Ev), not exceptionArt2b_18(Ep), not exceptionArt4a_18(Ep).

prohibited_18(Ep):- condition_2_18(Ep,X,R).

obligatory_18(ca(Ep,X,R)) :- rexist_18(Ep),condition_2_18(Ep,X,R).

remove_18(ca(Ep,X,R)) :- rexist_18(Ep),condition_2_18(Ep,X,R).

hasTheme_18(ca(Ep,X,R),R) :- rexist_18(Ep),condition_2_18(Ep,X,R).

hasAgent_18(ca(Ep,X,R),X) :- rexist_18(Ep),condition_2_18(Ep,X,R).

compensate_18(ca(Ep,X,R),Ep):- rexist_18(Ep),condition_2_18(Ep,X,R).
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_3_18(Ep):- publish_18(Ep), hasAgent_18(Ep,X), licensee_18(X), hasTheme_18(Ep,R), result_18(R), hasResult_18(Ev,R), evaluate_18(Ev), rexist_18(Ev), hasTheme_18(Ea,Ep), approve_18(Ea), rexist_18(Ea), hasAgent_18(Ea,Y), licensor_18(Y).

exceptionArt2b_18(Ep):- condition_3_18(Ep).

permitted_18(Ep):- condition_3_18(Ep).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 3. The Licensee must not publish_18 comment_18s on the evaluation of the Product,
%            unless the Licensee is permitted_18 to publish_18 the result_18s of the evaluation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_18(Ep):- publish_18(Ep), hasAgent_18(Ep,X), licensee_18(X), hasTheme_18(Ep,C), comment_18(C), isCommentOf_18(C,Ev), evaluate_18(Ev), rexist_18(Ev), not exceptionArt3b_18(Ep).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_4_18(Ep):- publish_18(Ep), hasAgent_18(Ep,X), licensee_18(X), hasTheme_18(Ep,C), comment_18(C), isCommentOf_18(C,Ev), evaluate_18(Ev), rexist_18(Ev), hasResult_18(Ev,R), hasTheme_18(Epr,R), hasAgent_18(Epr,X), publish_18(Epr), permitted_18(Epr).

exceptionArt3b_18(Ep):- condition_4_18(Ep).

permitted_18(Ep):- condition_4_18(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 4. If the Licensee is commission_18ed to perform an independent evaluation of the Product,then the Licensee has the obligation to publish_18 the evaluation result_18s.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 4a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_5_18(Ep):- publish_18(Ep), hasAgent_18(Ep,X), licensee_18(X), hasTheme_18(Ep,R), result_18(R), hasResult_18(Ev,R), evaluate_18(Ev), rexist_18(Ev), hasTheme_18(Ec,Ev), commission_18(Ec), rexist_18(Ec).

exceptionArt4a_18(Ep):- condition_5_18(Ep).

obligatory_18(Ep):- condition_5_18(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPLIANCE CHECKING RULES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%(1) if there is some action x obligatory_18 at time t and, at the same time, x does not really exist => violation_18; 
%(2) if there is some action x prohibited_18 at time t and, at the same time, x really exists => violation_18
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rexist_18(ca(Ep,X,R)) :- remove_18(ca(Ep,X,R)), hasTheme_18(ca(Ep,X,R),R), hasAgent_18(ca(Ep,X,R),X), rexist_18(Er), remove_18(Er), hasTheme_18(Er,R),hasAgent_18(Er,X).

compensate_18d(X):- compensate_18(Y,X), rexist_18(Y).

violation_18(viol(X)) :- obligatory_18(X), not rexist_18(X), not compensate_18d(X).
violation_18(viol(X)) :- prohibited_18(X), rexist_18(X), not compensate_18d(X).

referTo_18(viol(X),X) :- violation_18(viol(X)).

%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 1. The Licensor grant_19s the Licensee a licence_19 to evaluate_19 the Product.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_19(Ev):- evaluate_19(Ev), hasAgent_19(Ev,X), licensee_19(X), hasTheme_19(Ev,P), product_19(P), not exceptionArt1b_19(Ev). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_1_19(Ev):- evaluate_19(Ev), hasAgent_19(Ev,X), licensee_19(X), hasTheme_19(Ev,P), product_19(P), isLicenceOf_19(L,P), licence_19(L), hasTheme_19(Eg,L), hasAgent_19(Eg,Y), licensor_19(Y), grant_19(Eg), rexist_19(Eg), hasReceiver_19(Eg,X).

exceptionArt1b_19(Ev):- condition_1_19(Ev).

permitted_19(Ev):- condition_1_19(Ev).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 2. The Licensee must not publish_19 the result_19s of the evaluation of the Product without the approval of the Licensor.
%           If the Licensee publish_19es result_19s of the evaluation of the Product without approval from the Licensor, 
%           the material must be remove_19d.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2a and Article 2c %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_2_19(Ep,X,R):- publish_19(Ep), hasAgent_19(Ep,X), licensee_19(X), hasTheme_19(Ep,R), result_19(R), hasResult_19(Ev,R), evaluate_19(Ev), rexist_19(Ev), not exceptionArt2b_19(Ep), not exceptionArt4a_19(Ep).

prohibited_19(Ep):- condition_2_19(Ep,X,R).

obligatory_19(ca(Ep,X,R)) :- rexist_19(Ep),condition_2_19(Ep,X,R).

remove_19(ca(Ep,X,R)) :- rexist_19(Ep),condition_2_19(Ep,X,R).

hasTheme_19(ca(Ep,X,R),R) :- rexist_19(Ep),condition_2_19(Ep,X,R).

hasAgent_19(ca(Ep,X,R),X) :- rexist_19(Ep),condition_2_19(Ep,X,R).

compensate_19(ca(Ep,X,R),Ep):- rexist_19(Ep),condition_2_19(Ep,X,R).
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_3_19(Ep):- publish_19(Ep), hasAgent_19(Ep,X), licensee_19(X), hasTheme_19(Ep,R), result_19(R), hasResult_19(Ev,R), evaluate_19(Ev), rexist_19(Ev), hasTheme_19(Ea,Ep), approve_19(Ea), rexist_19(Ea), hasAgent_19(Ea,Y), licensor_19(Y).

exceptionArt2b_19(Ep):- condition_3_19(Ep).

permitted_19(Ep):- condition_3_19(Ep).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 3. The Licensee must not publish_19 comment_19s on the evaluation of the Product,
%            unless the Licensee is permitted_19 to publish_19 the result_19s of the evaluation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_19(Ep):- publish_19(Ep), hasAgent_19(Ep,X), licensee_19(X), hasTheme_19(Ep,C), comment_19(C), isCommentOf_19(C,Ev), evaluate_19(Ev), rexist_19(Ev), not exceptionArt3b_19(Ep).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_4_19(Ep):- publish_19(Ep), hasAgent_19(Ep,X), licensee_19(X), hasTheme_19(Ep,C), comment_19(C), isCommentOf_19(C,Ev), evaluate_19(Ev), rexist_19(Ev), hasResult_19(Ev,R), hasTheme_19(Epr,R), hasAgent_19(Epr,X), publish_19(Epr), permitted_19(Epr).

exceptionArt3b_19(Ep):- condition_4_19(Ep).

permitted_19(Ep):- condition_4_19(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 4. If the Licensee is commission_19ed to perform an independent evaluation of the Product,then the Licensee has the obligation to publish_19 the evaluation result_19s.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 4a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_5_19(Ep):- publish_19(Ep), hasAgent_19(Ep,X), licensee_19(X), hasTheme_19(Ep,R), result_19(R), hasResult_19(Ev,R), evaluate_19(Ev), rexist_19(Ev), hasTheme_19(Ec,Ev), commission_19(Ec), rexist_19(Ec).

exceptionArt4a_19(Ep):- condition_5_19(Ep).

obligatory_19(Ep):- condition_5_19(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPLIANCE CHECKING RULES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%(1) if there is some action x obligatory_19 at time t and, at the same time, x does not really exist => violation_19; 
%(2) if there is some action x prohibited_19 at time t and, at the same time, x really exists => violation_19
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rexist_19(ca(Ep,X,R)) :- remove_19(ca(Ep,X,R)), hasTheme_19(ca(Ep,X,R),R), hasAgent_19(ca(Ep,X,R),X), rexist_19(Er), remove_19(Er), hasTheme_19(Er,R),hasAgent_19(Er,X).

compensate_19d(X):- compensate_19(Y,X), rexist_19(Y).

violation_19(viol(X)) :- obligatory_19(X), not rexist_19(X), not compensate_19d(X).
violation_19(viol(X)) :- prohibited_19(X), rexist_19(X), not compensate_19d(X).

referTo_19(viol(X),X) :- violation_19(viol(X)).

%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 1. The Licensor grant_20s the Licensee a licence_20 to evaluate_20 the Product.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_20(Ev):- evaluate_20(Ev), hasAgent_20(Ev,X), licensee_20(X), hasTheme_20(Ev,P), product_20(P), not exceptionArt1b_20(Ev). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_1_20(Ev):- evaluate_20(Ev), hasAgent_20(Ev,X), licensee_20(X), hasTheme_20(Ev,P), product_20(P), isLicenceOf_20(L,P), licence_20(L), hasTheme_20(Eg,L), hasAgent_20(Eg,Y), licensor_20(Y), grant_20(Eg), rexist_20(Eg), hasReceiver_20(Eg,X).

exceptionArt1b_20(Ev):- condition_1_20(Ev).

permitted_20(Ev):- condition_1_20(Ev).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 2. The Licensee must not publish_20 the result_20s of the evaluation of the Product without the approval of the Licensor.
%           If the Licensee publish_20es result_20s of the evaluation of the Product without approval from the Licensor, 
%           the material must be remove_20d.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2a and Article 2c %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_2_20(Ep,X,R):- publish_20(Ep), hasAgent_20(Ep,X), licensee_20(X), hasTheme_20(Ep,R), result_20(R), hasResult_20(Ev,R), evaluate_20(Ev), rexist_20(Ev), not exceptionArt2b_20(Ep), not exceptionArt4a_20(Ep).

prohibited_20(Ep):- condition_2_20(Ep,X,R).

obligatory_20(ca(Ep,X,R)) :- rexist_20(Ep),condition_2_20(Ep,X,R).

remove_20(ca(Ep,X,R)) :- rexist_20(Ep),condition_2_20(Ep,X,R).

hasTheme_20(ca(Ep,X,R),R) :- rexist_20(Ep),condition_2_20(Ep,X,R).

hasAgent_20(ca(Ep,X,R),X) :- rexist_20(Ep),condition_2_20(Ep,X,R).

compensate_20(ca(Ep,X,R),Ep):- rexist_20(Ep),condition_2_20(Ep,X,R).
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_3_20(Ep):- publish_20(Ep), hasAgent_20(Ep,X), licensee_20(X), hasTheme_20(Ep,R), result_20(R), hasResult_20(Ev,R), evaluate_20(Ev), rexist_20(Ev), hasTheme_20(Ea,Ep), approve_20(Ea), rexist_20(Ea), hasAgent_20(Ea,Y), licensor_20(Y).

exceptionArt2b_20(Ep):- condition_3_20(Ep).

permitted_20(Ep):- condition_3_20(Ep).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 3. The Licensee must not publish_20 comment_20s on the evaluation of the Product,
%            unless the Licensee is permitted_20 to publish_20 the result_20s of the evaluation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_20(Ep):- publish_20(Ep), hasAgent_20(Ep,X), licensee_20(X), hasTheme_20(Ep,C), comment_20(C), isCommentOf_20(C,Ev), evaluate_20(Ev), rexist_20(Ev), not exceptionArt3b_20(Ep).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_4_20(Ep):- publish_20(Ep), hasAgent_20(Ep,X), licensee_20(X), hasTheme_20(Ep,C), comment_20(C), isCommentOf_20(C,Ev), evaluate_20(Ev), rexist_20(Ev), hasResult_20(Ev,R), hasTheme_20(Epr,R), hasAgent_20(Epr,X), publish_20(Epr), permitted_20(Epr).

exceptionArt3b_20(Ep):- condition_4_20(Ep).

permitted_20(Ep):- condition_4_20(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 4. If the Licensee is commission_20ed to perform an independent evaluation of the Product,then the Licensee has the obligation to publish_20 the evaluation result_20s.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 4a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_5_20(Ep):- publish_20(Ep), hasAgent_20(Ep,X), licensee_20(X), hasTheme_20(Ep,R), result_20(R), hasResult_20(Ev,R), evaluate_20(Ev), rexist_20(Ev), hasTheme_20(Ec,Ev), commission_20(Ec), rexist_20(Ec).

exceptionArt4a_20(Ep):- condition_5_20(Ep).

obligatory_20(Ep):- condition_5_20(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPLIANCE CHECKING RULES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%(1) if there is some action x obligatory_20 at time t and, at the same time, x does not really exist => violation_20; 
%(2) if there is some action x prohibited_20 at time t and, at the same time, x really exists => violation_20
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rexist_20(ca(Ep,X,R)) :- remove_20(ca(Ep,X,R)), hasTheme_20(ca(Ep,X,R),R), hasAgent_20(ca(Ep,X,R),X), rexist_20(Er), remove_20(Er), hasTheme_20(Er,R),hasAgent_20(Er,X).

compensate_20d(X):- compensate_20(Y,X), rexist_20(Y).

violation_20(viol(X)) :- obligatory_20(X), not rexist_20(X), not compensate_20d(X).
violation_20(viol(X)) :- prohibited_20(X), rexist_20(X), not compensate_20d(X).

referTo_20(viol(X),X) :- violation_20(viol(X)).

%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 1. The Licensor grant_21s the Licensee a licence_21 to evaluate_21 the Product.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_21(Ev):- evaluate_21(Ev), hasAgent_21(Ev,X), licensee_21(X), hasTheme_21(Ev,P), product_21(P), not exceptionArt1b_21(Ev). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_1_21(Ev):- evaluate_21(Ev), hasAgent_21(Ev,X), licensee_21(X), hasTheme_21(Ev,P), product_21(P), isLicenceOf_21(L,P), licence_21(L), hasTheme_21(Eg,L), hasAgent_21(Eg,Y), licensor_21(Y), grant_21(Eg), rexist_21(Eg), hasReceiver_21(Eg,X).

exceptionArt1b_21(Ev):- condition_1_21(Ev).

permitted_21(Ev):- condition_1_21(Ev).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 2. The Licensee must not publish_21 the result_21s of the evaluation of the Product without the approval of the Licensor.
%           If the Licensee publish_21es result_21s of the evaluation of the Product without approval from the Licensor, 
%           the material must be remove_21d.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2a and Article 2c %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_2_21(Ep,X,R):- publish_21(Ep), hasAgent_21(Ep,X), licensee_21(X), hasTheme_21(Ep,R), result_21(R), hasResult_21(Ev,R), evaluate_21(Ev), rexist_21(Ev), not exceptionArt2b_21(Ep), not exceptionArt4a_21(Ep).

prohibited_21(Ep):- condition_2_21(Ep,X,R).

obligatory_21(ca(Ep,X,R)) :- rexist_21(Ep),condition_2_21(Ep,X,R).

remove_21(ca(Ep,X,R)) :- rexist_21(Ep),condition_2_21(Ep,X,R).

hasTheme_21(ca(Ep,X,R),R) :- rexist_21(Ep),condition_2_21(Ep,X,R).

hasAgent_21(ca(Ep,X,R),X) :- rexist_21(Ep),condition_2_21(Ep,X,R).

compensate_21(ca(Ep,X,R),Ep):- rexist_21(Ep),condition_2_21(Ep,X,R).
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_3_21(Ep):- publish_21(Ep), hasAgent_21(Ep,X), licensee_21(X), hasTheme_21(Ep,R), result_21(R), hasResult_21(Ev,R), evaluate_21(Ev), rexist_21(Ev), hasTheme_21(Ea,Ep), approve_21(Ea), rexist_21(Ea), hasAgent_21(Ea,Y), licensor_21(Y).

exceptionArt2b_21(Ep):- condition_3_21(Ep).

permitted_21(Ep):- condition_3_21(Ep).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 3. The Licensee must not publish_21 comment_21s on the evaluation of the Product,
%            unless the Licensee is permitted_21 to publish_21 the result_21s of the evaluation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_21(Ep):- publish_21(Ep), hasAgent_21(Ep,X), licensee_21(X), hasTheme_21(Ep,C), comment_21(C), isCommentOf_21(C,Ev), evaluate_21(Ev), rexist_21(Ev), not exceptionArt3b_21(Ep).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_4_21(Ep):- publish_21(Ep), hasAgent_21(Ep,X), licensee_21(X), hasTheme_21(Ep,C), comment_21(C), isCommentOf_21(C,Ev), evaluate_21(Ev), rexist_21(Ev), hasResult_21(Ev,R), hasTheme_21(Epr,R), hasAgent_21(Epr,X), publish_21(Epr), permitted_21(Epr).

exceptionArt3b_21(Ep):- condition_4_21(Ep).

permitted_21(Ep):- condition_4_21(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 4. If the Licensee is commission_21ed to perform an independent evaluation of the Product,then the Licensee has the obligation to publish_21 the evaluation result_21s.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 4a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_5_21(Ep):- publish_21(Ep), hasAgent_21(Ep,X), licensee_21(X), hasTheme_21(Ep,R), result_21(R), hasResult_21(Ev,R), evaluate_21(Ev), rexist_21(Ev), hasTheme_21(Ec,Ev), commission_21(Ec), rexist_21(Ec).

exceptionArt4a_21(Ep):- condition_5_21(Ep).

obligatory_21(Ep):- condition_5_21(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPLIANCE CHECKING RULES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%(1) if there is some action x obligatory_21 at time t and, at the same time, x does not really exist => violation_21; 
%(2) if there is some action x prohibited_21 at time t and, at the same time, x really exists => violation_21
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rexist_21(ca(Ep,X,R)) :- remove_21(ca(Ep,X,R)), hasTheme_21(ca(Ep,X,R),R), hasAgent_21(ca(Ep,X,R),X), rexist_21(Er), remove_21(Er), hasTheme_21(Er,R),hasAgent_21(Er,X).

compensate_21d(X):- compensate_21(Y,X), rexist_21(Y).

violation_21(viol(X)) :- obligatory_21(X), not rexist_21(X), not compensate_21d(X).
violation_21(viol(X)) :- prohibited_21(X), rexist_21(X), not compensate_21d(X).

referTo_21(viol(X),X) :- violation_21(viol(X)).

%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 1. The Licensor grant_22s the Licensee a licence_22 to evaluate_22 the Product.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_22(Ev):- evaluate_22(Ev), hasAgent_22(Ev,X), licensee_22(X), hasTheme_22(Ev,P), product_22(P), not exceptionArt1b_22(Ev). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_1_22(Ev):- evaluate_22(Ev), hasAgent_22(Ev,X), licensee_22(X), hasTheme_22(Ev,P), product_22(P), isLicenceOf_22(L,P), licence_22(L), hasTheme_22(Eg,L), hasAgent_22(Eg,Y), licensor_22(Y), grant_22(Eg), rexist_22(Eg), hasReceiver_22(Eg,X).

exceptionArt1b_22(Ev):- condition_1_22(Ev).

permitted_22(Ev):- condition_1_22(Ev).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 2. The Licensee must not publish_22 the result_22s of the evaluation of the Product without the approval of the Licensor.
%           If the Licensee publish_22es result_22s of the evaluation of the Product without approval from the Licensor, 
%           the material must be remove_22d.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2a and Article 2c %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_2_22(Ep,X,R):- publish_22(Ep), hasAgent_22(Ep,X), licensee_22(X), hasTheme_22(Ep,R), result_22(R), hasResult_22(Ev,R), evaluate_22(Ev), rexist_22(Ev), not exceptionArt2b_22(Ep), not exceptionArt4a_22(Ep).

prohibited_22(Ep):- condition_2_22(Ep,X,R).

obligatory_22(ca(Ep,X,R)) :- rexist_22(Ep),condition_2_22(Ep,X,R).

remove_22(ca(Ep,X,R)) :- rexist_22(Ep),condition_2_22(Ep,X,R).

hasTheme_22(ca(Ep,X,R),R) :- rexist_22(Ep),condition_2_22(Ep,X,R).

hasAgent_22(ca(Ep,X,R),X) :- rexist_22(Ep),condition_2_22(Ep,X,R).

compensate_22(ca(Ep,X,R),Ep):- rexist_22(Ep),condition_2_22(Ep,X,R).
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_3_22(Ep):- publish_22(Ep), hasAgent_22(Ep,X), licensee_22(X), hasTheme_22(Ep,R), result_22(R), hasResult_22(Ev,R), evaluate_22(Ev), rexist_22(Ev), hasTheme_22(Ea,Ep), approve_22(Ea), rexist_22(Ea), hasAgent_22(Ea,Y), licensor_22(Y).

exceptionArt2b_22(Ep):- condition_3_22(Ep).

permitted_22(Ep):- condition_3_22(Ep).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 3. The Licensee must not publish_22 comment_22s on the evaluation of the Product,
%            unless the Licensee is permitted_22 to publish_22 the result_22s of the evaluation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_22(Ep):- publish_22(Ep), hasAgent_22(Ep,X), licensee_22(X), hasTheme_22(Ep,C), comment_22(C), isCommentOf_22(C,Ev), evaluate_22(Ev), rexist_22(Ev), not exceptionArt3b_22(Ep).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_4_22(Ep):- publish_22(Ep), hasAgent_22(Ep,X), licensee_22(X), hasTheme_22(Ep,C), comment_22(C), isCommentOf_22(C,Ev), evaluate_22(Ev), rexist_22(Ev), hasResult_22(Ev,R), hasTheme_22(Epr,R), hasAgent_22(Epr,X), publish_22(Epr), permitted_22(Epr).

exceptionArt3b_22(Ep):- condition_4_22(Ep).

permitted_22(Ep):- condition_4_22(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 4. If the Licensee is commission_22ed to perform an independent evaluation of the Product,then the Licensee has the obligation to publish_22 the evaluation result_22s.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 4a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_5_22(Ep):- publish_22(Ep), hasAgent_22(Ep,X), licensee_22(X), hasTheme_22(Ep,R), result_22(R), hasResult_22(Ev,R), evaluate_22(Ev), rexist_22(Ev), hasTheme_22(Ec,Ev), commission_22(Ec), rexist_22(Ec).

exceptionArt4a_22(Ep):- condition_5_22(Ep).

obligatory_22(Ep):- condition_5_22(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPLIANCE CHECKING RULES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%(1) if there is some action x obligatory_22 at time t and, at the same time, x does not really exist => violation_22; 
%(2) if there is some action x prohibited_22 at time t and, at the same time, x really exists => violation_22
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rexist_22(ca(Ep,X,R)) :- remove_22(ca(Ep,X,R)), hasTheme_22(ca(Ep,X,R),R), hasAgent_22(ca(Ep,X,R),X), rexist_22(Er), remove_22(Er), hasTheme_22(Er,R),hasAgent_22(Er,X).

compensate_22d(X):- compensate_22(Y,X), rexist_22(Y).

violation_22(viol(X)) :- obligatory_22(X), not rexist_22(X), not compensate_22d(X).
violation_22(viol(X)) :- prohibited_22(X), rexist_22(X), not compensate_22d(X).

referTo_22(viol(X),X) :- violation_22(viol(X)).

%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 1. The Licensor grant_23s the Licensee a licence_23 to evaluate_23 the Product.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_23(Ev):- evaluate_23(Ev), hasAgent_23(Ev,X), licensee_23(X), hasTheme_23(Ev,P), product_23(P), not exceptionArt1b_23(Ev). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_1_23(Ev):- evaluate_23(Ev), hasAgent_23(Ev,X), licensee_23(X), hasTheme_23(Ev,P), product_23(P), isLicenceOf_23(L,P), licence_23(L), hasTheme_23(Eg,L), hasAgent_23(Eg,Y), licensor_23(Y), grant_23(Eg), rexist_23(Eg), hasReceiver_23(Eg,X).

exceptionArt1b_23(Ev):- condition_1_23(Ev).

permitted_23(Ev):- condition_1_23(Ev).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 2. The Licensee must not publish_23 the result_23s of the evaluation of the Product without the approval of the Licensor.
%           If the Licensee publish_23es result_23s of the evaluation of the Product without approval from the Licensor, 
%           the material must be remove_23d.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2a and Article 2c %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_2_23(Ep,X,R):- publish_23(Ep), hasAgent_23(Ep,X), licensee_23(X), hasTheme_23(Ep,R), result_23(R), hasResult_23(Ev,R), evaluate_23(Ev), rexist_23(Ev), not exceptionArt2b_23(Ep), not exceptionArt4a_23(Ep).

prohibited_23(Ep):- condition_2_23(Ep,X,R).

obligatory_23(ca(Ep,X,R)) :- rexist_23(Ep),condition_2_23(Ep,X,R).

remove_23(ca(Ep,X,R)) :- rexist_23(Ep),condition_2_23(Ep,X,R).

hasTheme_23(ca(Ep,X,R),R) :- rexist_23(Ep),condition_2_23(Ep,X,R).

hasAgent_23(ca(Ep,X,R),X) :- rexist_23(Ep),condition_2_23(Ep,X,R).

compensate_23(ca(Ep,X,R),Ep):- rexist_23(Ep),condition_2_23(Ep,X,R).
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_3_23(Ep):- publish_23(Ep), hasAgent_23(Ep,X), licensee_23(X), hasTheme_23(Ep,R), result_23(R), hasResult_23(Ev,R), evaluate_23(Ev), rexist_23(Ev), hasTheme_23(Ea,Ep), approve_23(Ea), rexist_23(Ea), hasAgent_23(Ea,Y), licensor_23(Y).

exceptionArt2b_23(Ep):- condition_3_23(Ep).

permitted_23(Ep):- condition_3_23(Ep).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 3. The Licensee must not publish_23 comment_23s on the evaluation of the Product,
%            unless the Licensee is permitted_23 to publish_23 the result_23s of the evaluation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_23(Ep):- publish_23(Ep), hasAgent_23(Ep,X), licensee_23(X), hasTheme_23(Ep,C), comment_23(C), isCommentOf_23(C,Ev), evaluate_23(Ev), rexist_23(Ev), not exceptionArt3b_23(Ep).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_4_23(Ep):- publish_23(Ep), hasAgent_23(Ep,X), licensee_23(X), hasTheme_23(Ep,C), comment_23(C), isCommentOf_23(C,Ev), evaluate_23(Ev), rexist_23(Ev), hasResult_23(Ev,R), hasTheme_23(Epr,R), hasAgent_23(Epr,X), publish_23(Epr), permitted_23(Epr).

exceptionArt3b_23(Ep):- condition_4_23(Ep).

permitted_23(Ep):- condition_4_23(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 4. If the Licensee is commission_23ed to perform an independent evaluation of the Product,then the Licensee has the obligation to publish_23 the evaluation result_23s.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 4a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_5_23(Ep):- publish_23(Ep), hasAgent_23(Ep,X), licensee_23(X), hasTheme_23(Ep,R), result_23(R), hasResult_23(Ev,R), evaluate_23(Ev), rexist_23(Ev), hasTheme_23(Ec,Ev), commission_23(Ec), rexist_23(Ec).

exceptionArt4a_23(Ep):- condition_5_23(Ep).

obligatory_23(Ep):- condition_5_23(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPLIANCE CHECKING RULES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%(1) if there is some action x obligatory_23 at time t and, at the same time, x does not really exist => violation_23; 
%(2) if there is some action x prohibited_23 at time t and, at the same time, x really exists => violation_23
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rexist_23(ca(Ep,X,R)) :- remove_23(ca(Ep,X,R)), hasTheme_23(ca(Ep,X,R),R), hasAgent_23(ca(Ep,X,R),X), rexist_23(Er), remove_23(Er), hasTheme_23(Er,R),hasAgent_23(Er,X).

compensate_23d(X):- compensate_23(Y,X), rexist_23(Y).

violation_23(viol(X)) :- obligatory_23(X), not rexist_23(X), not compensate_23d(X).
violation_23(viol(X)) :- prohibited_23(X), rexist_23(X), not compensate_23d(X).

referTo_23(viol(X),X) :- violation_23(viol(X)).

%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 1. The Licensor grant_24s the Licensee a licence_24 to evaluate_24 the Product.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_24(Ev):- evaluate_24(Ev), hasAgent_24(Ev,X), licensee_24(X), hasTheme_24(Ev,P), product_24(P), not exceptionArt1b_24(Ev). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_1_24(Ev):- evaluate_24(Ev), hasAgent_24(Ev,X), licensee_24(X), hasTheme_24(Ev,P), product_24(P), isLicenceOf_24(L,P), licence_24(L), hasTheme_24(Eg,L), hasAgent_24(Eg,Y), licensor_24(Y), grant_24(Eg), rexist_24(Eg), hasReceiver_24(Eg,X).

exceptionArt1b_24(Ev):- condition_1_24(Ev).

permitted_24(Ev):- condition_1_24(Ev).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 2. The Licensee must not publish_24 the result_24s of the evaluation of the Product without the approval of the Licensor.
%           If the Licensee publish_24es result_24s of the evaluation of the Product without approval from the Licensor, 
%           the material must be remove_24d.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2a and Article 2c %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_2_24(Ep,X,R):- publish_24(Ep), hasAgent_24(Ep,X), licensee_24(X), hasTheme_24(Ep,R), result_24(R), hasResult_24(Ev,R), evaluate_24(Ev), rexist_24(Ev), not exceptionArt2b_24(Ep), not exceptionArt4a_24(Ep).

prohibited_24(Ep):- condition_2_24(Ep,X,R).

obligatory_24(ca(Ep,X,R)) :- rexist_24(Ep),condition_2_24(Ep,X,R).

remove_24(ca(Ep,X,R)) :- rexist_24(Ep),condition_2_24(Ep,X,R).

hasTheme_24(ca(Ep,X,R),R) :- rexist_24(Ep),condition_2_24(Ep,X,R).

hasAgent_24(ca(Ep,X,R),X) :- rexist_24(Ep),condition_2_24(Ep,X,R).

compensate_24(ca(Ep,X,R),Ep):- rexist_24(Ep),condition_2_24(Ep,X,R).
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_3_24(Ep):- publish_24(Ep), hasAgent_24(Ep,X), licensee_24(X), hasTheme_24(Ep,R), result_24(R), hasResult_24(Ev,R), evaluate_24(Ev), rexist_24(Ev), hasTheme_24(Ea,Ep), approve_24(Ea), rexist_24(Ea), hasAgent_24(Ea,Y), licensor_24(Y).

exceptionArt2b_24(Ep):- condition_3_24(Ep).

permitted_24(Ep):- condition_3_24(Ep).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 3. The Licensee must not publish_24 comment_24s on the evaluation of the Product,
%            unless the Licensee is permitted_24 to publish_24 the result_24s of the evaluation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_24(Ep):- publish_24(Ep), hasAgent_24(Ep,X), licensee_24(X), hasTheme_24(Ep,C), comment_24(C), isCommentOf_24(C,Ev), evaluate_24(Ev), rexist_24(Ev), not exceptionArt3b_24(Ep).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_4_24(Ep):- publish_24(Ep), hasAgent_24(Ep,X), licensee_24(X), hasTheme_24(Ep,C), comment_24(C), isCommentOf_24(C,Ev), evaluate_24(Ev), rexist_24(Ev), hasResult_24(Ev,R), hasTheme_24(Epr,R), hasAgent_24(Epr,X), publish_24(Epr), permitted_24(Epr).

exceptionArt3b_24(Ep):- condition_4_24(Ep).

permitted_24(Ep):- condition_4_24(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 4. If the Licensee is commission_24ed to perform an independent evaluation of the Product,then the Licensee has the obligation to publish_24 the evaluation result_24s.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 4a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_5_24(Ep):- publish_24(Ep), hasAgent_24(Ep,X), licensee_24(X), hasTheme_24(Ep,R), result_24(R), hasResult_24(Ev,R), evaluate_24(Ev), rexist_24(Ev), hasTheme_24(Ec,Ev), commission_24(Ec), rexist_24(Ec).

exceptionArt4a_24(Ep):- condition_5_24(Ep).

obligatory_24(Ep):- condition_5_24(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPLIANCE CHECKING RULES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%(1) if there is some action x obligatory_24 at time t and, at the same time, x does not really exist => violation_24; 
%(2) if there is some action x prohibited_24 at time t and, at the same time, x really exists => violation_24
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rexist_24(ca(Ep,X,R)) :- remove_24(ca(Ep,X,R)), hasTheme_24(ca(Ep,X,R),R), hasAgent_24(ca(Ep,X,R),X), rexist_24(Er), remove_24(Er), hasTheme_24(Er,R),hasAgent_24(Er,X).

compensate_24d(X):- compensate_24(Y,X), rexist_24(Y).

violation_24(viol(X)) :- obligatory_24(X), not rexist_24(X), not compensate_24d(X).
violation_24(viol(X)) :- prohibited_24(X), rexist_24(X), not compensate_24d(X).

referTo_24(viol(X),X) :- violation_24(viol(X)).

%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 1. The Licensor grant_25s the Licensee a licence_25 to evaluate_25 the Product.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_25(Ev):- evaluate_25(Ev), hasAgent_25(Ev,X), licensee_25(X), hasTheme_25(Ev,P), product_25(P), not exceptionArt1b_25(Ev). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_1_25(Ev):- evaluate_25(Ev), hasAgent_25(Ev,X), licensee_25(X), hasTheme_25(Ev,P), product_25(P), isLicenceOf_25(L,P), licence_25(L), hasTheme_25(Eg,L), hasAgent_25(Eg,Y), licensor_25(Y), grant_25(Eg), rexist_25(Eg), hasReceiver_25(Eg,X).

exceptionArt1b_25(Ev):- condition_1_25(Ev).

permitted_25(Ev):- condition_1_25(Ev).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 2. The Licensee must not publish_25 the result_25s of the evaluation of the Product without the approval of the Licensor.
%           If the Licensee publish_25es result_25s of the evaluation of the Product without approval from the Licensor, 
%           the material must be remove_25d.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2a and Article 2c %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_2_25(Ep,X,R):- publish_25(Ep), hasAgent_25(Ep,X), licensee_25(X), hasTheme_25(Ep,R), result_25(R), hasResult_25(Ev,R), evaluate_25(Ev), rexist_25(Ev), not exceptionArt2b_25(Ep), not exceptionArt4a_25(Ep).

prohibited_25(Ep):- condition_2_25(Ep,X,R).

obligatory_25(ca(Ep,X,R)) :- rexist_25(Ep),condition_2_25(Ep,X,R).

remove_25(ca(Ep,X,R)) :- rexist_25(Ep),condition_2_25(Ep,X,R).

hasTheme_25(ca(Ep,X,R),R) :- rexist_25(Ep),condition_2_25(Ep,X,R).

hasAgent_25(ca(Ep,X,R),X) :- rexist_25(Ep),condition_2_25(Ep,X,R).

compensate_25(ca(Ep,X,R),Ep):- rexist_25(Ep),condition_2_25(Ep,X,R).
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_3_25(Ep):- publish_25(Ep), hasAgent_25(Ep,X), licensee_25(X), hasTheme_25(Ep,R), result_25(R), hasResult_25(Ev,R), evaluate_25(Ev), rexist_25(Ev), hasTheme_25(Ea,Ep), approve_25(Ea), rexist_25(Ea), hasAgent_25(Ea,Y), licensor_25(Y).

exceptionArt2b_25(Ep):- condition_3_25(Ep).

permitted_25(Ep):- condition_3_25(Ep).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 3. The Licensee must not publish_25 comment_25s on the evaluation of the Product,
%            unless the Licensee is permitted_25 to publish_25 the result_25s of the evaluation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_25(Ep):- publish_25(Ep), hasAgent_25(Ep,X), licensee_25(X), hasTheme_25(Ep,C), comment_25(C), isCommentOf_25(C,Ev), evaluate_25(Ev), rexist_25(Ev), not exceptionArt3b_25(Ep).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_4_25(Ep):- publish_25(Ep), hasAgent_25(Ep,X), licensee_25(X), hasTheme_25(Ep,C), comment_25(C), isCommentOf_25(C,Ev), evaluate_25(Ev), rexist_25(Ev), hasResult_25(Ev,R), hasTheme_25(Epr,R), hasAgent_25(Epr,X), publish_25(Epr), permitted_25(Epr).

exceptionArt3b_25(Ep):- condition_4_25(Ep).

permitted_25(Ep):- condition_4_25(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 4. If the Licensee is commission_25ed to perform an independent evaluation of the Product,then the Licensee has the obligation to publish_25 the evaluation result_25s.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 4a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_5_25(Ep):- publish_25(Ep), hasAgent_25(Ep,X), licensee_25(X), hasTheme_25(Ep,R), result_25(R), hasResult_25(Ev,R), evaluate_25(Ev), rexist_25(Ev), hasTheme_25(Ec,Ev), commission_25(Ec), rexist_25(Ec).

exceptionArt4a_25(Ep):- condition_5_25(Ep).

obligatory_25(Ep):- condition_5_25(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPLIANCE CHECKING RULES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%(1) if there is some action x obligatory_25 at time t and, at the same time, x does not really exist => violation_25; 
%(2) if there is some action x prohibited_25 at time t and, at the same time, x really exists => violation_25
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rexist_25(ca(Ep,X,R)) :- remove_25(ca(Ep,X,R)), hasTheme_25(ca(Ep,X,R),R), hasAgent_25(ca(Ep,X,R),X), rexist_25(Er), remove_25(Er), hasTheme_25(Er,R),hasAgent_25(Er,X).

compensate_25d(X):- compensate_25(Y,X), rexist_25(Y).

violation_25(viol(X)) :- obligatory_25(X), not rexist_25(X), not compensate_25d(X).
violation_25(viol(X)) :- prohibited_25(X), rexist_25(X), not compensate_25d(X).

referTo_25(viol(X),X) :- violation_25(viol(X)).

%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 1. The Licensor grant_26s the Licensee a licence_26 to evaluate_26 the Product.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_26(Ev):- evaluate_26(Ev), hasAgent_26(Ev,X), licensee_26(X), hasTheme_26(Ev,P), product_26(P), not exceptionArt1b_26(Ev). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_1_26(Ev):- evaluate_26(Ev), hasAgent_26(Ev,X), licensee_26(X), hasTheme_26(Ev,P), product_26(P), isLicenceOf_26(L,P), licence_26(L), hasTheme_26(Eg,L), hasAgent_26(Eg,Y), licensor_26(Y), grant_26(Eg), rexist_26(Eg), hasReceiver_26(Eg,X).

exceptionArt1b_26(Ev):- condition_1_26(Ev).

permitted_26(Ev):- condition_1_26(Ev).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 2. The Licensee must not publish_26 the result_26s of the evaluation of the Product without the approval of the Licensor.
%           If the Licensee publish_26es result_26s of the evaluation of the Product without approval from the Licensor, 
%           the material must be remove_26d.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2a and Article 2c %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_2_26(Ep,X,R):- publish_26(Ep), hasAgent_26(Ep,X), licensee_26(X), hasTheme_26(Ep,R), result_26(R), hasResult_26(Ev,R), evaluate_26(Ev), rexist_26(Ev), not exceptionArt2b_26(Ep), not exceptionArt4a_26(Ep).

prohibited_26(Ep):- condition_2_26(Ep,X,R).

obligatory_26(ca(Ep,X,R)) :- rexist_26(Ep),condition_2_26(Ep,X,R).

remove_26(ca(Ep,X,R)) :- rexist_26(Ep),condition_2_26(Ep,X,R).

hasTheme_26(ca(Ep,X,R),R) :- rexist_26(Ep),condition_2_26(Ep,X,R).

hasAgent_26(ca(Ep,X,R),X) :- rexist_26(Ep),condition_2_26(Ep,X,R).

compensate_26(ca(Ep,X,R),Ep):- rexist_26(Ep),condition_2_26(Ep,X,R).
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_3_26(Ep):- publish_26(Ep), hasAgent_26(Ep,X), licensee_26(X), hasTheme_26(Ep,R), result_26(R), hasResult_26(Ev,R), evaluate_26(Ev), rexist_26(Ev), hasTheme_26(Ea,Ep), approve_26(Ea), rexist_26(Ea), hasAgent_26(Ea,Y), licensor_26(Y).

exceptionArt2b_26(Ep):- condition_3_26(Ep).

permitted_26(Ep):- condition_3_26(Ep).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 3. The Licensee must not publish_26 comment_26s on the evaluation of the Product,
%            unless the Licensee is permitted_26 to publish_26 the result_26s of the evaluation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_26(Ep):- publish_26(Ep), hasAgent_26(Ep,X), licensee_26(X), hasTheme_26(Ep,C), comment_26(C), isCommentOf_26(C,Ev), evaluate_26(Ev), rexist_26(Ev), not exceptionArt3b_26(Ep).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_4_26(Ep):- publish_26(Ep), hasAgent_26(Ep,X), licensee_26(X), hasTheme_26(Ep,C), comment_26(C), isCommentOf_26(C,Ev), evaluate_26(Ev), rexist_26(Ev), hasResult_26(Ev,R), hasTheme_26(Epr,R), hasAgent_26(Epr,X), publish_26(Epr), permitted_26(Epr).

exceptionArt3b_26(Ep):- condition_4_26(Ep).

permitted_26(Ep):- condition_4_26(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 4. If the Licensee is commission_26ed to perform an independent evaluation of the Product,then the Licensee has the obligation to publish_26 the evaluation result_26s.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 4a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_5_26(Ep):- publish_26(Ep), hasAgent_26(Ep,X), licensee_26(X), hasTheme_26(Ep,R), result_26(R), hasResult_26(Ev,R), evaluate_26(Ev), rexist_26(Ev), hasTheme_26(Ec,Ev), commission_26(Ec), rexist_26(Ec).

exceptionArt4a_26(Ep):- condition_5_26(Ep).

obligatory_26(Ep):- condition_5_26(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPLIANCE CHECKING RULES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%(1) if there is some action x obligatory_26 at time t and, at the same time, x does not really exist => violation_26; 
%(2) if there is some action x prohibited_26 at time t and, at the same time, x really exists => violation_26
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rexist_26(ca(Ep,X,R)) :- remove_26(ca(Ep,X,R)), hasTheme_26(ca(Ep,X,R),R), hasAgent_26(ca(Ep,X,R),X), rexist_26(Er), remove_26(Er), hasTheme_26(Er,R),hasAgent_26(Er,X).

compensate_26d(X):- compensate_26(Y,X), rexist_26(Y).

violation_26(viol(X)) :- obligatory_26(X), not rexist_26(X), not compensate_26d(X).
violation_26(viol(X)) :- prohibited_26(X), rexist_26(X), not compensate_26d(X).

referTo_26(viol(X),X) :- violation_26(viol(X)).

%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 1. The Licensor grant_27s the Licensee a licence_27 to evaluate_27 the Product.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_27(Ev):- evaluate_27(Ev), hasAgent_27(Ev,X), licensee_27(X), hasTheme_27(Ev,P), product_27(P), not exceptionArt1b_27(Ev). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_1_27(Ev):- evaluate_27(Ev), hasAgent_27(Ev,X), licensee_27(X), hasTheme_27(Ev,P), product_27(P), isLicenceOf_27(L,P), licence_27(L), hasTheme_27(Eg,L), hasAgent_27(Eg,Y), licensor_27(Y), grant_27(Eg), rexist_27(Eg), hasReceiver_27(Eg,X).

exceptionArt1b_27(Ev):- condition_1_27(Ev).

permitted_27(Ev):- condition_1_27(Ev).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 2. The Licensee must not publish_27 the result_27s of the evaluation of the Product without the approval of the Licensor.
%           If the Licensee publish_27es result_27s of the evaluation of the Product without approval from the Licensor, 
%           the material must be remove_27d.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2a and Article 2c %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_2_27(Ep,X,R):- publish_27(Ep), hasAgent_27(Ep,X), licensee_27(X), hasTheme_27(Ep,R), result_27(R), hasResult_27(Ev,R), evaluate_27(Ev), rexist_27(Ev), not exceptionArt2b_27(Ep), not exceptionArt4a_27(Ep).

prohibited_27(Ep):- condition_2_27(Ep,X,R).

obligatory_27(ca(Ep,X,R)) :- rexist_27(Ep),condition_2_27(Ep,X,R).

remove_27(ca(Ep,X,R)) :- rexist_27(Ep),condition_2_27(Ep,X,R).

hasTheme_27(ca(Ep,X,R),R) :- rexist_27(Ep),condition_2_27(Ep,X,R).

hasAgent_27(ca(Ep,X,R),X) :- rexist_27(Ep),condition_2_27(Ep,X,R).

compensate_27(ca(Ep,X,R),Ep):- rexist_27(Ep),condition_2_27(Ep,X,R).
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_3_27(Ep):- publish_27(Ep), hasAgent_27(Ep,X), licensee_27(X), hasTheme_27(Ep,R), result_27(R), hasResult_27(Ev,R), evaluate_27(Ev), rexist_27(Ev), hasTheme_27(Ea,Ep), approve_27(Ea), rexist_27(Ea), hasAgent_27(Ea,Y), licensor_27(Y).

exceptionArt2b_27(Ep):- condition_3_27(Ep).

permitted_27(Ep):- condition_3_27(Ep).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 3. The Licensee must not publish_27 comment_27s on the evaluation of the Product,
%            unless the Licensee is permitted_27 to publish_27 the result_27s of the evaluation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_27(Ep):- publish_27(Ep), hasAgent_27(Ep,X), licensee_27(X), hasTheme_27(Ep,C), comment_27(C), isCommentOf_27(C,Ev), evaluate_27(Ev), rexist_27(Ev), not exceptionArt3b_27(Ep).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_4_27(Ep):- publish_27(Ep), hasAgent_27(Ep,X), licensee_27(X), hasTheme_27(Ep,C), comment_27(C), isCommentOf_27(C,Ev), evaluate_27(Ev), rexist_27(Ev), hasResult_27(Ev,R), hasTheme_27(Epr,R), hasAgent_27(Epr,X), publish_27(Epr), permitted_27(Epr).

exceptionArt3b_27(Ep):- condition_4_27(Ep).

permitted_27(Ep):- condition_4_27(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 4. If the Licensee is commission_27ed to perform an independent evaluation of the Product,then the Licensee has the obligation to publish_27 the evaluation result_27s.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 4a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_5_27(Ep):- publish_27(Ep), hasAgent_27(Ep,X), licensee_27(X), hasTheme_27(Ep,R), result_27(R), hasResult_27(Ev,R), evaluate_27(Ev), rexist_27(Ev), hasTheme_27(Ec,Ev), commission_27(Ec), rexist_27(Ec).

exceptionArt4a_27(Ep):- condition_5_27(Ep).

obligatory_27(Ep):- condition_5_27(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPLIANCE CHECKING RULES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%(1) if there is some action x obligatory_27 at time t and, at the same time, x does not really exist => violation_27; 
%(2) if there is some action x prohibited_27 at time t and, at the same time, x really exists => violation_27
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rexist_27(ca(Ep,X,R)) :- remove_27(ca(Ep,X,R)), hasTheme_27(ca(Ep,X,R),R), hasAgent_27(ca(Ep,X,R),X), rexist_27(Er), remove_27(Er), hasTheme_27(Er,R),hasAgent_27(Er,X).

compensate_27d(X):- compensate_27(Y,X), rexist_27(Y).

violation_27(viol(X)) :- obligatory_27(X), not rexist_27(X), not compensate_27d(X).
violation_27(viol(X)) :- prohibited_27(X), rexist_27(X), not compensate_27d(X).

referTo_27(viol(X),X) :- violation_27(viol(X)).

%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 1. The Licensor grant_28s the Licensee a licence_28 to evaluate_28 the Product.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_28(Ev):- evaluate_28(Ev), hasAgent_28(Ev,X), licensee_28(X), hasTheme_28(Ev,P), product_28(P), not exceptionArt1b_28(Ev). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_1_28(Ev):- evaluate_28(Ev), hasAgent_28(Ev,X), licensee_28(X), hasTheme_28(Ev,P), product_28(P), isLicenceOf_28(L,P), licence_28(L), hasTheme_28(Eg,L), hasAgent_28(Eg,Y), licensor_28(Y), grant_28(Eg), rexist_28(Eg), hasReceiver_28(Eg,X).

exceptionArt1b_28(Ev):- condition_1_28(Ev).

permitted_28(Ev):- condition_1_28(Ev).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 2. The Licensee must not publish_28 the result_28s of the evaluation of the Product without the approval of the Licensor.
%           If the Licensee publish_28es result_28s of the evaluation of the Product without approval from the Licensor, 
%           the material must be remove_28d.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2a and Article 2c %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_2_28(Ep,X,R):- publish_28(Ep), hasAgent_28(Ep,X), licensee_28(X), hasTheme_28(Ep,R), result_28(R), hasResult_28(Ev,R), evaluate_28(Ev), rexist_28(Ev), not exceptionArt2b_28(Ep), not exceptionArt4a_28(Ep).

prohibited_28(Ep):- condition_2_28(Ep,X,R).

obligatory_28(ca(Ep,X,R)) :- rexist_28(Ep),condition_2_28(Ep,X,R).

remove_28(ca(Ep,X,R)) :- rexist_28(Ep),condition_2_28(Ep,X,R).

hasTheme_28(ca(Ep,X,R),R) :- rexist_28(Ep),condition_2_28(Ep,X,R).

hasAgent_28(ca(Ep,X,R),X) :- rexist_28(Ep),condition_2_28(Ep,X,R).

compensate_28(ca(Ep,X,R),Ep):- rexist_28(Ep),condition_2_28(Ep,X,R).
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_3_28(Ep):- publish_28(Ep), hasAgent_28(Ep,X), licensee_28(X), hasTheme_28(Ep,R), result_28(R), hasResult_28(Ev,R), evaluate_28(Ev), rexist_28(Ev), hasTheme_28(Ea,Ep), approve_28(Ea), rexist_28(Ea), hasAgent_28(Ea,Y), licensor_28(Y).

exceptionArt2b_28(Ep):- condition_3_28(Ep).

permitted_28(Ep):- condition_3_28(Ep).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 3. The Licensee must not publish_28 comment_28s on the evaluation of the Product,
%            unless the Licensee is permitted_28 to publish_28 the result_28s of the evaluation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_28(Ep):- publish_28(Ep), hasAgent_28(Ep,X), licensee_28(X), hasTheme_28(Ep,C), comment_28(C), isCommentOf_28(C,Ev), evaluate_28(Ev), rexist_28(Ev), not exceptionArt3b_28(Ep).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_4_28(Ep):- publish_28(Ep), hasAgent_28(Ep,X), licensee_28(X), hasTheme_28(Ep,C), comment_28(C), isCommentOf_28(C,Ev), evaluate_28(Ev), rexist_28(Ev), hasResult_28(Ev,R), hasTheme_28(Epr,R), hasAgent_28(Epr,X), publish_28(Epr), permitted_28(Epr).

exceptionArt3b_28(Ep):- condition_4_28(Ep).

permitted_28(Ep):- condition_4_28(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 4. If the Licensee is commission_28ed to perform an independent evaluation of the Product,then the Licensee has the obligation to publish_28 the evaluation result_28s.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 4a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_5_28(Ep):- publish_28(Ep), hasAgent_28(Ep,X), licensee_28(X), hasTheme_28(Ep,R), result_28(R), hasResult_28(Ev,R), evaluate_28(Ev), rexist_28(Ev), hasTheme_28(Ec,Ev), commission_28(Ec), rexist_28(Ec).

exceptionArt4a_28(Ep):- condition_5_28(Ep).

obligatory_28(Ep):- condition_5_28(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPLIANCE CHECKING RULES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%(1) if there is some action x obligatory_28 at time t and, at the same time, x does not really exist => violation_28; 
%(2) if there is some action x prohibited_28 at time t and, at the same time, x really exists => violation_28
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rexist_28(ca(Ep,X,R)) :- remove_28(ca(Ep,X,R)), hasTheme_28(ca(Ep,X,R),R), hasAgent_28(ca(Ep,X,R),X), rexist_28(Er), remove_28(Er), hasTheme_28(Er,R),hasAgent_28(Er,X).

compensate_28d(X):- compensate_28(Y,X), rexist_28(Y).

violation_28(viol(X)) :- obligatory_28(X), not rexist_28(X), not compensate_28d(X).
violation_28(viol(X)) :- prohibited_28(X), rexist_28(X), not compensate_28d(X).

referTo_28(viol(X),X) :- violation_28(viol(X)).

%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 1. The Licensor grant_29s the Licensee a licence_29 to evaluate_29 the Product.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_29(Ev):- evaluate_29(Ev), hasAgent_29(Ev,X), licensee_29(X), hasTheme_29(Ev,P), product_29(P), not exceptionArt1b_29(Ev). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 1b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_1_29(Ev):- evaluate_29(Ev), hasAgent_29(Ev,X), licensee_29(X), hasTheme_29(Ev,P), product_29(P), isLicenceOf_29(L,P), licence_29(L), hasTheme_29(Eg,L), hasAgent_29(Eg,Y), licensor_29(Y), grant_29(Eg), rexist_29(Eg), hasReceiver_29(Eg,X).

exceptionArt1b_29(Ev):- condition_1_29(Ev).

permitted_29(Ev):- condition_1_29(Ev).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 2. The Licensee must not publish_29 the result_29s of the evaluation of the Product without the approval of the Licensor.
%           If the Licensee publish_29es result_29s of the evaluation of the Product without approval from the Licensor, 
%           the material must be remove_29d.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2a and Article 2c %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_2_29(Ep,X,R):- publish_29(Ep), hasAgent_29(Ep,X), licensee_29(X), hasTheme_29(Ep,R), result_29(R), hasResult_29(Ev,R), evaluate_29(Ev), rexist_29(Ev), not exceptionArt2b_29(Ep), not exceptionArt4a_29(Ep).

prohibited_29(Ep):- condition_2_29(Ep,X,R).

obligatory_29(ca(Ep,X,R)) :- rexist_29(Ep),condition_2_29(Ep,X,R).

remove_29(ca(Ep,X,R)) :- rexist_29(Ep),condition_2_29(Ep,X,R).

hasTheme_29(ca(Ep,X,R),R) :- rexist_29(Ep),condition_2_29(Ep,X,R).

hasAgent_29(ca(Ep,X,R),X) :- rexist_29(Ep),condition_2_29(Ep,X,R).

compensate_29(ca(Ep,X,R),Ep):- rexist_29(Ep),condition_2_29(Ep,X,R).
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 2b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_3_29(Ep):- publish_29(Ep), hasAgent_29(Ep,X), licensee_29(X), hasTheme_29(Ep,R), result_29(R), hasResult_29(Ev,R), evaluate_29(Ev), rexist_29(Ev), hasTheme_29(Ea,Ep), approve_29(Ea), rexist_29(Ea), hasAgent_29(Ea,Y), licensor_29(Y).

exceptionArt2b_29(Ep):- condition_3_29(Ep).

permitted_29(Ep):- condition_3_29(Ep).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Article 3. The Licensee must not publish_29 comment_29s on the evaluation of the Product,
%            unless the Licensee is permitted_29 to publish_29 the result_29s of the evaluation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

prohibited_29(Ep):- publish_29(Ep), hasAgent_29(Ep,X), licensee_29(X), hasTheme_29(Ep,C), comment_29(C), isCommentOf_29(C,Ev), evaluate_29(Ev), rexist_29(Ev), not exceptionArt3b_29(Ep).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 3b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_4_29(Ep):- publish_29(Ep), hasAgent_29(Ep,X), licensee_29(X), hasTheme_29(Ep,C), comment_29(C), isCommentOf_29(C,Ev), evaluate_29(Ev), rexist_29(Ev), hasResult_29(Ev,R), hasTheme_29(Epr,R), hasAgent_29(Epr,X), publish_29(Epr), permitted_29(Epr).

exceptionArt3b_29(Ep):- condition_4_29(Ep).

permitted_29(Ep):- condition_4_29(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Article 4. If the Licensee is commission_29ed to perform an independent evaluation of the Product,then the Licensee has the obligation to publish_29 the evaluation result_29s.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% rule Article 4a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

condition_5_29(Ep):- publish_29(Ep), hasAgent_29(Ep,X), licensee_29(X), hasTheme_29(Ep,R), result_29(R), hasResult_29(Ev,R), evaluate_29(Ev), rexist_29(Ev), hasTheme_29(Ec,Ev), commission_29(Ec), rexist_29(Ec).

exceptionArt4a_29(Ep):- condition_5_29(Ep).

obligatory_29(Ep):- condition_5_29(Ep).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPLIANCE CHECKING RULES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%(1) if there is some action x obligatory_29 at time t and, at the same time, x does not really exist => violation_29; 
%(2) if there is some action x prohibited_29 at time t and, at the same time, x really exists => violation_29
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rexist_29(ca(Ep,X,R)) :- remove_29(ca(Ep,X,R)), hasTheme_29(ca(Ep,X,R),R), hasAgent_29(ca(Ep,X,R),X), rexist_29(Er), remove_29(Er), hasTheme_29(Er,R),hasAgent_29(Er,X).

compensate_29d(X):- compensate_29(Y,X), rexist_29(Y).

violation_29(viol(X)) :- obligatory_29(X), not rexist_29(X), not compensate_29d(X).
violation_29(viol(X)) :- prohibited_29(X), rexist_29(X), not compensate_29d(X).

referTo_29(viol(X),X) :- violation_29(viol(X)).

%%%%%%%%%%%%

test(livio).

#include "asp30_50.asp".

