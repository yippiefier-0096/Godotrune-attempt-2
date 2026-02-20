extends Control

var main_buttons:Array[Button]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_buttons=[actbutton.new(),actbutton.new(),actbutton.new(),actbutton.new(),actbutton.new()]
	for i in 5:
		main_buttons[i].position=Vector2(40*i,160)
		add_child(main_buttons[i])
	main_buttons[0].grab_focus()
	for i in 2:
		for j in 3:
			add_child(option_button.new(i,j))	
		pass
	
	
	pass # Replace with function body.
func _input(event: InputEvent) -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
