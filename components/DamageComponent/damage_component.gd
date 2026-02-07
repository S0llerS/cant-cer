class_name DamageComponent
extends Node2D

var damage: int = 0

var crit_multiplier: float = 1.0
var crit_chance: float = 0.0

func calculate_damage():
	var total_damage: int = damage
	var is_critical: bool = false
	
	if randf_range(0, 100) < crit_chance:
		total_damage = int(total_damage * crit_multiplier)
		is_critical = true
	
	return TotalDamage.new(total_damage, is_critical)
