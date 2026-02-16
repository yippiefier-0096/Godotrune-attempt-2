extends Control
class_name ui_manager

enum mode_index{light,dark,battle,shop} 

var normal:normal_text
var question:option_container
var pause:float=0.15
#i have no idea how to work this system so here
var dialogue:dialogue_manager



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.size=Vector2(640,480)
	normal=normal_text.new()
	self.add_child(normal)
	question= option_container.new()
	self.add_child(question)
	pass # Replace with function body.

func basetext(input:String):
	normal.type(input)
func questiontext(input:Array):
	question.type(input)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(_delta: float) -> void:
	pass
