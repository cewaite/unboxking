class_name Dummy extends CharacterBody2D

@export var jump_comp: JumpComponent
@export var grav_comp: GravityComponent

func _physics_process(delta: float) -> void:
	jump_comp.handle_jump(delta)
	grav_comp.apply_gravity(delta)
	move_and_slide()

func die():
	self.queue_free()
