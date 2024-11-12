extends PanelContainer

@export var hide_see_figure_button: bool

@export var empty_star: Texture2D
@export var filled_star: Texture2D

func _ready():
	if hide_see_figure_button:
		%FigureButton.visible = false

func set_stars(quantity: int):
	%Stars/Star.texture = filled_star if quantity >= 1 else empty_star
	%Stars/Star2.texture = filled_star if quantity >= 2 else empty_star
	%Stars/Star3.texture = filled_star if quantity >= 3 else empty_star
	
	# First score assignment or score update.
	if not GameState.stars_per_level.has(GameState.current_scene) or GameState.stars_per_level[GameState.current_scene] < quantity:
		GameState.stars_per_level[GameState.current_scene] = quantity

func show_panel():
	for star in %Stars.get_children():
		star.custom_minimum_size = Vector2.ZERO

	set_visible(true)
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "scale", Vector2(1,1), 0.7)
	tween.tween_property(%Stars/Star, "custom_minimum_size", Vector2(128,128), 0.3)
	tween.tween_property(%Stars/Star2, "custom_minimum_size", Vector2(128,128), 0.3)
	tween.tween_property(%Stars/Star3, "custom_minimum_size", Vector2(128,128), 0.3)

func hide_panel() -> void:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "scale", Vector2(0,0), 0.7)
	tween.tween_callback(self.hide)
