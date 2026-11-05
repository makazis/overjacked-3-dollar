@tool
class_name AttackPattern extends Resource

@export_enum("None","Random","Cycle","Random+","Automata") var PatternType:String
@export var attacks:Array[EnemyAttackMove]
@export var automata_vertices:Array[AutomataCondition]
@export var starts_at:int=0
