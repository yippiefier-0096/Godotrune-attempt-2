extends HBoxContainer
class_name battle_direction

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.size=Vector2(200,200)
	self.add_child(actbutton.new())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
