extends Node

# arrays
@export var FOOTSTEPS: Array[AudioStream]
@export var RICOCHETS: Array[AudioStream]

# enemies
const ENEMY_ATTACK = preload("uid://coqarn2s4ujtv")
const ENEMY_DAMAGED = preload("uid://dioe7mxw0mmgd")
const ENEMY_DESTROYED = preload("uid://brh3rgw7w4ltp")
const EXPLOSION = preload("uid://u426brlx55fc")

# environment
const FIRE = preload("uid://d3lxv3e8q5rd3")

# items
const BOMB = preload("uid://dqab40prkjvkx")
const DIAMOND = preload("uid://72pal1fyipu5")
const SHIELD = preload("uid://mpml2p0v27aq")
const SHIELD_BREAK = preload("uid://8nxb72r7ou52")

# NPC's
const DEPRESSES = preload("uid://dkeoovi2dbt5n")
const SCARED = preload("uid://0l7j5374q30v")
const SCREAM = preload("uid://cnpyppkg6bbve")
const SOFT_TALK = preload("uid://bsvkpypy5gc8f")
const TALK = preload("uid://x8t722hipy2b")

# objects
const BIG_EXPLOSION = preload("uid://bfk7x3jwqfac4")

# obstacles
const ROCK = preload("uid://cj2hv6nnay4vx")
const LAZER = preload("uid://iyhuxiyn5ky6")
const LAZER_SHOOT = preload("uid://d4mjr0h6lg1ob")

# plants
const PLANT = preload("uid://bqvamp2cveqiw")
const PLANT_DAMAGED = preload("uid://d3cx06ei5a2i8")
const PLANT_DESTROYED = preload("uid://b6cjgm1oj3ngu")

const SUNFLOWER = preload("uid://sie7r5w61j6j")
const MUSHROOM = preload("uid://ekw1twyqaphf")
const FREEZE = preload("uid://ho8v7gc3vhid")
const MORTAR = preload("uid://c73v07xccuqu3")
const WATERMELON = preload("uid://c6bscvsfiu6q5")

# player
const JUMP = preload("uid://e2drr5wedknn")
const STEP = preload("uid://cgilcxf3ytedw")

# UI
const LEADERBOARD = preload("uid://dm2kd7553rlsl")
const TRANSITION = preload("uid://dux6ums3x8hu7")

const HOVERED = preload("uid://bbvr0wpd2a432")
const PRESSED = preload("uid://dqvo4slhtxovl")

# Logic
var audio_players = []

func _ready() -> void:
	audio_players = get_children()

func select_random(sounds: Array[AudioStream]) -> AudioStream:
	var index = randi_range(0, sounds.size() - 1)
	return sounds[index]

func play_sound(sound):
	for audio_player in audio_players:
		if !audio_player.playing:
			audio_player.stream = sound
			audio_player.pitch_scale = randf_range(0.9, 1.1)
			
			audio_player.play()
			
			return
	
	# if no audio_player is free
	var audio_player = AudioStreamPlayer.new()
	
	add_child(audio_player)
	audio_players.push_back(audio_player)
	
	audio_player.stream = sound
	audio_player.pitch_scale = randf_range(0.9, 1.1)
	
	audio_player.play()
