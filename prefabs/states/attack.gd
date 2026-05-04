class_name Attack extends State

@export var attack_comp: AttackComponent

@export var body_anim_player: AnimationPlayer

#func _ready() -> void:
	#if body_anim_player:
		#attack_comp.attack_duration = body_anim_player.get_animation("horizontal_attack").length

func enter():
	super()
	if body_anim_player:
		body_anim_player.play("horizontal_attack")

func exit():
	super()

func update(delta: float):
	super(delta)
	pass

func physics_update(delta: float):
	attack_comp.attack()
	if body_anim_player:
		await get_tree().create_timer(body_anim_player.get_animation("horizontal_attack").length).timeout
	transition.emit(self, "MOVE")
