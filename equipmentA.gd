extends equipment_base
class_name equipmentA

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.atk_arg=3
	self.def_arg=5
	self.def_bonus=2.0
	pass # Replace with function body.

func passive_effect(target:battle_profile):
	print("I am being equipped by", target)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
