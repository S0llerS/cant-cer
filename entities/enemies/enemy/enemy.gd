class_name Enemy
extends CharacterBody2D

@export var enemy_stats : EnemyStats
@export var stop_when_attacking : bool = true

@onready var health_component: HealthComponent = $HealthComponent

@onready var damage_component: DamageComponent = $DamageComponent

@onready var range_component: RangeComponent = $RangeComponent
@onready var attack_component: AttackComponent = $AttackComponent

@onready var sprite: Sprite2D = $Sprite

@onready var animator: AnimationPlayer = $Animator
@onready var hurt_animator: AnimationPlayer = $HurtAnimator

var speed_multiplier: float = 1.0 # for applying effect e.g. slow

var max_vel: Vector2
var target : Node2D

func _ready() -> void:
	# setup
	max_vel = Vector2(enemy_stats.speed, enemy_stats.speed)
	
	health_component.max_health = enemy_stats.health
	health_component.health = enemy_stats.health
	
	damage_component.damage = enemy_stats.damage
	#damage_component.crit_multiplier = enemy_stats.crit_multiplier
	#damage_component.crit_chance = enemy_stats.crit_chance
	
	range_component.scale = Vector2(enemy_stats.attack_range, enemy_stats.attack_range)
	attack_component.scale = Vector2(enemy_stats.attack_range, enemy_stats.attack_range) * 1.25
	
	attack_component.timer.wait_time = enemy_stats.attack_speed
	
	# signals
	health_component.damaged.connect(_on_damaged)
	health_component.destroyed.connect(_on_destroyed)
	
	attack_component.attacked.connect(_on_attacked)

func _on_damaged():
	SoundPlayer.play_sound(SoundPlayer.ENEMY_DAMAGED)
	ParticleManager.spawn_particles(global_position, ParticleManager.hit_particles_scene)
	Camera.start_shake(0.1)
	
	hurt_animator.play("normal")

func _on_destroyed():
	Stats.change_score(enemy_stats.score_value)
	#Stats.change_money(enemy_stats.money_value)
	
	SoundPlayer.play_sound(SoundPlayer.ENEMY_DESTROYED)
	ParticleManager.spawn_particles(global_position, ParticleManager.explosion_particles_scene)
	Camera.start_shake(0.5)
	
	queue_free()

func _on_attacked():
	SoundPlayer.play_sound(SoundPlayer.ENEMY_ATTACK)

func _physics_process(delta: float) -> void:
	# attack
	var areas = range_component.get_overlapping_areas()
	for area in areas:
		var object = area.get_parent()
		if object is Player or object is Plant:
			var total_damage: TotalDamage = damage_component.calculate_damage()
			attack_component.attack(total_damage)
	
	# movement
	if target and (attack_component.can_attack or !stop_when_attacking):
		var direction = (target.global_position - global_position).normalized()
		velocity = lerp(velocity, direction * enemy_stats.speed * speed_multiplier, 8.0 * delta)
	else:
		velocity = lerp(velocity, Vector2.ZERO, 8.0 * delta)
	
	velocity = velocity.clamp(-max_vel, max_vel)
	sprite.flip_h = velocity.x < 0
	
	move_and_slide()
