extends Node2D

var inspecting:Clothing=null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	for i in Global.clothes:
		i.visible=true
		get_tree().get_root().remove_child(i)
		$ScrollContainer/GridContainer.add_child(i)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$DripBar.value=(Global.money_multipliers[0]-1)/7.*100.
	inspecting=Global.last_selected_clothing
	if inspecting == null:
		$Label.visible=false
	else:
		$Label.visible=true
		$Label.text=inspecting.clothing_name+"\nAura:\nOfficial:\nCute:"
		if inspecting.set_name!="":
			$Label.text+="\nSet: "+inspecting.set_name
		
		$Label/AuraBar.value=inspecting.aura*2.
		$Label/Obara.value=inspecting.official*2.
		$Label/CutenessBar.value=inspecting.cute*2.
	$Label3.text=Global.set_bonuses
	
func _on_button_pressed() -> void:
	for i in $ScrollContainer/GridContainer.get_children():
		$ScrollContainer/GridContainer.remove_child(i)
		get_tree().get_root().add_child(i)
		i.visible=false
	get_tree().change_scene_to_file("res://location_scenes/Riga/Home/root.tscn")
	
func on_exit():
	for i in $ScrollContainer/GridContainer.get_children():
		$ScrollContainer/GridContainer.remove_child(i)
		get_tree().get_root().add_child(i)
		i.visible=false
