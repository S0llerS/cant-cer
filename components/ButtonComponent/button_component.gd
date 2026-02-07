class_name ButtonComponent
extends Node

var hovered_scale: Vector2 = Vector2(1.05, 1.05)
var pressed_scale: Vector2 = Vector2(1.1, 1.1)

var button : Button

func _ready() -> void:
	if get_parent() is Button:
		button = get_parent()
		
		button.pivot_offset_ratio = Vector2(0.5, 0.5)
		button.focus_mode = Control.FOCUS_NONE
		
		button.mouse_entered.connect(_on_mouse_entered)
		button.mouse_exited.connect(_on_mouse_exited)
		
		button.pressed.connect(_on_pressed)
	else:
		push_warning("ButtonComponent's parent is NOT a Button.")

func _on_mouse_entered() -> void:
	var tween = get_tree().create_tween()
	tween.set_parallel()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	
	tween.tween_property(button, "scale", hovered_scale, 0.1).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(button, "rotation", 0.05, 0.1).set_trans(Tween.TRANS_CUBIC)
	
	SoundPlayer.play_sound(SoundPlayer.HOVERED)

func _on_mouse_exited() -> void:
	var tween = get_tree().create_tween()
	tween.set_parallel()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	
	tween.tween_property(button, "scale", Vector2.ONE, 0.1).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(button, "rotation", 0, 0.25).set_trans(Tween.TRANS_CUBIC)

func _on_pressed() -> void:
	var tween_scale = get_tree().create_tween()
	var tween_rotation = get_tree().create_tween()
	
	tween_scale.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween_rotation.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	
	tween_scale.tween_property(button, "scale", pressed_scale, 0.1).set_trans(Tween.TRANS_CUBIC)
	tween_rotation.tween_property(button, "rotation", -0.1, 0.1).set_trans(Tween.TRANS_CUBIC)
	
	tween_scale.tween_property(button, "scale", Vector2.ONE, 0.2).set_trans(Tween.TRANS_CUBIC)
	tween_rotation.tween_property(button, "rotation", 0, 0.25).set_trans(Tween.TRANS_CUBIC)
	
	SoundPlayer.play_sound(SoundPlayer.PRESSED)
