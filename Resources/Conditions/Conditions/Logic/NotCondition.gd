class_name NotCondition extends Condition

@export var condition:Condition=null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func check():
	if !condition.check():
		return true
	return false
