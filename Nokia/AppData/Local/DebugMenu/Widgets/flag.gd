extends Panel

var binds_to_flag=""
var tips=0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func setup(type,flag_name):
	tips=type
	binds_to_flag=flag_name
	if tips==0:
		$CheckButton.button_pressed=Global.movement_flags[flag_name]
		$Label.text="MF: "+binds_to_flag
	if tips==1:
		$CheckButton.button_pressed=Global.john_bounties[flag_name]
		$Label.text="John Bounty: "+binds_to_flag
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_check_button_toggled(toggled_on: bool) -> void:
	if tips==0:
		Global.movement_flags[binds_to_flag]=toggled_on
	if tips==1:
		Global.john_bounties[binds_to_flag]=toggled_on
