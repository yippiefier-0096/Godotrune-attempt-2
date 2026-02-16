extends Node2D
## Autoload Node that facilitates turn based battles by managing [battle_profile]s. 
class_name battle_manager
##the soul used for most normal attacks
var soul_normal:heart_shaped_object
## the effective tp the player has. caps at 1000 - effectively 100%.
var tp_gauge:float
##
var enemy_attacks:Array[bullet_pattern_base]
##
var bt_timer:float=9999999
##the enemy roster for any battle.
var enemy_team:Array[battle_profile]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	pass # Replace with function body.
func battle_start():
	my_turn()
	pass
func my_turn():
	globals.mode=globals.mode_index.battle_turn
func enemy_turn():
	if globals.mode==globals.mode_index.battle_turn:
		self.position=OverworldTeam.position
		soul_normal=heart_shaped_object.new()
		self.add_child(soul_normal)
		globals.mode=globals.mode_index.battle_dodge
		add_child(test_pattern.new())
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("a"):
		battle_start()
	if event.is_action_pressed("s"):
		enemy_turn()
	if event.is_action_pressed("d"):
		my_turn()
	pass
func _process(delta: float) -> void:
	pass
