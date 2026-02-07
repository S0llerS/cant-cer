class_name PlayerStats
extends Resource

@export var health : int = 10

@export var damage : int = 5

@export var crit_multiplier : float = 2.5
@export var crit_chance : float = 10.0

@export var shoot_range : float = 250.0
@export var shoot_speed : float = 0.8

@export_group("Projectile")
@export var projectile_speed : float = 450.0
@export var projectile_size : float = 10.0

@export var projectile_slows_down : bool = false
@export var can_pierce : bool = false

@export var shoot_spread : float = 0.0
@export var n_projectiles : int = 1
@export var n_projectile_burst : int = 1
