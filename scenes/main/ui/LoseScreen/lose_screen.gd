class_name LoseScreen
extends Control


func _on_try_again_pressed() -> void:
	DiamondTransition.transition_to(Scenes.MAIN)

func _on_menu_pressed() -> void:
	DiamondTransition.transition_to(Scenes.MENU)
