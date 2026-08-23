class_name HasMoneyCondition extends Condition

@export var money_amount:float=2.00
@export_enum(">",">=","!=","<","<=","==") var sign=">="

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func check():
	if sign==">=":
		if Global.money>=money_amount:
			return true
	elif sign==">":
		if Global.money>money_amount:
			return true
	elif sign=="<=":
		if Global.money<=money_amount:
			return true
	elif sign=="<":
		if Global.money<money_amount:
			return true
	elif sign=="==":
		if Global.money==money_amount:
			return true
	elif sign=="!=":
		if Global.money!=money_amount:
			return true
	return false
