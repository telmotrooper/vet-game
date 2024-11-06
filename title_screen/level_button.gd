extends Button

@export var target_scene: String

func _ready() -> void:
	for child in get_children():
		if child is LevelStarCounter:
			child.set_stars(1)

func _pressed() -> void:
	GameState.load_scene(target_scene)
