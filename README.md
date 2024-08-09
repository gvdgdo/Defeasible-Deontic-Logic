# Implementation of Defeasible Logic and Defeasible Deontic Logic in ASP (clingo).

The code provides an implementation of Defeasible Logic and Defeasible Deontic Logic in Answer Set Programming, specifically, CLINGO. 

## Defeasible Logic

The implementation support the full version of Defeasible Logic, including strict rules, defeasible rules and defeaters, and implements both the ambiguity blocking and ambiguity propagating variants of the logic. 

It supports the computation of positive (and negative) definite and defeasible extensions of a defeasible theory. A defeasible theory is a triple `<Facts, Rules, Superiority>` where `Facts` is a set of atomic propositions regarded as true, `Rules` is a set of rules, divided in _strict rules_, _defeasible rules_ and_defeaters_, and the `Superiority` relation is a binary relation over the set of rules, describing the relative strength of pairs of rules. 

The computation of the extension is limited to the (ground) propositions declared as atomic_proposition

    atom(proposition).
    atom(predicate(constant_1, ..., constant_n)).

A fact is a (grounded) atom, and are declared by 

    fact(ground_atom).

A strict rule: 

    label: a_1, ..., a_n -> head

is represented by the clauses

    strictRule(label, head).
    definiteApplicable(label, head).

A defeasible rule: 

    label: a_1, ..., a_n => head

is represented by the clauses

    defeasibleRule(label, head).
    applicable(label, head).

A defeater: 

    label: a_1, ..., a_n ~> head

is represented by the clauses

    defeater(label, head).
    applicable(label, head).


## Defeasible Deontic Logic

This ASP implementation of Defeasible Deontic Logic covers Obligations, Permissions, and Compensatory Obligations.  Currently, the language is restricted to defeasible rules (constitutive, prescriptive and permissive). 

A rule 

    label: a_1, ... , a_n, OBL(o_1), ... OBL(o_m), PERM(p_1), ... PERM(p_k) =>X head

is represented by the clauses

    <type>Rule(label, head).
    applicable(label, head) :-
        defeasible(a_1), ...  defeasible(a_n),
        obligation(o_1), ...  obligation(o_m),
        permission(p_1), ...  permission(p_k).

where `<type>` is a placeholder for `constitutive`, `prescriptive` or `permissive` according to the value of `X`. 

For a prescriptive rule if `head` is not a single element, i.e., 

    head =  c_1, c_2, ..., c_w

The `head` is represented by a set of clauses

    compensate(label, c_n, c_n+1, n).

For `constitutiveRule`, it is possible to add

    convertObligation(label, head) :-
        obligation(a_1), ... obligation(a_n).
    convertPermission(label, head) :-
        permission(a_1), ... permission(a_n).

provided `{a_1, ..., a_n}` is not empty and there are no obligations or permissions in the antecedent of the rule. 

Instances of the superiority relation are captured by 

    superior(r,s). 
    inferior(r,s). 

All the atomic propositions appearing in a theory must be declared by 

    atom(atomic_proposition).

