extends Control

@onready var label: Label = $Label

func _ready() -> void:
	GameManager.score_updated.connect(_on_score_updated)
	_on_score_updated(0)

func _on_score_updated(new_score: float) -> void:
	label.text = str(int(new_score))


func _on_master_value_changed(value: float) -> void:
	pass # Replace with function body.
