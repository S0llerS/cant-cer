class_name UI
extends CanvasLayer

@export var player: Player

@onready var health: Label = %Health
@onready var score: Label = %Score

@onready var animator: AnimationPlayer = $Control/Animator

# upgrades
@onready var upgrades: Upgrades = $Upgrades

# win/lose
@onready var win_screen: WinScreen = $WinScreen
@onready var lose_screen: LoseScreen = $LoseScreen

func _ready() -> void:
	# setup
	upgrades.player = player
	
	# signals
	player.health_component.damaged.connect(_on_damaged)
	
	Stats.score_changed.connect(_on_score_changed)
	
	Global.won.connect(_on_won)
	Global.lost.connect(_on_lost)

func _on_damaged(_is_critical: bool):
	health.text = str(player.health_component.health)

func _on_score_changed():
	animator.play("score")
	
	score.text = str(Stats.score)


func _on_won():
	win_screen.visible = true

func _on_lost():
	lose_screen.visible = true


func _on_settings_pressed() -> void:
	Settings.toggle()
