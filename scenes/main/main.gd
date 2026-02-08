class_name Main
extends Node2D

func _ready() -> void:
	#Engine.time_scale = 6.0
	
	MusicPlayer.play_music(MusicPlayer.ARCADE_STYLE_GAME)
	
	Stats.reset()
	Global.start_playing()
	
	get_tree().paused = true

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("restart") and !DiamondTransition.is_transitioning:
		DiamondTransition.transition_to(Scenes.MAIN)
