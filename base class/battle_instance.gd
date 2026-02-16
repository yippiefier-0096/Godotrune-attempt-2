extends Area2D
class_name battle_instance

##Unimplemented; tp gained when defending.
var special_rule_defense_tp:float
##Unimplemented; TP gained when normally attacking
var special_rule_attack_tp
##Unimplemented; cause the battle to be coveered in darkness
var special_rule_darkness
##
var enemy_team:Array[battle_profile]
##
@export var graphics:AnimatedSprite2D=AnimatedSprite2D.new()
##
var hitbox_enemy:CollisionShape2D=CollisionShape2D.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hitbox_enemy.shape=RectangleShape2D.new()
		
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	pass
