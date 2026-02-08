class_name Tutorial
extends Control

func _on_continue_pressed() -> void:
	get_tree().paused = false
	visible = false
