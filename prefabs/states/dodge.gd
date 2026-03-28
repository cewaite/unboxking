class_name Dodge extends State

@export var input_comp: InputComponent
@export var dodge_comp: DodgeComponent
var init_x_direction

func enter():
	init_x_direction = input_comp.get_movement_input()
	dodge_comp.start_dodge()

func exit():
	dodge_comp.end_dodge()

func update(delta: float):
	super(delta)
	pass

func physics_update(delta: float):
	dodge_comp.dodge(delta, init_x_direction)
	
	if not dodge_comp.is_dodging:
		transition.emit(self, "MOVE")
