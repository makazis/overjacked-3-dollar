extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.is_combat_going: #use as preset for combat handling
		if EffectContext.won:
			Global.enemies_defeated.append("Lesser Angel")
			pass
		else:
			#lose sequence
			pass
		Global.is_combat_going=false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$TokenNumber/Label.text=str(Global.hospital_number)
	while len($TokenNumber/Label.text)<3:
		$TokenNumber/Label.text="0"+$TokenNumber/Label.text


var sips_taken=0
func _on_button_pressed() -> void:
	$AudioStreamPlayer.play()
	sips_taken+=1
	if sips_taken==5:
		if Global.combat_unlocked and not "Lesser Angel" in Global.enemies_defeated:
			Global.pre_combat_scene="res://location_scenes/Riga/Soup Store/fishing_in_backrooms.tscn"
			Global.start_combat(["Lesser Angel"])
			


func _on_fish_button_pressed() -> void:
	$Panel.visible=true
	for i in 6:
		if i<Global.extra_fish_lives:
			$Panel/Node2D.get_child(i).visible=true
		else:
			$Panel/Node2D.get_child(i).visible=false
	
	#


func _on_confirm_pressed() -> void:
	if Global.money<10.99:
		return
	Global.money-=10.99
	get_tree().change_scene_to_file("res://location_scenes/Riga/Soup Store/fishing_minigame.tscn")


func _on_more_dino_nuggers_pressed() -> void:
	if Global.money<5.00 or Global.extra_fish_lives>5:
		return
	Global.money-=5.00
	$Panel/Node2D.get_child(Global.extra_fish_lives).visible=true
	Global.extra_fish_lives+=1
	
	#get_tree().change_scene_to_file("res://location_scenes/Riga/Soup Store/fishing_minigame.tscn")


func _on_deny_pressed() -> void:
	$Panel.visible=false
