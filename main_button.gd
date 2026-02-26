extends Button
##for the buttons that appears as a bar at the start of your turn you know that one right
class_name main_button

var root_character:battle_profile

var replacer:Sprite2D=Sprite2D.new()

var option_type_called:GDScript


##The context of this action
var context_pass:int=BattleManager.actioncontext.skipped
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	action_mode=BaseButton.ACTION_MODE_BUTTON_PRESS
	mouse_filter=Control.MOUSE_FILTER_IGNORE
	size=Vector2(31,26)
	add_child(replacer)
	replacer.visible=false
	replacer.centered=false
	pass # Replace with function body.

func _init(current_char:battle_profile) -> void:
	root_character=current_char
	pass
	
func _pressed() -> void:
	
	UiManager.create_page_h(root_character,0,option_type_called)
	self.self_modulate.a=0
	replacer.visible=true
	UiManager.ui_backtrack.append(Callable(UiManager.menu_b,"layer_on"))
	BattleManager.turn_action[BattleManager.turn_order][0]=self.context_pass
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
