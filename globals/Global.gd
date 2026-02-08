extends Node

var is_playing: bool = true

signal won
signal lost

signal warning

signal score_submitted

func _ready() -> void:
	# signals
	get_tree().scene_changed.connect(func():
		is_playing = true
	)
	
	# talo
	await Talo.players.identify("username", "DefaultPlayer")
	
	Talo.events.track("Game Started")
	
	#func _ready() -> void:
	#await Talo.players.identify("username", "DefaultPlayer")
	#
	#Talo.events.track("")
	#
	#print("Player identified!")

func start_playing():
	is_playing = true

func win():
	if !is_playing:
		return
	
	is_playing = false
	won.emit()

func lose():
	if !is_playing:
		return
	
	MusicPlayer.stop_music()
	
	is_playing = false
	lost.emit()

func warn(text: String):
	warning.emit(text)

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		Talo.events.flush()
