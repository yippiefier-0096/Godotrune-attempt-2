extends note_base
class_name hold_note
var initial_result:float
var initial_hit:bool=false
var held_input_event:int
var extension:AnimatedSprite2D=AnimatedSprite2D.new()
var tail:AnimatedSprite2D=AnimatedSprite2D.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state=state_enum.idle
	super()
	add_child(extension)
	add_child(tail)
	extension.sprite_frames=load("uid://bterbb0hdxf4d")
	tail.sprite_frames=load("uid://bterbb0hdxf4d")
	tail.self_modulate.r=0
	tail.self_modulate.g=0
	tail.position.x=(end_timing-just_timing)/(scroll_speed*4.5)
	
	
	pass # Replace with function body.
func _draw() -> void:
	if state==state_enum.state1:
		draw_rect(Rect2(0,-15,(end_timing-clampf(util.current_playback_ms(),just_timing,end_timing))/(4.5*scroll_speed),30),Color.YELLOW,true)
	elif state==state_enum.idle:
		draw_rect(Rect2(0,-15,(end_timing-just_timing)/(4.5*scroll_speed),30),Color.YELLOW,true)
	pass
func hit(this:int=0):
	var _i = util.current_playback_ms() - just_timing
	if absf(_i)>300:
		return
	initial_result=_i
	initial_hit=true
	state=state_enum.state1
	held_input_event=this
	safe_free()
	pass
	
func release():
	var _i = util.current_playback_ms() - end_timing
	if absf(_i)>300:
		print("MISS early release")
		self.safe_free()
		queue_free()
	else:
		print("HIT")
		self.outro()
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#while active, this note fly toward the player
	#and checks if it's timed out.
	#if the player managed to hit the note and it becomes inactive
	#check for the input being released instead
	#during which only the tail follows up with the movement
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
			position.x=320
			tail.position.x=clampf((end_timing-util.current_playback_ms())/(scroll_speed*4.5),0,9999999)
			if !Input.is_key_pressed(held_input_event):
				release()
			if (util.current_playback_ms()-end_timing)>300:
				print("MISS release")
				safe_free()
				queue_free()
				pass
	if (util.current_playback_ms()-end_timing)>1000:
		safe_free()
		queue_free()
	queue_redraw()
