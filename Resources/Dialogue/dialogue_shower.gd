extends Control

@onready var dlabel=$Untitled/DialogueLabel
var dialogue_resource=null
signal chose_response(response_id:int)
var is_listening=false
var loaded_dialogue_resource=null
var showing_responses=false
var binds=[0,0,0,0,0, 0,0,0,0,0, 0] # which button binds to which response
func next_dialogue_resource(next_id=null,start_id="start"):
	if loaded_dialogue_resource==null:
		loaded_dialogue_resource=dialogue_resource
		if loaded_dialogue_resource==null:
			return
	if dlabel.dialogue_line==null:
		dlabel.dialogue_line=await loaded_dialogue_resource.get_next_dialogue_line(start_id)
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
	var num=0
	if len(dlabel.dialogue_line.responses)>0:
		for response in len(dlabel.dialogue_line.responses):
			if dlabel.dialogue_line.responses[response].is_allowed:
				$Options.get_child(num).visible=true
				$Options.get_child(num).get_child(0).text=dlabel.dialogue_line.responses[response].text
				binds[num]=response
				num+=1
		showing_responses=true
	elif get_tree()!=null:
		dlabel.type_out()
	else:
		visible=false
		dlabel.dialogue_line=null #prepare for the next dialogue. Yipee. 
		#Although one object would benefit from having only one resource. 
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
		
func start_dialogue(resource,que="start"):
	dialogue_resource=resource
	next_dialogue_resource(null,que)
	
func response_1() -> void:
	handle_response_clicked()
	if len(dlabel.dialogue_line.responses)>0:
		next_dialogue_resource(dlabel.dialogue_line.responses[binds[0]].next_id)
	pass # Replace with function body.


func response_2() -> void:
	handle_response_clicked()
	if len(dlabel.dialogue_line.responses)>0:
		next_dialogue_resource(dlabel.dialogue_line.responses[binds[1]].next_id)
	pass # Replace with function body.


func response_3() -> void:
	handle_response_clicked()
	if len(dlabel.dialogue_line.responses)>0:
		next_dialogue_resource(dlabel.dialogue_line.responses[binds[2]].next_id)
	pass # Replace with function body.


func response_4() -> void:
	handle_response_clicked()
	if len(dlabel.dialogue_line.responses)>0:
		next_dialogue_resource(dlabel.dialogue_line.responses[binds[3]].next_id)
	pass # Replace with function body.


func response_5() -> void:
	handle_response_clicked()
	if len(dlabel.dialogue_line.responses)>0:
		next_dialogue_resource(dlabel.dialogue_line.responses[binds[4]].next_id)
	pass # Replace with function body.


func response_6() -> void:
	handle_response_clicked()
	if len(dlabel.dialogue_line.responses)>0:
		next_dialogue_resource(dlabel.dialogue_line.responses[binds[5]].next_id)
	pass # Replace with function body.


func response_7() -> void:
	handle_response_clicked()
	if len(dlabel.dialogue_line.responses)>0:
		next_dialogue_resource(dlabel.dialogue_line.responses[binds[6]].next_id)
	pass # Replace with function body.


func response_8() -> void:
	handle_response_clicked()
	if len(dlabel.dialogue_line.responses)>0:
		next_dialogue_resource(dlabel.dialogue_line.responses[binds[7]].next_id)
	pass # Replace with function body.


func response_9() -> void:
	handle_response_clicked()
	if len(dlabel.dialogue_line.responses)>0:
		next_dialogue_resource(dlabel.dialogue_line.responses[binds[8]].next_id)
	pass # Replace with function body.


func response_10() -> void:
	handle_response_clicked()
	if len(dlabel.dialogue_line.responses)>0:
		next_dialogue_resource(dlabel.dialogue_line.responses[binds[9]].next_id)
	pass # Replace with function body.


func response_11() -> void:
	handle_response_clicked()
	if len(dlabel.dialogue_line.responses)>0:
		next_dialogue_resource(dlabel.dialogue_line.responses[binds[10]].next_id)
	pass # Replace with function body.
