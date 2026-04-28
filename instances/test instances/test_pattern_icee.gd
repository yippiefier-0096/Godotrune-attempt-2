extends bullet_pattern_base
class_name test_pattern_icee

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in 4000:
		add_child(icee_bullets.new())
		await get_tree().create_timer(0.5).timeout
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
