extends Node
class_name util
static var battle_position_ally:Dictionary[Array,Vector2]={
	[1,1]:Vector2(100,240),
	[2,1]:Vector2(110,100),
	[2,2]:Vector2(90,360),
	[3,1]:Vector2(120,100),
	[3,2]:Vector2(100,230),
	[3,3]:Vector2(80,360),
	[4,1]:Vector2(),
	[4,2]:Vector2(),
	[4,3]:Vector2(),
	[4,4]:Vector2(),
	[5,1]:Vector2(),
	[5,2]:Vector2(),
	[5,3]:Vector2(),
	[5,4]:Vector2(),
	[5,5]:Vector2()
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
