extends CanvasLayer

@onready var animator: AnimationPlayer = %Animator

func _ready() -> void:
	visible = false

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause") and get_tree().current_scene.name == "Main":
		toggle()

func toggle():
	if visible:
		get_tree().paused = false
		
		animator.play_backwards("toggle")
		await animator.animation_finished
		
		visible = false
	else:
		get_tree().paused = true
		
		animator.play("toggle")
		visible = true


func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1, linear_to_db(value))

func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(2, linear_to_db(value))


func _on_sfx_check_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(1, !toggled_on)

func _on_music_check_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(2, !toggled_on)


func _on_close_pressed() -> void:
	toggle()

func _on_restart_pressed() -> void:
	toggle()
	DiamondTransition.transition_to(Scenes.MAIN)

func _on_menu_pressed() -> void:
	toggle()
	DiamondTransition.transition_to(Scenes.MENU)
