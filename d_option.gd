extends RichTextLabel
class_name d_option

var DTmono:Font= preload("uid://b0ixdmo1uekv2")
var pos:int

func _init(content:String,position:int) -> void:
	theme=load("uid://dqbt1qotxciwu")
	self.scroll_active=false
	self.size=Vector2(560,160)
	self.position=Vector2(40,50*(position+1))
	self.visible=true
	self.text=content
	pos=position

func _process(delta: float) -> void:
	pass
	
