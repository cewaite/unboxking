class_name UIManager extends CanvasLayer

signal start
signal resume

@export var fade_effect: FadeEffect
@export var main_menu: MainMenu
@export var pause_menu: PauseMenu

var curr_screen: Control

var captured_time_scale: float = Engine.time_scale

func _ready():
	curr_screen = main_menu

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if curr_screen == null:
			curr_screen = pause_menu
			captured_time_scale = Engine.time_scale
			Engine.time_scale = 0.0
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			pause_menu.show()
		elif curr_screen == pause_menu:
			Engine.time_scale = captured_time_scale
			Input.mouse_mode = Input.MOUSE_MODE_CONFINED

func fade_in():
	await fade_effect.fade(0.0).finished

func fade_out():
	await fade_effect.fade(1.0).finished

func _on_pause_menu_resume() -> void:
	curr_screen = null
	Engine.time_scale = captured_time_scale
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	pause_menu.hide()
	resume.emit()

func _on_main_menu_start_game() -> void:
	curr_screen = null
	start.emit()
