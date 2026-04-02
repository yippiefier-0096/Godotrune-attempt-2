extends heart_shaped_object
class_name void_mode

var attack_handled:music_attack_base
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	graphics.sprite_frames=load("uid://bterbb0hdxf4d")
	

func _input(event: InputEvent) -> void:
	var target:note_base
	var all_notes=attack_handled.current_note_list
	var event_keycode:int
	if event is InputEventKey:
		event_keycode=event.keycode
	if event.is_action_pressed("rhythm_down"):
		var temp_list=all_notes.filter(func(x:note_base):return x.on_lane==x.lane_meaning.down or x.on_lane==x.lane_meaning.both)
		if temp_list.is_empty():
			return
		target=temp_list[0]
		target.hit(event_keycode)
		print("hit_down",target)
		pass
	if event.is_action_pressed("rhythm_up"):
		var temp_list=all_notes.filter(func(x:note_base):return x.on_lane==x.lane_meaning.up or x.on_lane==x.lane_meaning.both)
		if temp_list.is_empty():
			return
		target=temp_list[0]
		target.hit(event_keycode)
		print("hit_up",target)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

	
func _physics_process(delta: float) -> void:
	pass
