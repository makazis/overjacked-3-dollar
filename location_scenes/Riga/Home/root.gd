extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Button3.visible=Global.combat_unlocked


func gobbl_button() -> void:
	get_tree().change_scene_to_file("res://location_scenes/The Dice Goblin/rolling dice.tscn")


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://location_scenes/Riga/Home/wardrobe.tscn")


func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://location_scenes/Riga/Home/cardrobe.tscn")
	#Global.what_map_am_i_on="Riga"
	#get_tree().change_scene_to_file("res://Resources/MapMaxxing/GraphMaps/Riga/RigaMap.tscn")


func _nap_button() -> void:
	if Global.is_sleepy:
		Global.is_sleepy=false
		Global.transition_to_scene("res://location_scenes/Riga/Home/sleeping.tscn")
	else:
		$AudioStreamPlayer.play()


func _stats() -> void:
	Global.transition_to_scene("res://location_scenes/Riga/Home/player_stats.tscn")
