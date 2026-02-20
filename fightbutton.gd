extends Button
class_name fightbutton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.theme_type_variation="fightbutton"
	mouse_filter=Control.MOUSE_FILTER_IGNORE
	size=Vector2(31,26)
	pass # Replace with function body.

func _pressed() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
