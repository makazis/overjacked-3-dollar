class_name Clothing extends Panel

#let's say these go from 0 to 50 on each individual one. Meaning each one can give a 50% increase to total money, equalling out to about 4.5 times the earnings with the right set. Or what if we increase this even further to 45 times. Yes, 45 times seems like a beautiful place to be at
#every point increases total money by... 2%
#meaning that together they can increase money by +700%, so 8 times, if used accordingly. 
@export var aura=0
@export var cute=0
@export var official=0
@export var clothing_name = ""
@export_enum("Hat","Overclothes","Shirt","Pants","Underwear","Shoes","Bag") var clothing_slot="Hat"
@export_enum("Common","Uncommon","Rare","Epic","Legendary","Achievement") var rarity="Common"
@export var market_price:float=10.
@export var set_name:String=""
# 0 - 100 for common
# 100 - 1000 for uncommon
# 1_000 - 100_000 for rare
# 100_000 - 1_000_000 for epic
# 1_000_000 - 100_000_000 for legendary
var equipped=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text=clothing_name
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$ColorRect.visible=equipped


func _on_button_pressed() -> void:
	if get_tree().current_scene.name=="Wardrobe":
		equipped=not equipped
		
		if equipped:
			if Global.equipped_clothes[clothing_slot]!=null:
				Global.equipped_clothes[clothing_slot].equipped=false
			Global.equipped_clothes[clothing_slot]=self
			Global.last_selected_clothing=self
			Global.calculate_clothes()
		else:
			
			Global.last_selected_clothing=null
			Global.equipped_clothes[clothing_slot]=null
			Global.calculate_clothes()
	elif get_tree().current_scene.name=="Soup Store":
		if Global.last_selected_clothing==self:
			Global.last_selected_clothing=null
		else:
			Global.last_selected_clothing=self	
		
		
