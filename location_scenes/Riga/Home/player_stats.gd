extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Panel/Label.text="HP: "+str(CombatData.player_hp)+"/"+str(CombatData.player_max_hp)+"\n\n"
	if Global.player_ball_knowledge<10:
		$Panel/Label.text+="Ball Knowledge: "+str(Global.player_ball_knowledge)
		$Panel/ProgressBar.value=100.*(Global.player_ball_knowledge_xp/Global.player_ball_knowledge_levelups[Global.player_ball_knowledge])
	else:
		$Panel/ProgressBar.visible=false
		$Panel/Label.text+="Ball Knowledge: Indeed"
	$Panel/Label.text+="\n"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
