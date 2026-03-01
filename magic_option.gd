extends battle_option
class_name magic_option
##the individual skill for every single button of this class
var skill_held:Dictionary
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
func _init(x:int,y:int,my_owner:battle_profile,my_page:int) -> void:
	superprep(x,y,my_owner,my_page)
	skill_held=root_character.active_power[2*y+x+6*my_page]
	self.dialog.text=skill_held["name"]
	self.focus_entered.connect(UiManager.set_desc.bind(skill_held["b_desc"],skill_held["cost"]))
	
func _pressed():
	BattleManager.turn_action[BattleManager.turn_order][3]=skill_held["function"]
	match skill_held["target_mode"]:
		battle_profile.target_style.single_enemy:
			UiManager.create_page_v(BattleManager.enemy_team,0,char_option)
		battle_profile.target_style.single_ally:	
			UiManager.create_page_v(globals.ally_list,0,char_option)
		_:
			BattleManager.turn_action[BattleManager.turn_order][1]=-1
			BattleManager.next_turn()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
