# Copyright (c) 2022-2025 Guido Governatori 

# write a parser for defeasible deontic logic (DDL) in python. Each rule in 
# DDL  has the format:
# rule : antecedent => consequent
# where the antecedent is a sets of literals. 
# a literal has the form
# ~atom or atom or [O]atom or [P]atom or [O]~atom or [P]~atom or ~[O]atom 
# or ~[P]atom or ~[O]~atom or ~[P]~atom
# literals are transformed according to the following rules:
# atom = atom(atom).
# ~atom = non(atom).
# [O]atom = obl(atom).
# [P]atom = per(atom).
# [O]~atom = obl(non(atom)).
# [P]~atom = per(non(atom)).
# ~[O]atom = non(obl(atom)).
# ~[P]atom = non(per(atom)).
# ~[O]~atom = non(obl(non(atom))).
# ~[P]~atom = non(per(non(atom))).

# The consequent is either a literal or a list of literals
# if the first literal in the consequent is deontic literal, then the rule is 
# a prescriptive rule if the deontic literal is an obligation, and 
# permissive rule if it is a permission.
# if the first literal in the consequent is not a deontic literal, then the     # rule is a constitutive rule.
# when the consequent of a prescriptive rule contains more than one element 
# strips the deontic modality and output a string 
# "compensate(name,element1,element2,1)" where element1 and element2 are 
# consecutive elements in the consequent. Do this for all the pair of 
# consecutive elements in the consequent of the rule

# the parser should be able to parse the following rules:

# r: a , b => c
# r1: [O]a, c => [O]b
# rule3: [P]a, ~d, ~[O]e => [P]~b
# rule_name: ~[O]~g => c
# s : => c
# s2: pippo -> pluto
# comp2: x => [O]y, [O]z, [O]~w             

# and produce the following output:

# constitutiveRule(r,c).
# body(r,(a;b)).
# prescriptiveRule(r1,b).
# body(r1,(obl(a);c)).
# permissiveRule(rule3,non(b)).
# body(rule3,(per(a);non(d),non(obl(e)))).
# constitutiveRule(rule_name,c).
# body(rule_name,non(obl(non(g))).

#if the antecedent of a rule is empty, the clause with body should not be
# generated, and no atom should be generated for the antecedent.

#if there is a single element in the antecedent, the body clause should not
# have a semicolon and should not be enclosed in parentheses.

# in addition the parse should create a list of atoms that appear in the rules
# where each atom is represented as atom(atom).

# finally the parser should be able to parse instance of the superiority 
# relation represented as

# r1 > r2

# where r1 and r2 are rules. the instance 
# superior(r1,r2).

# the parser should be able to parse the set of facts. where a fact is an atom 
# or a negated atom (~atom).
# facts are transformed into rules of the form:
# fact(atom). or fact(neg(atom)).
# the parser should check for comments, which are lines starting with # and
# ignore them. Same thing for empty lines.
# Moreover the parse should examine first for rule and the superiority relation
# and then for facts.

import re

class DLParser:
    def __init__(self, sep=','):
        self.rules = []
        self.superiorities = []
        self.facts = []
        self.atoms = set()
        self.sep = sep  # separator for atoms in input rules

    def parse(self, text):
        lines = text.split('\n')
        for line in lines:
            line = line.strip()
            if not line or line.startswith('#'):
                continue
            if '->' in line or '=>' in line or '~>' in line:
                self.parse_rule(line)
            elif '>' in line or '<' in line:
                self.parse_superiority(line)
            elif ';' in line:
                self.parse_facts(line)
            else:
                self.parse_fact(line)

    def parse_rule(self, line):
        name, rule = line.split(':')
        name = name.strip()
        if '->' in line:
            antecedent, consequent = rule.split('->')
            rule_type = 'strictRule'
        elif '=>' in line:
            antecedent, consequent = rule.split('=>')
            rule_type = 'defeasibleRule'
        else:
            antecedent, consequent = rule.split('~>')
            rule_type = 'defeater'
        antecedent = antecedent.strip()
        consequent = consequent.strip()
        antecedent_literals = [self.transform_literal(lit.strip()) for lit in antecedent.split(self.sep) if lit.strip()]
        consequent_literal = self.transform_literal(consequent)
        self.rules.append(f'{rule_type}({name},{consequent_literal}).')
        if antecedent_literals:
            if len(antecedent_literals) == 1:
                self.rules.append(f'body({name},{antecedent_literals[0]}).')
            else:
                self.rules.append(f'body({name},({";".join(antecedent_literals)})).')

    def parse_superiority(self, line):
        if '>' in line:
            r1, r2 = line.split('>')
        else:
            r2, r1 = line.split('<')
        r1 = r1.strip()
        r2 = r2.strip()
        self.superiorities.append(f'superior({r1},{r2}).')

    def parse_facts(self, line):
        facts = [self.transform_literal(lit.strip()) for lit in line.split(self.sep) if lit.strip()]
        fact_content = ';'.join(facts)
        self.facts.append(f'{{ fact({fact_content}) }}.')

    def parse_fact(self, line):
        literal = self.transform_literal(line)
        self.facts.append(f'fact({literal}).')

    def transform_literal(self, literal):
        if literal.startswith('~'):
            return f'non({self.transform_literal(literal[1:])})'
        else:
            self.atoms.add(f'atom({literal}).')
            return literal

    def get_output(self):
        return '\n'.join(self.rules + self.superiorities + self.facts + list(self.atoms))

