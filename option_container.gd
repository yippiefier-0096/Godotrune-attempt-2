extends Node
class_name option_container

var options:Array
var can_choose:bool
var has_chosen:bool
var selection:int=-1
var available:Array[bool]=[false,false,false,false]
var heart_marker:Sprite2D
signal next_line
# Called when the node enters the scene tree for the first time.
func _init() -> void:
	for i in 4:
		var _o=d_option.new("",i)
		options.append(_o)
		self.add_child(_o)	
		heart_marker=Sprite2D.new()
		heart_marker.texture=load("uid://i0b3ii438h1d")
		self.add_child(heart_marker)
		heart_marker.visible=false
	pass
func _ready() -> void:
	pass # Replace with function body.
func type(content:Array, timed:float=-1, _skip:bool=false):
	selection=-1
	has_chosen=false
	if _skip and timed==-1:
		_skip=false
	for i in clamp(content.size(),1,4):
		options[i].text=content[i]
		options[i].visible=true
		available[i]=true
	heart_marker.visible=true
	heart_marker.position=Vector2(400,400)
	if !_skip:
		can_choose=true
	else:
		can_choose=false
	if timed>=0:
		await get_tree().create_timer(timed).timeout
		if !has_chosen:
			selection=4
			next_line.emit()
			for i in self.options.size():
				options[i].visible=false
				available[i]=false
			can_choose=false
			heart_marker.visible=false	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("up") and available[0]:
		selection=0
		heart_marker.position=options[selection].position - Vector2(20,-20)
		heart_marker.visible=true
	if event.is_action_pressed("right") and available[1]:
		selection=1 
		heart_marker.position=options[selection].position - Vector2(20,-20)
		heart_marker.visible=true
	if event.is_action_pressed("down") and available[2]:
		selection=2
		heart_marker.position=options[selection].position - Vector2(20,-20)
		heart_marker.visible=true
	if event.is_action_pressed("left") and available[3]:
		selection=3
		heart_marker.position=options[selection].position - Vector2(20,-20)
		heart_marker.visible=true
	if can_choose:
		if event.is_action_pressed("confirm") and selection!=-1:
			next_line.emit()
			for i in self.options.size():
				options[i].visible=false
				available[i]=false
			can_choose=false
			heart_marker.visible=false
			has_chosen=true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
