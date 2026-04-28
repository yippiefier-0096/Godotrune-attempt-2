extends battle_profile
class_name enemy1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	name="enemy 1"
	atk=5
	def=2
	mag=0
	max_hp=100
	hp=max_hp
	attack_patterns=[test_pattern,test_pattern_icee]
	self.nametag="victim :D"
	self.act_list={
		0:{
			"name":"Maim",
			"desc":"Rip and tear",
			"b_desc":"ow.",
			"cost":0,
			"function":self.act1
		},
		1:{
			"name":"sic susie",
			"b_desc":"twice as much pain",
			"cost":240,
			"function":self.act2,
			"assist":[susie_profile]
		}
	}
	self.active_act=[act_list[0],act_list[1]]
	pass # Replace with function body.
func act1(target:Array[battle_profile]):
	self.mercy+=0.2
func act2(target:Array[battle_profile]):
	self.hp=1
	self.mercy=1
func ally_action(from:battle_profile):
	match from.char_id:
		0:
			pass
		1:
			DialogueManager.add_line("Susie drop kicked the enemy!")
			self.mercy+=0.5
		2:
			DialogueManager.add_line("Ralsei whipped the enemy into shape!")
			self.mercy+=0.25
		3:
			DialogueManager.add_line("Noelle gently tapped the enemy.")
			self.mercy+=0.1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
