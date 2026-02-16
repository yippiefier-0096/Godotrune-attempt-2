extends bullet_base
class_name test_bullet

func _ready() -> void:
	invulnerable=1.2
	super()
	graphics.sprite_frames.add_frame("default",load("uid://bsn7xvmsik0hb"))
	initial_velocity= Vector2(randf_range(0.5,-0.5),-1.8)
	pass # Replace with function body.

func behavior(life:float):
	if life==0:
		self.position=BattleManager.position+Vector2(randf(),randf())*8
	elif life<=2:
		self.position+=initial_velocity
		initial_velocity+=Vector2(0,0.05)
	elif life<=7:
		self.position+=Vector2(0.8,0)
	else:
		self.queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
