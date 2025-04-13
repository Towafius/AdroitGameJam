extends TextureProgressBar

@onready var decay_rate_label: Label = $DecayRate
@onready var player_sprite: Sprite2D = $"../../../PlayerSprite"
@onready var player: CharacterBody2D = $"../../.."

@export var decay_rate :float = 3

signal rage_over

var rage_amount:float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.value = self.max_value
	rage_amount = self.max_value
	decay_rate_label.text = "-" + str(float(int(decay_rate*100))/100)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player.caught_meter > 0:
		rage_amount -= decay_rate*delta*1.5
		decay_rate_label.text = "-" + str((float(int(decay_rate*100*1.5))/100))
	else:
		rage_amount -= decay_rate*delta
		decay_rate_label.text = "-" + str(float(int(decay_rate*100))/100)
	decay_rate += .05 * delta
	
	if(self.value <= 0):
		rage_over.emit()
		set_process(false)
	player_sprite.set_modulate(Color(1, 1-(self.value/150), 1-(self.value/150)))
	self.value = rage_amount

func add_rage(amount:int):
	rage_amount+=amount
