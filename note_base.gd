extends bullet_base
class_name note_base
var note_skin:AnimatedSprite2D
##the timing in milisec, when this note is supposed to be 
var just_timing:int
##for extend notes like switch or hold, the timing of the "Second Hit".
var end_timing:int
##in pixels per frame, the speed notes scroll
var scroll_speed:float

var on_lane:int

enum lane_meaning{up,down,both,modifier}

var from_right_side:bool
##indicates if a note is able to be hit
var active:bool=false
## why did i name it like this. indicates if a note has been hit, and is flying off screen.
var flew:bool=false
# Called when the node enters the scene tree for the first time.
var y_velo:float

var state:int

enum state_enum{idle,in_range,state1,state2,finished}
func _init(timing:int,end:int,scroll:float,lane:int,side:bool):
	state=state_enum.idle
	just_timing=timing
	end_timing=end
	scroll_speed=scroll
	on_lane=lane
	from_right_side=side
	if on_lane==lane_meaning.down:
		position.y=250
	elif on_lane==lane_meaning.up:
		position.y=150
	pass
func _ready():
	graphics=AnimatedSprite2D.new()
	graphics.sprite_frames=load("uid://mx30b18f0y0r")
	add_child(graphics)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.

func hit(this:int=0)->bool:
	var _i=util.current_playback_ms()-just_timing
	var results:String
	if absf(_i)<76:
		results="PERFECT"+str(int(_i))
	elif absf(_i)<126:
		results="GREAT"
	elif absf(_i)<176:
		results="GOOD"
	elif absf(_i)<251:
		results="OK"
	elif absf(_i)<301:
		results="barely"
	else:
		return false
	outro()
	safe_free()
	return true

func outro():
	state=state_enum.finished
	position.x=320
	y_velo=12
	pass
	
func _process(delta: float) -> void:
	match state:
		state_enum.idle:
			position.x=320+(just_timing-(BgmManager.get_playback_position()+AudioServer.get_time_since_last_mix())*1000)/(scroll_speed*4.5)
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
			safe_free()
		self.queue_free()
	pass
func safe_free():
	get_parent().current_note_list.erase(self)
	get_parent().current_note_list.sort_custom(func(x:note_base,y:note_base):return x.just_timing<y.just_timing)
