extends Control

@onready var dlabel=$Untitled/DialogueLabel
var dialogue_resource=null
signal chose_response(response_id:int)
var is_listening=false
var loaded_dialogue_resource=null
var showing_responses=false
func next_dialogue_resource(next_id=null):
	if loaded_dialogue_resource==null:
		loaded_dialogue_resource=dialogue_resource
		if loaded_dialogue_resource==null:
			return
	if dlabel.dialogue_line==null:
		dlabel.dialogue_line=await loaded_dialogue_resource.get_next_dialogue_line("start")
	else:
		if next_id==null:
			dlabel.dialogue_line=await loaded_dialogue_resource.get_next_dialogue_line(dlabel.dialogue_line.next_id)
		else:
			dlabel.dialogue_line=await loaded_dialogue_resource.get_next_dialogue_line(next_id)
	if dlabel.dialogue_line==null:
		queue_free()
		return
	$Untitled/Label.text=dlabel.dialogue_line.character
	#print(dlabel.dialogue_line)
	if len(dlabel.dialogue_line.responses)>0:
		for response in len(dlabel.dialogue_line.responses):
			$Options.get_child(response).visible=true
			$Options.get_child(response).get_child(0).text=dlabel.dialogue_line.responses[response].text
			if !dlabel.dialogue_line.responses[response].is_allowed:
				$Options.get_child(response).modulate=Color(1.0, 0.0, 0.0, 1.0)
			else:
				$Options.get_child(response).modulate=Color(1.0, 1.0, 1.0, 1.0)
		showing_responses=true
	elif get_tree()!=null:
		dlabel.type_out()
func _on_button_pressed() -> void:
	if showing_responses:
		return
	if dlabel.is_typing:
		dlabel.skip_typing()
	else:
		next_dialogue_resource()
func _input(event: InputEvent) -> void:
	if is_listening:
		if event.is_action_pressed("DIALOGUE NEXT"):
			_on_button_pressed()

func handle_response_clicked():
	for child in $Options.get_children():
		child.visible=false
	showing_responses=false
		
func start_dialogue(resource):
	dialogue_resource=resource
	next_dialogue_resource()
	
func response_1() -> void:
	handle_response_clicked()
	if len(dlabel.dialogue_line.responses)>0:
		next_dialogue_resource(dlabel.dialogue_line.responses[0].next_id)
	pass # Replace with function body.


func response_2() -> void:
	handle_response_clicked()
	if len(dlabel.dialogue_line.responses)>0:
		next_dialogue_resource(dlabel.dialogue_line.responses[1].next_id)
	pass # Replace with function body.


func response_3() -> void:
	handle_response_clicked()
	if len(dlabel.dialogue_line.responses)>0:
		next_dialogue_resource(dlabel.dialogue_line.responses[2].next_id)
	pass # Replace with function body.


func response_4() -> void:
	handle_response_clicked()
	if len(dlabel.dialogue_line.responses)>0:
		next_dialogue_resource(dlabel.dialogue_line.responses[3].next_id)
	pass # Replace with function body.


func response_5() -> void:
	handle_response_clicked()
	if len(dlabel.dialogue_line.responses)>0:
		next_dialogue_resource(dlabel.dialogue_line.responses[4].next_id)
	pass # Replace with function body.


func response_6() -> void:
	handle_response_clicked()
	if len(dlabel.dialogue_line.responses)>0:
		next_dialogue_resource(dlabel.dialogue_line.responses[5].next_id)
	pass # Replace with function body.


func response_7() -> void:
	handle_response_clicked()
	if len(dlabel.dialogue_line.responses)>0:
		next_dialogue_resource(dlabel.dialogue_line.responses[6].next_id)
	pass # Replace with function body.


func response_8() -> void:
	handle_response_clicked()
	if len(dlabel.dialogue_line.responses)>0:
		next_dialogue_resource(dlabel.dialogue_line.responses[7].next_id)
	pass # Replace with function body.


func response_9() -> void:
	handle_response_clicked()
	if len(dlabel.dialogue_line.responses)>0:
		next_dialogue_resource(dlabel.dialogue_line.responses[8].next_id)
	pass # Replace with function body.


func response_10() -> void:
	handle_response_clicked()
	if len(dlabel.dialogue_line.responses)>0:
		next_dialogue_resource(dlabel.dialogue_line.responses[9].next_id)
	pass # Replace with function body.


func response_11() -> void:
	handle_response_clicked()
	if len(dlabel.dialogue_line.responses)>0:
		next_dialogue_resource(dlabel.dialogue_line.responses[10].next_id)
	pass # Replace with function body.
