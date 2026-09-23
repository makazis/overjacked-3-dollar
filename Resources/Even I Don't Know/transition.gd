extends ColorRect

signal dies
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween=create_tween()
	tween.tween_property(self,"modulate",Color(1,1,1,1),0.5)
	await tween.finished
	dies.emit()
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
