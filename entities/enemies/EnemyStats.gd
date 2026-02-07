class_name EnemyStats
extends Resource

@export var title : String = "Enemy"

enum EnemyType { NORMAL, FAST, TANK, RANGED, BOSS }
@export var type : EnemyType = EnemyType.NORMAL

@export_group("Values")
@export var enemy_value : int = 1

@export var score_value : int = 100
@export var money_value : int = 25

@export_group("Base")
@export var speed : float = 100.0

@export var health : int = 10

@export var damage : int = 5

@export var crit_multiplier : float = 2.5
@export var crit_chance : float = 10.0

@export var attack_range : float = 48.0
@export var attack_speed : float = 1.2
