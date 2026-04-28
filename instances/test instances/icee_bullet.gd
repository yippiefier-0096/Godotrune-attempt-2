extends bullet_base
class_name icee_bullets


func _ready() -> void:
	invulnerable=0.2
	print(position)
	super()
	graphics.sprite_frames.add_frame("default",load("uid://cwpxqcyp80vu6"))
	initial_velocity= Vector2(randf_range(0.5,-0.5),1)
	pass # Replace with function body.

func behavior(life:float):
	if life<=2:
		self.position+=initial_velocity
	elif life<=7:
		self.position+=Vector2(0.8,0)
	else:
		self.queue_free()
