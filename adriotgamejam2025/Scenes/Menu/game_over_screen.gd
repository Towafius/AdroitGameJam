extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_quit_to_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Levels/BossOffice.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().paused = false
	get_tree().quit()


func _on_rage_meter_rage_over() -> void:
	get_tree().paused = true
	show()
