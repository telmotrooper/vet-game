@tool
extends Control

@export var hide_back_button: bool

func _ready() -> void:
	if hide_back_button:
		$BackButton.set_visible(false)
