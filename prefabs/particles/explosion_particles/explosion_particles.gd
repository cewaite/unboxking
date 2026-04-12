class_name ExplosionParticles extends GPUParticles2D

func _ready() -> void:
	one_shot = true
	await get_tree().create_timer(self.lifetime).timeout
	call_deferred("queue_free")
