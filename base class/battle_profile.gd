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

var out:bool=false

var char_color:Color=Color(0.836, 0.0, 0.0, 1.0)
##The list of five buttons that this character gets to access on the first layer of menu (e.g. kris' second button being ACT instead of MAGIC. eg2. DOG button)
##[br]alternatively, putting classes extended from sprite2d can effectively make a button "disabled" (as if, it's just a sprite)
var button_config:Array[GDScript]=[fightbutton,magicbutton,itembutton,mercybutton,defendbutton]

enum target_style {single_enemy,single_ally,all_enemies,all_allies}

var assist_icon:String

var affinities:Dictionary[String,float]={}

var avatar:actor_base

var enemy_sprite:SpriteFrames

var position_in_team:int
signal intro_finished
func _ready() -> void:
	
	pass # Replace with function body.
func _init(order:int,ally:bool=true) -> void:
	is_ally=ally
	position_in_team=order
	
	pass

	#move to after variables are assigned with start()
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
		
		
func set_avatar():
	if !is_ally:
		avatar=actor_base.new()
		avatar.sprite_frames=enemy_sprite
	else:	
		avatar=party_member.new(position_in_team,char_id)
	add_sibling(avatar)
	avatar.animation_changed.connect(output)
func output():
	print(self.nametag, " changed to ", avatar.animation)
func _input(event: InputEvent) -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func b_intro():
	var target:Vector2
	if is_ally:
		target=util.battle_position_ally.get([globals.ally_list.size(),position_in_team])
	var velocity:float=(avatar.position-target).length()/30
	for i in 31:
		avatar.position=avatar.position.move_toward(target,velocity)
		var temp=afterimage.new(avatar.sprite_frames.get_frame_texture(avatar.animation,avatar.frame),avatar.position,0.5)
		add_sibling(temp)
		await get_tree().physics_frame
	avatar.position=target
	avatar.play("intro")
	await avatar.animation_finished
	print(nametag)
	avatar.play("idle")
	intro_finished.emit()
func choose_attack(turn:int=0)->bullet_pattern_base:
	if !attack_patterns.is_empty():
		return attack_patterns[randi_range(0,attack_patterns.size()-1)].new()	
	else:
		return null
func receive_damage(from:battle_profile,amount:int,d_type:Array[String]=["",""],bypass:bool=false):
	var effective_damage:int=amount
	var effective_max_hp:int=max_hp+maxhp_aug.reduce(func(accum:int,x:int):return accum+x)
	var effective_def=def+def_aug.reduce(func(accum:int,x:int):return accum+x)
	for i in d_type.size():
		effective_damage*=affinities.get(d_type[i],1)
	if !bypass:
		effective_damage-=effective_def*3
	hp-=effective_damage
	if hp <=0:
		if d_type.has("ice") and from.get_script()==noelle_profile:
			pass#iceshock capacity
		leave_violence()
	pass
func choose_attack_solo(turn:int=0):
	if !attack_patterns_solo.is_empty():
		BattleManager.enemy_attacks.append(attack_patterns_solo[randi_range(0,attack_patterns_solo.size()-1)])


	
func leave_mercy():
	BattleManager.battle_s_over_everyone_go_home.connect(self.queue_free)
	out=true
func leave_violence():
	BattleManager.battle_s_over_everyone_go_home.connect(self.queue_free)
	out=true
func leave_sleep():
	BattleManager.battle_s_over_everyone_go_home.connect(self.queue_free)
	out=true

func ally_action(from:battle_profile):
	
	pass

func state_update():
	
	pass
