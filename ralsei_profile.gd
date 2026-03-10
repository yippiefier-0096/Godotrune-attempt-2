extends battle_profile
class_name ralsei_profile

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	char_id=2
	atk=3
	def=2
	mag=6
	max_hp=180
	hp=max_hp
	assist_icon="uid://bssag1p2qhvin"
	nametag="RALSEI"
	power_list={
		0:{
			"name":"R-Action",
			"b_desc":"",
			"cost":0,
			"target_mode":target_style.single_enemy,
			"function":int(0)
		}
	}
	active_power=[power_list[0]]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
