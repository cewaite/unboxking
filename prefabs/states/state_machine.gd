class_name StateMachine extends Node

@export var init_state: State
var curr_state: State
var states: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_upper()] = child
			child.transition.connect(on_state_transition)
	
	if init_state:
		init_state.enter()
		curr_state = init_state

func _process(delta: float) -> void:
	if curr_state:
		curr_state.update(delta)

func _physics_process(delta: float) -> void:
	if curr_state:
		#print_debug(curr_state.name)
		curr_state.physics_update(delta)

func on_state_transition(state, new_state_name):
	new_state_name = new_state_name.to_upper()
	if state != curr_state or not states[new_state_name]:
		return
	
	curr_state.exit()
	curr_state = states[new_state_name]
	curr_state.enter()
