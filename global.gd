extends Node
#region misc global functions
func romanify(num:int):
	var output=""
	for i in range(13):
		while num>=[1000,900,500,400,100,90,50,40,10,9,5,4,1][i]:
			num-=[1000,900,500,400,100,90,50,40,10,9,5,4,1][i]
			output+=["M","CM","D","CD","C","XC","L","XL","X","IX","V","IV","I"][i]
	return output
func open_link(link:String):
	OS.shell_open(link)
#endregion
#region money handling
var money=30000.00
	
func earn_money(amount:float,affected_by_multipliers=true): 
	if affected_by_multipliers:
		for i in money_multipliers:
			amount*=i
	money+=amount
func convert_to_cash(a:float):
	var b=str(a)
	if b[-2]==".":
		b+="0"
	b+="$"
	return b
var money_multipliers=[1]
var last_money_popup=null
signal make_money_popup(how_much_money:int,reason:String)
#endregion 
#region time travel
var time=0
var timer_running=true
var timer_multiplier=1 
var time_acceleration=1 #good luck figuring out which one does what you fucker. 
#also high value means time is accelerated more
#endregion
#region clothing code
var clothes:Array[Clothing]=[]
var equipped_clothes={
	"Hat":null,
	"Overclothes":null,
	"Shirt":null,
	"Pants":null,
	"Underwear":null,
	"Shoes":null,
	"Bag":null
}

var aura=0
var official=0
var cute=0
var last_selected_clothing:Clothing=null

func calculate_clothes():
	aura=0
	official=0
	cute=0
	for i in clothes:
		if i.equipped:
			aura+=i.aura
			cute+=i.cute
			official+=i.official
	clear_clothing_sets()
	check_clothing_sets()
	money_multipliers[0]=max(aura,official,cute)/50.+1
@onready var achievable_clothes={
	"Fisherman's Hat":preload("res://Resources/Clothes/Achievement Clothes/Fisherman's Hat.tscn"),
	"God Gamer Trophy":preload("res://Resources/Clothes/Achievement Clothes/God Gamer Trophy.tscn")
}
func achieve_clothes(cloth_name):
	for i in clothes:
		if i.clothing_name==cloth_name:
			return
	var new_cloth=achievable_clothes[cloth_name].instantiate()
	clothes.append(new_cloth)
	get_tree().get_root().add_child(new_cloth)
	new_cloth.visible=false
	
var clothing_sets={
	"Nugget Enjoyer":["You get 3 more dino nuggets"],
	"Ergonomic Gamer":["","","Your cuteness increases by 15%","You are allowed into Poland","Your cuteness increases by 15%","You unlock the god gamer trophy"],
}
func clear_clothing_sets():
	max_fish_lives=1
var sets_worn={}
var set_bonuses=""
func check_clothing_sets():
	sets_worn={}
	for i in clothing_sets:
		sets_worn[i]=0
	set_bonuses=""
	for i in equipped_clothes:
		if equipped_clothes[i]!=null:
			#print(i," ",equipped_clothes[i].set_name," ",sets_worn)
			if equipped_clothes[i].set_name!="":	
				sets_worn[equipped_clothes[i].set_name]+=1
	#print(sets_worn)
	if sets_worn["Nugget Enjoyer"]>=1:
		max_fish_lives+=3
	if sets_worn["Ergonomic Gamer"]>=3:
		cute*=1.15
	if sets_worn["Ergonomic Gamer"]>=5:
		cute*=1.15
	if sets_worn["Ergonomic Gamer"]>=6:
		achieve_clothes("God Gamer Trophy")
	
	for i in sets_worn:
		for ii in range(len(clothing_sets[i])):
			
			if clothing_sets[i][ii]!="":
				if sets_worn[i]>=ii+1:
					set_bonuses+="\n"+i+" "+romanify(ii+1)+": "+clothing_sets[i][ii]
	if len(set_bonuses)>0:
		set_bonuses="Set Bonuses:"+set_bonuses
