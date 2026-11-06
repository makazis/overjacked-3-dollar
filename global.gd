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
var money=3.00
	
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
	"Riga-Limbo":"The World Above",
	"London":"Alleyway",
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
	"Riga-Limbo":"res://location_scenes/Riga/Limbo/hell.tscn"
}
var movement_flags={
	"Defeated John Politician":true,
	"Hell Unlocked":false,
	"In Hell":false
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
#endregion
#region combat
var combat_unlocked=false
var enemies_defeated=[]
var pre_combat_scene=""
func start_combat(_enemies):
	if combat_unlocked==false:
		EffectContext.won=false
		return
	EffectContext.enemies=_enemies
	is_combat_going=true
	transition_to_scene("res://Resources/CardMaxxing/Combat/root.tscn")
var is_combat_going=false
func resolve_combat():	
	transition_to_scene(pre_combat_scene)
	might_be_a_good_idea_to_save()
var player_all_cards={
	"Strike":14,
	"Defend":14,
}
#region card_database
var card_database={
	"Strike":load("res://Resources/CardMaxxing/Card Data/John Politiican/Strike.tres"),
	"Defend":load("res://Resources/CardMaxxing/Card Data/John Politiican/defend.tres"),
	"Four Flaming Fingers":load("res://location_scenes/Riga/Church of John/Combat/four_flaming_fingers.tres"),
	"The John Punch":load("res://location_scenes/Riga/Church of John/Combat/THE_JOHN_PUNCH_FOR_REAL.tres"),
	"Pepper Spray":load("res://Resources/CardMaxxing/Card Data/John Politiican/pepper_spray.tres"),
	"Bicycle":load("res://Resources/CardMaxxing/Card Data/John Politiican/Mounts/Bicycle/Bicycle.tres"),
	"Bulldozer":load("res://Resources/CardMaxxing/Card Data/John Politiican/Mounts/Bulldozer/Bulldozer.tres"),
	"Wooden Chair":load("res://Resources/CardMaxxing/Card Data/John Politiican/wooden_chair.tres"),
	"Molotov":load("res://Resources/CardMaxxing/Card Data/John Politiican/hell/molotov.tres"),
	"Steel Sheets":load("res://Resources/CardMaxxing/Card Data/John Politiican/Crafting/Killdozer/steel_sheets.tres"),
	"Wielder":load("res://Resources/CardMaxxing/Card Data/John Politiican/Crafting/Killdozer/wielder.tres"),
	"Sugar":load("res://Resources/CardMaxxing/Card Data/John Politiican/buy/sugar.tres"),
	"Hematogen":load("res://Resources/CardMaxxing/Card Data/John Politiican/buy/hematogen.tres"),
	"Foldable Chair":load("res://Resources/CardMaxxing/Card Data/John Politiican/buy/foldable_chair.tres"),
	"Burn™":load("res://Resources/CardMaxxing/Card Data/John Politiican/buy/burn energy drinks.tres"),
	"Flamethrower":load("res://Resources/CardMaxxing/Card Data/John Politiican/Crafting/Fire Truck/flamethrower.tres"),
	"Lucky Strike":load("res://location_scenes/Riga/Carnikava/lucky_strike.tres"),
}
#endregion
var player_decks=[
	{"Strike":7,"Defend":8},
]
var player_deck_selected=0
signal show_gui_card_got(card_name:String)
func player_gain_card(card_name:String=""):
	if not card_name in player_all_cards:
		player_all_cards[card_name]=1
	else:
		player_all_cards[card_name]+=1
	show_gui_card_got.emit(card_name)
#endregion
#region dialogue calls
#how do we structure a dialogue? maybe we just pass the dialogue manager thingy and just base the dialogue off of that? and just finally incorporate dialogue manager into the code. 
#yeah, that's probably the best way to do that. 
func dialogue(dialogue_data:DialogueLine,camera_root=null):
	if camera_root==null:
		pass
func d_randi_range(a:int,b:int):
	return randi_range(a,b)
	
#endregion
#region locations
#region home
var is_sleepy=true

var player_ball_knowledge_levelups=[10,30,60,100,150,210,280,360,450,550,660,780,910]
var player_ball_knowledge=0
var player_ball_knowledge_xp=0:
	set(value):
		player_ball_knowledge_xp=value
		if player_ball_knowledge<10:
			while player_ball_knowledge_xp>=player_ball_knowledge_levelups[player_ball_knowledge]:
				player_ball_knowledge_xp-=player_ball_knowledge_levelups[player_ball_knowledge]
				player_ball_knowledge+=1
var goblin_losses=0
#endregion
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
#region Church of John
var john_sells_cards={
	"Pepper Spray":2,
	"Wooden Chair":3,
	"Bicycle":1,
	"Bulldozer":1,
	"Molotov":2,
	"Flamethrower":1,
	"Steel Sheets":1,
	"Wielder":1,
	"Foldable Chair":3,
	"Hematogen":3,
	"Sugar":1,
	"Burn™":2,
}
var john_card_costs={
	"Pepper Spray":6.99,
	"Wooden Chair":3.99,
	"Bicycle":49.99,
	"Bulldozer":99.99,
	"Molotov":19.99,
	"Flamethrower":99.99,
	"Steel Sheets":19.99,
	"Wielder":39.99,
	"Foldable Chair":4.99,
	"Hematogen":1.99,
	"Sugar":39.99,
	"Burn™":1.09,
}
var john_bounties={
	"Bigfoot":false, #30
	"Chupacabra":false, #35
	"Mothman":false, #90
	"Lesser Angel":false, #120
	"Greater Angel":false, #150
	"Mongolian Death Worm":false, #70
}
#endregion
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
#endregion
#region saving
func save_data():
	var saved_data={
		"Money":money,
		"Time":time,
		"Clothes":[],
		"equipped_clothes":{},
		"omwai":on_map_where_am_i,
		"wmaio":what_map_am_i_on,
		"Movement Flags":movement_flags,
		"Combat Unlocked":combat_unlocked,
		"Enemies Defeated":enemies_defeated,
		"Player All Cards":player_all_cards,
		"john_sells_cards":john_sells_cards,
		"is_sleepy":is_sleepy,
		"player_ball_knowledge":player_ball_knowledge,
		"player_ball_knowledge_xp":player_ball_knowledge_xp,
		"can_donate_blood":can_donate_blood,
		"hospital_number":hospital_number,
		"john_bounties":john_bounties,
		#region CombatData
		"player_hp":CombatData.player_hp,
		"player_max_hp":CombatData.player_max_hp,
		#endregion
		#region Phone
		"Apps":Phone.apps,
		"Notepad Text":Phone.notepad_text,
		"music_volume":Phone.music_volume,
		"sfx_volume":Phone.sfx_volume,
		"overjacked_setting":Phone.overjacked_setting,
		"combat_settings_unlocked":Phone.combat_settings_unlocked,
		#endregion
	}
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	save_file.store_line(JSON.stringify(saved_data))
var asked_to_load_data=false

func load_data():
	if not FileAccess.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	var json=JSON.new()
	var recieved_stuff=save_file.get_as_text()
	var parse_result=json.parse(recieved_stuff)
	if not parse_result == OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", save_file, " at line ", json.get_error_line())
		return
	
		# Get the data from the JSON object.
	var data = json.data
	#region Global
	money=data["Money"]
	time=data["Time"]
	on_map_where_am_i=data["omwai"]
	what_map_am_i_on=data["wmaio"]
	movement_flags=data["Movement Flags"]
	combat_unlocked=data["Combat Unlocked"]
	enemies_defeated=data["Enemies Defeated"]
	player_all_cards=data["Player All Cards"]
	john_sells_cards=data["john_sells_cards"]
	is_sleepy=data["is_sleepy"]
	player_ball_knowledge=data["player_ball_knowledge"]
	player_ball_knowledge_xp=data["player_ball_knowledge_xp"]
	can_donate_blood=data["can_donate_blood"]
	hospital_number=data["hospital_number"]
	john_bounties=data["john_bounties"]
	#endregion
	#region CombatData
	CombatData.player_hp=data["player_hp"]
	CombatData.player_max_hp=data["player_max_hp"]
	#endregion
	#region Phone
	Phone.music_volume=data["music_volume"]
	Phone.apps=data["Apps"]
	Phone.notepad_text=data["Notepad Text"]
	Phone.sfx_volume=data["sfx_volume"]
	Phone.overjacked_setting=data["overjacked_setting"]
	Phone.combat_settings_unlocked=data["combat_settings_unlocked"]
	#endregion
	
	#print(recieved_stuff)
var time_since_last_save=0
func might_be_a_good_idea_to_save():
	if time_since_last_save>30:
		save_data()
		time_since_last_save=0
#endregion
#region Combat Functions
func deal_damage(attacker:Creature,defender:Creature,damage:int,times:int=1):
	var total_damage=damage
	if "Strength" in attacker.statuses:
		total_damage+=attacker.statuses["Strength"]
	total_damage*=times
	defender.block-=total_damage
	if defender.block<0:
		defender.hp+=defender.block
		defender.block=0
	if Phone.screen_shake_on_hitting:
		CombatData.I_NEED_MORE_SCREEN_SHAKE.emit(total_damage)
func apply_block(target:Creature,source:Creature,block:int,times:int=1):
	var gained_block=block
	if "Dexterity" in source.statuses:
		gained_block+=source.statuses["Dexterity"]
	target.block+=gained_block*times
func apply_status(target:Creature,source:Creature,_type:String,amount:int=1,times:int=1):
	if not _type in target.statuses:
		target.statuses[_type]=0
	target.statuses[_type]+=amount*times
#endregion
#region ready
func _ready() -> void:
	print("Get ready to suffer")
	
	#what_map_am_i_on="Riga"#str(get_tree().root.get_children()[-1].name)
	EffectContext.combat_ends.connect(resolve_combat)
	#load_data()
	pass # Replace with function body.
#endregion
#region process
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_since_last_save+=delta
	time+=delta*int(timer_running)*timer_multiplier #convert from bool to int for that extra spice. 
	if randf()<delta: #Will trigger on average once per second
		#random ticker
		if randi_range(0,8)==0:
			hospital_number+=1
#endregion
