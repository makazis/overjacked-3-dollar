extends FoldableContainer


# Called when the node enters the scene tree for the first time.
@onready var flag=preload("res://Nokia/AppData/Local/DebugMenu/Widgets/Flag.tscn")
func _ready() -> void:
	for _flag in Global.movement_flags:
		var new_flag=flag.instantiate()
		new_flag.setup(0,_flag)
		$VBoxContainer.add_child(new_flag)
	for _flag in Global.john_bounties:
		var new_flag=flag.instantiate()
		new_flag.setup(1,_flag)
		$VBoxContainer.add_child(new_flag)
	
	$"VBoxContainer/Combat Unlocked/CheckButton".button_pressed=Global.combat_unlocked
	$"VBoxContainer/Is Sleepy/CheckButton".button_pressed=Global.is_sleepy
	$"VBoxContainer/Can Donate Blood/CheckButton".button_pressed=Global.can_donate_blood
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _combat_unlocked(toggled_on: bool) -> void:
	Global.combat_unlocked=toggled_on

func _is_sleepy(toggled_on: bool) -> void:
	Global.is_sleepy=toggled_on

func _can_donate_blood(toggled_on: bool) -> void:
	Global.can_donate_blood=toggled_on
