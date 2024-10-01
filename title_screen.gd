extends Control

func _on_cat_button_pressed() -> void:
	$"/root/Main".load_scene("res://cat_level/cat_level.tscn")
