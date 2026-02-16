extends Node
## Autoload Class that keeps track of player items at all time. 
class_name inventory

## Dummy reference to replace empty equipment slots for [battle_profile]s.
var no_weapon:weapon_base=empty_weapon.new()
## Dummy reference to replace empty equipment slots for [battle_profile]s.
var no_armor:equipment_base=empty_armor.new()

##list of every item the player possesses.
var item_content:Array[item_base]
##list of every piece of equipment the player possesses.
var equip_content:Array[equipment_base]
##list of every weapon the player possesses.
var weapon_content:Array[weapon_base]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in 12:
		var _i=miracle_drink.new()
		self.item_content.append(_i)
		add_child(_i)
	self.weapon_content.append(practice_axe.new())
	self.weapon_content.append(real_axe.new())
	for i in 5:
		self.equip_content.append(equipmentA.new())
	for i in self.weapon_content.size():
		add_child(self.weapon_content[i])
	print (self.item_content)
	for i in equip_content.size():
		add_child(equip_content[i])
	pass # Replace with function body.

## Applies the effects of the item on index [param which] in [member item_content] into [param on_who]'s [member battle_profile]. [br][br]Specifics of the item's effects are decided in the item's subclass itself.
func use_item(which:int,on_who:Array[battle_profile]):
	if item_content.size()>0:
		for i in on_who.size():
			item_content[which].use(on_who[i])
		if item_content[which].consume_on_use:
			item_content.pop_at(which).queue_free()
	print(item_content)
##equips the [equipment_base] stored in index [param which] of [member equip_content] to [param on_who]'s weapon.
func equip_weapon(which:int, on_who:battle_profile):
	if on_who.equipped_weapon!=weapon_content[which]:
		if on_who.equipped_weapon!=no_weapon:
			on_who.equipped_weapon.unequip()
		weapon_content[which].equip(on_who)
	else:
		on_who.equipped_weapon.unequip()
		#this happens when you click over someone's equipped weapon
	pass
##equips the [equipment_base] stored in index [param which] of [member equip_content] to slot [param what_slot] of [param on_who]'s equipments.
func equip_armor(which:int, on_who:battle_profile, what_slot:int):
	if on_who.equipped_armors.size()<which+1:
		on_who.equipped_armors.append(no_armor)
	if !equip_content[which].is_equipped:
		equip_content[which].equip(on_who,what_slot)
		print (equip_content[which].atk_arg)
		print ("equipped ",on_who.equipped_armors)
		print(on_who.atk_aug)
	else:
		on_who.equipped_armors[what_slot].is_equipped=false
		on_who.equipped_armors[what_slot]=no_armor
		print("i've unequipped thing")
	pass

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
