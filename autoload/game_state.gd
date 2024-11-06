extends Node

@onready var audio_stream_player = $AudioStreamPlayer

var stars_per_level: Dictionary = {}

func toggle_volume() -> void:
	$AudioStreamPlayer.playing = !$AudioStreamPlayer.playing

func load_scene(target_scene: NodePath) -> void:
	if is_instance_valid($"/root/Main"):
		$"/root/Main".load_scene(target_scene)
	else:
		get_tree().change_scene_to_file(target_scene)
