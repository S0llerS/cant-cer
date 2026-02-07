class_name Upgrades
extends Control

var player: Player

@onready var cards_container: HBoxContainer = %CardsContainer

@export var upgrade_cards: Array[PackedScene]

var can_select_card: bool = false

func show_cards():
	# return if no cards
	if upgrade_cards.is_empty():
		return
	
	# clean up
	for card in cards_container.get_children():
		card.queue_free()
	
	# select random card
	var available_cards = upgrade_cards.duplicate()
	for i in range(min(3, available_cards.size())):
		var index = randi_range(0, available_cards.size() - 1)
		var card = available_cards[index]
	
		# add random card
		var instance: Upgrade = card.instantiate()
		cards_container.add_child(instance)
		
		# setup
		instance.upgrades = self
		instance.id = card
		
		# remove card
		available_cards.remove_at(index)
	
	# final
	can_select_card = true
	visible = true
	
	get_tree().paused = true

func select_card(id, stats_upgrade: Dictionary):
	# return if cannot select an upgrade card
	if !can_select_card:
		return
	
	# increase player stats
	for stat in stats_upgrade:
		if player.player_stats.get(stat):
			player.player_stats.set(stat, player.player_stats.get(stat) + stats_upgrade[stat])
			
			print(stat, " applied! Current value: ", player.player_stats.get(stat))
	
	# apply player stats
	player.apply_stats()
	
	# remove the card
	upgrade_cards.erase(id)
	
	# final
	can_select_card = false
	visible = false
	
	get_tree().paused = false
