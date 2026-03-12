extends AnimatedSprite2D
class_name actor_base
var nametag:StringName="default"
var identifier:int=0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var temp:StringName=nametag
	while CutsceneManager.animatable.has(temp):
		identifier+=1
		temp=nametag+str(identifier)
	CutsceneManager.animatable.set(temp,self)
	
		
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
