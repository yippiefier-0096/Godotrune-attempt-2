extends Node
class_name Globals

enum mode_index{overworld,shop,menu,battle_turn,battle_dodge}
var mode:int=0
var yourchoice:int=-1
var party_list:Array[party_member]=[]
var ally_list:Array[battle_profile]=[]
var test:bool=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in 4:
		var ally:party_member= party_member.new(i,i)
		add_child(ally)
		party_list.append(ally)
		if ally.profile:
			ally.profile.is_ally=true
			ally_list.append(ally.profile)
			
		pass
	pass # Replace with function body.
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu"):
		if test==false:
			
			party_list[3].regroup(-1)
			party_list[2].regroup(1)
			party_list[1].regroup(-1)
			party_list[0].regroup(0)
			test=true
		else:
			for i in 4:
				party_list[i].regroup(i)
			test=false
			
	if event.is_action_pressed("q"):
		Inventory.use_item(0,[ally_list[1].profile])
	if event.is_action_pressed("w"):
		Inventory.equip_weapon(0,ally_list[1].profile)
	if event.is_action_pressed("e"):
		Inventory.equip_weapon(1,ally_list[1].profile)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
