extends battle_profile
class_name enemy2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	atk=5
	def=2
	mag=0
	max_hp=100
	hp=27
	attack_patterns=[test_pattern_icee]
	mercy=0.75
	nametag="the testerrrrrr"
	act_list={
		0:{
			"name":"test",
			"b_desc":"do tests",
			"cost":0,
			"function":self.act1
		}
	}
	active_act=[act_list[0]]
	pass # Replace with function body.

func act1(target:Array[battle_profile]):
	DialogueManager.add_line("you tested... something.")
	DialogueManager.add_line("Do you think it worked?")
	DialogueManager.add_line("[option]yes||no")
	DialogueManager.add_consequence(0,"Then it's a relief.")
	DialogueManager.add_consequence(0,"The tester feels at ease!")
	DialogueManager.add_consequence(1,"It's been so long since i last saw my parents...")
	DialogueManager.add_consequence(1,"The tester lost all motivation!")
	await DialogueManager.read_dialogue()
	match globals.yourchoice:
		0:
			mercy=1
		1:
			sleepy=1
	await DialogueManager.read_dialogue()	
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
