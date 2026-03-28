class_name SmashWave extends Node2D

@onready var left_wave: CharacterBody2D = $LeftWave
@onready var right_wave: CharacterBody2D = $RightWave

@export var wave_speed: float = 300.0

func _physics_process(delta: float) -> void:
	if left_wave:
		var left_collision = left_wave.move_and_collide(Vector2.LEFT * wave_speed * delta)
		if left_collision:
			left_wave.call_deferred("queue_free")
	
	if right_wave:
		var right_collision = right_wave.move_and_collide(Vector2.RIGHT * wave_speed * delta)
		if right_collision:
			right_wave.call_deferred("queue_free")
	
	if not left_wave and not right_wave:
		self.call_deferred("queue_free")

func _on_left_hitbox_area_entered(area: Area2D) -> void:
	left_wave.call_deferred("queue_free")

func _on_right_hitbox_area_entered(area: Area2D) -> void:
	right_wave.call_deferred("queue_free")
