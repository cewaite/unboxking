class_name MovementComponent extends Component

@export var parent: CharacterBody2D
@export var input_comp: InputComponent

@export var run_speed: float = 600.0
@export var accel: float = 1800.0
@export var max_speed: float = 1000.0

func get_component_name() -> StringName: 
	return "MovementComponent"

func handle_move(delta: float) -> void:
	var target_x_velocity = (input_comp.get_movement_input() * run_speed)
	parent.velocity.x = move_toward(
		parent.velocity.x,
		target_x_velocity,
		accel * delta
	)
	
	if parent.velocity.length() > max_speed:
		parent.velocity = parent.velocity.normalized() * max_speed
