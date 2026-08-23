class_name IsWearingCondition extends Condition

@export var needs_to_be_wearing:String="Cat Ears"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func check():
	for i in Global.equipped_clothes:
		if Global.equipped_clothes[i]!=null:
			if Global.equipped_clothes[i].clothing_name==needs_to_be_wearing:
				return true
	return false
