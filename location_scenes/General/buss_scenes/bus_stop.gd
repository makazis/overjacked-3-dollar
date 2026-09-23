extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#get_tree()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$ProgressBar.value+=delta*5


func _on_timer_timeout() -> void:
	$Gui.transition_to_scene("res://location_scenes/General/buss_scenes/buss_scene_1.tscn")
