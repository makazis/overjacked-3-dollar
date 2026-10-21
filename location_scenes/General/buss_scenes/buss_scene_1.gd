extends Node2D

var guy_is_dead=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.is_combat_going: #use as preset for combat handling
		if EffectContext.won:
			# Win sequence
			pass
		else:
			#lose sequence
			pass
	if Global.is_combat_going: #use as preset for combat handling
		if EffectContext.won:
			guy_is_dead=true
			$KilledTheGuy.visible=true
			pass
		else:
			#lose sequence
			pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void: #TAlk to the ugly man sequence initiated
	$Button.visible=false
	$Button3.visible=false
	$"huh?".visible=true
	$Gui.can_exit_to_map=false
	$Timer.start(randf_range(20,40))

func _on_button_2_pressed() -> void: #Sitting Down
	$Button2.visible=false
	$Button.visible=true
	$Button3.visible=true
	$"Sitting Down".visible=true


func _on_button_3_pressed() -> void:
	$Button2.visible=true
	$Button.visible=false
	$Button3.visible=false
	$"Sitting Down".visible=false


func _on_timer_timeout() -> void:
	$Button3.visible=true
	$"huh?".visible=false
	$Gui.can_exit_to_map=true
	$Button4.visible=true


func _on_button_4_pressed() -> void:
	Global.pre_combat_scene="res://location_scenes/General/buss_scenes/buss_scene_1.tscn"
	Global.start_combat(["Bigfoot"])
