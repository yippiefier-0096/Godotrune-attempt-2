extends Node
class_name equipment_base

var is_equipped=false
var equippable_id:Array[int]=[0,1,2,3]

var atk_arg:int=0
var def_arg:int=0
var mag_arg:int=0
var atk_bonus:float=0.0
var def_bonus:float=0.0
var mag_bonus:float=0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func equip(target:battle_profile,slot:int):
	if target.equipped_armors[slot]:
		target.equipped_armors[slot].is_equipped=false
	self.is_equipped=true
	target.equipped_armors[slot]=self
	target.atk_aug[1+slot]=self.atk_arg+target.atk*self.atk_bonus
	target.def_aug[1+slot]=self.def_arg+target.def*self.def_bonus
	target.mag_aug[1+slot]=self.mag_arg+target.mag*self.mag_bonus
	print(target,target.equipped_armors,slot)
	pass

func start_effect(target:battle_profile):
	pass

func passive_effect(target:battle_profile):
	print("not an equipment at all")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
