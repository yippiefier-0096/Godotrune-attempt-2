extends Area2D
class_name battle_instance

##Unimplemented; tp gained when defending.
var special_rule_defense_tp:float
##Unimplemented; TP gained when normally attacking
var special_rule_attack_tp
##Unimplemented; cause the battle to be coveered in darkness
var special_rule_darkness
##
@export var enemy_team:Array[GDScript]
##
@export var graphics:AnimatedSprite2D=AnimatedSprite2D.new()
##
var hitbox_enemy:CollisionShape2D=CollisionShape2D.new()

var hit:bool=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hitbox_enemy.shape=RectangleShape2D.new()
	add_child(hitbox_enemy)
	self.area_entered.connect(battle)
	
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.

func battle(area:Area2D):
	if hit:
		return
	for i in self.enemy_team.size():
		var _v:battle_profile=self.enemy_team[i].new()
		BattleManager.enemy_team.append(_v)
		BattleManager.add_child(_v)
	BattleManager.battle_start()
	self.hitbox_enemy.set_deferred("disabled",true)	
	hit=true
