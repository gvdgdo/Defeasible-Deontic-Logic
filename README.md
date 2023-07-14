# Implementation of Defeasible Deontic Logic in ASP (clingo).

This is the first working version of an ASP implementation of Defeasible Deontic Logic. The implementation covers Obligations, Permisions, and Compensatory Obligations.  Currently, the language is restricted to defeasible rules (constitutive, prescriptive and permissive). 

A rule 

    label: a_1, ... , a_n, OBL(o_1), ... OBL(o_m), PERM(p_1), ... PERM(p_k) =>X head

is represented by the clauses

    <type>Rule(label, head).
    applicable(label, head) :-
        defeasible(a_1; ... ; a_n),
        obligation(o_1; ... ; o_m),
        permission(p_1; ... ; p_k).

where `<type>`  is a placeholder for `constitutive`, `prescriptive` or `permissive` according to the value of `X`. 

For a prescriptive rule if `head` is not a single element, i.e., 

    head =  c_1, c_2, ..., c_w

The `head` is represented by a set of clauses

    compensate(label, c_n, c_n+1, n).

For `constitutiveRule`, it is possible to add

    convertObligation(label, head) :-
        obligatoin(a_1; ... ; a_n).
    convertPermission(label, head) :-
        permission(a_1; ... ; a_n).

provided `{a_1, ..., a_n}` is not empty and there are no obligations or permissions in the antecedent of the rule. 

Instances of the superiority relation are caputured by 

    superior(r,s). 
    inferior(r,s). 

All the atomic propositions appearing in a theory must be declared by 

    atom(atomic_proposition).

