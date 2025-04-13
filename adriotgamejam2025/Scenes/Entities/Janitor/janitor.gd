extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var sprite: Sprite2D = $Sprite

const SPEED = 80


var current_speed = SPEED
var last_direction = Vector2(0,1)
var repairables:=[]
var active_target
var done:bool = false

func _ready() -> void:
	repairables = GameManager.pop_repairables()
	print(repairables)
	_find_next_repair()

func _physics_process(delta: float) -> void:
	var next_position = nav_agent.get_next_path_position()
	#var distance = global_position.distance_to(player.global_position)
	var direction = global_position.direction_to(next_position)
	
	if direction && !done:
		velocity.x = direction.x * current_speed
		velocity.y = direction.y * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.y = move_toward(velocity.y, 0, current_speed)

	_handle_animation(direction)

	if(direction):
		last_direction = direction

	move_and_slide()

func _find_next_repair():
	var list_size = repairables.size()
	print(list_size)
	if list_size <= 0:
		print(str(list_size) + " too small")
		var tween = get_tree().create_tween()
		tween.tween_property(sprite, "modulate", Color(1,1,1,0), 3.0)
		tween.tween_callback(queue_free)
		return
	active_target = repairables.pop_at(randi_range(0, list_size-1))
	print(active_target.global_position)
	nav_agent.target_position = active_target.global_position
	nav_agent.set_target_position(active_target.global_position)
	
	print("Active target pos:", active_target.global_position)
	print("Agent current pos:", global_position)
	print("Distance to target:", global_position.distance_to(active_target.global_position))
	

func _on_navigation_agent_2d_target_reached() -> void:
	print("repair reached")
	active_target.regenerate_object()
	_find_next_repair()

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
				animation_player.play("walk_right")
			else:

				animation_player.play("walk_left")
		else:
			if direction.y > 0:
				animation_player.play("walk_down")
			else:
				animation_player.play("walk_up")
