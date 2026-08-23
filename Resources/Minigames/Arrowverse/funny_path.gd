extends Path2D

@export_enum("Up","Down","Left","Right") var direction="Up"
@export var path_length:float=3
@export var deadzone:float=0.1
## How long is the path in seconds

signal note_dies()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ArrowDown.visible=direction=="Down"
	$ArrowLeft.visible=direction=="Left"
	$ArrowUp.visible=direction=="Up"
	$ArrowRight.visible=direction=="Right"
	note_dies.connect(cry)
func cry():
	if last_press_timer>0 and not last_press_by_player:
		fails+=1
		last_press_timer=0
	
	if last_press_timer>0 and last_press_by_player:
		local_accuracy+=0.9+(deadzone-last_press_timer)/deadzone*0.1
		last_press_timer=0
	else:
		last_press_timer=deadzone
		last_press_by_player=false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if playing:
		timer+=delta
		if total_notes==len(playing_track):
			playing=false
		else:
			while timer+path_length>playing_track[total_notes]:
				total_notes+=1
				create_new_note()
				if total_notes==len(playing_track):
					break
	if last_press_timer>0:
		last_press_timer-=delta
	if last_press_timer<0:
		fails+=1
		last_press_timer=0
				
				
	pass
var total_notes=0
var fails=0
var local_accuracy=0
var accuracy=1
@onready var note=preload("res://Resources/Minigames/Arrowverse/note.tscn")
func create_new_note():
	var new_note=note.instantiate()
	new_note.direction=direction
	new_note.total_time=path_length
	new_note.dies.connect(note_dies.emit)
	add_child(new_note)
var playing_track=[]
var timer=0
var playing=false
var last_press_by_player=false #if a note comes within deadzone of the last_press, 
var last_press_timer=0
func play(track):
	playing=true
	playing_track=track
	timer=0
	fails=0
	total_notes=0
	for ote in track:
		if ote<=path_length:
			var new_note=note.instantiate()
			new_note.dies.connect(note_dies.emit)
			
			new_note.direction=direction
			new_note.total_time=path_length
			
			add_child(new_note)
			new_note.time=ote
			new_note.progress_ratio=ote/path_length
			
			
func _input(event: InputEvent) -> void:
	if direction=="Down":
		if event.is_action_pressed("Arrow_down"):
			pressed_by_player()
	if direction=="Left":
		if event.is_action_pressed("Arrow_left"):
			pressed_by_player()
	if direction=="Right":
		if event.is_action_pressed("Arrow_right"):
			pressed_by_player()
	if direction=="Up":
		if event.is_action_pressed("Arrow_up"):
			pressed_by_player()
	
func pressed_by_player():
	if last_press_timer>0 and not last_press_by_player:
		local_accuracy+=0.9+(deadzone-last_press_timer)/deadzone*0.1
		last_press_timer=0
	elif last_press_by_player and last_press_timer>0:
		fails+=1
		last_press_timer=0
	else:
		last_press_timer=deadzone
		last_press_by_player=true
			
