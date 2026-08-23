extends Node2D

var chapter=1
var chapters_total=3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_chapter()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func load_chapter():
	$ColorRect/RichTextLabel.scroll_to_line(0)
	$ColorRect/RichTextLabel.text=load_text_file("res://Nokia/AppData/Roaming/Book 2/Ch/CH"+str(chapter)+".txt")

func load_text_file(file_path: String) -> String:
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file == null:
		print("Error opening file: ", file_path)
		return ""

	var content = file.get_as_text()
	return content


func _on_button_pressed() -> void:
	chapter=max(1,chapter-1)
	load_chapter()


func _on_button_2_pressed() -> void:
	chapter=min(chapters_total,chapter+1)
	load_chapter()
