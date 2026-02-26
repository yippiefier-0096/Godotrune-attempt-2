extends Control
class_name battle_ui

var main_buttons:Array[main_button]
var options:Array[battle_option]

# Called when the node enters the scene tree for the first time.
func _init(initiator:battle_profile) -> void:
	for i in 5:
		main_buttons.append(initiator.button_config[i].new(initiator))
		main_buttons[i].position=Vector2(33*i,160)
		add_child(main_buttons[i])
		main_buttons[i].pressed.connect(layer_off)
		print (main_buttons[i],main_buttons[i].get_tree())
	for i in 5:
		print (main_buttons[wrapi(i-1,0,5)])
		main_buttons[i].focus_neighbor_left=main_buttons[wrapi(i-1,0,5)].get_path()
		main_buttons[i].focus_neighbor_right=main_buttons[wrapi(i+1,0,5)].get_path()
	main_buttons[0].call_deferred("grab_focus")
	
	pass # Replace with function body.
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
