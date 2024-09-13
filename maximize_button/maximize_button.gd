extends Button

@export_group("Icons")
@export var maximize_icon: Texture2D
@export var minimize_icon: Texture2D

func _ready() -> void:
	update_icon()

func update_icon() -> void:
	if get_window().mode == Window.MODE_FULLSCREEN:
		set_button_icon(minimize_icon)
	else:
		set_button_icon(maximize_icon)

func toggle_fullscreen() -> void:
	get_window().mode = Window.MODE_FULLSCREEN if get_window().mode != Window.MODE_FULLSCREEN else Window.MODE_WINDOWED

func _on_pressed() -> void:
	toggle_fullscreen()
	update_icon()
