extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	random_calls()
	#_on_audio_stream_player_finished()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if i_will_hang_up_in>0:
		i_will_hang_up_in-=delta
	if i_will_hang_up_in<0:
		i_will_hang_up_in=0
		$"Hangs The Fuck Up".play()

func random_calls():
	$AudioStreamPlayer.play()
	$Button.visible=true
	can_ring_again=true
	

var can_ring_again=true
var i_will_hang_up_in=0
func _on_audio_stream_player_finished() -> void:
	$Button.visible=false
	$Timer.start()
	


func _on_button_pressed() -> void:
	$Button.visible=false
	can_ring_again=false
	$AudioStreamPlayer.stop()
	$"Part 1/Recording".play()
	


func _on_button_3_pressed() -> void:
	$"Part 1/Button".visible=false
	$"Part 1/Button2".visible=false
	$"Part 1/Button3".visible=false
	$"Part 1/Button3/Recording(2)".play()
	i_will_hang_up_in=0
	await get_tree().create_timer(40).timeout
	$"Hangs The Fuck Up".play()
	can_ring_again=true


func _on_recording_finished() -> void:
	i_will_hang_up_in=randi_range(20,randi_range(40,60))
	$"Part 1/Button".visible=true
	$"Part 1/Button2".visible=true
	$"Part 1/Button3".visible=true
	


func _on_button_2_pressed() -> void:
	$"Wifi/Recording(6)".play()
	$"Part 1/Button".visible=false
	$"Part 1/Button2".visible=false
	$"Part 1/Button3".visible=false


func _on_recording_6_finished() -> void:
	$Wifi/Button.visible=true
	$Wifi/Button2.visible=true
	


func Wifi_button_2() -> void:
	$Wifi/Button.visible=false
	$Wifi/Button2.visible=false
	$"Hangs The Fuck Up".play()
	

func WifiButton1() -> void:
	$Wifi/Button.visible=false
	$Wifi/Button2.visible=false
	can_ring_again=true
	i_will_hang_up_in=0
	if Global.money<16.99:
		$Wifi/LoudIncorrectBuzzer.play()
		
		return
	Global.money-=16.99
	


func _on_loud_incorrect_buzzer_finished() -> void:
	$"Hangs The Fuck Up".play()


func _on_timer_timeout() -> void:
	if can_ring_again:
		random_calls()
	else:
		$Timer.start()


func _on_hangs_the_fuck_up_finished() -> void:
	can_ring_again=true
	$Timer.start()
