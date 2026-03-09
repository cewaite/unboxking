class_name PushComponent extends Component

@export var parent: CharacterBody2D
@export var push_force: float = 1.0

func get_component_name() -> StringName: 
	return "PushComponent"

func apply_push():
	for i in parent.get_slide_collision_count():
		var collision := parent.get_slide_collision(i)
		var collider = collision.get_collider()
		var push_dir = -collision.get_normal() # for pointing towards impact
		
		if collider is RigidBody2D:
			# Only parent vector length going into the impact - colliders velocity into impact
			var impact_speed = parent.velocity.dot(push_dir) - collider.linear_velocity.dot(push_dir)
			impact_speed = max(0., impact_speed)
			collider.apply_central_impulse(push_dir * impact_speed * push_force)
			
		elif collider is CharacterBody2D:
			#if parent is Hand:
				#print_debug("Velocity of dummy before impact: " + str(collider.velocity))
			var impact_speed = parent.velocity.dot(push_dir) - collider.velocity.dot(push_dir)
			impact_speed = max(0., impact_speed)
			var impact_force_vector = push_dir * impact_speed * push_force
			#print_debug(parent.name + " impacts " + collider.name + " with strength: " + str(impact_force_vector.length()))
			collider.velocity += impact_force_vector
			#if parent is Hand:
				#print_debug("Velocity of dummy after impact: " + str(collider.velocity))
