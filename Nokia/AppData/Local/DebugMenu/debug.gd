extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ColorRect/ScrollContainer/VBoxContainer/Panel/LineEdit.placeholder_text=str(Global.money)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_line_edit_text_submitted(new_text: String) -> void:
	Global.money=float(new_text)
