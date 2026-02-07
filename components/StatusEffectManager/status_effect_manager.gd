class_name StatusEffectManager
extends Node2D

var handler

func _ready() -> void:
	handler = get_parent()

func apply_effect(effect: StatusEffect):
	for stat in effect.stats_multiplier:
		if handler.get(stat):
			handler.set(stat, handler.get(stat) + effect.stats_multiplier[stat])
	
	handler.apply_multipliers()

func remove_effect(effect: StatusEffect):
	for stat in effect.stats_multiplier:
		if handler.get(stat):
			handler.set(stat, handler.get(stat) - effect.stats_multiplier[stat])
	
	handler.apply_multipliers()
