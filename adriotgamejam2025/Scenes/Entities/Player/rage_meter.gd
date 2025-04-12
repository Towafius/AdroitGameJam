extends ProgressBar

@onready var decay_rate_label: Label = $DecayRate

@export var decay_rate :float = 3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.value = self.max_value
	decay_rate_label.text = "-" + str(float(int(decay_rate*100))/100)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.value -= decay_rate*delta
	decay_rate += .05 * delta
	decay_rate_label.text = "-" + str(float(int(decay_rate*100))/100)
	if(self.value <= 0):
		set_process(false)
