class_name JumpComponent extends Component

@export var parent: CharacterBody2D
@export var input_comp: InputComponent
@export var jump_speed: float = -900.0

func get_component_name() -> StringName: 
	return "JumpComponent"

func handle_jump(delta: float):
	if parent.is_on_floor() and input_comp.wants_jump():
		parent.velocity.y += jump_speed
	#if not parent.is_on_floor():
		#parent.velocity.y += gravity_falling * delta
	#else:
		#if input_comp.wants_jump():
			#parent.velocity.y += jump_speed
		#else:
			#parent.velocity.y = 0.0
