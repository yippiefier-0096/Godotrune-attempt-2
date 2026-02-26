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
	self.power_list={
	0:["Rude buster","Susie's signature skill. deals high Rude Damage.","High burst damage",50,null,1],
	1:["Rude buster","Susie's signature skill. deals high Rude Damage.","High burst damage???",50,null,-1],
	2:["Rude buster","Susie's signature skill. deals high Rude Damage.","I forgor",50],
	3:["Rude buster","Susie's signature skill. deals high Rude Damage.","High burst damage",50],
	4:["Rude buster","Susie's signature skill. deals high Rude Damage.","High burst damage",50],
	5:["Rude buster","Susie's signature skill. deals high Rude Damage.","High burst damage",50],
	6:["Rude buster","Susie's signature skill. deals high Rude Damage.","High burst damage",50],
	7:["Rude buster","Susie's signature skill. deals high Rude Damage.","High burst damage",50],
	8:["Rude buster","Susie's signature skill. deals high Rude Damage.","High burst damage",50,null,1],
	9:["Rude buster","Susie's signature skill. deals high Rude Damage.","High burst damage???",50,null,-1],
	10:["Rude buster","Susie's signature skill. deals high Rude Damage.","I forgor",50],
	11:["Rude buster","Susie's signature skill. deals high Rude Damage.","High burst damage",50],
	}
	self.active_power=[0,1,2,3,4,5,6,7,8,9,10]
	self.nametag="SUSIE"
	
	#load from 2nd character data slot
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
