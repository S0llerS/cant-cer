class_name Bomb
extends Item

@export var blast_scene: PackedScene

func effect():
	SoundPlayer.play_sound(SoundPlayer.BOMB)
	Camera.start_shake(1.5)
	
	var blast = blast_scene.instantiate()
	get_parent().add_child(blast)
	blast.global_position = global_position
