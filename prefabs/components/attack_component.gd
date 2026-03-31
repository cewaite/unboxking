class_name AttackComponent extends Component

## Used for syncing attack cooldown
@export var other_attack_comps: Array[AttackComponent]

## Turn on and off hurtbox for now, enable/disable and duration
## can later be tied to the animation player.
@export var attack_hitbox: HitBox
@export var attack_detector: Area2D
@export var attack_indicator: ColorRect
@export var attack_duration: float = 0.1
@export var attack_cooldown: float = 0.1
@export var flip_attack: bool = false
var can_attack: bool = true

func get_component_name() -> StringName: 
	return "AttackComponent"

func _physics_process(delta: float) -> void:
	if flip_attack:
		attack_hitbox.scale.x = 1 if owner.velocity.x >= 0 else -1
		attack_detector.scale.x = 1 if owner.velocity.x >= 0 else -1

func attack():
	if can_attack:
		can_attack = false
		for attackcomp in other_attack_comps:
			attackcomp.can_attack = false
		attack_hitbox.enable_collider()
		if attack_indicator:
			attack_indicator.show()
		await get_tree().create_timer(attack_duration).timeout
		attack_hitbox.disable_collider()
		if attack_indicator:
			attack_indicator.hide()
		await get_tree().create_timer(attack_cooldown).timeout
		can_attack = true
		for attackcomp in other_attack_comps:
			attackcomp.can_attack = true
	
