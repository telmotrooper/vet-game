extends Button

@export var target_scene: String

func _ready() -> void:
	var star_count := 0
	
	if GameState.stars_per_level.has(target_scene):
		star_count = GameState.stars_per_level[target_scene]
		
	for child in get_children():
		if child is LevelStarCounter:
			child.set_stars(star_count)

func _pressed() -> void:
	GameState.load_scene(target_scene)
