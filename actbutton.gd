extends main_button
class_name actbutton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.theme_type_variation="actbutton"
	super()
	self.option_type_called=char_option
	self.context_pass=BattleManager.actioncontext.act
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
