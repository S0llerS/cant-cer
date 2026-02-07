class_name Blast
extends Area2D


func _on_area_entered(area: Area2D) -> void:
	var object = area.get_parent()
	if object is Stone:
		object.queue_free()
