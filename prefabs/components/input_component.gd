class_name InputComponent extends Component


func get_component_name() -> StringName: 
	return "InputComponent"

## Return the desired direction of morevment for the character
## in range [-1, 1], where positive values indicate a desire to 
## move to the right and negative values to the left.
func get_movement_input() -> float:
	return 0.0

## Return a bolean indicating if the character wants to jump.
## (Not necessarily if it can jump)
func wants_jump() -> bool:
	return false
