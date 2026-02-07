extends Node2D

@export var damage_popup : PackedScene

func spawn_damage_popup(spawn_position: Vector2, total_damage: TotalDamage):
	var popup: DamagePopup = damage_popup.instantiate()
	get_tree().root.add_child(popup)
	
	var tween = get_tree().create_tween()
	tween.tween_property(popup, "rotation_degrees", randf_range(-15, 15), 0.4).set_trans(Tween.TRANS_CUBIC)
	
	if total_damage.is_critical:
		popup.animator.play("critical")
	else:
		popup.animator.play("normal")
	
	popup.global_position = spawn_position
	popup.setup(total_damage.amount)
