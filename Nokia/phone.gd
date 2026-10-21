extends Node


# Called when the node enters the scene tree for the first time.
signal open_app(app_path:String)
var apps=["App Store","Whatsapp","Settings"]
signal apps_changed()
signal shake_phone(time:int)
#settings
var music_volume=100
var sfx_volume=100
var overjacked_setting=0
var combat_settings_unlocked=false
var screen_shake_on_hitting=false
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
