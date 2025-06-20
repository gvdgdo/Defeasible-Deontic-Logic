import clingo
import sys
sys.path.append("/Users/guido/Documents/Current/ICAIL-Tutorial/Defeasible-Deontic-Logic/Python")
import turnipparser

ctl = clingo.Control(["0", "--warn=no-atom-undefined"])

path = "/Users/Guido/Documents/Current/ICAIL-Tutorial/Defeasible-Deontic-Logic/"
rule_path = "/Users/Guido/Documents/Current/ICAIL-Tutorial/"

engine_files = [
    "language.asp",
    "Deontic/defeasible-ab.asp",
    "Deontic/deontic.asp",
]

rule_files = [ "rules.dft" ]

for file in engine_files:
    ctl.load(path+file)

for f in rule_files:
    p = parser.DDLParser()
    theory = open(f, "r")
    p.parse(theory.read())
    with open(f"simple.lp", "w") as output_file:
        output_file.write(p.get_output())    
    ctl.add("base", [], p.get_output())

# ctl.load("output.lp")

ctl.ground([("base", ())])

for model in ctl.solve(yield_=True):
    for symbol in model.symbols(shown=True):
        print(symbol)

