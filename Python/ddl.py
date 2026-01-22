import clingo
import sys
sys.path.append("/Users/guido/Documents/GitHub/Refactoring/Defeasible-Deontic-Logic/Python")
import parser

ctl = clingo.Control(["0", "--warn=no-atom-undefined"])

engine_files = [
    "language.asp",
    "Basic/language.asp",
    "Deontic/language.asp",
    "Deontic/defeasible-ab.asp",
    # "Deontic/deontic.asp",
    "Deontic/deontic-comp.asp"
]

rule_files = [ 
    # "Examples/ambiguity.dl" 
    "Examples/deontic-test.dl"
    ]

for file in engine_files:
    ctl.load(file)

for f in rule_files:
    p = parser.DDLParser()
    theory = open(f, "r")
    content = theory.read()

    print(content)

    p.parse(theory.read())
    p.parse(content)

    with open(f"simple.lp", "w") as output_file:
        output_file.write(p.get_output())    
   
    ctl.add("base", [], p.get_output())

ctl.load("Examples/output.lp")
# ctl.load("Deontic/debug.lp")

ctl.ground([("base", ())])

modelNo = 1

for model in ctl.solve(yield_=True):
    print(f"\nModel: {modelNo}")
    modelNo += 1
    for symbol in model.symbols(shown=True):
        print(symbol)
        # if symbol.name == "obligation":
        #     print (f"--> There is an obligation for {symbol.arguments[0]}")
        # if symbol.name == "refuted":
        #     if symbol.arguments[0].name == "non":
        #         print (f"~{symbol.arguments[0].arguments[0]}")

times = ctl.statistics['summary']['times']
print(f"\nTotal: {times['total']:.3f}")
print(f"CPU:   {times['cpu']:.3f}")

print(f"Atoms: {ctl.statistics['problem']['lp']['atoms']:.0f}")

print(f"Rules: {ctl.statistics['problem']['lp']['rules']:.0f}") 