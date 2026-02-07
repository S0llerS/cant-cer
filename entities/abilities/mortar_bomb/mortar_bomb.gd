class_name MortarBomb
extends CharacterBody2D

@export var amplitude_curve: Curve

@onready var attack_component: AttackComponent = $AttackComponent

@onready var shadow_component: ShadowComponent = $ShadowComponent
@onready var sprite: Sprite2D = $Sprite

var speed: float
var damage: int

var start_position: Vector2
var target_position: Vector2
var total_distance: float

func _ready() -> void:
	start_position = global_position
	total_distance = (target_position - start_position).length()
	
	attack_component.scale = scale * 2

func _physics_process(_delta: float) -> void:
	if target_position:
		var direction = (target_position - global_position).normalized()
		velocity = direction * speed
	
	move_and_slide()
	
	# mortar bomb visuals
	var current_distance: float = (target_position - global_position).length()
	var amplitude: float = amplitude_curve.sample(current_distance / total_distance)
	
	shadow_component.scale = Vector2.ONE - Vector2(amplitude, amplitude) * 0.5
	sprite.position.y = -amplitude * min(total_distance / 10, 5)
	
	# handle explosion on target position
	if (target_position - global_position).length() < 10.0:
		attack_component.attack(TotalDamage.new(damage, false))
		SoundPlayer.play_sound(SoundPlayer.WATERMELON)
		
		queue_free()


func _on_hitbox_component_area_entered(_area: Area2D) -> void:
	pass
	
	#attack_component.attack(damage)
	#queue_free()
