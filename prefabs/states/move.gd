class_name Move extends State

@export var input_comp: InputComponent
@export var move_comp: MovementComponent

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
	move_comp.handle_move(delta, input_comp.get_movement_input())
	
	if input_comp.wants_dodge():
		transition.emit(self, "Dodge")
	
	if input_comp.wants_horizontal_attack:
		transition.emit(self, "HorizontalAttack")
	
	if input_comp.wants_vertical_attack:
		transition.emit(self, "VerticalAttack")
	
	if input_comp.has_method("wants_jump") and input_comp.wants_jump():
		transition.emit(self, "Jump")

func _on_health_component_taken_damage() -> void:
	transition.emit(self, "Stun")
