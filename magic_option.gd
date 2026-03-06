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
	if self.skill_held.get("assist"):
		var assist_cache:Array=self.skill_held.get("assist")
		print (assist_cache)
		for i in assist_cache.size():
			dialog.text="[img]"+globals.assist_icon.get(assist_cache[i])+"[/img]"+dialog.text
			print (globals.assist_icon.get(assist_cache[i]))
	self.focus_entered.connect(UiManager.set_desc.bind(skill_held["b_desc"],skill_held["cost"]))
	
func _pressed():
	print("1")
	if BattleManager.tp_gauge<skill_held.get("cost"):
		return
	print("2")
	var assist_cache:Array
	var assisted:Array[int]=[]
	if self.skill_held.has("assist"):
		assist_cache=self.skill_held.get("assist").duplicate()	
		for i in globals.ally_list.size():
			if BattleManager.turn_action[i][0]!=BattleManager.actioncontext.empty:
				print (BattleManager.turn_action[i])
				continue
			for j in assist_cache.size():
				if globals.ally_list[i].get_script() == assist_cache[j] and !assisted.has(i):
					assisted.append(i)
		if assisted.size()!=assist_cache.size():
			print(assisted,assist_cache)
			return
	print("3")
	BattleManager.temp_action[3]=skill_held["function"]#action (callable)
	BattleManager.temp_action[5]=assisted#everyone that helped (array[int of index of party members])
	BattleManager.tp_use_cache[BattleManager.turn_order]=skill_held.get("cost")
	UiManager.ui_backtrack.append(UiManager.create_page_h.bind(root_character,on_page,self.get_script(),pos.x+pos.y*2))
	match skill_held["target_mode"]:
		battle_profile.target_style.single_enemy:
			UiManager.create_page_v(BattleManager.enemy_team,0,char_option)
		battle_profile.target_style.single_ally:	
			UiManager.create_page_v(globals.ally_list,0,char_option)
		battle_profile.target_style.all_enemies:
			BattleManager.temp_action[1]=-1#target index
			BattleManager.next_turn()
		battle_profile.target_style.all_allies:
			BattleManager.temp_action[1]=-2
			BattleManager.next_turn()		
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
