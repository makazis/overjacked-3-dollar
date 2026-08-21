class_name Clothing extends Node2D

@export var aura=0
@export var cute=0
@export var official=0
@export var clothing_name = ""
@export_enum("Hat","Overclothes","Shirt","Pants","Underwear","Shoes","Bag") var clothing_slot="Hat"
@export_enum("Common","Uncommon","Rare","Epic","Legendary") var rarity="Common"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
