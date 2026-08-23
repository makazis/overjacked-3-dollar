class_name CostsMoneyCondition extends Condition

@export var money_amount:float=2.00
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func check():
	if Global.money<money_amount:
		return false
	return true

func affect():
	Global.money-=money_amount
