extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.timer_running=false
	$Label2.text="Your Time: "+str(int(Global.time/3600.))+":"+str(int(Global.time/60)%60)+":"+str(int(Global.time)%60)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
