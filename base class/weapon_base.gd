extends Node
## Base class of every weapon that exists in the game.
## [br][br]Different weapons are represented by different classes that extend from this.
class_name weapon_base

## Variable keeping track of which [battle_profile] is equipping this. While unused by any character, it is null.
var is_equipped:battle_profile

## (uninplemented) Array of character IDs. Any [battle_profile] without its [member battle_profile.char_id] included in this cannot equip the item.
var equippable_id:Array[int]=[0,1,2,3]

## flat modifier of the user's attack.
var atk_arg:int=0
## flat modifier of the user's defence.
var def_arg:int=0
## flat modifier of the user's magic.
var mag_arg:int=0
## multiplier of the user's innate attack.
var atk_bonus:float=0.0
## multiplier of the user's innate defense.
var def_bonus:float=0.0
## multiplier of the user's innate magic.
var mag_bonus:float=0.0

var strike_type:battle_strike_bar.pattern_lookup=battle_strike_bar.pattern_lookup.LINEAR
func _ready() -> void:
	
	pass 

## If and only if not equipped (I.e. [member is_equipped] is null) be equipped to [param target] and give it this equipment's stat bonus.
func equip(target:battle_profile):
	if self.is_equipped==target:
		print("I'm already wearign this")
	elif self.is_equipped:
		print("Item not available")
		pass
	else:
		if target.equipped_weapon:
			target.equipped_weapon.is_equipped=null
		self.is_equipped=target
		target.equipped_weapon=self
		target.atk_aug[0]=self.atk_arg+target.atk*self.atk_bonus
		target.def_aug[0]=self.def_arg+target.def*self.def_bonus
		target.mag_aug[0]=self.mag_arg+target.mag*self.mag_bonus
		pass
## if and only if equipped, unequip self from [member is_equipped].
func unequip():
	if self.is_equipped:
		self.is_equipped.equipped_weapon=Inventory.no_weapon
		self.is_equipped.atk_aug[0]=0
		self.is_equipped.def_aug[0]=0
		self.is_equipped.mag_aug[0]=0
		self.is_equipped=null
	pass
	
## effect that happens at the start of a battle.
func start_effect(target:battle_profile):
	pass

##effect that happens every turn.
func passive_effect(target:battle_profile):
	print("I am not being worn by ", target)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
