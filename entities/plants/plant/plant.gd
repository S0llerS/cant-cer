class_name Plant
extends StaticBody2D

@export var plant_stats : PlantStats

@onready var health_component: HealthComponent = $HealthComponent
@onready var damage_component: DamageComponent = $DamageComponent

@onready var range_component: RangeComponent = $RangeComponent
@onready var shoot_component: ShootComponent = $ShootComponent

@onready var sprite: Sprite2D = $Sprite
@onready var animator: AnimationPlayer = $Animator

var status_effect_manager: StatusEffectManager

var damage_multiplier: float = 1.0
var shoot_speed_multiplier: float = 1.0

var SHOOT_SFX

func _ready() -> void:
	# add status effect manager
	status_effect_manager = StatusEffectManager.new()
	add_child(status_effect_manager)
	
	# setup
	health_component.max_health = plant_stats.health
	health_component.health = plant_stats.health
	
	damage_component.damage = plant_stats.damage
	damage_component.crit_multiplier = plant_stats.crit_multiplier
	damage_component.crit_chance = plant_stats.crit_chance
	
	if range_component:
		range_component.scale = Vector2(plant_stats.shoot_range, plant_stats.shoot_range)
	if shoot_component:
		shoot_component.shoot_speed = plant_stats.shoot_speed
		shoot_component.setup({ "shoot_speed": plant_stats.shoot_speed })
		
		shoot_component.projectile_speed = plant_stats.projectile_speed
		shoot_component.projectile_size = plant_stats.projectile_size
		
		shoot_component.projectile_slows_down = plant_stats.projectile_slows_down
		shoot_component.can_pierce = plant_stats.can_pierce
		
		shoot_component.spread = plant_stats.shoot_spread
		shoot_component.n_projectiles = plant_stats.n_projectiles
		shoot_component.n_projectile_burst = plant_stats.n_projectile_burst
	
	# signals
	health_component.damaged.connect(_on_damaged)
	health_component.destroyed.connect(_on_destroyed)
	
	shoot_component.shooted.connect(_on_shooted)

func _on_damaged():
	SoundPlayer.play_sound(SoundPlayer.PLANT_DAMAGED)

func _on_destroyed():
	SoundPlayer.play_sound(SoundPlayer.PLANT_DESTROYED)
	queue_free()

func _on_shooted():
	animator.stop()
	animator.play("attack")
	await animator.animation_finished
	animator.play("idle")

func apply_multipliers():
	damage_component.damage = int(plant_stats.damage * damage_multiplier)
	shoot_component.timer.wait_time = plant_stats.shoot_speed
	
	print("Multipliers applied!")

func _physics_process(_delta: float) -> void:
	if !range_component or !shoot_component:
		return
	
	var areas = range_component.get_overlapping_areas()
	for area in areas:
		var object = area.get_parent()
		if object is Enemy:
			sprite.flip_h = object.global_position.x - global_position.x < 0
			
			var result = damage_component.calculate_damage()
			shoot_component.shoot(result.total_damage, object)
