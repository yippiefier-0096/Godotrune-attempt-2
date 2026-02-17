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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hitbox_enemy.shape=RectangleShape2D.new()
	add_child(hitbox_enemy)
	
	
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if self.get_overlapping_bodies():
		print(self.get_overlapping_bodies()[0])
		for i in self.enemy_team.size():
			var _v:battle_profile=self.enemy_team[i].new()
			BattleManager.enemy_team.append(_v)
			BattleManager.add_child(_v)
			BattleManager.battle_start()
		self.hitbox_enemy.set_deferred("disabled",true)
	pass
