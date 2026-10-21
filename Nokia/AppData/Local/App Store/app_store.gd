extends Node2D


# Called when the node enters the scene tree for the first time.
var all_apps=[
	"Whatsapp",
	"Book 2",
	"App Store", #IDK HOW YOU WOULD BE IN THE APP STORE WHILE HAVING APP STORE DELETED (NixOS)
	"Settings",
	"Hopital App",
	"Rhythm Heaven",
	"ChadGPT"
]
@onready var app_in_app_store=preload("res://Nokia/AppData/Local/App Store/app_in_app_store.tscn")
func _ready() -> void:
	for app in all_apps:
		if not app in Phone.apps:
			add_app_to_app_store(app)
	
func add_app_to_app_store(app_name):
	var new_app=app_in_app_store.instantiate()
	new_app.setup(app_name)
	$ScrollContainer/VBoxContainer.add_child(new_app)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
