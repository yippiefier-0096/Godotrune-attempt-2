extends StaticBody2D
##Base class for bullets instanciated by [bullet_event_base]s with their own specific properties, paths, and motions.
##[br][br]The impact of any given bullet, such as their individual attack power, invulnerable frames given, and tp gain via grazing is also set here.
class_name bullet_base
## the hitbox of this bullet
var hitbox:CollisionShape2D
##
var graphics:AnimatedSprite2D
var current_lifetime:float=0.0

##Base TP gain when grazed for the first time.
var graze_value:float=30

##base TP gain for every frame the bullet is grazed.
var graze_sustain:float=0.01
##whether this bullet is already grazed 
var graze_true:bool=false

##how long invulnarable time lasts in seconds.
var invulnerable:float

var initial_velocity:Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hitbox=CollisionShape2D.new()
	add_child(hitbox)
	graphics=AnimatedSprite2D.new()
	graphics.sprite_frames=SpriteFrames.new()
	add_child(graphics)
	graphics.scale*=0.15
	hitbox.shape=CircleShape2D.new()
	hitbox.scale*=0.6
	collision_mask=2
	collision_layer=2
	
	pass # Replace with function body.

## Details the behavior of bullets. [aug life] is the time this bullet has existed, used to augment behaviors.
func behavior(life:float):
	if life<=5:
		pass

	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	behavior(current_lifetime)
	current_lifetime+=delta
	pass
