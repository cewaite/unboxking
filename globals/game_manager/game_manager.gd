class_name GameManager extends Node

#@export var ui_manager: UIManager
@export var level: Node2D

@export var boss: Boss

const KNIGHT_SCENE = preload("uid://b2go38g2ml5gq")
var knight: Knight
@export var knight_spawn: Marker2D
@export var knight_spawn_time: float = 1.0

func _ready() -> void:
	assert(boss, "Boss has not been initalized")
	load_game()

func load_game():
	#await ui_manager.fade_out()
	await spawn_knight()
	#await ui_manager.fade_in()

func spawn_knight():
	Engine.time_scale = 1.0
	await get_tree().create_timer(knight_spawn_time).timeout
	var new_knight = KNIGHT_SCENE.instantiate() as Knight
	new_knight.global_position = knight_spawn.global_position
	new_knight.pass_boss_parts(boss.left_hand, boss.right_hand)
	new_knight.died.connect(spawn_knight)
	level.add_child(new_knight)
	knight = new_knight

func load_ui():
	pass
