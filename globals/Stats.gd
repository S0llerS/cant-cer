extends Node

# stats
var score : int = 0
var gifts : int = 0

var wave : int = 1

var total_time : float = 0.0

# signals
signal score_changed
signal gifts_changed

signal wave_changed

# reset all of the statistics
func reset() -> void:
	score = 0
	gifts = 0
	
	wave = 1
	
	total_time = 0.0

# score
func change_score(amount: int) -> void:
	score += amount
	score_changed.emit()

# gift
func add_gift() -> void:
	gifts += 1
	gifts_changed.emit()

func remove_gift() -> void:
	if gifts - 1 < 0:
		return
	
	gifts -= 1
	gifts_changed.emit()

# wave
func next_wave() -> void:
	wave += 1
	wave_changed.emit()
