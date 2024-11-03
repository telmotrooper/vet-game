extends Control

func _on_dog_button_pressed() -> void:
	GameState.load_scene("res://dog_level/dog_level.tscn")

func _on_cat_button_pressed() -> void:
	GameState.load_scene("res://cat_level/cat_level.tscn")

func _on_lympathic_system_button_pressed() -> void:
	GameState.load_scene("res://lymphatic_system_level/lymphatic_system_level.tscn")
