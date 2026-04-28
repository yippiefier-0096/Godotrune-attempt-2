extends Sprite2D
class_name battle_strike_meter

var motion:Expression = Expression.new()

enum pattern_lookup{LINEAR,BUNGEE,SLOW,FAST}

var bar_patterns:Dictionary[StringName,String]={
	"linear":"2.5*t",
	"bungee":"2.5t+10*(sin(PI*t/5))"
}

var target_offset:float

var start_time:float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
func _init(pattern) -> void:
	motion.parse(bar_patterns[pattern_lookup[pattern]],["t"])
	start_time=Time.get_ticks_msec()
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y=motion.execute([(Time.get_ticks_msec()-start_time)/1000])
	pass
