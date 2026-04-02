extends note_base
class_name freestyle_note

var followups:Array[freestyle_followup]

signal clear
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	self.scale.y*=10
	self.position.y=200
	state=state_enum.idle
	pass # Replace with function body.
	
func hit(this:int=0)->bool:
	var _i=util.current_playback_ms()-just_timing
	var results:String
	if absf(_i)<300:
		state=state_enum.state1
		safe_free()
	
	return true
func _process(delta: float) -> void:
	if state==state_enum.idle:
		position.x=320+(just_timing-(BgmManager.get_playback_position()+AudioServer.get_time_since_last_mix())*1000)/(scroll_speed*4.5)
	elif state==state_enum.finished:
		position.y-=y_velo
		y_velo-=0.3
		if y_velo<3 and y_velo>-3:
			y_velo-=1.5
		position.x+=2
	elif state==state_enum.state1:
		position.x=320
		rotation+=0.05
		if followups.is_empty():
			state=state_enum.finished
			safe_free()
		else:
			if !followups[0]:
				followups.pop_front()
	if util.current_playback_ms()-just_timing>300:
		if state==state_enum.idle:
			sub_missed()
	pass

func sub_missed():
	print("CHAIN FAIL")
	for i in followups:
		clear.emit()
	self.safe_free()
	self.queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
