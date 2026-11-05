@tool
class_name PatternAction extends Resource
## The type of action that the enemy will perform
## AttacK: Attack a random playerside character for *amount* of damage perhaps multiple *times* 
## Block: self explanatory
## Curse: weaken the playerside character
## Buff: buff itself
## Dig: Deprecated
## Flee: run away from the combat, instantly winning. 
@export_enum("Attack","Block","Curse","Buff","Dig","Flee") var type:String
##
@export var amount:int=5
@export var times:int=1
@export_enum("Strength","Dexterity","Burning") var status_type:String="Strength"
@export var target_perhaps:String=""
