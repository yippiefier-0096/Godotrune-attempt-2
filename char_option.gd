extends battle_option
class_name char_option

var health_bar_base:Panel=Panel.new()

var health_bar_true:Panel=Panel.new()

var status:RichTextLabel=RichTextLabel.new()

var mercy_bar_base:Panel=Panel.new()

var mercy_bar_true:Panel=Panel.new()

var target_group:Array[battle_profile]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
func _init(y:int,my_targets:Array[battle_profile],my_page:int) -> void:
	superprep(0,y,my_targets[my_page*3+y],my_page)
	my_targets=target_group
	add_child(health_bar_base)
	health_bar_base.add_child(health_bar_true)
	health_bar_base.size=Vector2(120,20)
	health_bar_base.position.x=360
	health_bar_true.size=health_bar_base.size
	health_bar_true.scale.x=float(root_character.hp)/float(root_character.max_hp)
	health_bar_true.theme_type_variation="true_bar"
	health_bar_base.theme_type_variation="base_bar"
	if !root_character.is_ally:
		add_child(mercy_bar_base)
		mercy_bar_base.add_child(mercy_bar_true)
		mercy_bar_base.size=Vector2(120,20)
		mercy_bar_base.position.x=500
		mercy_bar_true.size=mercy_bar_base.size
		mercy_bar_true.scale.x=root_character.mercy
		mercy_bar_true.theme_type_variation="true_bar"
		mercy_bar_base.theme_type_variation="base_bar"
	self.dialog.text=root_character.nametag
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up") and self.has_focus():
		if pos.y==0:
			if on_page>0:
				UiManager.create_page_v(target_group,on_page-1,self.get_script(),2)
				pass
	if event.is_action_pressed("ui_down") and self.has_focus():
		if pos.x==2:
			if on_page<(root_character.active_power.size()/3):
				UiManager.create_page_v(target_group,on_page+1,self.get_script(),0)
				pass
func _pressed() -> void:
	UiManager.ui_backtrack.append(UiManager.create_page_v.bind(target_group,on_page,self.get_script(),pos.y))
	BattleManager.turn_action[BattleManager.turn_order][1]=pos.y+on_page*3
	BattleManager.turn_action[BattleManager.turn_order][2]=target_group
	#and then end the turn
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
