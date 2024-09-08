extends Node2D

@export var initial_scene: PackedScene

func _ready() -> void:
	get_tree().call_deferred("change_scene_to_packed", initial_scene)
