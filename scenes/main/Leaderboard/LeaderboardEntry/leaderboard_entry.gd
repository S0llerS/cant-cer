class_name LeaderboardEntry
extends PanelContainer

@onready var rank: Label = %Rank
@onready var score: Label = %Score

var frequency: float = 20.0
var speed: float = 2.5

var hue: float = -0.1
var hue_offset: float = 0.0

var hue_max: float = 0.2

func _ready() -> void:
	pivot_offset_ratio = Vector2(0.5, 0.5)

func _process(_delta: float) -> void:
	var t = Time.get_ticks_msec() * 0.001
	hue_offset = (sin(t * speed + hue) + 1.0) / 2
	
	var final_hue = hue_offset * hue_max + 0.68
	
	self_modulate = Color.from_ok_hsl(final_hue, 1.0, 0.5)
	
	scale.x = 1.0 + hue_offset * 0.05
