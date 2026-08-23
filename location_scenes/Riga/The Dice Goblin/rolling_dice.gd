extends Node2D

var dice=[4,6,8,12,20,100]
var payouts=[5,40,100,1_000,3_000,100_000]
var costs=[1,5,10,50,100,200]
var selected_dice=0

var current_roll=0
var rolling_for=0
var lock_input=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_selected_dice()


func _process(delta: float) -> void:
	if rolling_for>0:
		rolling_for-=delta
		if 1/(randf()+0.000001)/Global.time_acceleration<rolling_for:
			current_roll=randi_range(1,dice[selected_dice])
		$Label6.visible=true
		$Label6.text="You rolled a: "+str(current_roll)
		$ColorRect.visible=true
	elif rolling_for<0:
		rolling_for=0
		if current_roll==dice[selected_dice]:
			Global.earn_money(payouts[selected_dice])
		lock_input=false
		$ColorRect.visible=false
func update_selected_dice():
	$Label2.text="Selected dice: d"+str(dice[selected_dice])+"\npayout: "+str(payouts[selected_dice])+"\ncost: "+str(costs[selected_dice])
	
func roll() -> void:
	if Global.money<costs[selected_dice]:
		return
	Global.money-=costs[selected_dice]
	if lock_input: #fuck y'all nesters, i'm a never nester
		return
	lock_input=true
	rolling_for=randi_range(1,randi_range(1,5))/Global.time_acceleration
	current_roll=randi_range(1,dice[selected_dice])
	#trust

func _on_button_3_pressed() -> void:
	if lock_input:
		return
	selected_dice=max(0,selected_dice-1)
	update_selected_dice()

func _on_button_2_pressed() -> void:
	if lock_input:
		return
	selected_dice=min(5,selected_dice+1)
	update_selected_dice()


func go_home() -> void:
	Global.what_map_am_i_on="Riga"
	get_tree().change_scene_to_file("res://Resources/MapMaxxing/GraphMaps/Riga/RigaMap.tscn")


func _on_drip_buttn_pressed() -> void:
	get_tree().change_scene_to_file("res://location_scenes/Drip Store/looking_dapper.tscn")


func _on_audio_stream_player_finished() -> void:
	if randf()<0.1:
		$Shitmusic.play()
	else:
		$EpicHexcore.play()
