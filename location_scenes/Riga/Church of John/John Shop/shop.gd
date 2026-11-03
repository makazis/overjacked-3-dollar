extends Node2D


# Called when the node enters the scene tree for the first time.
@onready var john_card_slot=preload("res://location_scenes/Riga/Church of John/John Shop/John_Shop_card_slot.tscn")
func _ready() -> void:
	for card_name in Global.john_sells_cards:
		var new_john_slot=john_card_slot.instantiate()
		new_john_slot.setup(card_name,Global.john_card_costs[card_name],Global.john_sells_cards[card_name])
		$ScrollContainer/GridContainer.add_child(new_john_slot)
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
