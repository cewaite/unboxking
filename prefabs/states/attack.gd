class_name Attack extends State

@export var attack_comp: AttackComponent

func enter():
	super()

func exit():
	super()

func update(delta: float):
	super(delta)
	pass

func physics_update(delta: float):
	attack_comp.attack()
	transition.emit(self, "MOVE")
