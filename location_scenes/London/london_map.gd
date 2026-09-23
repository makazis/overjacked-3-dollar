extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	$Timer.start()
	$Button.visible=false


func _on_timer_timeout() -> void:
	Global.on_map_where_am_i["Riga"]="House"
	Global.what_map_am_i_on="Riga"
	get_tree().change_scene_to_file("res://Resources/MapMaxxing/GraphMaps/Riga/RigaMap.tscn")
