extends battle_profile
class_name kris_profile

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_hp=200
	hp=max_hp
	atk=7
	def=2
	mag=0
	button_config=[fightbutton,actbutton,itembutton,mercybutton,defendbutton]
	nametag="KRIS"
	char_id=0
	char_color=Color(0.0, 0.635, 0.91, 1.0)
	power_list={
		0:{
			"name":"K-Action",
			"b_desc":"",
			"cost":0,
			"target_mode":target_style.single_enemy,
			"function":int(0)
		},
		1:{
			"name":"Courage",
			"desc":"Weave the power of your SOUL to defend allies.",
			"b_desc":"Defense UP",
			"cost":250,
			"target_mode":target_style.all_allies,
			"function":courage
		},
		2:{
			"name":"Red Buster",
			"desc":"Shine your soul on Susie's hopeful heart.",
			"b_desc":"RED damage",
			"cost":500,
			"target_mode":target_style.single_enemy,
			"function":redbuster,
			"assist":[susie_profile]
		},
		3:{
			"name":"OmniHeal",
			"desc":"Immense healing with the power of four souls.",
			"b_desc":"Everyone heals",
			"cost":760,
			"target_mode":target_style.all_allies,
			"function":redbuster,
			"assist":[susie_profile,ralsei_profile,noelle_profile]
		}
	}
	active_power=[power_list[1],power_list[2],power_list[3]]
	set_avatar()
	pass # Replace with function body.

func courage(targets:Array[battle_profile]):
	DialogueManager.add_line("Your SOUL shines with a brilliant light...!")
	DialogueManager.add_line("Kris uses Courage! [br]Everyone's DEF UP!")
	targets[0].def_aug[3]+=4
func redbuster(targets:Array[battle_profile]):
	DialogueManager.add_line("Your SOUL shines its light unto Susie...!")
	DialogueManager.add_line("Susie shot RED BUSTER toward {0}!",[targets[0].nametag])
	targets[0].receive_damage(self,240,["rude"])
func quadheal(targets:Array[battle_profile]):
	DialogueManager.add_line("waow!!!!!!!!")
	for i in targets.size():
		
		pass
	pass	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
