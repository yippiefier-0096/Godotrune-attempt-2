extends battle_option
class_name magic_option

var skill_held:Array
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
func _init(x:int,y:int,my_owner:battle_profile,my_page:int) -> void:
	superprep(x,y,my_owner,my_page)
	skill_held=root_character.power_list[root_character.active_power[2*y+x+6*my_page]]
	self.dialog.text=skill_held[0]
	self.focus_entered.connect(UiManager.set_desc.bind(skill_held[2],skill_held[3]))
	
func _pressed():
	
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
