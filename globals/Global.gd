extends Node

signal score_submitted

func _ready() -> void:
	await Talo.players.identify("username", "DefaultPlayer")
	
	Talo.events.track("Game Started")
	
	#func _ready() -> void:
	#await Talo.players.identify("username", "DefaultPlayer")
	#
	#Talo.events.track("")
	#
	#print("Player identified!")

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		Talo.events.flush()
