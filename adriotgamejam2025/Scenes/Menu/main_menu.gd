extends CanvasLayer

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"
@onready var settings_menu: Control = $"Settings Menu"

func _ready() -> void:
	show()
	animation_player.play("idle")

func _on_play_button_pressed() -> void:
	hide()
	animation_player.play("Intro")

func _on_settings_button_pressed() -> void:
	settings_menu.toggle_menu()


func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _change_scene():
	get_tree().change_scene_to_file("res://Scenes/Levels/Fired_animation.tscn")
