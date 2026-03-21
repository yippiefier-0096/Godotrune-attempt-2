extends Node
class_name util
static var battle_position_ally:Dictionary[Array,Vector2]={
	[1,0]:Vector2(100,240),
	[2,0]:Vector2(110,100),
	[2,1]:Vector2(90,360),
	[3,0]:Vector2(120,100),
	[3,1]:Vector2(100,230),
	[3,2]:Vector2(80,360),
	[4,0]:Vector2(130,100),
	[4,1]:Vector2(110,200),
	[4,2]:Vector2(90,300),
	[4,3]:Vector2(70,400),
	[5,0]:Vector2(),
	[5,1]:Vector2(),
	[5,2]:Vector2(),
	[5,3]:Vector2(),
	[5,4]:Vector2()
}

static var action_ready_anim:Dictionary[int,StringName]={
	BattleManager.actioncontext.empty:"idle",
	BattleManager.actioncontext.attack:"fight_ready",
	BattleManager.actioncontext.act:"act_ready",
	BattleManager.actioncontext.skill:"skill_ready",
	BattleManager.actioncontext.item:"item_ready",
	BattleManager.actioncontext.mercy:"",
	BattleManager.actioncontext.ally_action:"act_ready",
	BattleManager.actioncontext.defending:"defend",
	BattleManager.actioncontext.skipped:"skill_ready"
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
static func current_playback_ms()->float:
	return (BgmManager.get_playback_position()+AudioServer.get_time_since_last_mix())*1000

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
