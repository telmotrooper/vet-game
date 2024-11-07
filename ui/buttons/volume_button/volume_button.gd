extends Button

@export_group("Icons")
@export var volume_on: Texture2D
@export var volume_off: Texture2D

func _ready() -> void:
	update_icon()

func update_icon() -> void:
	if GameState.audio_stream_player.playing:
		set_button_icon(volume_on)
	else:
		set_button_icon(volume_off)

func _on_pressed() -> void:
	GameState.toggle_volume()
	update_icon()
