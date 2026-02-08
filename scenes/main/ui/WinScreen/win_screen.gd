class_name WinScreen
extends Control

@onready var final_score: Label = %FinalScore

func setup():
	get_tree().paused = true
	
	final_score.text = "Final Score: " + str(Stats.score)

func _on_try_again_pressed() -> void:
	DiamondTransition.transition_to(Scenes.MAIN)

func _on_menu_pressed() -> void:
	DiamondTransition.transition_to(Scenes.MENU)
