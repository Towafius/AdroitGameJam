extends Control

@onready var label: Label = $Label

func _ready() -> void:
	GameManager.score_updated.connect(_on_score_updated)

func _on_score_updated(new_score: float) -> void:
	label.text = "$%d" % new_score
