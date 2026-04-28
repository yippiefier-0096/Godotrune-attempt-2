extends bullet_pattern_base
class_name music_attack_base

var note_data:chart_data_base
var current_note_list:Array
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	note_data=load("uid://dpxuwy4ln1yi0")
	var start_time=util.current_playback_ms()
	var spawn_queue=note_data.note_list.filter(func(input:Array):return start_time+4*note_data.delta_beat<input[2] and input[2]<start_time+999*note_data.delta_beat)	
	for i in spawn_queue:
		spawn_note(i)
	self.attack_length=50
	pass # Replace with function body.
func _init(_intensity:float=1) -> void:
	soul_mode=void_mode.new()
	soul_mode.attack_handled=self
func spawn_note(info:Array):
	var lane:int
	var this_note:note_base
	var last_note:note_base=current_note_list.back() if !current_note_list.is_empty() else null
	match info[0]:
		308:
			lane=0
		205:
			lane=1
		511:
			lane=2
		410:
			lane=3

	if info[3]==128:
		if lane == 1 or lane == 0:
			if info[4]==2:# whistle--double
				this_note=double_note.new(info[2],info[5],1.0,lane,true)
			else:
				this_note= hold_note.new(info[2],info[5],1.0,lane,true)
			add_child(this_note)
	else:
		if lane == 1 or lane == 0:
			this_note= note_base.new(info[2],info[2],1.0,lane,true)
			add_child(this_note)
		if lane == 2:
			if last_note is freestyle_note:
				this_note=freestyle_followup.new(info[2],info[2],1.0,lane,true)
				last_note.followups.append(this_note)
				add_child(this_note)
				this_note.missed.connect(last_note.sub_missed)
				last_note.clear.connect((this_note.safe_free))
				return
			else:
				this_note=freestyle_note.new(info[2],info[2],1.0,lane,true)
				add_child(this_note)
	if this_note is not freestyle_note:
		if last_note is freestyle_note:
			print(last_note.followups)
			current_note_list.append_array(last_note.followups)
			
			
	if this_note:
		current_note_list.append(this_note)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
