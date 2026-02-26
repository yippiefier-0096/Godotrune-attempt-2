extends Node2D
## Autoload Node that facilitates turn based battles by managing [battle_profile]s. 
class_name battle_manager
## enumerator that notates details about an action, for the purpose of executing them in a consistent order
enum actioncontext{skipped,attack,act,skill,item,mercy}

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


var turn_order:int=0
## for each entry: [a:int=action context, i:int=the receiver's index, t:array= context, call:Callable=the function that performs the effect]
var turn_action:Array=[]
##the battle option the player is currently hovering over. x is left/right, y is up/down, z is layer (context).


var current_char:battle_profile



func _ready() -> void:
	
	pass
	
func battle_start():
	my_turn()
	pass
	
func my_turn():
	if globals.mode==globals.mode_index.overworld:
		globals.mode=globals.mode_index.battle_turn
		for i in globals.ally_list:
			turn_action.append([0,0,0,null])
		turn_order=0
		character_turn()

func character_turn():
	if UiManager.menu_b:
		UiManager.queue_free()
	current_char=globals.ally_list[turn_order].profile
	UiManager.menu_b=battle_ui.new(current_char)
	UiManager.add_child(UiManager.menu_b)

func turn_consequence():
	for i in turn_action.size():
		pass
	globals.mode=globals.mode_index.battle_turn

func enemy_turn():
	if UiManager.menu_b:
		UiManager.queue_free()
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
		my_turn()
	pass

func _process(delta: float) -> void:
	
	pass
#below are functions that sorts out viable lists for character selection via map()
