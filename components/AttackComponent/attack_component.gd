class_name AttackComponent
extends Node2D

@export var splash : PackedScene
@export var child_of_attacker : bool = true

@export var attack_texture: Texture

@onready var timer: Timer = $Timer

var can_attack : bool = true

var effect: PackedScene

signal attacked

func attack(total_damage: TotalDamage):
	if can_attack:
		var instance : Splash = splash.instantiate()
		
		instance.damage = total_damage.amount
		if effect:
			instance.effect = effect
		
		if child_of_attacker:
			add_child(instance)
		else:
			instance.scale = scale * 2.0
			get_tree().root.add_child(instance) # attack_place.call_deferred("add_child", instance)
			instance.animator.speed_scale = 10.0
		instance.global_position = global_position
		
		# set what to attack
		var attacker = get_parent()
		if attacker is Enemy:
			instance.hitbox_component.set_collision_mask_value(2, true) # Player
		else:
			instance.hitbox_component.set_collision_mask_value(3, true) # Enemy
		
		# visuals
		if attack_texture:
			instance.sprite.texture = attack_texture
		
		# attack end
		can_attack = false
		attacked.emit()
		
		timer.start()

func _on_timer_timeout() -> void:
	can_attack = true
