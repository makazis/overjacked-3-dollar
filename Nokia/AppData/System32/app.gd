extends Panel

var app_locations={
	"Settings":Vector2(0,0),
	"App Store":Vector2(1,0),
	"Book 2":Vector2(2,0),
	"Whatsapp":Vector2(3,0)
	
}
func setup(app_name:String):
	if app_name in app_locations:
		$Icon.region_rect=Rect2(app_locations[app_name].x*128,app_locations[app_name].y*128,128,128)
	else:
		$Icon.region_rect=Rect2(512,0,128,128)
	$Label.text=app_name
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	Phone.open_app.emit($Label.text)

func toggle_button():
	$Button.disabled=!$Button.disabled
	
