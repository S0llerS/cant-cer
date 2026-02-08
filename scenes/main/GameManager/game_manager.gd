class_name  GameManager
extends Node2D

@export var player : Player
@export var ui: UI

@export var enemy_scene : PackedScene

@export var debt_enemy_scene: PackedScene
@export var air_pollution_enemy_scene: PackedScene

@export var boss_enemy_scene: PackedScene

@onready var wave_timer: Timer = %WaveTimer

var wave_enemies = [
	[1, 0, 0], # 1
	[1, 0, 0], # 2
	[1, 0, 0], # 3
	[1, 0, 0], # 1
	[1, 0, 0], # 1
]

var warning1: bool = false
var warning2: bool = false
var warning3: bool = false

func _ready() -> void:
	Stats.reset()
	
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
	
	## spawn enemies, total 36 waves
	# first stage
	if Stats.wave < 12:
		if !warning1:
			Global.warn("DEBT APPROACHING!")
			warning1 = true
		
		for i in range(Stats.wave):
			var spawn_position = player.global_position + get_random_radial_position()
			add_entity(debt_enemy_scene, spawn_position)
	# second stage
	elif Stats.wave < 24:
		if !warning2:
			Global.warn("AIR POLLUTION IS COMING!")
			warning2 = true
		
		for i in range(15):
			var spawn_position = player.global_position + get_random_radial_position()
			add_entity(debt_enemy_scene, spawn_position)
		for i in range((Stats.wave - 12)):
			var spawn_position = player.global_position + get_random_radial_position()
			add_entity(air_pollution_enemy_scene, spawn_position)
	# third stage
	elif Stats.wave < 36:
		for i in range(Stats.wave):
			var spawn_position = player.global_position + get_random_radial_position()
			add_entity(debt_enemy_scene, spawn_position)
		for i in range(Stats.wave):
			var spawn_position = player.global_position + get_random_radial_position()
			add_entity(air_pollution_enemy_scene, spawn_position)
	# final stage
	else:
		if !warning3:
			var boss_position = player.global_position + get_random_radial_position()
			add_entity(boss_enemy_scene, boss_position)
			
			Global.warn("BOSS BOSS BOSS BOSS BOSS!")
			warning3 = true
		
		for i in range(25):
			var spawn_position = player.global_position + get_random_radial_position()
			add_entity(debt_enemy_scene, spawn_position)
		for i in range(25):
			var spawn_position = player.global_position + get_random_radial_position()
			add_entity(air_pollution_enemy_scene, spawn_position)
	
	# upgrades every 6 waves
	if Stats.wave % 3 == 0:
		ui.upgrades.show_cards()
	
	# next wave
	Stats.next_wave()


func _on_wave_timer_timeout() -> void:
	start_wave()
