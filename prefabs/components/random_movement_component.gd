class_name RandomMovementComponent extends Component

@export var parent: CharacterBody2D
## Eventually moved to RandomAIComponent (Act as InputComponent),
## and this script renamed to MoveComponent
@export var jump_comp: JumpComponent

@export var run_speed: float = 600.0
@export var accel: float = 1800.0
@export var max_speed: float = 1000.0
## Time range in seconds before possible turn 0 to turn_freq, inclusive
@export var turn_freq: float = 1.0
@export var jump_cooldown: float = 4.0
var running_left: bool = false
var can_jump: bool = true

func _ready():
	super()
	assert(parent, "%s should have a parent assigned." % self.get_path())
	start_turn_timer()

func get_component_name() -> StringName: 
	return "RandomMovementComponent"

func run_randomly(delta: float) -> void:
	# Randomly run left or right
	var running_direction = Vector2.LEFT if running_left else Vector2.RIGHT
	var target_velocity = (running_direction * run_speed)
	parent.velocity.x = move_toward(
		parent.velocity.x,
		target_velocity.x,
		accel * delta
	)
	
	if parent.is_on_floor() and can_jump:
		can_jump = false
		jump_comp.activate_jump()
		start_jump_cooldown()
	
	if parent.velocity.length() > max_speed:
		parent.velocity = parent.velocity.normalized() * max_speed

func start_turn_timer():
	await get_tree().create_timer(randf_range(0, turn_freq)).timeout
	running_left = not running_left
	start_turn_timer()

func start_jump_cooldown():
	await get_tree().create_timer(randi_range(0, jump_cooldown)).timeout
	can_jump = true
