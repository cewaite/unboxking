class_name Knight extends CharacterBody2D

signal died()

const EXPLOSION_PARTICLES = preload("res://prefabs/particles/explosion_particles/explosion_particles.tscn")

@onready var vector_ray_cast: VectorRayCast = $VectorRayCast
@onready var target_ray_cast: VectorRayCast = $TargetRayCast

@export var input_comp: SmartInputComponent
@export var grav_comp: GravityComponent
@export var push_comp: PushComponent

@export var sprites: Array[Sprite2D]

@export var hurtbox: HurtBox
var is_invincible: bool = false

func _physics_process(delta: float) -> void:
	grav_comp.apply_gravity(delta)
	push_comp.apply_push()
	flip_sprites()
	move_and_slide()
	vector_ray_cast.show_vector_as_ray(velocity)

## Give Knight InputComponent access to Boss Parts to track their position,
## velocity and know which one is being controller
func pass_boss_parts(left_hand, right_hand):
	if left_hand:
		input_comp.boss_left_hand = left_hand
	if right_hand:
		input_comp.boss_right_hand = right_hand

func invincible_on():
	if not is_invincible:
		# Remove from Enemies layer so boss doesnt collide with it.
		# But still on default layer to collide with floor
		set_collision_layer_value(3, false)
		# Remove Boss from mask so it doesnt collide with Boss
		set_collision_mask_value(2, false)
		# Disable hurtbox
		hurtbox.disable_collider()
		is_invincible = true

func invincible_off():
	if is_invincible:
		set_collision_layer_value(3, true)
		# Add collision with boss
		set_collision_mask_value(2, true)
		# Disable hurtbox
		hurtbox.enable_collider()
		is_invincible = false

func die():
	var packing_explosion = EXPLOSION_PARTICLES.instantiate() as ExplosionParticles
	packing_explosion.global_position = self.global_position
	var parent = self.get_parent()
	parent.add_child(packing_explosion)
	died.emit()
	self.call_deferred("queue_free")

func flip_sprites():
	if sign(velocity.x) > 0:
		for sprite in sprites:
			if not sprite.flip_h:
				sprite.flip_h = true
	else:
		for sprite in sprites:
			if sprite.flip_h:
				sprite.flip_h = false
