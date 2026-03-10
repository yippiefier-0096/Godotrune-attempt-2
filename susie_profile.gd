extends battle_profile
class_name susie_profile

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(2.0).timeout
	char_id=1
	atk=7
	def=2
	mag=4
	max_hp=230
	hp=max_hp
	Inventory.equip_armor(0,self,0)
	Inventory.equip_armor(1,self,1)
	Inventory.equip_weapon(1,self)
	self.nametag="SUSIE"
	assist_icon="uid://dktm0kdxfba65"
	power_list={
		0:{
			"name":"S-Action",
			"b_desc":"",
			"cost":0,
			"target_mode":target_style.single_enemy,
			"function":int(0)
		}
	}
	active_power=[power_list[0]]
	#load from 2nd character data slot
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
