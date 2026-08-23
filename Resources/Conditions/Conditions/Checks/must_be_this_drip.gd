class_name MustBeThisDripCondition extends Condition

@export_enum("Aura","Official","Cute") var cloth_type:String="Aura"
@export var at_least=10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func check():
	if cloth_type=="Aura":
		if Global.aura>at_least:
			return true
	if cloth_type=="Official":
		if Global.official>at_least:
			return true
	if cloth_type=="Cute":
		if Global.cute>at_least:
			return true
	
	return false
