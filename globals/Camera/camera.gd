extends Camera2D

var target: Node2D
var last_position: Vector2

@onready var duration_timer: Timer = $DurationTimer
@onready var frequency_timer: Timer = $FrequencyTimer

@onready var blur: ColorRect = %Blur
var target_blur: float = 0.1

var shake_duration : float = 0.4
var shake_frequency : float = 0.05

var default_shake_amplitude : float = 8.0
var default_shake_direction : Vector2 = Vector2(1.0, 1.0)

var shake_amplitude : float = 8.0
var shake_direction : Vector2 = Vector2(1.0, 1.0)

var is_shaking : bool = false
var current_multiplier : float = 0.0

func _ready() -> void:
	check_scene()
	
	# signal
	get_tree().scene_changed.connect(check_scene)

func check_scene():
	var current_scene = get_tree().current_scene
	if current_scene.name == "Main":
		var player = current_scene.find_child("Player")
		target = player

func _physics_process(delta: float) -> void:
	var final_position: Vector2 = last_position
	
	if target:
		final_position = target.global_position
		last_position = target.global_position
	
	#var max_offset = Vector2(100, 100)
	var current_offset = (get_global_mouse_position() - global_position)
	final_position += current_offset * 0.1
	
	var current_blur = blur.material.get_shader_parameter("strength")
	blur.material.set_shader_parameter("strength", lerp(current_blur, target_blur, 8.0 * delta))
	
	global_position = lerp(global_position, final_position, 16.0 * delta)

func start_shake(multiplier = 0.25, duration = shake_duration, frequency = shake_frequency, amplitude = default_shake_amplitude, direction = default_shake_direction):
	# check
	if is_shaking and current_multiplier >= multiplier:
		return
	else:
		current_multiplier = multiplier
	
	# setup
	duration_timer.wait_time = duration * multiplier
	frequency_timer.wait_time = frequency
	
	shake_amplitude = amplitude * multiplier
	shake_direction = direction
	
	is_shaking = true
	
	target_blur = 1.5
	
	duration_timer.start()
	frequency_timer.start()

func shake():
	var x = randf_range(-shake_amplitude, shake_amplitude)
	var y = randf_range(-shake_amplitude, shake_amplitude)
	offset = Vector2(x, y) * shake_direction
	
	var max_angle = deg_to_rad(0.5)
	rotation = randf_range(-max_angle, max_angle)

func _on_duration_timer_timeout() -> void:
	is_shaking = false
	current_multiplier = 0.0
	
	offset = Vector2.ZERO
	rotation = 0.0
	
	target_blur = 0.1
	
	frequency_timer.stop()

func _on_frequency_timer_timeout() -> void:
	shake()
