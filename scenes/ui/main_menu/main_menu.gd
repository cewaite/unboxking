class_name MainMenu extends Control

signal start_game

func _on_play_button_pressed() -> void:
	start_game.emit()


func _on_options_button_pressed() -> void:
	pass # Replace with function body.


func _on_exit_button_pressed() -> void:
	pass # Replace with function body.
