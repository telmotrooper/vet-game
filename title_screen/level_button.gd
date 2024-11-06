extends Button

@export var target_scene: String

func _pressed() -> void:
	GameState.load_scene(target_scene)
