extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$TokenNumber/Label.text=str(Global.hospital_number)
	while len($TokenNumber/Label.text)<3:
		$TokenNumber/Label.text="0"+$TokenNumber/Label.text
