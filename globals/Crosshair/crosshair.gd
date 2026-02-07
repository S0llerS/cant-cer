extends CanvasLayer

@onready var handle: Control = $Handle

var pressed_scale: float = 1.25
var rotation_scale: float = 2.5

func _process(delta: float) -> void:
	if Input.is_anything_pressed():
		handle.scale = lerp(handle.scale, Vector2(pressed_scale, pressed_scale), 24.0 * delta)
	else:
		handle.scale = lerp(handle.scale, Vector2.ONE, 24.0 * delta)
	
	var old_position = handle.global_position
	handle.global_position = handle.get_global_mouse_position()
	
	var diff = handle.global_position - old_position
	handle.rotation_degrees = diff.x * rotation_scale
