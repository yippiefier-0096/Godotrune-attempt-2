extends Node
## An Autoload Node containing a method for every skill, item, or weapon effect in-game.
class_name effects
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
## Simple test effect that increases the [param target]'s maximum HP each time it is triggered.

func hp_up(target:battle_profile):
	target.max_hp+=20
	print(target.max_hp)
