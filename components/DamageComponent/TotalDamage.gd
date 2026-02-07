class_name TotalDamage
extends Resource

@export var amount: int
@export var is_critical: bool

func _init(p_amount: int = 0, p_is_critical: bool = false) -> void:
	amount = p_amount
	is_critical = p_is_critical
