class_name Leaderboard
extends Control

@export var lb_entry_scene: PackedScene

# highscore
@onready var highscore_container: PanelContainer = %HighscoreContainer

@onready var highscore: Label = %Highscore
@onready var amount: Label = %Amount

# leaderboard
@onready var loading: Label = %Loading

@onready var entries_container: VBoxContainer = %EntriesContainer

@onready var animator: AnimationPlayer = $Animator

var is_open: bool = false
var can_interact: bool = false

func _ready() -> void:
	Global.score_submitted.connect(_on_score_submitted)

func _on_score_submitted():
	load_entries()

func open():
	animator.play("open")
	SoundPlayer.play_sound(SoundPlayer.LEADERBOARD)
	
	visible = true
	is_open = true
	
	if Stats.high_score < Stats.score:
		highscore.text = "NEW HIGHSCORE!"
		Stats.set_high_score(Stats.score)
	
	amount.text = str(Stats.score)
	
	clean_up_entries()

func create_entry(entry: TaloLeaderboardEntry):
	var lb_entry: LeaderboardEntry = lb_entry_scene.instantiate()
	
	lb_entry.hue = float(entry.position)# / 10
	
	entries_container.add_child(lb_entry)
	
	lb_entry.rank.text = str(entry.position + 1) + "."
	lb_entry.score.text = str(int(entry.score))

func clean_up_entries():
	for i in range(1, entries_container.get_child_count()):
		entries_container.get_child(i).queue_free()

func build_entries():
	var entries: Array[TaloLeaderboardEntry] = Talo.leaderboards.get_cached_entries("score-leaderboard")
	entries = entries.slice(0, 10)
	
	# build new
	for entry in entries:
		create_entry(entry)

func load_entries():
	var res = await Talo.leaderboards.get_entries("score-leaderboard")
	
	build_entries()
	loading.visible = false

func _physics_process(_delta: float) -> void:
	if can_interact and Input.is_anything_pressed() and !DiamondTransition.is_transitioning:
		DiamondTransition.transition_to(Scenes.MAIN)

func enable_interact():
	can_interact = true
