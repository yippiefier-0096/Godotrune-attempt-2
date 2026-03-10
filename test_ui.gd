extends Control
class_name battle_ui

var main_buttons:Array[main_button]
var options:Array[battle_option]
var initiator:battle_profile
var placement:int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.position.x+=20+(600/globals.ally_list.size()*placement)
	for i in initiator.button_config.size():
		main_buttons.append(initiator.button_config[i].new(initiator))
		main_buttons[i].position=Vector2(33*i,160)
		add_child(main_buttons[i])
		main_buttons[i].pressed.connect(layer_off)
	for i in main_buttons.size():
		main_buttons[i].focus_neighbor_left=main_buttons[wrapi(i-1,0,main_buttons.size())].get_path()
		main_buttons[i].focus_neighbor_right=main_buttons[wrapi(i+1,0,main_buttons.size())].get_path()
	main_buttons[0].call_deferred("grab_focus")
	pass # Replace with function body.
func _init(_i:battle_profile,_p:int) -> void:
	initiator=_i
	placement=_p
	pass

func layer_off():
	for i in main_buttons.size():
		main_buttons[i].focus_mode=Control.FOCUS_NONE
func layer_on():
	var ref:int
	UiManager.battle_option_container.visible=false
	for i in UiManager.battle_option_array.size():
		UiManager.battle_option_array.pop_back().queue_free()
	for i in main_buttons.size():
		main_buttons[i].focus_mode=Control.FOCUS_ALL
		main_buttons[i].replacer.visible=false
		if main_buttons[i].self_modulate.a<0.2:
			main_buttons[i].self_modulate.a=1
			ref=i
	main_buttons[ref].call_deferred("grab_focus")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
