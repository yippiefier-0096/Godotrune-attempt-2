extends CharacterBody2D
## Autoload Node that represents the party's overworld movement. To Do: revamp directional input.
## [br][br] 
class_name overworld_team

var trail:Array=[]
var traildir:Array=[]
var detection:Area2D
var detection2:Area2D
var step_one:CollisionShape2D
var step_two:CollisionShape2D


var _collision:CollisionShape2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scale=Vector2(0.8,0.8)
	
	_collision=CollisionShape2D.new()
	add_child(_collision)
	_collision.shape=RectangleShape2D.new()
	detection=Area2D.new()
	add_child(detection)
	step_one=CollisionShape2D.new()
	step_one.debug_color=Color(1,0,1,0.5)
	step_one.shape=RectangleShape2D.new()
	step_one.position=Vector2(0,2)
	detection.add_child(step_one)
	detection2=Area2D.new()
	add_child(detection2)
	step_two=CollisionShape2D.new()
	step_two.shape=RectangleShape2D.new()
	step_two.scale=Vector2(0.1,1.3)
	step_two.position=Vector2(0,7)
	detection2.add_child(step_two)

	
	for i in 600:
		trail.append(self.position)
		traildir.append(self.get_real_velocity())

	pass # Replace with function body.
func config_party(party:Array):
	pass		
func _input(event: InputEvent) -> void:
	var interact_target:objects
	if event.is_action_pressed("confirm") and globals.mode==0:
		if detection.get_overlapping_bodies().size()>=3:

			for i in detection2.get_overlapping_bodies().size():
				if detection2.get_overlapping_bodies()[i] is objects:
					interact_target=detection2.get_overlapping_bodies()[i]
		else:
			for i in detection.get_overlapping_bodies().size():
				if detection.get_overlapping_bodies()[i] is objects:
					interact_target=detection.get_overlapping_bodies()[i]
		if interact_target:
			interact_target._interact()
		pass
			
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _physics_process(delta: float) -> void:
	if globals.mode==0:
		self.velocity=Input.get_vector("left","right","up","down")/delta*2
	else:
		self.velocity=Vector2.ZERO
	if self.get_real_velocity().length()>1:
		trail.push_front(self.position)
		traildir.push_front(self.velocity)
		trail.pop_back()
		traildir.pop_back()
		
	move_and_slide()
