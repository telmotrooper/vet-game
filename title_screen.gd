extends Control

func _on_cat_button_pressed() -> void:
	get_tree().change_scene_to_file("res://cat_level/cat_level.tscn")
