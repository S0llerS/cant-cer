class_name HealthComponent
extends Node2D

@export var max_health : int = 10
var health : int

signal damaged
signal destroyed

func _ready() -> void:
	health = max_health

func take_damage(amount: int):
	health -= amount
	if health <= 0:
		destroyed.emit()
	else:
		damaged.emit()
