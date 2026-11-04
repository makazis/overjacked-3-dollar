extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in get_children():
		if i is GraphPoint:
			if i.name==Global.on_map_where_am_i["Riga-Limbo"]:
				i.go_here()
				break
	Global.movement_flags["In Hell"]=true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
