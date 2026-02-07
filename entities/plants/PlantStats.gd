class_name PlantStats
extends Resource

@export var title : String = "Plant"
@export var price : int = 100

const TYPE = ["Shooter", "Splash", "Tank", "Support", "Mortar"]
const COLOR = [Color.YELLOW, Color.AQUA, Color.GREEN, Color.FUCHSIA, Color.RED]

enum PlantType { SHOOTER, SPLASH, TANK, SUPPORT, MORTAR }
@export var type : PlantType = PlantType.SHOOTER

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
