extends Node

# Music catalog
const ARCADE_PARTY = preload("uid://caf3104qr4m7a")
const ARCADE_STYLE_GAME = preload("uid://dhrp3ckf0jc7j")

const SPACE_AMBIENT = preload("uid://dgyj6ia2liice")
const PARK = preload("uid://w4d5ieiosf7a")

const GAME_OVER = preload("uid://dngta8bdvjblq")
const MAIN = preload("uid://snbgxaxiq63v")
const MENU = preload("uid://dhi3fhkwvqbg6")

# Logic
@export var audio_player : AudioStreamPlayer

func play_music(music):
	audio_player.stream = music
	audio_player.play()

func stop_music():
	audio_player.stop()
