class_name ImpactFrameComponent extends Component

## How much time slows on a hit, i.e. 0.5 mean time is halfed
@export var hit_slow_factor: float = 0.25
## How long time slows on a hit
@export var hit_slow_time: float = 0.2

func get_component_name() -> StringName: 
	return "ImpactFrameComponent"

func _on_health_component_taken_damage() -> void:
	if Engine.time_scale == 1.0:
		Engine.time_scale = hit_slow_factor
		await get_tree().create_timer(hit_slow_time).timeout
		Engine.time_scale = 1.0
