extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.is_combat_going: 
		if EffectContext.won:
			Global.enemies_defeated.append("John Politician")
			$Camera2D/DialogueLabel.visible=true
			$Camera2D/DialogueLabel.is_listening=true
			$Camera2D/DialogueLabel.start_dialogue(load("res://location_scenes/Riga/Church of John/Combat/JohnWonDialogue.dialogue"))
			pass
		else:
			$Camera2D/DialogueLabel.visible=true
			$Camera2D/DialogueLabel.is_listening=true
			$Camera2D/DialogueLabel.start_dialogue(load("res://location_scenes/Riga/Church of John/Combat/JohnLossDialogue.dialogue"))
			#lose sequence
			pass
		Global.is_combat_going=false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var sequence=""

func _on_button_pressed() -> void:
	$MainSpot.visible=false
	var tween=create_tween()
	tween.set_parallel()
	tween.tween_property($Camera2D,"position",Vector2(313,365),0.5)
	tween.tween_property($Camera2D,"scale",Vector2(1./2.3,1./2.3),0.5)
	tween.tween_property($Camera2D,"zoom",Vector2(2.3,2.3),0.5)
	await tween.finished
	$Camera2D/DialogueLabel.visible=true
	$Camera2D/DialogueLabel.is_listening=true
	$Camera2D/DialogueLabel.start_dialogue(load("res://location_scenes/Riga/Church of John/JohnDialogue.dialogue"))
	#dialogue_line = await john_dialogue_1.get_next_dialogue_line("start")
	#dialogue_line = await john_dialogue_1.get_next_dialogue_line("start")


func _on_button_2_pressed() -> void:
	$Camera2D/DialogueLabel.visible=true
	$MainSpot.visible=false
	$Camera2D/DialogueLabel.is_listening=true
	$Camera2D/DialogueLabel.start_dialogue(load("res://location_scenes/Riga/Church of John/God.dialogue"))
