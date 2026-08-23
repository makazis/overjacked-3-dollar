class_name GraphPoint extends Node2D

var connected_with:Array[graph_point_with_conditions]=[]
var you_are_here:bool=false
@export var loads_scene:String=""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text=name
	if you_are_here:
		go_here()
	for i in get_children(): # a bit of safety
		if i is graph_point_with_conditions:
			connected_with.append(i)

# Called every frame. 'delta' is the elapsed time since the previous frame.
var timer=0
func _process(delta: float) -> void:
	timer+=delta
	$HereIsYou.visible=you_are_here
	$HereIsYou.position=Vector2(-1,-79+sin(timer*5)*15)

func go_here():
	
	if Global.where_am_i!=null:
		Global.where_am_i.you_are_here=false
		for i in Global.where_am_i.connected_with:
			i.visible=false
	Global.where_am_i=self
	you_are_here=true
	Global.on_map_where_am_i[Global.what_map_am_i_on]=self.name
	for i in connected_with:
		i.visible=true


func _on_button_pressed() -> void:
	if Global.where_am_i==self:
		get_tree().change_scene_to_file(loads_scene)
		return
	Global.try_to_go_here(self)
	
