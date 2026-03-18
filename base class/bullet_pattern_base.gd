extends Node
## Base class for events where bullets spawn as a part of an attack.
##
## Nodes that extend off this script are each their own "attack pattern" that instanciates various bullets in different ways.
## [br][br]Each attack should incorporate an [member intensity] stat to be balanced when used in tendem with other attacks.
## [br][br]Each enemies' profiles would contain a number of these to choose from when prompted at the end of the player's turn.
class_name bullet_pattern_base

var intensity:float=1
var soul_mode:GDScript
var attack_length:float=10
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
func _init(_intensity:float=1) -> void:
	self.intensity=_intensity
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
