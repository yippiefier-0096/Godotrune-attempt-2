extends Node
class_name menu_manager

var layer:int=0
var section:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
func _input(event: InputEvent) -> void:
	if globals.mode==0:
		if event.is_action_pressed("menu"):
			globals.mode=2
	if globals.mode==2:
		if event.is_action_pressed("menu"):
			globals.mode=0
		if event.is_action_pressed("confirm"):
			layer+=1
			ready_menu(layer,section)
		if event.is_action_pressed("cancel"):
			layer-=1
			if layer==0:
				globals.mode=0
	pass
	
func ready_menu(x:int,y:int):
	
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
