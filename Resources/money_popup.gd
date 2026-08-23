extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	if Global.last_money_popup==self:
		Global.last_money_popup=null
	queue_free()

func set_text(text):
	$Label.text=text
