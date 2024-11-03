extends Control

func _on_dog_button_pressed() -> void:
	GameState.load_scene("res://levels/dog_level/dog_level.tscn")

func _on_cat_button_pressed() -> void:
	GameState.load_scene("res://levels/cat_level/cat_level.tscn")

func _on_lympathic_system_button_pressed() -> void:
	GameState.load_scene("res://levels/lymphatic_system_level/lymphatic_system_level.tscn")
