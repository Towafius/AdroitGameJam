extends Control

@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = get_tree().create_tween()
	var start_pos = self.global_position

	# Start parallel tweens
	tween.tween_property(label, "modulate", Color(1, 1, 1, 0), 1.0)
	tween.parallel().tween_property(self, "global_position", start_pos + Vector2(0, -10), 1.0)

	# Free node after both are done
	tween.tween_callback(queue_free)

func set_color(color:Color):
	label.modulate = color

func set_text(text:String):
	label.text = text
