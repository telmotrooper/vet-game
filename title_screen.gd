extends Control

func _on_dog_button_pressed() -> void:
	GameState.load_scene("res://dog_level/dog_level.tscn")

func _on_cat_button_pressed() -> void:
	GameState.load_scene("res://cat_level/cat_level.tscn")
