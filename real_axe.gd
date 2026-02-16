extends weapon_base
class_name real_axe

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	atk_arg=9
	atk_bonus=2.0
	pass # Replace with function body.

func start_effect(target:battle_profile):
	pass
func passive_effect(target:battle_profile):
	print("I am being worn by ",target, "and im powerful as fuuuuuuuuuuuck")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
