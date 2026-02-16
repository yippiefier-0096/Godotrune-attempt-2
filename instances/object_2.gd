extends objects


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var collision:CollisionShape2D=CollisionShape2D.new()
	self.add_child(collision)
	collision.shape=RectangleShape2D.new()
	pass # Replace with function body.

func _interact():
	#insert interaction
	DialogueManager.add_line("...")
	if interact_count==4:
		DialogueManager.add_line("Will you just quit it already?")
	DialogueManager.read_dialogue()
	interact_count+=1
	print(self.interact_count)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
