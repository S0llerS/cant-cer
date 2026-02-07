class_name  GameManager
extends Node2D

@export var player : Player
@export var ui: UI

@export var enemy_scene : PackedScene

@onready var wave_timer: Timer = %WaveTimer

func _ready() -> void:
	start_wave()

func add_entity(scene, pos):
	if !player:
		return
	
	var instance = scene.instantiate()
	
	if instance is Enemy:
		instance.target = player
		get_parent().call_deferred("add_child", instance)
	else:
		add_child(instance)
	
	instance.global_position = pos

func get_random_position(dist) -> Vector2:
	var x = randf_range(-dist, dist)
	var y = randf_range(-dist, dist)
	
	return Vector2(x, y)

func get_random_radial_position() -> Vector2:
	var angle = randf_range(0.0, TAU)
	var pos = Vector2(cos(angle), sin(angle)) * 1000.0
	
	return pos

func start_wave():
	# stop waves if player is not with us anymore...
	if !player:
		wave_timer.stop()
		return
	
	# spawn enemies
	for i in range(10):
		var random_position = player.global_position + get_random_radial_position()
		add_entity(enemy_scene, random_position)
	
	# upgrades every 5 waves
	if Stats.wave % 5 == 0:
		ui.upgrades.show_cards()
	
	# next wave
	Stats.next_wave()


func _on_wave_timer_timeout() -> void:
	start_wave()
