extends CanvasLayer

@onready var animator: AnimationPlayer = %Animator

var is_transitioning : bool = false

signal transitioned

func transition_to(path: String) -> void:
	animator.play("in")
	is_transitioning = true
	
	SoundPlayer.play_sound(SoundPlayer.TRANSITION)
	
	await animator.animation_finished
	
	get_tree().change_scene_to_file(path)
	
	animator.play("out")
	
	await animator.animation_finished
	
	is_transitioning = false
	transitioned.emit()
