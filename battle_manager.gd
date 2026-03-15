extends Node2D
## Autoload Node that facilitates turn based battles by managing [battle_profile]s. 
class_name battle_manager
## enumerator that notates details about an action, for the purpose of executing them in a consistent order
enum actioncontext{empty,attack,act,skill,item,mercy,ally_action,defending,skipped}

enum targetcontext{friendly, foe, team}
##the soul used for most normal attacks
var soul_normal:heart_shaped_object
## the effective tp the player has. caps at 1000 - effectively 100%.
var tp_gauge:float
##
var enemy_attacks:Array[bullet_pattern_base]
##Time (in seconds) until bullet hell section (enemy turn) ends. decided by the average of each attack in this turn
var bt_timer:float=15
##the enemy roster for any battle.
var enemy_team:Array[battle_profile]

var enemy_team_true:Array[battle_profile]

var item_use_cache:Array[item_base]

var tp_use_cache:Array[float]

var turn_order:int=0
## for each entry: [a:int=action context, i:int=the receiver's index, t:array=battle context, call:Callable=the function that performs the effect, initiater: the one using the attack,target_group:the group the target index is based on. assist members:character whose turn are spent in this action. array of index in party]
var turn_action:Array=[]

var temp_action:Array

var temp_tp:float

var temp_item:int

var current_char:battle_profile

var x:int=0

var move_sequence:Array[int]=[actioncontext.act,actioncontext.mercy,actioncontext.skill,actioncontext.item,actioncontext.attack]

signal battle_s_over_everyone_go_home
func _ready() -> void:
	pass
	
func battle_start():
	globals.mode=globals.mode_index.battle_turn
	var target:Array[Vector2]
	var interval:Array[float]
	for i in globals.ally_list:
			i.b_intro()
	#for i in joined.size():
		#target.append(Vector2(50,50+i*100))
		#interval.append((joined[i].position-target[i]).length()/20.0)

	if turn_action.is_empty():
		my_round()
	pass
	
func my_round():
	enemy_team=enemy_team_true.filter(func(input:battle_profile):return !input.out)
	turn_action=[]
	tp_use_cache=[]
	item_use_cache=[]
	globals.mode=globals.mode_index.battle_turn
	for i in globals.ally_list:
		turn_action.append([0,0,[],null,i,[]])
		tp_use_cache.append(0)
		i.avatar.play("idle")

	turn_order=0
	character_turn()

func character_turn():
	enemy_team=enemy_team_true.filter(func(input:battle_profile):return !input.out)
	for i in UiManager.battle_option_array.size():
		UiManager.battle_option_array.pop_back().queue_free()
	if UiManager.menu_b:
		UiManager.menu_b.queue_free()
	current_char=globals.ally_list[turn_order]
	temp_action=[0,0,[],null,current_char,[]]
	temp_item=-1
	turn_action[turn_order]=[0,0,[],null,current_char,[]]
	UiManager.menu_b=battle_ui.new(current_char,turn_order)
	UiManager.add_child(UiManager.menu_b)
	print(turn_action)
	
	
func next_turn():
	var update_anim:Array[int]=[]
	if  temp_action[0]== actioncontext.item:
		item_use_cache.append(Inventory.item_content.pop_at(temp_item))
	UiManager.ui_backtrack=[]
	turn_action[turn_order]=temp_action
	update_anim.append(turn_order)
	for i in turn_action[turn_order][5]:
		update_anim.append(i)
		BattleManager.turn_action[i][0]=BattleManager.actioncontext.skipped
	turn_order+=1
	print(update_anim)
	for i in update_anim:
		var handled:battle_profile=globals.ally_list[i]
		if !handled.out :
			handled.avatar.play(util.action_ready_anim.get(turn_action[i][0]))
	if turn_order>=turn_action.size():
		round_consequence()
		return
	while turn_action[turn_order][0]==actioncontext.skipped:
		turn_order+=1	
		if turn_order>=turn_action.size():
			round_consequence()
			return
	character_turn()
	pass
func last_turn():
	
	if turn_order>0:
		match BattleManager.turn_action[BattleManager.turn_order][0]:
			BattleManager.actioncontext.item:
				if !BattleManager.item_use_cache.is_empty():
					Inventory.item_content.append(BattleManager.item_use_cache.pop_back())
		turn_order-=1
		while turn_action[turn_order][0]==actioncontext.skipped and turn_order>0:
			turn_order-=1
	for i in turn_action[turn_order][5].size():
		turn_action[turn_action[turn_order][5][i]]=[0,0,[],null,null,[]]
	if turn_action[turn_order][0]==actioncontext.item:
		Inventory.item_content.append(item_use_cache.pop_back())
	turn_action[turn_order]=[0,0,[],null,null,[]]
	BattleManager.tp_gauge+=BattleManager.tp_use_cache[turn_order]
	BattleManager.tp_use_cache[turn_order]=0
	UiManager.ui_backtrack=[]
	for i in globals.ally_list.size():
		var handled:battle_profile=globals.ally_list[i]
		if !handled.out and turn_action[i][0]==0:
			print(turn_action[i][0])
			handled.avatar.play(util.action_ready_anim.get(turn_action[i][0]))
	character_turn()
