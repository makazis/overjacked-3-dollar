extends Node


# Called when the node enters the scene tree for the first time.
signal open_app(app_path:String)
## Add app named "Debug" to the list to access debug mode
var apps=["App Store","Whatsapp","Settings","Notepad"]

signal apps_changed()
signal shake_phone(time:int)
var notepad_text=""
#region settings
var music_volume=100
var sfx_volume=100
var overjacked_setting=0
var combat_settings_unlocked=false
var screen_shake_on_hitting=false
#endregion

func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
