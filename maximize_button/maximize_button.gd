extends Button

@export_group("Icons")
@export var maximize_icon: Texture2D
@export var minimize_icon: Texture2D

# We store the window mode because on "web" the value of "get_window().mode" is not reliable.
var window_mode: Window.Mode

func _ready() -> void:
	window_mode = get_window().mode
	update_icon()

func update_icon() -> void:
	if window_mode == Window.MODE_FULLSCREEN:
		set_button_icon(minimize_icon)
	else:
		set_button_icon(maximize_icon)

func toggle_fullscreen() -> void:
	window_mode = Window.MODE_FULLSCREEN if get_window().mode != Window.MODE_FULLSCREEN else Window.MODE_WINDOWED
	get_window().mode = window_mode

func _on_pressed() -> void:
	toggle_fullscreen()
	update_icon()
