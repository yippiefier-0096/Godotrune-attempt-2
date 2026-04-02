extends note_base
class_name freestyle_followup

signal missed

var head:freestyle_note

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	self.scale.y*=2
	self.position.y=200
	state=state_enum.idle
	
func hit(this:int=0)->bool:
	if absf(just_timing-util.current_playback_ms())<300:
		safe_free()
		return true
	else:
		return false
func safe_free():
	print("hapen")
	super()
	self.queue_free()
func _process(delta: float) -> void:
	match state:
		state_enum.idle:
			position.x=320+clampf((just_timing-util.current_playback_ms())/(scroll_speed*4.5),0,10000000)
		_:
			position.y-=y_velo
			y_velo-=0.3
			if y_velo<3 and y_velo>-3:
				y_velo-=1.5
			position.x+=2
	if util.current_playback_ms()-just_timing>300:
		if state==state_enum.finished:
			pass
		else:
			missed.emit()
		safe_free()
		self.queue_free()
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
