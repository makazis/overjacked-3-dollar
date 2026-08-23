extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if recording or replaying:
		timer+=delta
		$Button.visible=false
		$Button2.visible=false
	else:
		$Button.visible=true
		$Button2.visible=true
	$Label.text="Fails: "+str($"Funny Path".fails)
	$Label2.text="Fails: "+str($"Funny Path2".fails)
	$Label3.text="Fails: "+str($"Funny Path3".fails)
	$Label4.text="Fails: "+str($"Funny Path4".fails)
	
var recording=false
var timer=0
var inputs=[0.06, 0.48, 1.14, 2.22, 2.58, 5.4]



var inputs_2=[0.84, 3.06, 3.42, 4.38, 4.8, 5.1, 5.52] #right
var inputs_3=[1.68, 3.6] #up
var inputs_4=[1.92, 3.84] #down
var counter_2=0
var counter_3=0
var counter_4=0
var counter=0
var replaying=false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Arrow_left"):
		if recording:
			inputs.append(timer)
	if event.is_action_pressed("Arrow_right"):
		if recording:
			inputs_2.append(timer)
	if event.is_action_pressed("Arrow_up"):
		if recording:
			inputs_3.append(timer)
	if event.is_action_pressed("Arrow_down"):
		if recording:
			inputs_4.append(timer)
			


func _on_audio_stream_player_finished() -> void:
	if recording:
		recording=false
	if replaying:
		replaying=false


func _on_button_pressed() -> void:
	$AudioStreamPlayer.play()
	recording=true
	timer=0
	inputs=[]
	


func _on_button_2_pressed() -> void:
	$AudioStreamPlayer.play()
	replaying=true
	timer=0
	counter=0
	$"Funny Path".play(inputs)
	$"Funny Path2".play(inputs_2)
	$"Funny Path3".play(inputs_3)
	$"Funny Path4".play(inputs_4)
	


func _on_funny_path_note_dies() -> void:
	if replaying:
		pass
		#$AudioStreamPlayer2.play()