#endregion
#region map movement n shit
var where_am_i:GraphPoint=null
var on_map_where_am_i={
	"Global":"Livonia",
	"Riga":"House",
	"London":"Alleyway"
}
var what_map_am_i_on="Riga"
func try_to_go_here(where:GraphPoint):
	for i in where_am_i.connected_with:
		if i.connects_to==where:
			if i.check():
				i.affect()
				i.connects_to.go_here()
				#print("I'm going to "+where.name)
				break
var map_paths={
	"Global":"res://Resources/MapMaxxing/Map.tscn",
	"Riga":"res://Resources/MapMaxxing/GraphMaps/Riga/RigaMap.tscn",
	"London":"res://location_scenes/London/LondonMap.tscn",
}
var all_locations=[
	"res://location_scenes/General/buss_scenes/buss_scene_1.tscn",
	"res://location_scenes/Riga/Carnikava/Carnikava.tscn",
	"res://location_scenes/Riga/Home/root.tscn",
	"res://location_scenes/Riga/Home/wardrobe.tscn",
	"res://location_scenes/Riga/Hospital/Waiting Room.tscn",
	"res://location_scenes/Riga/Phone House/Phone House.tscn",
	"res://location_scenes/Riga/Poor Man's Pond/poor_man's_pond.tscn",
	"res://location_scenes/Riga/Soup Store/soup store.tscn",
	"res://location_scenes/Riga/Soup Store/fishing_in_backrooms.tscn",
	"res://location_scenes/Riga/The Dice Goblin/rolling dice.tscn",
]

func return_to_map():
	transition_to_scene(map_paths[what_map_am_i_on])
	#get_tree().change_scene_to_file()
@onready var transitioner=preload("res://Resources/Even I Don't Know/Transition.tscn")
func transition_to_scene(scene_path):
	
	var new_trans=transitioner.instantiate()
	add_child(new_trans)
	await new_trans.dies
	get_tree().change_scene_to_file(scene_path)
	print(scene_path)
#endregion
#region combat
var pre_combat_scene=""
func start_combat(_enemies):
	EffectContext.enemies=_enemies
	is_combat_going=true
	transition_to_scene("res://Resources/CardMaxxing/Combat/root.tscn")
var is_combat_going=false
func resolve_combat():
	transition_to_scene(pre_combat_scene)
var player_all_cards={
	"Strike":14,
	"Defend":14,
}
var card_database={
	"Strike":load("res://Resources/CardMaxxing/Card Data/John Politiican/strike.tres"),
	"Defend":load("res://Resources/CardMaxxing/Card Data/John Politiican/defend.tres"),
}
var player_decks=[
	{"Strike":7,"Defend":8},
]
var player_deck_selected=0
#endregion
#region locations
var action="":
	set(value):
		action=value
		if value=="Donate Blood":
			can_donate_blood=false
			get_tree().change_scene_to_file("res://location_scenes/Riga/Hospital/Waiting Room.tscn")
			money+=30
			await get_tree().create_timer(0.1).timeout
			make_money_popup.emit.call_deferred(3000,"From The Vampires")
		if value=="":
			return_to_map()
#region hospital (Riga)
var hospital_number=1
var your_hospital_number=0
var can_donate_blood=true
#endregion
#region fish minigame
var max_fish_lives=1
var fish_lives=1
var extra_fish_lives=0
#endregion
#endregion
#region ready
func _ready() -> void:
	print("Get ready to suffer")
	what_map_am_i_on=str(get_tree().root.get_children()[-1].name)
	EffectContext.combat_ends.connect(resolve_combat)

	pass # Replace with function body.
#endregion
#region process
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time+=delta*int(timer_running)*timer_multiplier #convert from bool to int for that extra spice. 
	if randf()<delta: #Will trigger on average once per second
		#random ticker
		if randi_range(0,8)==0:
			hospital_number+=1
#endregion
