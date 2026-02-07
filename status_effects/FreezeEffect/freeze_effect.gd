class_name FreezeEffect
extends Node2D

var slow_amount: float = 0.6 # lower = slower

func _ready() -> void:
	var holder = get_parent()
	if holder is Enemy:
		holder.speed_multiplier = slow_amount
