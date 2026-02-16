extends Sprite2D
class_name afterimage

var lifetime:float
var maxlifetime:float
var vel:Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _init(_t:Texture2D,pos:Vector2,life:float=1.0,toss_vector:Vector2=Vector2.ZERO) -> void:
	position=pos
	maxlifetime=life
	lifetime=life
	self.texture=_t
	vel=toss_vector

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.lifetime-=delta
	self.self_modulate=Color(1,1,1,1*lifetime/maxlifetime)
	self.position+=vel*lifetime/maxlifetime
	if self.lifetime<=0:
		self.queue_free()
	pass
