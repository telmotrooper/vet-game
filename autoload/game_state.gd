extends Node

@onready var audio_stream_player = $AudioStreamPlayer

func toggle_volume() -> void:
	if $AudioStreamPlayer.playing:
		$AudioStreamPlayer.stream_paused = true
	else:
		$AudioStreamPlayer.stream_paused = false
