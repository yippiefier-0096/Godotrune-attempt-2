extends bullet_pattern_base
class_name music_attack_base

var note_data:chart_data_base
var current_note_list:Array[note_base]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	note_data=load("uid://dpxuwy4ln1yi0")
	var start_time=BgmManager.get_playback_position()+AudioServer.get_time_since_last_mix()
	var spawn_queue=note_data.note_list.filter(func(input:Array):return start_time*1000+4*note_data.delta_beat<input[2] and input[2]<start_time*1000+50*note_data.delta_beat)	
	for i in spawn_queue:
		spawn_note(i)
	self.attack_length=50
	pass # Replace with function body.

func spawn_note(info:Array):
	var lower_lane:bool
	var this_note:note_base
	match info[0]:
		205:
			lower_lane=true
			this_note= note_base.new(info[2],info[2],1.0,lower_lane,true)
			add_child(this_note)
			current_note_list.append(this_note)
		308:
			lower_lane=false
			this_note=note_base.new(info[2],info[2],1.0,lower_lane,true)
			add_child(this_note)
			current_note_list.append(this_note)
		410:
			pass
			#both lane notes
		511:
			pass
			#effect notes
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
