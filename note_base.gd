extends bullet_base
class_name note_base
var note_skin:AnimatedSprite2D
##the timing in milisec, when this note is supposed to be 
var just_timing:int
##for extend notes like switch or hold, the timing of the "Second Hit".
var end_timing:int
##in pixels per frame, the speed notes scroll
var scroll_speed:float

var on_lower_lane:bool

var from_right_side:bool
##indicates if a note is able to be hit
var active:bool=false
# Called when the node enters the scene tree for the first time.

func _init(timing:int,end:int,scroll:float,lane:bool,side:bool):
	
	just_timing=timing
	end_timing=end
	scroll_speed=scroll
	on_lower_lane=lane
	from_right_side=side
	if on_lower_lane:
		position.y=150
	else:
		position.y=250
	pass
func _ready():
	graphics=AnimatedSprite2D.new()
	graphics.sprite_frames=load("uid://mx30b18f0y0r")
	add_child(graphics)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x=100+(just_timing-(BgmManager.get_playback_position()+AudioServer.get_time_since_last_mix())*1000)/(scroll_speed*10)
	if position.x<=99:
		self.queue_free()
	pass
