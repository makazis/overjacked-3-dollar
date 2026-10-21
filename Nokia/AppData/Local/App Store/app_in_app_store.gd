extends Panel


# Called when the node enters the scene tree for the first time.
var costs={
	"Book 2":0.00,
	"Hopital App":1.99,
	"Rhythm Heaven":4.99,
	"ChadGPT":0.14,
}
var is_about_app="Book 2"
func setup(app_name:String):
	is_about_app=app_name
	$Panel.setup(app_name)
	
	if app_name in costs:
		$Label.text=Global.convert_to_cash(costs[app_name])
	else:
		$Label.text="UNKNOWN PRICE"
	
func _ready() -> void:
	$Panel.toggle_button()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	if Global.money<costs[is_about_app]:
		return
	Global.money-=costs[is_about_app]
	Phone.apps.append(is_about_app)
	Phone.apps_changed.emit()
	queue_free()
