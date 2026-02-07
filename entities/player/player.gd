class_name Player
extends CharacterBody2D

@export var player_stats: PlayerStats

@onready var health_component: HealthComponent = $HealthComponent
@onready var damage_component: DamageComponent = $DamageComponent
@onready var shoot_component: ShootComponent = $ShootComponent

@onready var sprite: Sprite2D = $Sprite

var speed : float = 160.0

# dash
@onready var dash_timer: Timer = %DashTimer
@onready var dash_cooldown_timer: Timer = %DashCooldownTimer

var dash_speed : float = 550.0 # how much is faster than normal speed
var dash_duration : float = 0.2
var dash_cooldown : float = 0.8

var is_dashing : bool = false
var can_dash : bool = true

var dash_direction : Vector2

func _ready() -> void:
	dash_timer.wait_time = dash_duration
	dash_cooldown_timer.wait_time = dash_cooldown
	
	# stats magic
	player_stats = player_stats.duplicate()
	
	apply_stats()
	
	# signals
	health_component.damaged.connect(_on_damaged)
	health_component.destroyed.connect(_on_destroyed)
	
	shoot_component.shooted.connect(_on_shot)

func apply_stats():
	# health
	health_component.health = player_stats.health
	
	# damage
	damage_component.damage = player_stats.damage
	
	damage_component.crit_chance = player_stats.crit_chance
	damage_component.crit_multiplier = player_stats.crit_multiplier
	
	# shoot
	shoot_component.shoot_speed = player_stats.shoot_speed
	shoot_component.timer.wait_time = player_stats.shoot_speed
	
	shoot_component.projectile_speed = player_stats.projectile_speed
	shoot_component.projectile_size = player_stats.projectile_size
	
	shoot_component.projectile_slows_down = player_stats.projectile_slows_down
	shoot_component.can_pierce = player_stats.can_pierce
	
	shoot_component.spread = player_stats.shoot_spread
	shoot_component.n_projectiles = player_stats.n_projectiles
	shoot_component.n_projectile_burst = player_stats.n_projectile_burst

func _on_damaged(_is_critical: bool):
	SoundPlayer.play_sound(SoundPlayer.SHIELD_BREAK)
	Camera.start_shake(0.5)
	
	get_tree().paused = true
	await get_tree().create_timer(0.2).timeout
	get_tree().paused = false

func _on_destroyed():
	Global.lose()
	
	queue_free()

func _on_shot():
	pass

func handle_dash(dir, delta):
	if Input.is_action_just_pressed("dash") and can_dash:
		is_dashing = true
		can_dash = false
		
		dash_direction = dir
		
		dash_timer.start()
	
	if is_dashing:
		velocity = dash_direction * dash_speed
	else:
		velocity = lerp(velocity, dir * speed, 18.0 * delta)

func _physics_process(delta: float) -> void:
	# shoot
	if Input.is_action_pressed("shoot"):
		shoot_component.shoot(damage_component, get_global_mouse_position())
	
	# movement
	var direction = Input.get_vector("left", "right", "up", "down")
	
	#handle_dash(direction, delta)
	velocity = lerp(velocity, direction * speed, 4.0 * delta)
	
	if direction:
		var target_angle = velocity.angle()
		global_rotation = lerp_angle(global_rotation, target_angle, 8.0 * delta)
	
	move_and_slide()


func _on_dash_timer_timeout() -> void:
	is_dashing = false
	dash_cooldown_timer.start()

func _on_dash_cooldown_timer_timeout() -> void:
	can_dash = true
