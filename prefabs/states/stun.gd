class_name Stun extends State

@export var legs_anim_player: AnimationPlayer
@export var body_anim_player: AnimationPlayer
@export var leg_sprites_parent: Node2D
@export var body_sprites_parent: Node2D
@export var flash_freq: float = 2.0
var flash_timer: float = flash_freq

@export var stun_duration: float = 2.0
var stun_timer: float = stun_duration

func enter():
	super()
	stun_timer = stun_duration
	#flash_timer = flash_freq
	legs_anim_player.play("RESET")
	body_anim_player.play("RESET")

func exit():
	super()
	stun_timer = stun_duration
	#leg_sprites_parent.show()
	#body_sprites_parent.show()

func update(delta: float):
	super(delta)
	#if flash_timer <= 0.0:
		#leg_sprites_parent.visible = not leg_sprites_parent.visible
		#body_sprites_parent.visible = not body_sprites_parent.visible
		#flash_timer = flash_freq
	#else:
		#flash_freq -= delta

func physics_update(delta: float):
	if stun_timer <= 0.0:
		transition.emit(self, "MOVE")
	else:
		stun_timer -= delta
