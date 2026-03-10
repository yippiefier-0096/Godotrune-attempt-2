extends battle_profile
class_name noelle_profile

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	char_id=3
	atk=2
	def=1
	mag=9
	max_hp=150
	hp=max_hp
	power_list={
		0:{
			"name":"N-Action",
			"b_desc":"",
			"cost":0,
			"target_mode":target_style.single_enemy,
			"function":int(0)
		},
		1:{
			"name":"IceShock",
			"desc":"Attack with cooling air",
			"b_desc":"Icy strike",
			"cost":80,
			"target_mode":target_style.single_enemy,
			"function":iceshock
		},
		2:{},
		3:{}
	}
	active_power=[power_list[0],power_list[1]]
	nametag="NOELLE"
	pass # Replace with function body.

func iceshock(targets:Array[battle_profile]):
	DialogueManager.add_line("Noelle casted IceShock on [0]!",[targets[0].nametag])
	var effective_mag=mag+mag_aug.reduce(func(accum:int,x:int):return accum+x)
	var effective_output=effective_mag*13
	targets[0].receive_damage(self,effective_output,["ice"])
	await DialogueManager.read_dialogue()
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
