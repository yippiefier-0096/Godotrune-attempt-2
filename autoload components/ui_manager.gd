extends Control
class_name ui_manager

enum mode_index{light,dark,battle,shop} 

var normal:normal_text=normal_text.new()
var question:option_container= option_container.new()
var pause:float=0.15
#i have no idea how to work this system so here
var dialogue:dialogue_manager

var battle_option_container:Control=Control.new()

var battle_option_array:Array[battle_option]

var description:RichTextLabel=RichTextLabel.new()

var desc_tp:RichTextLabel=RichTextLabel.new()

var ui_backtrack:Array[Callable]

var menu_b:battle_ui

var backdrop:Panel=Panel.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.theme=load("uid://dqbt1qotxciwu")
	self.size=Vector2(640,480)
	normal=normal_text.new()
	self.add_child(normal)
	self.add_child(question)
	self.add_child(battle_option_container)
	battle_option_container.visible=false
	battle_option_container.add_child(description)
	description.add_theme_color_override("default",Color(0.435, 0.435, 0.435, 1.0))
	description.size=Vector2(140,140)
	description.position=Vector2(480,10)
	battle_option_container.add_child(desc_tp)
	desc_tp.size=Vector2(140,40)
	desc_tp.position=Vector2(480,110)
	
	pass # Replace with function body.

func basetext(input:String):
	normal.type(input)
func questiontext(input:Array):
	question.type(input)
	
func create_page_h(character:battle_profile,page_index:int,type:GDScript,init_pos:int=0):
	description.text=""
	desc_tp.text=""
	battle_option_container.visible=true
	var list_size:int
	for i in UiManager.battle_option_array.size():
		battle_option_array.pop_back().queue_free()
	match type:
		item_option:
			list_size=Inventory.item_content.size()
		magic_option:
			list_size=character.active_power.size()
		act_option:
			list_size=character.active_act.size()
	for i in clampi(list_size-6*page_index,0,6):
		var y:int=i/2
		var x:int=i%2
		var _this:Button=type.new(x,y,character,page_index)
		UiManager.battle_option_container.add_child(_this)
		UiManager.battle_option_array.append(_this)
		if i==clampi(init_pos,0,list_size-(6*page_index)-1):
			_this.call_deferred("grab_focus")
func create_page_v(list:Array[battle_profile],page_index:int,type:GDScript,init_pos:int=0):
	description.text=""
	desc_tp.text=""
	var list_size=list.size()
	UiManager.battle_option_container.visible=true
	for i in UiManager.battle_option_array.size():
		UiManager.battle_option_array.pop_back().queue_free()

	for i in clampi(list_size-3*page_index,0,3):
		var y:int=i
		var _this:Button=type.new(y,list,page_index)
		UiManager.battle_option_container.add_child(_this)
		UiManager.battle_option_array.append(_this)
		if i==clampi(init_pos,0,list_size-(3*page_index)-1):
			_this.call_deferred("grab_focus")
	
func set_desc(content:String,tp:int=0):
	desc_tp.text=""
	description.text=content
	if tp!=0:
		desc_tp.text=str(int(tp/10),"% TP")
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("cancel"):
		if !ui_backtrack.is_empty():
			ui_backtrack.pop_back().call()
		else:
			if BattleManager.turn_order!=0:
				BattleManager.last_turn()
	pass
func _process(_delta: float) -> void:
	pass
