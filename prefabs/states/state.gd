class_name State extends Node

## Signal for state_transitions, passing self as "state" and
## the name of the new state to transition to (i.e., "JUMPING")
signal transition(state, new_state_name)

func enter():
	pass

func exit():
	pass

func update(delta: float):
	pass

func physics_update(delta: float):
	pass
