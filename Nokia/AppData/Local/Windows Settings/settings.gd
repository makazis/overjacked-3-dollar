extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ScrollContainer/VBoxContainer/Panel/MusicVolume.value=Phone.music_volume
	$"ScrollContainer/VBoxContainer/Panel/SFX Volume".value=Phone.sfx_volume
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_sfx_volume_value_changed(value: float) -> void:
	Phone.sfx_volume=$"ScrollContainer/VBoxContainer/Panel/SFX Volume".value


func _on_music_volume_value_changed(value: float) -> void:
	Phone.music_volume=$ScrollContainer/VBoxContainer/Panel/MusicVolume.value


func _on_foxy_jumpscare_meter_value_changed(value: float) -> void:
	pass # Replace with function body.
