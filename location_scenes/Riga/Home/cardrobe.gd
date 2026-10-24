extends Node2D
#the scene where the player can edit their deck of cards. 

var loaded_cards={}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for card_name in Global.player_all_cards:
		var card=Card.new(Global.card_database[card_name])
		card.scale=Vector2(0.5,0.5)
		var count=Global.player_all_cards[card_name]
		if card_name in Global.player_decks[Global.player_deck_selected]:
			count-=Global.player_decks[Global.player_deck_selected][card_name]
		if count==0:
			$Marker2D.add_child(card)
		else:
			$ScrollContainer/GridContainer.add_child(card)
		card._layout.count=count
		
		card.refresh_layout()
		loaded_cards[card_name]=card
	
	CombatData.card_interaction.connect(add_card)
	CombatData.card_selector_interaction.connect(remove_card)
	update_deck()
var timer=0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Button3.visible=cards_in_deck>=15
	$Label.visible=!$Button3.visible
@onready var cselector=preload("res://location_scenes/Riga/Home/CardSelector.tscn")
var cards_in_deck=0
func update_deck():
	cards_in_deck=0
	for cardSelector in $CardsInDeck/VBoxContainer.get_children():
		cardSelector.queue_free()
	for card in Global.player_decks[Global.player_deck_selected]:
		var _cselector=cselector.instantiate()
		_cselector.card_name=card
		_cselector.count=Global.player_decks[Global.player_deck_selected][card]
		_cselector.update_name()
		$CardsInDeck/VBoxContainer.add_child(_cselector)
		cards_in_deck+=Global.player_decks[Global.player_deck_selected][card]
func add_card(card:Card):
	if not card.card_data.card_name in Global.player_decks[Global.player_deck_selected]:
		Global.player_decks[Global.player_deck_selected][card.card_data.card_name]=1
	else:
		Global.player_decks[Global.player_deck_selected][card.card_data.card_name]+=1
	card._layout.count-=1
	cards_in_deck+=1
	card.refresh_layout()
	if card._layout.count==0:
		$ScrollContainer/GridContainer.remove_child(card)
		$Marker2D.add_child(card)
	update_deck()

func remove_card(card_selector):
	card_selector.count-=1
	card_selector.update_name()
	if card_selector.count==0:
		card_selector.queue_free()
	Global.player_decks[Global.player_deck_selected][card_selector.card_name]-=1
	loaded_cards[card_selector.card_name]._layout.count+=1
	loaded_cards[card_selector.card_name].refresh_layout()
	if loaded_cards[card_selector.card_name].get_parent()==$Marker2D:
		$Marker2D.remove_child(loaded_cards[card_selector.card_name])
		$ScrollContainer/GridContainer.add_child(loaded_cards[card_selector.card_name])
	cards_in_deck-=1


func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://location_scenes/Riga/Home/root.tscn")
