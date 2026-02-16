extends actor_base
class_name party_member

var dir_vector:Vector2
var party_order:int #if -1, not in the party
var character_id:int
var pos_del:Vector2

var profile:battle_profile

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	pass # Replace with function body.
func _init(_order:int=-1,char:int=0) -> void:
	party_order=_order
	match char:
		0:
			self.sprite_frames=load("uid://bfa4q01xr86tx")
			self.profile=kris_profile.new()
		1:
			self.profile=susie_profile.new()
			self.sprite_frames=load("uid://pqi56gxfkg52")
		2:
			self.sprite_frames=load("uid://ta0xkgr01rjj")
			self.profile=ralsei_profile.new()
		3:
			self.sprite_frames=load("uid://cgmj7xivj1yhx")
			self.profile=noelle_profile.new()
	
	add_child(self.profile)

func regroup(_o:int=-1):
	self.party_order=_o

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
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
