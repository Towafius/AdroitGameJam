extends CanvasLayer

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

func _ready() -> void:
	show()

func _on_play_button_pressed() -> void:
	hide()
	animation_player.play("Intro")

func _on_settings_button_pressed() -> void:
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().quit()
