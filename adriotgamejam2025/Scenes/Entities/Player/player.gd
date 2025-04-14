extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var grace_period_timer: Timer = $GracePeriodTimer
@onready var caught_bar: Node2D = $CaughtBar
@onready var texture_progress_bar: TextureProgressBar = $CaughtBar/TextureProgressBar


const SPEED = 75

var last_direction = Vector2(0,1)
var caught_meter = 0 
var times_caught = 0
var grace_period_active := false

func _ready() -> void:
	GameManager.reset_repairables()
	GameManager.reset_score()

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Vector2.ZERO
	if(Input.is_action_just_pressed("escape")):
		_escape_attempt()
		
	if (caught_meter <= 0):
		direction = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down")).normalized()

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

func _escape_attempt():
	if caught_meter >0:
		caught_meter-=1
		texture_progress_bar.value = caught_meter
		print(caught_meter)
		if caught_meter <= 0:
			caught_bar.hide()
			grace_period_timer.start()

func _handle_animation(direction:Vector2):
	if(caught_meter <= 0):
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
	else:
		animation_player.play("caught_left")

func get_caught():
	if(grace_period_active):
		return false
	caught_bar.show()
	grace_period_active = true
	caught_meter = 5 + times_caught
	texture_progress_bar.max_value = caught_meter
	texture_progress_bar.value = caught_meter
	times_caught+=1
	return true


func _on_grace_period_timer_timeout() -> void:
	grace_period_active = false
