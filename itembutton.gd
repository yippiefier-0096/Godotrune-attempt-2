extends main_button
class_name itembutton


func _ready() -> void:
	super()	
	self.theme_type_variation="itembutton"
	replacer.texture=load("uid://cqjgikoee3a80")
	option_type_called=item_option

	pass # Replace with function body.

#func _init(current_char:battle_profile) -> void:
	#root_character=current_char
	#pass
#
#func _pressed() -> void:
	#UiManager.create_page_h(root_character,0,item_option)
	#self.self_modulate.a=0
	#replacer.visible=true
	#
	#pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
