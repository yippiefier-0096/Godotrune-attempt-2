extends main_button
class_name actbutton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.theme_type_variation="actbutton"
	super()
	self.option_type_called=char_option_act
	self.context_pass=BattleManager.actioncontext.act
	self.replacer.texture=load("uid://cyqtsn82mrsep")
	pass # Replace with function body.
func _pressed() -> void:
	UiManager.create_page_v(BattleManager.enemy_team,0,option_type_called)
	self.self_modulate.a=0
	replacer.visible=true
	UiManager.ui_backtrack.append(Callable(UiManager.menu_b,"layer_on"))
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
