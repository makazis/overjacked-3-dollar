extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var total_timer=100
	#print(jumps)
	#print(holds)
var timer=100
var jumps=[
]
var holds=[
	Vector2(99999,9999)
]
var hold_timer=0
var hold_index=0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	timer-=delta*10
	$ProgressBar.value=100-(timer+sin(timer*TAU/100)*40)


func _on_timer_timeout() -> void:
	$Gui.transition_to_scene("res://location_scenes/General/buss_scenes/buss_scene_1.tscn")

func combat_victory():
	pass

func combat_loss():
	pass
