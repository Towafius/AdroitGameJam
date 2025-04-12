extends Node2D

@onready var weapon_animator: AnimationPlayer = $WeaponAnimator
@onready var attack_timer: Timer = $Attack_Timer

enum Attacks{
	swing,
	swing2
}

var last_attack:int=-1
var can_attack:bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("attack") && can_attack:
		if(last_attack != Attacks.swing):
			last_attack = Attacks.swing
			weapon_animator.play("Swing")
		else:
			last_attack = Attacks.swing2
			weapon_animator.play("Swing_2")
		attack_timer.start()
		can_attack = false


func _on_attack_timer_timeout() -> void:
	can_attack = true
