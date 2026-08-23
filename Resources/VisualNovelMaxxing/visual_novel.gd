@tool
class_name VisualNovel extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.visual_novel=self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
@export var path:VNPath=null
var displayed_text=""
@onready var options_button=preload("res://Resources/VisualNovelMaxxing/Option.tscn")
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left click"):
		pass