class DDLParser(DLParser):
    def __init__(self, sep=','):
        DLParser.__init__(self)
        self.compensations = []
        self.sep = sep

    def parse(self, text):
        lines = text.split('\n')
        for line in lines:
            line = line.strip()
            if not line or line.startswith('#') or '->' in line:
                continue
            if '=>' in line:
                self.parse_rule(line)
            elif '>' in line or '<' in line:
                self.parse_superiority(line)
            elif ';' in line:
                self.parse_facts(line)
            else:
                self.parse_fact(line)

    def parse_rule(self, line):
        name, rule = line.split(':')
        name = name.strip()
        antecedent, consequent = rule.split('=>')
        antecedent = antecedent.strip()
        consequent = consequent.strip()
        antecedent_literals = [self.transform_literal(lit.strip()) for lit in antecedent.split(self.sep) if lit.strip()]
        consequent_literals = [lit.strip() for lit in consequent.split(self.sep) if lit.strip()]
        consequent_literal = self.transform_literal(consequent_literals[0])
        if consequent_literal.startswith('obl('):
            rule_type = 'prescriptiveRule'
            if len(consequent_literals) > 1:
                for i in range(len(consequent_literals) - 1):
                    elem1 = self.transform_literal(consequent_literals[i][3:])
                    elem2 = self.transform_literal(consequent_literals[i + 1][3:])
                    self.compensations.append(f'compensate({name},{elem1},{elem2},{i+1}).')
        elif consequent_literal.startswith('per('):
            rule_type = 'permissiveRule'
        else:
            rule_type = 'constitutiveRule'
        if rule_type == 'constitutiveRule':
            self.rules.append(f'constitutiveRule({name},{consequent_literal}).')
        else:
            self.rules.append(f'{rule_type}({name},{consequent_literal[4:-1]}).')
        if antecedent_literals:
            if len(antecedent_literals) == 1:
                self.rules.append(f'body({name},{antecedent_literals[0]}).')
            else:
                self.rules.append(f'body({name},({";".join(antecedent_literals)})).')

    def transform_literal(self, literal):
        if literal.startswith('~[O]'):
            return f'non(obl({self.transform_literal(literal[4:])}))'
        elif literal.startswith('~[P]'):
            return f'non(per({self.transform_literal(literal[4:])}))'
        elif literal.startswith('[O]~'):
            return f'obl(non({self.transform_literal(literal[4:])}))'
        elif literal.startswith('[P]~'):
            return f'per(non({self.transform_literal(literal[4:])}))'
        elif literal.startswith('[O]'):
            return f'obl({self.transform_literal(literal[3:])})'
        elif literal.startswith('[P]'):
            return f'per({self.transform_literal(literal[3:])})'
        elif literal.startswith('~'):
            return f'non({self.transform_literal(literal[1:])})'
        else:
            self.atoms.add(f'atom({literal}).')
            return literal 

    def get_output(self):
        return "\n".join(list(self.atoms) + self.rules + self.superiorities  + self.compensations + self.facts)

# Example usage:
# parser = DDLParser()
# parser.parse("""
# # Example rules
# r: A , B => C
# r1: [O]A, C => [O]B
# rule3: [P]A, ~D, ~[O]E => [P]~B
# rule_name: ~[O]~G => C
# s : => T
# s2: pippo -> pluto
# comp2: x => [O]y, [O]z, [O]~w             
             
# # Example superiority
# r1 > r2

# # Example facts
# a;c
# ~b
# """)
# print(parser.get_output())

