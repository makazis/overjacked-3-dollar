extends Node2D

var dice=[4,6,8,12,20,100]
var payouts=[5,40,100,1_000,3_000,100_000]
var costs=[1,5,10,50,100,200]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if "Dice Goblin" in Global.enemies_defeated:
		$Button.visible=false

func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	$Button.visible=false
	$Control.visible=true
	$Control.is_listening=true
	$Control.start_dialogue(load("res://location_scenes/Riga/The Dice Goblin/Goblin.dialogue"),"start")
