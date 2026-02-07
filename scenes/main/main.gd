class_name Main
extends Node2D

func _ready() -> void:
	#MusicPlayer.play_music(MusicPlayer.SPACE_AMBIENT)
	MusicPlayer.stop_music()
	get_tree().paused = false
	
	Stats.reset()
	
	Global.start_playing()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("restart") and !DiamondTransition.is_transitioning:
		DiamondTransition.transition_to(Scenes.MAIN)
