extends Node2D

var total_lives=1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.fish_lives=Global.max_fish_lives+Global.extra_fish_lives
	Global.extra_fish_lives=0
	total_lives=Global.fish_lives
	
	for i in range(100):
		var new_sun=evil_sun.instantiate()
		$Path2D.add_child(new_sun)
		new_sun.progress=i*200.

var mouse_pos=Vector2(0,0)
func _physics_process(delta: float) -> void:
	mouse_pos=get_viewport().get_mouse_position()
	$Camera2D.position.y=max(0,min(5000,$Fisch.position.y-324))
	var global_mouse_pos=mouse_pos+$Camera2D.position
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var speed=$Fisch.position.direction_to(global_mouse_pos)*delta*30000
		$Fisch.apply_central_force(speed)
	for i in range(10):
		if Global.fish_lives>i:
			$Camera2D/Node2D.get_child(i).visible=true
		else:
			$Camera2D/Node2D.get_child(i).visible=false
	if $Fisch.position.y>5648:
		if total_lives==1:
			Global.achieve_clothes("Fisherman's Hat")
		Global.earn_money(100)
		if total_lives==Global.fish_lives:
			Global.earn_money(20*(Global.fish_lives-1))
		get_tree().change_scene_to_file("res://location_scenes/Riga/Soup Store/fishing_in_backrooms.tscn")
@onready var evil_sun=preload("res://location_scenes/Riga/Soup Store/evil_sun.tscn")
func _on_timer_timeout() -> void:
	var new_sun=evil_sun.instantiate()
	$Path2D.add_child(new_sun)
