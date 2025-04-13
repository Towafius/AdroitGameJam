extends Node

signal score_updated(new_score: float)

var score: float = 0

func add_score(amount: float) -> void:
	score += amount
	score_updated.emit(score)
