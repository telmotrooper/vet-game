class_name LevelStarCounter
extends HBoxContainer

@export var empty_star: Texture2D
@export var filled_star: Texture2D

func set_stars(quantity: int):
	$Star.texture = filled_star if quantity >= 1 else empty_star
	$Star2.texture = filled_star if quantity >= 2 else empty_star
	$Star3.texture = filled_star if quantity >= 3 else empty_star
