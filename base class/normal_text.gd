extends RichTextLabel
class_name normal_text

var DTmono:Font= preload("uid://b0ixdmo1uekv2")
var blip:Timer
var can_next:bool=false
var skip:bool=false
var pause:float=0.15
signal next_line
# Called when the node enters the scene tree for the first time.
func _init() -> void:
	self.add_theme_font_override("normal_font",DTmono)
	self.add_theme_font_size_override("normal_font_size",32)
	self.scroll_active=false
	self.size=Vector2(560,160)
	self.position=Vector2(40,300)
	self.visible=false
	self.text=""
	self.visible_characters=0
	blip=Timer.new()
	self.add_child(blip)
func _ready() -> void:
	pass
	
func type(input:String,character:int=0,auto:bool=false,tick:float=0.05,wait_tick:float=0.3) -> void:
	#input= the dialogue itself
	#character= any character used? augments voice blip and portrait (while changing the textbox size
	#auto: if true, can't skip and instead gets automatically cut off
	#tick, wait tick: time between one letter & another, then time waited for each | pauses
	can_next=false
	self.visible=true
	self.text=input
	self.visible_characters=0
	var y:int = self.text.remove_chars("|").length()
	print (self.text)
	for i in y:
		while self.text[i]=="|":
			self.text[i]=""
			if !skip:
				await get_tree().create_timer(wait_tick).timeout
		self.visible_characters+=1
		if !skip:
			await get_tree().create_timer(tick).timeout
	can_next=true
	skip=false
	if auto:
		next_line.emit()
		
	pass # Replace with function body.
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("confirm") and can_next:
		self.text=""
		next_line.emit()
	if event.is_action_pressed("cancel"):
		skip=true
		if can_next:
			next_line.emit()
		pass
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
