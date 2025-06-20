import clingo

ctl = clingo.Control(["0", "--warn=no-atom-undefined"])

path = "/Users/Guido/Documents/Current/ICAIL-Tutorial/Defeasible-Deontic-Logic/"

engine_files = [
    "language.asp",
    "Deontic/defeasible-ab.asp",
    "Deontic/deontic.asp"]

rule_files = [ "rules.lp" ]

facts_files = [ "facts.lp" ]

ctl.load("output.lp")

for file in engine_files:
    ctl.load(path+file)

for file in rule_files:
    ctl.load(file)

for file in facts_files:
    ctl.load(file)

ctl.ground([("base", ())])

for model in ctl.solve(yield_=True):
    for symbol in model.symbols(shown=True):
        print(symbol)