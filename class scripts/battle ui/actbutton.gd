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
	var list_with_acts:Array[battle_profile]=BattleManager.enemy_team.duplicate(true)
	list_with_acts.append_array(globals.ally_list)
	list_with_acts=list_with_acts.filter(func(x:battle_profile):return !x.active_act.is_empty())
	UiManager.create_page_v(list_with_acts,0,option_type_called)
	BattleManager.temp_action[0]=BattleManager.actioncontext.act
	self.self_modulate.a=0
	replacer.visible=true
	UiManager.ui_backtrack.append(Callable(UiManager.menu_b,"layer_on"))
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
