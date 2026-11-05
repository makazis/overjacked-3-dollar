@tool
class_name HasHealthCondition extends AutomataCondition

@export_enum("Player","Self") var targets="Self"
@export var health:int=30
@export_enum(">",">=","!=","<","<=","==") var sign=">="


func test_condition(caster:Creature,player:Creature):
	var targeted_entity:Creature=null
	if targets=="Self":
		targeted_entity=caster
	else:
		targeted_entity=player
	if sign==">":
		if targeted_entity.hp>health:
			return true
	if sign=="<":
		if targeted_entity.hp<health:
			return true
	if sign==">=":
		if targeted_entity.hp>=health:
			return true
	if sign=="<=":
		if targeted_entity.hp<=health:
			return true
	if sign=="==":
		if targeted_entity.hp==health:
			return true
	if sign=="!=":
		if targeted_entity.hp!=health:
			return true
	return false
