extends Button

func _on_pressed() -> void:
	$"/root/Main".load_scene("res://title_screen.tscn")
