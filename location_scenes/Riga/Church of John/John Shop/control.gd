extends Panel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Label.text=str(snapped(_cost,0.01))+"$ "+str(_amount)+"x"

var _amount=0
var _cost=0
var crd_name=""
func setup(card_name:String,cost:float,amount=1):
	_cost=cost
	_amount=amount
	crd_name=card_name
	$Card.card_data=Global.card_database[card_name]
	$Card.refresh_layout()


func _on_button_pressed() -> void:
	if Global.money>_cost:
		Global.money-=_cost
		_amount-=1
		Global.player_gain_card(crd_name)
		if _amount==0:
			queue_free()
