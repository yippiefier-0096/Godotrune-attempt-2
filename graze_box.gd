extends Area2D
class_name graze_box

var area:CollisionPolygon2D=CollisionPolygon2D.new()
var temp_tp:float
var highlight:Sprite2D=Sprite2D.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	add_child(highlight)
	highlight.scale*=1.6
	highlight.visible=false
	highlight.texture=load("uid://bll8mreeyjshp")
	area.polygon=PackedVector2Array([Vector2(39,10),Vector2(39,-26),Vector2(27,-39),Vector2(9,-39),Vector2(2,-33),Vector2(-2,-33),Vector2(-9,-39),Vector2(-27,-39),Vector2(-39,-27),Vector2(-39,10),Vector2(-9,40),Vector2(9,40)])
	add_child(area)
	self.scale=Vector2(0.5,0.5)
	self.name="grazer"
	self.collision_layer=4
	self.collision_mask=2
	
	pass # Replace with function body.

func _init(sizemod:float=1) -> void:
	self.scale*=sizemod
	
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
func _physics_process(delta: float) -> void:
	for i in get_overlapping_bodies().size():
		if get_overlapping_bodies()[i] is bullet_base:
			if !get_overlapping_bodies()[i].graze_true:
				get_overlapping_bodies()[i].graze_true=true
				self.temp_tp+=get_overlapping_bodies()[i].graze_value
				self.highlight.self_modulate=Color.WHITE
				self.highlight.visible=true
			self.temp_tp+=get_overlapping_bodies()[i].graze_sustain
			highlight.self_modulate=highlight.self_modulate.clamp(Color(0.804, 0.498, 0.675, 1.0))
	print(temp_tp)
	highlight.self_modulate-=Color(0.2, 1.0, 1.0, 1.0)*delta*4
	if self.area.disabled:
		highlight.self_modulate.a=0
