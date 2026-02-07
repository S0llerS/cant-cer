class_name Lazer
extends Area2D

func shoot_sound() -> void:
	SoundPlayer.play_sound(SoundPlayer.LAZER_SHOOT)

func _on_area_entered(area: Area2D) -> void:
	var object = area.get_parent()
	if object is Player:
		if !object.can_control:
			return
		
		if !object.is_shielded:
			var force_dir = (object.global_position - global_position).normalized()
			object.velocity = force_dir * 250.0 + Vector2(0, -500.0)
			
			#SoundPlayer.play_sound(SoundPlayer.LAZER)
			object.health_component.take_damage(1)
		else:
			SoundPlayer.play_sound(SoundPlayer.SHIELD_BREAK)
			object.set_shielded(false)
		
		Camera.start_shake()
