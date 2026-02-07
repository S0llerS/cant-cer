class_name Projectile
extends CharacterBody2D

var speed : float
var slows_down : bool = true

var damage : int

var can_pierce : bool = false

var direction : Vector2
var target : Node2D

var is_critical : bool

func _physics_process(delta: float) -> void:
	#if target:
		#direction = (target.global_position - global_position).normalized()
		#velocity = direction * speed
	
	if slows_down:
		velocity = velocity.lerp(Vector2.ZERO, 2.0 * delta)
	move_and_slide()
	
	# clean up projectiles
	if velocity.length() < 10.0:
		queue_free()
	if abs(global_position.x - Camera.global_position.x) > 2148 or abs(global_position.y - Camera.global_position.y) > 1252:
		queue_free()


func _on_hitbox_component_area_entered(area: Area2D) -> void:
	var object = area.get_parent()
	if object is Enemy:
		PopupManager.spawn_damage_popup(global_position, TotalDamage.new(damage, is_critical))
		object.health_component.take_damage(damage)
	
	if !can_pierce:
		queue_free()
