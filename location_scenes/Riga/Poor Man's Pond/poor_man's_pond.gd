extends Node2D


# Called when the node enters the scene tree for the first time.
var mouse_pos=Vector2(0,0)
func _ready() -> void:
	pass # Replace with function body.

var hidden_coins=[]
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	mouse_pos=get_viewport().get_mouse_position()
	$Marker2D.position=mouse_pos
	$Marker2D.position.y=max(330,$Marker2D.position.y)
	$Marker2D/GrabIt.visible=is_grabbing
	$Marker2D/ReachForIt.visible=!is_grabbing
	while len(hidden_coins)<5:
		hidden_coins.append([Vector2(randi_range(0,1152),randi_range(330,648)),[1,1,1,1,1,2,2,2,5,5,5,10,10,20,20,50,100,200].pick_random()])
var is_grabbing=false
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left click"):
		is_grabbing=true
		var found_coins=[]
		for i in hidden_coins:
			if mouse_pos.distance_to(i[0])<50:
				Global.earn_money(i[1]/100.,false)
				Global.make_money_popup.emit(i[1],[
					"Found in the local water fountain",
					"Stole from the goverment",
					"Stole from the other homeless people",
					"Due to praying hard enough",
					"Finders Keepers"
				].pick_random())
				found_coins.append(i)
		for i in found_coins:
			hidden_coins.erase(i)
	if event.is_action_released("left click"):
		is_grabbing=false
	
