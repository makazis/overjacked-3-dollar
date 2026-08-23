class_name XOrCondition extends Condition

@export var condition_1:Condition=null
@export var condition_2:Condition=null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func check():
	if condition_1.check() or condition_2.check():
		if condition_1.check() and condition_2.check():
			return false
		return true
	return false
