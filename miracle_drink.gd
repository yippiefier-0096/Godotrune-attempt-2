extends item_base
class_name miracle_drink

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func use(target:battle_profile):
	target.turn_effect.append(Callable(Effects,"hp_up"))
	target.turn_timer.append(3)
# Called every frame. 'delta' is the elapsed time since the previous frame.
	

func _process(delta: float) -> void:
	pass
