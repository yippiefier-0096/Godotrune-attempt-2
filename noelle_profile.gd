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
		0:["N-action","???","ACT on enemies",0,ally_act,target_style.single_enemy],
		1:["IceShock","ice magic!!! so cool","Chilling ice attack",160,iceshock,target_style.single_enemy]
	}
	active_power=[]
	nametag="NOELLE"
	pass # Replace with function body.

func iceshock(target:battle_profile):
	DialogueManager.add_line("Noelle casted IceShock on [0]!",[target.nametag])
	await DialogueManager.read_dialogue()
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
