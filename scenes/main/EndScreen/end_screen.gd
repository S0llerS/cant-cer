class_name EndScreen
extends Control


func toggle():
	visible = !visible


func _on_restart_pressed() -> void:
	DiamondTransition.transition_to(Scenes.MAIN)

func _on_menu_pressed() -> void:
	DiamondTransition.transition_to(Scenes.MENU)
