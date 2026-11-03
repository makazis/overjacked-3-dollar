extends Node2D

func setup(card_name):
	var my_card=Card.new(Global.card_database[card_name])
	my_card.scale=Vector2(0.5,0.5)
	my_card.position=Vector2(-30,-64)
	add_child(my_card)	
	
func _ready() -> void:
	var tween=create_tween()
	tween.tween_property(self,"modulate",Color(1,1,1,1),0.3)
	await tween.finished
	await get_tree().create_timer(2).timeout
	tween=create_tween()
	tween.tween_property(self,"modulate",Color(1,1,1,0),0.3)
	await tween.finished
	queue_free()
