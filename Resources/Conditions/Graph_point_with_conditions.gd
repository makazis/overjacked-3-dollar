@tool
class_name graph_point_with_conditions extends Node2D

@export var conditions:Array[Condition]=[]
@export var connects_to:GraphPoint=null
@export var line_color:Color=Color(1.0, 1.0, 1.0, 1.0)

@onready var line=preload("res://Resources/MapMaxxing/GraphMaps/graph_line.tscn")
# Called when the node enters the scene tree for the first time.
var nline=null

func _ready() -> void:
	visible=false
	nline=line.instantiate()
	nline.modulate=line_color
	add_child(nline)
	nline.set_point_position(1,-global_position+connects_to.global_position)
	nline.get_child(0).position=(-global_position+connects_to.global_position)/2+Vector2(0,-20)
	nline.get_child(0).text=""
	for i in conditions:
		if i is CostsMoneyCondition:
			nline.get_child(0).text+="Costs: "+str(i.money_amount)+"$\n"
		if i is HasMoneyCondition:
			nline.get_child(0).text+="Needs: "+str(i.money_amount)+"$\n"
		if i is IsWearingCondition:
			nline.get_child(0).text+="Must Wear: "+str(i.needs_to_be_wearing)+"\n"
		if i is MustBeThisDripCondition:
			nline.get_child(0).text+="Needs: "+str(i.at_least)+" "+str(i.cloth_type)
	if nline.get_child(0).text!="":
		nline.get_child(0).visible=true

# Called every frame. 'delta' is the elapsed time since the previous frame.
var timer=0
func _process(delta: float) -> void:
	if visible:
		timer-=delta
		if timer<0:
			timer+=1
			if check():
				nline.modulate=line_color
			else:
				nline.modulate=Color(1.0, 0.0, 0.0, 1.0)
func check():
	for i in conditions:
		if i!=null:
			if !i.check():
				return false
	return true
func affect():
	for i in conditions:
		if i!=null:
			i.affect()
