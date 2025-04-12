extends Node

signal score_changed(score:int)

var score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func change_score(increase_amount:int):
	score += increase_amount
	score_changed.emit(score)
