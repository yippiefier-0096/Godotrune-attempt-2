extends actor_base
class_name party_member

var dir_vector:Vector2
var party_order:int #if -1, not in the party
var character_id:int
var pos_del:Vector2

var profile:battle_profile

# Called when the node enters the scene tree for the first time.
func _init(_order:int=-1,char:int=0) -> void:
	party_order=_order
	match char:
		0:
			nametag="kris"
			self.sprite_frames=load("uid://b142oqqg5opp3")
		1:
			nametag="susie"
			self.sprite_frames=load("uid://ds5qo1uhvsek0")
		2:
			nametag="ralsei"
			self.sprite_frames=load("uid://gd8tjngqkj4l")
		3:
			nametag="noelle"
			self.sprite_frames=load("uid://bgp5lea4s21mf")

func _ready() -> void:
	print("?????")
	
	globals.party_list.append(self)


func regroup(_o:int=-1):
	self.party_order=_o
func b_intro():
	play("intro")
	await animation_finished
	play("idle")
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if globals.mode!=globals.mode_index.overworld:
		return 
	if OverworldTeam.get_real_velocity().length()>1 and self.party_order>=0:
		if (self.position-OverworldTeam.trail[party_order*25]).length()>5:
			pos_del=OverworldTeam.trail[party_order*25]-self.position
		else:
			pos_del=OverworldTeam.traildir[party_order*25]
		if int(abs(pos_del.y)-abs(pos_del.x))<0:
			if pos_del.x>0:
				self.dir_vector=Vector2(1,0)
			else:
				self.dir_vector=Vector2(-1,0)
		elif int(abs(pos_del.y)-abs(pos_del.x))>=0:
			if pos_del.y>0:
				self.dir_vector=Vector2(0,1)
			else:
				self.dir_vector=Vector2(0,-1)	
		match self.dir_vector:
			Vector2(1,0):
				self.animation="right"
			Vector2(-1,0):
				self.animation="left"
			Vector2(0,1):
				self.animation="down"
			Vector2(0,-1):
				self.animation="up"		
		if self.party_order==0:
			OverworldTeam.detection.rotation=dir_vector.angle()-0.5*PI	
			OverworldTeam.detection2.rotation=dir_vector.angle()-0.5*PI	
		self.play()
		self.position=self.position.move_toward(OverworldTeam.trail[party_order*25],10)
	else:
		self.stop()
	pass
