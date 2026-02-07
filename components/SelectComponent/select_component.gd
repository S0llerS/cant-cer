class_name SelectComponent
extends Area2D

signal place
signal delete

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == 1:
			place.emit()
		elif event.button_index == 2:
			delete.emit()
