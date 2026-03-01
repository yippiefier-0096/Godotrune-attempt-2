extends char_option
class_name char_option_act

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.

func _pressed() -> void:
	UiManager.ui_backtrack.append(UiManager.create_page_v.bind(target_group,on_page,self.get_script(),pos.y))
	BattleManager.turn_action[BattleManager.turn_order][1]=pos.y+on_page*3
	BattleManager.turn_action[BattleManager.turn_order][2]=target_group
	print (target_group,on_page,self.get_script(),pos.y)
	if !is_self_act:
		UiManager.create_page_h(target_group[pos.y+on_page*3],0,act_option)
	else:
		UiManager.create_page_h(BattleManager.current_char,0,magic_option)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
