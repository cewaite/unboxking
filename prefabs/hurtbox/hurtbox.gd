class_name HurtBox extends Area2D

@export var health_comp: HealthComponent

func _ready():
	assert(health_comp, "%s should have a HealthComponent attached" % self.get_path())

func _on_area_entered(hitbox: HitBox):
	if health_comp.has_method("take_damage"):
		print_debug("TAKING DAMAGE")
		health_comp.take_damage(hitbox.damage)
