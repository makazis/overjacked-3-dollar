@tool
class_name AutomataCondition extends Resource

@export var input_nodes:Array[int]=[]
@export var output_nodes:Array[int]=[]
## which node will be activated if the condition is succesful
func test_condition(caster:Creature,player:Creature):
	## Also functions as the always true condition. Meaning that can be used for non-conditional finite automata. 
	return true
