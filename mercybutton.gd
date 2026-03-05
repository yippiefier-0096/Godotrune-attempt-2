extends main_button
class_name mercybutton

var spare_indicator:Sprite2D=Sprite2D.new()
var life:float
func _ready() -> void:
	self.theme_type_variation="mercybutton"
	super()
	option_type_called=char_option
	context_pass=BattleManager.actioncontext.mercy
	replacer.texture=load("uid://bv2lfral6tiwl")
	spare_indicator.visible=false
	spare_indicator.z_index=27
	spare_indicator.centered=false
	spare_indicator.texture=load("uid://cuopaj6me28dq")
	add_child(spare_indicator)
	self.focus_entered.connect(check_mercy_hint)
	self.focus_exited.connect(mercy_hint_off)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if self.visible:
		life+=delta
		spare_indicator.self_modulate.a=cos(life*PI)/2+0.5
	pass

func _pressed() -> void:
	UiManager.create_page_v(BattleManager.enemy_team,0,option_type_called)
	self.self_modulate.a=0
	replacer.visible=true
	UiManager.ui_backtrack.append(Callable(UiManager.menu_b,"layer_on"))
	BattleManager.temp_action[0]=self.context_pass
func check_mercy_hint():
	if BattleManager.enemy_team.filter(team_mercy_viable).size()>0:
		life=0
		spare_indicator.visible=true
	pass

func mercy_hint_off():
	spare_indicator.visible=false
	pass

func team_mercy_viable(test:battle_profile)->bool:
	if test.mercy>=1:
		return true
	else:
		return false
