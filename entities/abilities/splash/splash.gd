class_name Splash
extends CharacterBody2D

@onready var hitbox_component: HitboxComponent = $HitboxComponent
@onready var animator: AnimationPlayer = %Animator

@onready var sprite: Sprite2D = %Sprite

var damage: int
var effect: PackedScene

func _on_hitbox_component_area_entered(area: Area2D) -> void:
	var object = area.get_parent()
	var total_damage: TotalDamage = TotalDamage.new(damage)
	PopupManager.spawn_damage_popup(object.global_position, total_damage)
	object.health_component.take_damage(total_damage)
	if effect:
		SoundPlayer.play_sound(SoundPlayer.FREEZE)
		
		var instance = effect.instantiate()
		object.add_child(instance)
