class_name RandomInputComponent extends InputComponent

@export var parent: CharacterBody2D

## Time range in seconds before possible turn turn_freq_min to turn_freq_max, inclusive.
@export var turn_freq_min: float = 0.1
## Time range in seconds before possible turn turn_freq_min to turn_freq_max, inclusive.
@export var turn_freq_max: float = 1.0
## Time range in seconds before possible jump 0 to jump_freq, inclusive.
@export var jump_freq: float = 4.0
var running_left: bool = false
var can_jump: bool = false

func _ready() -> void:
	super()
	start_turn_timer()
	start_jump_timer()

## Return the desired direction of morevment for the character
## in range [-1, 1], where positive values indicate a desire to 
## move to the right and negative values to the left.
## (In RandomInputComponent's case, randomly switches between -1 and 1.)
func get_movement_input() -> float:
	if parent.is_on_wall():
		running_left = not running_left
	
	var running_direction = Vector2.LEFT if running_left else Vector2.RIGHT
	return running_direction.x

## Return a bolean indicating if the character wants to jump.
func wants_jump() -> bool:
	if can_jump:
		can_jump = false
		start_jump_timer()
		return true
	return false

func start_turn_timer():
	await get_tree().create_timer(randf_range(turn_freq_min, turn_freq_max)).timeout
	running_left = not running_left
	start_turn_timer()

func start_jump_timer():
	await get_tree().create_timer(randf_range(0, jump_freq)).timeout
	can_jump = true
