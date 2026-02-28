extends battle_option
class_name act_option

var this_act
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
##[arg my_owner refers to the target character that spawned this act list.
func _init(x:int,y:int,my_owner:battle_profile,my_page:int) -> void:
	superprep(x,y,my_owner,my_page)
	this_act=my_owner.active_act[2*y+x+6*my_page]
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
