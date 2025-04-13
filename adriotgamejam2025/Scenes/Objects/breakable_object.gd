extends StaticBody2D

class_name BreakableObject

@export var max_health:int = 50
@export var rage_value:float = max_health/5

@onready var unbroken_sprite: Sprite2D = $UnbrokenSprite
@onready var broken_sprite: Sprite2D = $BrokenSprite
@onready var health_bar: TextureProgressBar = $HealthBar
@onready var smoke_particles: GPUParticles2D = $SmokeParticles

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

func take_damage(damage_taken:int):
	if(health>0):
		#Set new health
		health -= damage_taken
		
		#Change Fill Bar
		health_bar.value=health
		health_bar.show()
		
		#Break if lower than 0
		if (health<=0):
			self.break_object()

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
