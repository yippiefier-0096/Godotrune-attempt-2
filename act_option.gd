extends battle_option
class_name act_option

var this_act:Dictionary
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
##[arg my_owner refers to the target character that spawned this act list.
func _init(x:int,y:int,my_owner:battle_profile,my_page:int) -> void:
	superprep(x,y,my_owner,my_page)
	this_act=my_owner.active_act[2*y+x+6*my_page]
	self.dialog.text=this_act["name"]
	if self.this_act.get("assist"):
		var assist_cache:Array=self.this_act.get("assist")
		print (assist_cache)
		for i in assist_cache.size():
			dialog.text="[img]"+globals.assist_icon.get(assist_cache[i])+"[/img]"+dialog.text
			print (globals.assist_icon.get(assist_cache[i]))
	self.focus_entered.connect(UiManager.set_desc.bind(this_act["b_desc"],this_act["cost"]))
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _pressed():
	print("1")
	if BattleManager.tp_gauge<this_act.get("cost"):
		return
	print("2")
	var assist_cache:Array
	var assisted:Array[int]=[]
	if self.this_act.has("assist"):
		assist_cache=self.this_act.get("assist").duplicate()	
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
	BattleManager.temp_action[3]=this_act["function"]#action (callable)
	BattleManager.temp_action[5]=assisted#everyone that helped (array[int of index of party members])
	BattleManager.tp_use_cache[BattleManager.turn_order]=this_act.get("cost")
	UiManager.ui_backtrack.append(UiManager.create_page_h.bind(root_character,on_page,self.get_script(),pos.x+pos.y*2))
	BattleManager.next_turn()	
	pass
