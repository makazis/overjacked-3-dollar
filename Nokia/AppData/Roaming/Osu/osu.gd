extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	total_fails=$"Node2D/Funny Path".fails+$"Node2D/Funny Path2".fails+$"Node2D/Funny Path3".fails+$"Node2D/Funny Path4".fails
	total_notes_hit=$"Node2D/Funny Path".total_notes+$"Node2D/Funny Path2".total_notes+$"Node2D/Funny Path3".total_notes+$"Node2D/Funny Path4".total_notes
	var money_gained=total_notes_hit-total_fails*1.1
	if money_gained<0:
		money_gained=floor(money_gained)/100
	else:
		money_gained=floor(pow(money_gained,1.8)*0.28)/100
	$Label.text=Global.convert_to_cash(money_gained)


var tracks=[
	[
		[0.75, 3.3, 4.65, 4.95, 5.25, 5.55, 5.85, 6.15, 6.45, 7.5, 7.8, 8.1, 8.4, 8.7, 9.15, 9.45, 9.6, 10.05, 10.2, 10.5, 10.65, 12.0, 12.3, 12.6, 13.8, 15.75, 17.55, 18.3, 18.9, 19.5, 20.1, 20.4, 20.7, 20.85, 21.0, 21.45, 21.9, 22.05, 22.35, 22.5, 22.65, 22.8, 22.95, 23.25, 23.4, 23.55, 23.85, 24.0, 24.45, 24.6, 24.75, 25.2, 25.8, 25.95, 26.25, 26.4, 26.55, 26.85, 27.15, 27.45, 27.9, 28.2, 28.5, 28.8, 28.95, 29.25, 29.55, 29.85, 30.3, 30.6, 30.75, 31.05, 31.35, 31.5, 31.65, 32.1, 32.55, 32.7, 33.0, 33.3, 33.6, 33.9, 34.05, 34.35, 34.5, 34.65, 34.8, 34.95, 35.25, 35.4, 35.7, 36.0, 36.3, 36.75, 37.05, 37.35, 37.65, 37.95, 38.25, 38.55, 38.85, 39.15, 39.45, 39.9, 40.2, 40.5],
		[0.3, 0.45, 1.2, 1.5, 1.8, 2.55, 2.7, 2.85, 4.35, 4.5, 6.6, 6.75, 7.2, 7.95, 8.55, 8.85, 10.8, 10.95, 11.7, 13.2, 13.5, 13.95, 14.4, 14.7, 15.45, 16.35, 16.8, 19.05, 19.65, 20.7, 21.3, 21.6, 21.9, 22.2, 22.5, 23.25, 23.7, 24.0, 24.15, 24.75, 24.9, 25.05, 25.5, 25.65, 26.1, 26.25, 27.15, 27.6, 27.75, 28.5, 29.1, 29.4, 29.7, 30.0, 30.3, 30.9, 31.2, 31.5, 31.95, 32.4, 32.55, 33.15, 33.45, 34.2, 34.35, 34.95, 35.4, 35.7, 36.0, 36.3, 37.05, 37.65, 38.25, 38.55, 38.85, 39.3, 39.9, 40.5],
		[0.6, 0.9, 1.65, 1.95, 2.4, 3.75, 3.9, 4.05, 4.8, 5.1, 5.4, 5.7, 6.0, 6.3, 6.9, 7.05, 7.35, 7.65, 8.25, 9.0, 11.1, 11.25, 11.7, 12.0, 12.3, 12.6, 12.9, 13.65, 14.1, 15.0, 15.6, 16.95, 17.25, 18.0, 18.15, 18.3, 18.45, 18.6, 18.75, 18.9, 19.2, 19.5, 20.4, 20.55, 21.15, 21.45, 21.75, 23.55, 23.85, 24.15, 24.3, 24.6, 25.2, 25.95, 26.1, 26.55, 27.0, 27.45, 27.6, 27.75, 28.35, 28.65, 28.8, 28.95, 29.55, 29.85, 30.3, 30.6, 31.05, 31.8, 32.25, 32.4, 32.85, 33.3, 33.6, 33.9, 34.5, 34.8, 36.45, 36.75, 37.95, 39.15, 39.9, 40.2],
		[2.1, 2.25, 3.15, 4.2, 9.3, 9.75, 11.4, 12.15, 12.45, 12.75, 13.05, 13.35, 14.55, 14.85, 15.15, 15.9, 16.2, 16.65, 17.1, 17.85, 19.35, 20.55, 21.0, 21.6, 22.05, 22.2, 22.65, 22.8, 22.95, 23.4, 24.3, 24.45, 24.75, 24.9, 25.05, 25.5, 25.65, 26.4, 27.0, 27.3, 27.9, 28.2, 28.8, 29.25, 29.4, 29.7, 30.0, 30.75, 30.9, 31.2, 31.35, 31.65, 31.95, 32.1, 32.25, 32.7, 32.85, 33.45, 33.75, 34.05, 34.65, 35.1, 35.25, 35.7, 36.0, 37.35, 38.25, 38.55, 38.85, 39.3, 40.2]
	]
]
var total_fails=0
var total_notes_hit=0
var playing=false

func _on_button_pressed() -> void:
	if Global.money<0.2:
		return
	Global.money-=0.2
	$"Node2D/Funny Path".play(tracks[0][0])
	$"Node2D/Funny Path2".play(tracks[0][1])
	$"Node2D/Funny Path3".play(tracks[0][2])
	$"Node2D/Funny Path4".play(tracks[0][3])
	$AudioStreamPlayer.play()
	$Timer.start()
	total_fails=0
	total_notes_hit=0
	$Button.visible=false
	$Label.visible=true

func _on_timer_timeout() -> void:
	$AudioStreamPlayer.stop()
	$Label.visible=false
	$Button.visible=true
