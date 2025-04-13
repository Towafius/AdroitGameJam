extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var sprite: Sprite2D = $Sprite

const coworker_sprites = [preload("res://Art/Coworker.png"), preload("res://Art/coworker 2.png")]
const SPEED = 40


var current_speed = SPEED
var last_direction = Vector2(0,1)

enum states{
	FOLLOW,
	RETREAT,
	ATTACK,
}

var state := states.FOLLOW

func _ready() -> void:
	sprite.texture = coworker_sprites.pick_random()
	nav_agent.target_position = player.global_position
	state = states.FOLLOW

func _physics_process(delta: float) -> void:
	if state == states.FOLLOW:
		if self.global_position.distance_to(player.global_position) < 40:
			state = states.ATTACK
	
	elif state == states.ATTACK:
		if self.global_position.distance_to(player.global_position) >= 40:
			state = states.FOLLOW
			
	var next_position = nav_agent.get_next_path_position()
	#var distance = global_position.distance_to(player.global_position)
	var direction:Vector2=Vector2.ZERO
	match state:
		states.FOLLOW:
			direction = global_position.direction_to(next_position)
		states.RETREAT:
			direction = -global_position.direction_to(next_position)
		states.ATTACK:
			direction = global_position.direction_to(player.global_position).normalized()
	
	if direction:
		velocity.x = direction.x * current_speed
		velocity.y = direction.y * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.y = move_toward(velocity.y, 0, current_speed)

	_handle_animation(direction)

	if(self.global_position.distance_to(player.global_position) <= 10):
		if player.get_caught():
			state = states.RETREAT
			var tween = get_tree().create_tween()
			tween.tween_property(sprite, "modulate", Color(1,1,1,0), 3.0)
			tween.tween_callback(queue_free)
	
	if(direction):
		last_direction = direction

	move_and_slide()


func _on_nav_refresh_timeout() -> void:
	nav_agent.target_position = player.global_position


func _on_navigation_agent_2d_target_reached() -> void:
	_on_nav_refresh_timeout()

func _handle_animation(direction:Vector2):
	if(direction.is_equal_approx(Vector2.ZERO)):
		if abs(last_direction.x) > abs(last_direction.y):
			if last_direction.x > 0:
					animation_player.play("idle_right")
			else:
				animation_player.play("idle_left")
		elif last_direction.y:
			if last_direction.y > 0:
				animation_player.play("idle_down")
			else:
				animation_player.play("idle_up")
		else:
			animation_player.play("idle_down")
	else:
		if abs(last_direction.x) > abs(last_direction.y):
			if direction.x > 0:
				if(global_position.distance_to(player.global_position)<50):
					animation_player.play("run_grab_right")
				else:
					animation_player.play("walk_right")
			else:
				if(global_position.distance_to(player.global_position)<50):
					animation_player.play("run_grab_left")
				else:
					animation_player.play("walk_left")
		else:
			if direction.y > 0:
				if(global_position.distance_to(player.global_position)<50):
					animation_player.play("run_grab_down")
				else:
					animation_player.play("walk_down")
			else:
				if(global_position.distance_to(player.global_position)<50):
					animation_player.play("run_grab_up")
				else:
					animation_player.play("walk_up")
