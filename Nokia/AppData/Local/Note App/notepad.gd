extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ColorRect/TextEdit.text=Phone.notepad_text

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_text_edit_text_changed() -> void:
	Phone.notepad_text=$ColorRect/TextEdit.text
