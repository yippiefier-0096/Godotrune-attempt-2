extends RichTextLabel
class_name d_option

var DTmono:Font= preload("uid://b0ixdmo1uekv2")
var pos:int

func _init(content:String,position:int) -> void:
	self.add_theme_font_override("normal_font",DTmono)
	self.add_theme_font_size_override("normal_font_size",32)
	self.scroll_active=false
	self.size=Vector2(560,160)
	self.position=Vector2(40,50*(position+1))
	self.visible=true
	self.text=content
	pos=position

func _process(delta: float) -> void:
	pass
	