func round_consequence():
	
	var attackers:Array[battle_profile]
	if UiManager.menu_b:
		UiManager.menu_b.queue_free()
	for i in UiManager.battle_option_array.size():
		UiManager.battle_option_array.pop_back().queue_free()

	for i in move_sequence.size():
		var roster:Array=turn_action.filter(func(x:Array):return x[0]==move_sequence[i])
		for subject in roster:#each character that used a certain category of actions move
			var target:Array[battle_profile]
			enemy_team=enemy_team_true.filter(func(input:battle_profile):return !input.out)
			match subject[1]:
				-1:
					target=BattleManager.enemy_team
				-2:
					target=globals.ally_list
				_:
					var viable:Array[battle_profile]=subject[2].filter(func(input:battle_profile):return !input.out)
					if 	subject[2][subject[1]].out:
						print("switching targets")
						target.append(viable[0])#last bug: Out of bounds get index '0' (on base: 'Array[battle_profile]')
					else:
						target.append(subject[2][subject[1]])
			print(target)
			match i:
				0:
					if subject[3] is int:
						await target[0].ally_action(subject[4])
					else:
						await subject[3].call(target)
					pass#things that happens with using ACTs
				1:
					if target[0].mercy>=1:
						DialogueManager.add_line("{0} spared {1}!",[subject[4].nametag,target[0].nametag])
						target[0].leave_mercy()
					else:
						DialogueManager.add_line("{0} tried to spare {1}...",[subject[4].nametag,target[0].nametag])
						DialogueManager.add_line("But their name wasn't [color=yellow]YELLOW[/color]!")
				2:
					if subject[3] is int:
						await target[0].ally_action(subject[4])
					else:
						await subject[3].call(target)
					pass#using magic skills
				3:
					await subject[3].call(target,subject[4])
					for x in item_use_cache.size():
						item_use_cache.pop_back().queue_free()
					pass#using items
				4:
					DialogueManager.add_line("{0} attacked {1}!",[subject[4].nametag,target[0].nametag])
					attackers.append(subject[4])
			enemy_team=enemy_team_true.filter(func(input:battle_profile):return !input.out)
			await DialogueManager.read_dialogue()
			print(enemy_team)
			if BattleManager.enemy_team.is_empty():
				print("nobody's here")
				end_battle()
				return
	for k in BattleManager.enemy_team.size():
		pass
	await DialogueManager.read_dialogue()
	print(enemy_team)
	if BattleManager.enemy_team.is_empty():
		print("nobody's here")
		end_battle()
		return
	globals.mode=globals.mode_index.battle_turn
	enemy_turn()
func action_groups(case:Array):
	return case[0]==actioncontext.attack
func enemy_turn():
	if UiManager.menu_b:
		UiManager.menu_b.queue_free()
	if globals.mode==globals.mode_index.battle_turn:
		bt_timer=0
		self.position=OverworldTeam.position
		soul_normal=heart_shaped_object.new()
		self.add_child(soul_normal)
		globals.mode=globals.mode_index.battle_dodge
		for i in enemy_team.size():
			var _v=enemy_team[i].choose_attack()
			add_child(_v)
			enemy_attacks.append(_v)
			bt_timer+=enemy_attacks[i].attack_length
		bt_timer/=enemy_attacks.size()	
		await get_tree().create_timer(bt_timer).timeout
		soul_normal.queue_free()
		for i in enemy_attacks.size():
			enemy_attacks.pop_front().queue_free()
		my_round()
		
	pass
func end_battle():
	battle_s_over_everyone_go_home.emit()
	if soul_normal:
		soul_normal.queue_free()
	for i in UiManager.battle_option_array.size():
		UiManager.battle_option_array.pop_back().queue_free()
	if UiManager.menu_b:
		UiManager.menu_b.queue_free()
	enemy_team_true=[]
	enemy_team=[]
	turn_action=[]
	DialogueManager.add_line("Battle ended. you get nothing lmao")
	await DialogueManager.read_dialogue()
	globals.mode=globals.mode_index.overworld
	pass
func _input(event: InputEvent) -> void:
	if !globals.mode==globals.mode_index.battle_turn:
		return
	if event.is_action_pressed("cancel"):
		if !UiManager.ui_backtrack.is_empty():
			UiManager.ui_backtrack.pop_back().call()
		else:
			if BattleManager.turn_order!=0:
				BattleManager.last_turn()
	if event.is_action_pressed("d"):
		end_battle()
func _process(delta: float) -> void:
	
	pass
#below are functions that sorts out viable lists for character selection via map()
