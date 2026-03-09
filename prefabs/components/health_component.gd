class_name HealthComponent extends Component

signal taken_damage()

@export var max_health: int
var curr_health: int

func _ready():
	super()
	curr_health = max_health

func get_component_name() -> StringName: 
	return "HealthComponent"

func take_damage(damage):
	if curr_health > 0:
		curr_health -= damage
	
	if curr_health <= 0:
		die()
	else:
		taken_damage.emit()

func restore_health():
	curr_health = max_health

func heal(val):
	curr_health = min(curr_health + val, max_health)

func die():
	owner.die()
