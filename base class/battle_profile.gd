extends Node
## Base class for characters, ally or foes, that can appear in combat, and is the main way they interact with battles.
## [br][br]A class extending from this is needed for each unique character.
## [br][br]Each instance represents the status and equipment of a character. 

class_name battle_profile 
## the character's id, for identifying purposes.
var char_id:int=0
##the character's maximum HP, past which increasing HP should be ineffective.
var max_hp:int=100
## the character's effective HP.
var hp:int=100
## the character's maximum HP bonuses given by various effects.
var maxhp_aug:Array[int]=[0,0,0,0]
## the character's attack power.
var atk:int=5
## bonus to the character's attack power given by various effects.
var atk_aug:Array[int]=[0,0,0,0]
## the character's defense.
var def:int=2
## bonus to the character's defense given by various effects.
var def_aug:Array[int]=[0,0,0,0]
## the character's magic.
var mag:int=3
## bonus to the character's magic given by various effects.
var mag_aug:Array[int]=[0,0,0,0]
## Used in tendem with [member turn_timer], representing any effect the character is under, from equipment, skills, or otherwise.
var turn_effect:Array[Callable]
## Used in tendem with [member turn_effect], representing the time (in turns) each effect would last.
var turn_timer:Array[int]
##list of attack patterns this character can use, if they're on the enemy roster.
var attack_patterns:Array 
##list of attack patterns this character can use while alone in the enemy team.
var attack_patterns_solo:Array
## the weapon this character currently holds. 
var equipped_weapon:weapon_base=Inventory.no_weapon
## the two pieces of accessories this character currently holds.
var equipped_armors:Array[equipment_base]=[Inventory.no_armor,Inventory.no_armor]
## list of skills. structured like this : [name, description, battle description, tp, callable, target style]
var power_list:Dictionary
##which skills are active
var active_power:Array[Dictionary]
##the character's name
var nametag:String=""
##the character's sleepiness
var sleepy:float=0
##the character's mercy gauge
var mercy:float=0
var can_mercy:bool=true
var teammate:bool=true
##acts toward this character, structered like this: [name, description, tp, callable]
var act_list:Dictionary

var active_act:Array[Dictionary]
##things allies can do to help in battle
var ally_act:Dictionary

var is_ally:bool=false
##The list of five buttons that this character gets to access on the first layer of menu (e.g. kris' second button being ACT instead of MAGIC. eg2. DOG button)
##[br]alternatively, putting classes extended from sprite2d can effectively make a button "disabled" (as if, it's just a sprite)
var button_config:Array[GDScript]=[fightbutton,magicbutton,itembutton,mercybutton,defendbutton]

enum target_style {single_enemy,single_ally,all_enemies,all_allies}
func _ready() -> void:
	
	pass # Replace with function body.
	
func faux_turn():
	
	for i in turn_effect.size():
		if turn_timer[i]>0:
			turn_effect[i].call(self)
		turn_timer[i]-=1
	for i in turn_timer.size():
		if turn_timer[clamp(turn_timer.size()-(i+1),0,9999)]<=0:
			turn_effect.pop_at(clamp(turn_timer.size()-(i+1),0,9999))
			turn_timer.pop_at(clamp(turn_timer.size()-(i+1),0,9999))
		print(turn_effect)
	if self.equipped_weapon:
		self.equipped_weapon.passive_effect(self)
	for i in self.equipped_armors.size():
		self.equipped_armors[i].passive_effect(self)
	print (self.atk_aug)
		

func _input(event: InputEvent) -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func choose_attack(turn:int=0)->bullet_pattern_base:
	if !attack_patterns.is_empty():
		return attack_patterns[randi_range(0,attack_patterns.size()-1)].new()	
	else:
		return null

func choose_attack_solo(turn:int=0):
	if !attack_patterns_solo.is_empty():
		BattleManager.enemy_attacks.append(attack_patterns_solo[randi_range(0,attack_patterns_solo.size()-1)])

func ally_action(id:int,target:battle_profile):
	pass
