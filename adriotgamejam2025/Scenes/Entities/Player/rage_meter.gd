extends TextureProgressBar

@onready var decay_rate_label: Label = $DecayRate
@onready var player_sprite: Sprite2D = $"../../PlayerSprite"

@export var decay_rate :float = 3

var rage_amount:float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.value = self.max_value
	rage_amount = self.max_value
	decay_rate_label.text = "-" + str(float(int(decay_rate*100))/100)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rage_amount -= decay_rate*delta
	decay_rate += .05 * delta
	decay_rate_label.text = "-" + str(float(int(decay_rate*100))/100)
	if(self.value <= 0):
		set_process(false)
	player_sprite.set_modulate(Color(1, 1-(self.value/150), 1-(self.value/150)))
	self.value = rage_amount
