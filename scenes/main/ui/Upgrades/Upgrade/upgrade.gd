class_name Upgrade
extends Control

@export var stats_upgrade: Dictionary

@onready var choose: Button = %Choose

var hovered_scale: Vector2 = Vector2(1.05, 1.05)

var upgrades: Upgrades
var id

func _ready() -> void:
	pivot_offset_ratio = Vector2(0.5, 0.5)
	
	# signals
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	
	choose.mouse_entered.connect(_on_mouse_entered)
	choose.mouse_exited.connect(_on_mouse_exited)

func _on_mouse_entered() -> void:
	var tween = get_tree().create_tween()
	tween.set_parallel()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	
	tween.tween_property(self, "scale", hovered_scale, 0.1).set_trans(Tween.TRANS_CUBIC)
	
	#SoundPlayer.play_sound(SoundPlayer.HOVERED)

func _on_mouse_exited() -> void:
	var tween = get_tree().create_tween()
	tween.set_parallel()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	
	tween.tween_property(self, "scale", Vector2.ONE, 0.1).set_trans(Tween.TRANS_CUBIC)


func _on_choose_pressed() -> void:
	upgrades.select_card(id, stats_upgrade)
