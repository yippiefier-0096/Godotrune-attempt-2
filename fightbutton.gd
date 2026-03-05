extends main_button
class_name fightbutton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.theme_type_variation="fightbutton"
	super()
	self.context_pass=BattleManager.actioncontext.attack
	self.option_type_called=char_option
	self.replacer.texture=load("uid://drqslf6j07v3l")
	pass # Replace with function body.
func _pressed() -> void:
	UiManager.create_page_v(BattleManager.enemy_team,0,option_type_called)
	BattleManager.temp_action[0]=self.context_pass
	self.self_modulate.a=0
	replacer.visible=true
	UiManager.ui_backtrack.append(Callable(UiManager.menu_b,"layer_on"))
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
