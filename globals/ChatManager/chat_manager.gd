extends Node

var current_npc: Player2AINPC
var is_active: bool = false

var can_stop: bool = true

signal started
signal stopped

signal reacted(reaction: String)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause") and is_active and can_stop:
		stop_chat()

func start_chat(npc: Player2AINPC):
	if is_active:
		return
	
	current_npc = npc
	is_active = true
	
	started.emit()

func stop_chat():
	current_npc = null
	is_active = false
	
	stopped.emit()

func react(reaction: String):
	reacted.emit(reaction)
