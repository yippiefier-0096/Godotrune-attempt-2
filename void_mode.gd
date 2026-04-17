extends heart_shaped_object
class_name void_mode

var attack_handled:music_attack_base

var lane_position:Array[float]=[1,0]

var holding:bool=false

var tandem_frame_counter=0
var tweener:Tween
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
		if tandem_frame_counter>0:
			var _double:soul_double=soul_double.new(true)
			add_sibling(_double)
			tandem_frame_counter=0
			if target is hold_note:
				_double.holding=true
				target.note_released.connect(_double.set.bind("holding",false))
			pass
		elif tandem_frame_counter==0:
			if tweener:tweener.kill()
			tweener=create_tween()
			tweener.set_trans(Tween.TRANS_LINEAR)
			tweener.tween_property(self,"position:y",250,0.025)
			tandem_frame_counter=-3
			if target is hold_note:
				holding=true
				target.note_released.connect(set.bind("holding",false))
		pass
	if event.is_action_pressed("rhythm_up"):
		var temp_list=all_notes.filter(func(x:note_base):return x.on_lane==x.lane_meaning.up or x.on_lane==x.lane_meaning.both)
		if temp_list.is_empty():
			return
		target=temp_list[0]
		target.hit(event_keycode)
		print("hit_up",target)
		if tandem_frame_counter<0:
			var _double:soul_double=soul_double.new(false)
			add_sibling(_double)
			tandem_frame_counter=0
			if target is hold_note:
				_double.holding=true
				target.note_released.connect(_double.set.bind("holding",false))
			pass
		elif tandem_frame_counter==0:
			if tweener:tweener.kill()
			tweener=create_tween()
			tweener.set_trans(Tween.TRANS_LINEAR)
			tweener.tween_property(self,"position:y",150,0.025)
			tandem_frame_counter=3
			if target is hold_note:
				holding=true
				target.note_released.connect(set.bind("holding",false))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass

	
func _physics_process(delta: float) -> void:
	if tandem_frame_counter>0:
		tandem_frame_counter-=1
	if tandem_frame_counter<0:
		tandem_frame_counter+=0
	if holding==false && !tweener:
		tweener=create_tween()
		tweener.set_trans(Tween.TRANS_QUAD)
		tweener.tween_property(self,"position:y",250,0.5)
	pass
