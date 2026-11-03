extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.is_combat_going: #use as preset for combat handling
		if EffectContext.won:
			if "John Homeless" in EffectContext.enemies:
				Global.enemies_defeated.append("John Homeless")
			else:
				Global.enemies_defeated.append("Chupacabra")
		else:
			#lose sequence
			pass
		Global.is_combat_going=false
	$Control.is_listening=true
	$Control.start_dialogue(load("res://location_scenes/Riga/Poor Man's Pond/John Homeless/Homeless_John.dialogue"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
