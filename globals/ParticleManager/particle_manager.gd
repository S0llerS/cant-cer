extends Node2D

@export var stone_particles_scene: PackedScene
@export var item_particles_scene: PackedScene

@export var jump_particles_scene: PackedScene

@export var hit_particles_scene: PackedScene
@export var explosion_particles_scene: PackedScene

func spawn_particles(spawn_position: Vector2, particles_scene: PackedScene):
	var particles: GPUParticles2D = particles_scene.instantiate()
	get_tree().root.add_child(particles)
	
	particles.global_position = spawn_position
	particles.restart()

func spawn_jump_particles(spawn_position: Vector2):
	spawn_particles(spawn_position, jump_particles_scene)
