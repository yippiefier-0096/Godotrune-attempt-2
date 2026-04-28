class_name soul_double
extends AnimatedSprite2D

var target:bool
var tweener:Tween
var holding:bool=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_frames=load("uid://bterbb0hdxf4d")
	
	tweener=create_tween()
	tweener.set_trans(Tween.TRANS_SINE)
	if target==false:
		tweener.tween_property(self,"position:y",250,0.025)
	elif target==true:
		tweener.tween_property(self,"position:y",150,0.025)
	print("Deployed...")

func _init(target_up_lane:bool):
	target=target_up_lane
	self_modulate.a=1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if holding==false:
		tweener=create_tween()
		tweener.set_trans(Tween.TRANS_LINEAR)
		tweener.tween_property(self,"self_modulate:a",0,1)
		tweener.tween_callback(self.queue_free).set_delay(2)	
	pass
