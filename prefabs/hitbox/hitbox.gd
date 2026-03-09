class_name HitBox extends Area2D

@export var collider: CollisionShape2D
@export var damage: int = 1
@export var hit_slows_time: bool = false
## How much time slows on a hit, i.e. 0.5 mean time is halfed
@export var hit_slow_factor: float = 0.5
## How long time slows on a hit
@export var hit_slow_time: float = 0.5
var collider_disabled: bool = true

func _ready() -> void:
	assert(collider, "%s should have a collider attached" % self.get_path())
	collider_disabled = collider.disabled

func _on_area_entered(area: Area2D) -> void:
	if area is HurtBox:
		if Engine.time_scale == 1.0 and hit_slows_time:
			Engine.time_scale = hit_slow_factor
			await get_tree().create_timer(hit_slow_time).timeout
			Engine.time_scale = 1.0

func disable_collider():
	collider_disabled = true
	collider.set_deferred("disabled", true)

func enable_collider():
	collider_disabled = false
	collider.set_deferred("disabled", false)
