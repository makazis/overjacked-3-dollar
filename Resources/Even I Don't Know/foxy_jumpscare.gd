extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not "Four Flaming Fingers" in Global.player_all_cards:
		Global.player_gain_card("Four Flaming Fingers")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	queue_free()
