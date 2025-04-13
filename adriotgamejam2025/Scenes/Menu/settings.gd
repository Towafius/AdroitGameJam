extends Control

@onready var master: HSlider = $TextureRect2/HBoxContainer/VBoxContainer/Master
@onready var music: HSlider = $TextureRect2/HBoxContainer/VBoxContainer/Music
@onready var sfx: HSlider = $TextureRect2/HBoxContainer/VBoxContainer/SFX

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.hide()
	
	master.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	music.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	sfx.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("open_options"):
		self.visible = !self.visible
		


func _on_music_value_changed(value: float) -> void:
	GameManager.set_bus_volume("Music", value)


func _on_sfx_value_changed(value: float) -> void:
	GameManager.set_bus_volume("SFX", value)


func _on_master_value_changed(value: float) -> void:
	GameManager.set_bus_volume("Master", value)


func _on_quit_button_pressed() -> void:
	get_tree().quit()
