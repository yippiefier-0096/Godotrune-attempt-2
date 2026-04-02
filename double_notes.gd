extends note_base
class_name double_note

var initial_result
var accel:float
var target:float
var origin_timing:float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state=state_enum.idle
	super()
	modulate.r=0.2
	modulate.g=0.2
	pass # Replace with function body.
	
func hit(this:int=0):
	var _i = util.current_playback_ms() - just_timing
	if absf(_i)>300:
		return
	initial_result=_i
	if state==state_enum.idle:
		accel=25
		if on_lane==lane_meaning.up:
			target=250
			on_lane=lane_meaning.down
		elif on_lane==lane_meaning.down:
			target=150
			on_lane=lane_meaning.up
		y_velo=-0.5*accel*(end_timing-just_timing)/1000
		state=state_enum.state1
		origin_timing=just_timing
		just_timing=end_timing
		get_parent().current_note_list.sort_custom(func(x:note_base,y:note_base):return x.just_timing<y.just_timing)
		if tweener:tweener.kill()
		tweener=create_tween()
		tweener.set_trans(Tween.TRANS_CIRC)
		tweener.set_ease(Tween.EASE_OUT)
		tweener.tween_property(self,"position:y",0.25*(end_timing-origin_timing)/(scroll_speed*4.5),0.5*(end_timing-origin_timing)/1000)
		tweener.tween_property(self,"position:y",target,0.5*(end_timing-origin_timing)/1000).set_ease(Tween.EASE_IN)
	elif state==state_enum.state1:
		state=state_enum.finished
		safe_free()
		
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match state:
		state_enum.finished:
			position.y-=y_velo
			y_velo-=0.3
			if y_velo<3 and y_velo>-3:
				y_velo-=1.5
			position.x+=2
			return
		state_enum.idle:
			position.x=320+(just_timing-util.current_playback_ms())/(scroll_speed*4.5)
			if (util.current_playback_ms()-just_timing)>300:
				print("MISS first hit")
				safe_free()
				queue_free()
			pass
		state_enum.state1:
			if (util.current_playback_ms()-end_timing)<300:
				pass
			else:
				safe_free()
				queue_free()
			
# y is displacement. y is +100 (up to down) or -100 (down to up)
# y=v(0)t+0.5*a(t)^2
# t is the time this note spent switching lane, i.e. (end_timing-just_timing)
# a is a set value
# v(0)=
# I can't believe it took me this long to remember something i learned two years ago

	if (util.current_playback_ms()-end_timing)>2000:
		safe_free()
		queue_free()
