class_name Hand extends CharacterBody2D

signal controlled_hand(hand)

@export var parent_boss: Boss

@export_group("Components")
@export var push_comp: PushComponent

@export_group("Punch Hitbox")
@export var punch_hitbox: HitBox
@export var punch_hitbox_velocity: float = 800.0

@export_group("Hand Speeds")
@export_subgroup("Normal Speeds")
@export var normal_speed: float = 600.0
@export var normal_accel: float = 2000.0
@export var max_normal_speed: float = 800.0

@export_subgroup("Fist Speeds")
@export var fist_speed: float = 2000.0
@export var fist_accel: float = 4000.0
@export var max_fist_speed: float = 1000.0

@export_subgroup("Return Speeds")
@export var return_speed: float = 500.0
@export var return_accel: float = 6000.0

@export_group("Misc")
@export var approx_distance_range: float = 5.0

var hand_return_pos: Vector2
var is_mouse_hovering: bool = false
var is_mouse_controlled: bool = false
var is_fist: bool = false

func _ready() -> void:
	hand_return_pos = get_parent().global_position

func _physics_process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	var target_velocity: Vector2
	var accel: float
	
	if is_mouse_controlled:
		accel = fist_accel if is_fist else normal_accel
		var speed = fist_speed if is_fist else normal_speed
		target_velocity = global_position.direction_to(mouse_pos) * speed
	else:
		accel = return_accel
		target_velocity = global_position.direction_to(hand_return_pos) * return_speed
	
	# Smoothly move toward target velocity
	velocity = velocity.move_toward(target_velocity, accel * delta)
	
	# Stop near target
	var target_pos = mouse_pos if is_mouse_controlled else hand_return_pos
	var distance = (target_pos - global_position).length()
	if distance < approx_distance_range:
		velocity = velocity.move_toward(Vector2.ZERO, accel * delta)
	
	# Clamp max speed
	#var max_speed = max_fist_speed if is_fist else max_normal_speed
	#if velocity.length() > max_speed:
		#print_debug("LIMITING")
		#velocity = velocity.normalized() * max_speed
	
	# Handle Hitbox rotation and enable if fast enough
	update_hitbox()
	
	# Resolve collisions with players
	push_comp.apply_push()
	
	# Move the hand
	#print_debug(owner.name, " velocity length: ", velocity.length())
	move_and_slide()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed() and is_mouse_hovering and not parent_boss.controlled_hand:
				is_mouse_controlled = true
				controlled_hand.emit(self)
			else:
				is_mouse_controlled = false
				controlled_hand.emit(null)
		
		if event.button_index == MOUSE_BUTTON_RIGHT:
			if event.is_pressed() and is_mouse_controlled:
				is_fist = true
			else:
				is_fist = false

func update_hitbox():
	punch_hitbox.rotation = velocity.angle() + deg_to_rad(90.0)
	if punch_hitbox.collider_disabled and velocity.length() >= punch_hitbox_velocity:
		punch_hitbox.enable_collider()
	elif not punch_hitbox.collider_disabled and velocity.length() <= punch_hitbox_velocity:
		punch_hitbox.disable_collider()

#--- SIGNALS --#
func _on_mouse_entered() -> void:
	is_mouse_hovering = true

func _on_mouse_exited() -> void:
	is_mouse_hovering = false

func die():
	owner.queue_free()
