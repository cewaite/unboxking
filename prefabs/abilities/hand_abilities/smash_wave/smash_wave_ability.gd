class_name SmashWaveAbility extends Node

const SMASH_WAVE_SCENE = preload("uid://cjiblqp6287j2")

@export var parent: Hand
@export var smash_velocity: float = 600.0
@export var smash_cooldown: float = 10.0
var smash_ready: bool = true
var prev_velocity: float = 0.0

func _physics_process(delta: float) -> void:
	check_smash()
	prev_velocity = parent.velocity.length()

func check_smash() -> void:
	#var floor_angle = parent.get_floor_angle()
	#print_debug(floor_angle)
	
	if can_smash():
		var collision = parent.get_last_slide_collision()
		var collider = collision.get_collider()
		if "Floor" in collider.name:
			print_debug("SMASH w/ velocity ", prev_velocity)
			spawn_wave(collision.get_position())
	
func spawn_wave(wave_pos):
	smash_ready = false
	var wave = SMASH_WAVE_SCENE.instantiate()
	wave.global_position = wave_pos
	add_child(wave)
	start_smash_cooldown()

func start_smash_cooldown():
	await get_tree().create_timer(smash_cooldown).timeout
	smash_ready = true

func can_smash() -> bool:
	return parent.is_on_floor_only() and not parent.is_fist and prev_velocity >= smash_velocity and smash_ready
