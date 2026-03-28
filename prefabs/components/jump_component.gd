class_name JumpComponent extends Component

@export var parent: CharacterBody2D
@export var jump_speed: float = -900.0

func get_component_name() -> StringName: 
	return "JumpComponent"

func jump(delta: float):
	if parent.is_on_floor():
		parent.velocity.y += jump_speed
