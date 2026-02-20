extends Node2D
## Autoload Node that facilitates turn based battles by managing [battle_profile]s. 
class_name battle_manager
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
## 
var turn_action:Array=[]
##the battle option the player is currently hovering over. x is left/right, y is up/down, z is layer (context).
var selection:Vector3i=Vector3i(0,0,0)
## the boundary that [member selection] cannot exceed. the four entries are respectively x lowerbound, x upperbound, y lowerbound, y upperbound.
var selection_bound:Array[int]=[0,5,0,1]
##remembers the menus opened for backtracking purposes. [br] specifically, records [member selection.z].
var context_history:Array[int]

var current_char:battle_profile

func _ready() -> void:
	pass
	
func battle_start():
	my_turn()
	pass
	
func my_turn():
	globals.mode=globals.mode_index.battle_turn
	turn_action=[]
	turn_order=0

func character_turn():
	current_char=globals.ally_list[turn_order].profile
	selection_bound=[0,5,0,1]

func turn_consequence():
	for i in turn_action.size():
		pass
	globals.mode=globals.mode_index.battle_turn

func enemy_turn():
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
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("right"):
		selection.x+=1
	if event.is_action_pressed("left"):
		selection.x-=1
	if event.is_action_pressed("up"):
		selection.y-=1
	if event.is_action_pressed("down"):
		selection.y+=1
	selection.x=wrapi(selection.x,selection_bound[0],selection_bound[1])
	selection.y=wrapi(selection.y,selection_bound[2],selection_bound[3])
	pass

func _process(delta: float) -> void:
	
	pass
