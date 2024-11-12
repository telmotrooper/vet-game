@tool
extends Control

@export var hide_back_button: bool
@export var back_button_target: String

func _ready() -> void:
	if hide_back_button:
		$BackButton.set_visible(false)
	if back_button_target:
		$BackButton.target_scene = back_button_target
