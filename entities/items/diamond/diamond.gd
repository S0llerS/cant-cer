class_name Diamond
extends Item

func effect():
	SoundPlayer.play_sound(SoundPlayer.DIAMOND)
	
	Stats.add_score(2500)
