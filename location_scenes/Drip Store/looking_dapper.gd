extends Node2D

var aura=0
var official=0
var cute=0
var sigma=0

#your clothing scores, your money gain is multiplied by this

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://location_scenes/The Dice Goblin/rolling dice.tscn")


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://location_scenes/Drip Store/opening_drip_box.tscn")
