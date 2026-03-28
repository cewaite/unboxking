class_name Stun extends State

@export var stun_duration: float = 2.0
var stun_timer: float = stun_duration

func enter():
	super()
	stun_timer = stun_duration

func exit():
	super()
	stun_timer = stun_duration

func update(delta: float):
	super(delta)
	pass

func physics_update(delta: float):
	if stun_timer <= 0.0:
		transition.emit(self, "MOVE")
	else:
		stun_timer -= delta
