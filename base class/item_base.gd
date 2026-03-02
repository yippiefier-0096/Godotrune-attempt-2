extends Node
class_name item_base

var consume_on_use:bool=true

var desc:String=""
var b_desc:String=""
var nametag:String=""
var target_mode:int

enum target_style {single_enemy,single_ally,all_enemies,all_allies}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
##called when the item is used.
func _use(target:battle_profile):
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
