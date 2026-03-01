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

var item_use_cache:Array[item_base]

var tp_use_cache:Array[float]

var turn_order:int=0
## for each entry: [a:int=action context, i:int=the receiver's index, t:array=battle context, call:Callable=the function that performs the effect]
var turn_action:Array=[]
##the battle option the player is currently hovering over. x is left/right, y is up/down, z is layer (context).


var current_char:battle_profile

var x:int=0

func _ready() -> void:
	pass
	
func battle_start():
	if turn_action.is_empty():
		my_round()
	pass
	
func my_round():
	turn_action=[]
	tp_use_cache=[]
	item_use_cache=[]
	globals.mode=globals.mode_index.battle_turn
	for i in globals.ally_list:
		turn_action.append([0,0,0,null])
		tp_use_cache.append(0)
	turn_order=0
	character_turn()

func character_turn():
	for i in UiManager.battle_option_array.size():
		UiManager.battle_option_array.pop_back().queue_free()
	if UiManager.menu_b:
		UiManager.menu_b.queue_free()
	current_char=globals.ally_list[turn_order]
	UiManager.menu_b=battle_ui.new(current_char)
	UiManager.add_child(UiManager.menu_b)
	print(turn_action)
func next_turn():
	UiManager.ui_backtrack=[]
	turn_order+=1
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
		BattleManager.tp_gauge+=	BattleManager.tp_use_cache[turn_order]
		BattleManager.tp_use_cache[turn_order]=0
		turn_order-=1
		while turn_action[turn_order][0]==actioncontext.skipped and turn_order>0:
			turn_order-=1
	turn_action[turn_order]=[0,0,0,null]	
	UiManager.ui_backtrack=[]
	character_turn()
func round_consequence():
	if UiManager.menu_b:
		UiManager.menu_b.queue_free()
	for i in UiManager.battle_option_array.size():
		UiManager.battle_option_array.pop_back().queue_free()
	
	globals.mode=globals.mode_index.battle_turn
	enemy_turn()
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
		end_battle()
	pass
func end_battle():
	
	if soul_normal:
		soul_normal.queue_free()
	for i in UiManager.battle_option_array.size():
		UiManager.battle_option_array.pop_back().queue_free()
	if UiManager.menu_b:
		UiManager.menu_b.queue_free()
	for i in enemy_team.size():
		enemy_team.pop_back().queue_free()
	turn_action=[]
	DialogueManager.add_line("Battle ended. you get nothing lmao")
	await DialogueManager.read_dialogue()
	globals.mode=globals.mode_index.overworld
	pass
func _process(delta: float) -> void:
	
	pass
#below are functions that sorts out viable lists for character selection via map()
