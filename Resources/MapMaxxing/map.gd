extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in get_children():
		if i is GraphPoint:
			if i.name==Global.on_map_where_am_i["Global"]:
				i.go_here()
				break


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
