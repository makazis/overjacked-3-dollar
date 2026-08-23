extends Node2D

var inspecting:Clothing=null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.last_selected_clothing=null
	for i in $ScrollContainer/GridContainer.get_children():
		for ii in Global.clothes:
			if ii.clothing_name==i.clothing_name:
				i.queue_free()
	
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	inspecting=Global.last_selected_clothing
	if inspecting == null:
		$Label.visible=false
	else:
		$Label.visible=true
		$Label.text=inspecting.clothing_name+"\nAura:\nOfficial:\nCute:\nCost: "+Global.convert_to_cash(inspecting.market_price)
		$Label/AuraBar.value=inspecting.aura*2.
		$Label/Obara.value=inspecting.official*2.
		$Label/CutenessBar.value=inspecting.cute*2.
		
	
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://location_scenes/Riga/Home/root.tscn")


func buy() -> void:
	if Global.money<inspecting.market_price:
		return
	Global.money-=inspecting.market_price
	Global.clothes.append(inspecting)
	$ScrollContainer/GridContainer.remove_child(inspecting)
	get_tree().get_root().add_child(inspecting)
	inspecting.visible=false
	Global.last_selected_clothing=null
