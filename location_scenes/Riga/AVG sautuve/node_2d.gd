extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.is_combat_going: #use as preset for combat handling
		if EffectContext.won:
			Global.enemies_defeated.append("Mothman")
			pass
		else:
			#lose sequence
			pass
		Global.is_combat_going=false
	if "Mothman" in Global.enemies_defeated:
		$Button.visible=false
		$Mothman.visible=false
var questions={
	"What is the name of the main character?":["fang yuan"],
	"Name a gu that appears in the first 20 chapters":["liquor worm","spring autumn cicada"],
}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	Global.pre_combat_scene="res://location_scenes/Riga/AVG sautuve/node_2d.tscn"
	Global.start_combat(["Mothman"])
