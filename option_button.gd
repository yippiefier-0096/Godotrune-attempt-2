extends Button
class_name battle_option

var dialog:RichTextLabel

var root_character:battle_profile

var pos:Vector2i

var on_page:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	pass # Replace with function body.
func _init(x:int,y:int,my_owner:battle_profile,my_page:int) -> void:
	superprep(x,y,my_owner,my_page)
	pass
	
func superprep(x:int,y:int,my_owner:battle_profile,my_page:int):
	action_mode=BaseButton.ACTION_MODE_BUTTON_PRESS
	mouse_filter=Control.MOUSE_FILTER_IGNORE
	self.size=Vector2(16,16)
	self.theme_type_variation="heartbutton"
	dialog=RichTextLabel.new()
	dialog.position=Vector2(22,-8)
	dialog.size=Vector2(220,40)
	self.position=Vector2(8+220*x,18+50*y)
	add_child(dialog)
	pos.x=x
	pos.y=y
	on_page=my_page
	root_character=my_owner
	self.z_index=25

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_left") and self.has_focus():
		if pos.x==0:
			if on_page>0:
				UiManager.create_page_h(root_character,on_page-1,self.get_script(),(pos.y*2)+1)
				pass
	if event.is_action_pressed("ui_right") and self.has_focus():
		if pos.x==1:
			if on_page<(root_character.active_power.size()/6):
				UiManager.create_page_h(root_character,on_page+1,self.get_script(),pos.y*2)
				pass
func _pressed() -> void:
	pass

func _back():
		UiManager.ui_backtrack.append(UiManager.create_page_h.bind(root_character,on_page,self.get_script(),pos.x+pos.y*2))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
