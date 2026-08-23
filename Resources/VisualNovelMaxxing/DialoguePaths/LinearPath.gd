class_name LinearVNPath extends VNPath

@export var text:String=""
@export var text_speed:float=0.1
@export var after:VNPath=null
var counter=0
var timer=0

func render(delta:float):
	if completed:
		return after.render(delta)
	else:
		if counter==len(text):
			if Input.is_action_just_pressed("left click"):
				completed=true
		timer-=delta
		if Input.is_action_just_pressed("left click"):
			timer-=1
		while timer<0 and counter<len(text):
			timer+=text_speed
			displayed_text+=text[counter]
			Global.visual_novel.displayed_text=displayed_text
			counter+=1
