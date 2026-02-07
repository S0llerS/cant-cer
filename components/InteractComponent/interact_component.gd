class_name InteractComponent
extends Area2D

@export var ai_npc: Player2AINPC

@onready var action: Label = %Action
var can_interact: bool = false

signal interacted

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and can_interact and !ChatManager.is_active:
		ChatManager.start_chat(ai_npc)
		SoundPlayer.play_sound(SoundPlayer.PRESSED)
		interacted.emit()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		action.visible = true
		can_interact = true

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		action.visible = false
		can_interact = false
