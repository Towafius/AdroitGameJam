extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

const SPEED = 100

var last_direction = Vector2(0,1)

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down")).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.y = direction.y * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	_handle_animation(direction)

	if(direction):
		last_direction = direction

	move_and_slide()


func _handle_animation(direction:Vector2):
	if(direction.is_equal_approx(Vector2.ZERO)):
		if last_direction.x:
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
		if direction.x:
			if direction.x > 0:
				animation_player.play("walk_right")
			else:
				animation_player.play("walk_left")
		else:
			if direction.y > 0:
				animation_player.play("walk_down")
			else:
				animation_player.play("walk_up")
