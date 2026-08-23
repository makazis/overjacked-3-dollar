extends Node2D


# Called when the node enters the scene tree for the first time.
@onready var app=preload("res://Nokia/AppData/System32/App.tscn")
func refresh_apps():
	for i in $"PhoneControl/App Screen/ScrollContainer/GridContainer".get_children():
		$"PhoneControl/App Screen/ScrollContainer/GridContainer".remove_child(i)
	for _app in Phone.apps:
		var new_app=app.instantiate()
		new_app.setup(_app)
		$"PhoneControl/App Screen/ScrollContainer/GridContainer".add_child(new_app)
func _ready() -> void:
	refresh_apps()
	Phone.apps_changed.connect(refresh_apps)
	Phone.open_app.connect(open_app)

@onready var app_lib={
	"Settings":preload("res://Nokia/AppData/Local/Windows Settings/settings.tscn"),
	"App Store":preload("res://Nokia/AppData/Local/App Store/App Store.tscn"),
	"Book 2":preload("res://Nokia/AppData/Roaming/Book 2/book_2.tscn"),
	"Hopital App":preload("res://Nokia/AppData/Roaming/Hopital App/hopital_app.tscn"),
	"Whatsapp":preload("res://Nokia/AppData/Local/Whatsapp/whatsapp.tscn")
}
var app_cache={}
func open_app(app_name:String):
	if not app_name in app_lib:
		return
	go_to_screen("Using App")
	
	if not app_name in app_cache:
		var using_app=app_lib[app_name].instantiate()
		using_app.position=Vector2(366,768)
		
		app_cache[app_name]=using_app
		$PhoneControl/CachedApps.add_child(using_app)
	
	for i in $PhoneControl/CachedApps.get_children():
		i.visible=(i.name==app_name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func update_time():
	var hours=str(int(Global.time/3600.))
	if len(hours)==1:
		hours="0"+hours
	var minutes=str(int(Global.time/60.)%60)
	if len(minutes)==1:
		minutes="0"+minutes
	var seconds=str(int(Global.time)%60)
	if len(seconds)==1:
		seconds="0"+seconds
	$"PhoneControl/Lock Screen/Label".text=hours+":"+minutes+":"+seconds
	$"PhoneControl/Lock Screen/Money".text=str(round(Global.money*100)/100.)
	if $"PhoneControl/Lock Screen/Money".text[-2]==".":
		$"PhoneControl/Lock Screen/Money".text+="0"
	$"PhoneControl/Lock Screen/Money".text+="$"
func update_app_time():
	var hours=str(int(Global.time/3600.))
	if len(hours)==1:
		hours="0"+hours
	var minutes=str(int(Global.time/60.)%60)
	if len(minutes)==1:
		minutes="0"+minutes
	var seconds=str(int(Global.time)%60)
	if len(seconds)==1:
		seconds="0"+seconds
	$Time.text=hours+":"+minutes+":"+seconds
	$Money.text=str(round(Global.money*100)/100.)
	if $Money.text[-2]==".":
		$Money.text+="0"
	$Money.text+="$"
func _process(delta: float) -> void:
	if current_screen=="Lock Screen":
		update_time()
	else:
		update_app_time()
	
var screens={
	"Lock Screen":Vector2(0,0),
	"App Screen":Vector2(0,1),
	"Using App":Vector2(1,1)
}
var current_screen="Lock Screen"
func go_to_screen(screen_name,take_time=true):
	current_screen=screen_name
	if !take_time:
		$PhoneControl.position=-screens[screen_name]*Vector2(366,768)
	else:
		var ctween=create_tween()
		ctween.tween_property($PhoneControl,'position',-screens[screen_name]*Vector2(366,768),0.3)
		await ctween.finished
func _on_button_pressed() -> void:
	go_to_screen("App Screen")


func _go_home() -> void:
	go_to_screen("App Screen")
