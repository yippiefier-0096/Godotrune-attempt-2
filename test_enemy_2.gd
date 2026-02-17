extends battle_profile
class_name enemy2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	atk=5
	def=2
	mag=0
	max_hp=100
	hp=max_hp
	attack_patterns=[test_pattern_icee]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
