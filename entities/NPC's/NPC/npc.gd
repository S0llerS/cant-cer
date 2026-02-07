class_name NPC
extends CharacterBody2D

@onready var agent_ai: Player2AINPC = $AgentAI

@onready var sprite: AnimatedSprite2D = $Sprite

@onready var idle_timer: Timer = $IdleTimer
@onready var move_timer: Timer = $MoveTimer

var speed: float = 100.0

var min_move_dist: float = 50.0
var max_move_dist: float = 500.0

var can_move: bool = false
var target_pos: Vector2

# other
@onready var animator: AnimationPlayer = $Animator
@onready var ability_animator: AnimationPlayer = $AbilityAnimator

@onready var sanity_label: Label = %Sanity
var sanity: int = 100

var high_sanity_multiplier: float = 1.0
var medium_sanity_multiplier: float = 1.4
var low_sanity_multiplier: float = 2.2

var current_sanity_multiplier: float = 1.0

signal sanity_lowered

func _ready() -> void:
	agent_ai.tool_called.connect(func(func_name, args):
		push_warning("WARNING WARNING WARNING ", func_name, args)
	)
	
	sanity = 1#randi_range(90, 100)
	check_sanity_multiplier()
	
	idle_timer.wait_time = randf_range(0.5, 3.0) / current_sanity_multiplier
	idle_timer.start()

func lower_sanity(amount: int):
	sanity = max(0, sanity - amount)
	check_sanity_multiplier()
	
	sanity_lowered.emit()

func check_sanity_multiplier():
	sanity_label.modulate = Color.from_hsv(0, 1.0 - sanity * 0.01, 1.0)#Color.from_rgba8(255 - int(sanity * 2.55), 0, 0)
	sanity_label.text = "Sanity: " + str(sanity)
	
	if sanity > 60:
		sprite.play("normal")
		current_sanity_multiplier = high_sanity_multiplier
	elif sanity > 30:
		sprite.play("sad")
		current_sanity_multiplier = medium_sanity_multiplier
	else:
		sprite.play("insane")
		current_sanity_multiplier = low_sanity_multiplier

func check_scream():
	if sanity <= 30:
		SoundPlayer.play_sound(SoundPlayer.SCREAM)
		ability_animator.play("scream")

func _physics_process(delta: float) -> void:
	if can_move:
		animator.play("run")
		
		var direction = (target_pos - global_position).normalized()
		
		sprite.flip_h = direction.x < 0
		
		var current_speed = direction * speed * current_sanity_multiplier
		velocity = lerp(velocity, current_speed, 8.0 * delta)
	else:
		animator.play("idle")
		velocity = lerp(velocity, Vector2.ZERO, 8.0 * delta)
	
	move_and_slide()
	
	# check
	if can_move and global_position.distance_to(target_pos) < 50.0:
		can_move = false
		move_timer.stop()
		
		idle_timer.start()
		
		check_scream()

func get_next_position(current_pos) -> Vector2:
	var angle = randf_range(0.0, TAU)
	var next_pos = Vector2(cos(angle), sin(angle))
	
	next_pos *= randf_range(min_move_dist, max_move_dist)
	next_pos += current_pos
	
	next_pos.x = clamp(next_pos.x, -600, 600)
	next_pos.y = clamp(next_pos.y, -300, 300)
	
	return next_pos

func _on_idle_timer_timeout() -> void:
	# random idle time
	idle_timer.wait_time = randf_range(0.5, 3.0) / current_sanity_multiplier
	
	# allow NPC to move
	can_move = true
	target_pos = get_next_position(global_position)
	
	# fallback
	move_timer.start()

func _on_move_timer_timeout() -> void:
	check_scream()
	
	# reset back to idle
	can_move = false
	idle_timer.start()


func _on_scream_area_entered(area: Area2D) -> void:
	var npc = area.get_parent()
	if npc != self and npc is NPC:
		npc.lower_sanity(randi_range(5, 15))
