extends CanvasLayer

@export var targets: Array[Control]
var positions: Array[Vector2]

@onready var control: Control = $Control
@onready var animator: AnimationPlayer = %Animator

func _ready() -> void:
	MusicPlayer.play_music(MusicPlayer.MENU)
	
	for target in targets:
		positions.append(target.position)
	
	print(targets)
	print(positions)

func _process(_delta: float) -> void:
	for i in range(targets.size()):
		var index_strength = (i + 1) * 3
		var offset_strength = 0.075
		var position_offset = (control.get_global_mouse_position() - Vector2(640, 360)) * offset_strength / index_strength
		targets[i].position = positions[i] - position_offset

func transition():
	DiamondTransition.transition_to(Scenes.MAIN)

func _input(_event: InputEvent) -> void:
	if Input.is_anything_pressed() and !DiamondTransition.is_transitioning:
		animator.play("start")

func _on_play_pressed() -> void:
	animator.play("start")
