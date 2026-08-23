extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	call_deferred("move_on_global")
	#pass
func move_on_global():
	global_position=-Vector2(1152,648)/2+Global.where_am_i.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
var previous_mouse_pos=Vector2(0,0)
var mouse_pos=Vector2(0,0)
func _process(delta: float) -> void:
	previous_mouse_pos=mouse_pos
	mouse_pos=get_viewport().get_mouse_position()
	var mouse_rel=mouse_pos-previous_mouse_pos
	if is_being_dragged:
		position-=mouse_rel
	position.x=min(limit_right,max(limit_left,position.x))
	position.y=min(limit_bottom,max(limit_top,position.y))
	
	
var is_being_dragged=false
		


func _on_button_button_down() -> void:
	is_being_dragged=true
	



func _on_button_button_up() -> void:
	is_being_dragged=false


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file(Global.where_am_i.loads_scene)
