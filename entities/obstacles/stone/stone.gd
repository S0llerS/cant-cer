class_name Stone
extends CharacterBody2D

var speed: float = 400.0

var direction: Vector2 = Vector2(0, 1)

func _physics_process(_delta: float) -> void:
	move_and_slide()


func _on_hitbox_component_area_entered(area: Area2D) -> void:
	var object = area.get_parent()
	if object is Player:
		if !object.can_control:
			return
		
		if !object.is_shielded:
			var force_dir = (object.global_position - global_position).normalized()
			object.velocity = force_dir * 500.0 + Vector2(0, -500.0)
			
			SoundPlayer.play_sound(SoundPlayer.ROCK)
			object.health_component.take_damage(1)
		else:
			SoundPlayer.play_sound(SoundPlayer.SHIELD_BREAK)
			object.set_shielded(false)
		
		Camera.start_shake()
		ParticleManager.spawn_particles(global_position, ParticleManager.stone_particles_scene)
		
		queue_free()
