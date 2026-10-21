extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	
	var roll=randi_range(1,100)
	#print("Button Detected, generating random outcome, roll: "+str(roll))
	if roll>=1 and roll<=5:
		print("Relocating you to birmingham")
		Global.what_map_am_i_on="London"
		Global.on_map_where_am_i["London"]="Alleyway"
		get_tree().change_scene_to_file("res://location_scenes/London/Alleyway/London Alleyway.tscn")
	if roll>=10 and roll<50:
		var message=[
			"The gods heard your prayer",
			"It's your lucky day",
			"Carnikava just has free money laying around sometimes",
			"Buy yourself something nice, kid",
		].pick_random()
		var money_gained=randf_range(0.5,3)
		Global.earn_money(money_gained)
		Global.make_money_popup.emit(int(money_gained*100),message)
