class_name MovingDummy extends Dummy

@onready var vector_ray_cast: VectorRayCast = $VectorRayCast
@onready var target_ray_cast: VectorRayCast = $TargetRayCast

@export var move_comp: MovementComponent
@export var push_comp: PushComponent

@export var stun_time: float = 2.0
var stunned: bool = false

func _physics_process(delta: float) -> void:
	grav_comp.apply_gravity(delta)
	if not stunned:
		#print_debug("NOT_STUNNED, velocity: " + str(velocity))
		move_comp.handle_move(delta)
		jump_comp.handle_jump(delta)
	push_comp.apply_push()
	move_and_slide()
	vector_ray_cast.show_vector_as_ray(velocity)

func _on_health_component_taken_damage() -> void:
	stunned = true
	await get_tree().create_timer(stun_time).timeout
	stunned = false
