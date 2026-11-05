@tool  # Optional: enables live data preview in the editor
extends CardLayout

@onready var name_label: Label = $SubViewport/DefaultCardSprite/Label
@onready var description_label: Label = $SubViewport/DefaultCardSprite/Label2

@onready var sprite=$SubViewport/DefaultCardSprite
#@onready var image: TextureRect = %CardImage

func _update_display() -> void:
	var data = card_resource as Gu_Move
	if data:
		name_label.text = data.card_name
		description_label.text = data.card_description
		if data.time_cost==0:
			$"SubViewport/DefaultCardSprite/No Time".visible=true
		if data.time_cost==1:
			$"SubViewport/DefaultCardSprite/One Time".visible=true
		if data.time_cost==2:
			$"SubViewport/DefaultCardSprite/Two Time".visible=true
		if data.time_cost==3:
			$"SubViewport/DefaultCardSprite/Three Time".visible=true
		if data.time_cost==4:
			$"SubViewport/DefaultCardSprite/Four Time".visible=true
		if count>0:
			$SubViewport/DefaultCardSprite/Count.visible=true
			$SubViewport/DefaultCardSprite/Count/Label.text="x"+str(count)
		else:
			$SubViewport/DefaultCardSprite/Count.visible=false
	if data.art!=null:
		$SubViewport/DefaultCardSprite/Sprite2D.texture=data.art
	display_updated.emit()
