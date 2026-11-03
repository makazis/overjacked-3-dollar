extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.money=0
	if Global.is_combat_going: #use as preset for combat handling
		if EffectContext.won:
			Global.enemies_defeated.append("Greater Angel")
			pass
		else:
			#lose sequence
			pass
		Global.is_combat_going=false
	if !Global.combat_unlocked or "Greater Angel" in Global.enemies_defeated:
		$Button.visible=false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	Global.pre_combat_scene="res://location_scenes/London/Alleyway/London Alleyway.tscn"
	Global.start_combat(["Greater Angel"])
