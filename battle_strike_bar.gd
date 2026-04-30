extends Sprite2D
class_name battle_strike_bar

var motion:Expression = Expression.new()

enum pattern_lookup{LINEAR,BUNGEE,SLOW,FAST}

var bar_patterns:Dictionary[int,String]={
	0:"2.5*t",
	1:"2.5t+10*(sin(PI*t/5))"
}

var beat_delay:float
var beat:int
var start_time:float
var current_life:float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
func _init(pattern:pattern_lookup=pattern_lookup.LINEAR,new_beat:int=0) -> void:
	motion.parse(bar_patterns[pattern],["t"])
	start_time=Time.get_ticks_msec()
	beat=new_beat
	beat_delay=beat*0.150
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	current_life=(Time.get_ticks_msec()-start_time)/1000
	position.x=motion.execute([(1+beat_delay)-current_life])*10
	pass
