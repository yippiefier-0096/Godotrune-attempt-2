extends battle_option
class_name item_option

var item_held:item_base
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called when the node enters the scene tree for the first time.
func _init(x:int,y:int,my_owner:battle_profile,my_page:int) -> void:
	superprep(x,y,my_owner,my_page)
	item_held=Inventory.item_content[2*y+x+6*my_page]
	self.dialog.text=item_held.nametag
	self.focus_entered.connect(UiManager.set_desc.bind(item_held.b_desc))
	#note to self. incorporate more of this function into the base class for readability
	
func _pressed():
	BattleManager.turn_action[BattleManager.turn_order][3]=item_held._use
	Inventory.item_content.pop_at(2*pos.y+pos.x+6*on_page)
	BattleManager.item_use_cache.append(item_held)
	#start here tmw
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
