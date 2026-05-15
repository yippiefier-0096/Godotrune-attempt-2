extends Sprite2D
class_name battle_strike_meter

var strike_notes:Array[battle_strike_bar]
var start_time:float
var current_beat:int
var current_time:int
var accuracy_score:float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
func _init(_character:battle_profile) -> void:
	var beats:Array[int]
	for i in randi_range(_character.equipped_weapon.strike_split_range[0],_character.equipped_weapon.strike_split_range[1]):
		if i==0:
			pass
	_character.equipped_weapon
	start_time=Time.get_ticks_msec()
	for i in beats:
		var _temp:battle_strike_bar=battle_strike_bar.new(_character.equipped_weapon.strike_type,i)
		add_child(_temp)
		strike_notes.append(_temp)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
func _input(event: InputEvent) -> void:
	if event.is_action("confirm"):
		current_time=(Time.get_ticks_msec()-start_time-925)
		current_beat=current_time/150
		for i in strike_notes:
			if current_beat<i.beat+1 and current_beat>i.beat-1:
				accuracy_score+=i.hit(current_time%150)
	pass
