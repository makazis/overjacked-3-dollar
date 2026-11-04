extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not FileAccess.file_exists("user://savegame.save"):
		$Button.visible=false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	Global.load_data()
	_on_button_2_pressed()


func _on_button_2_pressed() -> void:
	Global.transition_to_scene("res://Resources/MapMaxxing/GraphMaps/Riga/RigaMap.tscn")
