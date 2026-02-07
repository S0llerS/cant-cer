class_name Item
extends Area2D

var player: Player

signal collected

func effect():
	pass

func _on_area_entered(area: Area2D) -> void:
	var object = area.get_parent()
	if object is Player:
		ParticleManager.spawn_particles(global_position, ParticleManager.item_particles_scene)
		
		effect()
		collected.emit()
		
		queue_free()
