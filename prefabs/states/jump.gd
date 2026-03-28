class_name Jump extends State

@export var jump_comp: JumpComponent

func enter():
	super()
	pass

func exit():
	super()
	pass

func update(delta: float):
	super(delta)
	pass

func physics_update(delta: float):
	jump_comp.jump(delta)
	transition.emit(self, "MOVE")

func _on_health_component_taken_damage() -> void:
	transition.emit(self, "STUN")
