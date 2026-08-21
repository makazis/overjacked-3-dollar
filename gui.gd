extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Money.text=str(round(Global.money*100)/100.)
	if $Money.text[-2]==".":
		$Money.text+="0"
	$Money.text+="$"
	$Time.text=str(int(Global.time/3600.))+":"+str(int(Global.time/60)%60)+":"+str(int(Global.time)%60)
	if Global.money>1_000_000: #get one million money to win
		get_tree().change_scene_to_file("res://you_win!!!.tscn")

func _on_button_pressed() -> void:
	pass # Replace with function body.
