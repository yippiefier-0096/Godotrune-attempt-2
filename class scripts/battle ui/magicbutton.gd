extends main_button
class_name magicbutton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	self.theme_type_variation="magicbutton"
	replacer.texture=load("uid://dfg8cxaapr20j")
	option_type_called=magic_option
	self.context_pass=BattleManager.actioncontext.skill
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
