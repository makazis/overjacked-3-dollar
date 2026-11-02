extends Node3D

@onready var tile = preload("res://location_scenes/tile_1.tscn")
@onready var tiles = get_node("Tiles")
# Called when the node enters the scene tree for the first time.
var gridstring = []
func _ready() -> void:
	var distance = 0
	var xy = Vector3(0,0,0)
	var iter = 0
	var directions = [
		Vector3(10,0,0),
		Vector3(0,0,10),
		Vector3(-10,0,0),
		Vector3(0,0,-10),
	]
	var i = 0
	while i < 10:
		i += 1
		var temp: Node3D = tile.instantiate()
		
		temp.get_children()[randi_range(1,3)].visible = true
		tiles.add_child(temp)
		temp.global_position = xy
		xy += directions[iter]
		if i > distance:
			iter = (iter + 1) % 4
			i = 0
			distance += 1
		gridstring.append(temp)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
