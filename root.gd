extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func gobbl_button() -> void:
	get_tree().change_scene_to_file("res://location_scenes/The Dice Goblin/rolling dice.tscn")
