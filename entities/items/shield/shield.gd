class_name Shield
extends Item

func effect():
	SoundPlayer.play_sound(SoundPlayer.SHIELD)
	player.set_shielded(true)
