extends weapon_base
class_name practice_axe

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	atk_arg=3
	def_arg=1
	mag_arg=2
	atk_bonus=0.5
	def_bonus=0.2
	mag_bonus=1.0
	pass # Replace with function body.
func start_effect(target:battle_profile):
	
	pass

func passive_effect(target:battle_profile):
	print("I am being worn by ", target," and im weak as fuuuuuuuuu")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
