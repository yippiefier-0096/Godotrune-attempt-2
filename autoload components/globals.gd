extends Node
class_name Globals

enum mode_index{overworld,shop,menu,battle_turn,battle_dodge}
var mode:int=0
var yourchoice:int=-1
var party_list:Array[party_member]=[]
var ally_list:Array[battle_profile]=[]
var test:bool=false

var assist_icon:Dictionary[GDScript,String]={
	kris_profile:"uid://bray82k2ek31o",
	susie_profile:"uid://dktm0kdxfba65",
	ralsei_profile:"uid://bssag1p2qhvin",
	noelle_profile:"uid://dpuhhqngcfkbn"
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	ally_list=[kris_profile.new(0),susie_profile.new(1),noelle_profile.new(2),ralsei_profile.new(3)]
	for i in ally_list.size():
		add_child(ally_list[i])
		
	pass # Replace with function body
	
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
		Inventory.use_item(0,[ally_list[1]])
	if event.is_action_pressed("w"):
		Inventory.equip_weapon(0,ally_list[1])
	if event.is_action_pressed("e"):
		Inventory.equip_weapon(1,ally_list[1])
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
