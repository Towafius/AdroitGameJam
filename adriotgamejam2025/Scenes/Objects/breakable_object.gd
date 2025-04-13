extends StaticBody2D

class_name BreakableObject

@export var max_health:int = 50
@export var rage_value:float = max_health/5
@export var score_value:float = max_health

@onready var unbroken_sprite: Sprite2D = $UnbrokenSprite
@onready var broken_sprite: Sprite2D = $BrokenSprite
@onready var health_bar: TextureProgressBar = $HealthBar
@onready var smoke_particles: GPUParticles2D = $SmokeParticles

const TEMP_TEXT_LABEL = preload("res://Scenes/Objects/temp_text_label.tscn")

var health:int

func _ready() -> void:
	health = max_health
	
	#Set up health bar
	initialize_health_bar()

func initialize_health_bar():
	health_bar.max_value=max_health
	health_bar.value=health
	health_bar.hide()

func break_object():
	unbroken_sprite.hide()
	broken_sprite.show()
	smoke_particles.emitting = true
	health_bar.hide()
	GameManager.add_score(score_value)
	var rage_text = TEMP_TEXT_LABEL.instantiate()
	var score_text = TEMP_TEXT_LABEL.instantiate()
	self.add_child(rage_text)
	self.add_child(score_text)
	rage_text.set_color(Color.DARK_RED)
	score_text.set_color(Color.YELLOW)
	rage_text.set_text("+" + str(rage_value))
	score_text.set_text("+" + str(score_value))
	rage_text.global_position = health_bar.global_position + Vector2(20,0)
	score_text.global_position = health_bar.global_position + Vector2(-20,0)
	rage_text.trigger()
	score_text.trigger()


func take_damage(damage_taken:int) -> bool:
	if(health>0):
		#Set new health
		health -= damage_taken
		
		#Change Fill Bar
		health_bar.value=health
		health_bar.show()
		
		#Break if lower than 0
		if (health<=0):
			self.break_object()
			return true
			
	return false

func get_rage_amount():
	return rage_value

func regenerate_object():
	health = max_health
	unbroken_sprite.show()
	broken_sprite.hide()
	initialize_health_bar()
	health_bar.show()

func deal_50_damage_to_self_test():
	take_damage(50)
