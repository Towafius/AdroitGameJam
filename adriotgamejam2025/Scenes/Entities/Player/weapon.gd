extends Node2D

@onready var weapon_animator: AnimationPlayer = $WeaponAnimator
@onready var attack_timer: Timer = $Attack_Timer
@onready var attack_area: Area2D = $Sprite2D/AttackArea
@onready var player: CharacterBody2D = $".."
@onready var rage_meter: TextureProgressBar = $"../CanvasLayer/Rage/RageMeter"

enum Attacks{
	swing,
	swing2
}

var last_attack:int=-1
var can_attack:bool = true
@export var is_attacking := false
var attack_exceptions = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("attack") && can_attack && player.caught_meter<=0:
		is_attacking = true
		if(last_attack != Attacks.swing):
			last_attack = Attacks.swing
			weapon_animator.play("Swing")
		else:
			last_attack = Attacks.swing2
			weapon_animator.play("Swing_2")
		attack_timer.start()
		attack_exceptions = []
		can_attack = false
	
	_handle_attack_frame()

func _handle_attack_frame():
	if !is_attacking:
		return
	for body in attack_area.get_overlapping_bodies():
		if body is BreakableObject:
			if !(body in attack_exceptions):
				if body.take_damage(50):
					rage_meter.add_rage(body.get_rage_amount())
				attack_exceptions.append(body)
					
	
	

func _on_attack_timer_timeout() -> void:
	can_attack = true
	is_attacking = false
