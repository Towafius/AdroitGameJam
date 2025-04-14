extends Node

signal score_updated(new_score: float)

var score: float = 0
var repairables = []

func add_score(amount: float) -> void:
	score += amount
	score_updated.emit(score)

func reset_score() -> void:
	score = 0
	score_updated.emit(score)

# Volume control
func set_bus_volume(bus_name: String, value: float) -> void:
	# Clamp to a safe decibel range; Godot uses dB from -80 to 0
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus_name), db)

func get_bus_volume(bus_name: String) -> float:
	return db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index(bus_name)))

func pop_repairables():
	var value = repairables
	repairables = []
	return value

func add_repairable(body):
	repairables.append(body)

func reset_repairables():
	repairables = []
