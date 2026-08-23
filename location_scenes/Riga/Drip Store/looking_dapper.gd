extends Node2D




#your clothing scores, your money gain is multiplied by this

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_button_2_pressed() -> void:
	if Global.money<200:
		return
	Global.money-=200
	get_tree().change_scene_to_file("res://location_scenes/Riga/Drip Store/opening_drip_box.tscn")
