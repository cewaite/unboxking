class_name HurtBox extends Area2D

@export var collider: CollisionShape2D
@export var health_comp: HealthComponent

var collider_disabled: bool = false

func _ready():
	assert(health_comp, "%s should have a HealthComponent attached" % self.get_path())

func _on_area_entered(hitbox: HitBox):
	if health_comp.has_method("take_damage") and owner != hitbox.owner:
		# Temp fix to prevent smash wave from dealing damage to boss
		if not (owner is Hand and hitbox.owner is SmashWave):
			#print_debug(owner.name + " took " + str(hitbox.damage) + " damage.")
			health_comp.take_damage(hitbox.damage)

func disable_collider():
	collider_disabled = true
	collider.set_deferred("disabled", true)

func enable_collider():
	collider_disabled = false
	collider.set_deferred("disabled", false)
