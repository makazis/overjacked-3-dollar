extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.your_hospital_number!=0:
		$HandWithNumber/Label.text=str(Global.your_hospital_number)
		while len($HandWithNumber/Label.text)<3:
			$HandWithNumber/Label.text="0"+$HandWithNumber/Label.text
		$HandWithNumber.visible=true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$TokenNumber/Label.text=str(Global.hospital_number)
	while len($TokenNumber/Label.text)<3:
		$TokenNumber/Label.text="0"+$TokenNumber/Label.text
	

func _on_button_pressed() -> void:
	Global.your_hospital_number=max(Global.hospital_number+randi_range(randi_range(5,15),30),Global.your_hospital_number)
	$HandWithNumber/Label.text=str(Global.your_hospital_number)
	while len($HandWithNumber/Label.text)<3:
		$HandWithNumber/Label.text="0"+$HandWithNumber/Label.text
	$HandWithNumber.visible=true


func _on_button_2_pressed() -> void:
	if Global.hospital_number==Global.your_hospital_number:
		get_tree().change_scene_to_file("res://location_scenes/Riga/Hospital/is_it_my_number_yet.tscn")
	else:
		$AudioStreamPlayer2.play()
