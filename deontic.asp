#include "language.asp".

permission(X) :- obligation(X).
permission(X) :- opposes(X,X1), not obligation(X1).

% deonticRule(R,X) :- 1 {prescriptiveRule(R,X); permissiveRule(R,X)}.

deonticRule(R,X) :- prescriptiveRule(R,X).
deonticRule(R,X) :- permissiveRule(R,X).

obligation(X) :- prescriptiveRule(R,X), 
    applicable(R), not deonticOverruled(R,X).

obligation(X) :- constitutiveRule(R,X), 
    obligationApplicable(R), not deonticOverruled(R,X).

permission(X) :- permissiveRule(R,X), 
    applicable(R), not deonticOverruled(R,X).

permission(X) :- constitutiveRule(R,X), 
    permissionApplicable(R), not deonticOverruled(R,X).

deonticOverruled(R,X) :- prescriptiveRule(R,X), 
    deonticRule(R1,X1), opposes(X,X1),  applicable(R1),
    not deonticDefeated(R1,X1).

deonticOverruled(R,X) :- permissiveRule(R,X), 
    prescriptiveRule(R1,X1), opposes(X,X1), applicable(R1),
    not deonticDefeated(R1,X1).
 
deonticDefeated(R,X) :- opposes(X,X1),
    prescriptiveRule(R,X), deonticRule(R1,X1), 
    applicable(R1), superior(R1,R).

deonticDefeated(R,X) :- opposes(X,X1),
    permissiveRule(R,X), prescriptiveRule(R1,X1), 
    applicable(R1), superior(R1,R).

%% conversions not used in overruled and  defeated TODO

% obligationApplicable(R,X) :- constitutiveRule(R,X,C,O,P),
%     obligation(C), O = (), P = ().     

% permissionApplicable(R,X) :- constitutiveRule(R,X,C,O,P),
%     permission(C),O =(), P = ().

% an L4 rule
%
% RULE <r> 
% PRE  
%   <a_1> AND ... AND <a_n> AND
%   MUST <o_1> AND 
%        ... AND
%   MUST <o_m> AND
%   MAY <p_1> AND
%       ... AND
%   MAY <p_k> AND
% POST
%  [MUST | MAY] c
% RESTICT subject_to|desite <s>
%  
% is encoded as 
%
% prescriptiveRule(r,c). % if POST contains MUST  
% permissiveRule(r,c).   % if POST contains MAY
%
% applicable(r) :- 
%     defeasible(a_1), ... , defeasible(a_n), % for each a_i not in the scope of MUST|MAY 
%     obligation(o_1), ... , obligation(o_m), % for each o_i in the scope of MUST
%     permission(p_1), ...., permission(p_k). % for each p_i in the scope of MAY
%
% % is POST does not contain MUST|MAY then we have a constitutive rule
%
% % SHANT is an alias for MUST not, and SHANT a_i is encoded as obligation(non(a_i)).
% constitutiveRule(r,c).
%
% % and in addition to the clause for `applicable` we add
%
% obligationApplicable(r) :- obligation(a_1), ... , obligation(a_n). 
% permissionApplicable(r) :- permission(a_1), ... , permission(a_n).
%
% % provided that {a_i, ..., a_N} is not empty. 
%
% superior(r,s). % if restrict despite 
% inferior(r,s). % if restrict subject_to