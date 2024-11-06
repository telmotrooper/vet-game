extends Node

@onready var audio_stream_player = $AudioStreamPlayer

var current_scene: String
var stars_per_level: Dictionary = {}

func toggle_volume() -> void:
	$AudioStreamPlayer.playing = !$AudioStreamPlayer.playing

func load_scene(target_scene: String) -> void:
	if is_instance_valid($"/root/Main"):
		$"/root/Main".load_scene(target_scene)
	else:
		get_tree().change_scene_to_file(target_scene)
	current_scene = target_scene
