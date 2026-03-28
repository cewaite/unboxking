class_name SmartInputComponent extends InputComponent

@export var parent: CharacterBody2D
@export var random_input_comp: RandomInputComponent

var boss_left_hand: Hand
var boss_right_hand: Hand
#var boss_head: Head

#@export var immediate_vision: Area2D

### Time range in seconds before possible turn turn_freq_min to turn_freq_max, inclusive.
#@export var turn_freq_min: float = 0.0
### Time range in seconds before possible turn turn_freq_min to turn_freq_max, inclusive.
#@export var turn_freq_max: float = 1.0
### Time range in seconds before possible jump 0 to jump_freq, inclusive.
#@export var jump_freq: float = 4.0
#var running_left: bool = false

## The x range the knight must be within to trigger an attack on a Hand
@export var hand_attack_range: float = 200.0

var trigger_jump: bool = false
var wants_horizontal_attack: bool = false
var wants_vertical_attack: bool = false
var trigger_dodge: bool = false

#func _ready() -> void:
	#super()
	#start_turn_timer()
	#start_jump_timer()

## Return the desired direction of morevment for the character
## in range [-1, 1], where positive values indicate a desire to 
## move to the right and negative values to the left.
## (In SmartInputComponent's case, prioritizing the closest uncontrolled hand, moves within range to attack,
## then triggers jumps if attack not on cooldown, before moving directly into the hand. If not attack on cooldown
## move around in range of hand randomly. Only target Head if its low enough, in which case, get right below, jump straight up with no movement input)
func get_movement_input() -> float:
	var target_hand = closest_uncontrolled_hand()
	if target_hand:
		var x_distance_to_target = target_hand.global_position.x - parent.global_position.x
		var move_direction_towards_hand = -1 if x_distance_to_target <= 0.0 else 1
		if abs(x_distance_to_target) > hand_attack_range:
			return move_direction_towards_hand
		elif abs(x_distance_to_target) <= hand_attack_range and not (wants_horizontal_attack or wants_vertical_attack):
			trigger_jump = true
			return move_direction_towards_hand
		elif abs(x_distance_to_target) <= hand_attack_range and (wants_horizontal_attack or wants_vertical_attack):
			return -move_direction_towards_hand
		else:
			return random_input_comp.get_movement_input()
	return random_input_comp.get_movement_input()

## Return a bolean indicating if the character wants to jump.
func wants_jump() -> bool:
	if trigger_jump:
		trigger_jump = false
		#start_jump_timer()
		return true
	return false

func wants_dodge() -> bool:
	if trigger_dodge:
		trigger_dodge = false
		return true
	return false

func closest_uncontrolled_hand() -> Hand:
	if boss_left_hand and boss_right_hand:
		if boss_left_hand.is_mouse_controlled and not boss_right_hand.is_mouse_controlled:
			return boss_right_hand
		elif not boss_left_hand.is_mouse_controlled and boss_right_hand.is_mouse_controlled:
			return boss_left_hand
		else:
			var distance_to_left_hand = parent.global_position.distance_to(boss_left_hand.global_position)
			var distance_to_right_hand = parent.global_position.distance_to(boss_right_hand.global_position)
			if (distance_to_left_hand <= distance_to_right_hand):
				return boss_left_hand
			else:
				return boss_right_hand
	elif boss_left_hand and not boss_right_hand:
		return boss_left_hand
	elif not boss_left_hand and boss_right_hand:
		return boss_right_hand
	return null

#func start_turn_timer():
	#await get_tree().create_timer(randf_range(turn_freq_min, turn_freq_max)).timeout
	#running_left = not running_left
	#start_turn_timer()
#
#func start_jump_timer():
	#await get_tree().create_timer(randf_range(0, jump_freq)).timeout
	#trigger_jump = true

#---- SIGNALS ----

func _on_immediate_vision_body_entered(body: Node2D) -> void:
	if body is Hand:
		var hand = body as Hand
		if not hand.punch_hitbox.collider_disabled:  
			trigger_dodge = true
	elif body.owner is SmashWave:
		trigger_dodge = true

func _on_vertical_attack_detector_body_entered(body: Node2D) -> void:
	if body is Hand:
		var hand = body as Hand
		if hand.punch_hitbox.collider_disabled:  
			wants_vertical_attack = true

func _on_vertical_attack_detector_body_exited(body: Node2D) -> void:
	wants_vertical_attack = false

func _on_horizontal_attack_detector_body_entered(body: Node2D) -> void:
	if body is Hand:
		var hand = body as Hand
		if hand.punch_hitbox.collider_disabled:  
			wants_horizontal_attack = true

func _on_horizontal_attack_detector_body_exited(body: Node2D) -> void:
	wants_horizontal_attack = false
