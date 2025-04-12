extends RayCast2D

func deal_damage() -> void:
	if not is_colliding():
		return
	var collider = self.get_collider()
	add_exception(self.get_collider())
	if collider is BreakableObject:
		collider.take_damage(50)
		print(collider)
	print("adding exception")

	
