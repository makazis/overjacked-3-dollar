class_name soup_rooms_evil_sun extends PathFollow2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if randf()<1/5.:
		queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	progress+=delta*200
	if progress_ratio>=1:
		queue_free()


func _on_node_2d_body_entered(body: Node2D) -> void:
	if body.name=="Fisch":
		Global.fish_lives-=1
		if Global.fish_lives==0:
			get_tree().change_scene_to_file("res://location_scenes/Riga/Soup Store/fishing_in_backrooms.tscn")
		queue_free()
