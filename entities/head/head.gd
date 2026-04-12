class_name Head extends Node2D

@export var left_eye_sprite: Sprite2D
@export var right_eye_sprite: Sprite2D
var knight: Knight

func _process(delta: float) -> void:
	eye_animation()

func eye_animation():
	if knight:
		left_eye_sprite.position.x = remap(knight.global_position.x, 0, 1280, -18, 18)
		right_eye_sprite.position.x = remap(knight.global_position.x, 0, 1280, -18, 18)
