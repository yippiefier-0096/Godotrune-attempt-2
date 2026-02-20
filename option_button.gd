extends Button
class_name option_button

var dialog:RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	pass # Replace with function body.
func _init(x:int,y:int) -> void:
	superprep(x,y)
	pass
	
func superprep(x:int,y:int):
	mouse_filter=Control.MOUSE_FILTER_IGNORE
	self.size=Vector2(16,16)
	self.theme_type_variation="heartbutton"
	dialog=RichTextLabel.new()
	dialog.position=Vector2(22,-8)
	dialog.size=Vector2(220,40)
	self.position=Vector2(8+220*x,18+50*y)
	connect("focus_entered",dummy)#pick it back up from here
func dummy():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
