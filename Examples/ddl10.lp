#include "license-caseId.lp".

1{
caseId(c_0_0);
caseId(c_0_1);
caseId(c_0_2);
caseId(c_0_3);
caseId(c_0_4);
caseId(c_0_5);
caseId(c_0_6);
caseId(c_0_7);
caseId(c_0_8);
caseId(c_0_9)
} 1.

fact(authorise(c_0_0);
       license(c_0_0);
       publish(c_0_0);
       remove(c_0_0)):- caseId(c_0_0).

fact(evaluate(c_0_1);
    license(c_0_1);
    publish(c_0_1)):- caseId(c_0_1).

fact(commission(c_0_2);
    evaluate(c_0_2);
    license(c_0_2);
    publish(c_0_2);
    remove(c_0_2)):- caseId(c_0_2).

fact(commission(c_0_3);
  license(c_0_3); 
  publish(c_0_3)) :- caseId(c_0_3).

fact(commission(c_0_4)):-caseId(c_0_4).
fact(license(c_0_4)):-caseId(c_0_4).
fact(comment(c_0_4)):-caseId(c_0_4).
fact(remove(c_0_4)):-caseId(c_0_4).

fact(authorise(c_0_5)):-caseId(c_0_5).
fact(comment(c_0_5)):-caseId(c_0_5).

fact(authorise(c_0_6)):-caseId(c_0_6).
fact(commission(c_0_6)):-caseId(c_0_6).
fact(evaluate(c_0_6)):-caseId(c_0_6).
fact(remove(c_0_6)):-caseId(c_0_6).

fact(authorise(c_0_7)):-caseId(c_0_7).
fact(publish(c_0_7)):-caseId(c_0_7).
fact(remove(c_0_7)):-caseId(c_0_7).

fact(commission(c_0_8)):-caseId(c_0_8).
fact(remove(c_0_8)):-caseId(c_0_8).

fact(authorise(c_0_9);
  commission(c_0_9);
  license(c_0_9);
  comment(c_0_9)):-caseId(c_0_9).

% #show caseId/1.
% #show terminalViolation/1.
% #show defeasible/1.
#show .