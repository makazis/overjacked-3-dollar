extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.make_money_popup.connect(make_money_popup)
	$ColorRect.visible=true
	var tween=create_tween()
	tween.tween_property($ColorRect,'modulate',Color(1,1,1,0),0.5)
@onready var foxy_jumpscare=preload("res://Resources/Even I Don't Know/foxy_jumpscare.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func transition_to_scene(scene_name:String):
	var tween=create_tween()
	tween.tween_property($ColorRect,'modulate',Color(1,1,1,1),0.5)
	await tween.finished
	get_tree().change_scene_to_file(scene_name)
func _process(delta: float) -> void:
	if randf()<delta*10*pow(Phone.overjacked_setting/100.,6):
		var FOXY=foxy_jumpscare.instantiate()
		#print(spooked_ya)
		add_child(FOXY)
	
	if Global.money>1_000_000: #get one million money to win
		transition_to_scene("res://you_win!!!.tscn")
		#get_tree().change_scene_to_file()

@onready var money_popup=preload("res://Resources/money_popup.tscn")
func make_money_popup(money:int,reason:String):
	print(reason)
	var new_money_popup=money_popup.instantiate()
	if Global.last_money_popup==null:
		new_money_popup.position=$Marker2D.position
	else:
		new_money_popup.position=Global.last_money_popup.position+Vector2(0,30)
	Global.last_money_popup=new_money_popup
	add_child(new_money_popup)
	var a=str(money%100)
	if len(a)==1:
		a="0"+a
	new_money_popup.set_text("+"+str(int(money/100.))+"."+a+"$ "+reason)

var phone_out=false
var phone_fullscreen=false
var can_exit_to_map=true
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("map"):
		if !can_exit_to_map:
			return
		if get_tree().current_scene.has_method('on_exit'):
			get_tree().current_scene.on_exit()
		Global.return_to_map()
	if event.is_action_pressed("phone"):
		if phone_fullscreen:
			return 
		phone_out=!phone_out
		if phone_out:
			var ctween=create_tween()
			ctween.tween_property($Phone,'position',Vector2(0,142),0.1)
			await ctween.finished
		else:
			var ctween=create_tween()
			ctween.tween_property($Phone,'position',Vector2(-472,142),0.1)
			await ctween.finished
		
	if event.is_action_pressed("phone_fuilscreen"):
		if phone_out:
			phone_fullscreen=!phone_fullscreen
			if phone_fullscreen:
				var ctween=create_tween()
				ctween.set_parallel(true)
				ctween.tween_property($Phone,'position',Vector2(967,-805),0.7)
				ctween.tween_property($Phone,'rotation_degrees',72.1,0.7)
				ctween.tween_property($Phone,'scale',Vector2(1.405,1.405),0.7)
				await ctween.finished
			else:
				var ctween=create_tween()
				ctween.set_parallel(true)
				ctween.tween_property($Phone,'position',Vector2(0,142),0.7)
				ctween.tween_property($Phone,'rotation_degrees',0,0.7)
				ctween.tween_property($Phone,'scale',Vector2(0.469,0.469),0.7)
				await ctween.finished
			


func _on_video_stream_player_finished() -> void:
	$TextureRect.visible=false
