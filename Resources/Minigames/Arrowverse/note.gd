class_name Note extends PathFollow2D

@export_enum("Up","Down","Left","Right") var direction="Up"
@export var total_time:float=1.2
var time=0
signal dies()
func _ready() -> void:
	$ArrowDown.visible=direction=="Down"
	$ArrowLeft.visible=direction=="Left"
	$ArrowUp.visible=direction=="Up"
	$ArrowRight.visible=direction=="Right"
	progress_ratio=1
	time=total_time
# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time-=delta
	progress_ratio=time/total_time
	if progress_ratio<=0:
		dies.emit()
		queue_free()
		return
