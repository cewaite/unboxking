class_name GravityComponent extends Component

@export var parent: CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# Variable gravity for responsiveness
var gravity_falling = 1.5 * gravity
var gravity_hang_time = .7 * gravity
var curr_gravity = gravity

func get_component_name() -> StringName: 
	return "GravityComponent"

func apply_gravity(delta: float):
	if not parent.is_on_floor():
		parent.velocity.y += gravity_falling * delta
