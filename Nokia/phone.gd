extends Node


# Called when the node enters the scene tree for the first time.
signal open_app(app_path:String)
var apps=["App Store","Whatsapp","Settings"]
signal apps_changed()

#settings
var music_volume=100
var sfx_volume=100
var overjacked_setting=0

func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
