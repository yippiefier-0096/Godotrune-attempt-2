extends Area2D
class_name heart_shaped_object

var speed:float=1.8
var hitbox:CollisionShape2D
var graze:graze_box
var graphics:AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	hitbox=CollisionShape2D.new()
	hitbox.shape=CircleShape2D.new()
	self.add_child(hitbox)
	hitbox.scale*=0.4
	graphics=AnimatedSprite2D.new()
	graphics.sprite_frames=load("uid://bnb3jasd8ffra")
	self.add_child(graphics)
	graze=graze_box.new()
	add_child(graze)
	collision_layer=2
	collision_mask=2
	self.scale=Vector2(0.6,0.6)
	intro()
	
	pass # Replace with func`tion body.
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("cancel"):
		speed=1.0
	if event.is_action_released("cancel"):
		speed=1.8
func intro():

	pass
	

# Called every frame. 'd`elta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	self.position+=Input.get_vector("left","right","up","down")*speed
	if get_overlapping_bodies().size()>0:
		print("ouch")
		
		graphics.play("hurt")
		self.hitbox.set_deferred("disabled",true)
		graze.area.set_deferred("disabled",true)
		await get_tree().create_timer(get_overlapping_bodies()[0].invulnerable).timeout
		self.hitbox.set_deferred("disabled",false)
		graze.area.set_deferred("disabled",false)
		graphics.stop()
		graphics.frame=0
	pass
func _process(delta: float) -> void:
	
	pass
