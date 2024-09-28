extends Node

@onready var audio_stream_player = $AudioStreamPlayer

func toggle_volume() -> void:
	$AudioStreamPlayer.playing = !$AudioStreamPlayer.playing
