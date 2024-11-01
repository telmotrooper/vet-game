extends Control

@export var empty_star: Texture2D
@export var filled_star: Texture2D

var slot_counter: int
var score := 0
var mistakes := 0

const base_text := "[center][b]( Acertos:[/b] %d/%d )[/center]"

func _ready() -> void:
	%VictoryPanel.visible = false
	%VictoryPanel.scale = Vector2.ZERO
	for child in %Slots.get_children():
		if child is Slot:
			slot_counter += 1
	update_text()

func _on_slot_filled() -> void:
	score += 1
	update_text()
	if score == slot_counter:
		show_victory_panel()

func update_text() -> void:
	%Score.text = base_text % [score, slot_counter]

func set_stars(quantity: int):
	%Stars/Star.texture = filled_star if quantity >= 1 else empty_star
	%Stars/Star2.texture = filled_star if quantity >= 2 else empty_star
	%Stars/Star3.texture = filled_star if quantity >= 3 else empty_star

func show_victory_panel() -> void:
	set_stars(3)
	
	for star in %Stars.get_children():
		star.custom_minimum_size = Vector2.ZERO

	%VictoryPanel.set_visible(true)
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(%VictoryPanel, "scale", Vector2(1,1), 0.7)
	tween.tween_property(%Stars/Star, "custom_minimum_size", Vector2(128,128), 0.3)
	tween.tween_property(%Stars/Star2, "custom_minimum_size", Vector2(128,128), 0.3)
	tween.tween_property(%Stars/Star3, "custom_minimum_size", Vector2(128,128), 0.3)

func hide_victory_panel() -> void:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(%VictoryPanel, "scale", Vector2(0,0), 0.7)
	tween.tween_callback(%VictoryPanel.hide)

func _on_mistake_made():
	mistakes += 1
