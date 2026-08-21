extends Node2D


# Called when the node enters the scene tree for the first time.
var objects=[
	preload("res://Resources/Clothes/Cat Ears.tscn")
]
var roll_weights={
	"Common":1,
	"Uncommon":0.4,
	"Rare":0.1,
	"Epic":0.03,
	"Legendary":0.01
}
func _ready() -> void:
	var all_clothes=[]
	var total_roll=0
	for i in objects:
		all_clothes.append(i.instantiate())
		total_roll+=roll_weights[all_clothes[-1].rarity]
	var roll=randf_range(0,total_roll)
	var selected:Clothing=null
	for i in all_clothes:
		roll-=roll_weights[i.rarity]
		if roll<=0:
			selected=i
			break
	$Marker2D.add_child(selected)
	for i in Global.clothes:
		if i.clothing_name==selected.clothing_name:
			return
	Global.clothes.append(selected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://location_scenes/Drip Store/looking_dapper.tscn")
