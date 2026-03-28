class_name DodgeComponent extends Component

@export var parent: Knight

@export var dodge_speed: float = 1200.0
@export var max_dodge_speed: float = 2000.0
@export var accel: float = 1200.0
@export var dodge_duration: float = 2.0
@export var dodge_cooldown: float = 4.0
var dodge_timer: float = dodge_duration
var is_dodging: bool = false

func _ready() -> void:
	super()
	dodge_timer = dodge_duration

func get_component_name() -> StringName: 
	return "DodgeComponent"

func dodge(delta: float, x_direction: float) -> void:
	#print_debug("DODGING! Dodge timer: " + str(dodge_timer))
	if is_dodging and dodge_timer > 0.0:
		dodge_timer -= delta
		
		var target_x_velocity = (x_direction * dodge_speed)
		parent.velocity.x = move_toward(
			parent.velocity.x,
			target_x_velocity,
			accel * delta
		)
		
		if parent.velocity.length() > max_dodge_speed:
			parent.velocity = parent.velocity.normalized() * max_dodge_speed
	else:
		is_dodging = false


func start_dodge():
	if parent.is_on_floor():
		is_dodging = true
		dodge_timer = dodge_duration
		disable_collisons()

func end_dodge():
	enable_collisions()
	start_dodge_cooldown()

func disable_collisons():
	parent.invincible_on()

func enable_collisions():
	parent.invincible_off()

func start_dodge_cooldown():
	await get_tree().create_timer(dodge_cooldown).timeout
	dodge_timer = dodge_duration
