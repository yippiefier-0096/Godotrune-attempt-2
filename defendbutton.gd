extends main_button
class_name defendbutton

func _ready() -> void:
	super()
	self.theme_type_variation="defendbutton"
	self.context_pass=BattleManager.actioncontext.defending
	
	pass # Replace with function body.

func _pressed():
	BattleManager.turn_action[BattleManager.turn_order][0]=self.context_pass
	BattleManager.tp_gauge=clampf(BattleManager.tp_gauge+160,0,1000)
	BattleManager.tp_use_cache[BattleManager.turn_order]=-160
	BattleManager.next_turn()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
