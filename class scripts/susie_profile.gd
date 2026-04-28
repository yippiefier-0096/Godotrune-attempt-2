extends battle_profile
class_name susie_profile

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	char_id=1
	atk=7
	def=2
	mag=4
	max_hp=230
	hp=max_hp
	self.nametag="SUSIE"
	power_list={
		0:{
			"name":"S-Action",
			"b_desc":"",
			"cost":0,
			"target_mode":target_style.single_enemy,
			"function":int(0)
		},
		1:{
			"name":"Rude Buster",
			"desc":"Deals moderate Rude-elemental damage to one foe. Depends on Attack and Magic.",
			"b_desc":"Rude Damage",
			"cost":50,
			"target_mode":target_style.single_enemy,
			"function":null
		},
		2:{}
		
	}
	active_power=[power_list[0]]
	set_avatar()
	#load from 2nd character data slot
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
