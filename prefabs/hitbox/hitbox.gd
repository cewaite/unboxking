class_name HitBox extends Area2D

@export var collider: CollisionShape2D
@export var damage: int = 1
@export var collider_disabled: bool = true

func _ready() -> void:
	assert(collider, "%s should have a collider attached" % self.get_path())
	if collider_disabled:
		disable_collider()
	else:
		enable_collider()

func disable_collider():
	collider_disabled = true
	collider.set_deferred("disabled", true)

func enable_collider():
	collider_disabled = false
	collider.set_deferred("disabled", false)
