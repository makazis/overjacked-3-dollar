extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var answers=[
		"It is certain",
		"It is decidedly so",
		"Without a doubt",
		"Yes definetly",
		"You may rely on it",
		"As I see it, yes",
		"Most likely",
		"Outlook good",
		"Yes",
		"Signs point to yes",
		"Reply hazy, try again",
		"Shake harder",
		"Ask again later",
		"Cannot predict now",
		"Better not tell you now",
		"Concentrate and ask again",
		"Kill yourself",
		"Don't count on it",
		"My reply is no",
		"My sources say no",
		"Very doubtful",
		"Outlook not so good",
		"You don't want to know the answer",
		"Balls (please laugh)",
		"...",
		"What. The. Fuck.",
		"Huh?",
		"Ask again when you're a little... richer",
		"My mom said yeah",
		"My dad said nuh-uh",
		"*Laughs.* Oh you're serious",
		"pinky promise you won't tell anyone?",
		"Fuck nahh",
		"Fuck yeah",
		"Hell yeah",
]
func _on_line_edit_text_submitted(new_text: String) -> void:
	$RichTextLabel.text=""
	Phone.shake_phone.emit(randf_range(1.2,3))
	await get_tree().create_timer(4).timeout
	var t=answers.pick_random()
	
	for i in t:
		$RichTextLabel.text+=i
		await get_tree().create_timer(0.04).timeout
