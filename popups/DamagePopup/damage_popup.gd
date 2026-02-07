class_name DamagePopup
extends Node2D

@export var curve : Curve
var max_damage: int = 100
var max_scale: float = 1.5

@onready var amount: Label = %Amount
@onready var animator: AnimationPlayer = $Animator

func setup(damage_amount: int):
	#var damage_scale = 1.0 + float(damage_amount) / 100.0
	var damage_scale = 1.0 + curve.sample(min(damage_amount, max_damage) / max_damage) * (max_scale - 1.0)
	
	scale = Vector2(damage_scale, damage_scale)
	amount.text = str(damage_amount)
