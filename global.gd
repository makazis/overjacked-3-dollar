extends Node

var money=300.00:
	set(value):
		for i in money_multipliers:
			value*=i
		money+=value
var money_multipliers=[1]
var time=0
var timer_running=true
var timer_multiplier=1 
var time_acceleration=1 #good luck figuring out which one does what you fucker. 
#also high value means time is accelerated more
# Called when the node enters the scene tree for the first time.

var clothes:Array[Clothing]=[]

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time+=delta*int(timer_running)*timer_multiplier #convert from bool to int for that extra spice. 
