extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var timer=0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer<=0:
		timer+=randf_range(0.4,1.3)
		CombatData.player_hp+=randi_range(2,6)
		CombatData.player_hp=clamp(CombatData.player_hp,0,70)
	timer-=delta
	Global.time+=20*delta
