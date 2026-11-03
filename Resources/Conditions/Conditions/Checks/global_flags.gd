class_name FlagCondition extends Condition

@export var global_flag:String=""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func check():
	if !global_flag in Global.movement_flags:
		return false
	return Global.movement_flags[global_flag]
