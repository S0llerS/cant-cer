class_name UI
extends CanvasLayer

@export var player: Player

@onready var health: Label = %Health
@onready var score: Label = %Score

@onready var animator: AnimationPlayer = $Control/Animator

# upgrades
@onready var upgrades: Upgrades = $Upgrades

func _ready() -> void:
	# setup
	upgrades.player = player
	
	# signals
	player.health_component.damaged.connect(_on_damaged)
	Stats.score_changed.connect(_on_score_changed)

func _on_damaged(_is_critical: bool):
	health.text = str(player.health_component.health)

func _on_score_changed():
	animator.play("score")
	
	score.text = str(Stats.score)


func _on_settings_pressed() -> void:
	Settings.toggle()
