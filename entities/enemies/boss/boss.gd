class_name Boss
extends Enemy

func _on_destroyed():
	Global.win()
	
	super()
